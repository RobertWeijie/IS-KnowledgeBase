def fun():
    s = input()
    if s.isdigit() and len(s)%2 !=0:
        x = int(s)
        if x == eval(s[::-1]):
            print('yes')
        else:
            print('No')
    else:
        print('No')

fun()