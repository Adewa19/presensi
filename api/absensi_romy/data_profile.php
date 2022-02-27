<?php
include "koneksi.php";

$json = array();

$nik = $_POST['nik'];

$query = "SELECT  karyawan.* , jabatan.nama as nama_jabatan 
          from karyawan LEFT JOIN user ON karyawan.nik = user.nik
          LEFT JOIN jabatan on jabatan.jabatan_id = user.jabatan_id
           WHERE karyawan.nik ='$nik'   ";

$execute = mysqli_query($KONEKSI, $query);
$count = mysqli_num_rows($execute);

if($count > 0){
    while($row=mysqli_fetch_assoc($execute)){
        $json[] = $row;
    }
}else{
    $json = array();
}

echo json_encode($json);
mysqli_close($KONEKSI);

?>