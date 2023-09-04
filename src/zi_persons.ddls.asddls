@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface Entity View for Persons'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PERSONS as select from zpersons 
association to parent ZI_TEAMS as _team on $projection.TeamId = _team.TeamId
{
    key id as Id,
    first_name as FirstName,
    last_name as LastName,
    date_of_birth as DateOfBirth,
    team_id as TeamId,
    address_id as AddressId,
    _team
}
