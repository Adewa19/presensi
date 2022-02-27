<?php

include "koneksi.php";

$id=$_POST['id'];
$catatan=$_POST['catatan'];

$json = array();

$query="UPDATE logbook SET catatan = '$catatan' WHERE  id ='$id' ";

$result = mysqli_query($KONEKSI,$query);

if($result){
	$json = array('value'=> 1,'message'=> 'Update berhasil');
}else{
	$json = array('value'=> 0,'message'=> 'Update gagal');
}


echo json_encode($json);
mysqli_close($KONEKSI);