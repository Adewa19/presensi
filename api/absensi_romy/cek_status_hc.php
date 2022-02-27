<?php
include "koneksi.php";

$nik = $_POST['nik'];
$id  = $_POST['id'];

$query_sys ="UPDATE sys_pesan SET sudah_dibaca = '1' WHERE id_flg_otorisasi = '$id' ";
$exe = mysqli_query($KONEKSI, $query_sys);

$query ="SELECT COUNT(*) as jml FROM user_approval WHERE nik = '$nik' ";
$exe = mysqli_query($KONEKSI, $query);
$data=mysqli_fetch_assoc($exe);
$jml = $data['jml'];



$json = array('status_approval'=> $jml,'query_sys'=>$query_sys);

echo json_encode($json);
mysqli_close($KONEKSI);