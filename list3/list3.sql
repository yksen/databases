1.
SELECT SUM(cena * ilosc) AS wartosc FROM produkty;
2.
SELECT GROUP_CONCAT(nazwa ORDER BY nazwa ASC SEPARATOR ", ") AS nazwy FROM klienci;
3.
SELECT DATEDIFF(MAX(zamow.data), MIN(zamow.data)) AS interwal
FROM zamow
JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
JOIN produkty ON detal_zamow.p_id = produkty.idp
WHERE produkty.nazwa LIKE "%Samsung%";
4.
SELECT DAYNAME(data) AS dzien, COUNT(DISTINCT(k_id)) AS ilosc_zamowien
FROM zamow
JOIN klienci ON zamow.k_id = klienci.idk
GROUP BY DAYNAME(data)
ORDER BY ilosc_zamowien DESC;
5.
SELECT YEAR(data) AS rok, MONTHNAME(data) AS miesiac, SUM(cena * sztuk) AS wartosc
FROM zamow
JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
JOIN produkty ON detal_zamow.p_id = produkty.idp
GROUP BY YEAR(data), MONTHNAME(data)
ORDER BY wartosc DESC;
6.
SELECT CEILING(cena / 1000) * 1000, JSON_ARRAYAGG(nazwa)
FROM produkty
GROUP BY 1
ORDER BY 1;
7.
SELECT nazwa
FROM produkty
JOIN detal_zamow ON idp = p_id
GROUP BY idp
HAVING SUM(cena * sztuk) > 7000
ORDER BY 1 ASC;
8.
SELECT klienci.nazwa
FROM klienci
JOIN zamow ON idk = k_id
JOIN detal_zamow ON idz = z_id
JOIN produkty ON idp = p_id
WHERE cena > 1800
GROUP BY idk
HAVING SUM(sztuk) > 1
ORDER BY 1 ASC;
9.
SELECT nazwa, AVG(sztuk)
FROM produkty
JOIN detal_zamow ON idp = p_id
JOIN zamow ON idz = z_id
GROUP BY idp
HAVING BIT_OR(WEEKDAY(data) = 4)
ORDER BY 2 DESC;
10.
SELECT nazwa, COUNT(DISTINCT idz)
FROM klienci
LEFT JOIN zamow ON idk = k_id
GROUP BY idk
ORDER BY 2 DESC;
11.
SELECT produkty.nazwa, IFNULL(SUM(detal_zamow.sztuk), 0) AS liczba_zamowionych
FROM produkty
LEFT JOIN detal_zamow ON produkty.idp = detal_zamow.p_id
GROUP BY produkty.nazwa
ORDER BY liczba_zamowionych DESC;
12.
SELECT klienci.miasto, IFNULL(SUM(detal_zamow.sztuk), 0) AS liczba_zamowionych
FROM klienci
LEFT JOIN zamow ON klienci.idk = zamow.k_id
LEFT JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
GROUP BY klienci.miasto
ORDER BY liczba_zamowionych DESC;
13.
SELECT klienci.nazwa, klienci.miasto, IFNULL(SUM(produkty.cena * detal_zamow.sztuk), 0) AS wartosc_zamowien
FROM klienci
LEFT JOIN zamow ON klienci.idk = zamow.k_id
LEFT JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
LEFT JOIN produkty ON detal_zamow.p_id = produkty.idp
GROUP BY klienci.nazwa, klienci.miasto
ORDER BY wartosc_zamowien DESC;
14.
SELECT data, SUM(cena * sztuk)
FROM zamow
LEFT JOIN detal_zamow ON idz = z_id
LEFT JOIN produkty ON idp = p_id
GROUP BY idz
ORDER BY 2 DESC;
15.
SELECT klienci.nazwa, COUNT(DISTINCT idp)
FROM klienci
LEFT JOIN zamow ON idk = k_id
LEFT JOIN detal_zamow ON idz = z_id
LEFT JOIN produkty ON (idp = p_id AND cena > 1500)
GROUP BY idk
ORDER BY 2 DESC;
16.
SELECT produkty.nazwa, COUNT(DISTINCT idk)
FROM produkty
LEFT JOIN detal_zamow ON idp = p_id
LEFT JOIN zamow ON idz = z_id
LEFT JOIN klienci ON (idk = k_id AND miasto LIKE "W%")
GROUP BY idp
ORDER BY 2 DESC;
17.
SELECT z1.*
FROM zamow z1
JOIN zamow z2 ON z1.data <= z2.data
GROUP BY z1.idz
HAVING COUNT(z2.idz) <= 3
ORDER BY data;