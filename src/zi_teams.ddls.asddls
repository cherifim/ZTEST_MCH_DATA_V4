@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface Entity View for Teams'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_TEAMS
  as select from zteams
  composition [0..*] of ZI_PERSONS as _persons
{
  key team_id as TeamId,
      name    as Name,
      _persons
}
