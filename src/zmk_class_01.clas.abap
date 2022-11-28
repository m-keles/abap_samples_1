class ZMK_CLASS_01 definition
  public
  final
  create public .

public section.

  data GS_STRUCTURE type ZMK_TABLE_01 .
  data GT_TABLE type ZMK_TT_TABLE_01 .

  methods READ
    importing
      !ID_OF_EMPLOYEE type ZMK_TABLE_01-ID .
  methods CREATE
    importing
      !ID_OF_EMPLOYEE type ZMK_TABLE_01-ID
      !NAME_OF_EMPLOYEE type ZMK_TABLE_01-NAME
      !SURNAME_OF_EMPLOYEE type ZMK_TABLE_01-SURNAME
      !JOB_OF_EMPLOYEE type ZMK_TABLE_01-JOB
      !SALARY_OF_EMPLOYEE type ZMK_TABLE_01-SALARY
      !CURR_OF_EMPLOYEE type ZMK_TABLE_01-CURR
      !GSM_OF_EMPLOYEE type ZMK_TABLE_01-GSM
      !E_MAIL_OF_EMPLOYEE type ZMK_TABLE_01-E_MAIL .
  methods UPDATE
    importing
      !ID_OF_EMPLOYEE type ZMK_TABLE_01-ID
      !NAME_OF_EMPLOYEE type ZMK_TABLE_01-NAME
      !SURNAME_OF_EMPLOYEE type ZMK_TABLE_01-SURNAME
      !JOB_OF_EMPLOYEE type ZMK_TABLE_01-JOB
      !SALARY_OF_EMPLOYEE type ZMK_TABLE_01-SALARY
      !CURR_OF_EMPLOYEE type ZMK_TABLE_01-CURR
      !GSM_OF_EMPLOYEE type ZMK_TABLE_01-GSM
      !E_MAIL_OF_EMPLOYEE type ZMK_TABLE_01-E_MAIL .
  methods DELETE
    importing
      !ID_OF_EMPLOYEE type ZMK_TABLE_01-ID .
protected section.
private section.
ENDCLASS.



CLASS ZMK_CLASS_01 IMPLEMENTATION.


  METHOD create.
*    DATA: gs_structure TYPE zmk_table_01. "Attributta global degisken tanimladigimiz icin gerek kalmadi
    IF id_of_employee IS INITIAL.
      MESSAGE 'ID Bilgisi Girmediniz' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = id_of_employee.
      IF sy-subrc IS INITIAL.
        MESSAGE 'Girdiginiz ID bulunmaktadir bu yuzden ekelenemez' TYPE 'S' DISPLAY LIKE 'E'.
      ELSE.
        gs_structure-id       = id_of_employee.
        gs_structure-name     = name_of_employee.
        gs_structure-surname  = surname_of_employee.
        gs_structure-job      = job_of_employee.
        gs_structure-salary   = salary_of_employee.
        gs_structure-curr     = curr_of_employee.
        gs_structure-gsm      = gsm_of_employee.
        gs_structure-e_mail   = e_mail_of_employee.

        INSERT zmk_table_01 FROM gs_structure.

        IF sy-subrc IS INITIAL.
          MESSAGE 'Yeni kayit gerceklesti' TYPE 'S'.
        ELSE.
          MESSAGE 'Yeni kayit basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD delete.
*    DATA: gt_table     TYPE TABLE OF zmk_table_01,      "Attributa global olarak eklendigi icin gerek kalmadi
*          gs_structure TYPE zmk_table_01.
    IF id_of_employee IS INITIAL.
      MESSAGE 'Id bilgisi olmadan silme islemi yapilamaz' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = id_of_employee.
      IF sy-subrc IS INITIAL.
        DELETE FROM zmk_table_01 WHERE id = id_of_employee.
        IF sy-subrc IS INITIAL.
          MESSAGE 'Silem islemi basarili' TYPE 'S'.
        ELSE.
          MESSAGE 'Silme islemi basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE 'Girilen Id bilgisine sahip satir bulunmamaktadir.' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD read.
*    DATA: gt_table     TYPE TABLE OF zmk_table_01,  "Attribtta tanimladigimiz icin buna gerek olmadi
*          gs_structure TYPE zmk_table_01.


    IF id_of_employee IS INITIAL.
      SELECT * FROM zmk_table_01 INTO TABLE gt_table.
      IF sy-subrc IS INITIAL.
        LOOP AT gt_table INTO gs_structure.
          WRITE: / gs_structure-id,  / gs_structure-name,   / gs_structure-surname,
                 / gs_structure-job, / gs_structure-salary, / gs_structure-curr,
                 / gs_structure-gsm, / gs_structure-e_mail.
          SKIP.
          ULINE.
          CLEAR: gs_structure.
        ENDLOOP.
      ELSEIF sy-subrc IS NOT INITIAL.
        MESSAGE 'Tabloda Veri Bulunmamaktadir' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ELSEIF id_of_employee IS NOT INITIAL.
      SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = id_of_employee.
      IF sy-subrc IS INITIAL.
        WRITE: / gs_structure-id,  / gs_structure-name,   / gs_structure-surname,
                 / gs_structure-job, / gs_structure-salary, / gs_structure-curr,
                 / gs_structure-gsm, / gs_structure-e_mail.
      ELSEIF sy-subrc IS NOT INITIAL.
        MESSAGE 'Girdiginiz ID Bilgisine Sahip Veri bulunmamaktadir' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD update.
*    DATA: gt_table     TYPE TABLE OF zmk_table_01,    "Atrributa global degisken ekledigimiz icin gerek kalmadi
*          gs_structure TYPE zmk_table_01.

    IF id_of_employee IS INITIAL.
      MESSAGE 'Lutfen ID Alanini Bos Birakmayiniz' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      SELECT SINGLE * FROM zmk_table_01 INTO gs_structure WHERE id = id_of_employee.
      IF sy-subrc IS INITIAL.
        UPDATE zmk_table_01 SET name      = name_of_employee
                                surname   = surname_of_employee
                                job       = job_of_employee
                                salary    = salary_of_employee
                                curr      = curr_of_employee
                                gsm       = gsm_of_employee
                                e_mail    = e_mail_of_employee WHERE id = id_of_employee.
        IF sy-subrc IS INITIAL.
          MESSAGE 'Update basarili' TYPE 'S'.
        ELSE.
          MESSAGE 'Update Basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE 'Girilen Id bilgisine sahip veri bulunmamaktadir' TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
