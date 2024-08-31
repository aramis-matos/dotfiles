import fs from "fs";
import os from "os";
import path from "path";
import { Image } from "image-js";
import { exit } from "process";
async function getFilePromise(folder, file) {
    return new Promise((res, rej) => {
        fs.readFile(path.join(os.homedir(), ".config", folder, file), (err, data) => err ? rej(err) : res(data));
    });
}
async function execute({ display, path }) {
    const image = await Image.load(path);
    const medianColor = image.resize({ width: 200 }).getMedian();
    const complementaryColor = medianColor.map((elem) => 255 - elem);
    const toRBGStr = (key, elem) => `rgba(${elem[0]},${elem[1]},${elem[2]},${key === "background-color" ? 0.7 : 1});`;
    return {
        bgColor: toRBGStr("background-color", medianColor),
        textColor: toRBGStr("", complementaryColor),
        display,
        path,
    };
}
const [hyprpaperPromise, oldWallpaperPromise] = [
    getFilePromise("hypr", "hyprpaper.conf"),
    getFilePromise("waybar", "old_wallpapers.txt"),
];
const hyprpaper = (await hyprpaperPromise).toString();
const old_wallpaper = (await oldWallpaperPromise).toString();
if (hyprpaper === old_wallpaper) {
    exit(0);
}
const wallpapers = [...hyprpaper.matchAll(/wallpaper.*/g)];
const displaysAndWallpapers = wallpapers.map((elem) => {
    const displayAndWallpaperStr = elem[0].split("=")[1].trim().split(",");
    return {
        display: displayAndWallpaperStr[0],
        path: displayAndWallpaperStr[1],
    };
});
console.log(displaysAndWallpapers);
const barColorsPromises = [];
for (const x of displaysAndWallpapers) {
    const y = execute(x);
    barColorsPromises.push(y);
}
const barColors = await Promise.all(barColorsPromises);
const modifiedColors = barColors.reduce((acc, curr) => acc + `@define-color bgColor${curr.display} ${curr.bgColor}\n@define-color color${curr.display} ${curr.textColor}\n`, "");
fs.writeFileSync(path.join(os.homedir(), ".config", "waybar", "colors.css"), modifiedColors, { flag: "w" });
fs.writeFileSync(path.join(os.homedir(), ".config", "waybar", "old_wallpapers.txt"), hyprpaper, { flag: "w" });
//# sourceMappingURL=index.js.map