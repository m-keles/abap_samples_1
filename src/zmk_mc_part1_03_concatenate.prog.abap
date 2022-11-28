*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_03_concatenate.

" Concatenate komutu sadece string, n, c, datum ve uzeit icin calisir.

DATA: gv_mahalle    TYPE string,
      gv_cadde      TYPE string,
      gv_no         TYPE string,
      gv_pk         TYPE string,
      gv_ilce       TYPE string,
      gv_il         TYPE string,
      gv_adres      TYPE string,

      gv_char       TYPE c LENGTH 40,
      gv_string_01  TYPE string,
      gv_string_02  TYPE string,
      gv_string_03  TYPE string,
      gv_number     TYPE n LENGTH 1,

      gv_integer_01 TYPE i,

      gv_number_02  TYPE n LENGTH 3,
      gv_number_03  TYPE n LENGTH 3.




gv_mahalle = 'Mimar Sinan pasa Mahallesi'.
gv_cadde   = 'Cumhuriyet Caddesi'.
gv_no = '17/4'.
gv_pk = '34234'.
gv_ilce = 'Uskudar'.
gv_il = 'Istanbul'.

gv_char = 'Sap Abap'.
gv_string_01 = 'asd'.
gv_string_02 = 'dfg'.
gv_number = 1.

gv_integer_01 = 500.

gv_number_02 = 20.
gv_number_03 = 30.



CONCATENATE 'Adres: ' gv_mahalle ', ' gv_cadde ', ' gv_no ', ' gv_pk ', ' gv_ilce ', ' gv_il '.' INTO gv_adres RESPECTING BLANKS.
WRITE gv_adres.

*CONCATENATE gv_char gv_string_01 gv_number gv_string_02 into gv_string_03 SEPARATED BY space.
CONCATENATE gv_char gv_string_01 gv_number gv_string_02 INTO gv_string_03 SEPARATED BY '111'.
WRITE: / gv_string_03.



IF gv_integer_01 < 100.
  WRITE: / 'Girilen Sayi 100''den kucuktur'.
ELSEIF gv_integer_01 = 100.
  WRITE: / 'Girilen sayi 100 e esittir'.
ELSE.
  WRITE: / 'Girilen sayi 100 den buyuktur'.
ENDIF.


IF gv_number_02 = gv_number_03.
  WRITE: 'Girilen iki sayi esittir.'.
ELSE.
  WRITE: / 'Girilen iki sayi birbirine esit degildir'.
ENDIF.
