*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_05_sel_screen.

*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME title text-004 NO INTERVALS.
*PARAMETERS: p_number type i.
*SELECTION-SCREEN END OF block a1.
*
*IF p_number < 100.
*  MESSAGE text-001 type 'I'.
*elseif p_number = 100.
*  MESSAGE text-002 type 'I'.
*ELSEIF p_number > 100.
*  MESSAGE text-003 type 'I'.
*ENDIF.






*data: gv_integer type i.
*
*gv_integer = 20.
*
*DO 20 TIMES.
*  gv_integer = gv_integer + 5.
*ENDDO.
*
*write: gv_integer.






*data: gv_integer type i.
*gv_integer  = 50.
*DO.
*  gv_integer = gv_integer + 10.
*  IF gv_integer = 200.
*    exit.
*  ENDIF.
*  write: / gv_integer.
*ENDDO.





SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-002 NO INTERVALS.
PARAMETERS: p_date1 TYPE datum,
            p_date2 TYPE datum.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_counter TYPE n LENGTH 3.

IF p_date1 IS INITIAL OR p_date2 IS INITIAL.
  MESSAGE 'Her iki tarih alanini da doldurunuz.' TYPE 'S' DISPLAY LIKE 'E'.
  EXIT.
ENDIF.

IF p_date1 >= p_date2.
  MESSAGE 'Ilk girilen tarih ikinci girilen tarihten kucuk olmalidir' TYPE 'S' DISPLAY LIKE 'E'.
  EXIT.
ENDIF.

DO.
  p_date1 = p_date1 + 1.
  gv_counter = gv_counter + 1.
  IF p_date1 = p_date2.
    EXIT.
  ENDIF.
ENDDO.
WRITE: gv_counter.
