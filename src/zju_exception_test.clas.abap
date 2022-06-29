CLASS zju_exception_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zju_exception_test IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  try.

  if 1 = 1.
  RAISE EXCEPTION type zcx_certificate
    EXPORTING
      severity = if_abap_behv_message=>severity-error
      textid   = zcx_certificate=>material_unknown
*      previous =
      material = 'DASISTDAS'
  .

  endif.


  catch zcx_certificate into data(oref).

        out->write( |Caught exception:\n\n| &&  |"{ oref->get_text( ) }" | ).

        DATA(text) = oref->get_text( ).

  ENDTRY.
  ENDMETHOD.
ENDCLASS.
