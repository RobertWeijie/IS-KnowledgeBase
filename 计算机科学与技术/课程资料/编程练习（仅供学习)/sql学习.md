**sql 学习**

**越界一般都是打错字或者少打个逗号**


select
id,device_id,
gender,
age,
university,province
from user_profile;
现在运营想要查看用户信息表中所有的数据，请你取出相应结果

示例：user_profile
id	device_id	gender	age	university	province
1	2138	   male	    21	北京大学	    Beijing
2	3214	male	        复旦大学	   Shanghai
3	6543	female	20	    北京大学	    Beijing
4	2315	female	23	    浙江大学	   ZheJiang
5	5432	male	25	    山东大学	    Shandong

现在运营同学想要用户的设备id对应的性别、年龄和学校的数据，请你取出相应数据
select device_id,gender,age,university
from user_profile

现在运营需要查看用户来自于哪些学校，请从用户信息表中取出学校的去重数据。
select distinct university//distinct 就是去重的意思
from user_profile

现在运营只需要查看前2个用户明细设备ID数据，请你从用户信息表 user_profile 中取出相应结果。
select device_id
from user_profile limit 2


现在你需要查看前2个用户明细设备ID数据，并将列名改为 'user_infos_example',，请你从用户信息表取出相应结果。
select device_id as user_info_example
from user_profile limit 2


现在运营想要筛选出所有北京大学的学生进行用户调研，请你从用户信息表中取出满足条件的数据，结果返回设备id和学校。
select device_id,university
from user_profile
where university = '北京大学'

现在运营想要针对24岁以上的用户开展分析，请你取出满足条件的设备ID、性别、年龄、学校。
select device_id,gender,age,university
from user_profile
where age > 24

现在运营想要针对20岁及以上且23岁及以下的用户开展分析，请你取出满足条件的设备ID、性别、年龄。
select device_id,gender,age
from user_profile
where age >= 20 and age <= 23

现在运营想要查看除复旦大学以外的所有用户明细，请你取出相应数据
select device_id,gender,age,university
from user_profile
where university not in('复旦大学')


现在运营想要对用户的年龄分布开展分析，在分析时想要剔除没有获取到年龄的用户，请你取出所有年龄值不为空的用户的设备ID，性别，年龄，学校的信息。

select device_id,gender,age,university
from user_profile
where age is not null



现在运营想要找到男性且GPA在3.5以上(不包括3.5)的用户进行调研，请你取出相关数据。
select device_id,gender,age,university,gpa
from user_profile
where gender ='male' and gpa > 3.5;

现在运营想要找到学校为北大或GPA在3.7以上(不包括3.7)的用户进行调研，请你取出相关数据（使用OR实现
select device_id,gender,age,university,gpa
from user_profile
where university = '北京大学' or gpa > 3.7

现在运营想要找到学校为北大、复旦和山大的同学进行调研，请你取出相关数据。
select device_id,gender,age,university,gpa
from user_profile
where university ='北京大学' or university ='复旦大学' or university ='山东大学'


现在运营想要找到gpa在3.5以上(不包括3.5)的山东大学用户 或 gpa在3.8以上(不包括3.8)的复旦大学同学进行用户调研，请你取出相应数据
select device_id,gender,age,university,gpa
from user_profile
where university ='山东大学' and gpa > 3.5 or university = '复旦大学' and gpa >3.8

现在运营想查看所有大学中带有北京的用户的信息，请你取出相应数据
select device_id,age,university
from user_profile
where university like "%北京%" //北京%即为从以北京为开头


营想要知道复旦大学学生gpa最高值是多少，请你取出相应数据
select round(max(gpa),1)
from user_profile
where university ='复旦大学' // 1 代表小数点 round 就是遍历max 最高那个

现在运营想要看一下男性用户有多少人以及他们的平均gpa是多少，用以辅助设计相关活动，请你取出相应数据
-- 选取用户的性别和GPA，统计数量和平均值
select count(gender), round(avg(gpa), 1)
-- 从名为 'user_profile' 的表中选取数据
from user_profile
-- 只选取性别为 'male' 的用户
where gender = 'male'
-- 按照性别进行分组
group by gender;



现在运营想要对每个学校不同性别的用户活跃情况和发帖数量进行分析，请分别计算出每个学校每种性别的用户数、30天内平均活跃天数和平均发帖数量。


用户信息表：user_profile
30天内活跃天数字段（active_days_within_30）
发帖数量字段（question_cnt）
回答数量字段（answer_cnt）


现在运营想要对每个学校不同性别的用户活跃情况和发帖数量进行分析，请分别计算出每个学校每种性别的用户数、30天内平均活跃天数和平均发帖数量。


用户信息表：user_profile
30天内活跃天数字段（active_days_within_30）
发帖数量字段（question_cnt）
回答数量字段（answer_cnt）


select gender,university,count(gender) as user_num,// user_num 代表用户数量
avg(active_days_within_30) as avg_active_days,//该组用户平均的活跃天数
avg(question_cnt) as avg_question_cnt//该组用户平均的提问数量。

from user_profile
group by university,gender;//按照大学和性别进行分组


现在运营想查看每个学校用户的平均发贴和回帖情况，寻找低活跃度学校进行重点运营，请取出平均发贴数低于5的学校或平均回帖数小于20的学校。
select university,
avg(question_cnt) as avg_question_cnt,
avg(answer_cnt) as avg_answer_cnt

from user_profile
group by university
having avg_question_cnt < 5 or avg_answer_cnt <20; //having 是筛选的意思


现在运营想要查看不同大学的用户平均发帖情况，并期望结果按照平均发帖情况进行升序排列，请你取出相应数据
select university,
avg(question_cnt) as avg_question_cnt
from user_profile
group by university
order by avg_question_cnt


现在运营想要查看所有来自浙江大学的用户题目回答明细情况，请你取出相应数据
-- 选择用户的设备 ID、题目 ID 和题目结果
SELECT u.device_id, q.question_id, q.result
-- 从名为 'question_practice_detail' 和 'user_profile' 的表中选取数据
FROM question_practice_detail q, user_profile u
-- 筛选出所在大学为 '浙江大学' 的用户
WHERE university = '浙江大学'
-- 连接两个表，匹配设备 ID
AND q.device_id = u.device_id;


运营想要了解每个学校答过题的用户平均答题数量情况，请你取出数据。

用户信息表 user_profile，其中device_id指终端编号（认为每个用户有唯一的一个终端），gender指性别，age指年龄，university指用户所在的学校，gpa是该用户平均学分绩点，active_days_within_30是30天内的活跃天数。


select university,
count(question_id)/count(distinct(q.device_id))as avg_answer_cnt//选择大学和平均每个用户回答问题的数量
from user_profile u join question_practice_detail q on u.device_id = q.device_id//从 'user_profile' 表和 'question_practice_detail' 表中选取数据
group by university




运营想要计算一些参加了答题的不同学校、不同难度的用户平均答题量，请你写SQL取出相应数据

select university, difficult_level,    -- 选择学校和难度级别
count(qpd.question_id)/count(distinct qpd.device_id) as avg_answer_cnt  -- 计算平均答题数
from user_profile up,                  -- 在用户档案表中选择数据，表别名为up
question_practice_detail qpd,          -- 在题目练习详情表中选择数据，表别名为qpd
question_detail qd                    -- 在题目详情表中选择数据，表别名为qd
where up.device_id = qpd.device_id     -- 通过设备ID将用户档案表和题目练习详情表中的数据进行关联
and qpd.question_id = qd.question_id  -- 通过题目ID将题目练习详情表和题目详情表中的数据进行关联
group by university, difficult_level  -- 按照学校和难度级别进行分组


运营想要查看参加了答题的山东大学的用户在不同难度下的平均答题题目数，请取出相应数据

select u.university,q2.difficult_level,count(q1.question_id)/count(distinct q1.device_id)//该难度级别下平均每个用户回答的题目数量。

// 从 'user_profile' 表、'question_practice_detail' 表和 'question_detail' 表中选取数据
from user_profile u
inner join question_practice_detail q1 on u.device_id = q1.device_id
inner join question_detail q2 on q1.question_id = q2.question_id

group by u.university,q2.difficult_level
having u.university ='山东大学'



在运营想要分别查看学校为山东大学或者性别为男性的用户的device_id、gender、age和gpa数据，请取出相应结果，结果不去重。
select device_id,gender,age,gpa 
from user_profile 
where university = '山东大学'
union all // union all 不去重
select device_id,gender,age,gpa
from user_profile 
where gender = 'male'



现在运营想要将用户划分为25岁以下和25岁及以上两个年龄段，分别查看这两个年龄段用户数量
本题注意：age为null 也记为 25岁以下

select if(age >=25,'25岁及以上','25岁以下') as age_cut,
count(device_id) as number
from user_profile
group by age_cut


现在运营想要将用户划分为20岁以下，20-24岁，25岁及以上三个年龄段，分别查看不同年龄段用户的明细情况，请取出相应数据。（注：若年龄为空请返回其他。）
select device_id,gender,
case
when age< 20 then '20岁及以下'
when age < 25 then '20-24岁'
when age>= 25 then '25岁及以上'
else '其他'
end age_cut
from user_profile


现在运营想要计算出2021年8月每天用户练习题目的数量，请取出相应数据。
select day(date) as day,               -- 选择日期中的日，并将其重命名为day
count(question_id) as question_cnt     -- 计算每天的题目数量
from question_practice_detail          -- 在题目练习详情表中选择数据
where date like '2021-08%'             -- 筛选出日期为2021年8月份的数据
group by day(date)                     -- 按照日期中的日进行分组


在运营想要查看用户在某天刷题后第二天还会再来刷题的平均概率。请你取出相应数据。

-- 计算连续两天都有做题记录的用户占所有有做题记录的用户的比例
SELECT COUNT(DISTINCT q2.device_id, q2.date)/COUNT(DISTINCT q1.device_id, q1.date) AS avg_ret_count
-- 从 'question_practice_detail' 表中选取数据
FROM question_practice_detail AS q1
-- 使用左外连接，连接满足条件的记录
LEFT OUTER JOIN question_practice_detail AS q2 ON q1.device_id = q2.device_id AND DATEDIFF(q2.date, q1.date) = 1;



现在运营举办了一场比赛，收到了一些参赛申请，表数据记录形式如下所示，现在运营想要统计每个性别的用户分别有多少参赛者，请取出相应结果
示例：user_submit
device_id	profile	blog_url
2138	180cm,75kg,27,male	http:/url/bigboy777
3214	165cm,45kg,26,female	http:/url/kittycc
6543	178cm,65kg,25,male	http:/url/tiger
4321	171cm,55kg,23,female	http:/url/uhksd
2131	168cm,45kg,22,female	http:/urlsydney


SELECT -- 选择查询列
SUBSTRING_INDEX(profile, ',', -1) AS gender, -- 获取最后一个逗号后面的子字符串作为性别，并将其命名为 gender//substring是返回字符串str从第n个字符截取到第m个字符
COUNT(device_id) -- 计算设备 ID 的数量
FROM user_submit -- 数据来源于 user_submit 表
GROUP BY SUBSTRING_INDEX(profile, ',', -1); -- 按照性别进行分组// string_index 返回字符substr在str中第n次出现位置之前的字符串;


对于申请参与比赛的用户，blog_url字段中url字符后的字符串为用户个人博客的用户名，现在运营想要把用户的个人博客用户字段提取出单独记录为一个新的字段，请取出所需数据。

select device_id,
replace (blog_url,'http:/url/' ,'')
from user_submit



现在运营举办了一场比赛，收到了一些参赛申请，表数据记录形式如下所示，现在运营想要统计每个年龄的用户分别有多少参赛者，请取出相应结果

select substring_index(substring_index(profile,',',-2),',',1) as age,   -- 选择年龄段，并将其重命名为age
count(device_id) as number                                             -- 计算每个年龄段的设备数量
from user_submit                                                       -- 在用户提交表中选择数据
group by age                                                           -- 按照年龄段进行分组

现在运营想要找到每个学校gpa最低的同学来做调研，请你取出每个学校的最低gpa。

select device_id,university,gpa

from user_profile u
where gpa =(select min(gpa)
from user_profile 
where university = u.university)
order by university


现在运营想要了解复旦大学的每个用户在8月份练习的总题目数和回答正确的题目数情况，请取出相应明细数据，对于在8月份没有练习过的用户，答题数结果返回0.

select u.device_id,u.university,count(q.question_id) as question_cnt,
sum(case when result = 'right' then 1 else 0 end) as right_question_cnt

from user_profile u
left join question_practice_detail q
using(device_id)
WHERE university = '复旦大学' AND (MONTH(date) = 8 OR MONTH(date) IS NULL)

group by device_id



现在运营想要了解浙江大学的用户在不同难度题目下答题的正确率情况，请取出相应数据，并按照准确率升序输出

select difficult_level,
count(if(result='right',1,null)) / count(result) as correct_rate
from user_profile up
join question_practice_detail using(device_id)
join question_detail using(question_id)
where university='浙江大学'
group by difficult_level
order by correct_rate


现在运营想要取出用户信息表中的用户年龄，请取出相应数据，并按照年龄升序排序。
select device_id,age
from user_profile
order by age 


现在运营想要取出用户信息表中的年龄和gpa数据，并先按照gpa升序排序，再按照年龄升序排序输出，请取出相应数据


现在运营想要取出用户信息表中对应的数据，并先按照gpa、年龄降序排序输出，请取出相应数据。
select device_id,gpa,age
from user_profile
order by gpa desc,age desc//desc代表降序


现在运营想要了解2021年8月份所有练习过题目的总用户数和练习过题目的总次数，请取出相应结果
select count(distinct device_id) as did_cnt,    -- 计算8月份答题的设备数量，并将其重命名为did_cnt
count(device_id) as question_cnt                 -- 计算8月份的题目数量，并将其重命名为question_cnt
from question_practice_detail                     -- 在题目练习详情表中选择数据
where month(date) = 8 and year(date) = 2021       -- 筛选出日期为2021年8月份的数据



查找最晚入职员工的所有信息
select * from employees 
where hire_date = (select max(hire_date)from employees)
//* 用作一个简写，表示选择"employees"表格中的所有列
//hire_rate 表示最大的日期

查找入职员工时间排名倒数第三的员工所有信息
select * from employees
where hire_date=(select distinct hire_date from employees order by hire_date desc limit 2,1)
//2 表示跳过前两个行， 1 表示返回一个行作为结果。因此，这个子查询会返回排在第三个的不同的入职日
//desc 降序排序

查找当前薪水详情以及部门编号dept_no
select s.*,d.dept_no
from salaries as s
join dept_manager as d
on s.emp_no = d.emp_no
where s.to_date = '9999-01-01' and d.to_date = '9999-01-01'

查找所有已经分配部门的员工的last_name和first_name以及dept_no，未分配的部门的员工不显示
select e.last_name,e.first_name,d.dept_no 
from employees e ,dept_emp d
where e.emp_no = d.emp_no


查找所有已经分配部门的员工的last_name和first_name以及dept_no，也包括暂时没有分配具体部门的员工
select e.last_name,e.first_name,d.dept_no  -- 选择员工的姓、名和部门编号
from employees e                           -- 在员工表中选择数据，表别名为e
left join dept_emp d                       -- 与员工部门关系表进行左连接，表别名为d
on e.emp_no = d.emp_no                     -- 通过员工编号将员工表和员工部门关系表中的数据进行关联

请你查找薪水记录超过15条的员工号emp_no以及其对应的记录次数t
select emp_no,count(emp_no) as t
from salaries
group by emp_no having t > 15


找出所有员工具体的薪水salary情况，对于相同的薪水只显示一次,并按照逆序显示
select distinct salary from salaries
where to_date = '9999-01-01' 
order by salary desc
//相同薪水显示一次，则使用SELECT DISTINCT可去除重复值
//要求逆序排列，则在最后应使用ORDER BY salary DESC

找出所有非部门领导的员工emp_no
select emp_no from employees
where emp_no not in (select emp_no from dept_manager)


获取所有的员工和员工对应的经理，如果员工本身是经理的话则不显示
select e.emp_no,m.emp_no manager
from dept_emp e join dept_manager m on e.dept_no = m.dept_no
where e.to_date = '9999-01-01' and m.to_date = '9999-01-01' and e.emp_no != m.emp_no


获取每个部门中当前员工薪水最高的相关信息，给出dept_no, emp_no以及其对应的salary，按照部门编号dept_no升序排列
select d.dept_no,s.emp_no,s.salary maxSalary  -- 选择部门编号、员工编号和最高薪水
from salaries s                              -- 从工资表中选择数据，表别名为s
join dept_emp d on d.emp_no=s.emp_no         -- 在员工-部门关联表中选择数据，表别名为d，通过员工编号关联工资表中的数据
where (d.dept_no,s.salary) in (              -- 筛选出符合条件的数据
select d.dept_no,max(s.salary)over(partition by d.dept_no) t_max  -- 使用子查询找出每个部门中的最高薪水，并为结果命名为t_max
from salaries s                          -- 在工资表中选择数据，表别名为s
join dept_emp d on d.emp_no=s.emp_no     -- 在员工-部门关联表中选择数据，表别名为d，通过员工编号关联工资表中的数据
)
order by d.dept_no                          -- 按照部门编号升序排序结果


employees表所有emp_no为奇数，且last_name不为Mary的员工信息，并按照hire_date逆序排列
select * from employees
where emp_no % 2 = 1 and last_name !='Mary'
order by hire_date desc;



统计出各个title类型对应的员工薪水对应的平均工资avg。结果给出title以及平均工资avg，并且以avg升序排序
select t.title, avg(s.salary) as avg   -- 选择职称和平均工资，将平均工资列重命名为avg
from titles as t                       -- 从职称表中选择数据，表别名为t
inner join salaries as s               -- 与工资表进行内连接，表别名为s
on t.emp_no=s.emp_no                   -- 通过emp_no将职称表和工资表中的数据进行关联
group by title                         -- 按照职称进行分组
order by avg asc;                      -- 按照平均工资升序排序结果



请你获取薪水第二多的员工的emp_no以及其对应的薪水salary，
若有多个员工的薪水为第二多的薪水，则将对应的员工的emp_no和salary全部输出，并按emp_no升序排序。

select emp_no,salary from salaries     -- 选择员工编号和薪水
where to_date = '9999-01-01'            -- 筛选出当前在职的员工
and salary =                           -- 筛选出符合以下条件的员工
(select distinct salary            -- 从工资表中选择不重复的薪水
from salaries                     -- 在工资表中选择数据
order by salary desc limit 1,1)   -- 按照薪水降序排序，选择第二高的薪水


查找薪水排名第二多的员工编号emp_no、薪水salary、last_name以及first_name，不能使用order by完成，以上例子输出为:
（温馨提示:sqlite通过的代码不一定能通过mysql，因为SQL语法规定，使用聚合函数时，select子句中一般只能存在以下三种元素：常数、聚合函数，group by 指定的列名。如果使用非group by的列名，sqlite的结果和mysql 可能不一样)

select e.emp_no,s.salary,e.last_name,e.first_name
from employees e
join
salaries s on e.emp_no = s.emp_no 
and s.to_date ='9999-01-01'
and s.salary =(select max(salary)
from salaries
where salary <(select max(salary)
from salaries
where to_date = '9999-01-01')
and to_date ='9999-01-01'
)



