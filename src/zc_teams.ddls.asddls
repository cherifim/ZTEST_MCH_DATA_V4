@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View for Teams'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZC_TEAMS 
  as projection on ZI_TEAMS as Team {
    @EndUserText.label: 'Team Id'
    key TeamId,
    @EndUserText.label: 'Name'
    Name,
    _persons
}
