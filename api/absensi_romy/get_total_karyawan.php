<?php
include "koneksi.php";

$json = array();


$json = array();

$query="SELECT (SELECT COUNT(*) FROM view_karyawan WHERE STATUS = 'MAGANG'  ) AS  jml_magang,
       (SELECT COUNT(*) FROM view_karyawan WHERE STATUS = 'KONTRAK'  ) AS  jml_kontrak,
       (SELECT COUNT(*) FROM view_karyawan WHERE STATUS = 'TETAP'  ) AS  jml_tetap,
       (SELECT COUNT(*) FROM view_karyawan WHERE STATUS <> 'RESIGN'  ) AS  jml_semua ";


$result = mysqli_query($KONEKSI,$query);
$data =mysqli_fetch_assoc($result);
$row = mysqli_num_rows($result);

$jml_magang = $data['jml_magang'];
$jml_kontrak = $data['jml_kontrak'];
$jml_tetap = $data['jml_tetap'];
$jml_semua = $data['jml_semua'];


if($row == 0){
	$json = array('value'=> 0,'message'=> 'gagal');
}else{
	$json = array('value'=> 1,'message'=> 'berhasil','jml_magang'=>$jml_magang,
		         'jml_kontrak'=>$jml_kontrak,'jml_tetap'=>$jml_tetap,'jml_semua'=>$jml_semua);
}


echo json_encode($json);
mysqli_close($KONEKSI);