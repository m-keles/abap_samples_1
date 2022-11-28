*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_15_reuse_alv.

TYPES: BEGIN OF gty_table,
         box TYPE c LENGTH 1.
         INCLUDE STRUCTURE zmk_table_01.
       TYPES: END OF gty_table.

DATA: gt_table    TYPE TABLE OF gty_table,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.


*DATA: gt_table    TYPE TABLE OF zmk_table_01,
*      gt_fieldcat TYPE slis_t_fieldcat_alv,
*      gs_layout   TYPE slis_layout_alv.

SELECT * FROM zmk_table_01 INTO CORRESPONDING FIELDS OF TABLE gt_table.

CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
  EXPORTING
*   I_PROGRAM_NAME         =
*   I_INTERNAL_TABNAME     =
    i_structure_name       = 'ZMK_TABLE_01'
*   I_CLIENT_NEVER_DISPLAY = 'X'
*   I_INCLNAME             =
    i_bypassing_buffer     = 'X'
*   I_BUFFER_ACTIVE        =
  CHANGING
    ct_fieldcat            = gt_fieldcat
  EXCEPTIONS
    inconsistent_interface = 1
    program_error          = 2.



gs_layout-zebra = 'X'.  "Bir acik bir koyu renk
gs_layout-colwidth_optimize = 'X'.    "Bosluklari alir
gs_layout-box_fieldname = 'BOX'.


CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program = sy-repid          " 'Z09_MK_MABI_15'  Su anda hangi raporda bulunuyorsaniz
    is_layout          = gs_layout    "Reuse alv Grid Display ustune tiklayip importtan is_layout tipini bulup structure olsuturduk.
    it_fieldcat        = gt_fieldcat   "gt_fieldcat bolumunu yukarda bos verdik. O bize doldurup geri verdi.
  TABLES
    t_outtab           = gt_table   "Hangi tablonun alv sini almak istiyorsak onu yaziyoruz.
  EXCEPTIONS
    program_error      = 1.
