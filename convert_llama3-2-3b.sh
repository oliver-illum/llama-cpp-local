#!/bin/bash 

python3 llama.cpp/convert_hf_to_gguf.py ./A_models/Llama-3.2-3B-Instruct \
    --outfile llama-3.2-3b-q8_0.gguf \
    --outtype q8_0