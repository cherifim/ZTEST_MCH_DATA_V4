CLASS lhc_team DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_authorizations FOR AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR team RESULT result.

ENDCLASS.

CLASS lhc_team IMPLEMENTATION.

  METHOD get_authorizations.
  ENDMETHOD.


ENDCLASS.
