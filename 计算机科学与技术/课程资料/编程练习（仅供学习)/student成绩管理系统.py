filename = 'student.txt' #用于存储学生信息的txt文件名
import os #导入os模块
#定义主函数
def main():
    while True:
        menu()
        choice = int(input('请选择'))
        if choice in [0, 1, 2, 3, 4, 5, 6, 7]:
            if choice == 0:
                answer = input('您确定要退出系统吗?y/n')
                if answer == 'y' or answer == 'Y':
                    print('谢谢您的使用.')
                    break
                else:
                    continue
            elif choice == 1: insert()
            elif choice == 2: search()
            elif choice == 3: delete()
            elif choice == 4: modify()
            elif choice == 5: sort()
            elif choice == 6: total()
            elif choice == 7: show()
#定义菜单函数
def menu():
    print('==========欢迎==========')
    print('-------------功能菜单-------------')
    print('1.录入学生信息')
    print('2.查找学生信息')
    print('3.删除学生信息')
    print('4.修改学生信息')
    print('5.排序')
    print('6.统计学生信息')
    print('7.显示所有信息')
    print('0.退出')
    print('--------------------------------')
#定义学生信息添加函数
def insert():
    student_lst = [] #用于存储学生信息的列表
    while True:
        id = input('请输入ID(如1001):')
        if not id: break #如果id为空值，就停止
        name = input('请输入姓名:')
        if not name: break
        try:
            english = int(input('请输入英语成绩:'))
            python = int(input('请输入Python成绩:'))
            java = int(input('请输入Java成绩:'))
        except: 
            print('输入无效,不是整数类型,请重新输入.')
        student = {'ID': id, 'Name': name, 'English': english, 'Python': python, 'Java': java} #将新的学生信息生成字典
        student_lst.append(student) #将单条学生信息添加到列表后面
        save(student_lst) 
        answer = input('是否继续添加学生信息?y/n\n')
        if answer == 'y': continue
        else:
            break
            print('学生信息录入完毕.')
#定义学生信息保存函数
def save(lst):
    try:
        stu_txt = open(filename, 'a', encoding = 'utf_8')
    except:
        stu_txt = open(filename, 'w', encoding='utf_8')
    for item in lst:
        stu_txt.write(str(item) + '\n')
    stu_txt.close()
#定义学生信息搜索函数，可以实现按照ID或者姓名搜索
def search():
    while True:
        Method = int(input('请输入查找方法,1表示按ID查找,2表示按姓名查找.'))
        if Method != 1 and Method != 2:
            print('不是预设的查找方法,请重新输入.')
            search() #如果输入值不是1和2，就会要求重新输入，可以通过直接再次运行search()函数实现
        Inf = input('请按照查找方法输入要查找的学生的信息:') #输入ID或者姓名
        with open(filename, 'r', encoding = 'utf-8') as sfile: #打开存储学生信息的文件
            stu_ifo = sfile.readlines()
            d = {}
            flag = True #用于判断最后是否找到学生信息
            if Inf != '':
                for item in stu_ifo:
                    d = dict(eval(item)) #将文件中的每一行信息转化为一个字典
                    if Method == 1 and d['ID'] == Inf:
                        show_student(d) 
                        flag = False
                    elif Method == 2 and d['Name'] == Inf:
                        show_student(d)
                        flag = False
            else:
                print('没有输入正确的学生信息,请重新输入.')
                search()
        if flag: #flag的作用在这里体现
            print('未查到学生信息.')
        answer = input('是否继续查找学生信息?y/n\n')
        if answer == 'y': continue 
        else: break 
#输出学生信息的一个函数
def show_student(lst):
    if len(lst) == 0:
        print('没有查询到学生信息,无数据显示.')
        return
    #定义标题显示格式
    format_title = '{:^6}\t{:^12}\t{:^8}\t{:^10}\t{:^10}\t{:^8}'
    print(format_title.format('ID', 'Name', 'English', 'Python', 'Java', 'Sum'))
    #定义内容显示格式
    format_data = '{:^6}\t{:^12}\t{:^8}\t{:^10}\t{:^10}\t{:^8}'
    print(format_data.format(lst['ID'],
                             lst['Name'],
                             lst['English'],
                             lst['Python'],
                             lst['Java'],
                             int(lst['English']) + int(lst['Python']) + int(lst['Java'])))
#定义学生信息删除函数
def delete():
    while True:
        student_id = input('请输入要删除学生的ID:')
        if student_id != '':
            if os.path.exists(filename): #判断文件是否存在
                with open(filename, 'r', encoding = 'utf-8') as stu_file: #打开文件
                    student_old = stu_file.readlines()
            else:
                student_old = []
            flag = False #flag作用与上面的函数相同
            if student_old:
                with open(filename, 'w', encoding = 'utf-8') as wfile: 
                    d = {}
                    for item in student_old:
                        d = dict(eval(item))
                        if d['ID'] != student_id:
                            wfile.write(str(d) + '\n')
                        else:
                            flag = True
                    if flag:
                        print(f'ID为{student_id}的学生信息已删除.')
                    else:
                        print(f'没有找到ID为{student_id}的学生.')
            else:
                print('没有学生信息.')
                break
            show() 
            answer = input('是否继续删除?y/n\n')
            if answer == 'y': continue
            else: break
#定义学生信息修改函数
def modify():
    show()
    if os.path.exists(filename): #同上
        with open(filename, 'r', encoding = 'utf-8') as rfile: #只读方式打开
            student_old = rfile.readlines()
    else:
        return #如果没有学生信息的文件，就回到主函数
    student_id = input('请输入要修改学生的ID:')
    with open(filename, 'w', encoding = 'utf-8') as wfile: #写入方式打开
        for item in student_old:
            d = dict(eval(item))
            flag = False 
            if d['ID'] == student_id:
                print('找到学生信息,可以修改了.')
                try:
                    d['Name'] = input('请输入新的姓名:')
                    d['English'] = int(input('请输入新的English成绩:'))
                    d['Python'] = int(input('请输入新的Python成绩:'))
                    d['Java'] = int(input('请输入新的Java成绩:'))
                except:
                    print('输入有误,请重新输入.')
                wfile.write(str(d) + '\n')
            else:
                wfile.write(str(d) + '\n')
                flag = True
            if flag:
                print(f'未找到ID为{student_id}的学生信息.')
        answer = input('是否继续修改学生信息?y/n\n')
        if answer == 'y': modify()
#定义学生按成绩排序函数
def sort():
    if os.path.exists(filename): 
        show()
        with open(filename, 'r', encoding = 'utf-8') as rfile: #只读方式打开
            students = rfile.readlines()
        student_new = []
        for item in students:
            d = dict(eval(item))
            student_new.append(d)
    else:
        return
    aord = int(input('请选择:0表示升序,1表示降序.'))
    if aord == 0:
        flag = False
    elif aord == 1:
        flag = True
    else:
        print('输入有误,请重新输入.')
        sort()
    mode = int(input('请选择排序方式:1英语,2Python,3Java,4Sum'))
    if mode == 1: #借助lambda函数实现排序
        student_new.sort(key = lambda x :int(x['English']), reverse = flag)
    elif mode == 2:
        student_new.sort(key = lambda x: int(x['Python']), reverse = flag)
    elif mode == 3:
        student_new.sort(key = lambda x: int(x['Java']), reverse = flag)
    elif mode == 4:
        student_new.sort(key = lambda x: int(x['English'] + x['Python'] + x['Java']), reverse = flag)
    else:
        print('不是预设方法,请重新输入.')
        sort()
    
    format_title = '{:^6}\t{:^12}\t{:^8}\t{:^10}\t{:^10}\t{:^8}'
    print(format_title.format('ID', 'Name', 'English', 'Python', 'Java', 'Sum'))
    # 定义内容显示格式
    format_data = '{:^6}\t{:^12}\t{:^8}\t{:^10}\t{:^10}\t{:^8}'
    for lst in student_new:
        print(format_data.format(lst['ID'],
                                 lst['Name'],
                                 lst['English'],
                                 lst['Python'],
                                 lst['Java'],
                                 int(lst['English']) + int(lst['Python']) + int(lst['Java'])))
#定义学生数量统计函数
def total():
    if os.path.exists(filename):
        with open(filename, 'r', encoding = 'utf-8') as rfile:
            students = rfile.readlines()
            if students:
                print('一共有{}名学生.'.format(len(students)))
            else:
                print('还没有录入学生信息.')
    else:
        print('暂未保存数据信息.')
#定义学生信息展示函数
def show():
    if os.path.exists(filename):
        with open(filename, 'r', encoding = 'utf-8') as rfile:
            students = rfile.readlines()
            format_title = '{:^6}\t{:^12}\t{:^8}\t{:^10}\t{:^10}\t{:^8}'
            format_data = '{:^6}\t{:^12}\t{:^8}\t{:^10}\t{:^10}\t{:^8}'
            print(format_title.format('ID', 'Name', 'English', 'Python', 'Java', 'Sum'))
            d = {}
            if len(students) != 0:
                for item in students:
                    d = dict(eval(item))
                    print(format_data.format(d['ID'],
                                             d['Name'],
                                             d['English'],
                                             d['Python'],
                                             d['Java'],
                                             int(d['English']) + int(d['Python']) + int(d['Java'])))
            else:
                print('尚未录入学生信息.')
    else:
        print('尚未保存学生信息文件.')
if __name__ == '__main__':
            main()
