from llama_cpp import Llama

model_name = "qwen2.5_7B-4bit.gguf"
path_to_model = f"./A_quantized_models/{model_name}"
path_to_model = "llama-3.2-3b-q8_0.gguf"

llm = Llama(model_path=path_to_model, n_ctx=2048, n_gpu_layers=29, use_mlock=True, verbose=False)

# print("Chatbot initialized. Type your message and press Enter. Type 'exit' to quit.")
print("\nloaded model\n\n")
print(llm.metadata)


while True:
    user_input = input("You: ")
    if user_input.lower() in ["exit", "quit"]:
        print("Exiting the chat. Goodbye!")
        break

    prompt = f"You are a creative assistant. Answer the user's request directly and clearly.\nUser: {user_input}\nAssistant:"

    print("Assistant: ", end="", flush=True)  # Ensure we stay on the same line
    for token in llm(
        prompt,
        max_tokens=2048,
        temperature=0.7,
        top_p=0.9,
        stop=["User:", "Assistant:"],
        stream=True,  # Enable streaming
        verbose=False,
    ):
        # Access the text in the "choices" list
        if "choices" in token and token["choices"]:
            print(token["choices"][0]["text"], end="", flush=True)  # Print the text
    print()  # Move to a new line after the response

