#!/usr/bin/env python3

import random
import os
import re
from builtins import str
from fileinput import input

os.system('cls' if os.name=='nt' else 'clear')


def print(param):
	pass


while (1 < 2):
	print ("\n")
	print ("石头，剪刀，布 - 游戏开始!")
	userChoice = input("选择你的武器 [R]石头, [P]布, or [S]剪刀: ")
	if not re.match("[SsRrPp]", userChoice):
		print ("Please choose a letter:")
		print("[R]石头, [S]剪刀 或者 [P]布.")
		continue

	weapon_dic = {'R':"石头", 'r':"石头", "S":"剪刀", "s": "剪刀", "P":"布", "p":"布"}
	print ("你选择了： " + weapon_dic[userChoice])
	choices = ['R', 'P', 'S']
	opponenetChoice = random.choice(choices)
	print ("机器人选择了: " + weapon_dic[opponenetChoice])
	if opponenetChoice == str.upper(userChoice):
		print ("平手，再来吧，愚蠢的人类! ")

	elif opponenetChoice == 'R' and userChoice.upper() == 'S':
		print ("我赢了，愚蠢的人类! ")
		continue
	elif opponenetChoice == 'S' and userChoice.upper() == 'P':
		print ("我赢了, 愚蠢的人类! ")
		continue
	elif opponenetChoice == 'P' and userChoice.upper() == 'R':
		print ("我赢了, 愚蠢的人类! ")
		continue
	else:
		print ("你赢了，这局我大意了!")
