#!/bin/bash

# Default values
PROMPT=${1:-"what are the biggest country based on square meter?"}
#MODEL_PATH="./quantized_models/qwen2.5_7b-4bit.gguf"
MODEL_PATH="./quantized_models/llama_8b_model-4bit.gguf"
THREADS=12
GPU_LAYERS=29
BATCH_SIZE=4096
CTX_SIZE=2048

echo "Launching interactive chat session. Type your input and press Enter to continue chatting."
echo "Press Ctrl+C to exit."

# Run llama-cli in interactive mode
./llama.cpp/build/bin/llama-cli \
    -m "$MODEL_PATH" \
    --interactive \
    --threads "$THREADS" \
    --gpu-layers "$GPU_LAYERS" \
    --batch-size "$BATCH_SIZE" \
    --ctx-size "$CTX_SIZE" \
    -p "$PROMPT" 

