CLASS lhc_Certificate DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Certificate RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Certificate RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Certificate RESULT result.
    METHODS setInitialValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Certificate~setInitialValues.


    METHODS archiveVersion FOR MODIFY
      IMPORTING keys FOR ACTION Certificate~archiveVersion RESULT result.

    METHODS newVersion FOR MODIFY
      IMPORTING keys FOR ACTION Certificate~newVersion RESULT result.

    METHODS releaseVersion FOR MODIFY
      IMPORTING keys FOR ACTION Certificate~releaseVersion RESULT result.

    METHODS checkMaterial FOR VALIDATE ON SAVE
      IMPORTING keys FOR Certificate~checkMaterial.


ENDCLASS.

CLASS lhc_Certificate IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF ZI_Certificate IN LOCAL MODE
    ENTITY Certificate
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(certificates).
    result = VALUE #( FOR Certificate IN certificates
                        ( %tky   = Certificate-%tky
    ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setInitialValues.
    DATA lt_CertificateState  TYPE TABLE FOR CREATE zi_certificate\_CertificateState.
    DATA ls_CertificateState   LIKE LINE OF lt_CertificateState.
    DATA ls_CertificateStateValue LIKE LINE OF ls_certificatestate-%target.
    READ ENTITIES OF zi_certificate IN LOCAL MODE
    ENTITY certificate
    FIELDS ( certificationstatus )
      WITH CORRESPONDING #( keys )
    RESULT DATA(certificates).
    IF certificates IS NOT INITIAL.
      MODIFY ENTITIES OF zi_certificate IN LOCAL MODE
      ENTITY certificate
      UPDATE
      FIELDS ( version certificationstatus )
      WITH VALUE #( FOR certificate IN certificates
                      ( %tky = certificate-%key
                        version = '00001'
                        certificationstatus = '01' " neu
                       )
       ) REPORTED DATA(ls_return).
    ENDIF.
    LOOP AT certificates INTO DATA(ls_certificate).
      ls_CertificateState-%key = ls_certificate-%key.
      ls_CertificateState-CertUUID =
      ls_certificatestatevalue-CertUUID =
      ls_certificate-CertUUID.
      ls_certificatestatevalue-Status = '01'.
      CLEAR ls_certificatestatevalue-StatusOld.
      ls_certificatestatevalue-Version = '01'.
      ls_certificatestatevalue-%control-CertUUID =
             if_abap_behv=>mk-on.
      ls_certificatestatevalue-%control-Status =
             if_abap_behv=>mk-on.
      ls_certificatestatevalue-%control-StatusOld =
             if_abap_behv=>mk-on.
      ls_certificatestatevalue-%control-Version =
             if_abap_behv=>mk-on.
      ls_certificatestatevalue-%control-LastChangedAt =
             if_abap_behv=>mk-on.
      ls_certificatestatevalue-%control-LastChangedBy =
             if_abap_behv=>mk-on.
      APPEND ls_certificatestatevalue
             TO ls_certificatestate-%target.
      APPEND ls_certificatestate TO lt_certificatestate.
      MODIFY ENTITIES OF zi_certificate IN LOCAL MODE
      ENTITY certificate
        CREATE BY \_CertificateState
        FROM lt_CertificateState
            REPORTED DATA(ls_return_ass)
            MAPPED DATA(ls_mapped_ass)
            FAILED  DATA(ls_failed_ass).
    ENDLOOP.

  ENDMETHOD.


  METHOD archiveVersion.
  ENDMETHOD.

  METHOD newVersion.
  ENDMETHOD.

  METHOD releaseVersion.
  ENDMETHOD.

  METHOD checkMaterial.
  ENDMETHOD.

ENDCLASS.
