<?php
include "koneksi.php";

$q1 = "SELECT unit_id as kode_unit,nama as nama_unit  FROM view_combo_unit  ";

$exe = mysqli_query($KONEKSI, $q1);
while ($row = mysqli_fetch_assoc($exe)){
    $data_unit[] = $row;
}

echo json_encode($data_unit);
mysqli_free_result($exe);
mysqli_close($KONEKSI);