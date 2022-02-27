<?php
include "koneksi.php";

$nik = $_POST['nik'];

$rumahsakit = $_POST['rumahsakit'];
$tanggal = $_POST['tanggal'];
$tipe = $_POST['tipe'];
$hubungan = $_POST['hubungan'];
$pesan =$_POST['pesan'];
$nominal = $_POST['nominal'];
$today = date('Y-m-d');

if(!empty($_FILES)) {

	$fileSize    = $_FILES["gambar"]["size"];

    if ($fileSize > 1024 * 1000 * 10){
    	$isValid = 0;
		$isPesan = "File size shoud be less than 5 MB !!!!";
		$json = array('value'=> $isValid,'message'=> $isPesan);
		echo json_encode($json);
		die();
    } 


    $dir_base = "rawatjalan/";
    $dir_file = $dir_base;
    if(!file_exists($dir_file)){
        mkdir("$dir_file");
        chmod("$dir_file", 0777);
    }

    $fileName = isset($_FILES['gambar']['name']) ? $_FILES['gambar']['name']:"";

    $fileTmpName = isset($_FILES['gambar']['tmp_name']) ? $_FILES['gambar']['tmp_name']:"";
    $fileExt = explode('.', $fileName);
    $fileActualExt = strtolower(end($fileExt));
    $allowed = array('jpg','jpeg');
    $file_ext = substr($fileName, strripos($fileName, '.'));
    $file_basename= substr($fileName, 0, strripos($fileName, '.'));
    $newfilename = $tanggal."-".$nik.$file_ext;


    if (in_array($fileActualExt, $allowed)) {

        if(file_exists($dir_file.$newfilename)){
            unlink($dir_file.$newfilename);
        }

        if(move_uploaded_file($fileTmpName,$dir_file.$newfilename)) {

            $query ="INSERT INTO klaim (nik,tanggal,tipe,hubungan,nominal,rumah_sakit,keterangan,`file`,`status`,tgl_buat)
                     VALUES ('$nik','$tanggal','$tipe','$hubungan','$nominal','$rumahsakit','$pesan','$newfilename','0','$today') ";

			$result = mysqli_query($KONEKSI, $query);

			if(!$result){
				$isValid = 0;
            	$isPesan = "Data gagal tersimpan, error : ".mysqli_error($KONEKSI);
			}else{
				$isValid = 1;
                $isPesan = " Proses input Sukses !!!";
                
                $query ="SELECT user_id_induk ,nama ,`user_id` FROM user  where nik ='$nik' ";
                $result = mysqli_query($KONEKSI, $query);
                $data   = mysqli_fetch_assoc($result);
                $user_id_induk = $data['user_id_induk'];
                $nama = $data['nama'];
                $user_id = $data['user_id'];

                $query ="SELECT fcm_token ,user_id  FROM user  where nik = (SELECT nik FROM user_approval) ";
                $result = mysqli_query($KONEKSI, $query);
                $data   = mysqli_fetch_assoc($result);
                $fcm_token = $data['fcm_token'];
                $user_id_hc = $data['user_id'];

                $query ="SELECT id FROM klaim  where nik ='$nik' order by id desc limit 1 ";
                $result = mysqli_query($KONEKSI, $query);
                $data   = mysqli_fetch_assoc($result);
                $id_klaim = $data['id'];


                // Notifikasi ke atasan
                    $content = array(
                        "en" => "$nama Mengajukan Klaim $tipe di $rumahsakit Sebesar $nominal ",
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
                // }

                $query ="INSERT INTO sys_pesan (id_flg_otorisasi,`user_id`,user_id_request,waktu,`subject`,header,pesan,fcm_token)
                         VALUES ('$id_klaim','$user_id_hc','$user_id',now(),'KLAIM','$tipe','$nama Mengajukan Klaim $tipe di $rumahsakit Sebesar $nominal','$fcm_token') ";

                $result = mysqli_query($KONEKSI, $query);
                
			}
		}else{
            $isValid = 0;
            $isPesan = 'File gagal terkirim, Silahkan coba kembali !!!';
        }
                
    }

   
}


$json = array('value'=> $isValid,'message'=> $isPesan,'fcm_token'=>$fcm_token,'query'=>$query);


echo json_encode($json);
mysqli_close($KONEKSI);


?>