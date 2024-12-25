export enum Programs {
    MPVPAPER = "mpvpaper",
    HYPRPAPER = "hyprpaper",
}
export type DisplayAndPath = {
  display: string;
  path: string;
};

export type DAndPWithProgram = {
    program: Programs;
    wallpapers: DisplayAndPath[];
}

export type BarColor = DisplayAndPath & {
  bgColor: string;
  textColor: string;
};