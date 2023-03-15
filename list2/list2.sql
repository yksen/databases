1.
SELECT * FROM klienci, produkty;
2.
SELECT zamow.*, detal_zamow.sztuk FROM zamow INNER JOIN detal_zamow ON zamow.idz = detal_zamow.z_id;
3.
SELECT produkty.nazwa, detal_zamow.sztuk FROM detal_zamow INNER JOIN produkty ON detal_zamow.p_id = produkty.idp;
4.
SELECT produkty.cena * detal_zamow.sztuk AS wartosc FROM detal_zamow INNER JOIN produkty ON detal_zamow.p_id = produkty.idp ORDER BY wartosc DESC;
5.
SELECT detal_zamow.sztuk FROM detal_zamow INNER JOIN zamow ON detal_zamow.z_id = zamow.idz WHERE TIME(zamow.data) > "12:00:00";
6.
SELECT MONTHNAME(zamow.data) AS miesiac FROM zamow INNER JOIN klienci ON zamow.k_id = klienci.idk WHERE klienci.miasto != "Wrocław";
7.
SELECT produkty.cena 
FROM zamow 
INNER JOIN detal_zamow ON zamow.idz = detal_zamow.z_id 
INNER JOIN produkty ON detal_zamow.p_id = produkty.idp 
WHERE WEEKDAY(zamow.data) = 4;
8.
SELECT klienci.nazwa
FROM klienci
INNER JOIN zamow ON klienci.idk = zamow.k_id
INNER JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
WHERE detal_zamow.sztuk > 4
ORDER BY klienci.miasto DESC;
9.
SELECT klienci.adres
FROM klienci
INNER JOIN zamow ON klienci.idk = zamow.k_id
INNER JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
INNER JOIN produkty ON detal_zamow.p_id = produkty.idp
WHERE produkty.nazwa LIKE "%laptop%"
ORDER BY REVERSE(klienci.nazwa);
10.
SELECT produkty.nazwa
FROM klienci
INNER JOIN zamow ON klienci.idk = zamow.k_id
INNER JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
INNER JOIN produkty ON detal_zamow.p_id = produkty.idp
WHERE klienci.telefon LIKE "%4%"
ORDER BY produkty.cena;
11.
SELECT *
FROM klienci
NATURAL JOIN produkty;
12.
SELECT klienci.nazwa, DATE(zamow.data) AS data
FROM klienci
LEFT JOIN zamow ON klienci.idk = zamow.k_id
ORDER BY DATE(zamow.data);
13.
SELECT produkty.nazwa, klienci.miasto
FROM zamow
RIGHT JOIN klienci ON zamow.k_id = klienci.idk
RIGHT JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
RIGHT JOIN produkty ON detal_zamow.p_id = produkty.idp;
14.
SELECT produkty.nazwa
FROM produkty
LEFT JOIN detal_zamow ON produkty.idp = detal_zamow.p_id
WHERE detal_zamow.z_id IS NULL;
15.
SELECT klienci.nazwa
FROM klienci
LEFT JOIN zamow ON klienci.idk = zamow.k_id
LEFT JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
WHERE detal_zamow.p_id IS NULL;
16.
SELECT *
FROM zamow
LEFT JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
WHERE detal_zamow.p_id IS NULL;
17.
SELECT COUNT(z_id) FROM detal_zamow WHERE p_id = (SELECT idp FROM produkty WHERE ilosc = (SELECT MAX(ilosc) FROM produkty));