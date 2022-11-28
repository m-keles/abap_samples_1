*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_06_calc.

*PARAMETERS: p_num1   TYPE i OBLIGATORY,
*            p_num2   TYPE i OBLIGATORY,
*            p_topla  RADIOBUTTON GROUP gr1,
*            p_cikar  RADIOBUTTON GROUP gr1,
*            p_carpma RADIOBUTTON GROUP gr1,
*            p_bolme  RADIOBUTTON GROUP gr1,
*            p_mesg   AS CHECKBOX.
*
*DATA: gv_sonuc TYPE p DECIMALS 2.
*
*IF p_num1 IS INITIAL OR p_num2 IS INITIAL.
*  MESSAGE 'Lutfen her iki sayi hucresinide doldurunuz' TYPE 'S' DISPLAY LIKE 'E'.
*  EXIT.
*ENDIF.
*
*IF p_topla IS NOT INITIAL. "Eger kullanici p_topla butonunu secmisse
*
*  gv_sonuc = p_num1 + p_num2.
*
*  WRITE: 'Yapilan islem: Toplama, Sonuc: ', gv_sonuc.
*
*ELSEIF p_cikar IS NOT INITIAL.
*
*  gv_sonuc = p_num1 - p_num2.
*  WRITE: 'Yapilan islem: Cikarma, Sonuc: ', gv_sonuc.
*
*ELSEIF p_carpma IS NOT INITIAL.
*  gv_sonuc = p_num1 * p_num2.
*  WRITE: 'Yapilan islem: Carpma, Sonuc: ', gv_sonuc.
*
*ELSEIF p_bolme IS NOT INITIAL.
*  gv_sonuc = p_num1 / p_num2.
*  WRITE: 'Yapilan islem: Bolme, Sonuc: ', gv_sonuc.
*ENDIF.
*
*IF p_mesg is NOT INITIAL.
*    MESSAGE 'Isleminiz basarili bir sekilde tamamlandi' TYPE 'S'.
*ENDIF.




"Ohne 0 Division

*PARAMETERS: p_num1   TYPE i OBLIGATORY,
*            p_num2   TYPE i OBLIGATORY,
*            p_symbol TYPE c LENGTH 1.
*
*DATA: gv_sonuc TYPE p DECIMALS 2.
*
*CASE p_symbol.
*  WHEN '+'.
*    gv_sonuc = p_num1 + p_num2.
*    WRITE: gv_sonuc.
*  WHEN '-'.
*    gv_sonuc = p_num1 - p_num2.
*    WRITE: gv_sonuc.
*  WHEN '*'.
*    gv_sonuc = p_num1 * p_num2.
*    WRITE: gv_sonuc.
*  WHEN '/'.
*    gv_sonuc = p_num1 / p_num2.
*    WRITE: gv_sonuc.
*  WHEN OTHERS.
*    MESSAGE 'Yanlis bir islem kodu girdiniz' TYPE 'S' DISPLAY LIKE 'E'.
*ENDCASE.





"Mit 0 Division
PARAMETERS: pa_zahl1 TYPE i,
            pa_zahl2 TYPE i,
            pa_op    TYPE c LENGTH 1.


DATA gv_result TYPE p LENGTH 16 DECIMALS 2.

IF ( pa_op = '+' OR
     pa_op = '-' OR
     pa_op = '*' OR
     pa_op = '/' AND pa_zahl2 <> 0
  ).
*  at SELECTION-SCREEN.
*    if pa_zahl2 > 1000 or pa_zahl1 > 1000.
*      MESSAGE 'Die Zahl miss kleiner 1000 sein' TYPE 'I'.
*      endif.
*      START-OF-SELECTION.

  CASE  pa_op.
    WHEN '+'.
      gv_result = pa_zahl1 + pa_zahl2.

    WHEN '-'.
      gv_result = pa_zahl1 - pa_zahl2.

    WHEN '*'.
      gv_result = pa_zahl1 * pa_zahl2.

    WHEN '/'.
      gv_result = pa_zahl1 / pa_zahl2.
  ENDCASE.

  WRITE :' Das Ergebniss : '(res), gv_result LEFT-JUSTIFIED.

ELSEIF pa_op = '/' AND pa_zahl2 = 0.
  WRITE : ' Zahl2 muss anders als 0'(nul).
  MESSAGE s011(zbc400_09) WITH pa_zahl2.
  RETURN.
ELSE.
  MESSAGE i010(zbc400_09) WITH pa_op.
*MESSAGE 'Falscher Operator ausgewählt'(fop) TYPE 'I'.
* WRITE : ' The Operator ist Falsch'(fop).
  RETURN.

ENDIF.
