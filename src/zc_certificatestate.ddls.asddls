@EndUserText.label: 'Zertverwaltung Status Projection View'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_CertificateState as projection on ZI_CertificateState {
    key StateUUID,
    CertUUID,
    Material,
    Version,
    Status,
    StatusOld,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Certificate: redirected to parent ZC_Certificate
}
