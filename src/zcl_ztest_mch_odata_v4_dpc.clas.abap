class ZCL_ZTEST_MCH_ODATA_V4_DPC definition
  public
  inheriting from /IWBEP/CL_V4_ABS_DATA_PROVIDER
  create public .

public section.

  methods /IWBEP/IF_V4_DP_BASIC~READ_ENTITY_LIST
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~READ_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~UPDATE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~DELETE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~READ_REF_TARGET_KEY_DATA_LIST
    redefinition .
protected section.

  methods TEAM_READ_REF_KEY_LIST
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_REF_L
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_REF_L
    raising
      /IWBEP/CX_GATEWAY .
  methods TEAMSET_UPDATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_UPDATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_UPDATE
    raising
      /IWBEP/CX_GATEWAY .
  methods TEAMSET_READ_LIST
    importing
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_LIST
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_LIST
    raising
      /IWBEP/CX_GATEWAY .
  methods TEAMSET_READ
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_READ
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_READ
    raising
      /IWBEP/CX_GATEWAY .
  methods TEAMSET_DELETE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_DELETE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_DELETE
    raising
      /IWBEP/CX_GATEWAY .
  methods TEAMSET_CREATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_CREATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_CREATE
    raising
      /IWBEP/CX_GATEWAY .
  methods PERSON_READ_REF_KEY_LIST
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_REF_L
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_REF_L
    raising
      /IWBEP/CX_GATEWAY .
  methods PERSONSET_UPDATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_UPDATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_UPDATE
    raising
      /IWBEP/CX_GATEWAY .
  methods PERSONSET_READ_LIST
    importing
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_LIST
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_LIST
    raising
      /IWBEP/CX_GATEWAY .
  methods PERSONSET_READ
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_READ
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_READ
    raising
      /IWBEP/CX_GATEWAY .
  methods PERSONSET_DELETE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_DELETE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_DELETE
    raising
      /IWBEP/CX_GATEWAY .
  methods PERSONSET_CREATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_CREATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_CREATE
    raising
      /IWBEP/CX_GATEWAY .
  methods COMMANDESCDSSET_UPDATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_UPDATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_UPDATE
    raising
      /IWBEP/CX_GATEWAY .
  methods COMMANDESCDSSET_READ_LIST
    importing
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_LIST
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_LIST
    raising
      /IWBEP/CX_GATEWAY .
  methods COMMANDESCDSSET_READ
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_READ
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_READ
    raising
      /IWBEP/CX_GATEWAY .
  methods COMMANDESCDSSET_DELETE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_DELETE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_DELETE
    raising
      /IWBEP/CX_GATEWAY .
  methods COMMANDESCDSSET_CREATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_CREATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_CREATE
    raising
      /IWBEP/CX_GATEWAY .
  methods ADDRESSSET_UPDATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_UPDATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_UPDATE
    raising
      /IWBEP/CX_GATEWAY .
  methods ADDRESSSET_READ_LIST
    importing
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_LIST
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_LIST
    raising
      /IWBEP/CX_GATEWAY .
  methods ADDRESSSET_READ
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_READ
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_READ
    raising
      /IWBEP/CX_GATEWAY .
  methods ADDRESSSET_DELETE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_DELETE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_DELETE
    raising
      /IWBEP/CX_GATEWAY .
  methods ADDRESSSET_CREATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_CREATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_CREATE
    raising
      /IWBEP/CX_GATEWAY .
private section.
ENDCLASS.



CLASS ZCL_ZTEST_MCH_ODATA_V4_DPC IMPLEMENTATION.


  method TEAM_READ_REF_KEY_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_process_list.
  DATA lv_nav_property_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

  io_request->get_navigation_prop( IMPORTING ev_navigation_prop_name = lv_nav_property_name ).

  CASE lv_nav_property_name.
    WHEN 'PERSONS'.
    WHEN OTHERS.
  ENDCASE.

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method TEAMSET_UPDATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_team TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method TEAMSET_READ_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA lt_team TYPE zcl_ztest_mch_odata_v4_mpc=>tt_team.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method TEAMSET_READ.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_team TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method TEAMSET_DELETE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_team TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method TEAMSET_CREATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_team  TYPE zcl_ztest_mch_odata_v4_mpc=>ts_team.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method PERSON_READ_REF_KEY_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_process_list.
  DATA lv_nav_property_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

  io_request->get_navigation_prop( IMPORTING ev_navigation_prop_name = lv_nav_property_name ).

  CASE lv_nav_property_name.
    WHEN OTHERS.
  ENDCASE.

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method PERSONSET_UPDATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_person TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method PERSONSET_READ_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA lt_person TYPE zcl_ztest_mch_odata_v4_mpc=>tt_person.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method PERSONSET_READ.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_person TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method PERSONSET_DELETE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_person TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method PERSONSET_CREATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_person  TYPE zcl_ztest_mch_odata_v4_mpc=>ts_person.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method ADDRESSSET_UPDATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_address TYPE zcl_ztest_mch_odata_v4_mpc=>ts_address.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method ADDRESSSET_READ_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA lt_address TYPE zcl_ztest_mch_odata_v4_mpc=>tt_address.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method ADDRESSSET_READ.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_address TYPE zcl_ztest_mch_odata_v4_mpc=>ts_address.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method ADDRESSSET_DELETE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_address TYPE zcl_ztest_mch_odata_v4_mpc=>ts_address.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method ADDRESSSET_CREATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_address  TYPE zcl_ztest_mch_odata_v4_mpc=>ts_address.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~UPDATE_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  PersonSet
*-------------------------------------------------------------------------*
    WHEN 'PERSONSET'.
*     Call the entity set generated method
      personset_update(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  CommandesCDSSet
*-------------------------------------------------------------------------*
    WHEN 'COMMANDESCDSSET'.
*     Call the entity set generated method
      commandescdsset_update(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  TeamSet
*-------------------------------------------------------------------------*
    WHEN 'TEAMSET'.
*     Call the entity set generated method
      teamset_update(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  AddressSet
*-------------------------------------------------------------------------*
    WHEN 'ADDRESSSET'.
*     Call the entity set generated method
      addressset_update(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~update_entity( io_request  = io_request
                                                  io_response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~READ_REF_TARGET_KEY_DATA_LIST.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC provider subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_source_entity_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_source_entity_type( IMPORTING ev_source_entity_type_name = lv_source_entity_name ).

  CASE lv_source_entity_name.
*-------------------------------------------------------------------------*
*             Entity -  Team
*-------------------------------------------------------------------------*
    WHEN 'TEAM'.
*     Call the entity type generated method
      team_read_ref_key_list(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             Entity -  Person
*-------------------------------------------------------------------------*
    WHEN 'PERSON'.
*     Call the entity type generated method
      person_read_ref_key_list(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~read_ref_target_key_data_list( io_request  = io_request
                                                                  io_response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~READ_ENTITY_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  TeamSet
*-------------------------------------------------------------------------*
    WHEN 'TEAMSET'.
*     Call the entity set generated method
      teamset_read_list(
        EXPORTING
          io_request  = io_request
          io_response = io_response
       ).
*-------------------------------------------------------------------------*
*             EntitySet -  PersonSet
*-------------------------------------------------------------------------*
    WHEN 'PERSONSET'.
*     Call the entity set generated method
      personset_read_list(
        EXPORTING
          io_request  = io_request
          io_response = io_response
       ).
*-------------------------------------------------------------------------*
*             EntitySet -  CommandesCDSSet
*-------------------------------------------------------------------------*
    WHEN 'COMMANDESCDSSET'.
*     Call the entity set generated method
      commandescdsset_read_list(
        EXPORTING
          io_request  = io_request
          io_response = io_response
       ).
*-------------------------------------------------------------------------*
*             EntitySet -  AddressSet
*-------------------------------------------------------------------------*
    WHEN 'ADDRESSSET'.
*     Call the entity set generated method
      addressset_read_list(
        EXPORTING
          io_request  = io_request
          io_response = io_response
       ).
    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~read_entity_list( io_request  = io_request
                                                     io_response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~READ_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  PersonSet
*-------------------------------------------------------------------------*
    WHEN 'PERSONSET'.
*     Call the entity set generated method
      personset_read(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  CommandesCDSSet
*-------------------------------------------------------------------------*
    WHEN 'COMMANDESCDSSET'.
*     Call the entity set generated method
      commandescdsset_read(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  TeamSet
*-------------------------------------------------------------------------*
    WHEN 'TEAMSET'.
*     Call the entity set generated method
      teamset_read(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  AddressSet
*-------------------------------------------------------------------------*
    WHEN 'ADDRESSSET'.
*     Call the entity set generated method
      addressset_read(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~read_entity( io_request  = io_request
                                                io_response = io_response ).


  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~DELETE_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  TeamSet
*-------------------------------------------------------------------------*
    WHEN 'TEAMSET'.
*     Call the entity set generated method
      teamset_delete(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  AddressSet
*-------------------------------------------------------------------------*
    WHEN 'ADDRESSSET'.
*     Call the entity set generated method
      addressset_delete(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  PersonSet
*-------------------------------------------------------------------------*
    WHEN 'PERSONSET'.
*     Call the entity set generated method
      personset_delete(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  CommandesCDSSet
*-------------------------------------------------------------------------*
    WHEN 'COMMANDESCDSSET'.
*     Call the entity set generated method
      commandescdsset_delete(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~delete_entity( io_request  = io_request
                                                  io_response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~CREATE_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  AddressSet
*-------------------------------------------------------------------------*
    WHEN 'ADDRESSSET'.
*     Call the entity set generated method
      addressset_create(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  TeamSet
*-------------------------------------------------------------------------*
    WHEN 'TEAMSET'.
*     Call the entity set generated method
      teamset_create(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  CommandesCDSSet
*-------------------------------------------------------------------------*
    WHEN 'COMMANDESCDSSET'.
*     Call the entity set generated method
      commandescdsset_create(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  PersonSet
*-------------------------------------------------------------------------*
    WHEN 'PERSONSET'.
*     Call the entity set generated method
      personset_create(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~create_entity( io_request  = io_request
                                                  io_response = io_response ).
  ENDCASE.
  endmethod.


  method COMMANDESCDSSET_UPDATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_commandescds TYPE zcl_ztest_mch_odata_v4_mpc=>ts_commandescds.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method COMMANDESCDSSET_READ_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA lt_commandescds TYPE zcl_ztest_mch_odata_v4_mpc=>tt_commandescds.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method COMMANDESCDSSET_READ.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_commandescds TYPE zcl_ztest_mch_odata_v4_mpc=>ts_commandescds.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method COMMANDESCDSSET_DELETE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_commandescds TYPE zcl_ztest_mch_odata_v4_mpc=>ts_commandescds.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method COMMANDESCDSSET_CREATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZTEST_MCH_ODATA_V4_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_commandescds  TYPE zcl_ztest_mch_odata_v4_mpc=>ts_commandescds.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.
ENDCLASS.
