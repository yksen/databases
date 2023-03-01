1.
SELECT CURDATE();
2.
SELECT DAYNAME('2001-05-15');
3.
SELECT SUBSTRING(CONVERT(PI() + 0.00000000000, CHAR), 2 + 10, 1);
4.
SELECT SUBSTRING(CONVERT(EXP(1), CHAR), 2 + 8, 1);
5.
SELECT FLOOR(RAND()*6+1);
6.
SELECT nazwa, cena*ilosc AS wartosc FROM produkty;
7.
SELECT idk, nazwa, CONCAT(miasto, " ", TRIM(SUBSTRING_INDEX(adres, ".", -1))) AS skro
cony_adres, telefon FROM klienci;
8.
SELECT CONCAT_WS(", ", nazwa, adres, miasto, telefon) AS wizytowka FROM klienci;
9.
