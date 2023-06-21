#!/usr/bin/env python3

import tkinter as tk
from math import factorial

def calculate():
	input_num = entry.get()
	try:
		num = int(input_num)
		if num == -1:
			root.destroy() 
		if num < 0:
			raise ValueError("Input data error, must be a positive integer")
		elif num == 0:
			result.set(1)
		else:
			result.set(factorial(num))
	except ValueError as e:
		result.set(str(e))
		
root = tk.Tk()
root.title("factorial calculator")

frame = tk.Frame(root)
frame.pack(pady=10)

label = tk.Label(frame, text="Please enter a positive integer:")
label.pack(side=tk.LEFT)

entry = tk.Entry(frame)
entry.pack(side=tk.LEFT)

button = tk.Button(frame, text="Calculate", command=calculate)
button.pack(side=tk.LEFT, padx=10)

result = tk.StringVar()
result.set("")
result_label = tk.Label(root, textvariable=result)
result_label.pack(pady=10)

root.mainloop()