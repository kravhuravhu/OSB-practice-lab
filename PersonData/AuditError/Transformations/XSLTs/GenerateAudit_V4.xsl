<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : AuditTemplate.xsl
    Created on : 4 August 2015, 4:24 PM
    Author     : SBadat
    Description:
    Purpose of transformation follows.
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="dp"
    exclude-result-prefixes="dp" xmlns:dp="http://www.datapower.com/extensions"
    xmlns:fn-bea="http://www.bea.com/xquery/xquery-functions"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns="http://ws.publish.erroraudit.icc.eskom.co.za/">
    <xsl:param name="msg" select="''"/>
    <xsl:param name="transID" select="''"/>
    <xsl:param name="busKeyName" select="''"/>
    <xsl:param name="busKeyValue" select="''"/>
    <xsl:param name="componentName" select="''"/>
    <xsl:param name="description" select="''"/>
    <xsl:param name="sourceTimeStamp" select="''"/>
    <xsl:param name="messageUID" select="''"/>
    <xsl:param name="appServerID" select="''"/>
    <xsl:param name="environment" select="''"/>
    <xsl:param name="auditType" select="''"/>
    <xsl:output method="xml" encoding="UTF-8"/>
    <xsl:template match="/">
        <AuditLogRequest>
            <messageUID>
                <xsl:value-of select="$messageUID"/>
            </messageUID>
            <transactionId>
                <xsl:value-of select="$transID"/>
            </transactionId>
            <componentName>
                <xsl:value-of select="$componentName"/>
            </componentName>
            <!--Optional:-->
            <applicationServerId>
                <xsl:value-of select="$appServerID"/>
            </applicationServerId>
            <!--Optional:-->
            <businessKeys>
                <businessKey>
                    <keyName>
                        <xsl:value-of select="$busKeyName"/>
                    </keyName>
                    <keyValue>
                        <xsl:value-of select="$busKeyValue"/>
                    </keyValue>
                </businessKey>
            </businessKeys>
            <!--Optional:-->
            <description>
                <xsl:value-of select="$description"/>
            </description>
            <!--Optional:-->
            <txnSourceCreateTimestamp>
                <xsl:value-of select="$sourceTimeStamp"/>
            </txnSourceCreateTimestamp>
            <xsl:if test="upper-case($auditType) = 'START'">
                <startTimestamp>
                    <xsl:value-of select="current-dateTime()"/>
                </startTimestamp>
            </xsl:if>
            <xsl:if test="upper-case($auditType) = 'END'">
                <endTimestamp>
                    <xsl:value-of select="current-dateTime()"/>
                </endTimestamp>
            </xsl:if>
            <!--Optional:-->
            <message>
                <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                <xsl:copy-of select="$msg"/>
                <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
                <!--<xsl:value-of select="$msg"/>-->
            </message>
            <environment>
                <xsl:value-of select="$environment"/>
            </environment>
            <auditType>
                <xsl:value-of select="$auditType"/>
            </auditType>
        </AuditLogRequest>
    </xsl:template>
</xsl:stylesheet>