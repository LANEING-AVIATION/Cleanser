import cv2  # 导入OpenCV库用于图像处理
import numpy as np  # 导入NumPy库用于数组操作
import pytesseract  # 导入Pytesseract库用于OCR识别
import pyautogui  # 导入PyAutoGUI库用于屏幕捕获
import torch  # 导入PyTorch库用于深度学习
from transformers import MarianMTModel, MarianTokenizer  # 导入Transformers库的翻译模型和分词器
import tkinter as tk  # 导入Tkinter库用于创建图形用户界面

# 设置Tesseract路径，确保指向Tesseract的安装位置
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

# 加载离线翻译模型，选择目标语言对（例如英语到法语）
model_name = "Helsinki-NLP/opus-mt-en-fr"
tokenizer = MarianTokenizer.from_pretrained(model_name)  # 初始化分词器
model = MarianMTModel.from_pretrained(model_name)  # 初始化翻译模型
model.eval()  # 设置模型为评估模式，以禁用训练特性

def capture_screen():
    # 捕获当前屏幕并返回图像
    screen = pyautogui.screenshot()  # 使用PyAutoGUI截图
    screen = cv2.cvtColor(np.array(screen), cv2.COLOR_RGB2BGR)  # 转换颜色格式为BGR
    return screen  # 返回捕获的屏幕图像

def detect_changes(prev_frame, curr_frame):
    # 计算前后帧之间的变化
    diff = cv2.absdiff(prev_frame, curr_frame)  # 计算绝对差异
    gray = cv2.cvtColor(diff, cv2.COLOR_BGR2GRAY)  # 将差异图像转换为灰度图
    _, thresh = cv2.threshold(gray, 30, 255, cv2.THRESH_BINARY)  # 应用阈值处理
    return thresh  # 返回二值化图像，突出变化区域

def ocr_and_translate(rect):
    # 对检测到的区域进行OCR识别并翻译
    text = pytesseract.image_to_string(rect)  # 使用OCR识别文本
    text = text.strip()  # 去除前后空格
    
    # 确保识别到的是一个有效单词
    if text:
        translated = translate(text)  # 翻译识别的文本
        return translated  # 返回翻译结果
    return None  # 如果未识别到文本，返回None

def translate(text):
    # 使用离线翻译模型对文本进行翻译
    inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True)  # 分词并转换为张量
    with torch.no_grad():  # 禁用梯度计算以提高性能
        outputs = model.generate(**inputs)  # 生成翻译结果
    translated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)  # 解码翻译结果
    return translated_text  # 返回翻译文本

def show_label(text, x, y):
    # 创建Tkinter标签用于显示翻译结果
    label = tk.Tk()  # 初始化Tkinter窗口
    label.wm_attributes('-topmost', True)  # 确保窗口位于最上层
    label.wm_attributes('-disabled', True)  # 禁用窗口交互
    label.wm_attributes('-alpha', 0.9)  # 设置窗口透明度
    label.geometry(f"+{x}+{y}")  # 设置窗口位置
    label.title(text)  # 设置窗口标题为翻译文本
    tk.Label(label, text=text, font=('Arial', 12), bg='yellow').pack()  # 创建标签并添加到窗口
    label.mainloop()  # 运行主事件循环

# 捕获初始屏幕帧
prev_frame = capture_screen()

while True:  # 主循环
    curr_frame = capture_screen()  # 捕获当前屏幕帧
    changes = detect_changes(prev_frame, curr_frame)  # 检测变化区域

    # 找到变化的轮廓
    contours, _ = cv2.findContours(changes, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    for contour in contours:
        if cv2.contourArea(contour) > 500:  # 过滤掉较小的变化
            x, y, w, h = cv2.boundingRect(contour)  # 获取变化区域的边界框
            roi = curr_frame[y:y+h, x:x+w]  # 提取变化区域
            
            translated_text = ocr_and_translate(roi)  # 对区域进行OCR识别并翻译
            if translated_text:
                show_label(translated_text, x, y)  # 显示翻译结果标签

    prev_frame = curr_frame  # 更新前一帧
