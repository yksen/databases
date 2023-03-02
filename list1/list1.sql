1.
SELECT DAYOFYEAR(CURDATE());
2.
SELECT WEEKDAY("2001-05-15");
3.
SELECT RIGHT(CONVERT(TRUNCATE(PI() * 1e10, 0), CHAR), 1);
4.
SELECT RIGHT(CONVERT(TRUNCATE(EXP(1) * 1e8, 0), CHAR), 1);
5.
SELECT FLOOR(RAND() * 6 + 1);
6.
SELECT nazwa, cena*ilosc AS wartosc FROM produkty;
7.
SELECT idk, nazwa, miasto, CONCAT(TRIM(SUBSTRING_INDEX(adres, ".", -1))) AS skrocony_adres, telefon FROM klienci;
8.
SELECT CONCAT_WS(", ", nazwa, adres, miasto, telefon) AS wizytowka FROM klienci;
9.
SELECT nazwa, JSON_OBJECT("zlotych", TRUNCATE(cena, 0), "groszy", ROUND((cena - TRUNCATE(cena, 0)) * 100, 0)) AS cena FROM produkty;
10.
SELECT idz, DATE_SUB(DATE_ADD(data, INTERVAL 1 MONTH), INTERVAL IF(WEEKDAY(data) > 4, (WEEKDAY(data) - 1) % 3, 0) DAY) AS najpozniejsza_data, data FROM zamow;
11.
SELECT nazwa FROM klienci WHERE miasto NOT LIKE "W%";
12.
SELECT nazwa FROM klienci WHERE SUBSTR(nazwa, 1, CEIL(CHAR_LENGTH(nazwa) / 2)) LIKE "%s%";
13.
SELECT * FROM zamow WHERE WEEKDAY(data) % 4 = 0;
14.
SELECT * FROM zamow WHERE TIME(data) > "16:00:00";
15.
SELECT nazwa FROM produkty WHERE nazwa NOT LIKE "%Apple%";
16.
SELECT nazwa FROM klienci WHERE adres LIKE "Marszałkowska%";
17.
SELECT miasto FROM klienci WHERE CHAR_LENGTH(adres) > 15;
18.
SELECT nazwa, IF(cena > 1500, cena / 12 * 0.1, NULL) AS wysokosc_raty FROM produkty;
19.
SELECT COUNT(z_id) FROM detal_zamow WHERE p_id = (SELECT idp FROM produkty WHERE ilosc = (SELECT MAX(ilosc) FROM produkty));