<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gcoold="http://www.isotc211.org/2005/gco" xmlns:gfcold="http://www.isotc211.org/2005/gfc"
    xmlns:gfc="http://standards.iso.org/iso/19110/gfc/1.1"
    xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gss="http://www.isotc211.org/2005/gss"
    xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:srvold="http://www.isotc211.org/2005/srv"
    xmlns:gml30="http://www.opengis.net/gml"
    xmlns:cat="http://standards.iso.org/iso/19115/-3/cat/1.0"
    xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/2.0"
    xmlns:dqm="http://standards.iso.org/iso/19157/-2/mdq/1.0"
    xmlns:gcx="http://standards.iso.org/iso/19115/-3/gcx/1.0"
    xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0"
    xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0"
    xmlns:srv="http://standards.iso.org/iso/19115/-3/srv/2.1"
    xmlns:mac="http://standards.iso.org/iso/19115/-3/mac/2.0"
    xmlns:mas="http://standards.iso.org/iso/19115/-3/mas/1.0"
    xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
    xmlns:mco="http://standards.iso.org/iso/19115/-3/mco/1.0"
    xmlns:mda="http://standards.iso.org/iso/19115/-3/mda/1.0"
    xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/2.0"
    xmlns:mdt="http://standards.iso.org/iso/19115/-3/mdt/1.0"
    xmlns:mex="http://standards.iso.org/iso/19115/-3/mex/1.0"
    xmlns:mic="http://standards.iso.org/iso/19115/-3/mic/1.0"
    xmlns:mil="http://standards.iso.org/iso/19115/-3/mil/1.0"
    xmlns:mrl="http://standards.iso.org/iso/19115/-3/mrl/2.0"
    xmlns:mds="http://standards.iso.org/iso/19115/-3/mds/2.0"
    xmlns:mmi="http://standards.iso.org/iso/19115/-3/mmi/1.0"
    xmlns:mpc="http://standards.iso.org/iso/19115/-3/mpc/1.0"
    xmlns:mrc="http://standards.iso.org/iso/19115/-3/mrc/2.0"
    xmlns:mrd="http://standards.iso.org/iso/19115/-3/mrd/1.0"
    xmlns:mri="http://standards.iso.org/iso/19115/-3/mri/1.0"
    xmlns:mrs="http://standards.iso.org/iso/19115/-3/mrs/1.0"
    xmlns:msr="http://standards.iso.org/iso/19115/-3/msr/2.0"
    xmlns:mai="http://standards.iso.org/iso/19115/-3/mai/1.0"
    xmlns:mdq="http://standards.iso.org/iso/19157/-2/mdq/1.0"
    xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0"
    xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:dde="https://www.ddeworld.org/resource/metadata/0.4" exclude-result-prefixes="#all">


    <xsl:import href="utility/create19115-3Namespaces.xsl"/>
    <xsl:import href="utility/DDEutilities.xsl"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="DDE-specID"
        select="string('DDE S01-2023: Geosciences Information Metadata')"/>
    <xsl:variable name="ISOcodeListLocation"
        select="'https://standards.iso.org/iso/19115/resources/Codelists/cat/codelists.xml'"/>
    <xsl:variable name="DDEcodeListLocation" select="'https://www.ddeworld.org/resource/codelist/'"/>


    <xsl:template match="dde:MD_Metadata">
        <xsl:element name="mdb:MD_Metadata">
            <!-- new namespaces -->
            <xsl:call-template name="add-iso19115-3.2018-namespaces"/>
            <xsl:attribute name="xsi:schemaLocation"
                select="string('http://standards.iso.org/iso/19115/-3/mdb/2.0 https://schemas.isotc211.org/19115/-3/mds/2.0/mds.xsd')"/>
            <mdb:metadataIdentifier>
                <xsl:call-template name="MD_Identifier">
                    <xsl:with-param name="anIdentifier" select="dde:metadataIdentifier"/>
                </xsl:call-template>
            </mdb:metadataIdentifier>
            
            <xsl:if test="exists(dde:identificationInfo/dde:resourceType[text() = 'Service'])">
                <mdb:defaultLocale>
                    <lan:PT_Locale>
                        <lan:language>
                            <xsl:call-template name="writeCodelistElement">
                                <xsl:with-param name="elementName" select="'lan:LanguageCode'"/>
                                <xsl:with-param name="codeListName"
                                    select="'https://www.loc.gov/standards/iso639-2/php/code_list.php'"/>
                                <xsl:with-param name="codeListValue" select="dde:identificationInfo/dde:language[1]"/>
                            </xsl:call-template>
                        </lan:language>
                        
                        <lan:characterEncoding>
                            <xsl:call-template name="writeCodelistElement">
                                <xsl:with-param name="elementName" select="'lan:MD_CharacterSetCode'"/>
                                <xsl:with-param name="codeListName"
                                    select="'http://www.iana.org/assignments/character-sets'"/>
                                <xsl:with-param name="codeListValue" select="dde:identificationInfo/dde:characterEncoding[1]"/>
                            </xsl:call-template>
                        </lan:characterEncoding>
                    </lan:PT_Locale>
                </mdb:defaultLocale>
            </xsl:if>
            <!-- metadata scope -->
            <xsl:for-each select="dde:identificationInfo/dde:resourceType">
                <mdb:metadataScope>
                    <mdb:MD_MetadataScope>
                        <mdb:resourceScope>
                            <xsl:variable name="rtype" select="."/>
                            <xsl:variable name="clstval"
                                select="$resourceTypeMapping/entry[@key = $rtype]/@value"/>
                            <xsl:call-template name="writeCodelistElement">
                                <xsl:with-param name="elementName" select="'mcc:MD_ScopeCode'"/>
                                <xsl:with-param name="codeListName"
                                    select="concat($DDEcodeListLocation, 'ResourceTypeCode')"/>
                                <xsl:with-param name="codeListValue" select="$clstval"/>
                            </xsl:call-template>
                        </mdb:resourceScope>
                        <mdb:name>
                            <gco:CharacterString>
                                <xsl:value-of select="."/>
                            </gco:CharacterString>
                        </mdb:name>
                    </mdb:MD_MetadataScope>
                </mdb:metadataScope>

            </xsl:for-each>

            <!-- metadata contact -->
            <xsl:for-each select="dde:metadataResponsibleParty">
                <mdb:contact>
                    <xsl:call-template name="Responsibility">
                        <xsl:with-param name="theRes" select="."/>
                    </xsl:call-template>
                </mdb:contact>
            </xsl:for-each>

            <xsl:for-each select="dde:metadataDate">
                <mdb:dateInfo>
                    <xsl:call-template name="CI_Date">
                        <xsl:with-param name="theDate" select="."/>
                    </xsl:call-template>
                </mdb:dateInfo>
            </xsl:for-each>

            <mdb:metadataStandard>
                <cit:CI_Citation>
                    <cit:title>
                        <gco:CharacterString>Geographic information - Metadata - Part 3: XML schema
                            implementation for fundamental concepts</gco:CharacterString>
                    </cit:title>
                    <cit:edition>
                        <gco:CharacterString>ISO 19115-3:2016</gco:CharacterString>
                    </cit:edition>
                </cit:CI_Citation>
            </mdb:metadataStandard>
            <mdb:metadataProfile>
                <cit:CI_Citation>
                    <cit:title>
                        <gco:CharacterString>
                            <xsl:value-of select="$DDE-specID"/>
                        </gco:CharacterString>
                    </cit:title>
                </cit:CI_Citation>
            </mdb:metadataProfile>

            <xsl:for-each select="dde:identificationInfo/dde:metadataReference">
                <mdb:alternativeMetadataReference>
                    <cit:CI_Citation>
                        <cit:title>
                            <gco:CharacterString>
                                <xsl:value-of select="dde:title"/>
                            </gco:CharacterString>
                        </cit:title>
                        <cit:onlineResource>
                            <xsl:call-template name="CI_OnlineResource">
                                <xsl:with-param name="theOLR" select="."/>
                            </xsl:call-template>
                        </cit:onlineResource>
                    </cit:CI_Citation>
                </mdb:alternativeMetadataReference>
            </xsl:for-each>

            <!-- spatial reference system -->
            <xsl:for-each select="dde:distributionInfo/dde:spatialRepresentationInfo">
                <mdb:referenceSystemInfo>
                    <mrs:MD_ReferenceSystem>
                        <xsl:for-each select="dde:referenceSystemIdentifier">
                            <mrs:referenceSystemIdentifier>
                                <xsl:call-template name="MD_Identifier">
                                    <xsl:with-param name="anIdentifier" select="."/>
                                </xsl:call-template>
                            </mrs:referenceSystemIdentifier>
                        </xsl:for-each>
                        <xsl:for-each select="dde:referenceSystemType">
                            <mrs:referenceSystemType>
                                <xsl:call-template name="writeCodelistElement">
                                    <xsl:with-param name="elementName"
                                        select="'mrs:MD_ReferenceSystemTypeCode'"/>
                                    <xsl:with-param name="codeListName"
                                        select="concat($ISOcodeListLocation, '#MD_ReferenceSystemTypeCode')"/>
                                    <xsl:with-param name="codeListValue" select="."/>
                                </xsl:call-template>
                            </mrs:referenceSystemType>
                        </xsl:for-each>
                    </mrs:MD_ReferenceSystem>
                </mdb:referenceSystemInfo>
            </xsl:for-each>

            <mdb:identificationInfo>
                <xsl:choose>
                    <xsl:when test="exists(dde:identificationInfo/dde:resourceType[text() = 'Service'])">
                        <srv:SV_ServiceIdentification>
                            <xsl:call-template name="MD_Identification">
                                <xsl:with-param name="IDobject" select="dde:identificationInfo"/>
                            </xsl:call-template>
                            <!-- service specific properties here -->
                            <xsl:if test="dde:identificationInfo/dde:serviceIdentificationInfo">
                                <srv:serviceType>
                                    <gco:ScopedName>
                                        <xsl:attribute name="codeSpace"
                                            select="string('DDE service type vocabulary')"/>
                                        <xsl:value-of
                                            select="dde:identificationInfo/dde:serviceIdentificationInfo/dde:serviceType"/>
                                    </gco:ScopedName>
                                </srv:serviceType>
                                <xsl:if test="dde:identificationInfo/dde:serviceIdentificationInfo/dde:accessProperties">
                                    <srv:accessProperties>
                                        <mrd:MD_StandardOrderProcess>
                                            <mrd:orderingInstructions>
                                                <gco:CharacterString>
                                                  <xsl:value-of
                                                      select="dde:identificationInfo/dde:serviceIdentificationInfo/dde:accessProperties"
                                                  />
                                                </gco:CharacterString>
                                            </mrd:orderingInstructions>
                                        </mrd:MD_StandardOrderProcess>
                                    </srv:accessProperties>
                                </xsl:if>
                                <xsl:for-each
                                    select="dde:identificationInfo/dde:serviceIdentificationInfo/dde:operatedDataset">
                                    <srv:operatedDataset>
                                        <!-- see https://www.energistics.org/sites/default/files/2023-03/EIP_v1.1.pdf section 4.6.2 -->
                                        <cit:CI_Citation>
                                            <cit:title/>
                                            <cit:identifier>
                                                <xsl:call-template name="MD_Identifier">
                                                  <xsl:with-param name="anIdentifier" select="."/>
                                                </xsl:call-template>
                                            </cit:identifier>
                                        </cit:CI_Citation>
                                    </srv:operatedDataset>
                                </xsl:for-each>
                                <xsl:for-each
                                    select="dde:identificationInfo/dde:serviceIdentificationInfo/dde:containOperations">
                                    <srv:containsOperations>
                                        <srv:SV_OperationMetadata>
                                            <srv:operationName>
                                                <gco:CharacterString>
                                                  <xsl:value-of select="string(.)"/>
                                                </gco:CharacterString>
                                            </srv:operationName>
                                            <srv:distributedComputingPlatform/>
                                            <srv:connectPoint/>
                                        </srv:SV_OperationMetadata>
                                    </srv:containsOperations>
                                </xsl:for-each>
                            </xsl:if>
                            <!-- end dde:serviceIdentificationInfo handler -->
                        </srv:SV_ServiceIdentification>
                    </xsl:when>
                    <xsl:otherwise>
                        <mri:MD_DataIdentification>
                            <xsl:call-template name="MD_Identification">
                                <xsl:with-param name="IDobject"/>
                            </xsl:call-template>

                            <xsl:if test="dde:imageryInfo">
                                <!-- imagery metadata mostly fits into acquisition -->
                            </xsl:if>
                        </mri:MD_DataIdentification>
                    </xsl:otherwise>
                </xsl:choose>
            </mdb:identificationInfo>


            <xsl:for-each select="dde:distributionInfo">
                <mdb:distributionInfo>
                    <mrd:MD_Distribution>
                        <xsl:for-each select="dde:distributionFormat">
                            <mrd:distributionFormat>
                                <mrd:MD_Format>
                                    <mrd:formatSpecificationCitation>
                                        <cit:CI_Citation>
                                            <cit:title>
                                                <gco:CharacterString>
                                                  <xsl:value-of select="."/>
                                                </gco:CharacterString>
                                            </cit:title>
                                        </cit:CI_Citation>
                                    </mrd:formatSpecificationCitation>
                                </mrd:MD_Format>
                            </mrd:distributionFormat>
                        </xsl:for-each>
                        <!-- distribution format -->

                        <xsl:for-each select="dde:distributionResponsibleParty">
                            <mrd:distributor xlink:type="simple">
                                <mrd:MD_Distributor>
                                    <mrd:distributorContact>
                                        <xsl:call-template name="Responsibility">
                                            <xsl:with-param name="theRes" select="."/>
                                        </xsl:call-template>
                                    </mrd:distributorContact>
                                </mrd:MD_Distributor>
                            </mrd:distributor>
                        </xsl:for-each>

                        <xsl:for-each select="dde:onlineResource">
                            <mrd:transferOptions>
                                <mrd:MD_DigitalTransferOptions>
                                    <mrd:onLine>
                                        <xsl:call-template name="CI_OnlineResource">
                                            <xsl:with-param name="theOLR" select="."/>
                                        </xsl:call-template>
                                    </mrd:onLine>
                                </mrd:MD_DigitalTransferOptions>
                            </mrd:transferOptions>
                        </xsl:for-each>
                    </mrd:MD_Distribution>
                </mdb:distributionInfo>
            </xsl:for-each>
            <!-- handle endpoint description as a distribution -->
            <xsl:for-each
                select="dde:identificationInfo/serviceIdentificationInfo/endpointDescription">
                <mdb:distributionInfo>
                    <mrd:MD_Distribution>
                        <mrd:transferOptions>
                            <mrd:MD_DigitalTransferOptions>
                                <mrd:onLine>
                                    <xsl:call-template name="CI_OnlineResource">
                                        <xsl:with-param name="theOLR" select="."/>
                                    </xsl:call-template>
                                </mrd:onLine>
                            </mrd:MD_DigitalTransferOptions>
                        </mrd:transferOptions>
                    </mrd:MD_Distribution>
                </mdb:distributionInfo>
            </xsl:for-each>
            <!-- for each distributioninfo -->

            <xsl:if test="dde:identificationInfo/dde:dataQuality">
                <mdb:dataQualityInfo>
                    <dqm:DQ_DataQuality>
                        <dqm:scope gco:nilReason="missing"/>
                        <dqm:standaloneQualityReport>
                            <dqm:DQ_StandaloneQualityReportInformation>
                                <dqm:reportReference gco:nilReason="missing"/>
                                <dqm:abstract>
                                    <gco:CharacterString>
                                        <xsl:value-of
                                            select="dde:identificationInfo/dde:dataQuality"/>
                                    </gco:CharacterString>
                                </dqm:abstract>
                            </dqm:DQ_StandaloneQualityReportInformation>
                        </dqm:standaloneQualityReport>
                        <dqm:report gco:nilReason="missing"/>
                    </dqm:DQ_DataQuality>
                </mdb:dataQualityInfo>
            </xsl:if>

            <xsl:if test="dde:identificationInfo/dde:lineage">
                <mdb:resourceLineage>
                    <mrl:LI_Lineage>
                        <mrl:statement>
                            <gco:CharacterString>
                                <xsl:value-of select="dde:identificationInfo/dde:lineage"/>
                            </gco:CharacterString>
                        </mrl:statement>
                        <xsl:for-each select="dde:identificationInfo/dde:source">
                            <mrl:source>
                                <mrl:LI_Source>
                                    <mrl:sourceCitation>
                                        <cit:CI_Citation>

                                            <cit:title>
                                                <gco:CharacterString>
                                                  <xsl:value-of select="."/>
                                                </gco:CharacterString>
                                            </cit:title>
                                            <xsl:if test="./@uri">
                                                <cit:identifier>
                                                  <mcc:MD_Identifier>
                                                  <mcc:code>
                                                  <gco:CharacterString>
                                                  <xsl:value-of select="./@uri"/>
                                                  </gco:CharacterString>
                                                  </mcc:code>
                                                  </mcc:MD_Identifier>
                                                </cit:identifier>
                                            </xsl:if>
                                        </cit:CI_Citation>
                                    </mrl:sourceCitation>
                                </mrl:LI_Source>
                            </mrl:source>

                        </xsl:for-each>
                    </mrl:LI_Lineage>
                </mdb:resourceLineage>
            </xsl:if>

            <xsl:for-each select="dde:identificationInfo/dde:acquisitionType">
                <mdb:acquisitionInformation>
                    <mac:MI_AcquisitionInformation>
                        <mac:operation>
                            <mac:MI_Operation>
                                <mac:description>
                                    <gco:CharacterString>
                                        <xsl:value-of select="."/>
                                    </gco:CharacterString>
                                </mac:description>
                                <mac:status gco:nilReason="unknown"/>
                            </mac:MI_Operation>
                        </mac:operation>
                    </mac:MI_AcquisitionInformation>
                </mdb:acquisitionInformation>
            </xsl:for-each>
        </xsl:element>
        <!-- end of mdb:MD_Metadata -->

    </xsl:template>

    <xsl:template name="MD_Identifier">
        <xsl:param name="anIdentifier"/>
        <mcc:MD_Identifier>
            <xsl:if test="$anIdentifier/dde:authority">
                <mcc:authority>
                    <cit:CI_Citation>
                        <cit:title>
                            <gco:CharacterString>
                                <xsl:value-of select="$anIdentifier/dde:authority"/>
                            </gco:CharacterString>
                        </cit:title>
                    </cit:CI_Citation>
                </mcc:authority>
            </xsl:if>
            <mcc:code>
                <gco:CharacterString>
                    <xsl:value-of select="$anIdentifier/dde:code"/>
                </gco:CharacterString>
            </mcc:code>
            <xsl:if test="$anIdentifier/dde:codeSpace">
                <mcc:codeSpace>
                    <gco:CharacterString>
                        <xsl:value-of select="$anIdentifier/dde:codeSpace"/>
                    </gco:CharacterString>
                </mcc:codeSpace>
            </xsl:if>
            <xsl:if test="$anIdentifier/dde:version">
                <mcc:version>
                    <gco:CharacterString>
                        <xsl:value-of select="$anIdentifier/dde:version"/>
                    </gco:CharacterString>
                </mcc:version>
            </xsl:if>
            <xsl:if test="$anIdentifier/dde:description">
                <mcc:description>
                    <gco:CharacterString>
                        <xsl:value-of select="$anIdentifier/dde:description"/>
                    </gco:CharacterString>
                </mcc:description>
            </xsl:if>
        </mcc:MD_Identifier>

    </xsl:template>

    <xsl:template name="Responsibility">
        <xsl:param name="theRes"/>
        <cit:CI_Responsibility>
            <cit:role>
                <xsl:call-template name="writeCodelistElement">
                    <xsl:with-param name="elementName" select="'cit:CI_RoleCode'"/>
                    <xsl:with-param name="codeListName"
                        select="concat($ISOcodeListLocation, '#CI_RoleCode')"/>
                    <xsl:with-param name="codeListValue" select="$theRes/dde:role"/>
                </xsl:call-template>
            </cit:role>
            <cit:party>
                <cit:CI_Individual>
                    <cit:name>
                        <gco:CharacterString>
                            <xsl:value-of select="$theRes/dde:name"/>
                        </gco:CharacterString>
                    </cit:name>
                    <cit:contactInfo>
                        <cit:CI_Contact>
                            <cit:address>
                                <cit:CI_Address>
                                    <cit:country>
                                        <gco:CharacterString>
                                            <xsl:value-of select="$theRes/dde:country"/>
                                        </gco:CharacterString>
                                    </cit:country>
                                    <cit:electronicMailAddress>
                                        <gco:CharacterString>
                                            <xsl:value-of select="$theRes/dde:electronicMailAddress"
                                            />
                                        </gco:CharacterString>
                                    </cit:electronicMailAddress>
                                </cit:CI_Address>
                            </cit:address>
                        </cit:CI_Contact>
                    </cit:contactInfo>
                    <xsl:if test="$theRes/dde:identifier">
                        <cit:partyIdentifier>
                            <xsl:call-template name="MD_Identifier">
                                <xsl:with-param name="anIdentifier" select="$theRes/dde:identifier"
                                />
                            </xsl:call-template>
                        </cit:partyIdentifier>
                    </xsl:if>
                </cit:CI_Individual>
            </cit:party>
        </cit:CI_Responsibility>
    </xsl:template>

    <xsl:template name="CI_Date">
        <xsl:param name="theDate"/>
        <cit:CI_Date>
            <cit:date>
                <gco:DateTime>
                    <xsl:call-template name="TimePositionFormat">
                        <xsl:with-param name="tpos" select="dde:date/text()"/>
                    </xsl:call-template>
                </gco:DateTime>
            </cit:date>
            <cit:dateType>
                <xsl:call-template name="writeCodelistElement">
                    <xsl:with-param name="elementName" select="'cit:CI_DateTypeCode'"/>
                    <xsl:with-param name="codeListName"
                        select="concat($ISOcodeListLocation, '#CI_DateTypeCode')"/>
                    <xsl:with-param name="codeListValue" select="dde:dateType"/>
                </xsl:call-template>
            </cit:dateType>
        </cit:CI_Date>
    </xsl:template>

    <xsl:template name="CI_OnlineResource">
        <xsl:param name="theOLR"/>
        <cit:CI_OnlineResource>
            <cit:linkage>
                <gco:CharacterString>
                    <xsl:value-of select="dde:linkage"/>
                </gco:CharacterString>
            </cit:linkage>
            <xsl:if test="dde:applicationProfile">
                <cit:applicationProfile>
                    <gco:CharacterString>
                        <xsl:value-of select="dde:applicationProfile"/>
                    </gco:CharacterString>
                </cit:applicationProfile>
            </xsl:if>
            <xsl:if test="dde:title">
                <cit:description>
                    <gco:CharacterString>
                        <xsl:value-of select="dde:title"/>
                    </gco:CharacterString>
                </cit:description>
            </xsl:if>
            <cit:function>
                <xsl:call-template name="writeCodelistElement">
                    <xsl:with-param name="elementName" select="'cit:CI_OnLineFunctionCode'"/>
                    <xsl:with-param name="codeListName"
                        select="concat($DDEcodeListLocation, 'FunctionCode')"/>
                    <xsl:with-param name="codeListValue" select="dde:function"/>
                </xsl:call-template>
            </cit:function>
        </cit:CI_OnlineResource>
    </xsl:template>

    <xsl:template name="MD_Identification">
        <xsl:param name="IDobject"/>
        <xsl:for-each select="dde:identificationInfo">

            <mri:citation>
                <cit:CI_Citation>

                    <cit:title>
                        <gco:CharacterString>
                            <xsl:value-of select="string(dde:title)"/>
                        </gco:CharacterString>
                    </cit:title>
                    <xsl:for-each select="dde:alternateTitle">
                        <cit:alternateTitle>
                            <gco:CharacterString>
                                <xsl:value-of select="."/>
                            </gco:CharacterString>
                        </cit:alternateTitle>
                    </xsl:for-each>
                    <xsl:for-each select="dde:resourceDate">
                        <cit:date>
                            <xsl:call-template name="CI_Date">
                                <xsl:with-param name="theDate" select="."/>
                            </xsl:call-template>
                        </cit:date>
                    </xsl:for-each>
                    <cit:edition>
                        <gco:CharacterString>
                            <xsl:value-of select="dde:edition"/>
                        </gco:CharacterString>
                    </cit:edition>

                    <cit:identifier>
                        <xsl:call-template name="MD_Identifier">
                            <xsl:with-param name="anIdentifier" select="dde:resourceIdentifier"/>
                        </xsl:call-template>
                    </cit:identifier>

                    <xsl:for-each select="dde:resourceResponsibleParty">
                        <xsl:if test="not(string(dde:role) = 'pointOfContact')">
                            <cit:citedResponsibleParty>
                                <xsl:call-template name="Responsibility">
                                    <xsl:with-param name="theRes" select="."/>
                                </xsl:call-template>
                            </cit:citedResponsibleParty>
                        </xsl:if>
                    </xsl:for-each>
                </cit:CI_Citation>
            </mri:citation>
            <mri:abstract>
                <gco:CharacterString>
                    <xsl:value-of select="string(dde:abstract)"/>
                </gco:CharacterString>
            </mri:abstract>

            <xsl:for-each select="dde:resourceResponsibleParty">
                <xsl:if test="string(dde:role) = 'pointOfContact'">
                    <mri:pointOfContact>
                        <xsl:call-template name="Responsibility">
                            <xsl:with-param name="theRes" select="."/>
                        </xsl:call-template>
                    </mri:pointOfContact>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each
                select="//dde:spatialRepresentationInfo/dde:spatialRepresentationType">
                <mri:spatialRepresentationType>
                    <xsl:call-template name="writeCodelistElement">
                        <xsl:with-param name="elementName"
                            select="'mcc:MD_SpatialRepresentationTypeCode'"/>
                        <xsl:with-param name="codeListName"
                            select="concat($ISOcodeListLocation, '#MD_SpatialRepresentationTypeCode')"/>
                        <xsl:with-param name="codeListValue" select="."/>
                    </xsl:call-template>
                </mri:spatialRepresentationType>
            </xsl:for-each>
            <xsl:for-each
                select="//dde:spatialRepresentationInfo/dde:spatialResolution">
                <mri:spatialResolution>
                    <mri:MD_Resolution>
                        <xsl:choose>
                            <xsl:when test="contains(., ':')">
                                <mri:equivalentScale>
                                    <mri:MD_RepresentativeFraction>
                                        <mri:denominator>
                                            <gco:Integer><xsl:value-of select="substring-after(., ':')" /></gco:Integer>
                                        </mri:denominator>
                                    </mri:MD_RepresentativeFraction>
                                </mri:equivalentScale>
                            </xsl:when>
                            <xsl:otherwise>
                                <mri:levelOfDetail>
                                    <gco:CharacterString><xsl:value-of select="." /></gco:CharacterString>
                                </mri:levelOfDetail>
                            </xsl:otherwise>
                        </xsl:choose>
                    </mri:MD_Resolution>
                </mri:spatialResolution> </xsl:for-each>
            <xsl:for-each select="dde:topicCategory">
                <!-- <xsl:if test= doesn't start with '8.' -->
                <xsl:if test="not(starts-with(., '8_'))">
                    <mri:topicCategory>
                        <mri:MD_TopicCategoryCode>
                            <xsl:value-of select="."/>
                        </mri:MD_TopicCategoryCode>
                    </mri:topicCategory>
                </xsl:if>
            </xsl:for-each>
            <!-- <xsl:if test= if there is a topic category starts with '8.' -->
            <xsl:if
                test="exists(dde:topicCategory[starts-with(text(), '8_')]) and not(exists(dde:topicCategory[text() = 'geoscientificInformation']))">
                <mri:topicCategory>
                    <mri:MD_TopicCategoryCode>geoscientificInformation</mri:MD_TopicCategoryCode>
                </mri:topicCategory>
            </xsl:if>
            <!-- geographic or temporal extent -->

            <mri:extent>
                <gex:EX_Extent>
                    <xsl:for-each select="dde:geographicExtent">

                        <!-- handle geographic identifier and bounding box -->
                        <xsl:for-each select="dde:geographicIdentifier">
                            <gex:geographicElement>
                                <gex:EX_GeographicDescription>
                                    <gex:geographicIdentifier>
                                        <xsl:call-template name="MD_Identifier">
                                            <xsl:with-param name="anIdentifier" select="."/>
                                        </xsl:call-template>
                                    </gex:geographicIdentifier>
                                </gex:EX_GeographicDescription>
                            </gex:geographicElement>
                        </xsl:for-each>
                        <xsl:if test="dde:westBoundLongitude">
                            <gex:geographicElement>
                                <gex:EX_GeographicBoundingBox>
                                    <gex:westBoundLongitude>
                                        <gco:Decimal>
                                            <xsl:value-of select="dde:westBoundLongitude"/>
                                        </gco:Decimal>
                                    </gex:westBoundLongitude>
                                    <gex:eastBoundLongitude>
                                        <gco:Decimal>
                                            <xsl:value-of select="dde:eastBoundLongitude"/>
                                        </gco:Decimal>
                                    </gex:eastBoundLongitude>
                                    <gex:southBoundLatitude>
                                        <gco:Decimal>
                                            <xsl:value-of select="dde:southBoundLatitude"/>
                                        </gco:Decimal>
                                    </gex:southBoundLatitude>
                                    <gex:northBoundLatitude>
                                        <gco:Decimal>
                                            <xsl:value-of select="dde:northBoundLatitude"/>
                                        </gco:Decimal>
                                    </gex:northBoundLatitude>
                                </gex:EX_GeographicBoundingBox>
                            </gex:geographicElement>
                        </xsl:if>
                    </xsl:for-each>
                    <!-- end geographicExtent -->

                    <!-- temporal extent -->
                    <!-- geoTime is required -->
                    <gex:temporalElement>
                        <gex:EX_TemporalExtent>
                            <gex:extent>
                                <gml:TimePeriod>
                                    <gml:description>
                                        <xsl:value-of select="concat('geoTime: ', dde:geoTime)"/>
                                    </gml:description>
                                    <gml:begin nilReason="inapplicable"/>
                                    <gml:end nilReason="inapplicable"/>
                                </gml:TimePeriod>
                            </gex:extent>
                        </gex:EX_TemporalExtent>
                    </gex:temporalElement>
                    <xsl:for-each select="dde:temporalExtent">
                        <gex:temporalElement>
                            <gex:EX_TemporalExtent>
                                <gex:extent>
                                    <gml:TimePeriod>
                                        <gml:begin>
                                            <gml:TimeInstant>
                                                <xsl:if test="dde:beginIdentifier">
                                                  <xsl:element name="gml:identifier">
                                                  <xsl:attribute name="codeSpace">
                                                  <!-- codespace is required -->
                                                  <xsl:choose>
                                                  <xsl:when test="dde:beginIdentifier/dde:codespace">
                                                  <xsl:value-of
                                                  select="dde:beginIdentifier/dde:codespace"/>
                                                  </xsl:when>
                                                  <xsl:when test="dde:beginIdentifier/dde:authority">
                                                  <xsl:value-of
                                                  select="dde:beginIdentifier/dde:authority"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="string('nilReason missing')"
                                                  />
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                  </xsl:attribute>
                                                  <xsl:value-of
                                                  select="dde:beginIdentifier/dde:code"/>
                                                  </xsl:element>
                                                </xsl:if>
                                                <!-- begin name is required -->
                                                <gml:name>
                                                  <xsl:value-of select="dde:beginName"/>
                                                </gml:name>
                                                <xsl:choose>
                                                  <xsl:when test="dde:beginCoordinate">
                                                  <xsl:element name="gml:timePosition">
                                                  <xsl:attribute name="frame">
                                                  <xsl:value-of
                                                  select="concat(dde:coordinateUnits, ' before present')"
                                                  />
                                                  </xsl:attribute>
                                                  <xsl:value-of select="dde:beginCoordinate"/>
                                                  </xsl:element>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <gml:timePosition indeterminatePosition="unknown"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </gml:TimeInstant>
                                        </gml:begin>
                                        <xsl:choose>
                                            <xsl:when
                                                test="(count(dde:endIdentifier) + count(dde:endName) + count(dde:endCoordinate)) > 0">
                                                <gml:end>
                                                  <gml:TimeInstant>
                                                  <xsl:if test="dde:endIdentifier">
                                                  <xsl:element name="gml:identifier">
                                                  <xsl:attribute name="codeSpace">
                                                  <!-- codespace is required -->
                                                  <xsl:choose>
                                                  <xsl:when test="dde:endIdentifier/dde:codespace">
                                                  <xsl:value-of
                                                  select="dde:endIdentifier/dde:codespace"/>
                                                  </xsl:when>
                                                  <xsl:when test="dde:endIdentifier/dde:authority">
                                                  <xsl:value-of
                                                  select="dde:endIdentifier/dde:authority"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="string('nilReason missing')"
                                                  />
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                  </xsl:attribute>
                                                  <xsl:value-of select="dde:endIdentifier/dde:code"
                                                  />
                                                  </xsl:element>
                                                  </xsl:if>
                                                  <xsl:if test="dde:endName">
                                                  <gml:name>
                                                  <xsl:value-of select="dde:endName"/>
                                                  </gml:name>
                                                  </xsl:if>
                                                  <xsl:choose>
                                                  <xsl:when test="dde:endCoordinate">
                                                  <xsl:element name="gml:timePosition">
                                                  <xsl:attribute name="frame">
                                                  <xsl:value-of
                                                  select="concat(dde:coordinateUnits, ' before present')"
                                                  />
                                                  </xsl:attribute>
                                                  <xsl:value-of select="dde:endCoordinate"/>
                                                  </xsl:element>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <gml:timePosition indeterminatePosition="unknown"
                                                  />
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                  </gml:TimeInstant>
                                                </gml:end>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:element name="gml:end">
                                                  <xsl:attribute name="nilReason">
                                                  <xsl:value-of select="string('inapplicable')"/>
                                                  </xsl:attribute>
                                                </xsl:element>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </gml:TimePeriod>
                                </gex:extent>
                            </gex:EX_TemporalExtent>
                        </gex:temporalElement>
                    </xsl:for-each>

                    <!-- handle elevation -->
                    <xsl:if test="dde:elevation">
                        <!-- kludge to get text value for elevation in the verticalElement -->
                        <gex:verticalElement>
                            <xsl:attribute name="xlink:title"
                                select="concat('elevation:', dde:elevation)"/>
                        </gex:verticalElement>
                    </xsl:if>
                </gex:EX_Extent>
            </mri:extent>
            <!-- end if there is a geographic or temporal extent -->

            <xsl:for-each select="dde:browseGraphic">
                <mri:graphicOverview>
                    <mcc:MD_BrowseGraphic>
                        <mcc:fileName>
                            <gco:CharacterString>
                                <xsl:value-of select="string(dde:title)"/>
                            </gco:CharacterString>
                        </mcc:fileName>
                        <xsl:if test="dde:description">
                            <mcc:fileDescription>
                                <gco:CharacterString>
                                    <xsl:value-of select="string(dde:description)"/>
                                </gco:CharacterString>
                            </mcc:fileDescription>
                        </xsl:if>
                        <xsl:if test="dde:applicationProfile">
                            <mcc:fileType>
                                <gco:CharacterString>
                                    <xsl:variable name="apcount"
                                        select="count(dde:applicationProfile)"/>
                                    <xsl:for-each select="dde:applicationProfile">
                                        <xsl:value-of select="string(.)"/>
                                        <xsl:if test="$apcount > 1">
                                            <xsl:value-of select="string('; ')"/>
                                        </xsl:if>
                                    </xsl:for-each>
                                </gco:CharacterString>
                            </mcc:fileType>
                        </xsl:if>
                        <mcc:linkage>
                            <cit:CI_OnlineResource>
                                <cit:linkage>
                                    <gco:CharacterString>
                                        <xsl:value-of select="dde:linkage"/>
                                    </gco:CharacterString>
                                </cit:linkage>
                            </cit:CI_OnlineResource>
                        </mcc:linkage>
                    </mcc:MD_BrowseGraphic>
                </mri:graphicOverview>
            </xsl:for-each>
            <!-- <xsl:if test= if there is a topic category starts with '8.' -->
            <xsl:if test="exists(dde:topicCategory[starts-with(text(), '8_')])">
                <mri:descriptiveKeywords>
                    <mri:MD_Keywords>
                        <xsl:for-each select="dde:topicCategory[starts-with(text(), '8_')]">
                            <mri:keyword>
                                <gco:CharacterString>
                                    <xsl:value-of select="."/>
                                </gco:CharacterString>
                            </mri:keyword>
                        </xsl:for-each>
                        <mri:type>
                            <mri:MD_KeywordTypeCode
                                codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_KeywordTypeCode"
                                codeListValue="theme">theme</mri:MD_KeywordTypeCode>
                        </mri:type>
                        <mri:thesaurusName>
                            <cit:CI_Citation>
                                <cit:title>
                                    <gco:CharacterString>DDE topic category
                                        extensions</gco:CharacterString>
                                </cit:title>
                            </cit:CI_Citation>
                        </mri:thesaurusName>
                    </mri:MD_Keywords>
                    <!-- dde topic category extensions as keywords -->
                </mri:descriptiveKeywords>
            </xsl:if>

            <!-- regular dde keywords -->
            <mri:descriptiveKeywords>
                <mri:MD_Keywords>
                    <xsl:for-each select="dde:keyword">
                        <mri:keyword>
                            <gco:CharacterString>
                                <xsl:value-of select="."/>
                            </gco:CharacterString>
                        </mri:keyword>
                    </xsl:for-each>
                    <mri:type>
                        <mri:MD_KeywordTypeCode
                            codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_KeywordTypeCode"
                            codeListValue="theme">theme</mri:MD_KeywordTypeCode>
                    </mri:type>
                </mri:MD_Keywords>
            </mri:descriptiveKeywords>

            <xsl:for-each select="dde:restriction">
                <mri:resourceConstraints>
                    <mco:MD_LegalConstraints>
                        <xsl:if test="dde:restrictionText/@uri">
                            <mco:reference>
                                <xsl:attribute name="xlink:href" select="dde:restrictionText/@uri"/>
                            </mco:reference>
                        </xsl:if>
                        <xsl:for-each select="dde:restrictionCode">
                            <mco:useConstraints>
                                <xsl:call-template name="writeCodelistElement">
                                    <xsl:with-param name="elementName"
                                        select="'mco:MD_RestrictionCode'"/>
                                    <xsl:with-param name="codeListName"
                                        select="concat($ISOcodeListLocation, '#MD_RestrictionCode')"/>
                                    <xsl:with-param name="codeListValue" select="."/>
                                </xsl:call-template>
                            </mco:useConstraints>
                        </xsl:for-each>
                        <xsl:if test="dde:restrictionText">
                            <mco:otherConstraints>
                                <gco:CharacterString>
                                    <xsl:value-of select="dde:restrictionText"/>
                                </gco:CharacterString>
                            </mco:otherConstraints>
                        </xsl:if>
                    </mco:MD_LegalConstraints>
                </mri:resourceConstraints>
            </xsl:for-each>

            <xsl:for-each select="dde:associatedResource">
                <mri:associatedResource>
                    <mri:MD_AssociatedResource>
                        <mri:name>
                            <cit:CI_Citation>
                                <cit:title>
                                    <gco:CharacterString>
                                        <xsl:value-of select="dde:title"/>
                                    </gco:CharacterString>
                                </cit:title>
                                <cit:onlineResource>
                                    <xsl:call-template name="CI_OnlineResource">
                                        <xsl:with-param name="theOLR" select="."/>
                                    </xsl:call-template>
                                </cit:onlineResource>
                            </cit:CI_Citation>
                        </mri:name>
                        <mri:associationType>
                            <!-- dde uses function element in ci_online resource for linkage semantics -->
                            <xsl:call-template name="writeCodelistElement">
                                <xsl:with-param name="elementName"
                                    select="'mri:DS_AssociationTypeCode'"/>
                                <xsl:with-param name="codeListName"
                                    select="concat($DDEcodeListLocation, 'FunctionCode')"/>
                                <xsl:with-param name="codeListValue" select="dde:function"/>
                            </xsl:call-template>
                        </mri:associationType>
                    </mri:MD_AssociatedResource>
                </mri:associatedResource>
            </xsl:for-each>

            <xsl:if test="not(exists(dde:resourceType[text() = 'Service']))">
            <mri:defaultLocale>
                <lan:PT_Locale>
                    <lan:language>
                        <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'lan:LanguageCode'"/>
                            <xsl:with-param name="codeListName"
                                select="'https://www.loc.gov/standards/iso639-2/php/code_list.php'"/>
                            <xsl:with-param name="codeListValue" select="dde:language[1]"/>
                        </xsl:call-template>
                    </lan:language>

                    <lan:characterEncoding>
                        <xsl:call-template name="writeCodelistElement">
                            <xsl:with-param name="elementName" select="'lan:MD_CharacterSetCode'"/>
                            <xsl:with-param name="codeListName"
                                select="'http://www.iana.org/assignments/character-sets'"/>
                            <xsl:with-param name="codeListValue" select="dde:characterEncoding[1]"/>
                        </xsl:call-template>
                    </lan:characterEncoding>
                </lan:PT_Locale>
            </mri:defaultLocale>

            <xsl:if test="dde:additionalDocumentation">
                <mri:supplementalInformation>
                    <gco:CharacterString>
                        <xsl:value-of select="dde:additionalDocumentation"/>
                    </gco:CharacterString>
                </mri:supplementalInformation>
            </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- end identification info -->

    <xsl:template name="writeCodelistElement">
        <!-- from geonetwork xslts -->
        <xsl:param name="elementName"/>
        <xsl:param name="codeListName"/>
        <xsl:param name="codeListValue"/>
        <!-- The correct codeList Location goes here -->


        <xsl:for-each select="$codeListValue">
            <xsl:if test="string-length(.) > 0">
                <!--<xsl:element name="{$elementName}"> -->
                <xsl:element name="{$elementName}">
                    <xsl:attribute name="codeList">
                        <xsl:value-of select="$codeListName"/>
                    </xsl:attribute>
                    <xsl:attribute name="codeListValue">
                        <!-- the anyValidURI value is used for testing with paths -->
                        <!--<xsl:value-of select="'anyValidURI'"/>-->
                        <!-- commented out for testing -->
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
                <!--  </xsl:element> -->
                <!--<xsl:if test="@*">
                  <xsl:element name="{$elementName}">
                      <xsl:apply-templates select="@*"/>
                  </xsl:element>
              </xsl:if>-->
            </xsl:if>
        </xsl:for-each>
    </xsl:template>


</xsl:stylesheet>
