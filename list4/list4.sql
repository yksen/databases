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
14.
SELECT nazwa
FROM produkty
WHERE idp NOT IN (SELECT p_id FROM detal_zamow);