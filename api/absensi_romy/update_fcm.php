<?php

include "koneksi.php";

$fcmtoken=$_POST['fcmtoken'];
$nik=$_POST['nik'];

$json = array();

$query="UPDATE user SET fcm_token = '$fcmtoken' WHERE nik ='$nik' ";

$result = mysqli_query($KONEKSI,$query);

if($result){
	$json = array('value'=> 1,'message'=> 'Update berhasil' ,'query'=>$query);
}else{
	$json = array('value'=> 0,'message'=> 'Update gagal','query'=>$query);
}


echo json_encode($json);
mysqli_close($KONEKSI);