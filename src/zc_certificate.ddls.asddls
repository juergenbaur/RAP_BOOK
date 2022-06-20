@EndUserText.label: 'Zertifikatsverwaltung Projection View'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_Certificate as projection on ZI_Certificate {
    key CertUUID,
@Search.defaultSearchElement: true
    Material,
// @ObjectModel.text.element: ['MaterialName'] //Seite 368
//         @Consumption.valueHelpDefinition: [{
//           entity: {
//           name: 'I_MaterialText',
//           element: 'Material'} }]
//         @Search.defaultSearchElement: true
//    key Material,
//    key Version,
//   _MaterialText[Language = $session.system_language ].Material as MaterialName,
//  @ObjectModel.readOnly: true
  @ObjectModel.virtualElementCalculatedBy:
                          'ABAP:ZCL_CERTI_SERVICE'
    virtual MaterialText: abap.char( 150 ),         //Seite 369
    Version,
    CertificationStatus,
    StatusText,
    CertificateCe,
    CertificateGs,
    CertificateFcc,
    CertificateIso,
    CertificateTuev,
    LocalLastChangedAt,
    Criticality,
    /* Associations */
    _CertificateState : redirected to composition child ZC_CertificateState,
    _StatusText
}
