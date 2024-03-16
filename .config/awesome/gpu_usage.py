#! /usr/bin/python3
import re
from subprocess import run, PIPE
print(("🗔"+re.findall(r"\d+ \%",
      run(['gpustat'], stdout=PIPE).stdout.decode("utf-8"))[0].split(" ")[0].rjust(3, '0'))+"% ")
