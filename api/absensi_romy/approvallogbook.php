<?php

include "koneksi.php";

$id=$_POST['id'];

$json = array();


$query="UPDATE sys_pesan SET `sudah_dibaca` = '1' WHERE id_flg_otorisasi ='$id' ";
$result = mysqli_query($KONEKSI,$query);

$query="UPDATE logbook SET `status` = '1' WHERE id ='$id' ";

$result = mysqli_query($KONEKSI,$query);

if($result){
	$json = array('value'=> 1,'message'=> 'Update berhasil');
}else{
	$json = array('value'=> 0,'message'=> 'Update gagal');
}


echo json_encode($json);
mysqli_close($KONEKSI);