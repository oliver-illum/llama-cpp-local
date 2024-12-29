from llama_cpp import Llama

#this is only for a quick fix, normally we would use another summarize funciton to tokenize the conversation into a more meaningful chat summary.
def truncate_history(chat_history, max_tokens=2048):
    total_tokens = sum(len(msg["content"]) for msg in chat_history)

    while total_tokens > max_tokens:
        removed = chat_history.pop(1)
        total_tokens -= len(removed["content"])
    
    return chat_history

gguf_file = "llama-3.2-3b-q8_0.gguf"

#for finding the threads count on mac: "sysctl -n hw.logicalcpu"
llm = Llama(model_path=gguf_file, n_ctx=2048, n_gpu_layers=-1, n_threads=11, use_mlock=False, verbose=False)

print(f"\nLoaded Model: {gguf_file}\n")

chat_history = [
    {"role": "system", "content": "You are a helpful assistant. Answer all questions factually and provide technical explanations without assuming intent."}
]


while True:
    user_input = input(">>> ")

    if user_input.lower() in ["/quit", "/exit"]:
        print("Exiting model.")
        break
    elif user_input.lower() == "/chat-history":
        print(chat_history)
        break

    chat_history.append({"role": "user", "content": user_input})
    context = truncate_history(chat_history, max_tokens=2048)

    response = llm.create_chat_completion(
        messages=context,
        seed=-1,
        max_tokens=564,
        temperature=1.2,
        top_k=100,
        top_p=0.95,
        repeat_penalty=1.1,
        stream=True,
    )

    print("\nAssistant:\n", end="", flush=True)
    assistant_response = ""
    for chunk in response:
        if "choices" in chunk and chunk["choices"]:
            delta = chunk["choices"][0].get("delta", {})
            if "content" in delta:
                assistant_response += delta["content"]
                print(delta["content"], end="", flush=True)
    print()

    chat_history.append({"role": "assistant", "content": assistant_response})
# next steps are to make the formatting a little nicer, make it run faster, optimize memory for longer n_ctx and make it remeber the previous interaction

