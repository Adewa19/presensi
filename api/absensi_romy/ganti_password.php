<?php

include "koneksi.php";

$nik = $_POST['nik'];
$passwordlama = $_POST['passwordlama'];
$passwordbaru = $_POST['passwordbaru'];
$passwordconfirm = $_POST['passwordconfirm'];


$passwordlama= mysqli_real_escape_string($KONEKSI, $passwordlama);
$passwordlama = str_replace(" ","",$passwordlama);

$passwordbaru= mysqli_real_escape_string($KONEKSI, $passwordbaru);
$passwordbaru = str_replace(" ","",$passwordbaru);

$passwordconfirm = mysqli_real_escape_string($KONEKSI, $passwordconfirm);
$passwordconfirm = str_replace(" ","",$passwordconfirm);

$query ="SELECT COUNT(*) as jml FROM user WHERE nik ='$nik' and password = md5('$passwordlama') ";
$result = mysqli_query($KONEKSI,$query);
$data = mysqli_fetch_assoc($result);
$jml  = $data['jml'];

if($jml == 0){
    $json = array('value'=> 0,'message'=> 'Maaf password lama anda salah !!!');
}else{
    if($passwordconfirm !== $passwordbaru ){
        $json = array('value'=> 0,'message'=> 'Maaf password baru dan password confirm tidak sama !!!');
    }else{
        $query ="UPDATE user Set password =md5('$passwordbaru') WHERE nik ='$nik' ";
        $result = mysqli_query($KONEKSI,$query);

        if($result){
            $json = array('value'=> 1,'message'=> 'Proses berhasil !!!');
        }else{
            $json = array('value'=> 0,'message'=> 'Proses gagal !!!');
        }
    }
}


echo json_encode($json);
mysqli_close($KONEKSI);