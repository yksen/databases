<?php
echo "<form method='post'>
<input type='text' name='imie' placeholder='Imię'>
<input type='text' name='nazwisko' placeholder='Nazwisko'>
<select name='zainteresowania[]' multiple>
<option value='sport'>Sport</option>
<option value='muzyka'>Muzyka</option>
<option value='filmy'>Filmy</option>
<option value='ksiazki'>Książki</option>
<option value='gry'>Gry</option>
</select>
<select name='przedmioty[]' multiple>
<option value='php'>PHP</option>
<option value='java'>Java</option>
<option value='c++'>C++</option>
<option value='c#'>C#</option>
<option value='python'>Python</option>
</select>
<select name='rok'>
<option value='1'>1</option>
<option value='2'>2</option>
<option value='3'>3</option>
</select>
<input type='submit' value='Wyślij'>
</form>";

if (!empty($_POST['imie']) && !empty($_POST['nazwisko']) && !empty($_POST['rok'])) {
    $imie = $_POST['imie'];
    $nazwisko = $_POST['nazwisko'];
    $zainteresowania = $_POST['zainteresowania'];
    $przedmioty = $_POST['przedmioty'];
    $rok = $_POST['rok'];
    echo "Student $rok. roku $imie $nazwisko";
    if (!empty($przedmioty) && !empty($zainteresowania)) {
        echo " lubi zajęcia z ";
        echo implode(", ", $przedmioty);
        echo ", a w wolnym czasie uprawia ";
        echo implode(", ", $zainteresowania);
    } else if (!empty($przedmioty)) {
        echo " lubi zajęcia z ";
        echo implode(", ", $przedmioty);
    } else if (!empty($zainteresowania)) {
        echo " w wolnym czasie uprawia ";
        echo implode(", ", $zainteresowania);
    }
    echo ".";
}
