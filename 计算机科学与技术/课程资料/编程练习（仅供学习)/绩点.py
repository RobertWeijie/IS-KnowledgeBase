n = int(input())
S = 0
T = 0

for i in range(n):
    gpai, sci = map(float, input().split())
    S += sci
    T += gpai * sci

jidian = round(T / S, 1)
print(jidian)