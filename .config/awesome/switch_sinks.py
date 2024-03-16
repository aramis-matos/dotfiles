import sys
import re

curr = sys.argv[1]
contents = sys.argv[2]
sinks = [x[:len(x)-2].split(" ")[1]
                for x in re.findall(r"Sink #(.*[\n\t]*){3}", contents)]
print(sinks[(sinks.index(curr)+1) % len(sinks)])
