<?php
include "koneksi.php";

$json = array();

$nik = $_POST['nik'];
$tanggal = $_POST['tgl'];
list($day,$bln, $thn) = explode("-",$tanggal);
$tanggal = $thn."-".$bln."-".$day;

$query = "SELECT a.id,
            DATE(a.waktu_absensi) AS tanggal,
            TIME(a.waktu_absensi) AS jam,
            (CASE WHEN a.flag_masuk = 1 THEN 'Pagi' ELSE 'Sore' END) AS keterangan,
            a.nik,
            (SELECT nama FROM unit
            WHERE unit_id = (SELECT unit_id FROM kinerja 
                        WHERE nik = a.nik )  ) AS unit, 
            IFNULL(CONCAT('http://mediasaranainovasi.co.id/api/absensi/upload_absensi/',b.gambar),'https://kreditmandiri.co.id/api_test/absensi/profile/photo.jpg') AS gambar
            FROM `nik_import2`  a
            LEFT JOIN absensi_gambar b
            ON a.nik = b.`nik` AND
            a.flag_masuk = b.flag_masuk AND
            a.flag_keluar = b.flag_keluar AND
            DATE(a.`waktu_absensi`) = DATE(b.`waktu_absensi`)
            WHERE a.nik ='$nik' AND DATE(a.waktu_absensi) = '$tanggal'   ";


// print_r($query);


$execute = mysqli_query($KONEKSI, $query);
$count = mysqli_num_rows($execute);

if($count > 0){
    while($row=mysqli_fetch_assoc($execute)){
        $json[] = $row;
    }
}else{
    $json = array();
}

echo json_encode($json);
mysqli_close($KONEKSI);

?>