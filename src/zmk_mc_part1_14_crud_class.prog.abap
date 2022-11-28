*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_14_crud_class.

DATA: gc_class TYPE REF TO zmk_class_01.

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

CREATE OBJECT gc_class.

IF p_read = abap_true.
  CALL METHOD gc_class->read
    EXPORTING
      id_of_employee = p_id.

ELSEIF p_create = abap_true.
  CALL METHOD gc_class->create
    EXPORTING
      id_of_employee      = p_id
      name_of_employee    = p_name
      surname_of_employee = p_sname
      job_of_employee     = p_job
      salary_of_employee  = p_salary
      curr_of_employee    = p_curr
      gsm_of_employee     = p_gsm
      e_mail_of_employee  = p_email.

ELSEIF p_update = abap_true.
  CALL METHOD gc_class->update
    EXPORTING
      id_of_employee      = p_id
      name_of_employee    = p_name
      surname_of_employee = p_sname
      job_of_employee     = p_job
      salary_of_employee  = p_salary
      curr_of_employee    = p_curr
      gsm_of_employee     = p_gsm
      e_mail_of_employee  = p_email.

ELSEIF p_delete = abap_true.
  CALL METHOD gc_class->delete
    EXPORTING
      id_of_employee = p_id.

ENDIF.
