*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_17_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_19_reuse.
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
    WHEN 'SORT_NAME'.
      SORT gt_table BY name ASCENDING.   "Kucukten buyuge ASCENDING     Buyukten Kucuge DESCENDING   Hicbirsey yazmazsak default olarak ascending yapar.
      PERFORM display_data.
    WHEN 'SORT_SNAME'.
      SORT gt_table BY surname DESCENDING.
      PERFORM display_data.
    WHEN 'DELETE_ROW'.
      PERFORM delete_row.
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
