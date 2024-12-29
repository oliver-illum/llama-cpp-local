import os
import platform
import subprocess

if platform.system() == "Darwin" and "arm64" in platform.uname().machine:
    # for mac sillicon chips
    subprocess.run(
        "CMAKE_ARGS='DLLAMA_METAL=on' FORCE_MAKE=1 pip install llama-cpp-python", 
        shell=True,
        check=True,
        )
else:
    subprocess.run("pip install llama-cpp-python", shell=True, check=True)