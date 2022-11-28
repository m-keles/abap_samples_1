*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_16_reuse_fcat.

DATA: gt_table TYPE TABLE OF zmk_table_01,
      gt_fcat  TYPE lvc_t_fcat,
      gs_layout TYPE LVC_S_LAYO.

SELECT * FROM zmk_table_01 INTO TABLE gt_table.

CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
  EXPORTING
    i_structure_name       = 'ZMK_TABLE_01'
    i_bypassing_buffer     = 'X'
  CHANGING
    ct_fieldcat            = gt_fcat
  EXCEPTIONS
    inconsistent_interface = 1
    program_error          = 2.


gs_layout-zebra = 'X'.
gs_layout-cwidth_opt = 'X'.
gs_layout-sel_mode = 'A'.


CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
 EXPORTING
   IS_LAYOUT_LVC                     = gs_layout
   IT_FIELDCAT_LVC                   = gt_fcat
  TABLES
    t_outtab                          = gt_table
 EXCEPTIONS
   PROGRAM_ERROR                     = 1.
