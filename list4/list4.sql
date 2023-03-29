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
