@AbapCatalog.sqlViewName: 'ZISTATUSVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Wertehilfe für Status'
@ObjectModel.resultSet.sizeCategory: #XS
define view ZI_Status_VH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name : 'ZBC_STATUS'  )

{
  key  value_low as Value,
       @Semantics.text: true
//       @Search.defaultSearchElement: true
//       @Search.fuzzinessThreshold: 0.8
//       @Search.ranking: #HIGH
       text as Text
//  key domain_name,
//  key value_position,
//      @Semantics.language: true
//  key language,
//      value_low as Value,
//      @Semantics.text: true
//      text as Text
}
where
  language = $session.system_language
