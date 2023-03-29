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