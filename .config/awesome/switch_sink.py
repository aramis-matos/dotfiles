#! /usr/bin/env python3
import sys
import re
sinks = [x.split(" ")[1].strip() for x in re.findall(r"Name: .*", sys.argv[2])]
curr = sys.argv[1]

print(sinks[(sinks.index(curr)+1) % len(sinks)])
