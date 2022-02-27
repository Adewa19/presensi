SELECT
  `a`.`tgl`           AS `tgl`,
  `a`.`nik`           AS `nik`,
  `b`.`nama`          AS `nama`,
  `c`.`nama_kantor`   AS `nama_kantor`,
  `c`.`alamat_kantor` AS `alamat_kantor`,
  `d`.`nama`          AS `nama_divisi`,
  `a`.`jam_in_std`    AS `jam_in_std`,
  `a`.`jam_out_std`   AS `jam_out_std`,
  `a`.`in`            AS `in`,
  `a`.`out`           AS `out`,
  `a`.`flg_hadir`     AS `flg_hadir`
FROM (((`absensi_detail_init_3_final` `a`
     LEFT JOIN `user` `b`
       ON ((`a`.`nik` = `b`.`nik`)))
    LEFT JOIN `app_kode_kantor` `c`
      ON ((`b`.`kode_kantor` = `c`.`kode_kantor`)))
   LEFT JOIN `divisi` `d`
     ON ((`b`.`divisi_id` = `d`.`divisi_id`)))
WHERE (YEAR(`a`.`tgl`) = YEAR(CURDATE())) 