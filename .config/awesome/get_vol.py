import sys

curr = sys.argv[1]
sinks = sys.argv[2].split(" ")
vols = sys.argv[3].split(" ")
for (sink, vol) in zip(sinks, vols):
    if sink == curr:
        print("🎚️"+f"{vol} ")
