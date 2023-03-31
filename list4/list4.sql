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

SELECT nazwa AS najczesciej_zamawiany FROM ilosc_zamowionych
WHERE ilosc_zamowien = (SELECT MAX(ilosc_zamowien) FROM ilosc_zamowionych);

SELECT nazwa AS zamowiony_w_najwiekszej_lacznej_ilosci FROM ilosc_zamowionych
WHERE laczna_ilosc_zamowionych = (SELECT MAX(laczna_ilosc_zamowionych) FROM ilosc_zamowionych);
14.
