#!/usr/bin/env python3

import win32api
import win32con
import time
from ctypes import *
from PIL import ImageGrab
from skimage import io
import os

'''
使用方法：
首先打开Chrome恐龙小游戏（在浏览器中输入chrome://dino/），然后将鼠标放置于任务栏浏览器的图标上，运行代码

设计思路：
使用win32库模拟键盘鼠标的输入，PIL库和skimage库进行图像处理。开始游戏后，每隔约0.1秒截取小恐龙身前的图像，求取图像像素的平均值。
若像素均值低于阈值（黑色障碍物占大部分），则按键进行跳跃。最后删除截图，进入下一个trail。

缺陷：
仅适用于白天场景，进入黑夜后无法进行判断。
'''


def GetMousePos():  # 获取鼠标位置
	x, y = win32api.GetCursorPos()
	return x, y


def SetMousePos(num1, num2):  # 设置鼠标位置并按键
	windll.user32.SetCursorPos(num1, num2)  # 设置鼠标位置
	win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)  # 按下左键
	win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)  # 松开左键
	windll.user32.SetCursorPos(727, 503)  # 设置鼠标位置
	time.sleep(1)
	win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)  # 按下左键
	win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)  # 松开左键
	
	
def space():  # 输入空格
	space = win32api.keybd_event(0X20, 0, 0, 0)
	return space


def ScreenShoot():  # 屏幕截图，需要根据屏幕分辨率调整grab函数中的分辨率，只需要截取小恐龙身前一部分的图像
	im = ImageGrab.grab((590, 835, 765, 910))
	im.save(r'D:\picture_save\screenshoot.png')  # 可根据需要调整截图存储位置
	
	
def ReadImage():  # 读取屏幕截图
	screen = io.imread(r'D:\picture_save\screenshoot.png')
	ImMean = screen.mean()  # 获得截图像素平均值，0为纯黑，255为纯白
	return ImMean


def DeleteImg():  # 删除截图
	os.remove('D:\picture_save\screenshoot.png')
	
	
if __name__ == '__main__':
	x, y = GetMousePos()  # 运行代码前将鼠标放至浏览器的图标，可直接点开浏览器
	SetMousePos(x, y)
	for trail in range(0,20000):  # 按键判断20000次
		start = time.time()
		ScreenShoot()
		ImMean = ReadImage()
		if ImMean<230:  # 如果截图中黑色比例较高，按空格键跳跃
			space()
		DeleteImg()
		end = time.time()
		print('Time consuming:', end-start)