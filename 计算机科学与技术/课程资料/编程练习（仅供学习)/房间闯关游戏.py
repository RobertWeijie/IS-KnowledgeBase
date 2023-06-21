#!/usr/bin/env python3
import time

# 定义房间及其属性
rooms = {
	"起点": {
		"description": "你在一个黑暗的房间里。北边有一扇门。",
		"exits": {
			"north": "房间1"
		}
	},
	"房间1": {
		"description": "你在一个明亮的房间里。南边有一扇门，东边有一扇门。",
		"exits": {
			"south": "起点",
			"east": "房间2"
		}
	},
	"房间2": {
		"description": "你在一个有一个大箱子的房间里。西边有一扇门。",
		"exits": {
			"west": "房间1"
		}
	}
}

# 定义难题及其解决方案
puzzles = {
	"房间2": {
		"description": "箱子被锁住了。上面有一个附着的纸条写着：“要打开箱子，你必须解决这个谜语：什么总是在你前面，却看不见？”",
		"solution": "未来"
	}
}

# 定义玩家物品清单
inventory = []

# 定义玩家的起始位置
current_room = "起点"

# 定义一个函数，打印玩家当前位置和描述
def print_location():
	print(f"你在{current_room}。")
	print(rooms[current_room]["description"])
	print("可用出口：" + ", ".join(rooms[current_room]["exits"].keys()))
	
# 定义一个函数，处理玩家在房间之间移动
def move(direction):
	global current_room
	if direction in rooms[current_room]["exits"]:
		current_room = rooms[current_room]["exits"][direction]
		print_location()
	else:
		print("你不能往那个方向走。")
		
# 定义一个函数，处理玩家与难题的互动
def interact():
	if current_room in puzzles:
		print(puzzles[current_room]["description"])
		answer = input("输入你的答案：")
		if answer.lower() == puzzles[current_room]["solution"]:
			print("恭喜你，你解决了难题！")
			inventory.append(current_room)
		else:
			print("抱歉，那不是正确的答案。")
			
# 定义主游戏循环
while True:
	print_location()
	action = input("你想做什么？")
	if action.lower() == "quit":
		print("感谢你的游玩！")
		break
	elif action.lower() in ["north", "south", "east", "west"]:
		move(action.lower())
	elif action.lower() == "look":
		print_location()
	elif action.lower() == "inventory":
		print("你带着：")
		print(", ".join(inventory))
	elif action.lower() == "interact":
		interact()
	else:
		print("我不理解你想做什么。")
		
	# 添加轻微延迟，让玩家有时间阅读输出
	time.sleep(1)