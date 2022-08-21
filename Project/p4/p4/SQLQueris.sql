

/*Table Changes and add Constrains*/


Create database DrivingTraining;


Alter Table Student Add bloodGroup varchar(100);


Alter Table Student Drop Column bloodGroup;


Alter Table Student
	Add Check(DATEDIFF(YY, S_Birthday, GETDATE()) > 18);


Alter Table Student
	Add Check(DATEDIFF(DD, Start_Course, End_Course) > 25);


Alter Table SalaryPeyment
	Add Check(Amount > 200000);


Alter Table Admin
	Add Check(PhoneNo IS NOT NULL);


Alter Table Student
	Add Check(S_Birthday IS NOT NULL);


Alter Table SalaryPeyment
	Add Check(Amount IS NOT NULL);


Alter Table Health_Center
	Add Check(Region IS NOT NULL);


Alter Table Teacher
	Add Check(Confirmation = 'yyyy');


Alter table SalaryPeyment
	Add Default 'Melli' for Bank;


Alter table SalaryPeyment
	Add Default '4000000' for Amount;


Alter table Training_Staff
	Add Default 'src/unknown.jpg' for Img;


Alter table Exam
	Add Default 'Theory' for Exam_Type;


Alter table Class
	Add Default 'Theory' for Class_Type;


Alter Table Admin
	Add Constraint uniquness unique(UserName);


Alter Table Training_Staff Alter Column SSN BigInt;


Alter Table Training_Staff
	Add Constraint uniquness unique(SSN);


Create Index index_StudentName
		On Student (FName);


Create Index index_StaffName
		On Training_Staff (FName);


Alter Table Student Alter Column SSN BigInt;


Alter Table Student Add Unique(SSN);


Truncate table Training_Staff;


Drop database DrivingTraining;






/*Queries*/


/*1*/
/*hameye student hayi ke name kuchakeshan ba S shoru mishavad*/

SELECT FName, LName, PhoneNo
FROM Student
WHERE FName LIKE 'S%';



/*2*/
/*baraye sabte name student ha dar azmune amali name kamele student hayi ke azmune theory ra ghabul shodand mikhahim*/

SELECT FName, LName as FullName
FROM Student S, Cardex C
WHERE S.Student_ID = C.Student_ID
AND
C.Theory_Exam_Result = 'P'



/*3*/
/*nam va name khanevadegi studenti ra mukhahim ke az hame sene bishtari darad*/

SELECT Fname, Lname, DATEDIFF(YY, S_Birthday, GETDATE())
FROM Student
WHERE DATEDIFF(YY, S_Birthday, GETDATE()) 
IN 
(SELECT MAX(DATEDIFF(YY, S_Birthday, GETDATE()))
												FROM Student
												WHERE Gender = 'm')											



/*4*/
/*nam va name khanevadegi va sabeghe kare Teacher hayi ra mikhahim ke sabeghe kareshan dar in driving training bish az 3 sal ast*/

SELECT FName, LName, DATEDIFF(YY, R.R_Date, GETDATE()) AS Exprience
FROM Teacher T, Registration R, Training_Staff TF
WHERE R.RG_Code = TF.RG_ID
AND
T.TS_ID = TF.TS_ID
AND
DATEDIFF(YY, R.R_Date, GETDATE()) > 3;



/*5*/
/*liste type va ostade ameye class haye driving traning ba code 1*/
SELECT C.Class_Type, C.Class_Date, TS.LName, TS.Img
FROM Training_Staff TS, Teacher T, Class C
WHERE TS.TS_ID = T.TS_ID
AND
C.Teacher_ID = T.TS_ID
AND
C.DT_Code = 1;



/*6*/
/*nam va gender va salary hameye Teacher hayi ke salary anha bishtar az 4 milion ast*/

SELECT FName, TF.Gender, S.Amount AS Salary
FROM Teacher T, SalaryPeyment S, Training_Staff TF
WHERE S.SP_Code = TF.SP_ID
AND
T.TS_ID = TF.TS_ID
AND
S.Amount > 4000000;



/*7*/
/*be ezaye har exam, name kamele afsare emtehan girande, type exam va tarikhe exam ra be tartibe tarikhe exam be surate nozuli list konad*/

SELECT T.FName + ' ' + T.LName AS Fullname, E.Exam_Type, E.Exam_Date
FROM Exam E, Officer O, Training_Staff T
WHERE T.TS_ID = O.TS_ID
AND
E.Officer_ID = O.TS_ID
ORDER BY E.Exam_Date DESC;



/*8*/
/*code melli va zamane shorue course va zamane payane course ra baraye daneshjuyani ke mitavanand govahi nameye khod ra daryaft konand benevisad*/

select S.SSN, S.Start_Course, S.End_Course
FROM Student S INNER JOIN Cardex C 
				ON  S.Student_ID = C.Student_ID
WHERE C.Practical_Exam_Result = 'P'
AND
C.Theory_Exam_Result = 'P'



/*9*/
/*baraye har student natije Theory Exam va Practical Exam dar sotun haye jodagane be surate PASS ya FAIL benevisad*/

SELECT LName, PhoneNo, Theory_Exam = CASE C.Theory_Exam_Result
WHEN 'P' THEN 'PASS'
WHEN 'F' THEN 'FAIL'
ELSE '-'
END,
Practical_Exam = CASE C.Theory_Exam_Result
WHEN 'P' THEN 'PASS'
WHEN 'F' THEN 'FAIL'
ELSE '-'
END
FROM Student S, Cardex C
WHERE S.Student_ID = C.Student_ID



/*10*/
/*baraye student hayi ke dar teye 2 sale gozashte dar classe ranandegi sabte nam kardeand name kamel be hamrahe mr ya miss-mrs avale nameshan tebghe gender,
va tedade mah haye gozashte az tarikhe sabte nam ra benevisad*/

SELECT Student_Name = CASE S.Gender
WHEN 'm' THEN 'Miss/Mrs '
ELSE 'Mr '
END + S.FName + ' ' + S.LName,
DATEDIFF(MM, R.R_Date, GETDATE()) AS Month_Count
FROM Student S, Registration R
WHERE S.RG_ID = R.RG_Code
AND
DATEDIFF(YY, R.R_Date, GETDATE()) < 2



/*11*/
/*code melli va last name va tarikhe emtehane amali ra baraye student hayi ke emtehane theory ra pass shodeand benevisad*/

select S.SSN, S.LName AS Last_name, E.Exam_Date AS Practical_Exam
FROM Student S INNER JOIN Cardex C 
				ON C.Student_ID = S.Student_ID
				INNER JOIN TakeExam T
				ON  S.Student_ID = T.Student_ID
				INNER JOIN EXAM E
				ON E.EXAM_ID = T.Exam_ID
WHERE E.Exam_Type = 'Practical' 
AND 
C.Theory_Exam_Result = 'P'



/*12*/
/*نام و نام خانوادگی هنرآموزان , نوع و تاریخ کلاس آن ها*/

SELECT S.FName+S.LName AS FName, c.Class_Type,c.Class_Date
FROM EnrollClass e
INNER JOIN Class c 
on c.Class_ID=e.Class_ID
INNER JOIN Student S 
on S.Student_ID=e.Student_ID



/*13*/
/*مجموع مبلغ پرداخت ها به صورت نقدی*/

SELECT SUM(sp.Amount) AS SumOFSalaries
FROM SalaryPeyment sp
WHERE Payment_Type='cash'
GROUP BY sp.Amount



/*14*/
/*میانگین حقوق استاد های کلاس عملی را بنویسد*/

SELECT AVG(S.Amount) AS AVGOfSalaries
FROM Training_Staff TS INNER JOIN Teacher T 
						ON TS.TS_ID = T.TS_ID
						INNER JOIN SalaryPeyment S
						ON TS.SP_ID = S.SP_Code
WHERE T.T_Type = 'Practical'



/*adress darmangah ra baraye honarjooyani ke dar hich emtehani sherkat nakarde and chap konad*/
/*15*/
SELECT DISTINCT S.FName,S.LName ,hc.HC_Address
FROM Health_Center hc,Student S,Cardex c
WHERE c.Student_ID=S.Student_ID
and (c.Practical_Exam_Result=''
and c.Theory_Exam_Result='')
and s.HC_ID=hc.HC_ID



/*16*/
/*name ,code meli va gensiyat karmandani ke nagsh moalem ra darand*/

SELECT ts.FName,ts.LName,ts.SSN,ts.Gender
FROM Training_Staff ts 
INNER JOIN Teacher t 
on t.TS_ID=ts.TS_ID



/*17*/
/*nam danesh amoozani ke dar roozhayi ke i ke  admin shomare 1 masol sabt nam boode ast hozoor dashtand*/

SELECT s.FName,s.LName,rg.R_Date
FROM Registration rg  INNER JOIN Student s on s.RG_ID=rg.RG_Code
where rg.Admin_ID='1'



/*18*/
/*tabdil english be farsi baraye noe pardakht*/

SELECT payment_persian = CASE s.Payment_Type
WHEN 'check' THEN N'چک'
WHEN 'cash' THEN N'نقدی'
WHEN 'card' THEN N'کارت'
ELSE '-'
END
FROM SalaryPeyment s



/*19*/
/*famili va shomare telephon honarjooyan kelas 1 ra list konad*/

SELECT DISTINCT s.LName,s.PhoneNo
FROM EnrollClass en INNER JOIN Class c 
					on c.Class_ID=en.Class_ID
					INNER JOIN Student s 
					on s.Student_ID=en.Class_ID
where c.Class_ID='1'



/*20*/
/*adress va name honarjooyan ba shomare meli zoj*/

SELECT s.FName,s.SSN,s.S_Address
FROM Student s
where s.SSN % 2=0



















