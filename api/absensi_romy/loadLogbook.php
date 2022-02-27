

<?php
include "koneksi.php";

$nik = $_GET['nik'];
$limit = $_GET['limit'];
$page = $_GET['page']*$limit;


$q1 = "SELECT logbook.*,user.nama 
        FROM logbook LEFT JOIN user
        on logbook.nik = user.nik
       WHERE `status` = '0' AND  (logbook.nik ='$nik'  OR
       logbook.nik IN (SELECT nik FROM `user` 
                     WHERE user_id_induk IN (SELECT user_id FROM `user` WHERE nik ='$nik') ))   ORDER BY id Desc LIMIT $limit OFFSET $page   ";

// print_r($q1);

$exe = mysqli_query($KONEKSI, $q1);
$count = mysqli_num_rows($exe);

if($count > 0){
    while($row=mysqli_fetch_assoc($exe)){
        $json['results'][] = $row;
    }
}else{
    $json['results'] = array();
}

echo json_encode($json);
mysqli_close($KONEKSI);
