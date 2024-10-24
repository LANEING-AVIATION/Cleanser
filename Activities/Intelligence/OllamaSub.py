import subprocess
import re
import time
from plyer import notification


# Windows通知功能
def send_notification(title, message):
    """发送 Windows 系统通知."""
    notification.notify(
        title=title,
        message=message,
        timeout=5  # 通知持续5秒
    )


# 过滤加载符号的函数
def filter_output(output):
    """过滤掉加载符号或其他无用信息"""
    # 使用正则表达式去除所有非打印字符
    filtered = re.sub(r'[^\x20-\x7E]+', '', output)  # 仅保留可打印的ASCII字符
    return filtered.strip()


# 启动 LLM 进程
def start_llm():
    """启动 LLM 进程并返回进程对象."""
    process = subprocess.Popen(
        ['ollama', 'run', 'llama3:8b'],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding='utf-8',
        errors='replace',
        universal_newlines=True,
        shell=False
    )
    return process


# 与 LLM 进行交互
def communicate_with_llm(process, prompt):
    """与模型交互并返回过滤后的响应."""
    try:
        process.stdin.write(prompt + '\n')
        process.stdin.flush()

        # 读取模型的回复
        output = process.stdout.readline()

        return filter_output(output)  # 返回过滤后的 LLM 的输出

    except Exception as e:
        print(f"Error: {e}")
        return None


# 示例使用
if __name__ == '__main__':
    prompt = "who are you"  # 输入的提示词

    # 通知用户模型正在加载
    send_notification("加载中", "正在与模型建立连接...")

    # 启动模型
    llm_process = start_llm()

    # 通过进程通信发送和接收多次消息
    while True:
        output = communicate_with_llm(llm_process, prompt)
        if output:
            # 显示模型的回复
            send_notification("模型回复", "output")  # 发送模型回复的内容
            print(f"LLM Output: {output}")
        else:
            print("Error: 没有收到模型的回复。")
            break

        time.sleep(5)  # 等待5秒后再次发送请求
