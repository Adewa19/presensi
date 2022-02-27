<?php
include "koneksi.php";

$q1 = "SELECT kode_kantor,nama_area_kerja as  nama_kantor FROM app_kode_kantor  ";

$exe = mysqli_query($KONEKSI, $q1);
while ($row = mysqli_fetch_assoc($exe)){
    $data_kantor[] = $row;
}

echo json_encode($data_kantor);
mysqli_free_result($exe);
mysqli_close($KONEKSI);