#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <iomanip>

class Student {
public:
    Student() {}
    Student(std::string id, std::string name, std::string gender)
        : m_id(id), m_name(name), m_gender(gender) {}
    virtual ~Student() {}

    std::string getID() const { return m_id; }
    void setID(const std::string& id) { m_id = id; }
    std::string getName() const { return m_name; }
    std::string getGender() const { return m_gender; }

    virtual void input() = 0;
    virtual void output() const = 0;
    virtual int getTotalScore() const = 0;
    virtual void edit() = 0;

protected:
    std::string m_id;
    std::string m_name;
    std::string m_gender;
};

class Wulian : public Student {
public:
    Wulian() {}
    Wulian(std::string id, std::string name, std::string gender, std::string cls,
           int mathScore, int engScore)
        : Student(id, name, gender), m_cls(cls), m_mathScore(mathScore),
          m_engScore(engScore) {}

    std::string getCls() const { return m_cls; }
    int getMathScore() const { return m_mathScore; }
    int getEngScore() const { return m_engScore; }

    void input() override {
        std::cout << "请输入学生姓名：";
        std::cin >> m_name;
        std::cout << "请输入学生性别：";
        std::cin >> m_gender;
        std::cout << "请输入学生班级：";
        std::cin >> m_cls;
        std::cout << "请输入学生高数成绩：";
        std::cin >> m_mathScore;
        std::cout << "请输入学生英语成绩：";
        std::cin >> m_engScore;
    }

    void output() const override {
        std::cout << std::left << std::setw(10) << m_id << std::setw(10) << m_name << std::setw(10) << m_gender
                  << std::setw(20) << m_cls << std::setw(10) << m_mathScore << std::setw(10) << m_engScore
                  << std::setw(10) << getTotalScore() << std::endl;
    }

    int getTotalScore() const override { return m_mathScore + m_engScore; }

    void edit() override {
        std::cout << "请输入学生新班级：";
        std::cin >> m_cls;
        std::cout << "请输入学生新高数成绩：";
        std::cin >> m_mathScore;
        std::cout << "请输入学生新英语成绩：";
        std::cin >> m_engScore;
    }

private:
    std::string m_cls;
    int m_mathScore;
    int m_engScore;
};

class StudentManager {
public:
    void addStudent() {
        Wulian student;
        student.input();
        student.setID("stu" + std::to_string(m_students.size() + 1));
        m_students.push_back(student);
        std::cout << "添加成功！学生ID为：" << student.getID() << std::endl;
    }

    void queryStudent() const {
        std::string id;
        std::cout << "请输入要查询的学生ID：";
        std::cin >> id;
        for (const auto& student : m_students) {
            if (student.getID() == id) {
                student.output();
                return;
            }
        }
        std::cout << "未找到ID为" << id << "的学生！" << std::endl;
    }

    void editStudent() {
        std::string id;
        std::cout << "请输入要修改的学生ID：";
        std::cin >> id;
        for (auto& student : m_students) {
            if (student.getID() == id) {
                student.edit();
                std::cout << "修改成功！" << std::endl;
                return;
            }
        }
        std::cout << "未找到ID为" << id << "的学生！" << std::endl;
    }

    void deleteStudent() {
        std::string id;
        std::cout << "请输入要删除的学生ID：";
        std::cin >> id;
        for (auto it = m_students.begin(); it != m_students.end(); ++it) {
            if (it->getID() == id) {
                m_students.erase(it);
                std::cout << "删除成功！" <<std::endl;
                return;
            }
        }
        std::cout << "未找到ID为" << id << "的学生！" << std::endl;
    }

   void sortStudent() {
    std::sort(m_students.begin(), m_students.end(),
              [](const Wulian& s1, const Wulian& s2) {
                  return s1.getMathScore() > s2.getMathScore();
              });
    std::cout << "排序成功！" << std::endl;
}

    void displayAllStudents() const {
        std::cout << std::left << std::setw(10) << "ID" << std::setw(10) << "姓名" << std::setw(10) << "性别"
                  << std::setw(20) << "班级" << std::setw(10) << "高数成绩" << std::setw(10) << "英语成绩"
                  << std::setw(10) << "总成绩" << std::endl;
        for (const auto& student : m_students) {
            student.output();
        }
    }

private:
    std::vector<Wulian> m_students;
};

int main() {
    StudentManager manager;
    int choice = 0;
    while (true) {
        std::cout << "请选择操作：" << std::endl;
        std::cout << "1. 添加学生" << std::endl;
        std::cout << "2. 查询学生" << std::endl;
        std::cout << "3. 修改学生" << std::endl;
        std::cout << "4. 删除学生" << std::endl;
        std::cout << "5. 排序学生" << std::endl;
        std::cout << "6. 显示所有学生" << std::endl;
        std::cout << "0. 退出程序" << std::endl;
        std::cout << "请选择：";
        std::cin >> choice;
        switch (choice) {
            case 1:
                manager.addStudent();
                break;
            case 2:
                manager.queryStudent();
                break;
            case 3:
                manager.editStudent();
                break;
            case 4:
                manager.deleteStudent();
                break;
            case 5:
                manager.sortStudent();
                break;
            case 6:
                manager.displayAllStudents();
                break;
            case 0:
                std::cout << "程序已退出！" << std::endl;
                return 0;
            default:
                std::cout << "输入有误，请重新输入！" << std::endl;
                break;
        }
    }
    return 0;
}