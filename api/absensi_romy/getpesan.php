<?php
include "koneksi.php";

$user_id = $_POST['user_id'];

$query = "SELECT fcm_token FROM user where user_id ='$user_id' ";
$exe = mysqli_query($KONEKSI, $query);
$data=mysqli_fetch_assoc($exe);
$fcm_token = $data['fcm_token'];

$query ="SELECT COUNT(*) as jml FROM sys_pesan WHERE user_id = '$user_id' AND sudah_dibaca = '0' ";
$exe = mysqli_query($KONEKSI, $query);
$data=mysqli_fetch_assoc($exe);
$jml = $data['jml'];

if($jml > 0){

    $query = "SELECT * FROM sys_pesan WHERE user_id = '$user_id' AND sudah_dibaca = '0' ";
    $exe = mysqli_query($KONEKSI, $query);
    while($data = mysqli_fetch_assoc($exe)){

        $pesan = $data['pesan'];

        $content = array(
            "en" => $pesan,
        );
    
        $fields = array(
            'app_id' => "9c1a698f-3f93-439f-b2ed-890624451631",
            'include_player_ids' => array("$fcm_token"),
            'data' => array("foo" => "bar"),
            'large_icon' =>"ic_launcher_round.png",
            'contents' => $content
        );
    
        $fields = json_encode($fields);
    
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json; charset=utf-8',
                                                   'Authorization: Basic NzliZWQ4YWUtNTM0NS00NGMzLThjMDctYTFhNGE4NDBhNTg2'));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);    
    
        $response = curl_exec($ch);
        curl_close($ch);
    }
}



$json = array('notifikasi'=> $jml,'query_sys'=>$query,'fcm_token'=>$fcm_token);

echo json_encode($json);
mysqli_close($KONEKSI);