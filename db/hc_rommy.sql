/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.14-MariaDB : Database - hc_rommy
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hc_rommy` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

/*Table structure for table `absensi_detail_init_3_final` */

DROP TABLE IF EXISTS `absensi_detail_init_3_final`;

CREATE TABLE `absensi_detail_init_3_final` (
  `nik` varchar(10) DEFAULT NULL,
  `is_karyawan_exeption` int(1) DEFAULT 0,
  `shift` varchar(1) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `is_hari_kerja` int(1) DEFAULT NULL,
  `is_hari_libur` int(1) DEFAULT NULL,
  `jam_in_std` varchar(20) DEFAULT NULL,
  `jam_out_std` varchar(20) DEFAULT NULL,
  `in` varchar(20) DEFAULT NULL,
  `out` varchar(20) DEFAULT NULL,
  `flag_hadir_sabtu` int(1) DEFAULT 0,
  `flg_hadir` varchar(20) DEFAULT NULL,
  `is_potong_cuti` int(1) DEFAULT 0,
  `is_in_anomali` int(1) DEFAULT 0,
  `is_out_anomali` int(1) DEFAULT 0,
  `ijin_in_anomali` int(1) DEFAULT 0,
  `ijin_out_anomali` int(1) DEFAULT 0,
  `ijin_plg_cepat` int(1) DEFAULT 0,
  `lambat` int(1) DEFAULT 0,
  `ijin_lambat` int(1) DEFAULT 0,
  `set_hitung_lembur` int(1) DEFAULT 0,
  `jam_mulai_lembur_std` varchar(20) DEFAULT NULL,
  `jam_mulai_lembur` varchar(20) DEFAULT NULL,
  `is_lembur` int(1) DEFAULT 0,
  `jam_lembur` int(1) DEFAULT 0,
  `str_masuk` int(1) DEFAULT 0,
  `str_keluar` int(1) DEFAULT 0,
  `status` int(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `absensi_detail_init_3_final` */

insert  into `absensi_detail_init_3_final`(`nik`,`is_karyawan_exeption`,`shift`,`tgl`,`is_hari_kerja`,`is_hari_libur`,`jam_in_std`,`jam_out_std`,`in`,`out`,`flag_hadir_sabtu`,`flg_hadir`,`is_potong_cuti`,`is_in_anomali`,`is_out_anomali`,`ijin_in_anomali`,`ijin_out_anomali`,`ijin_plg_cepat`,`lambat`,`ijin_lambat`,`set_hitung_lembur`,`jam_mulai_lembur_std`,`jam_mulai_lembur`,`is_lembur`,`jam_lembur`,`str_masuk`,`str_keluar`,`status`) values 
('123456',0,'A','2021-06-01',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-02',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-03',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-04',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-05',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-06',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-07',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-08',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-09',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-10',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-11',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-12',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-13',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-14',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-15',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-16',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-17',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-18',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-19',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-20',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-21',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-22',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-23',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-24',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-25',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-26',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-27',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-28',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-29',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-06-30',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0),
('123456',0,'A','2021-07-01',1,NULL,'08:00','17:00','','',0,'AL',0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0);

/*Table structure for table `absensi_gambar` */

DROP TABLE IF EXISTS `absensi_gambar`;

CREATE TABLE `absensi_gambar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(20) DEFAULT NULL,
  `gambar` text DEFAULT NULL,
  `waktu_absensi` datetime DEFAULT NULL,
  `flag_masuk` int(1) DEFAULT 0,
  `flag_keluar` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `absensi_gambar` */

/*Table structure for table `app_kode_kantor` */

DROP TABLE IF EXISTS `app_kode_kantor`;

CREATE TABLE `app_kode_kantor` (
  `kode_kantor` int(11) NOT NULL AUTO_INCREMENT,
  `kode_cabang` char(4) DEFAULT NULL,
  `nama_kantor` char(50) DEFAULT NULL,
  `alamat_kantor` char(100) DEFAULT NULL,
  `latitude` decimal(20,8) DEFAULT NULL,
  `longitude` decimal(20,8) DEFAULT NULL,
  `flg_aktif` smallint(1) DEFAULT 1,
  PRIMARY KEY (`kode_kantor`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `app_kode_kantor` */

insert  into `app_kode_kantor`(`kode_kantor`,`kode_cabang`,`nama_kantor`,`alamat_kantor`,`latitude`,`longitude`,`flg_aktif`) values 
(1,'1','KANTOR BSD','Jalan raya BSD serpong Tangerang Selatan',-6.29963810,106.67030700,1),
(2,'1','KANTOR PAMULANG','Jalan raya Pamulang Tangerang Selatan',-6.34181960,106.72624570,1),
(3,'1','RUMAHKU','Jalan Gang pinang',-6.35110800,106.74084000,1),
(4,'1','MENARA 165','Jakarta selatan',-6.29078180,106.80978970,1),
(5,'2','UMP KESEHATAN','Purwokerto',-7.44938838,109.27990937,1),
(6,'2','WISMA UMP 1','Purwokerto',-7.41616957,109.27235611,1),
(7,'2','UMP 3','Purwokerto',-7.40770077,109.27859398,1),
(8,'2','WISMA UMP 2','JALAN BOJONGSARI PURWOKERTO',-7.41616663,109.27235733,1);

/*Table structure for table `area` */

DROP TABLE IF EXISTS `area`;

CREATE TABLE `area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_area` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `area` */

insert  into `area`(`area_id`,`nama_area`) values 
(1,'JAKARTA'),
(2,'PURWOKERTO');

/*Table structure for table `cabang` */

DROP TABLE IF EXISTS `cabang`;

CREATE TABLE `cabang` (
  `kode_cabang` int(11) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) DEFAULT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kode_cabang`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='master cabang';

/*Data for the table `cabang` */

insert  into `cabang`(`kode_cabang`,`area_id`,`nama`,`alamat`) values 
(1,1,'KANTOR PUSAT','JAKARTA PUSAT'),
(2,2,'UMP','PURWOKERTO');

/*Table structure for table `divisi` */

DROP TABLE IF EXISTS `divisi`;

CREATE TABLE `divisi` (
  `divisi_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`divisi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='master divisi karyawan';

/*Data for the table `divisi` */

insert  into `divisi`(`divisi_id`,`nama`) values 
(1,'BUSSINES'),
(2,'SUMBER DAYA MANUSIA');

/*Table structure for table `hari_libur` */

DROP TABLE IF EXISTS `hari_libur`;

CREATE TABLE `hari_libur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tgl` date DEFAULT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `hari_libur` */

insert  into `hari_libur`(`id`,`tgl`,`keterangan`) values 
(1,'2020-07-31','idul adha'),
(2,'2020-08-17','kemerdekaan indonsia'),
(3,'2020-08-20','tahun baru islam'),
(4,'2020-12-31','Cuti bersama'),
(5,'2021-01-01','Tahun baru');

/*Table structure for table `jabatan` */

DROP TABLE IF EXISTS `jabatan`;

CREATE TABLE `jabatan` (
  `jabatan_id` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`jabatan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='master jabatan karyawan';

/*Data for the table `jabatan` */

insert  into `jabatan`(`jabatan_id`,`nama`) values 
(1,'STAFF IT'),
(2,'HC'),
(3,'STAFF'),
(4,'HEAD IT'),
(5,'SDM'),
(6,'OPERASIONAL');

/*Table structure for table `karyawan` */

DROP TABLE IF EXISTS `karyawan`;

CREATE TABLE `karyawan` (
  `nik` varchar(10) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `id_kinerja` int(11) NOT NULL DEFAULT 0,
  `id_sp` int(11) NOT NULL DEFAULT 0,
  `tgl_masuk` date DEFAULT NULL,
  `identitas` enum('KTP','SIM','PASSPORT') DEFAULT 'KTP',
  `no_identitas` varchar(50) DEFAULT NULL,
  `kelamin` enum('WANITA','PRIA') DEFAULT 'PRIA',
  `tmp_lahir` varchar(50) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `agama` varchar(30) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `kota` varchar(50) DEFAULT NULL,
  `propinsi` varchar(30) DEFAULT NULL,
  `negara` varchar(30) DEFAULT NULL,
  `kd_pos` varchar(10) DEFAULT NULL,
  `telp` varchar(50) DEFAULT NULL,
  `hp` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `warga_negara` varchar(50) DEFAULT NULL,
  `nikah_id` varchar(10) DEFAULT NULL,
  `nama_pasangan` varchar(50) DEFAULT NULL,
  `foto` varchar(50) DEFAULT NULL,
  `npwp` varchar(50) DEFAULT NULL,
  `alamat_npwp` varchar(225) DEFAULT NULL,
  `no_bpjs` varchar(50) DEFAULT NULL COMMENT 'NO BPJS TENAGA KERJA',
  `no_bpjs_1` varchar(50) DEFAULT NULL COMMENT 'NO KESEHATAN',
  `shift` enum('A','B','C','D') DEFAULT 'B',
  `penggajian` char(1) DEFAULT '0',
  `set_lembur` enum('0','1') DEFAULT '0',
  `user` varchar(30) DEFAULT NULL,
  `user_update` varchar(30) DEFAULT NULL,
  `tgl_buat` datetime DEFAULT NULL,
  `tgl_update` datetime DEFAULT NULL,
  `tgl_use` date DEFAULT NULL,
  `pendidikan` varchar(50) DEFAULT NULL,
  `status` enum('Aktif','Tidak Aktif') DEFAULT 'Aktif',
  PRIMARY KEY (`nik`),
  UNIQUE KEY `nik` (`nik`),
  KEY `nama` (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='master karyawan';

/*Data for the table `karyawan` */

insert  into `karyawan`(`nik`,`nama`,`id_kinerja`,`id_sp`,`tgl_masuk`,`identitas`,`no_identitas`,`kelamin`,`tmp_lahir`,`tgl_lahir`,`agama`,`alamat`,`kota`,`propinsi`,`negara`,`kd_pos`,`telp`,`hp`,`email`,`warga_negara`,`nikah_id`,`nama_pasangan`,`foto`,`npwp`,`alamat_npwp`,`no_bpjs`,`no_bpjs_1`,`shift`,`penggajian`,`set_lembur`,`user`,`user_update`,`tgl_buat`,`tgl_update`,`tgl_use`,`pendidikan`,`status`) values 
('021901001','RAMELAN EKO',1,0,'2020-07-17','KTP','763246327648378','PRIA','BREBES','1992-07-17','Islam','Jalan pinang raya pamulang timur , Tangerang selatan','Bumiayu','Jawa tengah','Indonesia','52276','-','083813997825','admin@yahoo.com',NULL,NULL,NULL,'021901001.jpg',NULL,NULL,NULL,NULL,'A','0','0',NULL,NULL,NULL,NULL,NULL,'S1','Aktif'),
('12324234','BASRI',14,0,'2020-12-25','KTP',NULL,'PRIA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'B','0','0',NULL,NULL,NULL,NULL,NULL,NULL,''),
('123456','DEMO USER',13,0,'2020-12-03','KTP','0234872384','PRIA',NULL,NULL,NULL,'Jalan raya pondok indah','Jakarta',NULL,NULL,NULL,NULL,'023672684212',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'B','0','0',NULL,NULL,NULL,NULL,NULL,NULL,'Aktif');

/*Table structure for table `kinerja` */

DROP TABLE IF EXISTS `kinerja`;

CREATE TABLE `kinerja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(15) DEFAULT NULL,
  `kode_kantor` char(4) DEFAULT NULL,
  `jabatan_id` int(11) DEFAULT NULL,
  `divisi_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `rank_id` int(11) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `kinerja` */

insert  into `kinerja`(`id`,`nik`,`kode_kantor`,`jabatan_id`,`divisi_id`,`unit_id`,`rank_id`,`keterangan`,`created_by`) values 
(1,'021901001','1',1,1,1,1,'KARYAWAN BARU',1),
(12,'2123123','5',5,1,2,3,'KARYAWAN BARU',1),
(13,'123456','1',3,1,2,3,'KARYAWAN BARU',1),
(14,'12324234','3',3,1,2,3,'KARYAWAN BARU',1);

/*Table structure for table `klaim` */

DROP TABLE IF EXISTS `klaim`;

CREATE TABLE `klaim` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `tipe` varchar(50) DEFAULT NULL,
  `hubungan` enum('Sendiri','Suami / Istri','Anak') DEFAULT 'Sendiri',
  `nominal` int(11) DEFAULT NULL,
  `rumah_sakit` varchar(100) DEFAULT NULL,
  `rank` varchar(15) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `file` text DEFAULT NULL,
  `status` int(1) DEFAULT 0,
  `tgl_buat` date DEFAULT NULL,
  `user_approve` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `klaim` */

/*Table structure for table `lembur` */

DROP TABLE IF EXISTS `lembur`;

CREATE TABLE `lembur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(10) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam_awal` time DEFAULT NULL,
  `jam_akhir` time DEFAULT NULL,
  `selama` int(11) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `status` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `lembur` */

insert  into `lembur`(`id`,`nik`,`tanggal`,`jam_awal`,`jam_akhir`,`selama`,`keterangan`,`status`) values 
(5,'021901001','0000-00-00','23:10:00','23:10:00',3,'tess',1);

/*Table structure for table `logbook` */

DROP TABLE IF EXISTS `logbook`;

CREATE TABLE `logbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(50) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam_mulai` time DEFAULT NULL,
  `jam_selesai` time DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `logbook` */

insert  into `logbook`(`id`,`nik`,`tanggal`,`jam_mulai`,`jam_selesai`,`catatan`,`status`) values 
(1,'021901001','2021-01-02','08:00:00','17:00:00','Mmebuat aplikasi frontaccounting bcfvdvdsvdsvgvsdvsdvsdvd',1),
(3,'021901001','2021-01-03','08:34:00','04:34:00','Mengerjakakn tugas project membuat aplikasi ',0),
(4,'021901001','2021-01-01','08:35:00','04:35:00','Mengerjakakn tugas rumah',0),
(5,'021901001','2021-01-04','08:37:00','08:37:00','saya mengerjakakn apartment yang say perintahkan menjadi yang terbaik\n',0),
(6,'021901001','2021-01-05','08:37:00','08:37:00','dfgdsgsdgsdgsdgdfgdfgdfgdfvcxvc VC CV ',2),
(7,'021901001','2021-01-06','08:37:00','08:37:00','dfgdsgsdgsdgsdgdfgdfgdfgcvbcvbcvbcvbdfvcxvc VC CV ',1),
(8,'021901001','2021-01-07','09:40:00','09:40:00','teeesss  inilah yang say cari adalah kenikmatan dalam hidup dinikmatin dsfhksdjflksddkslfsk\n\n\n\n',0);

/*Table structure for table `maps_area_user` */

DROP TABLE IF EXISTS `maps_area_user`;

CREATE TABLE `maps_area_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) DEFAULT NULL,
  `lat` text DEFAULT NULL,
  `long` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `maps_area_user` */

insert  into `maps_area_user`(`id`,`user_id`,`lat`,`long`) values 
(6,'1','-6.2907714','106.80979480000002'),
(7,'15','-6.2996436','106.67031450000002'),
(8,'16','-6.2996523','106.67032260000002'),
(9,'18','-6.3509501','106.74060259999999'),
(10,'24','-2.4156751','121.8857097');

/*Table structure for table `master_klaim` */

DROP TABLE IF EXISTS `master_klaim`;

CREATE TABLE `master_klaim` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank_id` varchar(10) DEFAULT NULL,
  `Plafon` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `master_klaim` */

insert  into `master_klaim`(`id`,`rank_id`,`Plafon`) values 
(1,'SPV',5000000),
(2,'MANAGER',7000000),
(3,'DIREKTUR',10000000),
(4,'STAFF',1000000);

/*Table structure for table `master_permit` */

DROP TABLE IF EXISTS `master_permit`;

CREATE TABLE `master_permit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `master_permit` */

insert  into `master_permit`(`id`,`nama`) values 
(1,'WFH'),
(2,'SAKIT'),
(3,'IJIN'),
(9,'EVENT'),
(10,'CUTI');

/*Table structure for table `nik_import2` */

DROP TABLE IF EXISTS `nik_import2`;

CREATE TABLE `nik_import2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(10) NOT NULL,
  `waktu_absensi` datetime NOT NULL,
  `log_ke` int(11) DEFAULT 0,
  `flag_keluar` int(11) DEFAULT 0,
  `flag_masuk` int(11) DEFAULT 0,
  `flag_mulai_break` int(11) DEFAULT 0,
  `flag_selesai_break` int(11) DEFAULT 0,
  `waktu_kirim` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `waktu_absensi` (`waktu_absensi`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `nik_import2` */

/*Table structure for table `parameter` */

DROP TABLE IF EXISTS `parameter`;

CREATE TABLE `parameter` (
  `id` varchar(100) DEFAULT NULL,
  `deskripsi` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `parameter` */

insert  into `parameter`(`id`,`deskripsi`) values 
('HARI_KERJA','hari=Senin,Selasa,Rabu,Kamis,Jumat,Sabtu,Minggu'),
('LEMBUR','25000'),
('BATAS_LEMBUR','3'),
('JARAK','350'),
('JUMAH_HARI_KERJA','5'),
('JAM_MASUK','08:00'),
('JAM_PULANG','16:00'),
('JAM_MASUK_KUSUS','08:00'),
('JAM_PULANG_KHUSUS','16:30'),
('JAM_MULAI_ISTIRAHAT','12:00'),
('JAM_SELESAI_ISTIRAHAT','13:00');

/*Table structure for table `permit` */

DROP TABLE IF EXISTS `permit`;

CREATE TABLE `permit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(15) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_akhir` date DEFAULT NULL,
  `tipe_permit` int(11) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `file` varchar(200) DEFAULT NULL,
  `status` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `permit` */

/*Table structure for table `prm_master_group_menu` */

DROP TABLE IF EXISTS `prm_master_group_menu`;

CREATE TABLE `prm_master_group_menu` (
  `id_group_menu` int(11) NOT NULL AUTO_INCREMENT,
  `nama_group_menu` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_group_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `prm_master_group_menu` */

insert  into `prm_master_group_menu`(`id_group_menu`,`nama_group_menu`) values 
(1,'PUSAT'),
(2,'IT'),
(3,'HC'),
(4,'ADMINISTRASI');

/*Table structure for table `prm_master_menu_aplikasi` */

DROP TABLE IF EXISTS `prm_master_menu_aplikasi`;

CREATE TABLE `prm_master_menu_aplikasi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_aplikasi` varchar(50) DEFAULT NULL,
  `versi` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `prm_master_menu_aplikasi` */

insert  into `prm_master_menu_aplikasi`(`id`,`nama_aplikasi`,`versi`) values 
(1,'ABSENSI WEB',1);

/*Table structure for table `prm_menu_access_mitra` */

DROP TABLE IF EXISTS `prm_menu_access_mitra`;

CREATE TABLE `prm_menu_access_mitra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL,
  `id_group_menu` text DEFAULT NULL,
  `id_menu` text DEFAULT NULL,
  `divisi_id` varchar(30) DEFAULT NULL,
  `jabatan` varchar(50) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `created_time` time DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `updated_time` time DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

/*Data for the table `prm_menu_access_mitra` */

insert  into `prm_menu_access_mitra`(`id`,`user_id`,`id_group_menu`,`id_menu`,`divisi_id`,`jabatan`,`created_date`,`created_time`,`created_by`,`updated_date`,`updated_time`,`updated_by`) values 
(1,'1','1,61,62','1,2,173,175,184,176,177,178,179,180,181,182,183','1','1',NULL,NULL,NULL,'2020-11-28','22:32:13',1),
(79,'22','62','183','1','5','2020-11-28','20:52:25',1,NULL,NULL,NULL),
(80,'23','1,62','2,183','1','3','2020-12-03','22:39:29',1,'2020-12-03','22:39:51',1);

/*Table structure for table `prm_menu_group_mitra` */

DROP TABLE IF EXISTS `prm_menu_group_mitra`;

CREATE TABLE `prm_menu_group_mitra` (
  `id_group_menu` int(11) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) DEFAULT NULL,
  `id_menu_aplikasi` int(11) DEFAULT NULL,
  `font_icon` char(100) DEFAULT NULL,
  `nama_group_menu` varchar(100) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_date` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `flag_aktif` enum('1','0') DEFAULT '1',
  PRIMARY KEY (`id_group_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

/*Data for the table `prm_menu_group_mitra` */

insert  into `prm_menu_group_mitra`(`id_group_menu`,`no_urut`,`id_menu_aplikasi`,`font_icon`,`nama_group_menu`,`created_date`,`created_by`,`updated_date`,`updated_by`,`deleted_date`,`deleted_by`,`flag_aktif`) values 
(1,3,1,'glyphicon glyphicon-cog','Pengaturan',NULL,NULL,NULL,NULL,NULL,NULL,'1'),
(61,1,1,'glyphicon glyphicon-book','Master','2020-09-26 11:31:03',1,NULL,NULL,NULL,NULL,'1'),
(62,2,1,'glyphicon glyphicon-file','Laporan','2020-11-28 20:45:50',1,NULL,NULL,NULL,NULL,'1');

/*Table structure for table `prm_menu_mitra` */

DROP TABLE IF EXISTS `prm_menu_mitra`;

CREATE TABLE `prm_menu_mitra` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  `no_urut` int(11) DEFAULT NULL,
  `id_group_menu` int(11) NOT NULL,
  `nama_menu` varchar(100) NOT NULL,
  `font_icon` varchar(100) DEFAULT NULL,
  `controler` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_date` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `flag_aktif` enum('1','0') DEFAULT '1',
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=latin1;

/*Data for the table `prm_menu_mitra` */

insert  into `prm_menu_mitra`(`id_menu`,`no_urut`,`id_group_menu`,`nama_menu`,`font_icon`,`controler`,`created_date`,`created_by`,`updated_date`,`updated_by`,`deleted_date`,`deleted_by`,`flag_aktif`) values 
(1,1,1,'User','glyphicon glyphicon-cog','setting/setting_akses_menu',NULL,NULL,NULL,NULL,NULL,NULL,'1'),
(2,2,1,'Template','glyphicon glyphicon-cog','setting/setting_warna',NULL,NULL,NULL,NULL,NULL,NULL,'1'),
(173,3,1,'Menu','glyphicon glyphicon-cog','setting/setting_menu',NULL,NULL,NULL,NULL,NULL,NULL,'1'),
(175,1,1,'Aplikasi','glyphicon glyphicon-cog','setting/setting_aplikasi','2020-04-27 13:13:15',1,NULL,NULL,NULL,NULL,'1'),
(176,1,61,'Area','glyphicon glyphicon-book','master/area','2020-09-26 11:32:05',1,NULL,NULL,NULL,NULL,'1'),
(177,2,61,'Cabang','glyphicon glyphicon-book','master/cabang','2020-09-26 11:32:28',1,NULL,NULL,NULL,NULL,'1'),
(178,3,61,'Kantor','glyphicon glyphicon-book','master/kantor','2020-09-26 11:32:45',1,NULL,NULL,NULL,NULL,'1'),
(179,4,61,'Divisi','glyphicon glyphicon-book','master/divisi','2020-09-26 11:33:31',1,NULL,NULL,NULL,NULL,'1'),
(180,5,61,'Jabatan','glyphicon glyphicon-book','master/jabatan','2020-09-26 11:33:55',1,NULL,NULL,NULL,NULL,'1'),
(181,6,61,'Unit','glyphicon glyphicon-book','master/unit','2020-09-26 11:34:19',1,NULL,NULL,NULL,NULL,'1'),
(182,7,61,'Rank','glyphicon glyphicon-book','master/rank','2020-09-26 11:34:54',1,NULL,NULL,NULL,NULL,'1'),
(183,1,62,'Rekap absensi karyawan','glyphicon glyphicon-book','laporan/rekap_absensi','2020-11-28 20:47:59',1,NULL,NULL,NULL,NULL,'1'),
(184,5,1,'Parameter','glyphicon glyphicon-cog','setting/setting_parameter','2020-11-28 22:31:03',1,NULL,NULL,NULL,NULL,'1');

/*Table structure for table `prm_setting_warna` */

DROP TABLE IF EXISTS `prm_setting_warna`;

CREATE TABLE `prm_setting_warna` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `warna` varchar(100) DEFAULT NULL,
  `menu` varchar(50) DEFAULT NULL,
  `animasi` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `prm_setting_warna` */

insert  into `prm_setting_warna`(`id`,`user_id`,`warna`,`menu`,`animasi`) values 
(1,NULL,'#ee7c1c','atas','bounce');

/*Table structure for table `rank` */

DROP TABLE IF EXISTS `rank`;

CREATE TABLE `rank` (
  `rank_id` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`rank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='master rank';

/*Data for the table `rank` */

insert  into `rank`(`rank_id`,`nama`) values 
(1,'SUPERVISOR'),
(2,'DIREKTUR'),
(3,'STAFF '),
(4,'MANAGER');

/*Table structure for table `status_kerja` */

DROP TABLE IF EXISTS `status_kerja`;

CREATE TABLE `status_kerja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(15) DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `tgl_selesai` date DEFAULT NULL,
  `status` enum('TETAP','KONTRAK','MAGANG') DEFAULT 'KONTRAK',
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `status_kerja` */

/*Table structure for table `sys_pesan` */

DROP TABLE IF EXISTS `sys_pesan`;

CREATE TABLE `sys_pesan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_flg_otorisasi` int(11) DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `user_id_request` int(11) DEFAULT 0,
  `waktu` datetime NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `header` varchar(200) DEFAULT NULL,
  `pesan` text DEFAULT NULL,
  `via_email` smallint(1) DEFAULT 0,
  `email_to` varchar(1000) DEFAULT NULL,
  `via_sms` smallint(1) DEFAULT 0,
  `sms_to` varchar(100) DEFAULT NULL,
  `via_android` smallint(1) DEFAULT 0,
  `flg_aktif` smallint(1) DEFAULT 0,
  `flg_sent` smallint(1) DEFAULT 0,
  `sudah_dibaca` smallint(1) DEFAULT 0,
  `fcm_token` varchar(250) DEFAULT NULL,
  `error_msg` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=762902 DEFAULT CHARSET=latin1;

/*Data for the table `sys_pesan` */

/*Table structure for table `unit` */

DROP TABLE IF EXISTS `unit`;

CREATE TABLE `unit` (
  `unit_id` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='master unit kerja karyawan';

/*Data for the table `unit` */

insert  into `unit`(`unit_id`,`nama`) values 
(1,'IT'),
(2,'OPERASIONAL'),
(3,'HUMAN CAPITAL'),
(4,'KEUANGAN');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `nik` varchar(10) DEFAULT NULL,
  `nama` varchar(50) NOT NULL,
  `kode_kantor` int(11) DEFAULT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `group_menu` int(10) DEFAULT NULL,
  `area` varchar(10) DEFAULT NULL,
  `tgl_expired` date DEFAULT NULL,
  `flg_blok` int(1) DEFAULT 0,
  `jabatan_id` varchar(10) DEFAULT NULL,
  `unit_id` varchar(10) DEFAULT NULL,
  `divisi_id` varchar(10) DEFAULT NULL,
  `rank_id` varchar(10) DEFAULT NULL,
  `user_id_induk` int(11) DEFAULT NULL,
  `flag` varchar(10) DEFAULT NULL,
  `foto` varchar(20) DEFAULT NULL,
  `fcm_token` text DEFAULT NULL,
  `jam_masuk` varchar(20) DEFAULT NULL,
  `jam_pulang` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`user_id`,`username`,`password`,`nik`,`nama`,`kode_kantor`,`cabang_id`,`area_id`,`email`,`group_menu`,`area`,`tgl_expired`,`flg_blok`,`jabatan_id`,`unit_id`,`divisi_id`,`rank_id`,`user_id_induk`,`flag`,`foto`,`fcm_token`,`jam_masuk`,`jam_pulang`) values 
(1,'admin','202cb962ac59075b964b07152d234b70','021901001','RAMELAN EKO PAMUJI',1,1,1,'staf_tidev4@kreditmandiri.co.id',2,'PUSAT','2021-12-31',0,'1','IT','1','S2',23,'non_hc','021901001.jpg','f660a820-4c07-4ac4-8965-e605a9ddcde1','08:00','17:00'),
(23,'demo','202cb962ac59075b964b07152d234b70','123456','DEMO USER',1,1,1,NULL,NULL,NULL,'2020-12-31',0,'3','2','1','3',1,NULL,NULL,'f660a820-4c07-4ac4-8965-e605a9ddcde1','08:00','17:00');

/*Table structure for table `user_approval` */

DROP TABLE IF EXISTS `user_approval`;

CREATE TABLE `user_approval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `user_approval` */

insert  into `user_approval`(`id`,`nik`) values 
(1,'12324234');

/*Table structure for table `view_periode` */

DROP TABLE IF EXISTS `view_periode`;

/*!50001 DROP VIEW IF EXISTS `view_periode` */;
/*!50001 DROP TABLE IF EXISTS `view_periode` */;

/*!50001 CREATE TABLE  `view_periode`(
 `bulan` int(2) ,
 `periode_awal` varchar(12) ,
 `periode_akhir` varchar(11) 
)*/;

/*Table structure for table `view_rekap_absensi` */

DROP TABLE IF EXISTS `view_rekap_absensi`;

/*!50001 DROP VIEW IF EXISTS `view_rekap_absensi` */;
/*!50001 DROP TABLE IF EXISTS `view_rekap_absensi` */;

/*!50001 CREATE TABLE  `view_rekap_absensi`(
 `tgl` date ,
 `nik` varchar(10) ,
 `nama` varchar(50) ,
 `nama_kantor` char(50) ,
 `alamat_kantor` char(100) ,
 `nama_divisi` varchar(50) ,
 `jam_in_std` varchar(20) ,
 `jam_out_std` varchar(20) ,
 `in` varchar(20) ,
 `out` varchar(20) ,
 `flg_hadir` varchar(20) 
)*/;

/*View structure for view view_periode */

/*!50001 DROP TABLE IF EXISTS `view_periode` */;
/*!50001 DROP VIEW IF EXISTS `view_periode` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_periode` AS (select month(curdate()) AS `bulan`,case when month(curdate()) = 1 then concat(year(curdate()) - 1,'-','12','-','21') else concat(year(curdate()),'-',case when month(curdate()) - 1 < 10 then concat('0',month(curdate()) - 1) else month(curdate()) - 1 end,'-','21') end AS `periode_awal`,concat(year(curdate()),'-',case when month(curdate()) < 10 then concat('0',month(curdate())) else month(curdate()) end,'-','20') AS `periode_akhir`) */;

/*View structure for view view_rekap_absensi */

/*!50001 DROP TABLE IF EXISTS `view_rekap_absensi` */;
/*!50001 DROP VIEW IF EXISTS `view_rekap_absensi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_rekap_absensi` AS (select `a`.`tgl` AS `tgl`,`a`.`nik` AS `nik`,`b`.`nama` AS `nama`,`c`.`nama_kantor` AS `nama_kantor`,`c`.`alamat_kantor` AS `alamat_kantor`,`d`.`nama` AS `nama_divisi`,`a`.`jam_in_std` AS `jam_in_std`,`a`.`jam_out_std` AS `jam_out_std`,`a`.`in` AS `in`,`a`.`out` AS `out`,`a`.`flg_hadir` AS `flg_hadir` from (((`absensi_detail_init_3_final` `a` left join `user` `b` on(`a`.`nik` = `b`.`nik`)) left join `app_kode_kantor` `c` on(`b`.`kode_kantor` = `c`.`kode_kantor`)) left join `divisi` `d` on(`b`.`divisi_id` = `d`.`divisi_id`)) where year(`a`.`tgl`) = year(curdate())) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
