#include <iostream>
#include <string>
using namespace std;

// 学生信息类
class Student {
public:
    Student(string n = "", string g = "", int a = 0, string p = "", string add = "") {
        name = n;
        gender = g;
        age = a;
        phone = p;
        address = add;
    }

    string getName() {//获取学生姓名
        return name;
    }

    void setName(string n) {// 设置学生姓名
        name = n;
    }

    string getGender() {// 获取学生性别
        return gender;
    }

    void setGender(string g) { // 设置学生性别
        gender = g;
    }

    int getAge() {// 获取学生年龄
        return age;
    }

    void setAge(int a) {// 设置学生年龄
        age = a;
    }

    string getPhone() {// 获取学生电话
        return phone;
    }

    void setPhone(string p) {// 设置学生电话
        phone = p;
    }

    string getAddress() {//获取学生地址
        return address;
    }

    void setAddress(string add) { // 设置学生地址
        address = add;
    }

    void showInfo() {// 展示学生信息
        cout << "姓名：" << name << "\t性别：" << gender << "\t年龄：" << age
             << "\t电话：" << phone << "\t地址：" << address << endl;
    }

private:
    string name;    // 学生姓名
    string gender;  // 学生性别
    int age;        // 学生年龄
    string phone;   // 学生电话
    string address; // 学生地址
};

// 通讯录类
class AddressBook {
public:
    AddressBook() { // 构造函数，初始化学生信息数组和学生数量
        stu_arr = new Student[100]{
            Student("张三", "男", 20, "123456789", "北京市海淀区"),
            Student("李四", "女", 18, "987654321", "上海市浦东新区")
        };
        stu_num = 2;
    }

    ~AddressBook() {// 析构函数，释放动态分配的内存
        delete[] stu_arr;
    }

    void showMenu() {// 展示
        cout << "******************************" << endl;
        cout << "***** 1. 添加学生信息 *******" << endl;
        cout << "***** 2. 显示学生信息 *******" << endl;
        cout << "***** 3. 删除学生信息 *******" << endl;
        cout << "***** 4. 查找学生信息 *******" << endl;
        cout << "***** 5. 修改学生信息 *******" << endl;
        cout << "***** 6. 退出通讯录 ********" << endl;
        cout << "******************************" << endl;
    }

    void addStudent() {// 添加学生信息
        if (stu_num >= 100) {
            cout << "通讯录已满，无法添加新的学生信息！" << endl;// 当学生数量等于或超过数组长度时，无法再添加新的学生信息
            return;
        }

        string name, gender, phone, address;
        int age;

        cout << "请输入学生姓名：" << endl;
        cin >> name;

        cout << "请输入学生性别：" << endl;
        cin >> gender;

        cout << "请输入学生年龄：" << endl;
        cin >> age;

        cout << "请输入学生电话：" << endl;
        cin >> phone;

        cout << "请输入学生地址：" << endl;
        cin >> address;

        stu_arr[stu_num] = Student(name, gender, age, phone, address);
      // 将新的学生信息添加到数组中
        stu_num++;// 学生数量加1
        cout << "添加成功！" << endl;
    }

    void showStudent() {
        if (stu_num == 0) {
            cout << "通讯录中没有学生信息！" << endl;
            return;
        }

        for (int i = 0; i < stu_num; i++) {
            cout << "第" << i + 1 << "个学生信息：" << endl;
            stu_arr[i].showInfo();// 依次展示每个学生的信息
        }
    }

    void deleteStudent() {// 删除学生信息
        if (stu_num == 0) {
            cout << "通讯录中没有学生信息！" << endl;
            return;
        }

        string name;
        cout << "请输入要删除的学生姓名：" << endl;
        cin >> name;

        int index = -1;
        for (int i = 0; i < stu_num; i++) {
            if (stu_arr[i].getName() == name) {// 如果找到要删除的学生信息，记录其在数组中的下标
                index = i;
                break;
            }
        }

        if (index == -1) {// 没有找到要删除的学生信息
            cout << "没有找到该学生信息！" << endl;
            return;
        }

        for (int i = index; i < stu_num - 1; i++) {
            stu_arr[i] = stu_arr[i + 1];
        }

        stu_num--;//学生数量减1
        cout << "删除成功！" << endl;
    }

    void findStudent() {
        if (stu_num == 0) {
            cout <<"通讯录中没有学生信息！" << endl;
            return;
        }

        string name;
        cout << "请输入要查找的学生姓名：" << endl;
        cin >> name;

        for (int i = 0; i < stu_num; i++) {
            if (stu_arr[i].getName() == name) {
                cout << "找到该学生信息：" << endl;
                stu_arr[i].showInfo();
                return;
            }
        }

        cout << "没有找到该学生信息！" << endl;
    }

    void modifyStudent() {
        if (stu_num == 0) {
            cout << "通讯录中没有学生信息！" << endl;
            return;
        }

        string name;
        cout << "请输入要修改的学生姓名：" << endl;
        cin >> name;

        for (int i = 0; i < stu_num; i++) {
            if (stu_arr[i].getName() == name) {
                cout << "找到该学生信息，请输入要修改的信息：" << endl;

                string gender, phone, address;
                int age;

                cout << "请输入学生性别：" << endl;
                cin >> gender;

                cout << "请输入学生年龄：" << endl;
                cin >> age;

                cout << "请输入学生电话：" << endl;
                cin >> phone;

                cout << "请输入学生地址：" << endl;
                cin >> address;

                stu_arr[i].setGender(gender);
                stu_arr[i].setAge(age);
                stu_arr[i].setPhone(phone);
                stu_arr[i].setAddress(address);

                cout << "修改成功！" << endl;
                return;
            }
        }

        cout << "没有找到该学生信息！" << endl;
    }

private:
    Student* stu_arr; // 学生信息数组
    int stu_num; // 学生数量
};

int main() {
    AddressBook ab;

    while (true) {
        ab.showMenu();

        int choice;
        cin >> choice;

        switch (choice) {
        case 1: // 添加学生信息
            ab.addStudent();
            break;

        case 2: // 显示学生信息
            ab.showStudent();
            break;

        case 3: // 删除学生信息
            ab.deleteStudent();
            break;

        case 4: // 查找学生信息
            ab.findStudent();
            break;

        case 5: // 修改学生信息
            ab.modifyStudent();
            break;

        case 6: // 退出通讯录
            cout << "欢迎下次使用！" << endl;
            return 0;

        default:
            cout << "输入的选项不正确，请重新输入！" << endl;
            break;
        }
    }

    return 0;
}