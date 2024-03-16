#! /usr/bin/python3
from PIL import Image
import numpy as np
from functools import reduce
import re


def median(cells):
    length = len(cells)
    if length == 0:
        return None
    if length % 2 == 1:
        return tuple(cells[int(length / 2)])
    else:
        x = (int(x) for x in cells[int(length / 2)])
        y = (int(x) for x in cells[int(length / 2 -1)])
        return tuple(int((int(a)+int(b))/2) for (a,b) in zip(x,y))

def get_hex_code(cell: tuple[int]):
    return str(reduce(str.__add__,[hex(x)[2:] for x in cell],""))

def hilo(a, b, c):
    if c < b: b, c = c, b
    if b < a: a, b = b, a
    if c < b: b, c = c, b
    return a + c

def complement(r, g, b):
    k = hilo(r, g, b)
    return tuple(k - u for u in (r, g, b))

def get_index(colors,colors_index,rs,gs,bs):
    if colors[colors_index] == rs:
        return 0 
    elif colors[colors_index] == gs:
       return 1 
    else:
        return 2

def replace_color(var,color,contents):
    return re.sub(var+r".*",f"{var}\"#{color}\"",contents,1)



nitrogen_path = "/home/ccyanide/.config/nitrogen/bg-saved.cfg"
with open(nitrogen_path,'r') as f:
    img_path = re.findall(r"file=.*",f.read())[0].split("=")[1].strip()

old_wallpaper = "/home/ccyanide/.config/awesome/curr_wallpaper.txt"
with open(old_wallpaper,'r') as f:
    if f.read().strip() == img_path:
        exit(0)

img = Image.open(img_path)
img.thumbnail((500,500))
data = np.asarray(img)

rs = []
gs = []
bs = []

for col in data:
    for cell in col:
        max = np.max(cell[:3])
        if max == cell[0]:
            rs.append(cell[:3])
        elif max == cell[1]:
            gs.append(cell[:3])
        else:
            bs.append(cell[:3])

colors = [rs,gs,bs]
colors.sort(key=lambda x: len(x),reverse=True)

primary_index = get_index(colors,0,rs,gs,bs)
secondary_index = get_index(colors,1,rs,gs,bs)

colors[0].sort(key=lambda x: x[primary_index])
if colors[1] == []:
    colors[1] = [(0,0,0)]
colors[1].sort(key=lambda x: x[secondary_index])
primary = median(colors[0])
secondary = median(colors[1])
primaryCompliment = get_hex_code(complement(*primary))
secondaryCompliment = get_hex_code(complement(*secondary))
primaryHexCode = get_hex_code(primary)
secondaryHexCode = get_hex_code(secondary)

theme_lua_path = "/home/ccyanide/.config/awesome/theme.lua"
with open(theme_lua_path,'r') as f:
    contents = f.read()
    bg_normal = "theme.bg_normal = "
    bg_focus = "theme.bg_focus = "
    bg_systray = "theme.bg_systray = "
    fg_normal = "theme.fg_normal = "
    fg_focus = "theme.fg_focus = "
    contents = replace_color(bg_normal,secondaryHexCode,contents)   
    contents = replace_color(bg_systray,secondaryHexCode,contents)   
    contents = replace_color(bg_focus,primaryHexCode,contents)   
    contents = replace_color(fg_normal,secondaryCompliment,contents)   
    contents = replace_color(fg_focus,primaryCompliment,contents)

with open(theme_lua_path,'w') as f:
    f.write(contents)

with open(old_wallpaper,'w') as f:
    f.write(img_path)