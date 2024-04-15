<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gcoold="http://www.isotc211.org/2005/gco" 
    xmlns:gfcold="http://www.isotc211.org/2005/gfc"
    xmlns:gfc="http://standards.iso.org/iso/19110/gfc/1.1"
    xmlns:gmi="http://www.isotc211.org/2005/gmi" 
    xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:gsr="http://www.isotc211.org/2005/gsr" 
    xmlns:gss="http://www.isotc211.org/2005/gss"
    xmlns:gts="http://www.isotc211.org/2005/gts" 
    xmlns:srvold="http://www.isotc211.org/2005/srv"
    xmlns:gml30="http://www.opengis.net/gml"
    xmlns:cat="http://standards.iso.org/iso/19115/-3/cat/1.0"
    xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/2.0"
    xmlns:dqm="http://standards.iso.org/iso/19157/-2/mdq/1.0"
    xmlns:gcx="http://standards.iso.org/iso/19115/-3/gcx/1.0"
    xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0"
    xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0"
    xmlns:srv="http://standards.iso.org/iso/19115/-3/srv/2.0"
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
    xmlns:gml="http://www.opengis.net/gml/3.2" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:dde="https://www.ddeworld.org/resource/standards/dde/ds01/metadata/1.0"
    exclude-result-prefixes="#all">


    <xsl:import href="utility/create19115-3Namespaces.xsl"/>
    <xsl:import href="utility/DDEutilities.xsl"/>
    <!--   <xsl:import href="utility/fromISO19115-3.2014.xsl"/>         utilities to get 2018 namespaces for ISO19115-3 -->
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

            <xsl:if test="exists(dde:identificationInfo/dde:resourceType[text() = 'service'])">
                <mdb:defaultLocale>
                    <lan:PT_Locale>
                        <lan:language>
                            <xsl:call-template name="writeCodelistElement">
                                <xsl:with-param name="elementName" select="'lan:LanguageCode'"/>
                                <xsl:with-param name="codeListName"
                                    select="'https://www.loc.gov/standards/iso639-2/php/code_list.php'"/>
                                <xsl:with-param name="codeListValue"
                                    select="dde:identificationInfo/dde:language[1]"/>
                            </xsl:call-template>
                        </lan:language>

                        <lan:characterEncoding>
                            <xsl:call-template name="writeCodelistElement">
                                <xsl:with-param name="elementName"
                                    select="'lan:MD_CharacterSetCode'"/>
                                <xsl:with-param name="codeListName"
                                    select="'http://www.iana.org/assignments/character-sets'"/>
                                <xsl:with-param name="codeListValue"
                                    select="dde:identificationInfo/dde:characterEncoding[1]"/>
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
                            <xsl:variable name="rtype" select="string(.)"/>
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
                                <xsl:value-of select="string(.)"/>
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
                        <xsl:if test="dde:linkage and not(dde:linkage/@nilReason)">
                        <cit:onlineResource>
                            <xsl:call-template name="CI_OnlineResource">
                                <xsl:with-param name="theOLR" select="."/>
                            </xsl:call-template>
                        </cit:onlineResource>
                        </xsl:if>
                    </cit:CI_Citation>
                </mdb:alternativeMetadataReference>
            </xsl:for-each>

            <!-- spatial reference system -->
            <xsl:for-each
                select="dde:identificationInfo/dde:distributionInfo/dde:spatialRepresentationInfo">
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
                    <xsl:when
                        test="exists(dde:identificationInfo/dde:resourceType[text() = 'service'])">
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
                                            select="dde:identificationInfo/dde:serviceIdentificationInfo/dde:serviceType"
                                        />
                                    </gco:ScopedName>
                                </srv:serviceType>
                                <xsl:if
                                    test="dde:identificationInfo/dde:serviceIdentificationInfo/dde:accessProperties">
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


                        </mri:MD_DataIdentification>
                    </xsl:otherwise>
                </xsl:choose>
            </mdb:identificationInfo>


            <xsl:for-each select="dde:identificationInfo/dde:distributionInfo">
                <mdb:distributionInfo>
                    <mrd:MD_Distribution>
                        <xsl:for-each select="dde:distributionFormat">
                            <mrd:distributionFormat>
                                <mrd:MD_Format>
                                    <mrd:formatSpecificationCitation>
                                        <cit:CI_Citation>
                                            <cit:title>
                                                <gco:CharacterString>
                                                  <xsl:value-of select="string(.)"/>
                                                </gco:CharacterString>
                                            </cit:title>
                                                <xsl:if test="./@href">
                                                  <cit:onlineResource>
                                                  <cit:CI_OnlineResource>
                                                  <cit:linkage>
                                                  <gco:CharacterString>
                                                  <xsl:value-of select="./@href"/>
                                                  </gco:CharacterString>
                                                  </cit:linkage>
                                                  </cit:CI_OnlineResource>
                                                  </cit:onlineResource>
                                                </xsl:if>
                                            
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
                                <xsl:choose>
                                    <xsl:when test="dde:identificationInfo/dde:dataQuality/@href">
                                        <mdq:reportReference>
                                            <cit:CI_Citation>
                                                <cit:title>
                                                  <gco:CharacterString>Quality Report
                                                  Link</gco:CharacterString>
                                                </cit:title>
                                                <cit:onlineResource>
                                                  <cit:CI_OnlineResource>
                                                  <cit:linkage>
                                                  <gco:CharacterString>
                                                  <xsl:value-of
                                                  select="dde:identificationInfo/dde:dataQuality/@href"
                                                  />
                                                  </gco:CharacterString>
                                                  </cit:linkage>
                                                  </cit:CI_OnlineResource>
                                                </cit:onlineResource>
                                            </cit:CI_Citation>
                                        </mdq:reportReference>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <dqm:reportReference gco:nilReason="missing"/>
                                    </xsl:otherwise>
                                </xsl:choose>

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
                            <xsl:choose>
                                <xsl:when test="dde:identificationInfo/dde:lineage/@href">
                                    <xsl:element name="gcx:Anchor">
                                        <xsl:attribute name="xlink:href"
                                            select="dde:identificationInfo/dde:lineage/@href"/>
                                        <xsl:value-of select="dde:identificationInfo/dde:lineage/text()"/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gco:CharacterString>
                                        <xsl:value-of select="dde:identificationInfo/dde:lineage/text()"/>
                                    </gco:CharacterString>
                                </xsl:otherwise>
                            </xsl:choose>
                        </mrl:statement>
                        <xsl:for-each select="dde:identificationInfo/dde:source">
                            <mrl:source>
                                <mrl:LI_Source>
                                    <mrl:sourceCitation>
                                        <cit:CI_Citation>
                                            <cit:title>
                                                <gco:CharacterString>
                                                  <xsl:value-of select="string(.)"/>
                                                </gco:CharacterString>
                                            </cit:title>
                                            <xsl:if test="./@href">
                                                <cit:onlineResource>
                                                  <cit:CI_OnlineResource>
                                                  <cit:linkage>
                                                  <gco:CharacterString>
                                                  <xsl:value-of select="./@href"/>
                                                  </gco:CharacterString>
                                                  </cit:linkage>
                                                  </cit:CI_OnlineResource>
                                                </cit:onlineResource>
                                            </xsl:if>
                                        </cit:CI_Citation>
                                    </mrl:sourceCitation>
                                </mrl:LI_Source>
                            </mrl:source>

                        </xsl:for-each>
                    </mrl:LI_Lineage>
                </mdb:resourceLineage>
            </xsl:if>

<!--            <xsl:for-each select="dde:identificationInfo/dde:acquisitionType">
                <mdb:acquisitionInformation>
                    <mac:MI_AcquisitionInformation>
                        <mac:operation>
                            <mac:MI_Operation>
                                <mac:description>
                                    <gco:CharacterString>
                                        <xsl:value-of select="string(.)"/>
                                    </gco:CharacterString>
                                </mac:description>
                                <mac:status gco:nilReason="unknown"/>
                            </mac:MI_Operation>
                        </mac:operation>
                    </mac:MI_AcquisitionInformation>
                </mdb:acquisitionInformation>
            </xsl:for-each>-->

            <xsl:if test="dde:identificationInfo/dde:imageryInfo or dde:identificationInfo/dde:acquisitionType">
                <!-- imagery metadata mostly fits into acquisition 
                have to handle:  (all minOccurs="0" maxOccurs="unbounded")
            name="sensor" type="metadata:CharacterString_Type"  put in MI_Sensor
            name="platform" type="metadata:CharacterString_Type"   put in MI_Platform
            name="equipment" type="metadata:CharacterString_Type" minOccurs="0" maxOccurs="1"/>  put in MI_Instrument
            name="signalGenerator" type="metadata:CharacterString_Type" minOccurs="0" maxOccurs="1"/>  MI_Operation/mac:otherProperty/gco:Record
                    use otherProperty to distinguish dde:acquisitionType which goes in MI_Operation/description
            name="wavelength" type="metadata:CharacterString_Type" minOccurs="0" maxOccurs="1"/>   put in operation other property
            name="processingLevel"    several places in ISO19115-1....     -->

                <mdb:acquisitionInformation>
                    <mac:MI_AcquisitionInformation>
                        
                        <xsl:for-each select="dde:identificationInfo/dde:imageryInfo/dde:sensor">
                            <mac:instrument>
                                <mac:MI_Sensor>
                                    <!-- identifier and type are mandatory -->
                                    <mac:identifier>
                                        <mcc:MD_Identifier>
                                            <mcc:code>
                                                <gco:CharacterString>
                                                  <xsl:choose>
                                                    <xsl:when test="./@href">
                                                        <xsl:value-of select="./@href"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="string('Missing')"/>
                                                    </xsl:otherwise>
                                                  </xsl:choose>
                                                </gco:CharacterString>
                                            </mcc:code>
                                        </mcc:MD_Identifier>
                                    </mac:identifier>
                                    <mac:type>
                                        <gco:CharacterString>
                                            <xsl:value-of select="string(.)"/>
                                        </gco:CharacterString>
                                    </mac:type>
                                </mac:MI_Sensor>
                            </mac:instrument>
                        </xsl:for-each>
                        <!-- sensor -->

                        <xsl:for-each select="dde:identificationInfo/dde:imageryInfo/dde:equipment">
                            <mac:instrument>
                                <mac:MI_Instrument>
                                    <mac:identifier>
                                        <mcc:MD_Identifier>
                                            <mcc:code>
                                                <gco:CharacterString>
                                                  <xsl:choose>
                                                  <xsl:when test="./@href">
                                                  <xsl:value-of select="./@href"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="string('Missing')"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </gco:CharacterString>
                                            </mcc:code>
                                        </mcc:MD_Identifier>
                                    </mac:identifier>
                                    <mac:type>
                                        <gco:CharacterString>
                                            <xsl:value-of select="string(.)"/>
                                        </gco:CharacterString>
                                    </mac:type>
                                </mac:MI_Instrument>
                            </mac:instrument>
                        </xsl:for-each>
                        <!-- equipment maps to instrument -->

                        <xsl:for-each select="dde:identificationInfo/dde:imageryInfo/dde:signalGenerator">  
                                <mac:operation>
                                    <mac:MI_Operation>
                                        <mac:description>
                                            <xsl:choose>
                                                <xsl:when test="./@href">
                                                    <xsl:element name="gcx:Anchor">
                                                        <xsl:if test="./@href">
                                                            <xsl:attribute name="xlink:href" select="./@href"/>
                                                        </xsl:if>
                                                        <xsl:value-of select="concat(string('signalGenerator: '), string(.))"/>
                                                    </xsl:element>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <gco:CharacterString>
                                                        <xsl:value-of select="concat(string('signalGenerator: '), string(.))"/>
                                                    </gco:CharacterString>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </mac:description>
                                        <mac:status gco:nilReason="unknown"/>
                                    </mac:MI_Operation>
                                </mac:operation>
                        </xsl:for-each>
                                    
                        <xsl:for-each select="dde:identificationInfo/dde:imageryInfo/dde:wavelength">
                            <mac:operation>
                                <mac:MI_Operation>
                                    <mac:description>
                                        <gco:CharacterString>
                                            <xsl:value-of select="concat(string('wavelength: '), string(.))"/>
                                        </gco:CharacterString>
                                    </mac:description>
                                    <mac:status gco:nilReason="unknown"/>
                                </mac:MI_Operation>
                            </mac:operation>
                        </xsl:for-each> 
                                    
                        <xsl:for-each select="dde:identificationInfo/dde:acquisitionType">
                            <mac:operation>
                                <mac:MI_Operation>
                                    <mac:description>
                                        <gco:CharacterString>
                                            <xsl:value-of select="string(.)"/>
                                        </gco:CharacterString>
                                    </mac:description>
                                    <mac:status gco:nilReason="unknown"/>
                                </mac:MI_Operation>
                            </mac:operation>
                        </xsl:for-each>

                        <xsl:for-each select="dde:identificationInfo/dde:imageryInfo/dde:platform">
                            <mac:platform>
                                <mac:MI_Platform>
                                    <mac:identifier>
                                        <mcc:MD_Identifier>
                                            <mcc:code>
                                                <gco:CharacterString>
                                                  <xsl:choose>
                                                  <xsl:when test="./@href">
                                                  <xsl:value-of select="./@href"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="string('Missing')"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </gco:CharacterString>
                                            </mcc:code>
                                        </mcc:MD_Identifier>
                                    </mac:identifier>
                                    <mac:description>
                                        <gco:CharacterString>
                                            <xsl:value-of select="string(.)"/>
                                        </gco:CharacterString>
                                    </mac:description>
                                    <mac:instrument gco:nilReason="missing"/>
                                </mac:MI_Platform>
                            </mac:platform>
                            <!-- platform -->
                        </xsl:for-each>

                    </mac:MI_AcquisitionInformation>
                </mdb:acquisitionInformation>
            </xsl:if>
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
                                <xsl:value-of select="$anIdentifier/dde:authority/dde:name"/>
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
                <xsl:call-template name="appProfile"/>
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
    
    <xsl:template name="appProfile">
        <!--<xsl:param name="theOnlineResource"/>-->
        <cit:applicationProfile>
            <!-- dde allows multiple application profiles, ISO only alows one, 
                        concatenate multiple values.  An applicationProfile may have an href -->
            <xsl:choose>
                <xsl:when test="./child::dde:applicationProfile/@href">
                    <xsl:variable name="thehref">
                        <xsl:for-each select="./child::dde:applicationProfile/@href">
                            <xsl:if test="position() = 1">
                                <!-- only take the first href -->
                                <xsl:value-of select="."/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="otherhref">
                        <xsl:if test="count(./child::dde:applicationProfile/@href) > 1">
                            <xsl:value-of select = "string('other links: ')"/>
                        </xsl:if>
                        <xsl:for-each select="./child::dde:applicationProfile/@href">
                            <xsl:if test="position() > 1">
                                <!-- only take the first href -->
                                <xsl:value-of select="."/>
                                <xsl:value-of select = "string('| ')"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <!-- if there's an href on any applicationProfile, use gcx:Anchor -->
                    <xsl:element name="gcx:Anchor">
                        <xsl:attribute name="xlink:href" select="$thehref"/>
                        <xsl:if test="string-length($otherhref) > 0">
                            <xsl:value-of select="$otherhref"/>
                        </xsl:if>
                        <xsl:for-each select="dde:applicationProfile">
                            <!-- put in a delimiter if necessary -->
                            <xsl:value-of select="string(.)"/>
                            <xsl:if test="position() > 1 and position() &lt; count(dde:applicationProfile)">
                                <xsl:value-of select="string(' | ')"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="gco:CharacterString">
                        <xsl:for-each select="dde:applicationProfile">
                            <xsl:value-of select="string(.)"/>
                            <xsl:if test="position() > 1">
                                <xsl:value-of select="string(' | ')"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </cit:applicationProfile>
        
        
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
                                <xsl:value-of select="string(.)"/>
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
            <xsl:for-each select="//dde:spatialRepresentationInfo/dde:spatialRepresentationType">
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
            <xsl:for-each select="//dde:spatialRepresentationInfo/dde:spatialResolution">
                <mri:spatialResolution>
                    <mri:MD_Resolution>
                        <xsl:choose>
                            <xsl:when test="contains(., ':') and substring-after(., ':') castable as xs:integer">
                                <mri:equivalentScale>
                                    <mri:MD_RepresentativeFraction>
                                        <mri:denominator>
                                            <gco:Integer>
                                                <xsl:value-of select="substring-after(., ':')"/>
                                            </gco:Integer>
                                        </mri:denominator>
                                    </mri:MD_RepresentativeFraction>
                                </mri:equivalentScale>
                            </xsl:when>
                            <xsl:otherwise>
                                <mri:levelOfDetail>
                                    <gco:CharacterString>
                                        <xsl:value-of select="string(.)"/>
                                    </gco:CharacterString>
                                </mri:levelOfDetail>
                            </xsl:otherwise>
                        </xsl:choose>
                    </mri:MD_Resolution>
                </mri:spatialResolution>
            </xsl:for-each>
            <!-- DDE topic category extension terms have GI_ prefix -->
            <xsl:for-each select="dde:topicCategory">
                <!-- <xsl:if test= doesn't start with 'GI_' -->
                <xsl:if test="not(starts-with(., 'GI_')) and not(.[text() = 'dataScience'])">
                    <mri:topicCategory>
                        <mri:MD_TopicCategoryCode>
                            <xsl:value-of select="string(.)"/>
                        </mri:MD_TopicCategoryCode>
                    </mri:topicCategory>
                </xsl:if>
            </xsl:for-each>
            <!-- <xsl:if test= if there is a topic category starts with 'GI_' -->
            <xsl:if
                test="exists(dde:topicCategory[starts-with(text(), 'GI_')]) and not(exists(dde:topicCategory[text() = 'geoscientificInformation']))">
                <mri:topicCategory>
                    <mri:MD_TopicCategoryCode>geoscientificInformation</mri:MD_TopicCategoryCode>
                </mri:topicCategory>
            </xsl:if>

            <xsl:if
                test="exists(dde:topicCategory[text() = 'dataScience']) and not(exists(dde:topicCategory[starts-with(text(), 'GI_')])) and not(exists(dde:topicCategory[text() = 'geoscientificInformation']))">
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
                    <xsl:for-each select="dde:temporalExtent">
                        <gex:temporalElement>
                            <gex:EX_TemporalExtent>
                                <xsl:choose>
                                    <!-- check if temporal extent uses calendar dates -->
                                    <xsl:when
                                        test="dde:temporalExtent/dde:beginDate or dde:temporalExtent/dde:endDate">
                                        <gex:extent>
                                            <gml:TimePeriod>
                                                <gml:description>
                                                  <xsl:value-of
                                                  select="concat('geoTime: ', ../dde:geoTime)"/>
                                                </gml:description>
                                                <gml:begin>
                                                  <gml:TimeInstant>
                                                    <gml:name>
                                                        <xsl:value-of select="dde:beginName"/>
                                                    </gml:name>
                                                    <gml:timePosition>
                                                        <xsl:choose>
                                                            <xsl:when test="dde:temporalExtent/dde:beginDate">
                                                                <xsl:value-of select="dde:temporalExtent/dde:beginDate"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:attribute name="indeterminatePosition" select="unknown"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </gml:timePosition>
                                                  </gml:TimeInstant>
                                                </gml:begin>
                                                <gml:end>
                                                  <gml:TimeInstant>
                                                  <xsl:if test="dde:endName">
                                                  <gml:name>
                                                  <xsl:value-of select="dde:endName"/>
                                                  </gml:name>
                                                  </xsl:if>
                                                  <gml:timePosition>
                                                  <xsl:choose>
                                                  <xsl:when test="dde:temporalExtent/dde:endDate">
                                                  <xsl:value-of
                                                  select="dde:temporalExtent/dde:endDate"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:attribute name="indeterminatePosition"
                                                  select="unknown"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                  </gml:timePosition>
                                                  </gml:TimeInstant>
                                                </gml:end>
                                            </gml:TimePeriod>
                                        </gex:extent>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <!-- geologic age, by name, interval (geologic age) identifier or time position coordinates... -->
                                        <gex:extent>
                                            <gml:TimePeriod>
                                                <gml:description>
                                                    <!-- DDE allow more than one dde:geoTime value -->
                                                    <xsl:value-of
                                                        select="string('geoTime: ')"/>
                                                    <xsl:for-each select="../dde:geoTime">
                                                        <xsl:value-of select="."/>
                                                        <xsl:if test="position()&gt; 0 and position() &lt; count(../dde:geoTime)">
                                                            <xsl:value-of select="string(', ')"/>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                  <!--<xsl:value-of
                                                  select="concat('geoTime: ', ../dde:geoTime)"/>-->
                                                </gml:description>
                                                <gml:begin>
                                                  <!-- beginName is mandatory in DDE -->
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
                                    </xsl:otherwise>
                                </xsl:choose>
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

<!--  DDE processingLevel is in imagery section  -->
            <xsl:if test="//dde:imageryInfo//dde:processingLevel">
            <mri:processingLevel>
                <mcc:MD_Identifier>
                    <mcc:code>
                        <gco:CharacterString>
                            <xsl:value-of select="//dde:imageryInfo//dde:processingLevel"/>
                        </gco:CharacterString>
                    </mcc:code>
                </mcc:MD_Identifier>
            </mri:processingLevel>
            </xsl:if>
            
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
            <!-- <xsl:if test= if there is a topic category starts with 'GI_' -->
            <xsl:if
                test="exists(dde:topicCategory[starts-with(text(), 'GI_')]) or dde:topicCategory[text() = 'dataScience']">
                <mri:descriptiveKeywords>
                    <mri:MD_Keywords>
                        <xsl:for-each select="dde:topicCategory[starts-with(text(), 'GI_')]">
                            <mri:keyword>
                                <gco:CharacterString>
                                    <xsl:value-of select="string(.)"/>
                                </gco:CharacterString>
                            </mri:keyword>
                        </xsl:for-each>
                        <xsl:if test="dde:topicCategory[text() = 'dataScience']">
                            <mri:keyword>
                                <gco:CharacterString>
                                    <xsl:value-of select="string('dataScience')"/>
                                </gco:CharacterString>
                            </mri:keyword>
                        </xsl:if>
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
                            <xsl:choose>
                                <xsl:when test="./@href">
                                    <xsl:element name="gcx:Anchor">
                                        <xsl:attribute name="xlink:href" select="./@href"/>
                                        <xsl:value-of select="string(.)"/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise>
                                    <gco:CharacterString>
                                        <xsl:value-of select="string(.)"/>
                                    </gco:CharacterString>
                                </xsl:otherwise>
                            </xsl:choose>
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
                        <xsl:if test="dde:restrictionText/@href">
                            <mco:reference>
                                <cit:CI_Citation>
                                    <cit:title>
                                        <gco:CharacterString>
                                            <xsl:value-of select="dde:restrictionText"/>
                                        </gco:CharacterString>
                                    </cit:title>
                                    <cit:onlineResource>
                                        <cit:CI_OnlineResource>
                                            <cit:linkage>
                                                <gco:CharacterString>
                                                  <xsl:value-of select="dde:restrictionText/@href"/>
                                                </gco:CharacterString>
                                            </cit:linkage>
                                        </cit:CI_OnlineResource>
                                    </cit:onlineResource>
                                </cit:CI_Citation>
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
                        <xsl:if test="dde:restrictionText and not(dde:restrictionText/@href)">
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
                                    <xsl:choose>
                                        <xsl:when test="dde:resourceCitation/dde:title">
                                            <gco:CharacterString>
                                                <xsl:value-of
                                                  select="dde:resourceCitation/dde:title"/>
                                            </gco:CharacterString>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="gco:nilReason" select="missing"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </cit:title>

                                <cit:onlineResource>
                                    <xsl:for-each select="dde:resourceCitation">
                                        <xsl:call-template name="CI_OnlineResource">
                                            <xsl:with-param name="theOLR"
                                                select="./dde:resourceCitation"/>
                                        </xsl:call-template>
                                    </xsl:for-each>
                                </cit:onlineResource>
                            </cit:CI_Citation>
                        </mri:name>
                        <mri:associationType>
                            <xsl:element name="mri:DS_AssociationTypeCode">
                                <xsl:attribute name="codeList"
                                    select="concat($DDEcodeListLocation, string('#DS_AssociationTypeCode'))"/>
                                <xsl:attribute name="codeListValue"
                                    select="string('crossReference')"/>
                                <!--  the dde:relation value is the text content of the associationtype code   -->
                                <xsl:if test="dde:relation">
                                    <xsl:value-of select="dde:relation"/>
                                </xsl:if>
                            </xsl:element>
                        </mri:associationType>
                    </mri:MD_AssociatedResource>
                </mri:associatedResource>
            </xsl:for-each>
            <!-- done with associated resources -->

            <xsl:if test="not(exists(dde:resourceType[text() = 'service']))">
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
                                <xsl:with-param name="elementName"
                                    select="'lan:MD_CharacterSetCode'"/>
                                <xsl:with-param name="codeListName"
                                    select="'http://www.iana.org/assignments/character-sets'"/>
                                <xsl:with-param name="codeListValue"
                                    select="dde:characterEncoding[1]"/>
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
                        <xsl:value-of select="string(.)"/>
                    </xsl:attribute>
                    <xsl:value-of select="string(.)"/>
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
