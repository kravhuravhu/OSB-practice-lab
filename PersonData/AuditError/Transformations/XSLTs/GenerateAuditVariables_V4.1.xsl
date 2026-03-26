<?xml version="1.0" encoding="UTF-8"?>
<!--
    Document   : AuditTemplate.xsl
    Created on : 4 August 2015, 4:24 PM
    Author     : SBadat
    Description:
    Purpose of transformation follows.
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:date="http://exslt.org/dates-and-times" xmlns:fn-bea="http://www.bea.com/xquery/xquery-functions" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:tns="http://ws.publish.erroraudit.icc.eskom.co.za/" xmlns:tns2="http://ws.publish.errorauditVariables.icc.eskom.co.za/">
	<xsl:param name="parInputMessage" select="''"/>
	<xsl:param name="parTransactionId" select="''"/>
	<xsl:param name="parBusKeyName1" select="''"/>
	<xsl:param name="parBusKeyValue1" select="''"/>
	<xsl:param name="parBusKeyName2" select="''"/>
	<xsl:param name="parBusKeyValue2" select="''"/>
	<xsl:param name="parBusKeyName3" select="''"/>
	<xsl:param name="parBusKeyValue3" select="''"/>
	<xsl:param name="parBusKeyName4" select="''"/>
	<xsl:param name="parBusKeyValue4" select="''"/>
	<xsl:param name="parBusKeyName5" select="''"/>
	<xsl:param name="parBusKeyValue5" select="''"/>				
	<xsl:param name="parComponentName" select="''"/>
	<xsl:param name="parTXNSourceCreateTimestamp" select="''"/>
	<xsl:param name="parMessageUID" select="''"/>
	<xsl:param name="parApplicationServerId" select="''"/>
	<xsl:param name="parEnvironment" select="''"/>
	<xsl:param name="parStartAuditDescription" select="''"/>
	<xsl:param name="parEndAuditDescription" select="''"/>
	<xsl:param name="parErrorDescription" select="''"/>
	<xsl:param name="parErrorCriticality" select="''"/>
	<xsl:param name="parServiceOperation" select="''"/>
	<xsl:param name="parMessageName" select="''"/>
	<xsl:param name="parSourceApplication" select="''"/>
	<xsl:param name="parTargetSystems" select="''"/>
	<xsl:param name="parCallerComponent" select="''"/>
	<xsl:output method="xml" encoding="UTF-8"/>
	<xsl:template match="/">
		<tns2:AuditErrorVariables>
			<tns2:messageUID>
				<xsl:value-of select="$parMessageUID"/>
			</tns2:messageUID>
			<tns2:transactionId>
				<xsl:value-of select="$parTransactionId"/>
			</tns2:transactionId>
			<tns2:componentName>
				<xsl:value-of select="$parComponentName"/>
			</tns2:componentName>
			<tns2:applicationServerId>
				<xsl:value-of select="$parApplicationServerId"/>
			</tns2:applicationServerId>
			<xsl:variable name="varBK">

						<xsl:variable name="varBK1">
							<xsl:choose>
								<xsl:when test="$parBusKeyName1 != '' ">
									<xsl:value-of select="$parBusKeyName1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="''"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						
						<xsl:variable name="varBK2">
							<xsl:choose>
								<xsl:when test="$parBusKeyName2 != '' and $varBK1 != '' ">
									<xsl:value-of select="concat($varBK1,',',$parBusKeyName2)"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName2 != '' and $varBK1 = '' ">
									<xsl:value-of select="$parBusKeyName2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK1"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						
						<xsl:variable name="varBK3">
							<xsl:choose>
								<xsl:when test="$parBusKeyName3 != '' and $varBK2 != '' ">
									<xsl:value-of select="concat($varBK2,',',$parBusKeyName3)"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName3 != '' and $varBK2 = '' ">
									<xsl:value-of select="$parBusKeyName3"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK2"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						
						<xsl:variable name="varBK4">
							<xsl:choose>
								<xsl:when test="$parBusKeyName4 != '' and $varBK3 != '' ">
									<xsl:value-of select="concat($varBK3,',',$parBusKeyName4)"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName4 != '' and $varBK3 = '' ">
									<xsl:value-of select="$parBusKeyName4"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK3"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						
						<xsl:variable name="varBK5">
							<xsl:choose>
								<xsl:when test="$parBusKeyName5 != '' and $varBK4 != '' ">
									<xsl:value-of select="concat($varBK4,',',$parBusKeyName5)"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName5 != '' and $varBK4 = '' ">
									<xsl:value-of select="$parBusKeyName5"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK4"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						
						<xsl:variable name="varBK6">
							<xsl:choose>
								<xsl:when test="$parServiceOperation != '' and $varBK5 != '' ">
									<xsl:value-of select="concat($varBK5,',','ServiceOperation')"/>
								</xsl:when>
								<xsl:when test="$parServiceOperation != '' and $varBK5 = '' ">
									<xsl:value-of select="'ServiceOperation'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK5"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<xsl:variable name="varBK7">
							<xsl:choose>
								<xsl:when test="$parMessageName != '' and $varBK6 != '' ">
									<xsl:value-of select="concat($varBK6,',','MessageName')"/>
								</xsl:when>
								<xsl:when test="$parMessageName != '' and $varBK6 = '' ">
									<xsl:value-of select="'MessageName'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK6"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="varBK8">
							<xsl:choose>
								<xsl:when test="$parSourceApplication != '' and $varBK7 != '' ">
									<xsl:value-of select="concat($varBK7,',','SourceApplication')"/>
								</xsl:when>
								<xsl:when test="$parSourceApplication != '' and $varBK7 = '' ">
									<xsl:value-of select="'SourceApplication'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK7"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="varBK9">
							<xsl:choose>
								<xsl:when test="$parTargetSystems != '' and $varBK8 != '' ">
									<xsl:value-of select="concat($varBK8,',','TargetSystems')"/>
								</xsl:when>
								<xsl:when test="$parTargetSystems != '' and $varBK8 = '' ">
									<xsl:value-of select="'TargetSystems'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK8"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="varBK10">
							<xsl:choose>
								<xsl:when test="$parCallerComponent != '' and $varBK9 != '' ">
									<xsl:value-of select="concat($varBK9,',','CallerComponent')"/>
								</xsl:when>
								<xsl:when test="$parCallerComponent != '' and $varBK9 = '' ">
									<xsl:value-of select="'CallerComponent'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBK9"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="$varBK10"/>


			</xsl:variable>
			
			<xsl:variable name="varBKV">

						<xsl:variable name="varBKV1">
							<xsl:choose>
								<xsl:when test="$parBusKeyName1 != '' and $parBusKeyValue1 != '' ">
									<xsl:value-of select="concat($parBusKeyValue1, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName1 != '' and $parBusKeyValue1 = '' ">
									<xsl:value-of select="','"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="''"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
								
						
						<xsl:variable name="varBKV2">
							<xsl:choose>
								<xsl:when test="$parBusKeyName2 != '' and $parBusKeyValue2 != '' and $varBKV1 = '' ">
									<xsl:value-of select="concat($parBusKeyValue2, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName2 != '' and $parBusKeyValue2 = '' and $varBKV1 = '' ">
									<xsl:value-of select="','"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName2 != '' and $parBusKeyValue2 = '' and $varBKV1 != '' ">
									<xsl:value-of select="concat($varBKV1, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName2 != '' and $parBusKeyValue2 != '' and $varBKV1 != '' ">
									<xsl:value-of select="concat($varBKV1, $parBusKeyValue2,',')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBKV1"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						
						<xsl:variable name="varBKV3">
							<xsl:choose>
								<xsl:when test="$parBusKeyName3 != '' and $parBusKeyValue3 != '' and $varBKV2 = '' ">
									<xsl:value-of select="concat($parBusKeyValue3, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName3 != '' and $parBusKeyValue3 = '' and $varBKV2 = '' ">
									<xsl:value-of select="','"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName3 != '' and $parBusKeyValue3 = '' and $varBKV2 != '' ">
									<xsl:value-of select="concat($varBKV2, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName3 != '' and $parBusKeyValue3 != '' and $varBKV2 != '' ">
									<xsl:value-of select="concat($varBKV2, $parBusKeyValue3, ',')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBKV2"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>				
						<xsl:variable name="varBKV4">
							<xsl:choose>
								<xsl:when test="$parBusKeyName4 != '' and $parBusKeyValue4 != '' and $varBKV3 = '' ">
									<xsl:value-of select="concat($parBusKeyValue4, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName4 != '' and $parBusKeyValue4 = '' and $varBKV3 = '' ">
									<xsl:value-of select="','"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName4 != '' and $parBusKeyValue4 = '' and $varBKV3 != '' ">
									<xsl:value-of select="concat($varBKV3, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName4 != '' and $parBusKeyValue4 != '' and $varBKV3 != '' ">
									<xsl:value-of select="concat($varBKV3,$parBusKeyValue4, ',')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBKV3"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>										
						<xsl:variable name="varBKV5">
							<xsl:choose>
								<xsl:when test="$parBusKeyName5 != '' and $parBusKeyValue5 != '' and $varBKV4 = '' ">
									<xsl:value-of select="concat($parBusKeyValue5, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName5 != '' and $parBusKeyValue5 = '' and $varBKV4 = '' ">
									<xsl:value-of select="','"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName5 != '' and $parBusKeyValue5 = '' and $varBKV4 != '' ">
									<xsl:value-of select="concat($varBKV4, ',')"/>
								</xsl:when>
								<xsl:when test="$parBusKeyName5 != '' and $parBusKeyValue5 != '' and $varBKV4 != '' ">
									<xsl:value-of select="concat($varBKV4, $parBusKeyValue5, ',')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$varBKV4"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>			

						<xsl:variable name="varBKV6">
							<xsl:choose>
								<xsl:when test="$parServiceOperation != '' and $varBKV5 = '' ">
									<xsl:value-of select="concat($parServiceOperation, ',')"/>
								</xsl:when>
								<xsl:when test="$parServiceOperation != '' and $varBKV5 != '' ">
									<xsl:value-of select="concat($varBKV5, $parServiceOperation , ',')"/>
								</xsl:when>

								<xsl:otherwise>
									<xsl:value-of select="$varBKV5"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="varBKV7">
							<xsl:choose>
								<xsl:when test="$parMessageName != '' and $varBKV6 = '' ">
									<xsl:value-of select="concat($parMessageName, ',')"/>
								</xsl:when>
								<xsl:when test="$parMessageName != '' and $varBKV6 != '' ">
									<xsl:value-of select="concat($varBKV6, $parMessageName , ',')"/>
								</xsl:when>

								<xsl:otherwise>
									<xsl:value-of select="$varBKV6"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="varBKV8">
							<xsl:choose>
								<xsl:when test="$parSourceApplication != '' and $varBKV7 = '' ">
									<xsl:value-of select="concat($parSourceApplication, ',')"/>
								</xsl:when>
								<xsl:when test="$parSourceApplication != '' and $varBKV7 != '' ">
									<xsl:value-of select="concat($varBKV6, $parSourceApplication , ',')"/>
								</xsl:when>
								

								<xsl:otherwise>
									<xsl:value-of select="$varBKV7"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="varBKV9">
							<xsl:choose>
								<xsl:when test="$parTargetSystems != '' and $varBKV8 = '' ">
									<xsl:value-of select="concat($parTargetSystems, ',')"/>
								</xsl:when>
								<xsl:when test="$parTargetSystems != '' and $varBKV8 != '' ">
									<xsl:value-of select="concat($varBKV8, $parTargetSystems , ',')"/>
								</xsl:when>
								
								<xsl:otherwise>
									<xsl:value-of select="$varBKV8"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="varBKV10">
							<xsl:choose>
								<xsl:when test="$parCallerComponent != '' and $varBKV9 = '' ">
									<xsl:value-of select="concat($parCallerComponent, ',')"/>
								</xsl:when>
								<xsl:when test="$parCallerComponent != '' and $varBKV9 != '' ">
									<xsl:value-of select="concat($varBKV9, $parCallerComponent , ',')"/>
								</xsl:when>
								
								<xsl:otherwise>
									<xsl:value-of select="$varBKV9"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="$varBKV10"/>

			</xsl:variable>
			
			<xsl:variable name="varBKVFin">
				<xsl:choose>
					<xsl:when test="$varBKV != '' ">
						<xsl:value-of select="substring($varBKV, 1, string-length($varBKV) - 1)"/>
					</xsl:when>
					
					<xsl:otherwise>
						<xsl:value-of select="$varBKV"/>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:variable>
			
			<tns2:businessKeysKey>
				<xsl:value-of select="$varBK"/>
			</tns2:businessKeysKey>
			<tns2:businessKeysValue>
				<xsl:value-of select="$varBKVFin"/>
			</tns2:businessKeysValue>
			<xsl:if test="$varBK != '' ">
				<tns2:businessKeys>
					<xsl:call-template name="tokenize">
						<xsl:with-param name="text1" select="$varBK"/>
						<xsl:with-param name="text2" select="$varBKVFin"/>
					</xsl:call-template>
				</tns2:businessKeys>
			</xsl:if>
			<tns2:startAuditDescription>
				<xsl:value-of select="$parStartAuditDescription"/>
			</tns2:startAuditDescription>
			<tns2:endAuditDescription>
				<xsl:value-of select="$parEndAuditDescription"/>
			</tns2:endAuditDescription>
			<tns2:errorDescription>
				<xsl:value-of select="$parErrorDescription"/>
			</tns2:errorDescription>
			<tns2:txnSourceCreateTimestamp>
				<xsl:value-of select="$parTXNSourceCreateTimestamp"/>
			</tns2:txnSourceCreateTimestamp>
			<tns2:startTimestamp>
				<xsl:value-of select="current-dateTime()"/>
			</tns2:startTimestamp>
			<tns2:inputMessage>
				<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
				<xsl:copy-of select="$parInputMessage"/>
				<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
				<!--<xsl:value-of select="$msg"/>-->
			</tns2:inputMessage>
			<tns2:environment>
				<xsl:value-of select="$parEnvironment"/>
			</tns2:environment>
			<tns2:errorCriticality>
				<xsl:value-of select="$parErrorCriticality"/>
			</tns2:errorCriticality>
			<tns2:serviceOperation>
				<xsl:value-of select="$parServiceOperation"/>
			</tns2:serviceOperation>
			<tns2:messageName>
				<xsl:value-of select="$parMessageName"/>
			</tns2:messageName>
			<tns2:sourceApplication>
				<xsl:value-of select="$parSourceApplication"/>
			</tns2:sourceApplication>
			<tns2:targetSystems>
				<xsl:value-of select="$parTargetSystems"/>
			</tns2:targetSystems>
			<tns2:callerComponent>
				<xsl:value-of select="$parCallerComponent"/>
			</tns2:callerComponent>
		</tns2:AuditErrorVariables>
	</xsl:template>
	<xsl:template match="string/text()" name="tokenize">
		<xsl:param name="text1" select="."/>
		<xsl:param name="sep1" select="','"/>
		<xsl:param name="text2" select="."/>
		<xsl:choose>
			<xsl:when test="not(contains($text1, $sep1))">
				<tns:businessKey>
					<tns:keyName>
						<xsl:value-of select="normalize-space($text1)"/>
					</tns:keyName>
					<tns:keyValue>
						<xsl:value-of select="normalize-space($text2)"/>
					</tns:keyValue>
				</tns:businessKey>
			</xsl:when>
			<xsl:otherwise>
				<tns:businessKey>
					<tns:keyName>
						<xsl:value-of select="normalize-space(substring-before($text1, $sep1))"/>
					</tns:keyName>
					<tns:keyValue>
						<xsl:value-of select="normalize-space(substring-before($text2, $sep1))"/>
					</tns:keyValue>
				</tns:businessKey>
				<xsl:call-template name="tokenize">
					<xsl:with-param name="text1" select="substring-after($text1, $sep1)"/>
					<xsl:with-param name="text2" select="substring-after($text2, $sep1)"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>