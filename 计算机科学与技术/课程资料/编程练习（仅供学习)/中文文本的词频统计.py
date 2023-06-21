#!/usr/bin/env python3
import jieba
import csv

fr = open(r'D:\Jupyter\python学习\细节决定成败.txt', 'r', encoding='gb2312', errors='ignore')
raw = fr.read()
fr.close()

stop_words = ['，', '？', '；', '。', '：', '!', '.', '○', '［', '］', '“', '”', '、']

# 去除停用词
for sw in stop_words:
	raw = raw.replace(sw, '')
	
words = jieba.lcut(raw)

td = {}
for w in words:
	if len(w) > 1:
		td[w] = td.get(w, 0) + 1
		
fw = open(r'D:\Jupyter\python学习\词频.csv', 'w', encoding='gb2312', newline='')
writer = csv.writer(fw)
for k, v in td.items():
	writer.writerow([k, v])
fw.close()