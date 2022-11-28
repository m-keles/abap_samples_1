*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_13_calc_mit_func.

*PARAMETERS: p_num_01 TYPE i,
*            p_num_02 TYPE i,
*            p_topla  RADIOBUTTON GROUP gr1,
*            p_cikar  RADIOBUTTON GROUP gr1,
*            p_carp   RADIOBUTTON GROUP gr1,
*            p_bol    RADIOBUTTON GROUP gr1.
*
*DATA: gv_result TYPE p DECIMALS 2.
*
*IF p_topla = abap_true.
*  PERFORM toplama.
*ELSEIF p_cikar = abap_true.
*  PERFORM cikarma.
*ELSEIF p_carp = abap_true.
*  PERFORM carpma.
*ELSEIF p_bol = abap_true.
*  PERFORM bolme.
*ENDIF.
**&---------------------------------------------------------------------*
**&      Form  TOPLAMA
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM toplama.
*  DATA: lv_text TYPE string.
*  lv_text = 'Sonuc:'.
*  gv_result = p_num_01 + p_num_02.
*  WRITE: lv_text, gv_result.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  CIKARMA
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM cikarma.
*  DATA: lv_text TYPE string.
*  lv_text = 'Sonuc:'.
*  gv_result = p_num_01 - p_num_02.
*  WRITE: lv_text, gv_result.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  CARPMA
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM carpma .
*  gv_result = p_num_01 * p_num_02.
*  WRITE: gv_result.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  BOLME
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM bolme .
*  gv_result = p_num_01 / p_num_02.
*  WRITE: gv_result.
*ENDFORM.





*PARAMETERS: p_num_01 TYPE i,
*            p_num_02 TYPE i.
*
*DATA: gv_result TYPE i.
*
*CALL FUNCTION 'ZMK_FUNCTION_01'
*  EXPORTING
*    iv_number_01 = p_num_01
*    iv_number_02 = p_num_02
*  IMPORTING
*    ev_result    = gv_result.
*
*WRITE: gv_result.




PARAMETERS: p_num_01 TYPE i,
            p_num_02 TYPE i,
            p_symbol TYPE c LENGTH 1.

DATA: gv_result TYPE i.


CALL FUNCTION 'ZMK_FUNCTION_02'
  EXPORTING
    iv_number_01 = p_num_01
    iv_number_02 = p_num_02
    iv_symbol    = p_symbol
  IMPORTING
    ev_result    = gv_result.

WRITE: gv_result.
