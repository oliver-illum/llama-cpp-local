#!/bin/bash

# Default value for optional arguments
path_to_cache="~/.cache/huggingface/hub/"
out_put_name=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --path_to_cache)
            if [[ -n "$2" && ! "$2" =~ ^-- ]]; then
                path_to_cache="$2"
                shift
            else
                echo "Error: --path_to_cache requires a value"
                exit 1
            fi
            ;;
        --out_put_name)
            if [[ -n "$2" && ! "$2" =~ ^-- ]]; then
                out_put_name="$2"
                shift
            else
                echo "Error: --out_put_name requires a value"
                exit 1
            fi
            ;;
        --) shift; break ;; # End of options
        -*)
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
        *)
            # Handle positional argument (e.g., model path)
            MODEL_CACHE_PATH="$1"
            ;;
    esac
    shift
done

# Validate the positional argument
if [[ -z "$MODEL_CACHE_PATH" ]]; then
    echo "Error: MODEL_CACHE_PATH is required."
    exit 1
fi

# If MODEL_CACHE_PATH is not an absolute path, combine it with path_to_cache
if [[ "$MODEL_CACHE_PATH" != /* ]]; then
    MODEL_CACHE_PATH="${path_to_cache%/}/$MODEL_CACHE_PATH"
fi

# Expand tilde (~) to the absolute home directory
MODEL_CACHE_PATH=$(eval echo "$MODEL_CACHE_PATH")

# Extract the model name if --out_put_name is not provided
if [[ -z "$out_put_name" ]]; then
    MODEL_NAME=$(basename "$MODEL_CACHE_PATH")
else
    MODEL_NAME="$out_put_name"
fi

# Output paths
CONVERTED_MODEL="converted_models/${MODEL_NAME}.gguf"

# Display results
echo "Path to cache: $path_to_cache"
echo "Model cache path: $MODEL_CACHE_PATH"
echo "Model name: $MODEL_NAME"
echo "Converted model output path: $CONVERTED_MODEL"

# Create output directory if it doesn't exist
mkdir -p converted_models

# Convert the model
echo "Converting model from cache: $MODEL_CACHE_PATH"
python3 llama.cpp/convert_hf_to_gguf.py "$MODEL_CACHE_PATH" --outfile "$CONVERTED_MODEL"

# Display output
echo "Model converted:"
echo "  Converted model path: $CONVERTED_MODEL"
