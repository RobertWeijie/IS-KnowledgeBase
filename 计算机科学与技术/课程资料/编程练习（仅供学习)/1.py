#!/usr/bin/env python3

import tkinter as tk
import json

# 创建主窗口
root = tk.Tk()
root.title("Student management")
root.geometry("400x300")

# 定义一个空字典，用于存储学生的姓名和成绩
students = {}

# 成绩管理模块
def add_student():
	"""
	添加学生姓名和成绩
	"""
	name = name_entry.get()
	chinese = int(chinese_entry.get())
	math = int(math_entry.get())
	english = int(english_entry.get())
	students[name] = {
		'语文': chinese,
		'数学': math,
		'英语': english,
		'总分': chinese + math + english
	}
	result_label.config(text="Success！")
	
def delete_student():
	"""
	删除学生姓名和成绩
	"""
	name = name_entry.get()
	if name in students:
		del students[name]
		result_label.config(text="delete success！")
	else:
		result_label.config(text="The Student dont exists！")
		
def modify_score():
	"""
	修改学生成绩
	"""
	name = name_entry.get()
	if name in students:
		subject = subject_entry.get()
		if subject in students[name]:
			score = int(score_entry.get())
			students[name][subject] = score
			students[name]['总分'] = students[name]['语文'] + students[name]['数学'] + students[name]['英语']
			result_label.config(text="success！")
		else:
			result_label.config(text="the course no exits！")
	else:
		result_label.config(text="the student no exits！")
		
def query_score():
	"""
	查询学生的成绩
	"""
	name = name_entry.get()
	if name in students:
		result_label.config(text="学生姓名\t语文\t数学\t英语\t总分\n")
		result_label.config(text=f"{name}\t\t{students[name]['语文']}\t\t{students[name]['数学']}\t\t{students[name]['英语']}\t\t{students[name]['总分']}")
	else:
		result_label.config(text="the student dont exits！")
		
def query_all():
	"""
	查询所有学生成绩
	"""
	if not students:
		result_label.config(text="no student record！")
	else:
		result_label.config(text="学生姓名\t语文\t数学\t英语\t总分\n")
		for name in students:
			result_label.config(text=f"{name}\t\t{students[name]['语文']}\t\t{students[name]['数学']}\t\t{students[name]['英语']}\t\t{students[name]['总分']}\n")
			
			
# 创建标签、文本框和按钮
name_label = tk.Label(root, text="name：")
name_label.place(x=50, y=50)

name_entry = tk.Entry(root)
name_entry.place(x=100, y=50)

chinese_label = tk.Label(root, text="chinese：")
chinese_label.place(x=50, y=80)

chinese_entry = tk.Entry(root)
chinese_entry.place(x=100, y=80)

math_label = tk.Label(root, text="math：")
math_label.place(x=50, y=110)

math_entry = tk.Entry(root)
math_entry.place(x=100, y=110)

english_label = tk.Label(root, text="English：")
english_label.place(x=50, y=140)

english_entry = tk.Entry(root)
english_entry.place(x=100, y=140)



add_button = tk.Button(root, text="add", command=add_student)
add_button.place(x=50, y=240)

delete_button = tk.Button(root, text="delete", command=delete_student)
delete_button.place(x=110, y=240)

modify_button = tk.Button(root, text="modify", command=modify_score)
modify_button.place(x=170, y=240)

query_button = tk.Button(root, text="search", command=query_score)
query_button.place(x=230, y=240)



query_all_button = tk.Button(root, text="exits", command=exit)
query_all_button.place(x=290, y=240)


result_label = tk.Label(root, text="")
result_label.place(x=50, y=310)

root.mainloop()