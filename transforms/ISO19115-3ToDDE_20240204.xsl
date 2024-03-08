<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gcoold="http://www.isotc211.org/2005/gco" xmlns:gfcold="http://www.isotc211.org/2005/gfc"
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
    xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:dde="https://www.ddeworld.org/resource/standards/dde/ds01/metadata/1.0"
    exclude-result-prefixes="#all">


    <!--    <xsl:import href="utility/create19115-3Namespaces.xsl"/>-->
    <xsl:import href="utility/DDEutilities.xsl"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="DDE-specID" select="'DDE S01-2023: Geosciences Information Metadata'"/>
    <xsl:variable name="ISOcodeListLocation"
        select="'https://standards.iso.org/iso/19115/resources/Codelists/cat/codelists.xml'"/>
    <xsl:variable name="DDEcodeListLocation" select="'https://www.ddeworld.org/resource/codelist/'"/>
    <!-- this is interim until we get a firm web location for DDE codelists -->

    <xsl:template match="mdb:MD_Metadata">
        <xsl:element name="dde:MD_Metadata"
            xmlns="https://www.ddeworld.org/resource/standards/dde/ds01/metadata/1.0">

            <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
            <xsl:attribute name="xsi:schemaLocation"
                select="string('https://www.ddeworld.org/resource/standards/dde/ds01/metadata/1.0 DDEMetadataXSD_20240103.xsd')"/>

            <dde:metadataIdentifier>
                <xsl:apply-templates select="mdb:metadataIdentifier/mcc:MD_Identifier"/>
            </dde:metadataIdentifier>
            <dde:metadataStandardName>
                <xsl:value-of select="$DDE-specID"/>
            </dde:metadataStandardName>
            <xsl:for-each select="mdb:contact">
                <dde:metadataResponsibleParty>
                    <xsl:apply-templates select="cit:CI_Responsibility"/>
                </dde:metadataResponsibleParty>
            </xsl:for-each>

            <xsl:for-each select="mdb:dateInfo[count(@gco:nilReason)=0]">
                <dde:metadataDate>
                    <xsl:apply-templates select="cit:CI_Date"/>
                </dde:metadataDate>
            </xsl:for-each>
            <xsl:if test="count(mdb:dateInfo)=0">
                <dde:metadataDate>
                    
                </dde:metadataDate>
            </xsl:if>
            <dde:metadataDate>
                <dde:date>
                    <xsl:value-of  select="current-dateTime()"/>
                </dde:date>
                <dde:dateType>unavailable</dde:dateType>
            </dde:metadataDate>
            
            <dde:identificationInfo>
                <dde:resourceIdentifier>
                    <!-- ISO19115-3 allows multiple identifiers; for now we just take the first -->
                    <xsl:choose>
                        <xsl:when
                            test="mdb:identificationInfo//mri:citation//cit:identifier[1]/mcc:MD_Identifier">
                            <xsl:apply-templates
                                select="mdb:identificationInfo//mri:citation//cit:identifier[1]/mcc:MD_Identifier"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <dde:code>MISSING</dde:code>
                            <dde:description>ERROR. A resource identifier is
                                required</dde:description>
                        </xsl:otherwise>
                    </xsl:choose>
                </dde:resourceIdentifier>

                <dde:title>
                    <xsl:choose>
                        <xsl:when
                            test="mdb:identificationInfo//mri:citation//cit:title/gco:CharacterString">
                            <xsl:value-of
                                select="mdb:identificationInfo//mri:citation//cit:title/gco:CharacterString"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="string('ERROR, resource must have a title at least 20 characters long')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
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
                    <xsl:choose>
                        <xsl:when test="mdb:identificationInfo//mri:abstract/gco:CharacterString">
                            <xsl:value-of
                                select="mdb:identificationInfo//mri:abstract/gco:CharacterString"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="string('ERROR, resource must have an abstract at least 250 characters long')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- put additional identifiers here so they aren't lost -->
                    <xsl:if
                        test="count(mdb:identificationInfo//mri:citation//cit:identifier/mcc:MD_Identifier) > 1">
                        <xsl:value-of select="string('  Alternate Identifiers: ')"/>
                        <xsl:for-each
                            select="mdb:identificationInfo//mri:citation//cit:identifier/mcc:MD_Identifier">
                            <xsl:if test="position() > 1">
                                <xsl:call-template name="getText">
                                    <xsl:with-param name="theNode" select="."/>
                                </xsl:call-template>
                                <xsl:if test="position() > 2">
                                    <xsl:value-of select="string('. ')"/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                    <!-- put in all the details about imagery. Instrument and platform names, and processing level will be in the dde
                        imagery section as well-->
                    <xsl:for-each select="mdb:contentInfo/mrc:MI_ImageDescription | mdb:contentInfo/mrc:MD_ImageDescription">
                        <xsl:call-template name="getText">
                            <xsl:with-param name="theNode" select="."/>
                        </xsl:call-template>
                        <xsl:if test="position() > 1">
                            <xsl:value-of select="string('. ')"/>
                        </xsl:if>
                    </xsl:for-each>

                </dde:abstract>

                <xsl:for-each select="//mri:descriptiveKeywords">
                    <xsl:if
                        test="string(mri:MD_Keywords/mri:thesaurusName//cit:title/gco:CharacterString) != 'DDE topic category extensions'">
                        <xsl:for-each select="mri:MD_Keywords/mri:keyword">
                            <dde:keyword>
                                <xsl:if test="child::*/@xlink:href">
                                    <!-- only if keywords are gmx:Anchor -->
                                    <xsl:attribute name="href" select="string(child::*/@xlink:href)"
                                    />
                                </xsl:if>
                                <xsl:value-of select="string(child::*)"/>
                            </dde:keyword>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
                <!-- schema requires min 3 keywords -->
                <xsl:if test="count(//mri:keyword) &lt; 3">
                    <xsl:variable name="kcount" select="count(//mri:keyword)"/>
                   <xsl:choose>
                       <xsl:when test="$kcount=1">
                           <dde:keyword nilReason="missing"/>
                           <dde:keyword nilReason="missing"/>
                       </xsl:when>
                       <xsl:when test="$kcount=2">
                           <dde:keyword nilReason="missing"/>
                       </xsl:when>
                       <xsl:otherwise>
                           <dde:keyword nilReason="missing"/>
                           <dde:keyword nilReason="missing"/>
                           <dde:keyword nilReason="missing"/>
                       </xsl:otherwise>
                   </xsl:choose>
                </xsl:if>
                

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
                    <!-- source doesn't have optional topicCategory so use sentinel value-->
                    <dde:topicCategory>
                        <xsl:value-of select="string('other:missing')"/>
                    </dde:topicCategory>
                </xsl:if>

                <xsl:for-each select="mdb:metadataScope">
                    <xsl:if test="mdb:MD_MetadataScope/mdb:name">
                        <!-- is the name in the DDE resourceType codelist? -->
                        <xsl:variable name="rtype" select="mdb:MD_MetadataScope/child::mdb:name"/>
                        <xsl:variable name="clstval"
                            select="$resourceTypeMapping/entry[@key = $rtype]/@value"/>
                        <xsl:if test="$clstval">
                            <dde:resourceType>
                                <!-- use child:: in case there are anchors -->
                                <xsl:value-of select="$rtype"/>
                            </dde:resourceType>
                        </xsl:if>
                    </xsl:if>
                    <xsl:if test="mdb:MD_MetadataScope/mdb:resourceScope">
                        <dde:resourceType>
                            <xsl:value-of
                                select="mdb:MD_MetadataScope/mdb:resourceScope/mcc:MD_ScopeCode/@codeListValue"/>
                            <!-- have to capitalize string -->
                            <!--<xsl:value-of
                                select="concat(upper-case(substring($scode, 1, 1)), substring($scode, 2))" />-->
                        </dde:resourceType>
                    </xsl:if>
                </xsl:for-each>

                <xsl:if test="count(mdb:metadataScope) = 0">
                    <dde:resourceType>
                        <xsl:value-of select="string('ERROR-No resource type')"/>
                    </dde:resourceType>
                </xsl:if>

                <xsl:if
                    test="(count(//mri:supplementalInformation) + count(//mrd:MD_StandardOrderProcess) + count(//mri:credit) + count(//mri:resourceMaintenance) + count(//mri:resourceSpecificUsage) + count(//mri:environmentDescription) + count(mdb:contentInfo//mrc:attributeDescription)) > 0">
                    <dde:additionalDocumentation>
                        <xsl:for-each select="mdb:identificationInfo//mri:supplementalInformation">
                            <xsl:value-of select="gco:CharacterString"/>
                            <xsl:value-of select="string('. ')"/>
                        </xsl:for-each>
                        <xsl:for-each select="mdb:distributionInfo//mrd:MD_StandardOrderProcess">
                            <xsl:call-template name="getText">
                                <xsl:with-param name="theNode" select="."/>
                            </xsl:call-template>
                            <xsl:value-of select="string('. ')"/>
                        </xsl:for-each>
                        <xsl:for-each select="mdb:identificationInfo//mri:credit">
                            <xsl:call-template name="getText">
                                <xsl:with-param name="theNode" select="."/>
                            </xsl:call-template>
                            <xsl:value-of select="string('. ')"/>
                        </xsl:for-each>
                        <xsl:for-each select="mdb:identificationInfo//mri:resourceMaintenance">
                            <xsl:call-template name="getText">
                                <xsl:with-param name="theNode" select="."/>
                            </xsl:call-template>
                            <xsl:value-of select="string('. ')"/>
                        </xsl:for-each>
                        <xsl:for-each select="mdb:identificationInfo//mri:resourceSpecificUsage">
                            <xsl:call-template name="getText">
                                <xsl:with-param name="theNode" select="."/>
                            </xsl:call-template>
                            <xsl:value-of select="string('. ')"/>
                        </xsl:for-each>
                        <xsl:for-each select="mdb:identificationInfo//mri:environmentDescription">
                            <xsl:call-template name="getText">
                                <xsl:with-param name="theNode" select="."/>
                            </xsl:call-template>
                            <xsl:value-of select="string('. ')"/>
                        </xsl:for-each>
                        <xsl:for-each select="mdb:contentInfo//mrc:attributeDescription">
                            <xsl:call-template name="getText">
                                <xsl:with-param name="theNode" select="child::*"/>
                            </xsl:call-template>
                            <xsl:value-of select="string('. ')"/>
                        </xsl:for-each>
                    </dde:additionalDocumentation>
                </xsl:if>

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
                            <xsl:choose>
                                <xsl:when
                                    test="starts-with(mcc:MD_BrowseGraphic/mcc:fileName/gco:CharacterString, 'http')">
                                    <xsl:value-of select="string('Browse graphic')"/>
                                </xsl:when>
                                <xsl:when
                                    test="mcc:MD_BrowseGraphic/mcc:fileName/gco:CharacterString">
                                    <xsl:value-of
                                        select="mcc:MD_BrowseGraphic/mcc:fileName/gco:CharacterString"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="string('Browse graphic')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </dde:title>
                        <xsl:if test="mcc:MD_BrowseGraphic/mcc:fileType/child::*">
                            <dde:applicationProfile>
                                <xsl:value-of
                                    select="string(mcc:MD_BrowseGraphic/mcc:fileType/child::*)"/>
                            </dde:applicationProfile>
                        </xsl:if>
                        <xsl:if test="mcc:MD_BrowseGraphic/mcc:fileDescription/child::*">
                            <dde:description>
                                <xsl:value-of
                                    select="string(mcc:MD_BrowseGraphic/mcc:fileDescription/child::*)"
                                />
                            </dde:description>
                        </xsl:if>

                        <dde:linkage>
                            <xsl:choose>
                                <xsl:when
                                    test="mcc:MD_BrowseGraphic/mcc:linkage//cit:linkage/gco:CharacterString">
                                    <xsl:value-of
                                        select="mcc:MD_BrowseGraphic/mcc:linkage//cit:linkage/gco:CharacterString"
                                    />
                                </xsl:when>
                                <xsl:when
                                    test="starts-with(mcc:MD_BrowseGraphic/mcc:fileName/gco:CharacterString, 'http')">
                                    <xsl:value-of
                                        select="mcc:MD_BrowseGraphic/mcc:fileName/gco:CharacterString"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="nilReason" select="string('missing')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </dde:linkage>
                        <dde:function>browseGraphic</dde:function>
                    </dde:browseGraphic>
                </xsl:for-each>

                <xsl:for-each select="mdb:identificationInfo//lan:LanguageCode/@codeListValue">
                    <dde:language>
                        <xsl:value-of select="substring(string(.), 1, 3)"/>
                    </dde:language>
                </xsl:for-each>
                <!-- language is mandatory, if source doesn't have it insert two hyphen ('-') characters  (for "undetermined") the language cannot be identified. https://en.wikipedia.org/wiki/ISO_639-2
               -->
                <xsl:if test="count(mdb:identificationInfo//lan:LanguageCode/@codeListValue) = 0">
                    <dde:language>
                        <xsl:value-of select="string('--')"/>
                    </dde:language>
                </xsl:if>

                <xsl:for-each
                    select="mdb:identificationInfo//lan:MD_CharacterSetCode/@codeListValue">
                    <dde:characterEncoding>
                        <xsl:variable name="cscode" select="string(.)"/>
                        <xsl:variable name="cccscode"
                            select="$codeCorrectionMapping/entry[@key = $cscode]/@value"/>
                        <xsl:choose>
                            <xsl:when test="$cccscode">
                                <xsl:value-of select="$cccscode"/>
                            </xsl:when>
                            <xsl:when
                                test='$cscode = ("US-ASCII", "ISO-8859-1", "Shift_JIS", "EUC-JP", "EUC-KR", "UTF-8", "GB18030", "Big5", "windows-1251")'>
                                <xsl:value-of select="$cscode"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(string('other:'), $cscode)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dde:characterEncoding>
                </xsl:for-each>
                <xsl:if
                    test="count(mdb:identificationInfo//lan:MD_CharacterSetCode/@codeListValue) = 0">
                    <dde:characterEncoding>
                        <xsl:value-of select="string('other:missing')"/>
                    </dde:characterEncoding>
                </xsl:if>

                <!-- not handling SecurityConstraints, or most of the other possible ISO19115-1 constraint properties -->
                <xsl:for-each select="mdb:identificationInfo//mri:resourceConstraints">
                    <dde:restriction>
                        <dde:restrictionText>
                            <!-- beware, there might be multiple mco:reference elements -->
                            <xsl:if test="mco:reference/@xlink:href">
                                <xsl:attribute name="href" select=".//mco:reference/@xlink:href"/>
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
                        <xsl:if
                            test="(count(.//mco:useConstraints) + count(.//mco:accessConstraints)) = 0">
                            <dde:restrictionCode>
                                <xsl:value-of select="string('unrestricted')"/>
                            </dde:restrictionCode>
                        </xsl:if>
                    </dde:restriction>
                </xsl:for-each>
                <xsl:if test="count(mdb:identificationInfo//mri:resourceConstraints)=0">
                    <dde:restriction>
                        <dde:restrictionCode>other:missing</dde:restrictionCode>
                    </dde:restriction>
                </xsl:if>

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


                    <xsl:for-each select="mdb:acquisitionInformation/mac:MI_AcquisitionInformation">
                        <xsl:choose>
                            <xsl:when
                                test="mdb:contentInfo/mrc:MD_CoverageDescription | mdb:contentInfo/mrc:MD_ImageDescription">
                                <!-- have imagery data; capture acquisition information about instrument, platform in imagery metadata  
                                   rest gets put here as text in lineage-->
                                <xsl:text>  Image or coverage acquisition information:</xsl:text>
                                
                                <xsl:for-each select="./mac:operation">
                                    <xsl:call-template name="getText">
                                        <xsl:with-param name="theNode" select="child::*"/>
                                    </xsl:call-template>
                                </xsl:for-each>
                                <xsl:for-each select="./mac:acquisitionPlan">
                                    <xsl:call-template name="getText">
                                        <xsl:with-param name="theNode" select="child::*"/>
                                    </xsl:call-template>
                                </xsl:for-each>
                                <xsl:for-each select="./mac:objective">
                                    <xsl:call-template name="getText">
                                        <xsl:with-param name="theNode" select="child::*"/>
                                    </xsl:call-template>
                                </xsl:for-each>
                                <xsl:for-each select="./mac:acquisitionRequirement">
                                    <xsl:call-template name="getText">
                                        <xsl:with-param name="theNode" select="child::*"/>
                                    </xsl:call-template>
                                </xsl:for-each>
                                <xsl:for-each select="./mac:environmentalConditions">
                                    <xsl:call-template name="getText">
                                        <xsl:with-param name="theNode" select="child::*"/>
                                    </xsl:call-template>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- not imagery, put all acquisition information here -->
                                <xsl:value-of select="string('Data acquisition information: ')"/>
                                <xsl:call-template name="getText">
                                    <xsl:with-param name="theNode" select="child::*"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <!-- acquisition information -->
                </dde:lineage>

                <xsl:for-each select="mdb:resourceLineage//mrl:LI_Source">
                    <dde:source>
                        <xsl:if
                            test="mrl:sourceCitation//cit:identifier//mcc:code/gco:CharacterString">
                            <xsl:attribute name="href"
                                select="mrl:sourceCitation//cit:identifier//mcc:code/gco:CharacterString"
                            />
                        </xsl:if>
                        <!-- dde:source is a free text field, so scrape the text from the CI_Citation -->
                        <xsl:call-template name="getText">
                            <xsl:with-param name="theNode"
                                select="mrl:sourceCitation/cit:CI_Citation"/>
                        </xsl:call-template>
                    </dde:source>
                </xsl:for-each>

                <!-- acquisitionType is a codelist, no way to automate guessing the correct code from the ISO metadata.
                    But when DDE is converted to ISO, acquisition type goes into 
                    //mdb:acquisitionInformation/mac:MI_AcquisitionInformation/mac:operation/mac:MI_Operation/mac:description/gco:CharacterString
                    so check to see if the content there is a value from the dde 
                The text in the mdb:acquisitionInformation element gets put in the lineage descdription
                in the DDE metadata as well-->
                <xsl:for-each select="mdb:acquisitionInformation//mac:MI_Operation">
                    <xsl:variable name="aqtype" select="string(.//child::mac:description)"/>
                    <xsl:variable name="aqval"
                        select="$acquisitionCodeCheck/entry[@key = $aqtype]/@value"/>
                    <dde:acquisitionType>
                        <xsl:choose>
                            <xsl:when test="$aqval = 'true'">
                                <xsl:value-of select="$aqtype"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="string('other:missing')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dde:acquisitionType>
                </xsl:for-each>

                <dde:geoTime>
                    <xsl:choose>
                        <xsl:when test="//gex:temporalElement//gml:TimePeriod/gml:description">
                            <xsl:variable name="gtime"
                                select="mdb:identificationInfo//gex:temporalElement//gml:TimePeriod/gml:description"/>
                            <xsl:choose>
                                <xsl:when test="starts-with($gtime, 'geoTime:')">
                                    <xsl:value-of select="substring-after($gtime, 'geoTime:')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$gtime"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="string('geoTime description not provided')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </dde:geoTime>

                <xsl:for-each select="mdb:identificationInfo//mri:extent">
                    <dde:geographicExtent>
                        <dde:verbatimCoordinateLocation>
                            <xsl:choose>
                                <xsl:when test=".//gex:description">
                                    <xsl:value-of select=".//gex:description/gco:CharacterString"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="nilReason" select="string('missing')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </dde:verbatimCoordinateLocation>

                        <xsl:for-each select=".//gex:geographicIdentifier">
                            <dde:geographicIdentifier>
                                <xsl:apply-templates select="mcc:MD_Identifier"/>
                            </dde:geographicIdentifier>
                        </xsl:for-each>
                        <xsl:if test=".//gex:verticalElement/@xlink:title">
                            <dde:elevation>
                                <xsl:value-of select=".//gex:verticalElement/@xlink:title"/>
                            </dde:elevation>
                        </xsl:if>
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

                    </dde:geographicExtent>
                </xsl:for-each>

                <xsl:for-each select="mdb:identificationInfo//mri:extent//gex:temporalElement">
                    <xsl:if
                        test="not(starts-with(gex:EX_TemporalExtent//gml:TimePeriod/gml:description, 'geoTime:'))">
                        <dde:temporalExtent>
                            <dde:beginName>
                                <!-- this one is required -->
                                <xsl:choose>
                                    <xsl:when
                                        test="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:name">
                                        <xsl:value-of
                                            select="gex:EX_TemporalExtent//gml:TimePeriod/gml:begin/gml:TimeInstant/gml:name"
                                        />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="nilReason" select="string('missing')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </dde:beginName>
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

                            <xsl:if test="gex:EX_TemporalExtent//gml:TimePeriod/gml:beginPosition">
                                <dde:beginDate>
                                    <xsl:value-of
                                        select="gex:EX_TemporalExtent//gml:TimePeriod/gml:beginPosition"
                                    />
                                </dde:beginDate>
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
                            <xsl:if test="gex:EX_TemporalExtent//gml:TimePeriod/gml:endPosition">
                                <dde:endDate>
                                    <xsl:value-of
                                        select="gex:EX_TemporalExtent//gml:TimePeriod/gml:endPosition"
                                    />
                                </dde:endDate>
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
                    <xsl:if test="mri:MD_AssociatedResource//cit:CI_Citation">
                        <!-- skip if there isn't a name/CI_Citation or metadataReference/CI_Citation -->
                        <dde:associatedResource>
                            <dde:resourceCitation>
                                <xsl:choose>
                                    <xsl:when
                                        test="mri:MD_AssociatedResource/mri:metadataReference/cit:CI_Citation">
                                        <xsl:apply-templates
                                            select="mri:MD_AssociatedResource/mri:metadataReference/cit:CI_Citation"
                                        />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates
                                            select="mri:MD_AssociatedResource/mri:name/cit:CI_Citation"
                                        />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </dde:resourceCitation>
                            <xsl:for-each
                                select="./mri:MD_AssociatedResource//mri:DS_AssociationTypeCode">
                                <dde:relation>
                                    <xsl:value-of select="@codeListValue"/>
                                </dde:relation>
                            </xsl:for-each>
                            <xsl:for-each
                                select="./mri:MD_AssociatedResource//mri:DS_InitiativeTypeCode">
                                <dde:relation>
                                    <xsl:value-of select="@codeListValue"/>
                                </dde:relation>
                            </xsl:for-each>
                        </dde:associatedResource>
                    </xsl:if>
                </xsl:for-each>

                <xsl:for-each select="mdb:alternativeMetadataReference">
                    <dde:metadataReference>
                        <xsl:apply-templates select="cit:CI_Citation"/>
                    </dde:metadataReference>
                </xsl:for-each>

                <xsl:for-each select="mdb:distributionInfo/mrd:MD_Distribution">
                    <!-- ISO19115-3 doesn't bind spatial representation to distributions, so we're
                    putting all the spatial representation info in the first dde:distribution. This has
                    potential for information loss  -->
                    <xsl:variable name="pos" select="position()"/>
                    <!-- first deal with implementations that put the transfer options and format inside the distributor -->
                    <xsl:for-each
                        select="mrd:distributor[count(mrd:MD_Distributor/mrd:distributorTransferOptions) > 0]">
                        <dde:distributionInfo>
                            <xsl:for-each select=".//mrd:formatSpecificationCitation">
                                <dde:distributionFormat>
                                    <xsl:value-of
                                        select="cit:CI_Citation/cit:title/gco:CharacterString"/>
                                </dde:distributionFormat>
                            </xsl:for-each>
                            <xsl:for-each
                                select=".//mrd:distributorTransferOptions//cit:CI_OnlineResource">
                                <dde:onlineResource>
                                    <xsl:apply-templates select="."/>
                                </dde:onlineResource>
                            </xsl:for-each>
                            <xsl:for-each
                                select=".//mrd:distributorContact | .//mrd:distributorFormat//mrd:distributorContact">
                                <dde:distributionResponsibleParty>
                                    <xsl:apply-templates select=".//cit:CI_Responsibility"/>
                                </dde:distributionResponsibleParty>
                            </xsl:for-each>
                            <xsl:call-template name="spatialRep">
                                <xsl:with-param name="pos" select="$pos"/>
                            </xsl:call-template>
                        </dde:distributionInfo>
                    </xsl:for-each>

                    <xsl:if
                        test="count(mrd:distributionFormat) + count(mrd:transferOptions) + count(mrd:distributor[count(mrd:MD_Distributor/mrd:distributorTransferOptions) = 0]) > 0">
                        <dde:distributionInfo>
                            <xsl:for-each select="mrd:distributionFormat//mrd:formatSpecificationCitation">
                                <dde:distributionFormat>
                                    <xsl:value-of
                                        select="cit:CI_Citation/cit:title/gco:CharacterString"/>
                                </dde:distributionFormat>
                            </xsl:for-each>
                            <xsl:for-each select="mrd:transferOptions//cit:CI_OnlineResource">
                                <dde:onlineResource>
                                    <xsl:apply-templates select="."/>
                                </dde:onlineResource>
                            </xsl:for-each>
                            <xsl:for-each select="mrd:distributor[count(mrd:MD_Distributor/mrd:distributorTransferOptions) = 0]">
                                <dde:distributionResponsibleParty>
                                    <xsl:apply-templates select=".//cit:CI_Responsibility"/>
                                </dde:distributionResponsibleParty>
                            </xsl:for-each>
                            <xsl:if test="count(mrd:distributor[count(mrd:MD_Distributor/mrd:distributorTransferOptions) = 0]) = 0">
                                <!-- spatial representation gets put in here -->
                                <xsl:call-template name="spatialRep">
                                    <xsl:with-param name="pos" select="$pos"/>
                                </xsl:call-template>
                            </xsl:if>

                        </dde:distributionInfo>
                    </xsl:if>
                </xsl:for-each>
<!-- use local-name here to avoid problems with srv2.0 vs. srv2.1.  Geonetwork uses srv2.1, 
                but there is not official ISO interchange schema using srv2.1, mds2.0 uses srv2.0. -->
                <xsl:for-each select="mdb:identificationInfo/*[local-name(.)='SV_ServiceIdentification']">
                    <dde:serviceIdentificationInfo>
                        <xsl:variable name="stype" select="string(.//child::*[local-name(.)='serviceType'])"/>
                        <xsl:variable name="stval"
                            select="$serviceTypeCheck/entry[@key = $stype]/@value"/>
                        <dde:serviceType>
                            <xsl:choose>
                                <xsl:when test="$stval = 'true'">
                                    <xsl:value-of select="$stype"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('other:', $stype)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </dde:serviceType>

                        <xsl:for-each select="*[local-name(.)='containsOperations']">
                            <dde:containOperations>
                                <xsl:for-each select="*[local-name(.)='SV_OperationMetadata']/*">
                                    <xsl:if test=".//gco:CharacterString">
                                        <xsl:value-of select="local-name()"/>
                                        <xsl:text>:</xsl:text>
                                        <xsl:for-each select=".//gco:CharacterString">
                                            <!--  <xsl:value-of select="local-name(parent::*)"/>
                                            <xsl:text>:</xsl:text>-->
                                            <xsl:value-of select="string(.)"/>
                                            <xsl:text>; </xsl:text>
                                        </xsl:for-each>
                                    </xsl:if>
                                </xsl:for-each>
                            </dde:containOperations>
                        </xsl:for-each>
                        <dde:accessProperties>
                            <xsl:for-each
                                select="*[local-name(.)='accessProperties']/mrd:MD_StandardOrderProcess/*">
                                <xsl:if test=".//gco:CharacterString">
                                    <xsl:value-of select="local-name()"/>
                                    <xsl:text>:</xsl:text>
                                    <xsl:for-each select=".//gco:CharacterString">
                                        <!--<xsl:value-of select="local-name(parent::*)"/>
                                        <xsl:text>:</xsl:text>-->
                                        <xsl:value-of select="string(.)"/>
                                        <xsl:text>; </xsl:text>
                                    </xsl:for-each>
                                </xsl:if>
                            </xsl:for-each>
                        </dde:accessProperties>

                    </dde:serviceIdentificationInfo>
                </xsl:for-each>

                <!-- handle imagery info  imageryInfo{0-1} 
                 assume if there is a coverage description or image description, the resource can be considered imagery-->
                <xsl:if
                    test="mdb:contentInfo/mrc:MD_CoverageDescription | mdb:contentInfo/mrc:MD_ImageDescription">
                    <dde:imageryInfo>
                        <!-- instrument and sensor descriptions, other acquisition information is in lineage statement -->
                        <xsl:for-each
                            select="mdb:acquisitionInformation/mac:MI_AcquisitionInformation">
                            <!-- sensor or instrument; other acquisition information goes in lineage -->
                            <xsl:for-each select=".//mac:MI_Instrument | .//mac:MI_Sensor">
                                <dde:sensor>
                                    <xsl:if test="position()>1">
                                        <xsl:value-of select="string('.  ')"/>
                                    </xsl:if>
                                    <xsl:choose>
                                       <xsl:when test="local-name(.)='MI_Instrument'">
                                           <xsl:value-of select="string('Instrument: ')"/>
                                       </xsl:when>
                                        <xsl:when test="local-name(.)='MI_Instrument'">
                                            <xsl:value-of select="string('Sensor: ')"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:call-template name="getText">
                                        <xsl:with-param name="theNode" select="child::*"/>
                                    </xsl:call-template>
                                </dde:sensor>
                            </xsl:for-each>
                            <xsl:for-each select=".//mac:MI_Platform">
                                <xsl:if test="position()>1">
                                    <xsl:value-of select="string('.  ')"/>
                                </xsl:if>
                                <xsl:value-of select="string('Platform: ')"/>
                                <dde:platform>
                                    <xsl:call-template name="getText">
                                        <xsl:with-param name="theNode" select="child::*"/>
                                    </xsl:call-template>
                                </dde:platform>
                            </xsl:for-each>
                            <!-- <dde:equipment> </dde:equipment>  can't distinguish instrument, sensor, platform, and equipment...-->
                        </xsl:for-each>

                        <!-- imaging informating in dde:equipement Change and put the Image description 
                            attributeDescription in supplemental information-->
                       <!-- <xsl:for-each select="mdb:contentInfo/mrc:MD_ImageDescription">
                            <dde:equipment>
                                <!-\- put imageing conditions here -\->
                                <xsl:call-template name="getText">
                                    <xsl:with-param name="theNode" select="child::*"/>
                                </xsl:call-template>
                            </dde:equipment>
                        </xsl:for-each>-->

                        <!--<dde:signalGenerator> </dde:signalGenerator>  can't find any reasonable mapping-->

                        <!-- wavelength (band) information -->
                        <xsl:for-each
                            select="mdb:contentInfo/mrc:MD_ImageDescription/mrc:attributeGroup/mrc:MD_AttributeGroup/mrc:attribute/mrc:MD_Band">
                            <dde:wavelength>
                                <xsl:call-template name="getText">
                                    <xsl:with-param name="theNode" select="child::*"/>
                                </xsl:call-template>
                            </dde:wavelength>
                        </xsl:for-each>

                        <!-- processing level -->
                        <xsl:variable name="processLevel">
                            <xsl:choose>
                                <!-- prefer the value in contentInfo -->
                                <xsl:when
                                    test="//mrc:processingLevelCode//mcc:code/gco:CharacterString">
                                    <xsl:value-of
                                        select="//mrc:processingLevelCode//mcc:code/gco:CharacterString"
                                    />
                                </xsl:when>
                                <!-- take the value in identificationInfo if there isn't a contentInfo value -->
                                <xsl:when test="//mri:processingLevel//mcc:code/gco:CharacterString">
                                    <xsl:value-of
                                        select="//mri:processingLevel//mcc:code/gco:CharacterString"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="string('missing')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when
                                test="substring($processLevel, 1, 5) = 'Level' or substring($processLevel, 1, 6) = 'other:'">
                                <dde:processingLevel>
                                    <xsl:value-of select="$processLevel"/>
                                </dde:processingLevel>
                            </xsl:when>
                            <xsl:otherwise>
                                <dde:processingLevel>
                                    <xsl:value-of select="concat(string('other:'), $processLevel)"/>
                                </dde:processingLevel>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dde:imageryInfo>
                </xsl:if>
            </dde:identificationInfo>

        </xsl:element>
        <!-- end of dde:MD_Metadata -->

    </xsl:template>

    <xsl:template match="cit:CI_Citation">
        <!-- populate a dde online resource -->
        <dde:title>
            <xsl:choose>
                <xsl:when test="cit:title/gco:CharacterString">
                    <xsl:value-of select="cit:title/gco:CharacterString"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="nilReason" select="missing"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="not(starts-with(cit:identifier//mcc:code/gco:CharacterString, 'http'))">
                <xsl:value-of select="string(' Identifier: ')"/>
                    <xsl:if test="cit:identifier//mcc:codeSpace">
                        <xsl:value-of select="cit:identifier//mcc:codeSpace/gco:CharacterString"/>
                        <xsl:value-of select="string(':')"/>
                </xsl:if>
                <xsl:value-of select="cit:identifier//mcc:code/gco:CharacterString"/>
            </xsl:if>
        </dde:title>
        <dde:description>
            <xsl:for-each select="cit:date">
                <xsl:call-template name="getText">
                    <!-- gather dates  -->
                    <xsl:with-param name="theNode" select="child::*"/>
                </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="cit:citedResponsibleParty">
                <xsl:call-template name="getText">
                    <!-- gather text for responsible parties  -->
                    <xsl:with-param name="theNode" select="child::*"/>
                </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="cit:onlineResource/cit:CI_OnlineResource/cit:description">
                <xsl:value-of select="gco:CharacterString"/>
            </xsl:for-each>
        </dde:description>
        <dde:linkage>
            <xsl:choose>
                <xsl:when
                    test="cit:onlineResource/cit:CI_OnlineResource/cit:linkage/gco:CharacterString">
                    <xsl:value-of
                        select="cit:onlineResource/cit:CI_OnlineResource/cit:linkage/gco:CharacterString"
                    />
                </xsl:when>
                <xsl:when test="starts-with(cit:identifier//mcc:code/gco:CharacterString, 'http')">
                    <xsl:value-of select="cit:identifier//mcc:code/gco:CharacterString"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="nilReason" select="string('missing')"/>
                </xsl:otherwise>
            </xsl:choose>
        </dde:linkage>
    </xsl:template>

    <xsl:template name="spatialRep">
        <xsl:param name="pos"/>
        <xsl:if
            test="(count(//mrs:MD_ReferenceSystem) + count(//mri:spatialRepresentationType) + count(//mri:MD_Resolution)) > 0">
            <dde:spatialRepresentationInfo>
                <dde:spatialRepresentationType>
                    <!-- must have a value if the parent is present -->
                    <xsl:choose>
                        <xsl:when
                            test="string-length(//mri:spatialRepresentationType[$pos]/mcc:MD_SpatialRepresentationTypeCode/@codeListValue) > 0">
                            <xsl:value-of
                                select="//mri:spatialRepresentationType[$pos]/mcc:MD_SpatialRepresentationTypeCode/@codeListValue"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="string('other:missing')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </dde:spatialRepresentationType>
                <!-- required, but only one per distribution -->
                <xsl:if test="//mri:spatialResolution[$pos]">
                    <dde:spatialResolution>
                        <xsl:choose>
                            <xsl:when test="//mri:spatialResolution[$pos]//mri:denominator">
                                <xsl:value-of
                                    select="concat('1:', string(//mri:spatialResolution[$pos]//mri:denominator/gco:Integer))"
                                />
                            </xsl:when>
                            <xsl:when test="//mri:spatialResolution[$pos]//mri:levelOfDetail">
                                <xsl:value-of
                                    select="string(//mri:spatialResolution[$pos]//mri:levelOfDetail/gco:CharacterString)"
                                />
                            </xsl:when>
                        </xsl:choose>
                    </dde:spatialResolution>
                </xsl:if>
                <xsl:if
                    test="string-length(//mdb:referenceSystemInfo[$pos]//mrs:referenceSystemType/mrs:MD_ReferenceSystemTypeCode/@codeListValue) > 0">
                    <dde:referenceSystemType>
                        <xsl:value-of
                            select="//mdb:referenceSystemInfo[$pos]//mrs:referenceSystemType/mrs:MD_ReferenceSystemTypeCode/@codeListValue"
                        />
                    </dde:referenceSystemType>
                </xsl:if>
                <dde:referenceSystemIdentifier>
                    <xsl:choose>
                        <xsl:when
                            test="//mdb:referenceSystemInfo[$pos]//mrs:referenceSystemIdentifier/mcc:MD_Identifier">
                            <xsl:apply-templates
                                select="//mdb:referenceSystemInfo[$pos]//mrs:referenceSystemIdentifier/mcc:MD_Identifier"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                      <dde:code>missing</dde:code>
                        </xsl:otherwise>
                    </xsl:choose>
                </dde:referenceSystemIdentifier>
                <!-- required -->
            </dde:spatialRepresentationInfo>
        </xsl:if>

    </xsl:template>

    <xsl:template match="cit:CI_OnlineResource">
        <xsl:if test="cit:name">
            <dde:title>
                <xsl:value-of select="child::cit:name"/>
            </dde:title>
        </xsl:if>
        <xsl:if test="cit:applicationProfile">
            <dde:applicationProfile>
                <xsl:value-of select="cit:applicationProfile/gco:CharacterString"/>
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
        <xsl:if test="cit:party//cit:contactInfo//cit:country/child::*">
            <xsl:variable name="countryvb" select="cit:party//cit:contactInfo//cit:country/child::*"/>
            <dde:country>
                <xsl:choose>
                    <xsl:when test="string-length($countryvb) = 2">
                        <xsl:value-of select="$countryvb"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="countryAbbrev"
                            select="$countryLookup/entry[@key = $countryvb]/@value"/>
                        <xsl:choose>
                            <xsl:when test="$countryAbbrev">
                                <xsl:value-of select="$countryAbbrev[1]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="string('--')"/>
                                <!-- sentinel value for 'unknown' -->
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </dde:country>
        </xsl:if>
        <!-- is there a country in the contactInfo -->


        <dde:electronicMailAddress>
            <!-- dde only allows one e-mail address; ISO19115-3 allows many, take the first -->
            <xsl:choose>
                <xsl:when test="cit:party//cit:contactInfo//cit:electronicMailAddress[1]/child::*">
                    <xsl:value-of
                        select="cit:party//cit:contactInfo//cit:electronicMailAddress[1]/child::*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="nilReason" select="string('missing')"/>
                </xsl:otherwise>
            </xsl:choose>
        </dde:electronicMailAddress>

    </xsl:template>

    <xsl:template match="mcc:MD_Identifier">
        <xsl:if test="mcc:authority/cit:CI_Citation/cit:title/gco:CharacterString">
            <dde:authority>
                <dde:name>
                    <xsl:value-of
                        select="mcc:authority/cit:CI_Citation/cit:title/gco:CharacterString"/>
                </dde:name>
                <dde:role>resourceProvider</dde:role>
            </dde:authority>
        </xsl:if>
        <dde:code>
            <xsl:choose>
                <xsl:when test="mcc:code/child::*">
                    <xsl:value-of select="string(mcc:code/child::*)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="string('ERROR-identifierCodeRequired')"/>
                </xsl:otherwise>
            </xsl:choose>
        </dde:code>

        <xsl:if test="mcc:codeSpace/child::*">
            <dde:codeSpace>
                <xsl:value-of select="string(mcc:codeSpace/child::*)"/>
            </dde:codeSpace>
        </xsl:if>
        <xsl:if test="mcc:version/child::*">
            <dde:version>
                <xsl:value-of select="string(mcc:version/child::*)"/>
            </dde:version>
        </xsl:if>
        <xsl:if test="mcc:description/child::*">
            <dde:description>
                <xsl:value-of select="string(mcc:description/child::*)"/>
            </dde:description>
        </xsl:if>
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
            <xsl:if test=".//gco:CharacterString or .//gcx:Anchor or .//gco:Record">
                <!--<xsl:value-of select="local-name()"/>
                <xsl:text>:</xsl:text>-->
                <xsl:for-each select=".//gco:CharacterString | .//gcx:Anchor | .//gco:Record">
                    <xsl:value-of select="local-name(parent::*)"/>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="string(.)"/>
                    <xsl:text>; </xsl:text>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
