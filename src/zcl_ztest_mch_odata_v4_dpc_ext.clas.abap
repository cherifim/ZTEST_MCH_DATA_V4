class ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT definition
  public
  inheriting from ZCL_ZTEST_MCH_ODATA_V4_DPC
  create public .

public section.

  methods /IWBEP/IF_V4_DP_ADVANCED~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_ADVANCED~READ_ENTITY_LIST
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~DELETE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BATCH~PROCESS_CHANGE_SET
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~UPDATE_ENTITY
    redefinition .
protected section.

  methods ADDRESSSET_READ
    redefinition .
  methods ADDRESSSET_READ_LIST
    redefinition .
  methods PERSONSET_CREATE
    redefinition .
  methods PERSONSET_DELETE
    redefinition .
  methods PERSONSET_READ
    redefinition .
  methods PERSONSET_READ_LIST
    redefinition .
  methods PERSONSET_UPDATE
    redefinition .
  methods PERSON_READ_REF_KEY_LIST
    redefinition .
  methods TEAMSET_READ
    redefinition .
  methods TEAMSET_READ_LIST
    redefinition .
  methods TEAM_READ_REF_KEY_LIST
    redefinition .
private section.

  types:
    BEGIN OF ty_s_change,
      id                TYPE /iwbep/if_v4_runtime_types=>ty_operation_id,
      content_id        TYPE string,
      kind              TYPE /iwbep/if_v4_runtime_types=>ty_operation_kind,
      request           TYPE REF TO /iwbep/if_v4_requ_btc_oper,
      response          TYPE REF TO /iwbep/if_v4_resp_btc_oper,
      message_container TYPE REF TO /iwbep/if_v4_message_container,
    END OF ty_s_change .
  types:
    ty_t_changes TYPE STANDARD TABLE OF ty_s_change WITH DEFAULT KEY .
  types:
    BEGIN OF tys_person_data,
      data      TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person,
      operation TYPE ty_s_change,
    END OF tys_person_data .
  types:
    tyt_person_data TYPE STANDARD TABLE OF tys_person_data WITH DEFAULT KEY .
  types:
    BEGIN OF tys_team_data,
      data      TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team,
      operation TYPE ty_s_change,
    END OF tys_team_data .
  types:
    tyt_team_data TYPE STANDARD TABLE OF tys_team_data WITH DEFAULT KEY .

  data DEFERRED type BOOLEAN .
  data COLLECTED_CHANGES type TY_T_CHANGES .

  class-methods _EXECUTE_CHANGES
    importing
      !CHANGES type TY_T_CHANGES
    raising
      /IWBEP/CX_GATEWAY .
  methods _COLLECT_CHANGE
    importing
      !IO_REQUEST type ref to OBJECT
      !IO_RESPONSE type ref to OBJECT
    raising
      /IWBEP/CX_GATEWAY .
  class-methods _GET_CHANGE
    importing
      !IO_REQUEST type ref to OBJECT
      !IO_RESPONSE type ref to OBJECT
    returning
      value(CHANGE) type TY_S_CHANGE
    raising
      /IWBEP/CX_GATEWAY .
  class-methods _PROCESS_CHANGES
    importing
      !IT_PERSONS_DATA type TYT_PERSON_DATA
      !IT_TEAMS_DATA type TYT_TEAM_DATA
    raising
      /IWBEP/CX_GATEWAY .
ENDCLASS.



CLASS ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT IMPLEMENTATION.


METHOD /iwbep/if_v4_dp_advanced~create_entity.

*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00R
*______________________________________________________________________________________*
* Date of creation: 26.08.2023 21:44:46  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Redefinition - use basic creation (no creation with navigation/expand/deep insert)
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: lo_request_pro TYPE REF TO /iwbep/cl_v4_request_info_pro.
  DATA: lo_response_pro TYPE REF TO /iwbep/cl_v4_response_info_pro.

  lo_request_pro ?= io_request.
  lo_response_pro ?= io_response.

  me->/iwbep/if_v4_dp_basic~create_entity( io_request  = lo_request_pro
                                           io_response = lo_response_pro ).

*  IF me->deferred = abap_true. "Collect change in deferred mode
*    me->_collect_change( io_request  = io_request io_response = io_response ).
*  ENDIF.
*
*
*  DATA: ls_todo_list_orig TYPE /iwbep/if_v4_requ_adv_create=>ty_s_todo_list.
*  DATA: ls_team_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.
*  DATA: ls_person TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
*  DATA: ls_zperson TYPE zpersons.
*  DATA: ls_todo_process_list TYPE /iwbep/if_v4_requ_adv_create=>ty_s_todo_process_list.
*
*  FIELD-SYMBOLS:
*    <ls_navigation_prop_path>  TYPE /iwbep/if_v4_runtime_types=>ty_s_navigation_prop_w_path.
*
*  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list_orig ).
*
*  "Create entities with navigation (create an entity X under the entity Y)
*  IF ls_todo_list_orig-process-navigation = abap_true.
*
*    DATA(lo_navigation_source_node) = io_request->get_navigation_path( ).
*
*    io_request->get_navigation_expression( IMPORTING ev_navigation_expression = DATA(lv_nav_expression) ).
*
*    "Create a person for a given team (ex: /Team(23)/Persons)
*    IF lv_nav_expression = 'TEAMSET-PERSONS'.
*      "Get team key
*      lo_navigation_source_node->get_key_data( IMPORTING es_key_data = ls_team_key ).
*
*      CHECK ls_team_key-team_id IS NOT INITIAL.
*
*      "Get Person data
*      io_request->get_busi_data( IMPORTING es_busi_data = ls_person ).
*
*      SELECT * FROM zpersons INTO TABLE @DATA(lt_zpersons).
*      SORT lt_zpersons[] BY id DESCENDING.
*      ASSIGN lt_zpersons[ 1 ] TO FIELD-SYMBOL(<zperson>).
*      IF sy-subrc = 0.
*        ls_person-id = <zperson>-id + 1.
*      ELSE.
*        ls_person-id = 0.
*      ENDIF.
*
*      MOVE-CORRESPONDING ls_person TO ls_zperson.
*      ls_zperson-team_id = ls_team_key-team_id.
*
*      MODIFY zpersons FROM ls_zperson.
*      IF sy-subrc = 0.
*        io_response->set_busi_data( is_busi_data = ls_person ).
*        ls_todo_process_list-busi_data = abap_true.
*        ls_todo_process_list-navigation = abap_true.
*        ls_todo_process_list-partial_busi_data = ls_todo_list_orig-process-partial_busi_data.
*        io_response->set_is_done( is_todo_list = ls_todo_process_list ).
*      ENDIF.
*
*    ENDIF.
*  ENDIF.



ENDMETHOD.


METHOD /iwbep/if_v4_dp_advanced~read_entity_list.

  DATA: ls_todo_list            TYPE /iwbep/if_v4_requ_adv_list=>ty_s_todo_list,
        lo_request              TYPE REF TO /iwbep/cl_v4_request_info_pro,
        lo_response             TYPE REF TO /iwbep/cl_v4_response_info_pro,
        lo_target_data_provider TYPE REF TO /iwbep/if_v4_data_provider,
        lv_has_no_target        TYPE abap_bool.

  TRY.
      CALL METHOD super->/iwbep/if_v4_dp_advanced~read_entity_list
        EXPORTING
          io_request  = io_request
          io_response = io_response.
    CATCH /iwbep/cx_gateway.


      lo_request  ?= io_request.
      lo_response ?= io_response.
      io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

      " $apply
      IF ( ls_todo_list-process-apply = abap_true ).
        DATA(lo_apply_tree) = io_request->get_apply_tree( ).
        lo_apply_tree->get_aggreg_expr_info(
          IMPORTING
            es_node_info = DATA(ls_node_info)                 " Aggreation expression data of  an apply tree node ($apply)
        ).

        lo_apply_tree->get_transformation_info(
          IMPORTING
            es_trafo_info = DATA(ls_trafo_info)
        ).
        ".... TO BE IMPLEMENTED .....

*        CATCH /iwbep/cx_gateway. " SAP Gateway Exception

      ENDIF.


  ENDTRY.
ENDMETHOD.


METHOD addressset_read.

  DATA: ls_address_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_address.
  DATA: ls_address     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_address.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).

  IF ls_todo_list-process-key_data = abap_true.
    io_request->get_key_data( IMPORTING es_key_data = ls_address_key ). "Get the key data

    SELECT SINGLE * FROM zaddresses INTO @DATA(ls_zaddress) WHERE address_id = @ls_address_key-address_id.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    ls_address-address_id = ls_zaddress-address_id.
    ls_address-street = ls_zaddress-street.
    ls_address-street_number = ls_zaddress-street_number.
    ls_address-zip_code = ls_zaddress-zip_code.
    ls_address-city = ls_zaddress-city.
    ls_address-country = ls_zaddress-country.

    io_response->set_busi_data( ls_address ).

    ls_done_list-key_data = abap_true.

  ENDIF.

  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD addressset_read_list.

  DATA: lt_addresses      TYPE zcl_ztest_mch_odata_v4_mpc=>tt_address.
  DATA: ls_done_list      TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.
  DATA: lt_filter_ranges  TYPE /iwbep/t_mgw_select_option.
  DATA: lt_address_keys   TYPE zcl_ztest_mch_odata_v4_mpc=>tt_address.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list)  ).

  "Filter --> build filter ranges
  IF ls_todo_list-process-filter = abap_true.

    ls_done_list-filter = abap_true.

    io_request->get_filter_props_with_ranges(
      IMPORTING et_property_path = DATA(lt_property_path)                 " List of properties / property paths
    ).

    LOOP AT lt_property_path[] ASSIGNING FIELD-SYMBOL(<property_path>).
      APPEND INITIAL LINE TO lt_filter_ranges[] ASSIGNING FIELD-SYMBOL(<filter_range>).
      <filter_range>-property = <property_path>.
      io_request->get_filter_ranges_for_prop( EXPORTING iv_property_path = <property_path>
                                              IMPORTING et_range         = <filter_range>-select_options[] ).
    ENDLOOP.

    LOOP AT lt_filter_ranges[] ASSIGNING FIELD-SYMBOL(<filter>).
      CASE <filter>-property.
        WHEN 'ADDRESS_ID'.
          DATA(lt_select_address_id) = <filter>-select_options[].
        WHEN 'STREET'.
          DATA(lt_select_street) = <filter>-select_options[].
        WHEN 'STREET_NUMBER'.
          DATA(lt_select_street_number) = <filter>-select_options[].
        WHEN 'ZIP_CODE'.
          DATA(lt_select_zip_code) = <filter>-select_options[].
        WHEN 'CITY'.
          DATA(lt_select_city) = <filter>-select_options[].
        WHEN 'COUNTRY'.
          DATA(lt_select_country) = <filter>-select_options[].
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

  ENDIF.


  "Keys data provided --> build filter according to the keys
  IF ls_todo_list-process-key_data = abap_true.
    io_request->get_key_data( IMPORTING et_key_data = lt_address_keys[] ).
    LOOP AT lt_address_keys[] ASSIGNING FIELD-SYMBOL(<address_key>).
      APPEND INITIAL LINE TO lt_select_address_id[] ASSIGNING FIELD-SYMBOL(<select_address_id>).
      <select_address_id>-sign = 'I'.
      <select_address_id>-option = 'EQ'.
      <select_address_id>-low = <address_key>-address_id.
    ENDLOOP.
    ls_done_list-key_data = abap_true.
  ENDIF.

  "Data requested
  IF ls_todo_list-return-busi_data = abap_true.

    SELECT * FROM zaddresses INTO TABLE @DATA(lt_zaddresses)
      WHERE address_id IN @lt_select_address_id[] AND
            street IN @lt_select_street[] AND
            street_number IN @lt_select_street_number[] AND
            zip_code IN @lt_select_zip_code[] AND
            city IN @lt_select_city[] AND
            country IN @lt_select_country[].

    SORT lt_zaddresses[] BY address_id ASCENDING.

    LOOP AT lt_zaddresses[] ASSIGNING FIELD-SYMBOL(<zaddress>).
      APPEND INITIAL LINE TO lt_addresses[] ASSIGNING FIELD-SYMBOL(<address>).
      <address>-address_id = <zaddress>-address_id.
      <address>-street = <zaddress>-street.
      <address>-street_number = <zaddress>-street_number.
      <address>-zip_code = <zaddress>-zip_code.
      <address>-city = <zaddress>-city.
      <address>-country = <zaddress>-country.
    ENDLOOP.

    io_response->set_busi_data( lt_addresses[] ).
  ENDIF.


  "Order by
  IF ls_todo_list-process-orderby = abap_true.
    "TODO : order the results
    ls_done_list-orderby = abap_true.
  ENDIF.

  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD personset_create.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00B
*______________________________________________________________________________________*
* Date of creation: 27.08.2023 15:55:18  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Create Person entity
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*


  DATA: ls_person     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.
  DATA: lo_request    TYPE REF TO /iwbep/cl_v4_request_info_pro.


  io_request->get_busi_data( IMPORTING es_busi_data = ls_person ).
  io_response->set_busi_data( is_busi_data = ls_person ).

  ls_done_list-busi_data = abap_true.
  io_response->set_is_done( ls_done_list ).

  RETURN.

*
*
*  lo_request ?= io_request.
*  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).
*
*  IF ls_todo_list-process-busi_data = abap_true.
*    io_request->get_busi_data( IMPORTING es_busi_data = ls_person ). "Get the data
*
**    SELECT SINGLE * FROM zpersons INTO @DATA(ls_zperson) WHERE id = @ls_person_key-id.
**    IF sy-subrc <> 0.
**      RETURN.
**    ENDIF.
**
**    ls_person-id = ls_zperson-id.
**    ls_person-first_name = ls_zperson-first_name.
**    ls_person-last_name = ls_zperson-last_name.
**    ls_person-date_of_birth = ls_zperson-date_of_birth.
**    ls_person-age = sy-datum(4) - ls_zperson-date_of_birth(4).
**
**    io_response->set_busi_data( ls_person ).
**
**    ls_done_list-key_data = abap_true.
*
*  ENDIF.
*
*  io_response->set_is_done( ls_done_list ).


ENDMETHOD.


METHOD personset_delete.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00F
*______________________________________________________________________________________*
* Date of creation: 27.08.2023 15:54:02  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description : Delete a Person entity
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*


  DATA: ls_person_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.
  DATA: lv_error      TYPE boolean.

  ls_done_list-key_data = abap_true.
  io_response->set_is_done( ls_done_list ).

  RETURN.

*
*  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).
*
*  IF  ls_todo_list-process-key_data = abap_true.
*    "Get the key data of the person to be deleted
*    io_request->get_key_data( IMPORTING es_key_data = ls_person_key ).
*    IF ls_person_key-id IS NOT INITIAL.
*      DELETE FROM zpersons WHERE id = ls_person_key-id.
*      IF sy-subrc = 0.
*        ls_done_list-key_data = abap_true.
*        io_response->set_is_done( ls_done_list ).
*      ENDIF.
*    ENDIF.
*  ENDIF.

ENDMETHOD.


METHOD personset_read.

*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM002
*______________________________________________________________________________________*
* Date of creation: 21.06.2023 10:00:55  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :   Read single entity "Person"
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: ls_person_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_person     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ). "Get the todos

  IF ls_todo_list-process-key_data = abap_true. "The request contains key data

    io_request->get_key_data( IMPORTING es_key_data = ls_person_key ). "Get the key data

    SELECT SINGLE * FROM zpersons INTO @DATA(ls_zperson) WHERE id = @ls_person_key-id. "Select data from database
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    ls_person-id = ls_zperson-id.
    ls_person-first_name = ls_zperson-first_name.
    ls_person-last_name = ls_zperson-last_name.
    ls_person-date_of_birth = ls_zperson-date_of_birth.
    ls_person-age = sy-datum(4) - ls_zperson-date_of_birth(4).

    io_response->set_busi_data( ls_person ).

    ls_done_list-key_data = abap_true.

  ENDIF.

  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD personset_read_list.


  "DATA:  lt_person_key TYPE ty_t_persons_key.
  DATA: lt_persons          TYPE zcl_ztest_mch_odata_v4_mpc=>tt_person.
  DATA: lt_persons_keys     TYPE zcl_ztest_mch_odata_v4_mpc=>tt_person.
  DATA: ls_done_list        TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.
  DATA: lt_filter_ranges    TYPE /iwbep/t_mgw_select_option.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list)  ).

*  IF ls_todo_list-process-key_data EQ abap_true.
*    io_request->get_key_data( IMPORTING et_key_data = lt_person_key ).
*    ls_done_list-key_data = abap_true.
*  ENDIF.

  "Filter --> build filter ranges
  IF ls_todo_list-process-filter = abap_true.

    ls_done_list-filter = abap_true.

    io_request->get_filter_props_with_ranges(
      IMPORTING et_property_path = DATA(lt_property_path)                 " List of properties / property paths
    ).

    LOOP AT lt_property_path[] ASSIGNING FIELD-SYMBOL(<property_path>).
      APPEND INITIAL LINE TO lt_filter_ranges[] ASSIGNING FIELD-SYMBOL(<filter_range>).
      <filter_range>-property = <property_path>.
      io_request->get_filter_ranges_for_prop( EXPORTING iv_property_path = <property_path>
                                              IMPORTING et_range         = <filter_range>-select_options[] ).
    ENDLOOP.

    LOOP AT lt_filter_ranges[] ASSIGNING FIELD-SYMBOL(<filter>).
      CASE <filter>-property.
        WHEN 'ID'.
          DATA(lt_select_id) = <filter>-select_options[].
        WHEN 'FIRST_NAME'.
          DATA(lt_select_first_name) = <filter>-select_options[].
        WHEN 'LAST_NAME'.
          DATA(lt_select_last_name) = <filter>-select_options[].
        WHEN 'DATE_OF_BIRTH'.
          DATA(lt_select_date_of_birth) = <filter>-select_options[].
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

  ENDIF.

  "Keys data provided --> build filter according to the keys
  "This is used for Expand/Navigation from other entities
  IF ls_todo_list-process-key_data = abap_true.
    io_request->get_key_data( IMPORTING et_key_data = lt_persons_keys[] ).
    LOOP AT lt_persons_keys[] ASSIGNING FIELD-SYMBOL(<person_key>).
      APPEND INITIAL LINE TO lt_select_id[] ASSIGNING FIELD-SYMBOL(<select_id>).
      <select_id>-sign = 'I'.
      <select_id>-option = 'EQ'.
      <select_id>-low = <person_key>-id.
    ENDLOOP.
    ls_done_list-key_data = abap_true.
  ENDIF.

  "Data requested
  IF ls_todo_list-return-busi_data = abap_true.

    SELECT * FROM zpersons INTO TABLE @DATA(lt_zpersons)
      WHERE id IN @lt_select_id[] AND
            first_name IN @lt_select_first_name[] AND
            last_name IN @lt_select_last_name[] AND
            date_of_birth IN @lt_select_date_of_birth[].

    SORT lt_zpersons[] BY id ASCENDING.

    LOOP AT lt_zpersons[] ASSIGNING FIELD-SYMBOL(<zperson>).
      APPEND INITIAL LINE TO lt_persons[] ASSIGNING FIELD-SYMBOL(<person>).
      <person>-id = <zperson>-id.
      <person>-first_name = <zperson>-first_name.
      <person>-last_name = <zperson>-last_name.
      <person>-date_of_birth = <zperson>-date_of_birth.
      <person>-age = sy-datum(4) - <person>-date_of_birth(4).
    ENDLOOP.

    io_response->set_busi_data( lt_persons[] ).
  ENDIF.

  "Order by
  IF ls_todo_list-process-orderby = abap_true.
    "TODO : order the results
    ls_done_list-orderby = abap_true.
  ENDIF.

  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD personset_update.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM009
*______________________________________________________________________________________*
* Date of creation: 27.08.2023 00:45:38  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Update a Person entity
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*


  DATA: ls_person     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.
  DATA: lv_error      TYPE boolean.

  io_request->get_busi_data( IMPORTING es_busi_data = ls_person ).
  io_response->set_busi_data( is_busi_data = ls_person ).

  ls_done_list-key_data = abap_true.
  ls_done_list-busi_data = abap_true.
  io_response->set_is_done( ls_done_list ).

  RETURN.
*
*  DATA(lo_msg_container) = io_response->get_message_container( ).
*
*  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).
*
*  IF ls_todo_list-process-busi_data = abap_true.
*
*    io_request->get_busi_data( IMPORTING es_busi_data = ls_person ).
*
*    IF ls_person-first_name IS INITIAL.
*      io_response->get_message_container( )->add_t100(
*          iv_msg_type                 = 'E'
*          iv_msg_id                   = 'ZTEST_MCH'
*          iv_msg_number               = 1  "Mandatory field : First name
*          iv_is_for_user              = abap_true        " Is for user?
*          iv_leading_message_for_user = abap_false       " Is leading message?
*          iv_target                  = 'FirstName'
*      ).
*      lv_error = abap_true.
*    ENDIF.
*
*    IF ls_person-last_name IS INITIAL.
*      io_response->get_message_container( )->add_t100(
*          iv_msg_type                 = 'E'
*          iv_msg_id                   = 'ZTEST_MCH'
*          iv_msg_number               = 2  "Mandatory field : Last name
*          iv_is_for_user              = abap_true        " Is for user?
*          iv_leading_message_for_user = abap_false       " Is leading message?
*          iv_target                   = 'LastName'
*      ).
*      lv_error = abap_true.
*    ENDIF.
*
*    IF lv_error = abap_true.
*
*      "A leading message
*      io_response->get_message_container( )->add_t100(
*          iv_msg_type                 = 'E'
*          iv_msg_id                   = 'ZTEST_MCH'
*          iv_msg_number               = 0  "Error
*          iv_is_for_user              = abap_true        " Is for user?
*          iv_leading_message_for_user = abap_true       " Is leading message?
*      ).
*
*      RAISE EXCEPTION TYPE /iwbep/cx_gateway
*        EXPORTING
*          message_container = io_response->get_message_container( ).
*
*    ENDIF.
*
*    ls_person-first_name = ls_person-first_name && 'UPD'.
*
*    UPDATE zpersons SET first_name = ls_person-first_name
*                        last_name = ls_person-last_name
*                        date_of_birth = ls_person-date_of_birth
*                    WHERE id = ls_person-id.
*    IF sy-subrc = 0.
*      ls_person-age = sy-datum(4) - ls_person-date_of_birth(4).
*      io_response->set_busi_data( ls_person ).
*
*      ls_done_list-key_data = abap_true.
*      ls_done_list-busi_data = abap_true.
*    ENDIF.
*
*  ENDIF.
*
*  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD person_read_ref_key_list.

*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM007
*______________________________________________________________________________________*
* Date of creation: 24.02.2023 15:36:23  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Read target keys from Person entity
*                 This will calculate the target keys for target entities when using
*                 navigation properties
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_process_list.
  DATA lv_nav_property_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.
  DATA ls_person_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA ls_address_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_address.
  DATA lt_address_key TYPE zcl_ztest_mch_odata_v4_mpc=>tt_address.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

  io_request->get_navigation_prop( IMPORTING ev_navigation_prop_name = lv_nav_property_name ).

  "Source key data provided
  IF ls_todo_list-process-source_key_data = abap_true.
    io_request->get_source_key_data( IMPORTING es_source_key_data =  ls_person_key ).
    ls_done_list-source_key_data = abap_true.
  ENDIF.

  CASE lv_nav_property_name.
    WHEN 'ADDRESS'. "Person -> Address (1 -> 0..1)
      SELECT SINGLE address_id FROM zpersons INTO @ls_address_key-address_id
        WHERE id = @ls_person_key-id.
      IF sy-subrc = 0.
        APPEND ls_address_key TO lt_address_key[].
        ls_done_list-target_key_data = abap_true.
        io_response->set_target_key_data( lt_address_key[] ). "No more than one key is allowed
      ENDIF.
    WHEN OTHERS.
  ENDCASE.

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD teamset_read.

  DATA: ls_team_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.
  DATA: ls_team     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).

  IF ls_todo_list-process-key_data = abap_true.
    io_request->get_key_data( IMPORTING es_key_data = ls_team_key ). "Get the key data

    SELECT SINGLE * FROM zteams INTO @DATA(ls_zteam) WHERE team_id = @ls_team_key-team_id.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    ls_team-team_id = ls_zteam-team_id.
    ls_team-name = ls_zteam-name.

    io_response->set_busi_data( ls_team ).

    ls_done_list-key_data = abap_true.

  ENDIF.

  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD teamset_read_list.

  DATA: lt_teams            TYPE zcl_ztest_mch_odata_v4_mpc=>tt_team.
  DATA: ls_done_list        TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.
  DATA: lt_filter_ranges    TYPE /iwbep/t_mgw_select_option.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list)  ).

  "Filter --> build filter ranges
  IF ls_todo_list-process-filter = abap_true.

    ls_done_list-filter = abap_true.

    io_request->get_filter_props_with_ranges(
      IMPORTING et_property_path = DATA(lt_property_path)                 " List of properties / property paths
    ).

    LOOP AT lt_property_path[] ASSIGNING FIELD-SYMBOL(<property_path>).
      APPEND INITIAL LINE TO lt_filter_ranges[] ASSIGNING FIELD-SYMBOL(<filter_range>).
      <filter_range>-property = <property_path>.
      io_request->get_filter_ranges_for_prop( EXPORTING iv_property_path = <property_path>
                                              IMPORTING et_range         = <filter_range>-select_options[] ).
    ENDLOOP.


    LOOP AT lt_filter_ranges[] ASSIGNING FIELD-SYMBOL(<filter>).
      CASE <filter>-property.
        WHEN 'TEAM_ID'.
          DATA(lt_select_team_id) = <filter>-select_options[].
        WHEN 'NAME'.
          DATA(lt_select_name) = <filter>-select_options[].
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.

  ENDIF.

  "Data requested
  IF ls_todo_list-return-busi_data = abap_true.

    SELECT * FROM zteams INTO TABLE @DATA(lt_zteams)
      WHERE team_id IN @lt_select_team_id[] AND
            name IN @lt_select_name[].

    SORT lt_zteams[] BY team_id ASCENDING.

    LOOP AT lt_zteams[] ASSIGNING FIELD-SYMBOL(<zteam>).
      APPEND INITIAL LINE TO lt_teams[] ASSIGNING FIELD-SYMBOL(<team>).
      <team>-team_id = <zteam>-team_id.
      <team>-name = <zteam>-name.
    ENDLOOP.

    io_response->set_busi_data( lt_teams[] ).
  ENDIF.

  "Order by
  IF ls_todo_list-process-orderby = abap_true.
    "TODO : order the results
    ls_done_list-orderby = abap_true.
  ENDIF.

  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD team_read_ref_key_list.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM007
*______________________________________________________________________________________*
* Date of creation: 24.02.2023 15:36:23  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Read target keys from Team entity
*                 This will calculate the target keys for target entities when using
*                 navigation properties
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_process_list.
  DATA lv_nav_property_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.
  DATA ls_team_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.
  DATA ls_person_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA lt_person_key TYPE zcl_ztest_mch_odata_v4_mpc=>tt_person.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

  io_request->get_navigation_prop( IMPORTING ev_navigation_prop_name = lv_nav_property_name ).

  "Source key data provided
  IF ls_todo_list-process-source_key_data = abap_true.
    io_request->get_source_key_data( IMPORTING es_source_key_data =  ls_team_key ).
    ls_done_list-source_key_data = abap_true.
  ENDIF.

  CASE lv_nav_property_name.
    WHEN 'PERSONS'. "Team -> Person (1 -> 0..n)

      "Get Person key if provided
      io_request->get_target_key_data( IMPORTING es_target_key_data = ls_person_key ).

      IF ls_person_key-id IS NOT INITIAL. "Key on Person provided [ ex: /TeamSet(1)/Persons(11) ]
        SELECT * FROM zpersons INTO TABLE @DATA(lt_zpersons)
          WHERE team_id = @ls_team_key-team_id AND
                id = @ls_person_key-id.
      ELSE. "Key on Person NOT provided [ ex: /TeamSet(1)/Persons ]
        SELECT * FROM zpersons INTO TABLE lt_zpersons[]
          WHERE team_id = ls_team_key-team_id.
      ENDIF.

      LOOP AT lt_zpersons[] ASSIGNING FIELD-SYMBOL(<zperson>).
        APPEND INITIAL LINE TO lt_person_key[] ASSIGNING FIELD-SYMBOL(<person_key>).
        <person_key>-id = <zperson>-id.
      ENDLOOP.

      ls_done_list-target_key_data = abap_true.
      io_response->set_target_key_data( lt_person_key[] ).

    WHEN OTHERS.
  ENDCASE.


* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).

ENDMETHOD.


METHOD /iwbep/if_v4_dp_basic~create_entity.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00O
*______________________________________________________________________________________*
* Date of creation: 26.08.2023 21:13:53  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Redefinition - manage deferred mode
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  super->/iwbep/if_v4_dp_basic~create_entity( io_request  = io_request
                                              io_response = io_response ).

  IF me->deferred = abap_true. "Collect changes in deferred mode for later execution

    me->_collect_change( io_request  = io_request
                         io_response = io_response ).

  ELSE. "Execute the change immediately

    DATA(ls_change) = _get_change( io_request = io_request
                                   io_response = io_response ).

    _execute_changes( VALUE #( ( ls_change ) ) ).

  ENDIF.

ENDMETHOD.


METHOD /iwbep/if_v4_dp_basic~delete_entity.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00Q
*______________________________________________________________________________________*
* Date of creation: 26.08.2023 21:41:30  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Redefinition - manage deferred mode
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  super->/iwbep/if_v4_dp_basic~delete_entity( io_request = io_request
                                              io_response = io_response ).

  IF me->deferred = abap_true. "Collect changes in deferred mode for later execution

    me->_collect_change( io_request  = io_request
                         io_response = io_response ).

  ELSE. "Execute the change immediately

    DATA(ls_change) = _get_change( io_request = io_request
                                   io_response = io_response ).

    _execute_changes( VALUE #( ( ls_change ) ) ).

  ENDIF.

ENDMETHOD.


METHOD /iwbep/if_v4_dp_basic~update_entity.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00R
*______________________________________________________________________________________*
* Date of creation: 26.08.2023 21:44:46  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Redefinition - manage deferred mode
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  super->/iwbep/if_v4_dp_basic~update_entity( io_request  = io_request
                                              io_response = io_response ).

  IF me->deferred = abap_true. "Collect changes in deferred mode for later execution

    me->_collect_change( io_request  = io_request
                         io_response = io_response ).

  ELSE. "Execute the change immediately

    DATA(ls_change) = _get_change( io_request = io_request
                                   io_response = io_response ).

    _execute_changes( VALUE #( ( ls_change ) ) ).

  ENDIF.

ENDMETHOD.


METHOD /iwbep/if_v4_dp_batch~process_change_set.

  me->deferred = abap_true.
  CLEAR me->collected_changes[].

  CALL METHOD super->/iwbep/if_v4_dp_batch~process_change_set
    EXPORTING
      io_request  = io_request
      io_response = io_response.


  io_request->get_operations_info( IMPORTING et_operation_info = DATA(lt_operation_info) ).
  "Fill content_id
  LOOP AT lt_operation_info[] ASSIGNING FIELD-SYMBOL(<operation_info>).
    ASSIGN me->collected_changes[ id = <operation_info>-id ] TO FIELD-SYMBOL(<collected_change>).
    CHECK sy-subrc = 0.
    <collected_change>-content_id = <operation_info>-content_id.
  ENDLOOP.

  _execute_changes( me->collected_changes[] ).

ENDMETHOD.


METHOD _collect_change.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00P
*______________________________________________________________________________________*
* Date of creation: 26.08.2023 21:34:19  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Collect a change for deferred mode
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: ls_change LIKE LINE OF me->collected_changes[].

  ls_change = _get_change( io_request  = io_request
                           io_response = io_response ).

  ls_change-id = lines( me->collected_changes[] ) + 1.

  APPEND ls_change TO me->collected_changes[].

ENDMETHOD.


METHOD _execute_changes.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00K
*______________________________________________________________________________________*
* Date of creation: 26.08.2023 14:02:11  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :  Execute changes in deferred mode
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: lo_request_pro TYPE REF TO /iwbep/cl_v4_request_info_pro.
  DATA: lo_response_pro TYPE REF TO /iwbep/cl_v4_response_info_pro.
  DATA: lx_gateway TYPE REF TO /iwbep/cx_gateway.

  DATA: lt_teams_data TYPE tyt_team_data.
  DATA: lt_persons_data TYPE tyt_person_data.
  DATA: ls_team_data LIKE LINE OF lt_teams_data[].
  DATA: ls_person_data LIKE LINE OF lt_persons_data[].

  FIELD-SYMBOLS: <data> TYPE data.

  LOOP AT changes[] ASSIGNING FIELD-SYMBOL(<change>).
    "Get original request & response objects for each change
    lo_request_pro ?= <change>-request.
    lo_response_pro ?= <change>-response.

    DATA(ls_todos) = lo_request_pro->get_base_request_info( )->get_todos( ).
    DATA(lv_entity_set_name) = lo_request_pro->get_source_entity_set_name( ).

    CASE lv_entity_set_name.
      WHEN 'TEAMSET'.
        APPEND INITIAL LINE TO lt_teams_data[] ASSIGNING FIELD-SYMBOL(<team_data>).
        <team_data>-operation = <change>.
        ASSIGN <team_data>-data TO <data>.
      WHEN 'PERSONSET'.
        APPEND INITIAL LINE TO lt_persons_data[] ASSIGNING FIELD-SYMBOL(<person_data>).
        <person_data>-operation = <change>.
        ASSIGN <person_data>-data TO <data>.
      WHEN OTHERS.
    ENDCASE.

    CASE <change>-kind.
      WHEN 'UE'. "Update entity
        lo_request_pro->/iwbep/if_v4_requ_basic_update~get_busi_data( IMPORTING es_busi_data = <data> ).
      WHEN 'CA'. "Create entity
        lo_request_pro->/iwbep/if_v4_requ_basic_create~get_busi_data( IMPORTING es_busi_data = <data> ).
      WHEN 'DE'. "Delete entity
        lo_request_pro->/iwbep/if_v4_requ_basic_delete~get_key_data( IMPORTING es_key_data = <data> ).
      WHEN OTHERS.
    ENDCASE.

    "TO BE DELETED
    "Générer des erreur --> dans SAPUI5 il faut gérer la création de messages dans le code après un parse du payload de retour
*    <change>-message_container->add_t100(
*        iv_msg_type                 = 'E'
*        iv_msg_id                   = 'ZTEST_MCH'
*        iv_msg_number               = 2  "Mandatory field : Last name
*        iv_is_for_user              = abap_true        " Is for user?
*        iv_leading_message_for_user = abap_false       " Is leading message?
*        iv_target                   = 'LastName'
*    ).
*
*     <change>-message_container->add_t100(
*        iv_msg_type                 = 'E'
*        iv_msg_id                   = 'ZTEST_MCH'
*        iv_msg_number               = 1  "Mandatory field : First name
*        iv_is_for_user              = abap_true        " Is for user?
*        iv_leading_message_for_user = abap_false       " Is leading message?
*        iv_target                   = 'FirstName'
*    ).
*
*    lx_gateway = NEW #( message_container = <change>-message_container
*                        message_target = '' ).
*
*    lx_gateway->/iwbep/if_gateway_exception_fw~set_content_id( <change>-content_id ).
*
*    RAISE EXCEPTION lx_gateway.


  ENDLOOP.

  _process_changes( it_persons_data = lt_persons_data[]
                    it_teams_data   = lt_teams_data[] ).

ENDMETHOD.


METHOD _get_change.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00T
*______________________________________________________________________________________*
* Date of creation: 27.08.2023 00:57:19  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description : Generate change structure from request
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: lo_request TYPE REF TO /iwbep/cl_v4_request_info_pro.
  DATA: lo_response TYPE REF TO /iwbep/cl_v4_response_info_pro.

  lo_request ?= io_request.
  lo_response ?= io_response.

  change-kind = lo_request->get_base_request_info( )->get_operation_kind( ).
  change-request = lo_request.
  change-response = lo_response.
  lo_response->get_base_response_info( )->get_message_container( IMPORTING eo_message_container = change-message_container ).

ENDMETHOD.


METHOD _process_changes.
*______________________________________________________________________________________*
* Description:
* See object description
* Techname: ZCL_ZTEST_MCH_ODATA_V4_DPC_EXTCM00U
*______________________________________________________________________________________*
* Date of creation: 27.08.2023 16:07:53  / Author: MCHERIFI / Mourad CHERIFI (STMS)
* Reference document:
*  Description :   Process changes
*______________________________________________________________________________________*
* Historic of modifications
* Date / User name / Transport request / VYY-NN <Free>
* Description:
*______________________________________________________________________________________*

  DATA: lx_gateway TYPE REF TO /iwbep/cx_gateway.
  DATA: lo_request TYPE REF TO /iwbep/cl_v4_request_info_pro.
  DATA: lo_response TYPE REF TO /iwbep/cl_v4_response_info_pro.


  DATA(lt_persons_data) = it_persons_data[].
  DATA(lt_teams_data) = it_teams_data[].
  DATA(lv_error) = abap_false.
  "DATA(lo_message_container) = /iwbep/cl_v4_message_container=>get_message_container( ).


  LOOP AT lt_persons_data[] ASSIGNING FIELD-SYMBOL(<person_data>) WHERE operation-kind = 'UE'. "Updates on Persons

    DATA(lo_message_container) = <person_data>-operation-message_container.

    lo_request ?= <person_data>-operation-request.
    lo_response ?= <person_data>-operation-response.

    IF <person_data>-data-first_name IS INITIAL.
      lo_message_container->add_t100(
          iv_msg_type                 = 'E'
          iv_msg_id                   = 'ZTEST_MCH'
          iv_msg_number               = 1  "Mandatory field : First name
          iv_is_for_user              = abap_true        " Is for user?
          iv_leading_message_for_user = abap_false       " Is leading message?
          iv_target                  = 'FirstName'
      ).
      lv_error = abap_true.
    ENDIF.

    IF <person_data>-data-last_name IS INITIAL.
      lo_message_container->add_t100(
          iv_msg_type                 = 'E'
          iv_msg_id                   = 'ZTEST_MCH'
          iv_msg_number               = 2  "Mandatory field : Last name
          iv_is_for_user              = abap_true        " Is for user?
          iv_leading_message_for_user = abap_false       " Is leading message?
          iv_target                   = 'LastName'
      ).
      lv_error = abap_true.
    ENDIF.

    IF lv_error = abap_true.
      "A leading message
*      lo_message_container->add_t100(
*          iv_msg_type                 = 'E'
*          iv_msg_id                   = 'ZTEST_MCH'
*          iv_msg_number               = 0  "Error
*          iv_is_for_user              = abap_true        " Is for user?
*          iv_leading_message_for_user = abap_true       " Is leading message?
*          iv_target                   = 'LastName'
*      ).

      "Je n'arrive pas à afficher plusieurs messages avec plusieurs targets différents surlignées dans SAPUI5 !!!!!
      lx_gateway = NEW #( message_container = lo_message_container
                          message_target    = 'LastName' ).

      lx_gateway->/iwbep/if_gateway_exception_fw~set_content_id( <person_data>-operation-content_id ).

      "lo_response->/iwbep/if_v4_resp_btc_oper~set_gateway_exception( lx_gateway ).

      RAISE EXCEPTION lx_gateway.

    ENDIF.

    <person_data>-data-first_name = <person_data>-data-first_name && 'UPD'.

    UPDATE zpersons SET first_name = <person_data>-data-first_name
                        last_name = <person_data>-data-last_name
                        date_of_birth = <person_data>-data-date_of_birth
                    WHERE id = <person_data>-data-id.
    IF sy-subrc = 0.
      <person_data>-data-age = sy-datum(4) - <person_data>-data-date_of_birth(4).
      lo_response->/iwbep/if_v4_resp_basic_update~set_busi_data( <person_data>-data ).
    ENDIF.

  ENDLOOP.

ENDMETHOD.
ENDCLASS.
