import subprocess


def run_llm(prompt):
    # 启动 LLM 进程，使用管道传递输入输出，并指定编码为utf-8
    process = subprocess.Popen(
        ['ollama', 'run', 'llama3:8b'],
        stdin=subprocess.PIPE,  # 为输入创建管道
        stdout=subprocess.PIPE,  # 为输出创建管道
        stderr=subprocess.PIPE,  # 捕获错误输出
        text=True,  # 将输入输出视为文本，而非字节
        encoding='utf-8',  # 明确指定编码为utf-8
        errors='replace',  # 忽略或替换无效的字符，避免编码错误
        universal_newlines=True,  # 用于跨平台兼容
        shell=False  # 不使用shell，直接执行命令
    )

    try:
        # 向 LLM 提供提示词
        stdout_data, stderr_data = process.communicate(input=prompt, timeout=30)  # 超时时间根据需要调整

        if stderr_data:
            print(f"Error: {stderr_data}")

        # 返回 LLM 的输出
        return stdout_data.strip()  # 去掉多余的换行符

    except subprocess.TimeoutExpired:
        process.kill()
        print("LLM process timed out.")
        return None


# 示例使用
if __name__ == '__main__':
    prompt = "What is the capital of France?"  # 这是你要输入的提示词
    output = run_llm(prompt)
    print(f"LLM Output: {output}")
