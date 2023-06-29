#include <iostream>
#include <vector>
#include <string>
#include <stdlib.h>
#include <stack>

using namespace std;

bool is_operator(char c)
{
    switch(c)
    {
        case '+':
        case '-':
        case '*':
        case '/':
        case '>':
        case '<':
        case '!':
        case '&':
        case '|':
        case '=':
            return true;
        default:
            return false;
    }
}

int get_pri(char c)
{
    switch (c)
    {
        case '|':
            return 1;
        case '&':
            return 2;
        case '!':
            return 3;
        case '>':
        case '<':
        case '=':
            return 4;
        case '+':
        case '-':
            return 5;
        case '*':
        case '/':
            return 6;
        case '(':
            return 7;
        default:
            return -1;
    }
}

float calculate(float num1, float num2, char op)
{
    switch(op)
    {
        case '+':
            return num1 + num2;
        case '-':
            return num1 - num2;
        case '*':
            return num1 * num2;
        case '/':
            return num1 / num2;
        case '>':
            return num1 > num2;
        case '<':
            return num1 < num2;
        case '=' :
            return num1 == num2;
        case '&':
            return num1 && num2;
        case '|':
            return num1 || num2;
        
        case '!':
            return calculate(num1, num2, '=') ? false : true;  // 逻辑不等于运算符返回 true 或 false
        default:
            return false;
    }
}

int main()
{
    stack<float> nums;  // 使用栈来保存数字
    stack<char> ops;    // 使用栈来保存运算符

    string expression;
    getline(cin, expression);  // 可以接受包含空格的字符串作为输入

    int i = 0;
    while(i < expression.length())
    {
        char c = expression[i];
        if(is_operator(c))
        {
            if(i + 1 < expression.length() && is_operator(expression[i + 1]))
            {
                // 如果当前运算符和下一个运算符组成一个双字符运算符（>=, <=, !=）
                ops.push(c);
                i += 2;
            }
            else
            {
                // 如果当前运算符是单字符运算符，或者是一个双字符运算符的一部分
                while(!ops.empty() && get_pri(c) <= get_pri(ops.top()))
                {
                    float num2 = nums.top();
                    nums.pop();
                    float num1 = nums.top();
                    nums.pop();
                    char op = ops.top();
                    ops.pop();
                    float result = calculate(num1, num2, op);
                    nums.push(result);
                }
                ops.push(c);
                i++;
            }
        }
        else if(isdigit(c))
        {
            string number("");
            while(i < expression.length() && isdigit(expression[i]))
            {
                number += expression[i];
                i++;
            }
            float num = stof(number.c_str());
            nums.push(num);
        }
        else if(c == ' ')
        {
            i++;  // 忽略空格
        }
        else
        {
            cout << "Invalid input" << endl;
            return 0;
        }
    }

    while(!ops.empty())  // 处理剩余的运算符和数字
    {
        float num2 = nums.top();
        nums.pop();
        float num1 = nums.top();
        nums.pop();
        char op = ops.top();
        ops.pop();
        float result = calculate(num1, num2, op);
        nums.push(result);
    }

    if(nums.size() == 1)
    {
        cout << "表达式的结果为：" << nums.top() << endl;
    }
    else
    {
        cout << "Invalid input" << endl;
    }

    return 0;
}