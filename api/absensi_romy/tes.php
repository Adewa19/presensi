<?php
$url = 'https://absensidroid.000webhostapp.com/api/absensi/profile/'.'';


if (@getimagesize($url)) {
echo  "image exists ";
} else {
echo  "image does not exist ";
}
?>

<!-- 
function URLIsValid($URL)
{
    $exists = true;
    $file_headers = @get_headers($URL);
    $InvalidHeaders = array('404', '403', '500');
    foreach($InvalidHeaders as $HeaderVal)
    {
            if(strstr($file_headers[0], $HeaderVal))
            {
                    $exists = false;
                    break;
            }
    }
    return $exists;
}

$hasil = URLIsValid($urlfoto);

print_r($hasil); -->
