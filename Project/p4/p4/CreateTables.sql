---1---
CREATE TABLE Admin(
	Admin_ID int primary key identity(1, 1) NOT NULL, 
	FName varchar(100),
	LName varchar(100),
	UserName varchar(100) NOT NULL,
	Pass varchar(100) NOT NULL,
	PhoneNo bigInt
);

---2---
CREATE TABLE SalaryPeyment(
	SP_Code int identity(1, 1) NOT NULL, 
	Admin_Id int FOREIGN KEY REFERENCES Admin(Admin_ID) NOT NULL,
	Payment_Type varchar(100),
	Bank varchar(100),
	SP_Date date,
	Amount money,
	primary key(SP_Code, Admin_ID)

);

---3---
CREATE TABLE DrivingTraining(
	DT_Code int primary key identity(1, 1) NOT NULL, 
	Admin_Id int FOREIGN KEY REFERENCES Admin(Admin_ID) NOT NULL,
	DT_Name varchar(100),
	DT_Address varchar(100),
);

---4---
CREATE TABLE Registration(
	RG_Code int identity(1, 1) NOT NULL, 
	Admin_Id int FOREIGN KEY REFERENCES Admin(Admin_ID) NOT NULL,
	R_Date date,
	primary key(RG_Code, Admin_ID)
);

---5---
CREATE TABLE Training_Staff(
	TS_ID int primary key identity(1, 1) NOT NULL, 
	SSN bigint unique NOT NULL,
	RG_ID int NOT NULL,
	SP_ID int NOT NULL,
	Admin_ID int NOT NULL,
	FName varchar(100),
	LName varchar(100),
	Gender char,
	Img varchar(255),
	FOREIGN KEY (RG_ID,Admin_ID) REFERENCES Registration(RG_Code,Admin_ID),
	FOREIGN KEY (SP_ID,Admin_ID) REFERENCES SalaryPeyment(SP_Code,Admin_ID),
);



---6---
CREATE TABLE Teacher(
	TS_ID int primary key FOREIGN KEY REFERENCES Training_Staff(TS_ID) NOT NULL,
	Confirmation varchar(100),
	T_Type varchar(100),
);

---7---
CREATE TABLE Officer(
	TS_ID int primary key FOREIGN KEY REFERENCES Training_Staff(TS_ID) NOT NULL,
);

---8---
CREATE TABLE Health_Center(
	HC_ID int primary key identity(1, 1) NOT NULL, 
	HC_Address varchar(255),
	HC_Name varchar(100),
	Region varchar(100) NOT NULL,
	Registration_NO int NOT NULL,
);

---9---
CREATE TABLE Class(
	Class_ID int primary key identity(1, 1) NOT NULL,
	DT_Code int FOREIGN KEY REFERENCES DrivingTraIning(DT_Code) NOT NULL,
	Teacher_ID int FOREIGN KEY REFERENCES Teacher(TS_ID) NOT NULL,
	Class_Date date,
	Class_Time time,
	Class_Type varchar(100),
);

---10---
CREATE TABLE Exam(
	EXAM_ID int primary key identity(1, 1) NOT NULL,
	Class_ID int FOREIGN KEY REFERENCES Class(Class_ID) NOT NULL,
	Officer_ID int FOREIGN KEY REFERENCES Officer(TS_ID) NOT NULL,
	Exam_Date date,
	Exam_Time time,
	Exam_Type varchar(100)
);

---11---
CREATE TABLE Student(
	Student_ID int primary key identity(1, 1) NOT NULL, 
	SSN bigint unique NOT NULL,
	RG_ID int NOT NULL,
	Admin_ID int NOT NULL,
	FOREIGN KEY (RG_ID,Admin_ID) REFERENCES Registration(RG_Code,Admin_ID),
	HC_ID int FOREIGN KEY REFERENCES Health_Center(HC_ID) NOT NULL,
	FName varchar(100),
	LName varchar(100),
	S_Address varchar(255),
	PhoneNo bigInt,
	S_Birthday date NOT NULL,
	Gender char,
	Start_Course date,
	End_Course date,
);


---12---
CREATE TABLE Cardex(
	Student_ID int primary key FOREIGN KEY REFERENCES Student(Student_ID) NOT NULL,
	Practical_Exam_Result char,
	Theory_Exam_Result char,
);

---13---
CREATE TABLE EnrollClass(
	Class_ID int FOREIGN KEY REFERENCES Class(Class_ID) NOT NULL,
	Student_ID int FOREIGN KEY REFERENCES Student(Student_ID) NOT NULL,
	primary key(Class_ID, Student_ID)
);

---14---
CREATE TABLE TakeExam(
	Exam_ID int FOREIGN KEY REFERENCES Exam(Exam_ID) NOT NULL,
	Student_ID int FOREIGN KEY REFERENCES Student(Student_ID) NOT NULL,
	primary key(Exam_ID, Student_ID)
);






