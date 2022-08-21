/*Admin*/
Insert Into Admin
	values ('Ghazal', 'Bakhshande', 'GhazalB', '13456','09129876756');
Insert Into Admin
	values ('yasmin', 'madani', 'yasi', '1234','09120000000');

/*DrivingTraining*/
Insert Into DrivingTraining
	values ('1', 'Shamim', 'malard, fardis');

/*SalaryPeyment*/
Insert Into SalaryPeyment
	values ('1', 'cash', 'Saman', '2004-04-30', '5000000');
Insert Into SalaryPeyment
	values ('1', 'cash', 'Saderat', '2007-03-5', '5000000');
Insert Into SalaryPeyment
	values ('1', 'card', 'Melli', '2015-08-31', '8000000');
Insert Into SalaryPeyment
	values ('1', 'card', 'Mellat', '2021-06-30', '7500000');
Insert Into SalaryPeyment
	values ('1', 'check', 'Pasargad', '2019-12-25', '4800000');

/*Registration*/
Insert Into Registration
	values ('1', '2020-04-05');
Insert Into Registration
	values ('1', '2021-05-31');
Insert Into Registration
	values ('1', '2015-08-30');
Insert Into Registration
	values ('1', '2017-01-01');
Insert Into Registration
	values ('1', '2007-06-23');
Insert Into Registration
	values ('2', '2020-10-25');
Insert Into Registration
	values ('2', '2021-06-14');
Insert Into Registration
	values ('2', '2020-08-15');

/*Training_Staff*/
Insert Into Training_Staff
	values ('21687534567', '1', '1', '1','Mahoor', 'Rezayi', 'w', 'src\mahoorrezayi.jpg');
Insert Into Training_Staff
	values ('21687515329', '2', '2', '1','Mahdi', 'Nemati', 'm', 'src\mahdinemati.jpg');
Insert Into Training_Staff
	values ('21687535329', '3', '3', '1','Parsa', 'Naderi', 'm', 'src\parsanaderi.jpg');
Insert Into Training_Staff
	values ('21687535670', '4', '4', '1','Marzie', 'Sadeghi', 'w', 'src\marziesadeghi.jpg');
Insert Into Training_Staff
	values ('21687535656', '5', '5', '1','Aria', 'Kazemi', 'm', 'src\ariakazemi.jpg');
Insert Into Training_Staff
	values ('21687535656', '5', '5', '1','Aria', 'Kazemi', 'm', 'src\ariakazemi.jpg');

/*Teacher*/
Insert Into Teacher
	values ('1', 'yyyy', 'theory');
Insert Into Teacher
	values ('2', 'yyyy', 'practical');
Insert Into Teacher
	values ('4', 'yyyy', 'practical');

/*Officer*/
Insert Into Officer
	values ('3');
Insert Into Officer
	values ('5');

/*Health_Center*/
Insert Into Health_Center
	values ('tehran, narmak', 'Alghadir', '4', '1258');
Insert Into Health_Center
	values ('tehran, azadi', 'bahman', '9', '1428');

/*Class*/
Insert Into Class
	values ('1', '1', '2021-04-30', '3:30:00.000','theory');
Insert Into Class
	values ('1', '2', '2021-05-12', '6:00:00.000','practical');
Insert Into Class
	values ('1', '4', '2021-11-08', '18:00:00.000','practical');

/*Exam*/
Insert Into Exam
	values ('1', '3', '2021-12-21', '9:00:00.000','theory');
Insert Into Exam
	values ('1', '5', '2021-05-21', '11:00:00.000','theory');
Insert Into Exam
	values ('2', '3', '2021-11-13', '17:30:00.000','practical');
Insert Into Exam
	values ('2', '5', '2021-11-04', '17:30:00.000','practical');
Insert Into Exam
	values ('3', '5', '2021-12-1', '17:30:00.000','practical');

/*Student*/
Insert Into Student
	values ('22687214329', '1', '1', '1','Melika', 'Nazari', 'saadat abad', '09124568765', '2000-04-07', 'w', '2021-04-24', '2021-06-10');
Insert Into Student
	values ('22687267129', '2', '1', '1','Melina', 'Naseri', 'piroozi', '09124568787', '2001-06-05', 'w', '2021-06-09', '2021-07-26');
Insert Into Student
	values ('22681667129', '3', '1', '1','Samiar', 'Sameti', 'narmak', '09126168787', '2002-10-19', 'm', '2021-08-21', '2021-10-05');
Insert Into Student
	values ('22681667122', '4', '1', '2','Omid', 'Khaheghi', 'azadi', '09126478787', '1999-10-19', 'm', '2021-08-21', '2021-10-05');
Insert Into Student
	values ('22681667145', '1', '1', '2','Sepehr', 'Zargari', 'enghelab', '09125668787', '2001-10-19', 'm', '2013-08-21', '2013-10-05');
Insert Into Student
	values ('22681667146', '2', '1', '2','Yasaman', 'Keyvani', 'AmirAbad', '09126168787', '2000-07-09', 'w', '2021-08-21', '2021-10-05');
Insert Into Student
	values ('22681667452', '5', '1', '2','Negar', 'Rooshan', 'farjam', '09126161487', '1998-05-19', 'w', '2020-08-21', '2021-01-05');
Insert Into Student
	values ('22681667367', '4', '1', '1','bahar', 'Gholami', 'narmak', '09126168700', '1987-03-19', 'w', '2021-08-21', '2021-10-05');

/*Cardex*/
Insert Into Cardex
	values ('1', '', '');
Insert Into Cardex
	values ('2', '', '');
Insert Into Cardex
	values ('3', 'F', 'P');
Insert Into Cardex
	values ('4', 'F', 'P');
Insert Into Cardex
	values ('5', 'P', 'P');
Insert Into Cardex
	values ('6', 'F', 'P');
Insert Into Cardex
	values ('7', 'P', 'P');
Insert Into Cardex
	values ('8', '', 'F');

/*TakeExam*/
Insert Into TakeExam
	values ('1', '4');
Insert Into TakeExam
	values ('1', '5');
Insert Into TakeExam
	values ('1', '6');
Insert Into TakeExam
	values ('1', '7');
Insert Into TakeExam
	values ('1', '8');
Insert Into TakeExam
	values ('2', '4');
Insert Into TakeExam
	values ('2', '7');
Insert Into TakeExam
	values ('3', '1');
Insert Into TakeExam
	values ('3', '4');
Insert Into TakeExam
	values ('3', '8');
Insert Into TakeExam
	values ('4', '2');
Insert Into TakeExam
	values ('5', '3');

/*EnrollClass*/
Insert Into EnrollClass
	values ('1', '1');
Insert Into EnrollClass
	values ('1', '2');
Insert Into EnrollClass
	values ('1', '3');
Insert Into EnrollClass
	values ('2', '1');
Insert Into EnrollClass
	values ('3', '2');
Insert Into EnrollClass
	values ('3', '3');





