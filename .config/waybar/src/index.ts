import fs from "fs";
import os from "os";
import path from "path";
import { Image } from "image-js";
import { exit } from "process";

type DisplayAndPath = {
  display: string;
  path: string;
};

type BarColor = DisplayAndPath & {
  bgColor: string;
  textColor: string;
};

async function getFilePromise(
  folder: "hypr" | "waybar",
  file: "hyprpaper.conf" | "colors.css" | "old_wallpapers.txt"
): Promise<Buffer> {
  return new Promise((res, rej) => {
    fs.readFile(path.join(os.homedir(), ".config", folder, file), (err, data) =>
      err ? rej(err) : res(data)
    );
  });
}

async function execute({ display, path }: DisplayAndPath): Promise<BarColor> {
  const image = await Image.load(path);
  const medianColor = image.resize({ width: 200 }).getMedian();
  const complementaryColor = medianColor.map((elem) => 255 - elem);
  const toRBGStr = (key: string, elem: [number, number, number]) =>
    `rgba(${elem[0]},${elem[1]},${elem[2]},${
      key === "background-color" ? 0.7 : 1
    });`;
  return {
    bgColor: toRBGStr(
      "background-color",
      medianColor as [number, number, number]
    ),
    textColor: toRBGStr("", complementaryColor as [number, number, number]),
    display,
    path,
  };
}

const [hyprpaperPromise, oldWallpaperPromise] = [
  getFilePromise("hypr", "hyprpaper.conf"),
  getFilePromise("waybar", "old_wallpapers.txt"),
];


const hyprpaper = (await hyprpaperPromise).toString()
const old_wallpaper = (await oldWallpaperPromise).toString()

if (hyprpaper === old_wallpaper) {
  exit(0)
}

const wallpapers = [...hyprpaper.matchAll(/wallpaper.*/g)];
const displaysAndWallpapers: DisplayAndPath[] = wallpapers.map((elem) => {
  const displayAndWallpaperStr = elem[0].split("=")[1].trim().split(",");
  return {
    display: displayAndWallpaperStr[0],
    path: displayAndWallpaperStr[1],
  };
});
console.log(displaysAndWallpapers)

const barColorsPromises: Promise<BarColor>[] = [];
for (const x of displaysAndWallpapers) {
  const y = execute(x);
  barColorsPromises.push(y);
}

const barColors = await Promise.all(barColorsPromises);

const modifiedColors = barColors.reduce((acc,curr) =>  acc + `@define-color bgColor${curr.display} ${curr.bgColor}\n@define-color color${curr.display} ${curr.textColor}\n`,"")

fs.writeFileSync(path.join(os.homedir(), ".config","waybar","colors.css"),modifiedColors,{flag: "w"})
fs.writeFileSync(path.join(os.homedir(), ".config","waybar","old_wallpapers.txt"),hyprpaper,{flag: "w"})