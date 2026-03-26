xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://ws.publish.erroraudit.icc.eskom.co.za/";
(:: import schema at "../../Metadata/xsds/ErrorAudit_v5.0.xsd" ::)


declare variable $auditStart as element() (:: schema-element(ns1:AuditLogRequest) ::) external;
declare variable $message as xs:string external;
declare variable $description as xs:string external;

declare function local:generateAuditResponse($auditStart as element() (:: schema-element(ns1:AuditLogRequest) ::), 
                                             $message as xs:string, 
                                             $description as xs:string) 
                                             as element() (:: schema-element(ns1:AuditLogRequest) ::) {
    <ns1:AuditLogRequest>
        <ns1:messageUID>{fn:data($auditStart/ns1:messageUID)}</ns1:messageUID>
        <ns1:transactionId>{fn:data($auditStart/ns1:transactionId)}</ns1:transactionId>
        <ns1:componentName>{fn:data($auditStart/ns1:componentName)}</ns1:componentName>
        {
            if ($auditStart/ns1:applicationServerId)
            then <ns1:applicationServerId>{fn:data($auditStart/ns1:applicationServerId)}</ns1:applicationServerId>
            else ()
        }
        {
            if ($auditStart/ns1:businessKeys)
            then 
                <ns1:businessKeys>
                    {
                        for $businessKey in $auditStart/ns1:businessKeys/ns1:businessKey
                        return 
                        <ns1:businessKey>
                            <ns1:keyName>{fn:data($businessKey/ns1:keyName)}</ns1:keyName>
                            <ns1:keyValue>{fn:data($businessKey/ns1:keyValue)}</ns1:keyValue>
                        </ns1:businessKey>
                    }
                </ns1:businessKeys>
            else ()
        }
        {
            <ns1:description>{fn:data($description)}</ns1:description>
        }
        {
            if ($auditStart/ns1:txnSourceCreateTimestamp)
            then <ns1:txnSourceCreateTimestamp>{fn:data($auditStart/ns1:txnSourceCreateTimestamp)}</ns1:txnSourceCreateTimestamp>
            else ()
        }
        <ns1:startTimestamp>{fn:data($auditStart/ns1:startTimestamp)}</ns1:startTimestamp>
        <ns1:endTimestamp>{fn:current-dateTime()}</ns1:endTimestamp>
        {
            <ns1:message>{fn:data($message)}</ns1:message>
        }
        <ns1:environment>{fn:data($auditStart/ns1:environment)}</ns1:environment>
        <ns1:auditType>END</ns1:auditType>
    </ns1:AuditLogRequest>
};

local:generateAuditResponse($auditStart, $message, $description)