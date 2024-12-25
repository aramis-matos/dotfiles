import os from "os";
import path from "path";
import { exit } from "process";
import util from "util";
import { exec as execExport } from "child_process";
import {
  Programs,
  type DAndPWithProgram,
  type DisplayAndPath,
} from "../models/models";
import {
  loadHyprpaperWallpapers,
  loadMpvpaperWallpapers,
} from "./setWallpaper";

export const isImage = /(jpg|png|tiff|jpeg)$/i;

const exec = util.promisify(execExport);

function configPath(file: string) {
  return path.join(os.homedir(), ".config", "waybar", file);
}

export async function getCurrWallpapers(
  filePath: string
): Promise<{ curr: DisplayAndPath[]; fileText: string; program: Programs }> {
  const file = Bun.file(filePath);
  const json = (await file.json()) as DAndPWithProgram;
  return {
    curr: json.wallpapers.map((elem) => ({
      ...elem,
      path: path.join(
        "/",
        ...elem.path
          .split(/\/|\\/)
          .map((elem) => (elem === "~" ? os.homedir() : elem))
      ),
    })),
    fileText: (await file.text()).trim(),
    program: json.program,
  };
}

async function getOldWallpapers() {
  return (await Bun.file(configPath("old_wallpapers.txt")).text()).trim();
}

export async function loadWallpapers(): Promise<{
  curr: DisplayAndPath[];
  fileText: string;
  old: string;
  program: Programs;
}> {
  const { curr, fileText, program } = await getCurrWallpapers(
    configPath("wallpapers.json")
  );
  const old = await getOldWallpapers();

  return { curr, fileText, old, program };
}

async function setAndGetWallpaper(
  wallpapers: DisplayAndPath[],
  loader: (wallpapers: DisplayAndPath[]) => Promise<void>
): Promise<DisplayAndPath[]> {
  await loader(wallpapers);
  return wallpapers;
}

export async function getHyprpaperWallpapers(wallpapers: DisplayAndPath[]) {
  const val = await setAndGetWallpaper(wallpapers, loadHyprpaperWallpapers);
  return val;
}

export async function getMpvPaperWallpapers(
  wallpapers: DisplayAndPath[]
): Promise<DisplayAndPath[]> {
  const filteredWallpapers = await setAndGetWallpaper(
    wallpapers,
    loadMpvpaperWallpapers
  );
  const isImage = /(jpg|png|tiff|jpeg)$/i;
  const tempDisplaysAndWallpapers = await Promise.all(
    filteredWallpapers.map(async (val) => {
      if (isImage.exec(val.path)) {
        return { ...val };
      }
      await exec(
        `ffmpeg -ss 00:00:01.00 -i '${val.path}' -vf 'scale=100:100:force_original_aspect_ratio=decrease' -vframes 1 '${val.path}-temp.jpg' -y`
      );
      return {
        ...val,
        path: `${val.path}-temp.jpg`,
      };
    })
  );

  return tempDisplaysAndWallpapers;
}

export const loaderMatcher: {
  [x in Programs]: (wallpapers: DisplayAndPath[]) => Promise<DisplayAndPath[]>;
} = {
  [Programs.HYPRPAPER]: getHyprpaperWallpapers,
  [Programs.MPVPAPER]: getMpvPaperWallpapers,
};
