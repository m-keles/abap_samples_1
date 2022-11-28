*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_10_int_table_crud.

TYPES :BEGIN OF gty_satir,
         plaka_no    TYPE c LENGTH 10,
         marka       TYPE c LENGTH 25,
         model       TYPE string,
         renk        TYPE c LENGTH 12,
         motor_cc    TYPE n LENGTH 4,
         uretim_yili TYPE c LENGTH 4,
         fiyat       TYPE i,
         kilometre   TYPE i,
       END OF gty_satir.
DATA: gs_satir TYPE gty_satir,   "Bu bir structure
      gt_tablo TYPE TABLE OF gty_satir.   "Bu bir internal table

gs_satir-plaka_no = '34 AB 2025'.
gs_satir-marka = 'Citroen'.
gs_satir-model = 'Picasso'.
gs_satir-renk ='Lacivert'.
gs_satir-motor_cc = 1600.
gs_satir-uretim_yili = '2015'.
gs_satir-fiyat = 150000.
gs_satir-kilometre = 80000.

APPEND gs_satir TO gt_tablo.
CLEAR: gs_satir.

gs_satir-plaka_no = '23 DE 3476'.
gs_satir-marka = 'Volvo'.
gs_satir-model = 'S40'.
gs_satir-renk ='Beyaz'.
gs_satir-motor_cc = 2000.
gs_satir-uretim_yili = '2020'.
gs_satir-fiyat = 200000.
gs_satir-kilometre = 50000.

APPEND gs_satir TO gt_tablo.
CLEAR: gs_satir.

gs_satir-plaka_no = '16 ZR 9687'.
gs_satir-marka = 'Audi'.
gs_satir-model = 'A3'.
gs_satir-renk ='Siyah'.
gs_satir-motor_cc = 2000.
gs_satir-uretim_yili = '2014'.
gs_satir-fiyat = 170000.
gs_satir-kilometre = 120000.

APPEND gs_satir TO gt_tablo.
CLEAR: gs_satir.

"Create, Read, Update, Delete   CRUD Operations

*READ TABLE gt_tablo INTO gs_satir INDEX 2.
*IF sy-subrc IS INITIAL.
*  WRITE: gs_satir-plaka_no, / gs_satir-marka, / gs_satir-model,
*   / gs_satir-renk, / gs_satir-motor_cc, / gs_satir-uretim_yili,
*   / gs_satir-fiyat, / gs_satir-kilometre.
*  SKIP.
*  ULINE.
*  CLEAR: gs_satir.
*ENDIF.
*
*READ TABLE gt_tablo INTO gs_satir INDEX 2.
*IF sy-subrc IS INITIAL.
*  gs_satir-kilometre = gs_satir-kilometre + 10000.
*  gs_satir-renk = 'Kirmizi'.
*  MODIFY gt_tablo FROM gs_satir INDEX 2.
*  CLEAR: gs_satir.
*ENDIF.
*
*READ TABLE gt_tablo INTO gs_satir INDEX 2.
*IF sy-subrc IS INITIAL.
*  WRITE: gs_satir-plaka_no, / gs_satir-marka, / gs_satir-model,
*   / gs_satir-renk, / gs_satir-motor_cc, / gs_satir-uretim_yili,
*   / gs_satir-fiyat, / gs_satir-kilometre.
*
*  CLEAR: gs_satir.
*ENDIF.







*LOOP AT gt_tablo INTO gs_satir WHERE fiyat >= 170000.
*  gs_satir-kilometre = gs_satir-kilometre + 10000.
*  gs_satir-fiyat = gs_satir-fiyat + 10000.
*  MODIFY gt_tablo FROM gs_satir INDEX sy-tabix.
*  CLEAR: gs_satir.
*ENDLOOP.
*
*LOOP AT gt_tablo INTO gs_satir.
*  WRITE: gs_satir-plaka_no, / gs_satir-marka, / gs_satir-model,
*   / gs_satir-renk, / gs_satir-motor_cc, / gs_satir-uretim_yili,
*   / gs_satir-fiyat, / gs_satir-kilometre.
*  SKIP.
*  ULINE.
*  CLEAR: gs_satir.
*ENDLOOP.






*gs_satir-plaka_no = '16 ZR 9687'.
*gs_satir-marka = 'Audi'.
*gs_satir-model = 'A3'.
*gs_satir-renk ='Mavi'.
*gs_satir-motor_cc = 3000.
*gs_satir-uretim_yili = '2014'.
*gs_satir-fiyat = 170000.
*gs_satir-kilometre = 120000.
*
*MODIFY gt_tablo FROM gs_satir TRANSPORTING renk motor_cc WHERE plaka_no = gs_satir-plaka_no.
*CLEAR: gs_satir.
*READ TABLE gt_tablo INTO gs_satir WITH KEY plaka_no = '16 ZR 9687'.
*IF sy-subrc IS INITIAL.
*  WRITE: gs_satir-plaka_no, / gs_satir-marka, / gs_satir-model,
*   / gs_satir-renk, / gs_satir-motor_cc, / gs_satir-uretim_yili,
*   / gs_satir-fiyat, / gs_satir-kilometre.
*ENDIF.








*READ TABLE gt_tablo INTO gs_satir INDEX 1.
*IF sy-subrc IS INITIAL.
*  WRITE: gs_satir-plaka_no, / gs_satir-marka, / gs_satir-model,
*     / gs_satir-renk, / gs_satir-motor_cc, / gs_satir-uretim_yili,
*     / gs_satir-fiyat, / gs_satir-kilometre.
*  CLEAR: gs_satir.
*ENDIF.
*DELETE gt_tablo INDEX 1.
*SKIP.
*ULINE.
*READ TABLE gt_tablo INTO gs_satir INDEX 1.
*IF sy-subrc IS INITIAL.
*  WRITE: gs_satir-plaka_no, / gs_satir-marka, / gs_satir-model,
*     / gs_satir-renk, / gs_satir-motor_cc, / gs_satir-uretim_yili,
*     / gs_satir-fiyat, / gs_satir-kilometre.
*  CLEAR: gs_satir.
*ENDIF.





DELETE gt_tablo WHERE marka NE 'Audi'.
LOOP AT gt_tablo INTO gs_satir.
  WRITE: gs_satir-plaka_no, / gs_satir-marka, / gs_satir-model,
       / gs_satir-renk, / gs_satir-motor_cc, / gs_satir-uretim_yili,
       / gs_satir-fiyat, / gs_satir-kilometre.
ENDLOOP.
