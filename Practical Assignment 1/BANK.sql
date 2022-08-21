use BANK
/*1*/
select *
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE T_bank.Gender=N'مرد' and T_bank.Bardasht95>=250000000
/*2*/
select DISTINCT T_bank.SenfName 
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE  T_bank.SenfName IS NOT NULL
/*3*/
select T_bank.Id ,T_bank.ProvinceName
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE  T_bank.ProvinceName=N'گیلان' or T_bank.ProvinceName=N'خراسان رضوی'
ORDER BY (T_bank.Id ) DESC
/*4*/
SELECT T_bank.Id,(T_bank.Sood97-T_bank.Sood95) as increased_amount
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE T_bank.Sood95<T_bank.Sood96 and T_bank.Sood96<T_bank.Sood97
ORDER BY T_bank.Id
/*5*/
SELECT DISTINCT T_bank.Daramad_Total_Rials
FROM dbo.['500000FamilySample-990402$'] as T_bank
WHERE DATEDIFF(year,T_bank.BirthDate,GETDATE())=56
ORDER BY  T_bank.Daramad_Total_Rials
/*6*/
SELECT DISTINCT T_bank.SenfName 
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE  T_bank.SenfName IS NOT NULL and T_bank.SenfName  LIKE  N'%ش%' 
/*7*/
SELECT DISTINCT T_bank.Id,T_bank.Gender,T_bank.CountyName,Gender_ENG=
  CASE T_bank.Gender 
         WHEN N'مرد' THEN 'Mr'   
         ELSE 'Miss/Mrs'  
      END
FROM dbo.['500000FamilySample-990402$'] as T_bank  
/*8*/
SELECT *
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE T_bank.Bardasht95<T_bank.Variz95 and T_bank.Bardasht96<T_bank.Variz96 and T_bank.Bardasht97<T_bank.Variz97
ORDER BY T_bank.Id DESC
/*9*/
SELECT T_bank.Id,T_bank.CountyName, ABS(T_bank.Bardasht96-T_bank.Bardasht97) as difrence 
From dbo.['500000FamilySample-990402$'] as T_bank
ORDER BY ABS(T_bank.Bardasht96-T_bank.Bardasht97) DESC

/*10*/
SELECT  DISTINCT TOP 1  T_bank.Id,T_bank.CountyName, T_bank.Daramad_Total_Rials,T_bank.CarPrice_Sum,T_bank.Cars_Count,T_bank.CarPrice_Sum
From dbo.['500000FamilySample-990402$'] as T_bank
	inner join dbo.['500000FamilySample-990402$'] t1 ON
	t1.Cars_Count=T_bank.Cars_Count
	ORDER BY T_bank.CarPrice_Sum DESC

/*11*/
SELECT*
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE T_bank.Cars_Count> (SELECT AVG(t1.Cars_Count)
							From dbo.['500000FamilySample-990402$'] t1)
/*12*/
SELECT*
From dbo.['500000FamilySample-990402$'] as T_bank
WHERE T_bank.Sood97> (SELECT AVG(t1.Sood97)
							From dbo.['500000FamilySample-990402$'] t1) and T_bank.Sood97>T_bank.Sood96
ORDER BY T_bank.Id