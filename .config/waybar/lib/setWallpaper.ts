import util from "util";
import { exec as execExport } from "child_process";
import type { DisplayAndPath } from "../models/models";

const exec = util.promisify(execExport);

const hyprpaperUnloadCommand = "hyprctl hyprpaper unload all";

function hyprpaperPreloadCommand({ path }: DisplayAndPath) {
  return `hyprctl hyprpaper preload ${path}`;
}

function hyprpaperLoadCommand({ path, display }: DisplayAndPath) {
  return `hyprctl hyprpaper wallpaper ${display} ${path}`;
}

export async function loadHyprpaperWallpapers(wallpapers: DisplayAndPath[]) {
  if (wallpapers.length === 0) {
    return;
  }
  try {
    await exec("pgrep hyprpaper");
  } catch {
    await exec("hyprpaper &");
  }
  await exec(hyprpaperUnloadCommand);
  for (const wallpaper of wallpapers) {
    await exec(hyprpaperPreloadCommand(wallpaper));
    await exec(hyprpaperLoadCommand(wallpaper));
  }
}

const mpvpaperUnloadCommand = "pkill mpvpaper";

function mpvpaperLoadCommand({ display, path }: DisplayAndPath) {
  return `mpvpaper '${display}' '${path}' --fork -o 'no audio loop'`;
}

export async function loadMpvpaperWallpapers(wallpapers: DisplayAndPath[]) {
  if (wallpapers.length === 0) {
    return;
  }

  await exec(mpvpaperUnloadCommand).catch(() => {});
  for (const wallpaper of wallpapers) {
    await exec(mpvpaperLoadCommand(wallpaper));
  }
}

export const unloadCommands = [
  hyprpaperUnloadCommand,
  mpvpaperUnloadCommand,
].map((cmd) => async () => exec(cmd));
