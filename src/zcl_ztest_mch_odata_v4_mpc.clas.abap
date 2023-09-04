class ZCL_ZTEST_MCH_ODATA_V4_MPC definition
  public
  inheriting from /IWBEP/CL_V4_ABS_MODEL_PROV
  create public .

public section.

  types:
     begin of TS_ADDRESS,
         ADDRESS_ID type /IWBEP/SB_ODATA_TY_INT2,
         STREET type STRING,
         STREET_NUMBER type /IWBEP/SB_ODATA_TY_INT2,
         ZIP_CODE type STRING,
         CITY type STRING,
         COUNTRY type STRING,
     end of TS_ADDRESS .
  types:
     TT_ADDRESS type standard table of TS_ADDRESS .
  types:
     TS_COMMANDESCDS type ZVCDS_COMM_MCH .
  types:
     TT_COMMANDESCDS type standard table of TS_COMMANDESCDS .
  types:
     begin of TS_PERSON,
         ID type /IWBEP/SB_ODATA_TY_INT2,
         FIRST_NAME type STRING,
         LAST_NAME type STRING,
         DATE_OF_BIRTH type D,
         AGE type /IWBEP/SB_ODATA_TY_INT2,
     end of TS_PERSON .
  types:
     TT_PERSON type standard table of TS_PERSON .
  types:
     begin of TS_TEAM,
         TEAM_ID type /IWBEP/SB_ODATA_TY_INT2,
         NAME type C length 50,
     end of TS_TEAM .
  types:
     TT_TEAM type standard table of TS_TEAM .

  methods /IWBEP/IF_V4_MP_BASIC~DEFINE
    redefinition .
protected section.
private section.

  methods DEFINE_COMMANDESCDS
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
  methods DEFINE_TEAM
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
  methods DEFINE_ADDRESS
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
  methods DEFINE_PERSON
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
ENDCLASS.



CLASS ZCL_ZTEST_MCH_ODATA_V4_MPC IMPLEMENTATION.


  method /IWBEP/IF_V4_MP_BASIC~DEFINE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZTEST_MCH_ODATA_V4_MPC_EXT
*&-----------------------------------------------------------------------------------------------*
  define_address( io_model ).
  define_commandescds( io_model ).
  define_person( io_model ).
  define_team( io_model ).
  endmethod.


  method DEFINE_ADDRESS.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZTEST_MCH_ODATA_V4_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lo_entity_type    TYPE REF TO /iwbep/if_v4_med_entity_type.
 DATA lo_property       TYPE REF TO /iwbep/if_v4_med_prim_prop.
 DATA lo_entity_set     TYPE REF TO /iwbep/if_v4_med_entity_set.
***********************************************************************************************************************************
*   ENTITY - Address
***********************************************************************************************************************************
 lo_entity_type = io_model->create_entity_type( iv_entity_type_name = 'ADDRESS' ). "#EC NOTEXT

 lo_entity_type->set_edm_name( 'Address' ).                 "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property_by_elem( iv_property_name = 'ADDRESS_ID'
                                                             iv_element_name =  '/IWBEP/SB_ODATA_TY_INT2' ). "#EC NOTEXT
 lo_property->set_add_conversion( abap_true ).
 lo_property->set_edm_name( 'AddressId' ).                  "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Int16' ).        "#EC NOTEXT
 lo_property->set_is_key( ).

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'STREET' ). "#EC NOTEXT
 lo_property->set_edm_name( 'Street' ).                     "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property_by_elem( iv_property_name = 'STREET_NUMBER'
                                                             iv_element_name =  '/IWBEP/SB_ODATA_TY_INT2' ). "#EC NOTEXT
 lo_property->set_add_conversion( abap_true ).
 lo_property->set_edm_name( 'StreetNumber' ).               "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Int16' ).        "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'ZIP_CODE' ). "#EC NOTEXT
 lo_property->set_edm_name( 'ZipCode' ).                    "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'CITY' ). "#EC NOTEXT
 lo_property->set_edm_name( 'City' ).                       "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'COUNTRY' ). "#EC NOTEXT
 lo_property->set_edm_name( 'Country' ).                    "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'ADDRESSSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'AddressSet' ).               "#EC NOTEXT
  endmethod.


  method DEFINE_PERSON.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZTEST_MCH_ODATA_V4_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lo_entity_type    TYPE REF TO /iwbep/if_v4_med_entity_type.
 DATA lo_property       TYPE REF TO /iwbep/if_v4_med_prim_prop.
 DATA lo_entity_set     TYPE REF TO /iwbep/if_v4_med_entity_set.
 DATA lo_nav_prop       TYPE REF TO /iwbep/if_v4_med_nav_prop.
***********************************************************************************************************************************
*   ENTITY - Person
***********************************************************************************************************************************
 lo_entity_type = io_model->create_entity_type( iv_entity_type_name = 'PERSON' ). "#EC NOTEXT

 lo_entity_type->set_edm_name( 'Person' ).                  "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property_by_elem( iv_property_name = 'ID'
                                                             iv_element_name =  '/IWBEP/SB_ODATA_TY_INT2' ). "#EC NOTEXT
 lo_property->set_add_conversion( abap_true ).
 lo_property->set_edm_name( 'ID' ).                         "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Int16' ).        "#EC NOTEXT
 lo_property->set_is_key( ).

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'FIRST_NAME' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'FirstName' ).                  "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->/iwbep/if_v4_med_prim_type~set_scale_variable( ).
 lo_property->set_is_nullable( ).

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'LAST_NAME' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'LastName' ).                   "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->/iwbep/if_v4_med_prim_type~set_scale_variable( ).
 lo_property->set_is_nullable( ).

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'DATE_OF_BIRTH' ). "#EC NOTEXT
 lo_property->set_edm_name( 'DateOfBirth' ).                "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Date' ).         "#EC NOTEXT
 lo_property->set_is_nullable( ).

 lo_property = lo_entity_type->create_prim_property_by_elem( iv_property_name = 'AGE'
                                                             iv_element_name =  '/IWBEP/SB_ODATA_TY_INT2' ). "#EC NOTEXT
 lo_property->set_add_conversion( abap_true ).
 lo_property->set_edm_name( 'Age' ).                        "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Int16' ).        "#EC NOTEXT
 lo_property->set_is_nullable( ).


***********************************************************************************************************************************
*   Navigation Properties
***********************************************************************************************************************************
 lo_nav_prop = lo_entity_type->create_navigation_property( iv_property_name = 'ADDRESS' ). "#EC NOTEXT
 lo_nav_prop->set_edm_name( 'Address' ).                    "#EC NOTEXT
 lo_nav_prop->set_target_entity_type_name( 'ADDRESS' ).
 lo_nav_prop->set_target_multiplicity( 'O' ).
 lo_nav_prop->set_on_delete_action( 'None' ).               "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'PERSONSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'PersonSet' ).                "#EC NOTEXT

 lo_entity_set->add_navigation_prop_binding( iv_navigation_property_path = 'ADDRESS'
                                                              iv_target_entity_set = 'ADDRESSSET' ). "#EC NOTEXT
  endmethod.


  method DEFINE_TEAM.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZTEST_MCH_ODATA_V4_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lo_entity_type    TYPE REF TO /iwbep/if_v4_med_entity_type.
 DATA lo_property       TYPE REF TO /iwbep/if_v4_med_prim_prop.
 DATA lo_entity_set     TYPE REF TO /iwbep/if_v4_med_entity_set.
 DATA lo_nav_prop       TYPE REF TO /iwbep/if_v4_med_nav_prop.
***********************************************************************************************************************************
*   ENTITY - Team
***********************************************************************************************************************************
 lo_entity_type = io_model->create_entity_type( iv_entity_type_name = 'TEAM' ). "#EC NOTEXT

 lo_entity_type->set_edm_name( 'Team' ).                    "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property_by_elem( iv_property_name = 'TEAM_ID'
                                                             iv_element_name =  '/IWBEP/SB_ODATA_TY_INT2' ). "#EC NOTEXT
 lo_property->set_add_conversion( abap_true ).
 lo_property->set_edm_name( 'TeamId' ).                     "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Int16' ).        "#EC NOTEXT
 lo_property->set_is_key( ).

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'NAME' ). "#EC NOTEXT
 lo_property->set_edm_name( 'Name' ).                       "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '50' ).       "#EC NOTEXT


***********************************************************************************************************************************
*   Navigation Properties
***********************************************************************************************************************************
 lo_nav_prop = lo_entity_type->create_navigation_property( iv_property_name = 'PERSONS' ). "#EC NOTEXT
 lo_nav_prop->set_edm_name( 'Persons' ).                    "#EC NOTEXT
 lo_nav_prop->set_target_entity_type_name( 'PERSON' ).
 lo_nav_prop->set_target_multiplicity( 'N' ).
 lo_nav_prop->set_on_delete_action( 'None' ).               "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'TEAMSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'TeamSet' ).                  "#EC NOTEXT

 lo_entity_set->add_navigation_prop_binding( iv_navigation_property_path = 'PERSONS'
                                                              iv_target_entity_set = 'PERSONSET' ). "#EC NOTEXT
  endmethod.


  method DEFINE_COMMANDESCDS.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 03.03.2023 15:22:15 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZTEST_MCH_ODATA_V4_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lo_entity_type    TYPE REF TO /iwbep/if_v4_med_entity_type.
 DATA lo_property       TYPE REF TO /iwbep/if_v4_med_prim_prop.
 DATA lo_entity_set     TYPE REF TO /iwbep/if_v4_med_entity_set.
 DATA lv_commandescds  TYPE zvcds_comm_mch.
***********************************************************************************************************************************
*   ENTITY - CommandesCDS
***********************************************************************************************************************************
 lo_entity_type = io_model->create_entity_type_by_struct( iv_entity_type_name = 'COMMANDESCDS' is_structure = lv_commandescds
                                                          iv_add_conv_to_prim_props = abap_true ). "#EC NOTEXT

 lo_entity_type->set_edm_name( 'CommandesCDS' ).            "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'EKKOEBELN' ). "#EC NOTEXT
 lo_property->set_edm_name( 'EkkoEbeln' ).                  "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_is_key( ).
 lo_property->set_max_length( iv_max_length = '10' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'EKKOBUKRS' ). "#EC NOTEXT
 lo_property->set_edm_name( 'EkkoBukrs' ).                  "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '10' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'EKKOAEDAT' ). "#EC NOTEXT
 lo_property->set_edm_name( 'EkkoAedat' ).                  "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Date' ).         "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'COMMANDESCDSSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'CommandesCDSSet' ).          "#EC NOTEXT
  endmethod.
ENDCLASS.
