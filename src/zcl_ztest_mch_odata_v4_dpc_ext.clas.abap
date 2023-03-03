class ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT definition
  public
  inheriting from ZCL_ZTEST_MCH_ODATA_V4_DPC
  create public .

public section.

  methods /IWBEP/IF_V4_DP_ADVANCED~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_ADVANCED~READ_ENTITY_LIST
    redefinition .
protected section.

  methods ADDRESSSET_READ
    redefinition .
  methods ADDRESSSET_READ_LIST
    redefinition .
  methods PERSONSET_CREATE
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
  methods PERSONSET_DELETE
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT IMPLEMENTATION.


METHOD /iwbep/if_v4_dp_advanced~create_entity.

  DATA: ls_todo_list_orig       TYPE /iwbep/if_v4_requ_adv_create=>ty_s_todo_list.
  DATA: ls_team_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.
  DATA: ls_person TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_zperson TYPE zpersons.
  DATA: ls_todo_process_list TYPE /iwbep/if_v4_requ_adv_create=>ty_s_todo_process_list.

  FIELD-SYMBOLS:
    <ls_navigation_prop_path>  TYPE /iwbep/if_v4_runtime_types=>ty_s_navigation_prop_w_path.


  TRY.
      CALL METHOD super->/iwbep/if_v4_dp_advanced~create_entity(
          io_request  = io_request
          io_response = io_response ).
    CATCH /iwbep/cx_gateway.


      io_request->get_todos( IMPORTING es_todo_list = ls_todo_list_orig ).

      "Create entities with navigation (create an entity X under the entity Y)
      IF ls_todo_list_orig-process-navigation = abap_true.

        DATA(lo_navigation_source_node) = io_request->get_navigation_path( ).

        io_request->get_navigation_expression( IMPORTING ev_navigation_expression = DATA(lv_nav_expression) ).

        "Create a person for a given team (ex: /Team(23)/Persons)
        IF lv_nav_expression = 'TEAMSET-PERSONS'.
          "Get team key
          lo_navigation_source_node->get_key_data( IMPORTING es_key_data = ls_team_key ).

          CHECK ls_team_key-team_id IS NOT INITIAL.

          "Get Person data
          io_request->get_busi_data( IMPORTING es_busi_data = ls_person ).

          SELECT * FROM zpersons INTO TABLE @DATA(lt_zpersons).
          SORT lt_zpersons[] BY id DESCENDING.
          ASSIGN lt_zpersons[ 1 ] TO FIELD-SYMBOL(<zperson>).
          IF sy-subrc = 0.
            ls_person-id = <zperson>-id + 1.
          ELSE.
            ls_person-id = 0.
          ENDIF.

          MOVE-CORRESPONDING ls_person TO ls_zperson.
          ls_zperson-team_id = ls_team_key-team_id.

          MODIFY zpersons FROM ls_zperson.
          IF sy-subrc = 0.
            io_response->set_busi_data( is_busi_data = ls_person ).
            ls_todo_process_list-busi_data = abap_true.
            ls_todo_process_list-navigation = abap_true.
            ls_todo_process_list-partial_busi_data = ls_todo_list_orig-process-partial_busi_data.
            io_response->set_is_done( is_todo_list = ls_todo_process_list ).
          ENDIF.

        ENDIF.
      ENDIF.

  ENDTRY.

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


  DATA: ls_person     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.
  DATA: lo_request    TYPE REF TO /iwbep/cl_v4_request_info_pro.

  lo_request ?= io_request.
  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).

  IF ls_todo_list-process-busi_data = abap_true.
    io_request->get_busi_data( IMPORTING es_busi_data = ls_person ). "Get the data

*    SELECT SINGLE * FROM zpersons INTO @DATA(ls_zperson) WHERE id = @ls_person_key-id.
*    IF sy-subrc <> 0.
*      RETURN.
*    ENDIF.
*
*    ls_person-id = ls_zperson-id.
*    ls_person-first_name = ls_zperson-first_name.
*    ls_person-last_name = ls_zperson-last_name.
*    ls_person-date_of_birth = ls_zperson-date_of_birth.
*    ls_person-age = sy-datum(4) - ls_zperson-date_of_birth(4).
*
*    io_response->set_busi_data( ls_person ).
*
*    ls_done_list-key_data = abap_true.

  ENDIF.

  io_response->set_is_done( ls_done_list ).


ENDMETHOD.


METHOD personset_delete.

  DATA: ls_person_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.
  DATA: lv_error      TYPE boolean.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).

  IF  ls_todo_list-process-key_data = abap_true.
    "Get the key data of the person to be deleted
    io_request->get_key_data( IMPORTING es_key_data = ls_person_key ).
    IF ls_person_key-id IS NOT INITIAL.
      DELETE FROM zpersons WHERE id = ls_person_key-id.
      IF sy-subrc = 0.
        ls_done_list-key_data = abap_true.
        io_response->set_is_done( ls_done_list ).
      ENDIF.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD personset_read.

  DATA: ls_person_key TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_person     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).

  IF ls_todo_list-process-key_data = abap_true.
    io_request->get_key_data( IMPORTING es_key_data = ls_person_key ). "Get the key data

    SELECT SINGLE * FROM zpersons INTO @DATA(ls_zperson) WHERE id = @ls_person_key-id.
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

  DATA: ls_person     TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.
  DATA: ls_done_list  TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.
  DATA: lv_error      TYPE boolean.

  io_request->get_todos( IMPORTING es_todo_list = DATA(ls_todo_list) ).

  IF ls_todo_list-process-busi_data = abap_true.

    io_request->get_busi_data( IMPORTING es_busi_data = ls_person ).

    IF ls_person-first_name IS INITIAL.
      io_response->get_message_container( )->add_t100(
          iv_msg_type                 = 'E'
          iv_msg_id                   = 'ZTEST_MCH'
          iv_msg_number               = 1  "Mandatory field : First name
          iv_is_for_user              = abap_true        " Is for user?
          iv_leading_message_for_user = abap_false       " Is leading message?
          iv_target                  = 'FirstName'
      ).
      lv_error = abap_true.
    ENDIF.

    IF ls_person-last_name IS INITIAL.
      io_response->get_message_container( )->add_t100(
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
      io_response->get_message_container( )->add_t100(
          iv_msg_type                 = 'E'
          iv_msg_id                   = 'ZTEST_MCH'
          iv_msg_number               = 0  "Error
          iv_is_for_user              = abap_true        " Is for user?
          iv_leading_message_for_user = abap_true       " Is leading message?
      ).

      RAISE EXCEPTION TYPE /iwbep/cx_gateway
        EXPORTING
          message_container = io_response->get_message_container( ).

    ENDIF.

    UPDATE zpersons SET first_name = ls_person-first_name
                        last_name = ls_person-last_name
                        date_of_birth = ls_person-date_of_birth
                    WHERE id = ls_person-id.
    IF sy-subrc = 0.
      ls_person-age = sy-datum(4) - ls_person-date_of_birth(4).
      io_response->set_busi_data( ls_person ).

      ls_done_list-key_data = abap_true.
      ls_done_list-busi_data = abap_true.
    ENDIF.

  ENDIF.

  io_response->set_is_done( ls_done_list ).

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
ENDCLASS.
