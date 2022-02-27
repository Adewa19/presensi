

<?php
include "koneksi.php";

$user_id = $_GET['user_id'];
$limit = $_GET['limit'];
$page = $_GET['page']*$limit;


$q1 = "SELECT * FROM sys_pesan WHERE user_id ='$user_id' and sudah_dibaca = 0  ORDER BY id Desc LIMIT $limit OFFSET $page   ";

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
