#! /usr/bin/python3
import re
import sys
from subprocess import run, PIPE

curr: str = sys.argv[1]
text = run(['pactl', 'list', 'sinks'], stdout=PIPE).stdout.decode("utf-8")
names: list[str] = [x.split(" ")[1] for x in re.findall(r"Name: .*", text)]
descs: list[str] = [x.split(" ")[1][:5]
                    for x in re.findall(r"Description: .*", text)]

for (name, desc) in zip(names, descs):
    if name == curr:
        print("🎧"+desc+" ")
