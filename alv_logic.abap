REPORT zsales_order_report.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS: p_vkorg TYPE vbak-vkorg.

SELECT-OPTIONS:
  s_vbeln FOR vbak-vbeln,
  s_erdat FOR vbak-erdat,
  s_kunnr FOR vbak-kunnr.

*---------------------------------------------------------------------*
* Type Declaration
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_data,
         vbeln  TYPE vbak-vbeln,
         erdat  TYPE vbak-erdat,
         kunnr  TYPE vbak-kunnr,
         posnr  TYPE vbap-posnr,
         matnr  TYPE vbap-matnr,
         kwmeng TYPE vbap-kwmeng,
       END OF ty_data.

DATA: it_data TYPE TABLE OF ty_data,
      wa_data TYPE ty_data.

*---------------------------------------------------------------------*
* ALV Declarations
*---------------------------------------------------------------------*
DATA: it_fieldcat TYPE slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv,
      it_sort     TYPE slis_t_sortinfo_alv,
      wa_sort     TYPE slis_sortinfo_alv.

*---------------------------------------------------------------------*
* Start-of-selection
*---------------------------------------------------------------------*
START-OF-SELECTION.

  PERFORM fetch_data.
  PERFORM build_fieldcat.
  PERFORM build_sort.
  PERFORM display_alv.

*---------------------------------------------------------------------*
* Fetch Data
*---------------------------------------------------------------------*
FORM fetch_data.

  SELECT a~vbeln
         a~erdat
         a~kunnr
         b~posnr
         b~matnr
         b~kwmeng
    INTO TABLE it_data
    FROM vbak AS a
    INNER JOIN vbap AS b
    ON a~vbeln = b~vbeln
    WHERE a~vkorg = p_vkorg
      AND a~vbeln IN s_vbeln
      AND a~erdat IN s_erdat
      AND a~kunnr IN s_kunnr.

ENDFORM.

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
  wa_fieldcat-seltext_m = 'Order Qty'.
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
* Display ALV
*---------------------------------------------------------------------*
FORM display_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat = it_fieldcat
      it_sort     = it_sort
    TABLES
      t_outtab    = it_data.

ENDFORM.

*---------------------------------------------------------------------*
* Interactive Drill Down
*---------------------------------------------------------------------*
AT LINE-SELECTION.

  READ TABLE it_data INTO wa_data INDEX sy-tabix.

  IF sy-subrc = 0.
    WRITE: / 'Sales Order:', wa_data-vbeln,
           / 'Item:', wa_data-posnr,
           / 'Material:', wa_data-matnr,
           / 'Quantity:', wa_data-kwmeng.
  ENDIF.
