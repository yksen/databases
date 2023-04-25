1.
CREATE VIEW wszystko_klienci AS
SELECT klienci.nazwa AS k_nazwa, miasto, adres, telefon, zamow.*, detal_zamow.*, produkty.nazwa AS p_nazwa, cena, ilosc FROM klienci
JOIN zamow ON klienci.idk = zamow.k_id
JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
JOIN produkty ON detal_zamow.p_id = produkty.idp;
CREATE VIEW wszystko_produkty AS
SELECT klienci.nazwa AS k_nazwa, miasto, adres, telefon, zamow.*, detal_zamow.*, produkty.nazwa AS p_nazwa, cena, ilosc FROM klienci
RIGHT JOIN zamow ON klienci.idk = zamow.k_id
RIGHT JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
RIGHT JOIN produkty ON detal_zamow.p_id = produkty.idp;
3.
SELECT k_nazwa AS klienci_zamowili_laptop_i_tablet
FROM wszystko_klienci
GROUP BY k_id
HAVING COUNT(IF(p_nazwa = "laptop", 1, NULL)) > 0
   AND COUNT(IF(p_nazwa = "tablet", 1, NULL)) > 0;
4.
SELECT knazwa
FROM wszyscy_klienci
WHERE cena > ANY (
   SELECT cena
   FROM produkty
   WHERE nazwa LIKE "%laptop%"
)
GROUP BY idk;
5.
SELECT pnazwa
FROM wszystkie_produkty
WHERE knazwa < (
   SELECT MIN(nazwa)
   FROM klienci
   WHERE miasto = "Warszawa"
)
GROUP BY idp;
6.
CREATE VIEW wartosci_zamowien AS
SELECT klienci.nazwa, SUM(sztuk * cena) AS wartosc_zamowien FROM klienci
JOIN zamow ON klienci.idk = zamow.k_id
JOIN detal_zamow ON zamow.idz = detal_zamow.z_id
JOIN produkty ON detal_zamow.p_id = produkty.idp
GROUP BY klienci.nazwa;

SELECT w1.nazwa
FROM wartosci_zamowien AS w1
JOIN wartosci_zamowien AS w2 ON w1.wartosc_zamowien > w2.wartosc_zamowien AND w2.nazwa = 'Astro'
WHERE w1.nazwa != 'Astro';
7.
SELECT nazwa
FROM produkty
WHERE cena > 2 * (
   SELECT AVG(cena)
   FROM produkty
);

SELECT nazwa
FROM produkty
WHERE cena > 2 * (
   SELECT SUM(cena * ilosc)/SUM(ilosc)
   FROM produkty
);

SELECT nazwa
FROM produkty
WHERE cena > 2 * (
   SELECT SUM(cena * lacznie)/SUM(lacznie)
   FROM (
      SELECT cena, SUM(sztuk) AS lacznie
      FROM produkty
      LEFT JOIN detal_zamow ON idp = p_id
      GROUP BY idp
   ) AS foo
);
8.
SELECT YEAR(data), WEEKOFYEAR(data), AVG(wartosc)
FROM (
   SELECT data, SUM(cena * sztuk) AS wartosc
   FROM zamow
   JOIN detal_zamow ON idz = z_id
   JOIN produkty ON idp = p_id
   GROUP BY idz
) AS foo
GROUP BY 1, 2;
9.
CREATE VIEW wartosci_zamowien_klientow AS
SELECT idk, knazwa AS nazwa, IFNULL(SUM(cena * sztuk), 0) AS wartosc
FROM wszyscy_klienci
GROUP BY idk;

SELECT nazwa
FROM wartosci_zamowien_klientow
WHERE wartosc >= ALL (
   SELECT wartosc
   FROM wartosci_zamowien_klientow
);
10.
CREATE VIEW ilosc_zamowionych AS
SELECT produkty.nazwa, COUNT(*) AS ilosc_zamowien, SUM(sztuk) AS laczna_ilosc_zamowionych FROM produkty
JOIN detal_zamow ON produkty.idp = detal_zamow.p_id
GROUP BY produkty.nazwa;

SELECT i1.nazwa AS najczesciej_zamawiany
FROM ilosc_zamowionych AS i1
LEFT JOIN ilosc_zamowionych AS i2 ON i1.ilosc_zamowien < i2.ilosc_zamowien
WHERE i2.ilosc_zamowien IS NULL;

SELECT i1.nazwa AS zamowiony_w_najwiekszej_lacznej_ilosci
FROM ilosc_zamowionych AS i1
LEFT JOIN ilosc_zamowionych AS i2 ON i1.laczna_ilosc_zamowionych < i2.laczna_ilosc_zamowionych
WHERE i2.laczna_ilosc_zamowionych IS NULL;
11.
CREATE VIEW produkty_w_dniach AS
SELECT idp, nazwa, DATE(data) AS dzien, SUM(cena * sztuk) AS wartosc
FROM produkty
JOIN detal_zamow ON idp = p_id
JOIN zamow ON idz = z_id
GROUP BY 1, 3;

SELECT nazwa, dzien
FROM produkty_w_dniach AS super
WHERE wartosc = (
   SELECT MAX(wartosc)
   FROM produkty_w_dniach
   WHERE dzien = super.dzien
);
12.
CREATE VIEW ostatnie_zamowienia_klientow_z_miast AS
SELECT miasto, idk, nazwa, MAX(data) AS data
FROM klienci
LEFT JOIN zamow ON idk = k_id
GROUP BY 1, 2;

SELECT miasto, nazwa, data
FROM ostatnie_zamowienia_klientow_z_miast AS super
WHERE data = (
   SELECT MAX(data)
   FROM ostatnie_zamowienia_klientow_z_miast
   WHERE miasto = super.miasto
);
13.
CREATE VIEW produkty_klientow AS
SELECT idk, knazwa, pnazwa, IFNULL(SUM(cena * sztuk), 0) AS wartosc
FROM wszyscy_klienci
GROUP BY 1, idp;

SELECT knazwa, pnazwa
FROM produkty_klientow AS super
WHERE wartosc = (
   SELECT MAX(wartosc)
   FROM produkty_klientow
   WHERE idk = super.idk
);
14.
SELECT nazwa
FROM produkty
WHERE idp NOT IN (SELECT p_id FROM detal_zamow);
15.
SELECT nazwa
FROM klienci
WHERE idk NOT IN (
   SELECT k_id
   FROM zamow
   WHERE idz IN (
      SELECT z_id
      FROM detal_zamow
   )
);
16.
SELECT *
FROM zamow
WHERE idz NOT IN (
   SELECT z_id
   FROM detal_zamow
);
17.
SELECT *
FROM zamow AS super
WHERE (
   SELECT COUNT(*)
   FROM zamow
   WHERE data > super.data
) < 3;
18.
SELECT COUNT(DISTINCT z_id)
FROM detal_zamow
JOIN produkty ON idp = p_id
WHERE ilosc = (
   SELECT MAX(ilosc)
   FROM produkty
)
GROUP BY p_id;
19.
SELECT klienci.nazwa, COUNT(DISTINCT idp)
FROM klienci
LEFT JOIN zamow ON idk = k_id
LEFT JOIN detal_zamow ON idz = z_id
LEFT JOIN (
   SELECT *
   FROM produkty
   WHERE cena > 1500
) AS foo ON idp = p_id
GROUP BY idk
ORDER BY 2 DESC;
20.
SELECT produkty.nazwa, COUNT(DISTINCT idk)
FROM produkty
LEFT JOIN detal_zamow ON idp = p_id
LEFT JOIN zamow ON idz = z_id
LEFT JOIN (
   SELECT *
   FROM klienci
   WHERE miasto LIKE "W%"
) AS foo ON idk = k_id
GROUP BY idp
ORDER BY 2 DESC;