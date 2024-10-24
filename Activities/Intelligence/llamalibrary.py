import time
import sys
import contextlib
from llama_cpp import Llama

# 初始化模型并显示加载进度
print("Loading the LLaMA model, please wait...")
llm = Llama(model_path="llm_models\\Meta-Llama-3-8B.Q8_0.gguf", n_gpu_layers=40)
print("Model loaded successfully!")

# 初始提示词
prompt = "Tell me a story."
response = ""

# 对话循环，直到用户中止
while True:
    output = llm(prompt)

    # 获取模型的回答
    response = output["choices"][0]["text"].strip()

    # 展示模型的回答
    print(f"\nResponse: {response}\n")

    # 检查用户是否想要继续
    user_input = input("Do you want to continue the story? (yes/no): ").strip().lower()

    if user_input != "yes":
        print("Exiting the conversation.")
        break

    # 如果继续，提示词为"Continue"
    prompt = "Continue"

