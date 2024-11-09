import { writeFileSync } from "fs";
import fs from "fs/promises";
import os, { homedir } from "os";
import path from "path";
import { Image } from "image-js";
import { exit } from "process";
import util from "util";
import { exec as execExport } from "child_process";

const exec = util.promisify(execExport);

type DisplayAndPath = {
  display: string;
  path: string;
};

type PathsAndContents = {
  displaysAndWallpapers: DisplayAndPath[];
  file: string;
};

type BarColor = DisplayAndPath & {
  bgColor: string;
  textColor: string;
};

async function getFilePromise(folder: string[], file: string): Promise<Buffer> {
  return fs.readFile(path.join(os.homedir(), ".config", ...folder, file));
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

async function isMpvpaper(): Promise<Boolean> {
  return exec("ps aux | grep 'mpvpaper' | grep -v grep").then(() => true).catch(() => false);
}

async function getWaypaperWallpapers(): Promise<PathsAndContents> {
  const [hyprpaperPromise, oldWallpaperPromise] = [
    getFilePromise(["hypr"], "hyprpaper.conf"),
    getFilePromise(["waybar"], "old_wallpapers.txt"),
  ];

  const hyprpaper = (await hyprpaperPromise).toString();
  const old_wallpaper = (await oldWallpaperPromise).toString();

  if (hyprpaper === old_wallpaper) {
    exit(0);
  }

  const wallpapers = [...hyprpaper.matchAll(/wallpaper.*/g)];
  const displaysAndWallpapers: DisplayAndPath[] = wallpapers.map((elem) => {
    const displayAndWallpaperStr = elem[0].split("=")[1].trim().split(",");
    return {
      display: displayAndWallpaperStr[0].trim(),
      path: displayAndWallpaperStr[1].trim(),
    };
  });

  return { displaysAndWallpapers, file: hyprpaper };
}

async function getMpvPaperWallpapers(): Promise<PathsAndContents> {
  const [hyprpaperPromise, oldWallpaperPromise] = [
    getFilePromise(["hypr", "scripts"], "wallpapers.sh"),
    getFilePromise(["waybar"], "old_wallpapers.txt"),
  ];


  const mpvpaper = (await hyprpaperPromise).toString();
  const old_wallpaper = (await oldWallpaperPromise).toString();

  if (mpvpaper === old_wallpaper) {
    exit(0);
  }

  const displaysAndWallpapers = [
    ...mpvpaper.matchAll(/mpvpaper.+--auto-pause/g),
  ].map((elem) => {
    const splitItems = elem[0].split(" ");
    const display = splitItems[1];
    const path = splitItems.slice(2, splitItems.length - 1).join("");
    return {
      display,
      path,
    };
  });

  const tempDisplaysAndWallpapers = await Promise.all(
    displaysAndWallpapers.map(async (val) => {
      await exec(
        `ffmpeg -ss 00:00:01.00 -i ${val.path} -vf 'scale=100:100:force_original_aspect_ratio=decrease' -vframes 1 ${val.path}-temp.jpg -y`
      );
      return { ...val, path: `${path.join(os.homedir(),...val.path.split("/").slice(1))}-temp.jpg` };
    })
  );

  return { displaysAndWallpapers: tempDisplaysAndWallpapers, file: mpvpaper };
}

const isMpvPaper = await isMpvpaper();


const { displaysAndWallpapers, file }: PathsAndContents = await (isMpvPaper
  ? getMpvPaperWallpapers()
  : getWaypaperWallpapers());


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

writeFileSync(
  path.join(os.homedir(), ".config", "waybar", "colors.css"),
  modifiedColors,
  { flag: "w" }
);

writeFileSync(
  path.join(os.homedir(), ".config", "waybar", "old_wallpapers.txt"),
  file,
  { flag: "w" }
);

if (isMpvPaper) {
  await Promise.all(
    displaysAndWallpapers.map(async (elem) => fs.rm(elem.path))
  );
}
