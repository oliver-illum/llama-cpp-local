#!/bin/bash
PROMPT=${1:-"Can you tell a story from the old Danish Viking period age?"}

./llama.cpp/build/bin/llama-cli \
    -m ./quantized_models/qwen2.5_7B-4bit.gguf \
    -p "$PROMPT" \
    -n 512 \
    --threads 12 \
    --gpu-layers 29 \
    --batch-size 4096 \
    --flash-attn \
    --ctx-size 2048 \
    --top-k 40 --top-p 0.9 \
    --repeat-last-n 64 --repeat-penalty 1.1 \
    --temp 0.8 \
