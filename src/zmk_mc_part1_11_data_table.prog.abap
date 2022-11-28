*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_11_data_table.

*DATA: gs_structure TYPE zmk_structure_01,
*      gt_table     TYPE TABLE OF zmk_structure_01.
*
*gs_structure-id       = 20220004.
*gs_structure-name     = 'Mehmet'.
*gs_structure-surname  = 'Yilmaz'.
*gs_structure-job      ='Teacher'.
*gs_structure-salary   = 3000.
*gs_structure-curr     = 'EUR'.
*gs_structure-gsm      = '+9005453243434'.
*gs_structure-e_mail   = 'mehmetyilmaz@gmail.com'.
*
*APPEND gs_structure TO gt_table.
*CLEAR: gs_structure.
*
*gs_structure-id       = 20220005.
*gs_structure-name     = 'Ferdi'.
*gs_structure-surname  = 'Tayfur'.
*gs_structure-job      = 'Artist'.
*gs_structure-salary   = 5000.
*gs_structure-curr     = 'EUR'.
*gs_structure-gsm      = '+49052477873'.
*gs_structure-e_mail   = 'ferditayfur@gmail.com'.
*
*APPEND gs_structure TO gt_table.
*CLEAR: gs_structure.
*
*gs_structure-id       = 20220006.
*gs_structure-name     = 'Ali'.
*gs_structure-surname  = 'Ozturk'.
*gs_structure-job      = 'Doktor'.
*gs_structure-salary   = 4000.
*gs_structure-curr     = 'EUR'.
*gs_structure-gsm      = '+4901111111'.
*gs_structure-e_mail   = 'aliozturk@gmail.com'.
*
*APPEND gs_structure TO gt_table.
*CLEAR: gs_structure.
*
*LOOP AT gt_table INTO gs_structure where id >= 20220002 and salary >= 5000.
*  WRITE:  / gs_structure-id,
*          / gs_structure-name,
*          / gs_structure-surname,
*          / gs_structure-job,
*          / gs_structure-salary,
*          / gs_structure-curr,
*          / gs_structure-gsm,
*          / gs_structure-e_mail.
*  SKIP.
*  ULINE.
*
*  CLEAR: gs_structure.
*ENDLOOP.



DATA: gs_str TYPE zmk_table_01,            "Bu bir satir
      gt_tbl TYPE TABLE OF zmk_table_01.   "Bu bir internal tablo


SELECT * FROM zmk_table_01 INTO TABLE gt_tbl WHERE id >= 20220002.

LOOP AT gt_tbl INTO gs_str.
  WRITE:  / gs_str-id,
          / gs_str-name,
          / gs_str-surname,
          / gs_str-job,
          / gs_str-salary,
          / gs_str-curr,
          / gs_str-gsm,
          / gs_str-e_mail.

  SKIP.
  ULINE.
  CLEAR: gs_str.

ENDLOOP.
