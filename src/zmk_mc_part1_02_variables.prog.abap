*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_02_variables.

DATA: gv_number_01 TYPE n LENGTH 6. "sayi veya text verebiliyoruz. fakat text ile sayisal islem yapmaya izin vermiyor.
DATA: gv_number_02 TYPE n LENGTH 6. "n tipinin en karakteristik ozelligi bos haneleri 0 ile doldurur
DATA: gv_number_03 TYPE n LENGTH 6.
DATA: gv_number_04 TYPE n LENGTH 6.
DATA: gv_integer_01 TYPE i.
DATA: gv_integer_02 TYPE i.
DATA: gv_integer_03 TYPE i.
DATA: gv_decimal_01 TYPE p DECIMALS 13.
DATA: gv_integer_04 TYPE i.
DATA: gv_integer_05 TYPE i.
DATA: gv_string_01 TYPE string.
DATA: gv_date_01 TYPE datum.
DATA: gv_time_01 TYPE uzeit.

gv_number_01 = 'aa'.
gv_number_02 = 20. "Tercihen bu sekilde yazilir
gv_number_03 = gv_number_01 + gv_number_02.
gv_integer_01 = '100'.
gv_integer_02 = 200.  "Tercihen bu sekilde kullanilir
gv_integer_03 = gv_integer_01 - gv_integer_02.
gv_integer_04 = 200.
gv_integer_05 = 6.
gv_decimal_01 = gv_integer_04 / gv_integer_05.
gv_string_01 = 'Hello world'.
gv_date_01 = '20220212'.
gv_time_01 = '205200'.

WRITE gv_number_03.
WRITE gv_number_01.
WRITE gv_integer_01.
WRITE gv_integer_02.
WRITE gv_integer_03.
WRITE: / gv_decimal_01.
WRITE: / gv_string_01.
WRITE: / gv_date_01.
WRITE: / gv_time_01.
WRITE: / sy-datum.
WRITE: / sy-uzeit.
