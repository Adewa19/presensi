<?php

include "koneksi.php";

$id=$_POST['id'];
$nik=$_POST['nik'];
$tanggal = $_POST['tgl'];
$jam  = $_POST['jam'];

$waktu = $tanggal." ".$jam;

$json = array();

$query="UPDATE nik_import2 SET waktu_absensi = '$waktu' WHERE nik ='$nik' AND id ='$id' ";

$result = mysqli_query($KONEKSI,$query);

if($result){
	$json = array('value'=> 1,'message'=> 'Update berhasil');
}else{
	$json = array('value'=> 0,'message'=> 'Update gagal');
}


echo json_encode($json);
mysqli_close($KONEKSI);