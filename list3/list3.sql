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
SELECT YEAR(data) AS rok, MONTH(data) AS miesiac, SUM(cena * ilosc) AS wartosc
FROM zamow
JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
JOIN produkty ON detal_zamow.p_id = produkty.idp
GROUP BY YEAR(data), MONTH(data)
ORDER BY wartosc DESC;