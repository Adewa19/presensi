<?php

include "koneksi.php";

$id_klaim=$_POST['id'];

$json = array();

$query="SELECT * from klaim where id = '$id_klaim'  ";

$result = mysqli_query($KONEKSI,$query);
$data =mysqli_fetch_assoc($result);
$row = mysqli_num_rows($result);

if($row > 0){
    $id = $data['id'];
    $tanggal = $data['tanggal'];
    $tipe = $data['tipe'];
    $hubungan = $data['hubungan'];
    $nominal = $data['nominal'];
    $rumah_sakit = $data['rumah_sakit'];
    $keterangan = $data['keterangan']; 
    $file = $data['file'];

    $json = array('value'=> 1,'message'=> 'login berhasil',
                   'tanggal'=> $tanggal,'tipe'=>$tipe,'hubungan'=>$hubungan,
                   'nominal'=>$nominal,'rumah_sakit'=>$rumah_sakit,'keterangan'=>$keterangan,
                   'file'=>$file);
}else{
    $json = array('value'=> 0,'message'=> 'gagal','query'=> $query);
}

                 
echo json_encode($json);
mysqli_close($KONEKSI);