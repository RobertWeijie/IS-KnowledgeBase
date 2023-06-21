import jieba

txt = open("/Users/alex/c-projects/西游记之女儿国奇遇.txt", "r").read()
words = jieba.lcut(txt)
counts = {}

for word in words:
    rword = None
    if word == "师父" or word == "唐三藏":
        rword = "唐僧"
    elif word == "大师兄" or word == "孙行者" or word == "猴哥":
        rword = "悟空"
    elif word == "沙和尚" or word == "沙悟净":
        rword = "沙僧"
    elif word == "猪八戒" or word == "二师兄" or word == "呆子":
        rword = "八戒"
    else:
        continue
    if rword:
        counts[rword] = counts.get(rword, 0) + 1

for key in counts.keys():
    print(key, counts[key])