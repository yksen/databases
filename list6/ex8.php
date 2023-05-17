<?php
echo "<form method='post'>
<input type='text' name='imie' placeholder='Imię'>
<input type='text' name='nazwisko' placeholder='Nazwisko'>
<input type='text' name='adres' placeholder='Adres'>
<input type='text' name='miasto' placeholder='Miasto'>
<input type='text' name='kod' placeholder='Kod pocztowy'>
<input type='text' name='telefon' placeholder='Telefon'>
<input type='text' name='email' placeholder='Email'>
<input type='submit' value='Wyślij'>
</form>";

if (!empty($_POST)) {
    $dane = array_map('strlen', $_POST);
    echo "Łączna długość wprowadzonych napisów: " . array_sum($dane);
}
