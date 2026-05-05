*---------------------------------------------------------------------*
* ALV Logic
*---------------------------------------------------------------------*

DATA: it_fieldcat TYPE slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv,
      it_sort     TYPE slis_t_sortinfo_alv,
      wa_sort     TYPE slis_sortinfo_alv.

*---------------------------------------------------------------------*
* Build Field Catalog
*---------------------------------------------------------------------*
FORM build_fieldcat.

  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname = 'VBELN'.
  wa_fieldcat-seltext_m = 'Sales Order'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname = 'POSNR'.
  wa_fieldcat-seltext_m = 'Item'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname = 'ERDAT'.
  wa_fieldcat-seltext_m = 'Created On'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname = 'KUNNR'.
  wa_fieldcat-seltext_m = 'Customer'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname = 'MATNR'.
  wa_fieldcat-seltext_m = 'Material'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname = 'KWMENG'.
  wa_fieldcat-seltext_m = 'Order Quantity'.
  APPEND wa_fieldcat TO it_fieldcat.

ENDFORM.

*---------------------------------------------------------------------*
* Build Sort (Subtotals)
*---------------------------------------------------------------------*
FORM build_sort.

  wa_sort-fieldname = 'VBELN'.
  wa_sort-up = 'X'.
  wa_sort-subtot = 'X'.
  APPEND wa_sort TO it_sort.

ENDFORM.

*---------------------------------------------------------------------*
* Display ALV Grid
*---------------------------------------------------------------------*
FORM display_alv USING pt_data TYPE STANDARD TABLE.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat = it_fieldcat
      it_sort     = it_sort
    TABLES
      t_outtab    = pt_data.

ENDFORM.
