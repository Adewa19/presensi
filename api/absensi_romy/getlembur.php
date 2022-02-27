<?php
include "koneksi.php";

$nik = $_POST['nik'];

$q1 = "SELECT lembur.*,user.nama 
        FROM lembur LEFT JOIN user
        on lembur.nik = user.nik
       WHERE `status` = '0' AND (lembur.nik ='$nik'  OR
       lembur.nik IN (SELECT nik FROM `user` 
                     WHERE user_id_induk IN (SELECT user_id FROM `user` WHERE nik ='$nik') ))   ORDER BY id Desc  ";

$exe = mysqli_query($KONEKSI, $q1);
$count = mysqli_num_rows($exe);

if($count > 0){
    while($row=mysqli_fetch_assoc($exe)){
        $json[] = $row;
    }
}else{
    $json = array();
}

echo json_encode($json);
mysqli_close($KONEKSI);
