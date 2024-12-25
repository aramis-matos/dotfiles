import fs from "fs/promises";
import os from "os";
import path from "path";
import { Programs, type BarColor } from "./models/models";
import { isImage, loaderMatcher, loadWallpapers } from "./lib/getWallpapers";
import { execute } from "./lib/utils";
import { unloadCommands } from "./lib/setWallpaper";
import { exit } from "process";

await Promise.all(unloadCommands.map((elem) => elem().catch(() => {})));
const { curr: wallpapers, fileText, old, program } = await loadWallpapers();

const displaysAndWallpapers = await loaderMatcher[program](wallpapers);

// const displaysAndWallpapers = (
//   await Promise.all(getWallpapers.map((fn) => fn(wallpapers)))
// ).flat();

if (fileText === old) {
  exit(0);
}

const barColorsPromises: Promise<BarColor>[] = [];
for (const x of displaysAndWallpapers) {
  const y = execute(x);
  barColorsPromises.push(y);
}

const barColors = await Promise.all(barColorsPromises);

const modifiedColors = barColors.reduce(
  (acc, curr) =>
    acc +
    `@define-color bgColor${curr.display} ${curr.bgColor}\n@define-color color${curr.display} ${curr.textColor}\n`,
  ""
);

Bun.write(
  path.join(os.homedir(), ".config", "waybar", "colors.css"),
  modifiedColors
);

Bun.write(
  path.join(os.homedir(), ".config", "waybar", "old_wallpapers.txt"),
  fileText
);

if (program === Programs.MPVPAPER) {
  await Promise.all(
    wallpapers.filter(({path}) => isImage.exec(path) === null).map(async (elem) => fs.rm(`${elem.path}-temp.jpg`))
  );
}
