*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_01_data_types.

*WRITE: 'Hello World'.
*
*uline.
*
*SKIP 3.
*
*WRITE: / 'Hello World 2'.

DATA: gv_char_01 TYPE c LENGTH 40.
DATA: gv_char_02 TYPE c LENGTH 40.
DATA: gv_char_03 TYPE c.  "type c length 1
DATA: gv_char_04.   " type c length 1
DATA: gv_char_05 TYPE c LENGTH 3.

gv_char_01 = 'Hallo'.
gv_char_02 = 'Hello'.
gv_char_05 = '100'.

WRITE gv_char_01.
WRITE gv_char_05.
WRITE: / gv_char_02.
