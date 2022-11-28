*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_12_crud_form.

*DATA: gs_structure TYPE zmk_table_01.  "Bu bir structure
*
*gs_structure-id = 0020220005.
*gs_structure-name = 'Osman'.
*gs_structure-surname = 'Demir'.
*gs_structure-job = 'Police'.
*gs_structure-salary = 3200.
*gs_structure-curr = 'USD'.
*gs_structure-gsm = '+495252626'.
*gs_structure-e_mail = 'osmankartal@gmail.com'.
*
*INSERT zmk_table_01 FROM gs_structure.
*
*IF sy-subrc IS INITIAL.
*  MESSAGE 'Succesful Message' type 'S'.
*else.
*  MESSAGE 'Unsuccesful Message' TYPE 'S' DISPLAY LIKE 'E'.
*ENDIF.




*
*UPDATE zmk_table_01 SET job = 'Pilot'
*                        salary = 6000
*                        curr = 'EUR'
*                        where id = 0020220005.
*
*IF sy-subrc is initial.
*  MESSAGE 'Updata succesful' type 'S'.
*else.
*  MESSAGE 'Update Unsuccesful' type 'S' DISPLAY LIKE 'E'.
*
*ENDIF.





*DELETE FROM zmk_table_01 WHERE id = 0020220005.
*
*IF sy-subrc IS INITIAL.
*  MESSAGE 'Silme islemi basarili' TYPE 'S'.
*ELSE.
*  MESSAGE 'Silme Basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
*ENDIF.



DATA: gs_structure TYPE zmk_table_01,
      gt_table     TYPE TABLE OF zmk_table_01.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
PARAMETERS: p_id     TYPE zmk_table_01-id,
            p_name   TYPE zmk_table_01-name,
            p_sname  TYPE zmk_table_01-surname,
            p_job    TYPE zmk_table_01-job,
            p_salary TYPE zmk_table_01-salary,
            p_curr   TYPE zmk_table_01-curr,
            p_gsm    TYPE zmk_table_01-gsm,
            p_email  TYPE zmk_table_01-e_mail,
            p_create RADIOBUTTON GROUP rg1,
            p_read   RADIOBUTTON GROUP rg1,
            p_update RADIOBUTTON GROUP rg1,
            p_delete RADIOBUTTON GROUP rg1.
SELECTION-SCREEN END OF BLOCK a1.

IF p_create = abap_true.
  IF p_id IS INITIAL.
    MESSAGE 'ID Bilgisi Girmediniz' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = p_id.
    IF sy-subrc IS INITIAL.
      MESSAGE 'Girdiginiz ID bulunmaktadir bu yuzden ekelenemez' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      gs_structure-id       = p_id.
      gs_structure-name     = p_name.
      gs_structure-surname  = p_sname.
      gs_structure-job      = p_job.
      gs_structure-salary   = p_salary.
      gs_structure-curr     = p_curr.
      gs_structure-gsm      = p_gsm.
      gs_structure-e_mail   = p_email.

      INSERT zmk_table_01 FROM gs_structure.

      IF sy-subrc IS INITIAL.
        MESSAGE 'Yeni kayit gerceklesti' TYPE 'S'.
      ELSE.
        MESSAGE 'Yeni kayit basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.

    ENDIF.
  ENDIF.

ELSEIF p_read = abap_true.
  IF p_id IS INITIAL.
    SELECT * FROM zmk_table_01 INTO TABLE gt_table.
    IF sy-subrc IS INITIAL.
      LOOP AT gt_table INTO gs_structure.
        WRITE: / gs_structure-id,  / gs_structure-name,   / gs_structure-surname,
               / gs_structure-job, / gs_structure-salary, / gs_structure-curr,
               / gs_structure-gsm, / gs_structure-e_mail.
        CLEAR: gs_structure.
        SKIP.
        ULINE.
      ENDLOOP.
    ELSE.
      MESSAGE 'Tabloda Veri bulunmamaktadir' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ELSE.
    SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = p_id.
    IF sy-subrc IS INITIAL.
      WRITE:   / gs_structure-id,  / gs_structure-name,   / gs_structure-surname,
               / gs_structure-job, / gs_structure-salary, / gs_structure-curr,
               / gs_structure-gsm, / gs_structure-e_mail.
    ELSE.
      MESSAGE 'Girdiginiz Id Bilgisine Sahip Kisi Yok' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.

ELSEIF p_update = abap_true.
  IF p_id IS INITIAL.
    MESSAGE 'Lutfen ID Alanini Bos Birakmayiniz' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = p_id.
    IF sy-subrc IS INITIAL.
      UPDATE zmk_table_01 SET name      = p_name
                              surname   = p_sname
                              job       = p_job
                              salary    = p_salary
                              curr      = p_curr
                              gsm       = p_gsm
                              e_mail    = p_email WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        MESSAGE 'Update basarili' TYPE 'S'.
      ELSE.
        MESSAGE 'Update Basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ELSE.
      MESSAGE 'Girilen Id bilgisine sahip veri bulunmamaktadir' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.
ELSEIF p_delete = abap_true.
  IF p_id IS INITIAL.
    MESSAGE 'Lutfen ID Alanini Bos Birakmayiniz' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = p_id.
    IF sy-subrc IS INITIAL.
      DELETE FROM zmk_table_01 WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        MESSAGE 'Silme islemi basarili' TYPE 'S'.
      ELSE.
        MESSAGE 'Silme islmei basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ELSE.
      MESSAGE 'Girilen Id bilgisine sahip satir yok' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
   ENDIF.
ENDIF.
