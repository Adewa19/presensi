
<?php

// $KONEKSI = mysqli_connect('202.157.186.209:3307','NY7oJP4o3JMC','QSmpa55XDA4');
// $DATABASE= mysqli_select_db($KONEKSI,'hc');

$KONEKSI = mysqli_connect('localhost:3306','root','');
$DATABASE= mysqli_select_db($KONEKSI,'hc_rommy');

if(!$KONEKSI){
    die("Koneksi Gagal : ". mysqli_connect_error());
}

?>