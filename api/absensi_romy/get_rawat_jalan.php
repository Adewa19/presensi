<?php
include "koneksi.php";

$nik = $_POST['nik'];

$query ="SELECT COUNT(*) as jml FROM user_approval WHERE nik = '$nik' ";
$exe = mysqli_query($KONEKSI, $query);
$data=mysqli_fetch_assoc($exe);
$jml = $data['jml'];

if($jml > 0){
    $parameter ="";
}else{
    $parameter = "AND klaim.nik ='$nik' ";
}

$q1 = "SELECT klaim.*,user.nama FROM klaim left join user 
       on klaim.nik = user.nik 
       WHERE klaim.status = '0' $parameter
        ORDER BY id Desc  ";

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
