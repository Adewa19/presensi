<?php
    include "koneksi.php";

    $nik = $_GET['nik'];

    $query = "SELECT * FROM user where nik ='$nik'";
    $result = mysqli_query($KONEKSI,$query);
    $data   = mysqli_fetch_assoc($result);
    $nama_user = $data['nama'];
    $user_id_induk = $data['user_id_induk'];

    $query = "SELECT * FROM user where user_id ='$user_id_induk'";
    $result = mysqli_query($KONEKSI,$query);
    $data   = mysqli_fetch_assoc($result);
    $nama_atasan = $data['nama'];


    $query ="SELECT (SELECT CONCAT (YEAR(CURDATE()),'-',(CASE WHEN MONTH(CURDATE()) < 10 THEN CONCAT('0',MONTH(CURDATE()) - 1) ELSE MONTH(CURDATE()) -1 END),'-','21')) as periode_begin , 
                    (SELECT CONCAT (YEAR(CURDATE()),'-',(CASE WHEN MONTH(CURDATE()) < 10 THEN CONCAT('0',MONTH(CURDATE())) ELSE MONTH(CURDATE()) END),'-','20')) as periode_end ";
                    


    $result = mysqli_query($KONEKSI,$query);
    $data   = mysqli_fetch_assoc($result);

    $periode_begin = $data['periode_begin'];
    $periode_end   = $data['periode_end'];

    $query = "SELECT 
                    CASE
                    WHEN DATE_FORMAT(tgl,'%w') = 0 THEN 'Minggu'
                    WHEN DATE_FORMAT(tgl,'%w') = 1 THEN 'Senin'
                    WHEN DATE_FORMAT(tgl,'%w') = 2 THEN 'Selasa'
                    WHEN DATE_FORMAT(tgl,'%w') = 3 THEN 'Rabu'
                    WHEN DATE_FORMAT(tgl,'%w') = 4 THEN 'Kamis'
                    WHEN DATE_FORMAT(tgl,'%w') = 5 THEN 'Jumat'
                    WHEN DATE_FORMAT(tgl,'%w') = 6 THEN 'Sabtu'
                END AS hari,
                DATE_FORMAT(tgl,'%d-%m-%Y') AS tgl,
                IF((CASE WHEN is_hari_kerja ='1' OR flg_hadir ='HD' THEN `in`
                WHEN is_hari_kerja ='0' THEN ''
                ELSE '' END),(CASE WHEN is_hari_kerja ='1' OR flg_hadir ='HD' THEN `in`
                WHEN is_hari_kerja ='0' THEN ''
                ELSE '' END),'00:00') AS `in`,
                IF((CASE WHEN is_hari_kerja ='1' OR flg_hadir ='HD' THEN `out`
                WHEN is_hari_kerja ='0' THEN ''
                ELSE ''  END),(CASE WHEN is_hari_kerja ='1' OR flg_hadir ='HD' THEN `in`
                WHEN is_hari_kerja ='0' THEN ''
                ELSE '' END),'00:00') AS `out`,
                flg_hadir
            FROM `absensi_detail_init_3_final`
            WHERE nik ='$nik' AND tgl >='$periode_begin' AND tgl <= '$periode_end'  ";	


    $Hasil = mysqli_query($KONEKSI,$query);
    $Data = array();

    while($row = mysqli_fetch_assoc($Hasil)){
        array_push($Data, $row);
    }

    $Judul = "Data Absensi";
    $tgl= "Time : ".date("l, d F Y");
    $Header= array(
        array("label"=>"Hari", "length"=>20, "align"=>"L"),
        array("label"=>"Tanggal", "length"=>60, "align"=>"L"),
        array("label"=>"In", "length"=>40, "align"=>"L"),
        array("label"=>"Out", "length"=>33, "align"=>"L"),
        array("label"=>"flag", "length"=>30, "align"=>"L"),
    );
    include "fpdf/fpdf.php";
    $pdf = new FPDF();
    $pdf->AddPage('P','A4','C');
    $pdf->SetFont('arial','B','9');
    $pdf->Cell(0, 15, $Judul, '0', 1, 'C');
    $pdf->SetFont('arial','i','8');
    $pdf->Cell(0, 10,"Nik : $nik",'0', 1, 'P');
    $pdf->SetFont('arial','i','8');
    $pdf->Cell(0, 10,"Nama : $nama_user",'0', 1, 'P');
    $pdf->SetFont('arial','','8');
    $pdf->SetFillColor(190,190,0);
    $pdf->SetTextColor(255);
    $pdf->setDrawColor(128,0,0);
    foreach ($Header as $Kolom){
        $pdf->Cell($Kolom['length'], 8, $Kolom['label'], 1, '0', $Kolom['align'], true);
    }
    $pdf->Ln();
    $pdf->SetFillColor(255,235,255);
    $pdf->SettextColor(0);
    $pdf->SetFont('arial','','8');
    $fill =false;
    foreach ($Data as $Baris){
        $i= 0;
        foreach ($Baris as $Cell){
            $pdf->Cell ($Header[$i]['length'], 7, $Cell, 1, '0', $Kolom['align'], true);
            $i++;
        }
        $fill = !$fill;
        $pdf->Ln();
    }
    $pdf->Ln();
    $pdf->Setx(25);
    $pdf->Cell(0,5,'Mengetahui oleh; ',0,0,'L');
    $pdf->Setx(125);
    $pdf->Cell(0,5,'Disetujui oleh; ',0,0,'L');
    $pdf->Ln(5);
    $pdf->Setx(20);
    $pdf->Cell(0,5,"(    $nama_atasan      )",0,0,'L');
    $pdf->Setx(120);
    $pdf->Cell(0,5,'(______________________)',0,0,'L');
    $pdf->Output();
?>