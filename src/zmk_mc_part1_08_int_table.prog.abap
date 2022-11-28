*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_08_int_table.

TYPES: BEGIN OF gty_structure,   "Satir tipi
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 40,
         surname TYPE c LENGTH 40,
         job     TYPE c LENGTH 20,
         salary  TYPE i,
         curr    TYPE c LENGTH 3,
         gsm     TYPE string,
         e_mail  TYPE string,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,   "Structure yani satir objesi
      gt_table     TYPE TABLE OF gty_structure.     "Internal table, tablo objesi

gs_structure-id       = 20220001.
gs_structure-name     = 'Mehmet'.
gs_structure-surname  = 'Yilmaz'.
gs_structure-job      ='Teacher'.
gs_structure-salary   = 3000.
gs_structure-curr     = 'EUR'.
gs_structure-gsm      = '+9005453243434'.
gs_structure-e_mail   = 'mehmetyilmaz@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id       = 20220002.
gs_structure-name     = 'Ferdi'.
gs_structure-surname  = 'Tayfur'.
gs_structure-job      = 'Artist'.
gs_structure-salary   = 5000.
gs_structure-curr     = 'EUR'.
gs_structure-gsm      = '+49052477873'.
gs_structure-e_mail   = 'ferditayfur@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

gs_structure-id       = 20220003.
gs_structure-name     = 'Ali'.
gs_structure-surname  = 'Ozturk'.
gs_structure-job      = 'Doktor'.
gs_structure-salary   = 4000.
gs_structure-curr     = 'EUR'.
gs_structure-gsm      = '+4901111111'.
gs_structure-e_mail   = 'aliozturk@gmail.com'.

APPEND gs_structure TO gt_table.
CLEAR: gs_structure.

LOOP AT gt_table INTO gs_structure WHERE id >= 20220002 AND salary >= 5000.
  WRITE:  / gs_structure-id,
          / gs_structure-name,
          / gs_structure-surname,
          / gs_structure-job,
          / gs_structure-salary,
          / gs_structure-curr,
          / gs_structure-gsm,
          / gs_structure-e_mail.
  SKIP.
  ULINE.

  CLEAR: gs_structure.
ENDLOOP.
