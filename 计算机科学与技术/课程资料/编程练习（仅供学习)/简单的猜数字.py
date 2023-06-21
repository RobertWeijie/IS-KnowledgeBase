import random

def generate_secret_number(length):
    """
    生成指定长度的随机数
    """
    digits = [str(i) for i in range(10)]
    random.shuffle(digits)
    return ''.join(digits[:length])

def get_guess(length):
    """
    获取玩家的猜测
    """
    while True:
        guess = input("请输入一个{}位数字: ".format(length))
        if len(guess) != length or not guess.isdigit():
            print("无效输入，请重新输入。")
        else:
            return guess

def get_clues(secret_number, guess):
    """
    根据猜测生成提示信息
    """
    if guess == secret_number:
        return "恭喜你猜对了！"
    clues = []
    for i in range(len(guess)):
        if guess[i] == secret_number[i]:
            clues.append("B")
        elif guess[i] in secret_number:
            clues.append("C")
        else:
            clues.append("_")
    random.shuffle(clues)
    return ''.join(clues)

def play_game():
    """
    玩游戏
    """
    print("欢迎来到猜数字游戏！")
    while True:
        level = input("请选择游戏难度（1-3）: ")
        if level in ['1', '2', '3']:
            level = int(level)
            break
        else:
            print("无效输入，请重新输入。")
    while True:
        length = input("请选择数字长度（4-6）: ")
        if length in ['4', '5', '6']:
            length = int(length)
            break
        else:
            print("无效输入，请重新输入。")
    secret_number = generate_secret_number(length)
    print("游戏开始！")
    guesses = 0
    while True:
        guess = get_guess(length)
        guesses += 1
        clues = get_clues(secret_number, guess)
        print(clues)
        if guess == secret_number:
            print("你用了{}次猜对了！".format(guesses))
            break
        elif guesses == level * 10:
            print("游戏结束，你失败了。正确的数字是{}。".format(secret_number))
            break

play_game()