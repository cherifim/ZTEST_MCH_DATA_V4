@EndUserText.label: 'Consumption View for Persons'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_PERSONS as projection on ZI_PERSONS
{
    key Id, 
    FirstName,
    LastName,
    DateOfBirth,
    TeamId,
    AddressId,
    _team
}
