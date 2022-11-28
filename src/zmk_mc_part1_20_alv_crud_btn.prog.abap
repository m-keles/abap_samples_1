*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_17_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_20_alv_crud_btn.
"Bu Programda GUI Status konusu islenmektedir. SE41 tCode aciyoruz. Program bolumune SAPLSLVC_FULLSCREEN
" Program adina yaziyoruz. Status bolumune STANDARD_FULLSCREEN yaziyoruz. Daha sonra ustteki Status bolumune tikliyoruz.
" Acilan ekranda Program bolumune kopyalamak istedigimiz program adini yaziyoruz. Status bolumune ise herhangi bir status
" ismi vermek gereklidir. Daha sonra Kopyala bolumunu tikliyoruz.

TABLES: zmk_table_01.
DATA: gt_table TYPE TABLE OF zmk_table_01,
      gs_str   TYPE zmk_table_01.
DATA: gt_fcat   TYPE lvc_t_fcat,
      gs_layout TYPE lvc_s_layo.
PERFORM get_data.
PERFORM set_layo.
PERFORM set_fcat.
PERFORM display_data.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM zmk_table_01 INTO CORRESPONDING FIELDS OF TABLE gt_table.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYO
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM set_layo .
  gs_layout-zebra = 'X'.
  gs_layout-cwidth_opt = 'X'.
  gs_layout-sel_mode = 'A'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM set_fcat .
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'zmk_table_01'
      i_bypassing_buffer     = 'X'
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_DATA
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM display_data .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fcat
      i_callback_pf_status_set = 'MY_STATUS_101'
      i_callback_user_command  = 'MY_COMMAND_101'
    TABLES
      t_outtab                 = gt_table
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
ENDFORM.


FORM my_status_101 USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_101'.
ENDFORM.

FORM my_command_101 USING rucomm TYPE sy-ucomm
                          selfield TYPE slis_selfield.

  CASE rucomm.
    WHEN 'BACK_NEU'.
      selfield-refresh = abap_true.
      LEAVE PROGRAM.
    WHEN 'SORT_NAME'.
      SORT gt_table BY name ASCENDING.   "Kucukten buyuge ASCENDING     Buyukten Kucuge DESCENDING   Hicbirsey yazmazsak default olarak ascending yapar.
      PERFORM display_data.
    WHEN 'SORT_SNAME'.
      SORT gt_table BY surname DESCENDING.
      PERFORM display_data.
    WHEN 'DELETE_ROW'.
      PERFORM delete_row.
    WHEN 'FIND_ROW'.
      PERFORM find_row.
    WHEN 'UPDATE_ROW'.
      PERFORM update_row.
    WHEN 'NEW_ROW'.
      PERFORM new_row.
*  	WHEN OTHERS.
  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DELETE_ROW
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM delete_row.
  DATA: lc_grid       TYPE REF TO cl_gui_alv_grid,
        lt_index_rows TYPE lvc_t_row,
        lt_row_no     TYPE lvc_t_roid,
        ls_row_no     TYPE lvc_s_roid,
        lt_table_del  TYPE TABLE OF zmk_table_01,
        ls_table_del  TYPE zmk_table_01.

  CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
    IMPORTING
      e_grid = lc_grid.


  CALL METHOD lc_grid->get_selected_rows
    IMPORTING
      et_index_rows = lt_index_rows
      et_row_no     = lt_row_no.

  IF lt_row_no IS INITIAL.
    MESSAGE 'Lutfen en az bir satir seciniz' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.


  LOOP AT lt_row_no INTO ls_row_no.
    READ TABLE gt_table INTO gs_str INDEX ls_row_no-row_id.

    APPEND gs_str TO lt_table_del.
    CLEAR: gs_str.

  ENDLOOP.

  LOOP AT lt_table_del INTO ls_table_del.
    DELETE gt_table WHERE id = ls_table_del-id.
  ENDLOOP.

  PERFORM display_data.




ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIND_ROW
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM find_row.

  "Popup_Get_Values fonksiyonunun exproting bolumunde returncode tipine baktik.
  "Bu degerin bos ya A degerini alabilecegi icin c length 1 verdik.

  DATA: lv_return     TYPE c LENGTH 1,
        lt_fields     TYPE TABLE OF sval,
        ls_fields     TYPE sval,
        lt_table_find TYPE TABLE OF zmk_table_01,
        lt_fcat_find  TYPE slis_t_fieldcat_alv.

  ls_fields-tabname = 'ZMK_TABLE_01'.
  ls_fields-fieldname = 'ID'.
  APPEND ls_fields TO lt_fields.

  CALL FUNCTION 'POPUP_GET_VALUES'
    EXPORTING
      popup_title     = 'Please write an ID'
    IMPORTING
      returncode      = lv_return
    TABLES
      fields          = lt_fields
    EXCEPTIONS
      error_in_fields = 1.


  IF lv_return IS INITIAL.
    READ TABLE lt_fields INTO ls_fields INDEX 1.
    IF sy-subrc IS INITIAL.
      READ TABLE gt_table WITH KEY id = ls_fields-value INTO gs_str.
      IF sy-subrc IS INITIAL.
        APPEND gs_str TO lt_table_find.
        CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
          EXPORTING
            i_structure_name       = 'ZMK_TABLE_01'
            i_bypassing_buffer     = 'X'
          CHANGING
            ct_fieldcat            = lt_fcat_find
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2.

        CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
          EXPORTING
            i_title       = 'The line with the entered ID information is below.'
            i_tabname     = 'LT_TABLE_FIND'
            it_fieldcat   = lt_fcat_find
          TABLES
            t_outtab      = lt_table_find
          EXCEPTIONS
            program_error = 1.
      ENDIF.
    ENDIF.
  ENDIF.





ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  UPDATE_ROW
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM update_row.

  DATA: lc_grid         TYPE REF TO cl_gui_alv_grid,  "ok
        lt_index_rows   TYPE lvc_t_row, "ok
        lt_row_no       TYPE lvc_t_roid, "ok
        ls_row_no       TYPE lvc_s_roid,  "ok
        lv_no_lines     TYPE i,  "ok
        lt_table_update TYPE TABLE OF zmk_table_01,   "ok
        ls_table_update TYPE zmk_table_01,  "ok
        lt_fcat_update  TYPE slis_t_fieldcat_alv,  "ok
        ls_fcat_update  TYPE slis_fieldcat_alv,  "ok
        answer.   "ok

  CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
    IMPORTING
      e_grid = lc_grid.

  CALL METHOD lc_grid->get_selected_rows
    IMPORTING
      et_index_rows = lt_index_rows
      et_row_no     = lt_row_no.

  DESCRIBE TABLE lt_row_no LINES lv_no_lines.


  IF lv_no_lines NE 1.
    MESSAGE 'Lütfen bir satir seciniz!' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ELSE.
    READ TABLE lt_row_no INTO ls_row_no INDEX 1.
    CHECK sy-subrc IS INITIAL.
    READ TABLE gt_table INTO gs_str INDEX ls_row_no-row_id.
    CHECK sy-subrc IS INITIAL.
    APPEND gs_str TO lt_table_update.
    CLEAR: gs_str.


    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZMK_TABLE_01'
      CHANGING
        ct_fieldcat            = lt_fcat_update
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2.

    LOOP AT lt_fcat_update INTO ls_fcat_update.
      CASE ls_fcat_update-fieldname.
        WHEN 'NAME' OR 'SURNAME' OR 'JOB' OR 'SALARY' OR 'CURR' OR 'GSM' OR 'E_MAIL'.
          ls_fcat_update-edit = 'X'.
          ls_fcat_update-input = 'X'.
          MODIFY lt_fcat_update FROM ls_fcat_update.
      ENDCASE.
    ENDLOOP.


    CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
      EXPORTING
        i_title       = 'You can enter an Info from here.'
        i_tabname     = 'LT_TABLE_UPDATE'
        it_fieldcat   = lt_fcat_update
      TABLES
        t_outtab      = lt_table_update
      EXCEPTIONS
        program_error = 1.

    READ TABLE lt_table_update INTO ls_table_update INDEX 1.

    CHECK sy-subrc IS INITIAL.

    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        text_question         = 'Do you approve the changes?'
        text_button_1         = 'Yes'
        icon_button_1         = 'ICON_CHECKED'
        text_button_2         = 'No'
        icon_button_2         = 'ICON_CANCEL'
        display_cancel_button = ''
      IMPORTING
        answer                = answer
      EXCEPTIONS
        text_not_found        = 1.

    IF answer = '1'.
      MOVE-CORRESPONDING ls_table_update TO gs_str.
      UPDATE zmk_table_01 SET  name       = gs_str-name
                               surname    = gs_str-surname
                               job        = gs_str-job
                               salary     = gs_str-salary
                               curr       = gs_str-curr
                               gsm        = gs_str-gsm
                               e_mail     = gs_str-e_mail WHERE id = gs_str-id.
      REFRESH gt_table.
      PERFORM get_data.
      MESSAGE 'Yapilan degisiklikler basariyla kaydedildi.' TYPE 'S'.
      PERFORM display_data.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  NEW_ROW
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM new_row .
  DATA: lt_fcat_new  TYPE slis_t_fieldcat_alv,
        ls_fcat_new  TYPE slis_fieldcat_alv,
        lt_table_new TYPE TABLE OF zmk_table_01,
        ls_table_new TYPE zmk_table_01.
  DATA: lt_index_rows TYPE lvc_t_row,
        lt_row_no     TYPE lvc_t_roid,
        ls_row_no     TYPE lvc_s_roid,
        answer.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-repid
      i_structure_name       = 'ZMK_TABLE_01'
    CHANGING
      ct_fieldcat            = lt_fcat_new
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.


  LOOP AT lt_fcat_new INTO ls_fcat_new.
    CASE ls_fcat_new-fieldname.
      WHEN 'ID' OR 'NAME' OR 'SURNAME' OR 'JOB' OR 'SALARY' OR 'CURR' OR
     'GSM' OR 'E_MAIL'.
        ls_fcat_new-edit = 'X'.
        ls_fcat_new-input = 'X'.
        MODIFY lt_fcat_new FROM ls_fcat_new.
    ENDCASE.
  ENDLOOP.
  APPEND ls_table_new TO lt_table_new.


  CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
    EXPORTING
      i_title               = 'Lütfen bilgileri giriniz.'
      i_screen_start_column = 5
      i_screen_start_line   = 13
      i_screen_end_column   = 120
      i_screen_end_line     = 18
      i_tabname             = 'LT_TABLE_NEW'
      it_fieldcat           = lt_fcat_new
    IMPORTING
      e_exit                = answer
    TABLES
      t_outtab              = lt_table_new
    EXCEPTIONS
      program_error         = 1
      OTHERS                = 2.

  IF answer IS INITIAL.
    READ TABLE lt_table_new INTO ls_table_new INDEX 1.
    INSERT zmk_table_01 FROM ls_table_new.
    IF sy-subrc IS INITIAL.
      REFRESH gt_table.
      PERFORM get_data.
      MESSAGE 'Yeni kayit basariyla eklendi' TYPE 'S'.
      PERFORM display_data.
    ELSE.
      MESSAGE 'Yeni kayit ekleme islemi basarisiz oldu.' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.

ENDFORM.
