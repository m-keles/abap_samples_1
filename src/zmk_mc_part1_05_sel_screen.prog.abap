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





selection-screen begin of block a1 with frame title text-002 no intervals.
parameters: p_date1 type datum,
            p_date2 type datum.
selection-screen end of block a1.

data: gv_counter type n length 3.


initialization.

  %_p_date1_%_app_%-text = 'Erst Datum'.
  %_p_date2_%_app_%-text = 'Zweite Datum'.

start-of-selection.

  if p_date1 is initial or p_date2 is initial.
    message 'Her iki tarih alanini da doldurunuz.' type 'S' display like 'E'.
    exit.
  elseif p_date1 >= p_date2.
    message 'Ilk girilen tarih ikinci girilen tarihten kucuk olmalidir' type 'S' display like 'E'.
    exit.
  endif.


  do.
    p_date1 = p_date1 + 1.
    gv_counter = gv_counter + 1.
    if p_date1 = p_date2.
      exit.
    endif.
  enddo.
  
  write: gv_counter.
