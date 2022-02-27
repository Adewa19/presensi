<?php
include "koneksi.php";

$nik= $_POST['nik'];
$nama= strtoupper($_POST['nama']);
$noidentitas= $_POST['noidentitas'];
$tempatlahir= $_POST['tempatlahir'];
$tgllahir= $_POST['tgllahir'];
$hp= $_POST['hp'];
$alamat= $_POST['alamat'];
$agama= $_POST['agama'];
$kota= $_POST['kota'];
$provinsi= $_POST['provinsi'];
$negara= $_POST['negara'];
$kelamin= $_POST['kelamin'];

$json = array();

$query="UPDATE karyawan SET 
            nik = '$nik',
            nama = '$nama',
            no_identitas = '$noidentitas',
            tmp_lahir = '$tempatlahir',
            tgl_lahir = '$tgllahir',
            hp = '$hp',
            alamat = '$alamat',
            agama = '$agama',
            kota = '$kota',
            propinsi = '$provinsi',
            negara = '$negara',
            kelamin = '$kelamin'
WHERE nik ='$nik' ";

$result = mysqli_query($KONEKSI,$query);

if($result){
	$json = array('value'=> 1,'message'=> 'Update berhasil' ,'query'=>$query);
}else{
	$json = array('value'=> 0,'message'=> 'Update gagal','query'=>$query);
}


echo json_encode($json);
mysqli_close($KONEKSI);

?>