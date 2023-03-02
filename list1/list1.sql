1.
SELECT DAYOFYEAR(CURDATE());
2.
SELECT WEEKDAY("2001-05-15");
3.
SELECT RIGHT(CONVERT(TRUNCATE(PI()*1e10, 0), CHAR), 1);
4.
SELECT RIGHT(CONVERT(TRUNCATE(EXP(1)*1e8, 0), CHAR), 1);
5.
SELECT FLOOR(RAND()*6+1);
6.
SELECT nazwa, cena*ilosc AS wartosc FROM produkty;
7.
SELECT idk, nazwa, miasto, CONCAT(TRIM(SUBSTRING_INDEX(adres, ".", -1))) AS skrocony_adres, telefon FROM klienci;
8.
SELECT CONCAT_WS(", ", nazwa, adres, miasto, telefon) AS wizytowka FROM klienci;
9.
