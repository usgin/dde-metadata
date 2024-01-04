<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- SMR 2023-10-02 -->

    <xsl:variable name="resourceTypeMapping">
        <!-- key id DDE resourceType, Value is ISO19115-3 scope code -->
        <entry key="Aggregate" value="aggregate"/>
        <entry key="Application" value="application"/>
        <entry key="Web Application" value="application"/>
        <entry key="Collection" value="collection"/>
        <entry key="Dataset" value="dataset"/>
        <entry key="DataCatalog" value="dataset"/>
        <entry key="GeographicDataset" value="dataset"/>
        <entry key="NonGeographicDataset" value="nonGeographicDataset"/>
        <entry key="Document" value="document"/>
        <entry key="Article" value="document"/>
        <entry key="Thesis" value="document"/>
        <entry key="Book" value="document"/>
        <entry key="Poster" value="document"/>
        <entry key="WebPage" value="document"/>
        <entry key="Image" value="document"/>
        <entry key="Map" value="document"/>
        <entry key="Photograph" value="document"/>
        <entry key="ExplanatoryFigure" value="document"/>
        <entry key="Initiative" value="initiative"/>
        <entry key="FieldSession" value="fieldSession"/>
        <entry key="LearningResource" value="document"/>
        <entry key="Guide" value="document"/>
        <entry key="Model" value="model"/>
        <entry key="Movie" value="document"/>
        <entry key="Repository" value="repository"/>
        <entry key="Semantic resource" value="dataset"/>
        <entry key="DefinedTermSet" value="dataset"/>
        <entry key="Series" value="series"/>
        <entry key="Service" value="service"/>
        <entry key="WebAPI" value="service"/>
        <entry key="Software" value="software"/>
        <entry key="Sound" value="document"/>
    </xsl:variable>
    
    <xsl:variable name="ISO2DDEresourceMapping">
        <!-- key id DDE resourceType, Value is ISO19115-3 scope code -->
        <entry key="Aggregate" value="aggregate"/>
        <entry key="Aggregate" value="aggregate"/>
        <entry key="Application" value="application"/>
        <entry key="Web Application" value="application"/>
        <entry key="Collection" value="collection"/>
        <entry key="Dataset" value="dataset"/>
        <entry key="DataCatalog" value="dataset"/>
        <entry key="GeographicDataset" value="dataset"/>
        <entry key="NonGeographicDataset" value="nonGeographicDataset"/>
        <entry key="Document" value="document"/>
        <entry key="Article" value="document"/>
        <entry key="Thesis" value="document"/>
        <entry key="Book" value="document"/>
        <entry key="Poster" value="document"/>
        <entry key="WebPage" value="document"/>
        <entry key="Image" value="document"/>
        <entry key="Map" value="document"/>
        <entry key="Photograph" value="document"/>
        <entry key="ExplanatoryFigure" value="document"/>
        <entry key="Initiative" value="initiative"/>
        <entry key="FieldSession" value="fieldSession"/>
        <entry key="LearningResource" value="document"/>
        <entry key="Guide" value="document"/>
        <entry key="Model" value="model"/>
        <entry key="Movie" value="document"/>
        <entry key="Repository" value="repository"/>
        <entry key="Semantic resource" value="dataset"/>
        <entry key="DefinedTermSet" value="dataset"/>
        <entry key="Series" value="series"/>
        <entry key="Service" value="service"/>
        <entry key="WebAPI" value="service"/>
        <entry key="Software" value="software"/>
        <entry key="Sound" value="document"/>
    </xsl:variable>

    <xsl:template name="TimePositionFormat">
        <!-- from USGIN transformations -->
        <xsl:param name="tpos"/>
        <xsl:variable name="inputDate">
            <xsl:choose>
                <xsl:when test="contains($tpos, 'T')">
                    <xsl:value-of select="substring-before($tpos, 'T')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$tpos"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="inputTime">
            <xsl:choose>
                <xsl:when test="contains($tpos, 'T')">
                    <xsl:value-of select="substring-after($tpos, 'T')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- var_DateString will contain either 'nilAAAAA' where AAAA is a nilReason, a valid xs:dateTime, or it will contain a valid Date in format YYYY-MM-DD -->
        <xsl:variable name="var_DateString">
            <xsl:choose>
                <xsl:when
                    test="(substring($inputDate, 5, 1) = '-') and (substring($inputDate, 8, 1) = '-')">
                    <!-- if hyphens in right place assume is standard ISO8601 YYYY-MM-DD -->
                    <xsl:value-of select="string($inputDate)"/>
                </xsl:when>

                <xsl:when
                    test="(substring($inputDate, 5, 1) = '-') and (string-length($inputDate) = 7)">
                    <!-- YYYY-MM -->
                    <xsl:value-of select="concat(string($inputDate), '-01')"/>
                </xsl:when>

                <xsl:when test="string-length($inputDate) = 4">
                    <!-- YYYY -->
                    <xsl:value-of select="concat(string($inputDate), '-01-01')"/>
                </xsl:when>

                <!-- convert YYYYMMDD format to YYYY-MM-DD format -->
                <xsl:otherwise>
                    <xsl:variable name="var_dateString_result">
                        <xsl:choose>
                            <xsl:when test="string-length(normalize-space(string($inputDate))) = 8">
                                <xsl:value-of
                                    select="concat(substring(normalize-space(string($inputDate)), 0, 5), '-', substring(normalize-space(string($inputDate)), 5, 2), '-', substring(normalize-space(string($inputDate)), 7, 2))"
                                />
                            </xsl:when>
                            <xsl:when test="string-length(normalize-space(string($inputDate))) = 6">
                                <xsl:value-of
                                    select="concat(substring(normalize-space(string($inputDate)), 0, 5), '-', substring(normalize-space(string($inputDate)), 5, 2), '-01')"
                                />
                            </xsl:when>
                            <xsl:when test="string-length(normalize-space(string($inputDate))) = 4">
                                <xsl:value-of
                                    select="concat(substring(normalize-space(string($inputDate)), 0, 5), '-01-01')"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="string('nilmissing')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when
                            test="(substring($var_dateString_result, 5, 1) = '-') and (substring($var_dateString_result, 8, 1) = '-')">
                            <xsl:value-of select="$var_dateString_result"/>
                            <!-- /gco:DateTime -->
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- date format is screwy, put in default value -->
                            <xsl:value-of select="string('nilmissing')"/>
                            <!-- xsl:attribute name="gco:nilReason"><xsl:value-of select="string('InvalidValue')"/></xsl:attribute>
							<gco:DateTime>1900-01-01T12:00:00Z</gco:DateTime -->
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- now need to process input time  -->
        <xsl:variable name="var_timeString">
            <xsl:choose>
                <xsl:when
                    test="(substring($inputTime, 3, 1) = ':') and (substring($inputTime, 6, 1) = ':')">
                    <!-- if colonx in right place assume is standard ISO8601 hh:mm:ss -->
                    <xsl:value-of select="string($inputTime)"/>
                </xsl:when>
                
                <xsl:when test="string-length($inputTime) = 6">
                    <!-- handle hhmmss -->
                    <xsl:value-of
                        select="concat(substring(string($inputTime), 0, 3), ':', substring(string($inputTime), 3, 2), ':', substring(string($inputTime), 5, 2))"
                    />
                </xsl:when>
                <xsl:when
                    test="(substring($inputTime, 3, 1) = ':') and (string-length($inputTime) = 5)">
                    <!-- handle hh:mm -->
                    <xsl:value-of select="concat(string($inputTime),  ':00')"/>
                </xsl:when>
                
                <xsl:when test="string-length($inputTime) = 4">
                    <!-- handle hhmm -->
                    <xsl:value-of
                        select="concat(substring(string($inputTime), 0, 3), ':', substring(string($inputTime), 3, 2), ':00')"
                    />
                </xsl:when>
                <xsl:when test="string-length($inputTime) = 2">
                    <xsl:value-of select="concat(substring(string($inputTime), 0, 3), ':00:00')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="string('12:00:00')"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- /xsl:for-each-->
        </xsl:variable>
        <!-- now merge date string with time string (if it exists) -->
        <!--<xsl:choose>
            <xsl:when
                test="$var_DateString and (string-length($var_DateString) = 10) and (string-length($var_timeString) = 8)">
                <xsl:value-of select="concat(string($var_DateString), 'T', string($var_timeString))"
                />
            </xsl:when>
            <xsl:when
                test="$var_DateString and (string-length($var_DateString) = 10) and not(string-length($var_timeString) = 8)">
                <xsl:value-of select="concat(string($var_DateString), 'T12:00:00')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="string('indeterminate')"/>
            </xsl:otherwise>
        </xsl:choose>-->
        <xsl:value-of select="concat(string($var_DateString), 'T', string($var_timeString))"/>
    </xsl:template>




</xsl:stylesheet>
