*&---------------------------------------------------------------------*
*& Report Z09_MK_MABI_16_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmk_mc_part1_18_seconds.


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_hour TYPE i,
            p_mins TYPE i,
            p_scnd TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_rslt TYPE i.
SELECTION-SCREEN END OF BLOCK a2.

DATA: gv_result TYPE i.


START-OF-SELECTION.

AT SELECTION-SCREEN OUTPUT.

  IF p_hour > 0.
    gv_result = p_hour * 3600.
  ENDIF.

  IF p_mins > 0.
    gv_result = gv_result + ( p_mins * 60 ).
  ENDIF.

  IF p_scnd > 0.
    gv_result = gv_result + p_scnd.
  ENDIF.

LOOP AT SCREEN.
  IF screen-name = 'P_RSLT'.
    p_rslt = gv_result.
  ENDIF.
ENDLOOP.
