import util from "util";
import { exec as execExport } from "child_process";
import type { BarColor, DisplayAndPath } from "../models/models";
import { Image } from "image-js";

const exec = util.promisify(execExport);


export async function execute({ display, path }: DisplayAndPath): Promise<BarColor> {
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

export async function isMpvpaper(): Promise<Boolean> {
  return exec("ps aux | grep 'mpvpaper' | grep -v grep")
    .then(() => true)
    .catch(() => false);
}