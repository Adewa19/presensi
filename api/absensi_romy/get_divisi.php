<?php
include "koneksi.php";

$q1 = "SELECT divisi_id as kode_divisi,nama as nama_divisi  FROM view_combo_divisi  ";

$exe = mysqli_query($KONEKSI, $q1);
while ($row = mysqli_fetch_assoc($exe)){
    $data_divisi[] = $row;
}

echo json_encode($data_divisi);
mysqli_free_result($exe);
mysqli_close($KONEKSI);