use BANK
/*1*/
WITH AFZAYESH_95(id,afzayesh) as
(SELECT tb.Id,(tb.MandehAkhar95-tb.MandehAval95) as afzayesh
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.Gender=N'زن' 
GROUP BY tb.id,tb.MandehAkhar95-tb.MandehAval95)
SELECT TOP 1 a.id,a.afzayesh
FROM AFZAYESH_95 as a
ORDER BY a.afzayesh DESC
/*2*/
SELECT AVG(Sood95) as avg_for_IsTamin_Karfarma
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.IsTamin_Karfarma=1 
SELECT AVG(Sood95) as avg_for_Is_NOT_Tamin_Karfarma
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.IsTamin_Karfarma=0

SELECT AVG(Sood95) as avg_for_IsBimarkhas
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.IsBimarkhas=1 
SELECT AVG(Sood95) as avg_for_Is_NOT_IsBimarkhas
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.IsBimarkhas=0

SELECT AVG(Sood95) as avg_for_IsBimePardaz_Sandoghha
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.IsBimePardaz_Sandoghha=1 
SELECT AVG(Sood95) as avg_for_Is_NOT_IsBimePardaz_Sandoghha
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.IsBimePardaz_Sandoghha=0
/*3*/
SELECT tb.Id,(tb.Variz96/(SELECT AVG(Variz96) FROM ['500000FamilySample-990402$']))/(tb.Variz97/(SELECT AVG(Variz97) FROM ['500000FamilySample-990402$'])) as rate
FROM ['500000FamilySample-990402$'] as tb
GROUP by tb.Id,tb.Variz96,tb.Variz97
HAVING AVG(Variz96)>0 and AVG(Variz97)>0
ORDER BY (tb.Variz96/(SELECT AVG(Variz96) FROM ['500000FamilySample-990402$']))/(tb.Variz97/(SELECT AVG(Variz97) FROM ['500000FamilySample-990402$'])) DESC
/*4*/
SELECT COUNT(*) as number
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.IsBimePardaz_Sandoghha=1 and tb.Daramad_Total_Rials>1000000
GROUP by tb.IsBimePardaz_Sandoghha

/*5*/
;WITH tbl_w
AS(
SELECT tb.Id,tb.MandehAkhar97
FROM ['500000FamilySample-990402$'] as tb 
WHERE tb.Gender=N'زن'
)

SELECT tb2.Id,tb2.MandehAval97
FROM ['500000FamilySample-990402$'] as tb2 
WHERE tb2.Gender=N'مرد'

/*دو جدول بالا را کراس جوین می کنیم و برحسب تفاضل مانده حساب ها صورت می کنیم*/


/*6*/
SELECT top 1 tb.id,tb.Daramad_Total_Rials
FROM ['500000FamilySample-990402$'] as tb
WHERE tb.SenfName=N'مشاوره املاک و مستغلات'
ORDER by tb.Daramad_Total_Rials DESC
/*7*/
/*سال را به باکت های5 ساله تقسیم می کنیم و برحسب آن گروپ بای می کنیم سپس
sumسود را محاسبه می کنیم*/