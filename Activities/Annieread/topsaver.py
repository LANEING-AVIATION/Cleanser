import time
import numpy as np
import pyautogui
import threading
from PIL import ImageGrab, ImageTk
from tkinter import Tk, Label
from pynput import mouse, keyboard

class ScreenSaver:
    def __init__(self, screenshot_path="screenshot.png"):
        self.screenshot_path = screenshot_path
        self.last_screenshot = None
        self.inactive_time = 0
        self.keyboard_inactive_time = 0
        self.mouse_inactive_time = 0
        self.mouse_listener = None
        self.keyboard_listener = None
        self.screen_locked = False
        self.root = None

    def start(self):
        # 启动监听线程
        threading.Thread(target=self.monitor_user_activity, daemon=True).start()
        threading.Thread(target=self.monitor_screen_activity, daemon=True).start()

    def monitor_screen_activity(self):
        while True:
            screenshot = ImageGrab.grab()
            screenshot_np = np.array(screenshot)
            if self.last_screenshot is None:
                self.last_screenshot = screenshot_np
            else:
                diff = np.sum(np.abs(screenshot_np - self.last_screenshot))
                if diff < 10000:  # 微小变化阈值
                    self.inactive_time += 1
                else:
                    self.inactive_time = 0

                self.last_screenshot = screenshot_np

            if self.inactive_time >= 5 and self.mouse_inactive_time >= 5 and self.keyboard_inactive_time >= 5:
                self.show_screenshot()
            time.sleep(1)

    def monitor_user_activity(self):
        # 使用pynput监听键盘和鼠标
        def on_move(x, y):
            self.mouse_inactive_time = 0

        def on_click(x, y, button, pressed):
            self.mouse_inactive_time = 0

        def on_scroll(x, y, dx, dy):
            self.mouse_inactive_time = 0

        def on_press(key):
            self.keyboard_inactive_time = 0

        self.mouse_listener = mouse.Listener(on_move=on_move, on_click=on_click, on_scroll=on_scroll)
        self.mouse_listener.start()

        self.keyboard_listener = keyboard.Listener(on_press=on_press)
        self.keyboard_listener.start()

    def show_screenshot(self):
        if not self.screen_locked:
            self.screen_locked = True
            screenshot = ImageGrab.grab()
            screenshot.save(self.screenshot_path)

            # 初始化Tk窗口
            self.root = Tk()
            self.root.attributes("-fullscreen", True)
            self.root.attributes("-topmost", True)
            self.root.attributes("-alpha", 0.5)  # 半透明
            self.root.overrideredirect(True)  # 去掉标题栏
            self.root.attributes("-transparentcolor", "white")  # 设置穿透色

            # 显示截图
            img = ImageTk.PhotoImage(screenshot)
            label = Label(self.root, image=img)
            label.pack(fill="both", expand=True)

            # 启动一个线程监听用户输入，一旦有输入就关闭窗口
            def close_on_activity():
                while self.mouse_inactive_time < 5 or self.keyboard_inactive_time < 5:
                    time.sleep(1)
                self.root.destroy()
                self.screen_locked = False

            threading.Thread(target=close_on_activity, daemon=True).start()
            self.root.mainloop()

# 启动屏幕保护程序
screen_saver = ScreenSaver()
screen_saver.start()
