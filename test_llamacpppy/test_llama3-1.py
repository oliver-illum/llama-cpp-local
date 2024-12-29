import sys
from llama_cpp import Llama

# Path to your GGUF model (no embedded chat template)
MODEL_PATH = "llama-3.2-3b-q8_0.gguf"

def main():
    # Initialize the model
    llm = Llama(
        model_path=MODEL_PATH,
        n_gpu_layers=-1,  # All layers on GPU (assuming you have enough VRAM)
        n_ctx=4096,
        verbose=False
    )

    # Define a minimal "chat template"
    # In llama-cpp, you can simply provide system, user, assistant messages.
    # This is conceptually the same as your Jinja2 template, but done at runtime.
    messages = [
        {
            "role": "system",
            "content": "You are a helpful AI assistant. Answer in a friendly style."
        },
        {
            "role": "user",
            "content": "can you write a story about a rose for me?"
        }
    ]

    # Create a chat completion
    # You can adjust `max_tokens`, `temperature`, etc. to your liking.
    response = llm.create_chat_completion(
        messages=messages,
        seed=-1,
        max_tokens=564,
        temperature=1.2,
        top_k=100,
        top_p=0.95,
        repeat_penalty=1.1
    )

    # Print the assistant's reply
    assistant_reply = response["choices"][0]["message"]["content"]
    print("Assistant:", assistant_reply)


if __name__ == "__main__":
    sys.exit(main())
