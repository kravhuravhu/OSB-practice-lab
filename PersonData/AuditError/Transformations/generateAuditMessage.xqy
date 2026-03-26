xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://ws.publish.erroraudit.icc.eskom.co.za/";
(:: import schema at "../../Metadata/xsds/ErrorAudit_v5.0.xsd" ::)
declare namespace ns2="http://ws.publish.errorauditVariables.icc.eskom.co.za/";
(:: import schema at "../../Metadata/xsds/ErrorAuditVariables_v5.0.xsd" ::)

declare variable $auditVariables as element() (:: schema-element(ns2:AuditErrorVariables) ::) external;
declare variable $message as xs:string external;
declare variable $description as xs:string external;
declare variable $auditType as xs:string external;
declare variable $BusinessRulesFilter as xs:string external;

declare function local:generateAuditResponse($auditVariables as element() (:: schema-element(ns2:AuditErrorVariables) ::), 
                                             $message as xs:string, 
                                             $description as xs:string,
                                             $auditType as xs:string,
                                             $BusinessRulesFilter as xs:string) 
                                             as element() (:: schema-element(ns1:AuditLogRequest) ::) {
    <ns1:AuditLogRequest>
        <ns1:messageUID>{fn:data($auditVariables/ns2:messageUID)}</ns1:messageUID>
        <ns1:transactionId>{fn:data($auditVariables/ns2:transactionId)}</ns1:transactionId>
        <ns1:componentName>{fn:data($auditVariables/ns2:componentName)}</ns1:componentName>
        {
            if ($auditVariables/ns2:applicationServerId)
            then <ns1:applicationServerId>{fn:data($auditVariables/ns2:applicationServerId)}</ns1:applicationServerId>
            else ()
        }
        {
            if (exists($auditVariables/ns2:businessKeys))
            then (
                <ns1:businessKeys>
                    {
                        if ($BusinessRulesFilter != '')
                        then 
                        <ns1:businessKey>
                            <ns1:keyName>BusinessRulesFilter</ns1:keyName>
                            <ns1:keyValue>{fn:data($BusinessRulesFilter)}</ns1:keyValue>
                        </ns1:businessKey>                    
                        else ()
                    }
                    {

                        for $businessKey in $auditVariables/ns2:businessKeys/ns1:businessKey
                        return 
                        <ns1:businessKey>
                            <ns1:keyName>{fn:data($businessKey/ns1:keyName)}</ns1:keyName>
                            <ns1:keyValue>{fn:data($businessKey/ns1:keyValue)}</ns1:keyValue>
                        </ns1:businessKey>

                    }
                </ns1:businessKeys>
            )
            else (
                        if ($BusinessRulesFilter != '')
                        then 
                        <ns1:businessKeys>
                            <ns1:businessKey>
                                <ns1:keyName>BusinessRulesFilter</ns1:keyName>
                                <ns1:keyValue>{fn:data($BusinessRulesFilter)}</ns1:keyValue>
                            </ns1:businessKey>  
                        </ns1:businessKeys> 
                        else ()
            )

        }
        {
            if ($description != '')
            then <ns1:description>{fn:data($description)}</ns1:description>
            else (
                if ($auditType = 'START' and $auditVariables/ns2:startAuditDescription)
                then <ns1:description>{fn:data($auditVariables/ns2:startAuditDescription)}</ns1:description>
                else (                                    
                    if ($auditType = 'END' and $auditVariables/ns2:endAuditDescription)
                    then <ns1:description>{fn:data($auditVariables/ns2:endAuditDescription)}</ns1:description>
                    else (
                        <ns1:description>{fn:data("No Description Defined")}</ns1:description>
                    )                    
                )
            )
        }
        {
            if ($auditVariables/ns2:txnSourceCreateTimestamp)
            then <ns1:txnSourceCreateTimestamp>{fn:data($auditVariables/ns2:txnSourceCreateTimestamp)}</ns1:txnSourceCreateTimestamp>
            else ()
        }
        {
            if ($auditType = 'START' and $auditVariables/ns2:startTimestamp)
            then <ns1:startTimestamp>{fn:data($auditVariables/ns2:startTimestamp)}</ns1:startTimestamp>
            else (
                <ns1:startTimestamp>{fn:current-dateTime()}</ns1:startTimestamp>
            )
        }
        <ns1:endTimestamp>{fn:current-dateTime()}</ns1:endTimestamp>
        {
            if ($message != '')
            then <ns1:message>{fn:data($message)}</ns1:message>
            else (
                <ns1:message>{fn:data($auditVariables/ns2:inputMessage)}</ns1:message>
            )
        }
        <ns1:environment>{fn:data($auditVariables/ns2:environment)}</ns1:environment>
        <ns1:auditType>{fn:data($auditType)}</ns1:auditType>
    </ns1:AuditLogRequest>
};

local:generateAuditResponse($auditVariables, $message, $description, $auditType, $BusinessRulesFilter)