<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- SMR 2023-10-02 -->
    
    <xsl:variable name="resourceTypeMapping">
        <!-- key id DDE resourceType, Value is ISO19115-3 scope code -->
        <entry key="portrayalCatalogueCitation" value="information.portrayal"/>
        <entry key="additionalDocumentation" ns="mrl" value="information.lineage" type="dq"/>
        <entry key="specification" value="information.qualitySpecification" type="dq"/>
        <entry key="reportReference" value="information.qualityReport" type="dq"/>
        <entry key="featureCatalogueCitation" value="information.content"/>
    </xsl:variable>
    
    
</xsl:stylesheet>