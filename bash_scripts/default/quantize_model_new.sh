#!/bin/bash

# Default values for arguments
model_to_quantize=""
quantized_name=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --model_to_quantize)
            if [[ -n "$2" && ! "$2" =~ ^-- ]]; then
                model_to_quantize="$2"
                shift
            else
                echo "Error: --model_to_quantize requires a value"
                exit 1
            fi
            ;;
        --quantized_name)
            if [[ -n "$2" && ! "$2" =~ ^-- ]]; then
                quantized_name="$2"
                shift
            else
                echo "Error: --quantized_name requires a value"
                exit 1
            fi
            ;;
        --) shift; break ;; # End of options
        -*)
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
        *)
            # Handle positional argument (e.g., model to quantize)
            model_to_quantize="$1"
            ;;
    esac
    shift
done

# Validate the positional argument
if [[ -z "$model_to_quantize" ]]; then
    echo "Error: model_to_quantize is required."
    exit 1
fi

# Extract quantized name if not provided
if [[ -z "$quantized_name" ]]; then
    QUANTIZED_MODEL=$(basename "$model_to_quantize" .gguf)-4bit.gguf
else
    QUANTIZED_MODEL="$quantized_name"
fi

# Output path for quantized model
QUANTIZED_OUTPUT="quantized_models/$QUANTIZED_MODEL"

# Create output directory if it doesn't exist
mkdir -p quantized_models

# Quantize the model
echo "Quantizing model: $model_to_quantize"
llama.cpp/build/bin/llama-quantize "$model_to_quantize" "$QUANTIZED_OUTPUT" q4_K_M

# Display output
echo "Model quantized:"
echo "  Quantized model path: $QUANTIZED_OUTPUT"