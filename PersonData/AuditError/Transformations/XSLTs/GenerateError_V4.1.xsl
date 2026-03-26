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
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text1" select="$busKeyName"/>
                    <xsl:with-param name="text2" select="$busKeyValue"/>
                </xsl:call-template>            
                <!--<businessKey>
                    <keyName><xsl:value-of select="$busKeyName"/></keyName>
                    <keyValue><xsl:value-of select="$busKeyValue"/></keyValue>
                </businessKey>-->
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
    
    <xsl:template match="string/text()" name="tokenize">
        <xsl:param name="text1" select="."/>
        <xsl:param name="sep1" select="','"/>
        <xsl:param name="text2" select="."/>

        <xsl:choose>
            <xsl:when test="not(contains($text1, $sep1))">
                <businessKey>
                    <keyName>
                        <xsl:value-of select="normalize-space($text1)"/>
                    </keyName>
                    <keyValue>
                        <xsl:value-of select="normalize-space($text2)"/>
                    </keyValue>
                </businessKey>
            </xsl:when>
            <xsl:otherwise>
                <businessKey>
                    <keyName>
                        <xsl:value-of select="normalize-space(substring-before($text1, $sep1))"/>
                    </keyName>
                    <keyValue>
                        <xsl:value-of select="normalize-space(substring-before($text2, $sep1))"/>
                    </keyValue>
                </businessKey>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text1" select="substring-after($text1, $sep1)"/>
                    <xsl:with-param name="text2" select="substring-after($text2, $sep1)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>