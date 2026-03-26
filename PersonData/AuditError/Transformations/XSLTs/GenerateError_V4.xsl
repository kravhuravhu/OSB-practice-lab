<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : ErrorTemplate.xsl
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
    <xsl:param name="exception" select="''"/>
    <xsl:param name="criticality" select="''"/>
    <xsl:param name="category" select="''"/>
    <xsl:param name="messageUID" select="''"/>
    <xsl:param name="appServerID" select="''"/>
    <xsl:param name="environment" select="''"/>
    <xsl:param name="sourceTimeStamp" select="''"/>
    <xsl:output method="xml" encoding="UTF-8"/>
    <xsl:template match="/">
        <ErrorLogRequest>
            <messageUID><xsl:value-of select="$messageUID"/></messageUID>
            <transactionId><xsl:value-of select="$transID"/></transactionId>
            <componentName><xsl:value-of select="$componentName"/></componentName>
            <!--Optional:-->
            <applicationServerId><xsl:value-of select="$appServerID"/></applicationServerId>
            <!--Optional:-->
            <businessKeys>
                <businessKey>
                    <keyName><xsl:value-of select="$busKeyName"/></keyName>
                    <keyValue><xsl:value-of select="$busKeyValue"/></keyValue>
                </businessKey>
            </businessKeys>
            <!--Optional:-->
            <description><xsl:value-of select="$description"/></description>
            <!--Optional:-->
            <txnSourceCreateTimestamp><xsl:value-of select="$sourceTimeStamp"/></txnSourceCreateTimestamp>
            <exception>
            <!--<xsl:value-of select="$exception"/>-->
                <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                <xsl:copy-of select="$exception"/>
                <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
              </exception>
            <criticality><xsl:value-of select="$criticality"/></criticality>
            <category><xsl:value-of select="$category"/></category>
            <timestamp><xsl:value-of select="current-dateTime()"/></timestamp>            
            <!--Optional:-->
            <message>
                <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                <xsl:copy-of select="$msg"/>
                <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
            </message>
            <environment><xsl:value-of select="$environment"/></environment>
        </ErrorLogRequest>
    </xsl:template>
</xsl:stylesheet>