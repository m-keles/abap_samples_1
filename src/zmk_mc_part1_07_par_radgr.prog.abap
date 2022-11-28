*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_07_par_radgr.

*PARAMETERS: p_rd_1 RADIOBUTTON GROUP def,
*            p_rd_2 RADIOBUTTON GROUP def,
*            p_rd_3 RADIOBUTTON GROUP def.
*
*IF p_rd_1 IS NOT INITIAL.
*  MESSAGE 'Birinci radiobutton secildi' TYPE 'S'.
*ENDIF.
*
*IF p_rd_2 = 'X'.
*  MESSAGE 'Ikinci radiobutton secildi' TYPE 'S'.
*ENDIF.
*
*IF p_rd_3 = abap_true.
*  MESSAGE 'Ucuncu radiobutton secildi' TYPE 'S'.   "En cok tercih edilen
*ENDIF.





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

WRITE: gs_structure-id, / gs_structure-name.
