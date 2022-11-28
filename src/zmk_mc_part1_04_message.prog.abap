*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_04_message.

*DATA: gv_number TYPE n LENGTH 2.
*
*gv_number = 20.
*
*IF gv_number > 50.
*  MESSAGE 'Sayi 50 den buyuktur' TYPE 'I'.
*ELSEIF gv_number = 50.
*  MESSAGE 'Sayi 50 ye esittir.' TYPE 'I'.
*ELSE.
*  MESSAGE 'Sayi 50 den kucuktur.' TYPE 'I'.
*ENDIF.





*DATA: gv_number_01 TYPE n LENGTH 2,
*      gv_number_02 TYPE n LENGTH 2.
*
*gv_number_01 = 40.
*
*IF gv_number_01 > 50.
*  gv_number_02 = gv_number_01 + 10.
*
*  WRITE: gv_number_02.
*
*  MESSAGE 'Toplama islemi basari ile gerceklestirildi' TYPE 'S'.
*
*elseif gv_number_01 < 50.
*  MESSAGE 'Toplama islemi gerceklestilemedi' TYPE 'I'.
*ENDIF.




*data: gv_number_01 type n LENGTH 2,
*      gv_number_02 type n LENGTH 2.
*
*gv_number_01 = 20.
*
*IF gv_number_01 between 40 and 60.
*  gv_number_02 = gv_number_01 + 10.
*else.
**  MESSAGE 'Girdiginiz sayi 40 ile 60 arasinda degildir' TYPE 'E'.
*  MESSAGE 'Girdiginiz sayi 40 ile 60 arasinda degildir' TYPE 'S' DISPLAY LIKE 'E'.
*
*ENDIF.





*data: gv_number type n LENGTH 3.
*gv_number = 100.
*IF gv_number < 100.
*  MESSAGE text-001 type 'I'.
*elseif gv_number = 100.
*  MESSAGE text-002 type 'I'.
*else.
*  MESSAGE text-003 type 'I'.
*ENDIF.



PARAMETERS: p_number type i.

IF p_number < 100.
  MESSAGE text-001 type 'I'.
elseif p_number = 100.
  MESSAGE text-002 type 'I'.
ELSEIF p_number > 100.
  MESSAGE text-003 type 'I'.
ENDIF.
