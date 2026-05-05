*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

PARAMETERS: p_vkorg TYPE vbak-vkorg OBLIGATORY.

SELECT-OPTIONS:
  s_vbeln FOR vbak-vbeln,
  s_erdat FOR vbak-erdat,
  s_kunnr FOR vbak-kunnr.

*---------------------------------------------------------------------*
* Optional: Default Values
*---------------------------------------------------------------------*

INITIALIZATION.
  s_erdat-low = sy-datum - 30.
  s_erdat-high = sy-datum.
  APPEND s_erdat.

*---------------------------------------------------------------------*
* Validation (Optional - Advanced)
*---------------------------------------------------------------------*

AT SELECTION-SCREEN.

  IF p_vkorg IS INITIAL.
    MESSAGE 'Sales Organization is required' TYPE 'E'.
  ENDIF.
