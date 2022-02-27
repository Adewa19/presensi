<?php
include "koneksi.php";

$q1 = "SELECT jabatan_id as kode_jabatan,nama as nama_jabatan  FROM view_jabatan  ";

$exe = mysqli_query($KONEKSI, $q1);
while ($row = mysqli_fetch_assoc($exe)){
    $data_jabatan[] = $row;
}

echo json_encode($data_jabatan);
mysqli_free_result($exe);
mysqli_close($KONEKSI);