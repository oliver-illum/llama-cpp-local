from huggingface_hub import snapshot_download

MODEL_PATH="meta-llama/Llama-3.2-3B-Instruct"
#MODEL_PATH="Qwen/Qwen2.5-7B"

snapshot_download(repo_id=MODEL_PATH, local_dir="A_models/Llama-3.2-3B-Instruct")

#remember to remove the tokenizer.model in some cases
#rm "A_models/...."