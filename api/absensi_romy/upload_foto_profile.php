<?php
include "koneksi.php";

$nik = $_POST['nik'];

if(!empty($_FILES)) {

	$fileSize    = $_FILES["gambar"]["size"];

    if ($fileSize > 1024 * 1000 * 10){
    	$isValid = 0;
		$isPesan = "File size shoud be less than 5 MB !!!!";
		$json = array('value'=> $isValid,'message'=> $isPesan);
		echo json_encode($json);
		die();
    } 


    $dir_base = "profile/";
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
    $newfilename = $nik.$file_ext;


    if (in_array($fileActualExt, $allowed)) {

        if(file_exists($dir_file.$newfilename)){
            unlink($dir_file.$newfilename);
        }

        if(move_uploaded_file($fileTmpName,$dir_file.$newfilename)) {

            $query ="UPDATE karyawan SET foto ='$newfilename' WHERE nik ='$nik' ";

			$result = mysqli_query($KONEKSI, $query);

			if(!$result){
				$isValid = 0;
            	$isPesan = "Data gagal tersimpan, error : ".mysqli_error($KONEKSI);
			}else{
				$isValid = 1;
            	$isPesan = " Proses input Sukses !!!";
            	
            	$query ="UPDATE user SET foto ='$newfilename' WHERE nik ='$nik' ";

			    $result = mysqli_query($KONEKSI, $query);
			}
		}else{
            $isValid = 0;
            $isPesan = 'File gagal terkirim, Silahkan coba kembali !!!';
        }
                
    }

   
}


$json = array('value'=> $isValid,'message'=> $isPesan);


echo json_encode($json);
mysqli_close($KONEKSI);


?>