<?php

$to = "dade8450-cc66-467d-a9e4-442771759edc";
$title = "Approval PRF";
$message = "Mohon di appprove yah";
$img = "https://kreditmandiri.co.id/api_test/absensi/gedung.jpg";
// $img = "";



$msg = $message;
$content = array(
    "en" => $msg
);
$headings = array(
    "en" => $title
);

if ($img == '') {
    $fields = array(
        'app_id' => '9c1a698f-3f93-439f-b2ed-890624451631',
        "headings" => $headings,
        'include_player_ids' => array($to),
        'large_icon' => "https://kreditmandiri.co.id/api_test/absensi/gedung.jpg",
        'content_available' => true,
        'contents' => $content
    );
} else {
    $ios_img = array(
        "id1" => $img
    );
    $fields = array(
        'app_id' => '9c1a698f-3f93-439f-b2ed-890624451631',
        "headings" => $headings,
        'include_player_ids' => array($to),
        'contents' => $content,
        "big_picture" => $img,
        'large_icon' => "https://kreditmandiri.co.id/api_test/absensi/gedung.jpg",
        'content_available' => true,
        "ios_attachments" => $ios_img
    );

}
$headers = array(
    'Authorization: key=NzliZWQ4YWUtNTM0NS00NGMzLThjMDctYTFhNGE4NDBhNTg2',
    'Content-Type: application/json; charset=utf-8'
);

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'https://onesignal.com/api/v1/notifications');
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
$result = curl_exec($ch);
curl_close($ch);

return $result;



?>