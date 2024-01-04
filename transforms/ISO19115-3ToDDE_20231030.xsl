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
    xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:dde="https://www.ddeworld.org/resource/metadata/0.4" exclude-result-prefixes="#all">


    <!--    <xsl:import href="utility/create19115-3Namespaces.xsl"/>-->
    <xsl:import href="utility/DDEutilities.xsl"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="DDE-specID"
        select="string('DDE S01-2023: Geosciences Information Metadata')"/>
    <xsl:variable name="ISOcodeListLocation"
        select="'https://standards.iso.org/iso/19115/resources/Codelists/cat/codelists.xml'"/>
    <xsl:variable name="DDEcodeListLocation" select="'https://www.ddeworld.org/resource/codelist/'"/>


    <xsl:template match="mdb:MD_Metadata">
        <xsl:element name="dde:MD_Metadata" xmlns="https://www.ddeworld.org/resource/metadata/0.4">

            <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
            <xsl:attribute name="xsi:schemaLocation"
                select="string('https://www.ddeworld.org/resource/metadata/0.4 DraftDDEMetadataProposal20231030.xsd')"/>

            <dde:metadataIdentifier>
                <xsl:apply-templates select="mdb:metadataIdentifier/mcc:MD_Identifier"/>
            </dde:metadataIdentifier>
            <dde:metadataStandardName>DDE S01-2023: Geosciences Information
                Metadata</dde:metadataStandardName>
            <xsl:for-each select="mdb:contact">
                <dde:metadataResponsibleParty>
                    <xsl:apply-templates select="cit:CI_Responsibility"/>
                </dde:metadataResponsibleParty>
            </xsl:for-each>

            <xsl:for-each select="mdb:dateInfo">
                <dde:metadataDate>
                    <xsl:apply-templates select="cit:CI_Date"/>
                </dde:metadataDate>
            </xsl:for-each>

            <dde:identificationInfo>
                <dde:resourceIdentifier>
                    <!-- ISO19115-3 allows multiple identifiers; for now we just take the first -->
                    <xsl:apply-templates
                        select="mdb:identificationInfo//mri:citation//cit:identifier[1]/mcc:MD_Identifier"
                    />
                </dde:resourceIdentifier>
                <dde:title>
                    <xsl:value-of
                        select="mdb:identificationInfo//mri:citation//cit:title/gco:CharacterString"
                    />
                </dde:title>
                <xsl:for-each select="mdb:identificationInfo//mri:citation//cit:alternateTitle">
                    <dde:alternateTitle>
                        <xsl:value-of select="."/>
                    </dde:alternateTitle>
                </xsl:for-each>
                <xsl:for-each select="mdb:identificationInfo//mri:citation/cit:CI_Citation/cit:date">
                    <dde:resourceDate>
                        <xsl:apply-templates select="cit:CI_Date"/>
                    </dde:resourceDate>
                </xsl:for-each>
                <dde:abstract>
                    <xsl:value-of select="mdb:identificationInfo//mri:abstract/gco:CharacterString"
                    />
                </dde:abstract>

                <xsl:for-each select="//mri:descriptiveKeywords">
                    <xsl:if
                        test="string(mri:MD_Keywords/mri:thesaurusName//cit:title/gco:CharacterString) != 'DDE topic category extensions'">
                        <xsl:for-each select="mri:MD_Keywords/mri:keyword">
                            <dde:keyword>
                                <xsl:if test="child::*/@xlink:href">  <!-- only if keywords are gmx:Anchor -->
                                    <xsl:attribute name="uri" select="string(child::*/@xlink:href)"/>
                                </xsl:if>
                                <xsl:value-of select="string(child::*)"/>
                            </dde:keyword>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>

                <xsl:for-each
                    select="//mri:descriptiveKeywords/mri:MD_Keywords[mri:thesaurusName//cit:title/gco:CharacterString = 'DDE topic category extensions']">
                    <xsl:for-each select="mri:keyword">
                        <dde:topicCategory>
                            <xsl:value-of select="gco:CharacterString"/>
                        </dde:topicCategory>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="mdb:identificationInfo//mri:topicCategory">
                    <dde:topicCategory>
                        <xsl:value-of select="mri:MD_TopicCategoryCode"/>
                    </dde:topicCategory>
                </xsl:for-each>
                <xsl:if test="not(mdb:identificationInfo//mri:topicCategory)">
                     <!-- source doesn't have optional topicCategory -->
                    <dde:topicCategory>
                        <xsl:value-of select="string('missing')"/>
                    </dde:topicCategory>
                </xsl:if>

                <xsl:for-each select="mdb:metadataScope">
                    <xsl:if test="mdb:MD_MetadataScope/mdb:name">
                        <!-- is the name in the DDE resourceType codelist? -->
                        <xsl:variable name="rtype" select="mdb:MD_MetadataScope/child::mdb:name"/>
                        <xsl:variable name="clstval"
                            select="$resourceTypeMapping/entry[@key = $rtype]/@value"/>
                        <xsl:if test="$clstval">
                          <dde:resourceType> <!-- use child:: in case there are anchors -->
                              <xsl:value-of select="$rtype"/>
                          </dde:resourceType>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="mdb:MD_MetadataScope/mdb:resourceScope">
                        <dde:resourceType> <!-- use child:: in case there are anchors -->
                            <xsl:variable name="scode" select="mdb:MD_MetadataScope/mdb:resourceScope/mcc:MD_ScopeCode/@codeListValue"/>
                            <!-- have to capitalize string -->
                            <xsl:value-of select="concat(upper-case(substring($scode,1,1)), substring($scode, 2))"/>
                        </dde:resourceType>
                    </xsl:if>
                </xsl:for-each>

                <xsl:for-each
                    select="mdb:identificationInfo//mri:citation//cit:citedResponsibleParty">
                    <dde:resourceResponsibleParty>
                        <xsl:apply-templates select="cit:CI_Responsibility"/>
                    </dde:resourceResponsibleParty>
                </xsl:for-each>
                <xsl:for-each select="mdb:identificationInfo//mri:pointOfContact">
                    <dde:resourceResponsibleParty>
                        <xsl:apply-templates select="cit:CI_Responsibility"/>
                    </dde:resourceResponsibleParty>
                </xsl:for-each>

                <xsl:for-each select="mdb:identificationInfo//mri:graphicOverview">
                    <dde:browseGraphic>
                        <dde:title>
                            <xsl:value-of
                                select="mcc:MD_BrowseGraphic/mcc:fileName/gco:CharacterString"/>
                        </dde:title>
                        <dde:applicationProfile>
                            <xsl:value-of
                                select="mcc:MD_BrowseGraphic/mcc:fileType/gco:CharacterString"/>
                        </dde:applicationProfile>
                        <dde:description>
                            <xsl:value-of
                                select="mcc:MD_BrowseGraphic/mcc:fileDescription/gco:CharacterString"
                            />
                        </dde:description>
                        <dde:linkage>
                            <xsl:value-of
                                select="mcc:MD_BrowseGraphic/mcc:linkage//cit:linkage/gco:CharacterString"
                            />
                        </dde:linkage>
                        <dde:function>browseGraphic</dde:function>
                    </dde:browseGraphic>
                </xsl:for-each>

                <xsl:for-each select="mdb:identificationInfo//mri:supplementalInformation">
                    <dde:additionalDocumentation>
                        <xsl:value-of select="gco:CharacterString"/>
                    </dde:additionalDocumentation>
                </xsl:for-each>

                <dde:language>
                    <xsl:for-each select="//lan:LanguageCode/@codeListValue">
                        <xsl:value-of select="string(.)"/>
                        <xsl:if test="position() > 1">
                            <xsl:value-of select="string('; ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </dde:language>

                <dde:characterEncoding>
                    <xsl:for-each select="//lan:MD_CharacterSetCode/@codeListValue">
                        <xsl:value-of select="string(.)"/>
                        <xsl:if test="position() > 1">
                            <xsl:value-of select="string('; ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </dde:characterEncoding>

                <!-- not handling SecurityConstraints, or most of the other possible ISO19115-1 constraint properties -->
                <xsl:for-each select="mdb:identificationInfo//mri:resourceConstraints">
                    <dde:restriction>
                        <dde:restrictionText>
                            <!-- beware, there might be multiple mco:reference elements -->
                            <xsl:if test="mco:reference/@xlink:href">
                                <xsl:attribute name="uri" select=".//mco:reference/@xlink:href"/>
                            </xsl:if>
                            <xsl:call-template name="getText">
                                <!-- child could be MD_LegalConstraints, MD_Constraints, or MD_SecurityConstraints -->
                                <xsl:with-param name="theNode" select="child::*"/>
                            </xsl:call-template>
                        </dde:restrictionText>
                        <xsl:for-each select=".//mco:accessConstraints">
                            <dde:restrictionCode>
                                <xsl:value-of select="mco:MD_RestrictionCode/@codeListValue"/>
                            </dde:restrictionCode>
                        </xsl:for-each>
                        <xsl:for-each select=".//mco:useConstraints">
                            <dde:restrictionCode>
                                <xsl:value-of select="mco:MD_RestrictionCode/@codeListValue"/>
                            </dde:restrictionCode>
                        </xsl:for-each>
                    </dde:restriction>
                </xsl:for-each>

                <xsl:if test="
                        mdb:identificationInfo//mri:citation//cit:edition or
                        mdb:identificationInfo//mri:citation//cit:editionDate">
                    <dde:edition>
                        <xsl:choose>
                            <xsl:when
                                test="mdb:identificationInfo//mri:citation//cit:edition and mdb:identificationInfo//mri:citation//cit:editionDate">
                                <xsl:value-of select="
                                        concat(mdb:identificationInfo//mri:citation//cit:edition,
                                        string('; editionDate:'), mdb:identificationInfo//mri:citation//cit:editionDate)"
                                />
                            </xsl:when>
                            <xsl:when test="mdb:identificationInfo//mri:citation//cit:edition">
                                <xsl:value-of
                                    select="mdb:identificationInfo//mri:citation//cit:edition/gco:CharacterString"
                                />
                            </xsl:when>
                            <xsl:when test="mdb:identificationInfo//mri:citation//cit:editionDate">
                                <xsl:value-of
                                    select="concat('editionDate: ', mdb:identificationInfo//mri:citation//cit:editionDate/gco:DateTime)"
                                />
                            </xsl:when>
                        </xsl:choose>
                    </dde:edition>
                </xsl:if>

                <dde:dataQuality>
                    <xsl:for-each select="mdb:dataQualityInfo">
                        <xsl:call-template name="getText">
                            <xsl:with-param name="theNode" select="mdq:DQ_DataQuality"/>
                        </xsl:call-template>
                        <!--<xsl:for-each select="mdq:DQ_DataQuality/*">
                            <xsl:if test=".//gco:CharacterString">
                                <xsl:value-of select="local-name()"/>
                                <xsl:text>:</xsl:text>
                                <xsl:for-each select=".//gco:CharacterString">
                                    <xsl:value-of select="local-name(parent::*)"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:value-of select="string(.)"/>
                                    <xsl:text>; </xsl:text>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:for-each>-->

                    </xsl:for-each>

                </dde:dataQuality>

                <dde:lineage>
                    <xsl:for-each select="mdb:resourceLineage">
                        <xsl:call-template name="getText">
                            <xsl:with-param name="theNode" select="mrl:LI_Lineage"/>
                        </xsl:call-template>
                        <!--<xsl:for-each select="mrl:LI_Lineage/*">
                            <xsl:if test=".//gco:CharacterString or .//gcx:Anchor">
                                <xsl:value-of select="local-name()"/>
                                <xsl:text>:</xsl:text>
                                <xsl:for-each select=".//gco:CharacterString | .//gcx:Anchor">
                                    <xsl:value-of select="local-name(parent::*)"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:value-of select="string(.)"/>
                                    <xsl:text>; </xsl:text>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:for-each>-->
                    </xsl:for-each>
                    <!-- capture acquisition inforamtion above and beyond what is in operation/description, where the dde acquisition code get placed.. -->
                    <xsl:for-each select="mdb:acquisitionInformation">
                        <xsl:text>  AcquisitionInformation:</xsl:text>
                        <xsl:call-template name="getText">
                            <xsl:with-param name="theNode" select="mac:MI_AcquisitionInformation"/>
                        </xsl:call-template>
                        <!--
                        <xsl:for-each select="mac:MI_AcquisitionInformation/*">
                            <xsl:if test=".//gco:CharacterString or .//gcx:Anchor">
                                <xsl:value-of select="local-name()"/>
                                <xsl:text>:</xsl:text>
                                <xsl:for-each select=".//gco:CharacterString | .//gcx:Anchor">
                                    <xsl:value-of select="local-name(parent::*)"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:value-of select="string(.)"/>
                                    <xsl:text>; </xsl:text>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:for-each>-->
                    </xsl:for-each>
                </dde:lineage>

                <xsl:for-each select="mdb:resourceLineage//mrl:LI_Source">
                    <dde:source>
                        <xsl:if
                            test="mrl:sourceCitation//cit:identifier//mcc:code/gco:CharacterString">
                            <xsl:attribute name="uri"
                                select="mrl:sourceCitation//cit:identifier//mcc:code/gco:CharacterString"
                            />
                        </xsl:if>
                        <!-- dde:source is a free text field, so scrape the text from the CI_Citation -->
                        <xsl:call-template name="getText">
                            <xsl:with-param name="theNode"
                                select="mrl:sourceCitation/cit:CI_Citation"/>
                        </xsl:call-template>

                        <!--<xsl:for-each select="mrl:sourceCitation/cit:CI_Citation/*">
                            <xsl:if test=".//gco:CharacterString">
                                <xsl:value-of select="local-name()"/>
                                <xsl:text>:</xsl:text>
                                <xsl:for-each select=".//gco:CharacterString">
                                    <xsl:value-of select="local-name(parent::*)"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:value-of select="string(.)"/>
                                    <xsl:text>; </xsl:text>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:for-each>-->
                    </dde:source>
                </xsl:for-each>

                <xsl:for-each select="mdb:acquisitionInformation">
                    <dde:acquisitionType>
                        <xsl:choose>
                            <xsl:when test="mac:MI_AcquisitionInformation/mac:operation//mac:description">
                                <xsl:value-of  select="mac:MI_AcquisitionInformation/mac:operation//child::mac:description"  />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of  select="string('missing')"  />
                            </xsl:otherwise>
                        </xsl:choose>
                    </dde:acquisitionType>
                </xsl:for-each>

                <dde:geoTime>
                    <xsl:value-of
                        select="mdb:identificationInfo//gex:temporalElement//gml:TimePeriod/gml:description"/>
                    <xsl:if
                        test="not(mdb:identificationInfo//gex:temporalElement//gml:TimePeriod/gml:description)">
                        <xsl:value-of select="string('geoTime description not provided')"/>
                    </xsl:if>
                </dde:geoTime>

                <xsl:for-each select="mdb:identificationInfo//mri:extent">
                    <dde:geographicExtent>
                        <xsl:for-each select=".//gex:geographicIdentifier">
                            <dde:geographicIdentifier>
                                <xsl:apply-templates select="mcc:MD_Identifier"/>
                            </dde:geographicIdentifier>
                        </xsl:for-each>
                        <xsl:for-each select=".//gex:geographicElement/gex:EX_GeographicBoundingBox">
                            <!-- ISO19115-3 allows multiple bounding boxes in a single extent; DDE only allows one per extent -->
                            <xsl:if test="position() = 1">
                                <dde:westBoundLongitude>
                                    <xsl:value-of select="gex:westBoundLongitude"/>
                                </dde:westBoundLongitude>
                                <dde:eastBoundLongitude>
                                    <xsl:value-of select="gex:eastBoundLongitude"/>
                                </dde:eastBoundLongitude>
                                <dde:southBoundLatitude>
                                    <xsl:value-of select="gex:southBoundLatitude"/>
                                </dde:southBoundLatitude>
                                <dde:northBoundLatitude>
                                    <xsl:value-of select="gex:northBoundLatitude"/>
                                </dde:northBoundLatitude>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:if test=".//gex:verticalElement/@xlink:title">
                            <dde:elevation>
                                <xsl:value-of select=".//gex:verticalElement/@xlink:title"/>
                            </dde:elevation>
                        </xsl:if>
                    </dde:geographicExtent>
                </xsl:for-each>

                <xsl:for-each select="mdb:identificationInfo//mri:extent//gex:temporalElement">
                    <xsl:if
                        test="not(starts-with(gex:EX_TemporalExtent//gml:TimePeriod/gml:description, 'geoTime:'))">
                        <dde:temporalExtent>
                            <xsl:if
                                test="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:name">
                                <dde:beginName>
                                    <xsl:value-of
                                        select="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:name"
                                    />
                                </dde:beginName>
                            </xsl:if>
                            <xsl:if
                                test="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:identifier">
                                <dde:beginIdentifier>
                                    <dde:authority>
                                        <xsl:value-of
                                            select="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:identifier/@codeSpace"
                                        />
                                    </dde:authority>
                                    <dde:code>
                                        <xsl:value-of
                                            select="string(gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:identifier)"
                                        />
                                    </dde:code>
                                </dde:beginIdentifier>
                            </xsl:if>

                            <xsl:if
                                test="gex:EX_TemporalExtent//gml:TimePeriod/gml:end/gml:TimeInstant/gml:name">
                                <dde:endName>
                                    <xsl:value-of
                                        select="gex:EX_TemporalExtent//gml:TimePeriod/gml:end/gml:TimeInstant/gml:name"
                                    />
                                </dde:endName>
                            </xsl:if>
                            <xsl:if
                                test="gex:EX_TemporalExtent//gml:TimePeriod/gml:end/gml:TimeInstant/gml:identifier">
                                <dde:endIdentifier>
                                    <dde:authority>
                                        <xsl:value-of
                                            select="gex:EX_TemporalExtent//gml:TimePeriod/gml:end/gml:TimeInstant/gml:identifier/@codeSpace"
                                        />
                                    </dde:authority>
                                    <dde:code>
                                        <xsl:value-of
                                            select="string(gex:EX_TemporalExtent//gml:TimePeriod/gml:end/gml:TimeInstant/gml:identifier)"
                                        />
                                    </dde:code>
                                </dde:endIdentifier>
                            </xsl:if>
                            <xsl:if
                                test="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:timePosition">
                                <dde:beginCoordinate>
                                    <xsl:value-of
                                        select="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:timePosition"
                                    />
                                </dde:beginCoordinate>
                            </xsl:if>
                            <xsl:if
                                test="gex:EX_TemporalExtent//gml:TimePeriod/gml:end/gml:TimeInstant/gml:timePosition">
                                <dde:endCoordinate>
                                    <xsl:value-of
                                        select="gex:EX_TemporalExtent//gml:TimePeriod/gml:end/gml:TimeInstant/gml:timePosition"
                                    />
                                </dde:endCoordinate>
                            </xsl:if>
                            <xsl:if
                                test="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:timePosition">
                                <!-- assume coordinates use the same frame.  -->
                                <dde:coordinateUnits>
                                    <xsl:value-of
                                        select="gex:EX_TemporalExtent//gml:TimePeriod//gml:TimeInstant/gml:timePosition/@frame"
                                    />
                                </dde:coordinateUnits>
                            </xsl:if>
                        </dde:temporalExtent>
                    </xsl:if>
                </xsl:for-each>

                <xsl:for-each select="mdb:identificationInfo//mri:associatedResource">
                    <dde:associatedResource>
                        <xsl:apply-templates select="mri:MD_AssociatedResource//cit:CI_Citation"/>
                        <!--<dde:title>
                            <xsl:value-of select="mri:MD_AssociatedResource//cit:CI_Citation/cit:title/gco:CharacterString"/>
                            <xsl:if test="not(mri:MD_AssociatedResource//cit:CI_Citation/cit:title/gco:CharacterString)">
                                <xsl:value-of select="string('title not provided')"/>
                            </xsl:if>
                        </dde:title>
                        <xsl:if test="mri:MD_AssociatedResource//cit:CI_Citation/cit:onlineResource//cit:applicationProfile">
                          <dde:applicationProfile>
                              <xsl:value-of select="mri:MD_AssociatedResource//cit:CI_Citation/cit:onlineResource//cit:applicationProfile/gco:CharacterString"/>
                          </dde:applicationProfile>
                        </xsl:if>
                        <xsl:if test="mri:MD_AssociatedResource//cit:CI_Citation/cit:onlineResource//cit:description">
                            <dde:description>
                                <xsl:value-of select="mri:MD_AssociatedResource//cit:CI_Citation/cit:onlineResource//cit:description/gco:CharacterString"/>
                            </dde:description>
                        </xsl:if>
                        <!-\- linkage is mandatory -\->
                        <dde:linkage>
                            <xsl:value-of select="mri:MD_AssociatedResource//cit:CI_Citation/cit:onlineResource//cit:linkage/gco:CharacterString"/>
                        </dde:linkage>
                        <xsl:if test="mri:MD_AssociatedResource//cit:CI_Citation/cit:onlineResource//cit:function">
                          <dde:function>
                              <xsl:value-of select="mri:MD_AssociatedResource//cit:CI_Citation/cit:onlineResource//cit:function/cit:CI_OnLineFunctionCode/@codeListValue"/>
                          </dde:function>
                        </xsl:if>-->
                    </dde:associatedResource>
                </xsl:for-each>

                <xsl:for-each select="mdb:alternativeMetadataReference">
                    <dde:metadataReference>
                        <xsl:apply-templates select="cit:CI_Citation"/>
                        <!--<dde:title>
                            <xsl:value-of select="cit:CI_Citation/cit:title/gco:CharacterString"/>
                            <xsl:if test="not(cit:CI_Citation/cit:title/gco:CharacterString)">
                                <xsl:value-of select="string('title not provided')"/>
                            </xsl:if>
                        </dde:title>
                        <xsl:if test="cit:CI_Citation/cit:onlineResource//cit:applicationProfile">
                            <dde:applicationProfile>
                                <xsl:value-of select="cit:CI_Citation/cit:onlineResource//cit:applicationProfile/gco:CharacterString"/>
                            </dde:applicationProfile>
                        </xsl:if>
                        <xsl:if test="cit:CI_Citation/cit:onlineResource//cit:description">
                            <dde:description>
                                <xsl:value-of select="cit:CI_Citation/cit:onlineResource//cit:description/gco:CharacterString"/>
                            </dde:description>
                        </xsl:if>
                        <!-\- linkage is mandatory -\->
                        <dde:linkage>
                            <xsl:value-of select="cit:CI_Citation/cit:onlineResource//cit:linkage/gco:CharacterString"/>
                        </dde:linkage>
                        <xsl:if test="cit:CI_Citation/cit:onlineResource//cit:function">
                            <dde:function>
                                <xsl:value-of select="cit:CI_Citation/cit:onlineResource//cit:function/cit:CI_OnLineFunctionCode/@codeListValue"/>
                            </dde:function>
                        </xsl:if>-->
                    </dde:metadataReference>
                </xsl:for-each>

                <xsl:for-each select="mdb:identificationInfo/srv:SV_ServiceIdentification">
                    <dde:serviceIdentificationInfo>
                        <dde:serviceType>
                            <xsl:value-of select="string(.//child::srv:serviceType)"/>
                        </dde:serviceType>
                        <xsl:for-each select="srv:containsOperations">
                            <dde:containOperations>
                                <xsl:for-each select="srv:SV_OperationMetadata/*">
                                    <xsl:if test=".//gco:CharacterString">
                                        <xsl:value-of select="local-name()"/>
                                        <xsl:text>:</xsl:text>
                                        <xsl:for-each select=".//gco:CharacterString">
                                            <xsl:value-of select="local-name(parent::*)"/>
                                            <xsl:text>:</xsl:text>
                                            <xsl:value-of select="string(.)"/>
                                            <xsl:text>; </xsl:text>
                                        </xsl:for-each>
                                    </xsl:if>
                                </xsl:for-each>
                            </dde:containOperations>
                        </xsl:for-each>
                        <dde:accessProperties>
                            <xsl:for-each
                                select="srv:accessProperties/mrd:MD_StandardOrderProcess/*">
                                <xsl:if test=".//gco:CharacterString">
                                    <xsl:value-of select="local-name()"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:for-each select=".//gco:CharacterString">
                                        <xsl:value-of select="local-name(parent::*)"/>
                                        <xsl:text>:</xsl:text>
                                        <xsl:value-of select="string(.)"/>
                                        <xsl:text>; </xsl:text>
                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:for-each>
                        </dde:accessProperties>

                    </dde:serviceIdentificationInfo>
                </xsl:for-each>

                <!--serviceIdentificationInfo{0-1}
                    imageryInfo{0-1} -->
            </dde:identificationInfo>

            <xsl:for-each select="mdb:distributionInfo/mrd:MD_Distribution">
                <xsl:variable name="pos" select="position()"/>
                <dde:distributionInfo>
                    <xsl:for-each select=".//mrd:formatSpecificationCitation">
                        <dde:distributionFormat>
                            <xsl:value-of select="cit:CI_Citation/cit:title/gco:CharacterString"/>
                        </dde:distributionFormat>
                    </xsl:for-each>
                    <xsl:for-each select="mrd:transferOptions//cit:CI_OnlineResource">
                        <dde:onlineResource>
                            <xsl:apply-templates select="."/>
                        </dde:onlineResource>
                    </xsl:for-each>
                    <!-- ISO19115-3 doesn't bind spatial representation to distributions, so we're
                    putting all the spatial representation info in the first dde:distribution. This has
                    potential for information loss  -->

                    <xsl:if
                        test="(count(//mrs:MD_ReferenceSystem) + count(//mri:spatialRepresentationType) + count(//mri:MD_Resolution)) > 0">
                        <dde:spatialRepresentationInfo>
                            <!-- optional -->
                            <dde:spatialRepresentationType>
                                <xsl:value-of
                                    select="//mri:spatialRepresentationType[$pos]/mcc:MD_SpatialRepresentationTypeCode/@codeListValue"
                                />
                            </dde:spatialRepresentationType>
                            <!-- required, but only one per distribution -->
                            <dde:spatialResolution>
                                <xsl:choose>
                                    <xsl:when test="//mri:spatialResolution[$pos]//mri:denominator">
                                        <xsl:value-of
                                            select="concat('1:', string(//mri:spatialResolution[$pos]//mri:denominator/gco:Integer))"
                                        />
                                    </xsl:when>
                                    <xsl:when
                                        test="//mri:spatialResolution[$pos]//mri:levelOfDetail">
                                        <xsl:value-of
                                            select="string(//mri:spatialResolution[$pos]//mri:levelOfDetail/gco:CharacterString)"
                                        />
                                    </xsl:when>
                                </xsl:choose>
                            </dde:spatialResolution>
                            <dde:referenceSystemType>
                                <xsl:value-of
                                    select="//mdb:referenceSystemInfo[$pos]//mrs:referenceSystemType/mrs:MD_ReferenceSystemTypeCode/@codeListValue"
                                />
                            </dde:referenceSystemType>
                            <dde:referenceSystemIdentifier>
                                <xsl:apply-templates
                                    select="//mdb:referenceSystemInfo[$pos]//mrs:referenceSystemIdentifier/mcc:MD_Identifier"
                                />
                            </dde:referenceSystemIdentifier>
                            <!-- required -->
                        </dde:spatialRepresentationInfo>
                    </xsl:if>
                    <!-- test for some srs info -->

                    <xsl:for-each select="mrd:distributor">
                    <dde:distributionResponsibleParty>
                        <xsl:apply-templates select=".//cit:CI_Responsibility"/>
                    </dde:distributionResponsibleParty>
                    </xsl:for-each>

                </dde:distributionInfo>
            </xsl:for-each>
        </xsl:element>
        <!-- end of dde:MD_Metadata -->

    </xsl:template>

    <xsl:template match="cit:CI_Citation">
        <dde:title>
            <xsl:value-of select="cit:title/gco:CharacterString"/>
            <xsl:if test="not(cit:title/gco:CharacterString)">
                <xsl:value-of select="string('title not provided')"/>
            </xsl:if>
        </dde:title>
        <xsl:apply-templates select="cit:onlineResource/cit:CI_OnlineResource"/>
 
    </xsl:template>

    <xsl:template match="cit:CI_OnlineResource">
        <xsl:if test="cit:name">
            <dde:title>
                <xsl:value-of select="child::cit:name"/>
            </dde:title>
        </xsl:if>
        <xsl:if test="cit:applicationProfile">
            <dde:applicationProfile>
                <xsl:value-of select="child::cit:applicationProfile"/>
            </dde:applicationProfile>
        </xsl:if>
        <xsl:if test="cit:description">
            <dde:description>
                <xsl:value-of select="child::cit:description"/>
            </dde:description>
        </xsl:if>
        <!-- linkage is mandatory -->
        <dde:linkage>
            <xsl:value-of select="cit:linkage/gco:CharacterString"/>
        </dde:linkage>
        <xsl:if test="cit:function">
            <dde:function>
                <xsl:value-of select="cit:function/cit:CI_OnLineFunctionCode/@codeListValue"/>
            </dde:function>
        </xsl:if>

    </xsl:template>

    <xsl:template match="cit:CI_Responsibility">
        <dde:name>
            <xsl:if test="cit:party//cit:name">
                <xsl:value-of select="cit:party//cit:name/gco:CharacterString"/>
            </xsl:if>
            <xsl:if test="cit:party//cit:positionName">
                <xsl:value-of select="cit:party//cit:positionName/gco:CharacterString"/>
            </xsl:if>
        </dde:name>
        <dde:role>
            <xsl:value-of select="cit:role/cit:CI_RoleCode/@codeListValue"/>
        </dde:role>
        <xsl:for-each select="cit:party/cit:partyIdentifier">
            <dde:identifier>
                <xsl:apply-templates select="mcc:MD_Identifier"/>
            </dde:identifier>
        </xsl:for-each>
        <dde:country>
            <xsl:value-of select="cit:party//cit:contactInfo//cit:country//gco:CharacterString"/>
        </dde:country>
        <dde:electronicMailAddress>
            <xsl:value-of
                select="cit:party//cit:contactInfo//cit:electronicMailAddress//gco:CharacterString"
            />
        </dde:electronicMailAddress>
    </xsl:template>

    <xsl:template match="mcc:MD_Identifier">
        <dde:authority>
            <xsl:value-of select="mcc:authority/cit:CI_Citation/cit:title/gco:CharacterString"/>
        </dde:authority>
        <dde:code>
            <xsl:value-of select="mcc:code/gco:CharacterString"/>
        </dde:code>
        <dde:codeSpace>
            <xsl:value-of select="mcc:codeSpace/gco:CharacterString"/>
        </dde:codeSpace>
        <dde:version>
            <xsl:value-of select="mcc:version/gco:CharacterString"/>
        </dde:version>
        <dde:description>
            <xsl:value-of select="mcc:description/gco:CharacterString"/>
        </dde:description>
    </xsl:template>

    <xsl:template match="cit:CI_Date">
        <dde:date>
            <xsl:if test="cit:date/gco:DateTime">
                <xsl:value-of select="cit:date/gco:DateTime"/>
            </xsl:if>
            <xsl:if test="cit:date/gco:Date">
                <xsl:value-of select="cit:date/gco:Date"/>
            </xsl:if>
        </dde:date>
        <dde:dateType>
            <xsl:value-of select="cit:dateType/cit:CI_DateTypeCode/@codeListValue"/>
        </dde:dateType>
    </xsl:template>

    <xsl:template name="getText">
        <xsl:param name="theNode"/>
        <xsl:for-each select="$theNode/*">
            <xsl:if test=".//gco:CharacterString or .//gcx:Anchor">
                <xsl:value-of select="local-name()"/>
                <xsl:text>:</xsl:text>
                <xsl:for-each select=".//gco:CharacterString | .//gcx:Anchor">
                    <xsl:value-of select="local-name(parent::*)"/>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="string(.)"/>
                    <xsl:text>; </xsl:text>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
