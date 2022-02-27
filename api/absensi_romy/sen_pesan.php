<?PHP

include "koneksi.php";

$user_id = $_POST['user_id'];

$query ="SELECT fcm_token FROM `user` WHERE user_id ='$user_id'  ";
$result = mysqli_query($KONEKSI,$query);
$data  = mysqli_fetch_assoc($result);
$fcm_token = $data['fcm_token'];


function sendMessage($fcm_token){
    $content = array(
        "en" => 'Selammat datang di Aplikasiku Jangan lupa subscribe yah',
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

    return $response;
}

$response = sendMessage($fcm_token);
$return["allresponses"] = $response;
$return = json_encode( $return);
?>