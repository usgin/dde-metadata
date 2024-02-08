<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- SMR 2023-10-02
      update 2024-02-04 for current DDE resourceType codes -->

    <xsl:variable name="resourceTypeMapping">
        <!-- key id DDE resourceType, Value is ISO19115-3 scope code -->
        <entry key="aggregate" value="aggregate"/>
        <entry key="application" value="application"/>
        <entry key="webApplication" value="application"/>
        <entry key="collection" value="collection"/>
        <entry key="dataset" value="dataset"/>
        <entry key="dataCatalog" value="dataset"/>
        <entry key="geographicDataset" value="dataset"/>
        <entry key="nonGeographicDataset" value="nonGeographicDataset"/>
        <entry key="document" value="document"/>
        <entry key="article" value="document"/>
        <entry key="thesis" value="document"/>
        <entry key="book" value="document"/>
        <entry key="poster" value="document"/>
        <entry key="webPage" value="document"/>
        <entry key="image" value="document"/>
        <entry key="map" value="document"/>
        <entry key="photograph" value="document"/>
        <entry key="explanatoryFigure" value="document"/>
        <entry key="initiative" value="initiative"/>
        <entry key="fieldSession" value="fieldSession"/>
        <entry key="learningResource" value="document"/>
        <entry key="guide" value="document"/>
        <entry key="model" value="model"/>
        <entry key="movie" value="document"/>
        <entry key="repository" value="repository"/>
        <entry key="semanticResource" value="dataset"/>
        <entry key="definedTermSet" value="dataset"/>
        <entry key="series" value="series"/>
        <entry key="service" value="service"/>
        <entry key="webAPI" value="service"/>
        <entry key="software" value="software"/>
        <entry key="sound" value="document"/>
    </xsl:variable>

    <xsl:variable name="codeCorrectionMapping">
        <!-- key is codelist string that appears in source metadata,
            Value is corresponding DDE-valid code. For use in
            ISO to DDE transforms-->
        <entry key="uft8" value="UTF-8"/>
        <entry key="utf8" value="UTF-8"/>
        <entry key="utf-8" value="UTF-8"/>
        <entry key="UTF 8" value="UTF-8"/>
        <entry key="utf 8" value="UTF-8"/>
        <entry key="us-ascii" value="US-ASCII"/>
        <entry key="us ascii" value="US-ASCII"/>
        <entry key="US ASCII" value="US-ASCII"/>
        <entry key="USASCII" value="US-ASCII"/>
        <entry key="usascii" value="US-ASCII"/>
        <entry key="iso-8859-1" value="ISO-8859-1"/>
        <entry key="iso 8859-1" value="ISO-8859-1"/>
        <entry key="ISO 8859-1" value="ISO-8859-1"/>
        <entry key="iso8859-1" value="ISO-8859-1"/>
        <entry key="ISO8859-1" value="ISO-8859-1"/>
        <entry key="shift JIS" value="Shift_JIS"/>
        <entry key="SHIFT_JIS" value="Shift_JIS"/>
        <entry key="Shift JIS" value="Shift_JIS"/>
        <entry key="shiftJIS" value="Shift_JIS"/>
        <entry key="ShiftJIS" value="Shift_JIS"/>
        <entry key="EUC JP" value="EUC-JP"/>
        <entry key="euc jp" value="EUC-JP"/>
        <entry key="euc-jp" value="EUC-JP"/>
        <entry key="EUC KR" value="EUC-KR"/>
        <entry key="euc kr" value="EUC-KR"/>
        <entry key="euc-kr" value="EUC-KR"/>
        <entry key="gb18030" value="GB18030"/>
        <entry key="gb 18030" value="GB18030"/>
        <entry key="GB 18030" value="GB18030"/>
        <entry key="big5" value="Big5"/>
        <entry key="big 5" value="Big5"/>
        <entry key="BIG5" value="Big5"/>
        <entry key="Big-5" value="Big5"/>
        <entry key="Big 5" value="Big5"/>
        <entry key="windows 1251" value="windows-1251"/>
        <entry key="WINDOWS 1251" value="windows-1251"/>
        <entry key="WINDOWS-1251" value="windows-1251"/>
        <entry key="Windows 1251" value="windows-1251"/>
        <entry key="Windows-1251" value="windows-1251"/>
        <entry key="windows1251" value="windows-1251"/>
        <entry key="Windows1251" value="windows-1251"/>

    </xsl:variable>

    <!-- This is a lookup table to check if a serviceType in an input is 
one of the valid enum values  -->
    <xsl:variable name="serviceTypeCheck">
        <entry key="dataService" value="true"/>
        <entry key="dataAccessService" value="true"/>
        <entry key="dataWorkFlowService" value="true"/>
        <entry key="dataProcessingService" value="true"/>
        <entry key="dataMapService" value="true"/>
        <entry key="dataOtherService" value="true"/>
        <entry key="knowledgeService" value="true"/>
        <entry key="knowledgeGeoscienceCatalogueService" value="true"/>
        <entry key="knowledgeGeoscienceContentService" value="true"/>
        <entry key="knowledgeReasoningService" value="true"/>
        <entry key="knowledgeDeepShovel" value="true"/>
        <entry key="knowledgeDDEScholar" value="true"/>
        <entry key="knowledgeOtherService" value="true"/>
        <entry key="platformService" value="true"/>
        <entry key="platformCatalogueService" value="true"/>
        <entry key="platformRegistryService" value="true"/>
        <entry key="platformModelService" value="true"/>
        <entry key="platformCloudComputingResourceService" value="true"/>
        <entry key="platformAnnotationService" value="true"/>
        <entry key="platformAPIService" value="true"/>
        <entry key="platformEarthExplorer" value="true"/>
        <entry key="platformDataEvaluationService" value="true"/>
        <entry key="platformDDEIdentifierService" value="true"/>
        <entry key="platformOtherPlatformService" value="true"/>
        <entry key="thematicService" value="true"/>
        <entry key="thematicMineralResourceAssessmentService" value="true"/>
        <entry key="thematicGeologicMappingGlobalService" value="true"/>
        <entry key="thematicGeologicalTimelineService" value="true"/>
        <entry key="thematicDigitalGeologicalOccurrenceService" value="true"/>
        <entry key="thematicDinosaurService" value="true"/>
        <entry key="thematicGlobalNamingService" value="true"/>
        <entry key="thematicGeomorphologyMappingService" value="true"/>
        <entry key="thematicGeoscienceStandardService" value="true"/>
        <entry key="thematicOtherService" value="true"/>
        <entry key="vocabularyService" value="true"/>
        <entry key="registryService" value="true"/>
        <entry key="discoveryService" value="true"/>
        <entry key="viewService" value="true"/>
    </xsl:variable>

    <xsl:variable name="acquisitionCodeCheck">
        <!-- lookup to determine if a string is in the DDE acquisitionCode codelist. -->
        <entry key="geologicalMapping" value="true"/>
        <entry key="survey" value="true"/>
        <entry key="observation" value="true"/>
        <entry key="directObservation" value="true"/>
        <entry key="indirectObservation" value="true"/>
        <entry key="outcropObservation" value="true"/>
        <entry key="remoteSensing" value="true"/>
        <entry key="drillBorehole" value="true"/>
        <entry key="boreholeCuttingsObservation" value="true"/>
        <entry key="boreholeGeophysicalLogMeasurements" value="true"/>
        <entry key="drillCoreObservation" value="true"/>
        <entry key="laboratoryInstrumentation" value="true"/>
        <entry key="dataIntegrationSynthesis" value="true"/>
        <entry key="dataFromSinglePublishedDescription" value="true"/>
        <entry key="synthesisFromMultipleSources" value="true"/>
        <entry key="synthesisFromMultipleOutcropObservations" value="true"/>
        <entry key="synthesisFromMultiplePublishedDescriptions" value="true"/>
        <entry key="digitalConversionFromPublishedSource" value="true"/>
        <entry key="digitalSimulation" value="true"/>
        <entry key="dataAndMapCompilation" value="true"/>
        <entry key="webResource" value="true"/>
    </xsl:variable>

    <xsl:variable name="countryLookup">
        <!-- Lookup based on https://en.wikipedia.org/w/index.php?title=ISO_3166-1_alpha-2&action=view&section=6#Officially_assigned_code_elements
     modified to add legacy names and likely spelling without special characters, or common abbreviations.-->
        <entry key="Andorra" value="AD" fullname="Andorra"/>
        <entry key="AND" value="AD" fullname="Andorra"/>
        <entry key="UAE" value="AE" fullname="United Arab Emirates"/>
        <entry key="United Arab Emirates" value="AE" fullname="United Arab Emirates"/>
        <entry key="United Arab Emirates (the)" value="AE" fullname="United Arab Emirates"/>
        <entry key="ARE" value="AE" fullname="United Arab Emirates"/>
        <entry key="Afghanistan" value="AF" fullname="Afghanistan"/>
        <entry key="AFG" value="AF" fullname="Afghanistan"/>
        <entry key="Antigua" value="AG" fullname="Antigua and Barbuda" notes=" "/>
        <entry key="Antigua and Barbuda" value="AG" fullname="Antigua and Barbuda"/>
        <entry key="Barbuda" value="AG" fullname="Antigua and Barbuda"/>
        <entry key="ATG" value="AG" fullname="Antigua and Barbuda"/>
        <entry key="Anguilla" value="AI" fullname="Anguilla"
            notes="AI previously represented French Afars and Issas"/>
        <entry key="AIA" value="AI" fullname="Anguilla"/>
        <entry key="Albania" value="AL" fullname="Albania"/>
        <entry key="ALB" value="AL" fullname="Albania"/>
        <entry key="Armenia" value="AM" fullname="Armenia"/>
        <entry key="ARM" value="AM" fullname="Armenia"/>
        <entry key="Angola" value="AO" fullname="Angola"/>
        <entry key="AGO" value="AO" fullname="Angola"/>
        <entry key="Antarctica" value="AQ" fullname="Antarctica"
            notes="Covers the territories south of 60° south latitude. Code taken from name in French: Antarctique"/>
        <entry key="ATA" value="AQ" fullname="Antarctica"/>
        <entry key="Argentina" value="AR" fullname="Argentina"/>
        <entry key="ARG" value="AR" fullname="Argentina"/>
        <entry key="American Samoa" value="AS" fullname="American Samoa"/>
        <entry key="ASM" value="AS" fullname="American Samoa"/>
        <entry key="Austria" value="AT" fullname="Austria"/>
        <entry key="AUT" value="AT" fullname="Austria"/>
        <entry key="Australia" value="AU" fullname="Australia"
            notes="Includes the Ashmore and Cartier Islands and the Coral Sea Islands"/>
        <entry key="AUS" value="AU" fullname="Australia"/>
        <entry key="Aruba" value="AW" fullname="Aruba"/>
        <entry key="ABW" value="AW" fullname="Aruba"/>
        <entry key="Aland Islands" value="AX" fullname="Åland Islands"
            notes="An autonomous county of Finland"/>
        <entry key="Åland Islands" value="AX" fullname="Åland Islands"
            notes="An autonomous county of Finland"/>
        <entry key="ALA" value="AX" fullname="Åland Islands"/>
        <entry key="Azerbaijan" value="AZ" fullname="Azerbaijan"/>
        <entry key="AZE" value="AZ" fullname="Azerbaijan"/>
        <entry key="Bosnia" value="BA" fullname="Bosnia and Herzegovina"/>
        <entry key="Bosnia and Herzegovina" value="BA" fullname="Bosnia and Herzegovina"/>
        <entry key="Herzegovina" value="BA" fullname="Bosnia and Herzegovina"/>
        <entry key="BIH" value="BA" fullname="Bosnia and Herzegovina"/>
        <entry key="Barbados" value="BB" fullname="Barbados"/>
        <entry key="BRB" value="BB" fullname="Barbados"/>
        <entry key="Bangladesh" value="BD" fullname="Bangladesh"/>
        <entry key="BGD" value="BD" fullname="Bangladesh"/>
        <entry key="Belgium" value="BE" fullname="Belgium"/>
        <entry key="BEL" value="BE" fullname="Belgium"/>
        <entry key="Burkina Faso" value="BF" fullname="Burkina Faso"
            notes="Name changed from Upper Volta (HV)"/>
        <entry key="Upper Volta" value="BF" fullname="Burkina Faso" notes="now Burkina Faso"/>
        <entry key="BFA" value="BF" fullname="Burkina Faso"/>
        <entry key="Bulgaria" value="BG" fullname="Bulgaria"/>
        <entry key="BGR" value="BG" fullname="Bulgaria"/>
        <entry key="Bahrain" value="BH" fullname="Bahrain"/>
        <entry key="BHR" value="BH" fullname="Bahrain"/>
        <entry key="Burundi" value="BI" fullname="Burundi"/>
        <entry key="BDI" value="BI" fullname="Burundi"/>
        <entry key="Benin" value="BJ" fullname="Benin" notes="Name changed from Dahomey (DY)"/>
        <entry key="Dahomey " value="BJ" fullname="Benin" notes="Now Benin"/>
        <entry key="BEN" value="BJ" fullname="Benin"/>
        <entry key="Saint Barthelemy" value="BL" fullname="Saint Barthélemy"/>
        <entry key="Saint Barthélemy" value="BL" fullname="Saint Barthélemy"/>
        <entry key="St Barthelemy" value="BL" fullname="Saint Barthélemy"/>
        <entry key="BLM" value="BL" fullname="Saint Barthélemy"/>
        <entry key="Bermuda" value="BM" fullname="Bermuda"/>
        <entry key="BMU" value="BM" fullname="Bermuda"/>
        <entry key="Brunei" value="BN" fullname="Brunei Darussalam" notes="now Brunei Darussalam"/>
        <entry key="Brunei Darussalam" value="BN" fullname="Brunei Darussalam"
            notes="Previous ISO country name: Brunei"/>
        <entry key="BRN" value="BN" fullname="Brunei Darussalam"/>
        <entry key="Bolivia" value="BO" fullname="Bolivia (Plurinational State of)"
            notes="Previous ISO country name: Bolivia"/>
        <entry key="Bolivia (Plurinational State of)" value="BO"
            fullname="Bolivia (Plurinational State of)"/>
        <entry key="BOL" value="BO" fullname="Bolivia (Plurinational State of)"/>
        <entry key="Bonaire" value="BQ" fullname="Bonaire, Sint Eustatius and Saba"
            notes="one of three Caribbean special municipalities, which are part of the Netherlands proper"/>
        <entry key="Bonaire, Sint Eustatius and Saba" value="BQ"
            fullname="Bonaire, Sint Eustatius and Saba"
            notes="Consists of three Caribbean special municipalities, which are part of the Netherlands proper: Bonaire, Sint Eustatius, and Saba (the BES Islands).  Previous ISO country name: Bonaire, Saint Eustatius and Saba.  BQ previously represented British Antarctic Territory"/>
        <entry key="Saba" value="BQ" fullname="Bonaire, Sint Eustatius and Saba"
            notes="one of three Caribbean special municipalities, which are part of the Netherlands proper"/>
        <entry key="Sint Eustatius" value="BQ" fullname="Bonaire, Sint Eustatius and Saba"
            notes="one of three Caribbean special municipalities, which are part of the Netherlands proper"/>
        <entry key="BES" value="BQ" fullname="Bonaire, Sint Eustatius and Saba"/>
        <entry key="Brazil" value="BR" fullname="Brazil"/>
        <entry key="BRA" value="BR" fullname="Brazil"/>
        <entry key="Bahamas" value="BS" fullname="Bahamas"/>
        <entry key="Bahamas (the)" value="BS" fullname="Bahamas"/>
        <entry key="BHS" value="BS" fullname="Bahamas"/>
        <entry key="Bhutan" value="BT" fullname="Bhutan"/>
        <entry key="BTN" value="BT" fullname="Bhutan"/>
        <entry key="Bouvet Island" value="BV" fullname="Bouvet Island" notes="Dependency of Norway"/>
        <entry key="BVT" value="BV" fullname="Bouvet Island"/>
        <entry key="Botswana" value="BW" fullname="Botswana"/>
        <entry key="BWA" value="BW" fullname="Botswana"/>
        <entry key="Belarus" value="BY" fullname="Belarus"
            notes="Code taken from previous ISO country name: Byelorussian SSR (now assigned ISO 3166-3 code BYAA).  Code assigned as the country was already a UN member since 1945[14]"/>
        <entry key="Byelorussian SSR " value="BY" fullname="Belarus" notes="now Belarus"/>
        <entry key="BLR" value="BY" fullname="Belarus"/>
        <entry key="Belize" value="BZ" fullname="Belize"/>
        <entry key="BLZ" value="BZ" fullname="Belize"/>
        <entry key="Canada" value="CA" fullname="Canada"/>
        <entry key="CAN" value="CA" fullname="Canada"/>
        <entry key="Cocos (Keeling) Islands" value="CC" fullname="Cocos (Keeling) Islands"
            notes="External territory of Australia"/>
        <entry key="Cocos (Keeling) Islands (the)" value="CC" fullname="Cocos (Keeling) Islands"/>
        <entry key="Cocos Islands" value="CC" fullname="Cocos (Keeling) Islands"
            notes="External territory of Australia"/>
        <entry key="Keeling Islands" value="CC" fullname="Cocos (Keeling) Islands"
            notes="External territory of Australia"/>
        <entry key="CCK" value="CC" fullname="Cocos (Keeling) Islands"/>
        <entry key="Congo" value="CD" fullname="Congo, Democratic Republic of the"
            notes="Name changed from Zaire (ZR)"/>
        <entry key="Congo (the Democratic Republic of the)" value="CD"
            fullname="Congo, Democratic Republic of the"/>
        <entry key="Zaire" value="CD" fullname="Congo, Democratic Republic of the"
            notes="now Congo, Democratic Republic of the"/>
        <entry key="Congo (the)" value="CD" fullname="Congo, Democratic Republic of the"/>
        <entry key="COD" value="CD" fullname="Congo, Democratic Republic of the"/>
        <entry key="COG" value="CD" fullname="Congo, Democratic Republic of the"/>
        <entry key="Central African Republic" value="CF" fullname="Central African Republic"/>
        <entry key="Central African Republic (the)" value="CF" fullname="Central African Republic"/>
        <entry key="CAF" value="CF" fullname="Central African Republic"/>
        <entry key="Switzerland" value="CH" fullname="Switzerland"
            notes="Code taken from name in Latin: Confoederatio Helvetica"/>
        <entry key="CHE" value="CH" fullname="Switzerland"/>
        <entry key="Cote d'Ivoire" value="CI" fullname="Côte d'Ivoire"/>
        <entry key="Côte d'Ivoire" value="CI" fullname="Côte d'Ivoire"
            notes="ISO country name follows UN designation (common name and previous ISO country name: Ivory Coast)"/>
        <entry key="Ivory Coast" value="CI" fullname="Côte d'Ivoire"/>
        <entry key="CIV" value="CI" fullname="Côte d'Ivoire"/>
        <entry key="Cook Islands" value="CK" fullname="Cook Islands"/>
        <entry key="Cook Islands (the)" value="CK" fullname="Cook Islands"/>
        <entry key="COK" value="CK" fullname="Cook Islands"/>
        <entry key="Chile" value="CL" fullname="Chile"/>
        <entry key="CHL" value="CL" fullname="Chile"/>
        <entry key="Cameroon" value="CM" fullname="Cameroon"
            notes="Previous ISO country name: Cameroon, United Republic of"/>
        <entry key="CMR" value="CM" fullname="Cameroon"/>
        <entry key="China" value="CN" fullname="China"/>
        <entry key="CHN" value="CN" fullname="China"/>
        <entry key="Colombia" value="CO" fullname="Colombia"/>
        <entry key="COL" value="CO" fullname="Colombia"/>
        <entry key="Costa Rica" value="CR" fullname="Costa Rica"/>
        <entry key="CRI" value="CR" fullname="Costa Rica"/>
        <entry key="Cuba" value="CU" fullname="Cuba"/>
        <entry key="CUB" value="CU" fullname="Cuba"/>
        <entry key="Cabo Verde" value="CV" fullname="Cabo Verde"
            notes="ISO country name follows UN designation (common name and previous ISO country name: Cape Verde, another previous ISO country name: Cape Verde Islands)"/>
        <entry key="Cape Verde" value="CV" fullname="Cabo Verde"/>
        <entry key="Cape Verde Islands" value="CV" fullname="Cabo Verde"/>
        <entry key="CPV" value="CV" fullname="Cabo Verde"/>
        <entry key="Curacao" value="CW" fullname="Curaçao"/>
        <entry key="Curaçao" value="CW" fullname="Curaçao"/>
        <entry key="CUW" value="CW" fullname="Curaçao"/>
        <entry key="Christmas Island" value="CX" fullname="Christmas Island"
            notes="External territory of Australia"/>
        <entry key="CXR" value="CX" fullname="Christmas Island"/>
        <entry key="Cyprus" value="CY" fullname="Cyprus"/>
        <entry key="CYP" value="CY" fullname="Cyprus"/>
        <entry key="Czech Republic" value="CZ" fullname="Czechia" notes="Czechia"/>
        <entry key="Czechia" value="CZ" fullname="Czechia"
            notes="Previous ISO country name: Czech Republic"/>
        <entry key="CZE" value="CZ" fullname="Czechia"/>
        <entry key="Germany" value="DE" fullname="Germany"
            notes="Code taken from name in German: Deutschland.  Code used for West Germany before 1990 (previous ISO country name: Germany, Federal Republic of)"/>
        <entry key="DEU" value="DE" fullname="Germany"/>
        <entry key="Afars and Issas " value="DJ" fullname="Djibouti" notes="now Djibouti"/>
        <entry key="Djibouti" value="DJ" fullname="Djibouti"
            notes="Name changed from French Afars and Issas (AI)"/>
        <entry key="French Afars and Issas " value="DJ" fullname="Djibouti" notes="now Djibouti"/>
        <entry key="DJI" value="DJ" fullname="Djibouti"/>
        <entry key="Denmark" value="DK" fullname="Denmark"/>
        <entry key="DNK" value="DK" fullname="Denmark"/>
        <entry key="Dominica" value="DM" fullname="Dominica"/>
        <entry key="DMA" value="DM" fullname="Dominica"/>
        <entry key="Dominican Republic" value="DO" fullname="Dominican Republic"/>
        <entry key="Dominican Republic (the)" value="DO" fullname="Dominican Republic"/>
        <entry key="DOM" value="DO" fullname="Dominican Republic"/>
        <entry key="Algeria" value="DZ" fullname="Algeria"
            notes="Code taken from name in Arabic الجزائر al-Djazā'ir, Algerian Arabic الدزاير al-Dzāyīr, or Berber ⴷⵣⴰⵢⵔ Dzayer"/>
        <entry key="DZA" value="DZ" fullname="Algeria"/>
        <entry key="Ecuador" value="EC" fullname="Ecuador"/>
        <entry key="ECU" value="EC" fullname="Ecuador"/>
        <entry key="Estonia" value="EE" fullname="Estonia"
            notes="Code taken from name in Estonian: Eesti"/>
        <entry key="EST" value="EE" fullname="Estonia"/>
        <entry key="Egypt" value="EG" fullname="Egypt"/>
        <entry key="EGY" value="EG" fullname="Egypt"/>
        <entry key="Spanish Sahara" value="EH" fullname="Western Sahara"/>
        <entry key="Western Sahara" value="EH" fullname="Western Sahara"
            notes="Previous ISO country name: Spanish Sahara (code taken from name in Spanish: Sahara español)"/>
        <entry key="ESH" value="EH" fullname="Western Sahara"/>
        <entry key="Eritrea" value="ER" fullname="Eritrea"/>
        <entry key="ERI" value="ER" fullname="Eritrea"/>
        <entry key="Spain" value="ES" fullname="Spain"
            notes="Code taken from name in Spanish: España"/>
        <entry key="ESP" value="ES" fullname="Spain"/>
        <entry key="Ethiopia" value="ET" fullname="Ethiopia"/>
        <entry key="ETH" value="ET" fullname="Ethiopia"/>
        <entry key="Finland" value="FI" fullname="Finland"/>
        <entry key="FIN" value="FI" fullname="Finland"/>
        <entry key="Fiji" value="FJ" fullname="Fiji"/>
        <entry key="FJI" value="FJ" fullname="Fiji"/>
        <entry key="Falkland Islands" value="FK" fullname="Falkland Islands (Malvinas)"/>
        <entry key="Falkland Islands (Malvinas)" value="FK" fullname="Falkland Islands (Malvinas)"
            notes="ISO country name follows UN designation due to the Falkland Islands sovereignty dispute (local common name: Falkland Islands)[16]"/>
        <entry key="Falkland Islands (the)" value="FK" fullname="Falkland Islands (Malvinas)"/>
        <entry key="Malvinas" value="FK" fullname="Falkland Islands (Malvinas)"/>
        <entry key="FLK" value="FK" fullname="Falkland Islands (Malvinas)"/>
        <entry key="Micronesia" value="FM" fullname="Micronesia (Federated States of)"/>
        <entry key="Micronesia (Federated States of)" value="FM"
            fullname="Micronesia (Federated States of)"
            notes="Previous ISO country name: Micronesia"/>
        <entry key="FSM" value="FM" fullname="Micronesia (Federated States of)"/>
        <entry key="Faroe Islands" value="FO" fullname="Faroe Islands"
            notes="Code taken from name in Faroese: Føroyar"/>
        <entry key="Faroe Islands (the)" value="FO" fullname="Faroe Islands"/>
        <entry key="FRO" value="FO" fullname="Faroe Islands"/>
        <entry key="France" value="FR" fullname="France" notes="Includes Clipperton Island"/>
        <entry key="FRA" value="FR" fullname="France"/>
        <entry key="Gabon" value="GA" fullname="Gabon"/>
        <entry key="GAB" value="GA" fullname="Gabon"/>
        <entry key="Great Britain" value="GB"
            fullname="United Kingdom of Great Britain and Northern Ireland"/>
        <entry key="United Kingdom" value="GB"
            fullname="United Kingdom of Great Britain and Northern Ireland"/>
        <entry key="United Kingdom of Great Britain and Northern Ireland" value="GB"
            fullname="United Kingdom of Great Britain and Northern Ireland"
            notes="Code taken from Great Britain (from official name: United Kingdom of Great Britain and Northern Ireland).  Previous ISO country name: United Kingdom. Includes Akrotiri and Dhekelia (Sovereign Base Areas)"/>
        <entry key="United Kingdom of Great Britain and Northern Ireland (the)" value="GB"
            fullname="United Kingdom of Great Britain and Northern Ireland"/>
        <entry key="GBR" value="GB" fullname="United Kingdom of Great Britain and Northern Ireland"/>
        <entry key="Grenada" value="GD" fullname="Grenada"/>
        <entry key="GRD" value="GD" fullname="Grenada"/>
        <entry key="Georgia" value="GE" fullname="Georgia"
            notes="GE previously represented Gilbert and Ellice Islands"/>
        <entry key="GEO" value="GE" fullname="Georgia"/>
        <entry key="French Guiana" value="GF" fullname="French Guiana"
            notes="Code taken from name in French: Guyane française"/>
        <entry key="GUF" value="GF" fullname="French Guiana"/>
        <entry key="Guernsey" value="GG" fullname="Guernsey" notes="A British Crown Dependency"/>
        <entry key="GGY" value="GG" fullname="Guernsey"/>
        <entry key="Ghana" value="GH" fullname="Ghana"/>
        <entry key="GHA" value="GH" fullname="Ghana"/>
        <entry key="Gibraltar" value="GI" fullname="Gibraltar"/>
        <entry key="GIB" value="GI" fullname="Gibraltar"/>
        <entry key="Greenland" value="GL" fullname="Greenland"/>
        <entry key="GRL" value="GL" fullname="Greenland"/>
        <entry key="Gambia" value="GM" fullname="Gambia"/>
        <entry key="Gambia (the)" value="GM" fullname="Gambia"/>
        <entry key="GMB" value="GM" fullname="Gambia"/>
        <entry key="Guinea" value="GN" fullname="Guinea"/>
        <entry key="GIN" value="GN" fullname="Guinea"/>
        <entry key="Guadeloupe" value="GP" fullname="Guadeloupe"/>
        <entry key="GLP" value="GP" fullname="Guadeloupe"/>
        <entry key="Equatorial Guinea" value="GQ" fullname="Equatorial Guinea"
            notes="Code taken from name in French: Guinée équatoriale"/>
        <entry key="GNQ" value="GQ" fullname="Equatorial Guinea"/>
        <entry key="Greece" value="GR" fullname="Greece"/>
        <entry key="GRC" value="GR" fullname="Greece"/>
        <entry key="South Georgia" value="GS"
            fullname="South Georgia and the South Sandwich Islands"/>
        <entry key="South Georgia and the South Sandwich Islands" value="GS"
            fullname="South Georgia and the South Sandwich Islands"/>
        <entry key="South Sandwich Islands" value="GS"
            fullname="South Georgia and the South Sandwich Islands"/>
        <entry key="SGS" value="GS" fullname="South Georgia and the South Sandwich Islands"/>
        <entry key="Guatemala" value="GT" fullname="Guatemala"/>
        <entry key="GTM" value="GT" fullname="Guatemala"/>
        <entry key="Guam" value="GU" fullname="Guam"/>
        <entry key="GUM" value="GU" fullname="Guam"/>
        <entry key="Guinea-Bissau" value="GW" fullname="Guinea-Bissau"/>
        <entry key="GNB" value="GW" fullname="Guinea-Bissau"/>
        <entry key="Guyana" value="GY" fullname="Guyana"/>
        <entry key="GUY" value="GY" fullname="Guyana"/>
        <entry key="Hong Kong" value="HK" fullname="Hong Kong"
            notes="Hong Kong is officially a Special Administrative Region of the People's Republic of China since 1 July 1997"/>
        <entry key="HKG" value="HK" fullname="Hong Kong"/>
        <entry key="Heard Island and McDonald Islands" value="HM"
            fullname="Heard Island and McDonald Islands" notes="External territory of Australia"/>
        <entry key="HMD" value="HM" fullname="Heard Island and McDonald Islands"/>
        <entry key="Honduras" value="HN" fullname="Honduras"/>
        <entry key="HND" value="HN" fullname="Honduras"/>
        <entry key="Croatia" value="HR" fullname="Croatia"
            notes="Code taken from name in Croatian: Hrvatska"/>
        <entry key="HRV" value="HR" fullname="Croatia"/>
        <entry key="Haiti" value="HT" fullname="Haiti"/>
        <entry key="HTI" value="HT" fullname="Haiti"/>
        <entry key="Hungary" value="HU" fullname="Hungary"/>
        <entry key="HUN" value="HU" fullname="Hungary"/>
        <entry key="Indonesia" value="ID" fullname="Indonesia"/>
        <entry key="IDN" value="ID" fullname="Indonesia"/>
        <entry key="Ireland" value="IE" fullname="Ireland"/>
        <entry key="IRL" value="IE" fullname="Ireland"/>
        <entry key="Israel" value="IL" fullname="Israel"/>
        <entry key="ISR" value="IL" fullname="Israel"/>
        <entry key="Isle of Man" value="IM" fullname="Isle of Man"
            notes="A British Crown Dependency"/>
        <entry key="IMN" value="IM" fullname="Isle of Man"/>
        <entry key="India" value="IN" fullname="India"/>
        <entry key="IND" value="IN" fullname="India"/>
        <entry key="British Indian Ocean Territory" value="IO"
            fullname="British Indian Ocean Territory"/>
        <entry key="British Indian Ocean Territory (the)" value="IO"
            fullname="British Indian Ocean Territory"/>
        <entry key="IOT" value="IO" fullname="British Indian Ocean Territory"/>
        <entry key="Iraq" value="IQ" fullname="Iraq"/>
        <entry key="IRQ" value="IQ" fullname="Iraq"/>
        <entry key="Iran" value="IR" fullname="Iran (Islamic Republic of)"/>
        <entry key="Iran (Islamic Republic of)" value="IR" fullname="Iran (Islamic Republic of)"
            notes="Previous ISO country name: Iran"/>
        <entry key="IRN" value="IR" fullname="Iran (Islamic Republic of)"/>
        <entry key="Iceland" value="IS" fullname="Iceland"
            notes="Code taken from name in Icelandic: Ísland"/>
        <entry key="ISL" value="IS" fullname="Iceland"/>
        <entry key="Italy" value="IT" fullname="Italy"/>
        <entry key="ITA" value="IT" fullname="Italy"/>
        <entry key="Jersey" value="JE" fullname="Jersey" notes="A British Crown Dependency"/>
        <entry key="JEY" value="JE" fullname="Jersey"/>
        <entry key="Jamaica" value="JM" fullname="Jamaica"/>
        <entry key="JAM" value="JM" fullname="Jamaica"/>
        <entry key="Jordan" value="JO" fullname="Jordan"/>
        <entry key="JOR" value="JO" fullname="Jordan"/>
        <entry key="Japan" value="JP" fullname="Japan"/>
        <entry key="JPN" value="JP" fullname="Japan"/>
        <entry key="Kenya" value="KE" fullname="Kenya"/>
        <entry key="KEN" value="KE" fullname="Kenya"/>
        <entry key="Kyrgyzstan" value="KG" fullname="Kyrgyzstan"/>
        <entry key="KGZ" value="KG" fullname="Kyrgyzstan"/>
        <entry key="Cambodia" value="KH" fullname="Cambodia"
            notes="Code taken from former name: Khmer Republic. Previous ISO country name: Kampuchea, Democratic"/>
        <entry key="Kampuchea" value="KH" fullname="Cambodia"/>
        <entry key="Khmer Republic" value="KH" fullname="Cambodia"/>
        <entry key="KHM" value="KH" fullname="Cambodia"/>
        <entry key="Gilbert Islands" value="KI" fullname="Kiribati" notes="Now Kiribati"/>
        <entry key="Kiribati" value="KI" fullname="Kiribati"
            notes="Name changed from Gilbert Islands (GE)"/>
        <entry key="KIR" value="KI" fullname="Kiribati"/>
        <entry key="Comoro Islands" value="KM" fullname="Comoros"/>
        <entry key="Comoros" value="KM" fullname="Comoros"
            notes="Code taken from name in Comorian: Komori.  Previous ISO country name: Comoro Islands"/>
        <entry key="Comoros (the)" value="KM" fullname="Comoros"/>
        <entry key="COM" value="KM" fullname="Comoros"/>
        <entry key="Nevis" value="KN" fullname="Saint Kitts and Nevis"/>
        <entry key="Saint Kitts" value="KN" fullname="Saint Kitts and Nevis"/>
        <entry key="Saint Kitts and Nevis" value="KN" fullname="Saint Kitts and Nevis"
            notes="Previous ISO country name: Saint Kitts-Nevis-Anguilla"/>
        <entry key="Saint Kitts-Nevis-Anguilla" value="KN" fullname="Saint Kitts and Nevis"
            notes="Anguilla now has code AI"/>
        <entry key="KNA" value="KN" fullname="Saint Kitts and Nevis"/>
        <entry key="Democratic People's Republic of Korea" value="KP"
            fullname="Korea (Democratic People's Republic of)"
            notes="ISO country name follows UN designation (common name: North Korea)"/>
        <entry key="DPRK" value="KP" fullname="Korea (Democratic People's Republic of)"
            notes="ISO country name follows UN designation (common name: North Korea)"/>
        <entry key="Korea (Democratic People's Republic of)" value="KP"
            fullname="Korea (Democratic People's Republic of)"
            notes="ISO country name follows UN designation (common name: North Korea)"/>
        <entry key="Korea (the Democratic People's Republic of)" value="KP"
            fullname="Korea (Democratic People's Republic of)"/>
        <entry key="North Korea" value="KP" fullname="Korea (Democratic People's Republic of)"
            notes="ISO country name follows UN designation (common name: North Korea)"/>
        <entry key="PRK" value="KP" fullname="Korea (Democratic People's Republic of)"/>
        <entry key="Korea, Republic of" value="KR" fullname="Korea, Republic of"
            notes="ISO country name follows UN designation (common name: South Korea)"/>
        <entry key="Republic of Korea" value="KR" fullname="Korea, Republic of"
            notes="ISO country name follows UN designation (common name: South Korea)"/>
        <entry key="ROK" value="KR" fullname="Korea, Republic of"
            notes="ISO country name follows UN designation (common name: South Korea)"/>
        <entry key="South Korea" value="KR" fullname="Korea, Republic of"
            notes="ISO country name follows UN designation (common name: South Korea)"/>
        <entry key="Korea (the Republic of)" value="KR" fullname="Korea, Republic of"/>
        <entry key="KOR" value="KR" fullname="Korea, Republic of"/>
        <entry key="Kuwait" value="KW" fullname="Kuwait"/>
        <entry key="KWT" value="KW" fullname="Kuwait"/>
        <entry key="Cayman Islands" value="KY" fullname="Cayman Islands"/>
        <entry key="Cayman Islands (the)" value="KY" fullname="Cayman Islands"/>
        <entry key="CYM" value="KY" fullname="Cayman Islands"/>
        <entry key="Kazakhstan" value="KZ" fullname="Kazakhstan"
            notes="Previous ISO country name: Kazakstan"/>
        <entry key="Kazakstan" value="KZ" fullname="Kazakhstan" notes="now Kazakhstan"/>
        <entry key="KAZ" value="KZ" fullname="Kazakhstan"/>
        <entry key="Lao People's Democratic Republic" value="LA"
            fullname="Lao People's Democratic Republic"
            notes="ISO country name follows UN designation (common name and previous ISO country name: Laos)"/>
        <entry key="Laos" value="LA" fullname="Lao People's Democratic Republic"/>
        <entry key="Lao People's Democratic Republic (the)" value="LA"
            fullname="Lao People's Democratic Republic"/>
        <entry key="LAO" value="LA" fullname="Lao People's Democratic Republic"/>
        <entry key="Lebanon" value="LB" fullname="Lebanon"/>
        <entry key="LBN" value="LB" fullname="Lebanon"/>
        <entry key="Saint Lucia" value="LC" fullname="Saint Lucia"/>
        <entry key="LCA" value="LC" fullname="Saint Lucia"/>
        <entry key="Liechtenstein" value="LI" fullname="Liechtenstein"/>
        <entry key="LIE" value="LI" fullname="Liechtenstein"/>
        <entry key="Sri Lanka" value="LK" fullname="Sri Lanka"/>
        <entry key="LKA" value="LK" fullname="Sri Lanka"/>
        <entry key="Liberia" value="LR" fullname="Liberia"/>
        <entry key="LBR" value="LR" fullname="Liberia"/>
        <entry key="Lesotho" value="LS" fullname="Lesotho"/>
        <entry key="LSO" value="LS" fullname="Lesotho"/>
        <entry key="Lithuania" value="LT" fullname="Lithuania"
            notes="LT formerly reserved indeterminately for Libya Tripoli"/>
        <entry key="LTU" value="LT" fullname="Lithuania"/>
        <entry key="Luxembourg" value="LU" fullname="Luxembourg"/>
        <entry key="LUX" value="LU" fullname="Luxembourg"/>
        <entry key="Latvia" value="LV" fullname="Latvia"/>
        <entry key="LVA" value="LV" fullname="Latvia"/>
        <entry key="Libya" value="LY" fullname="Libya"
            notes="Previous ISO country name: Libyan Arab Jamahiriya"/>
        <entry key="Libyan Arab Jamahiriya" value="LY" fullname="Libya"/>
        <entry key="LBY" value="LY" fullname="Libya"/>
        <entry key="Morocco" value="MA" fullname="Morocco"
            notes="Code taken from name in French: Maroc"/>
        <entry key="MAR" value="MA" fullname="Morocco"/>
        <entry key="Monaco" value="MC" fullname="Monaco"/>
        <entry key="MCO" value="MC" fullname="Monaco"/>
        <entry key="Moldova" value="MD" fullname="Moldova, Republic of"/>
        <entry key="Moldova, Republic of" value="MD" fullname="Moldova, Republic of"
            notes="Previous ISO country name: Moldova (briefly from 2008 to 2009)"/>
        <entry key="Moldova (the Republic of)" value="MD" fullname="Moldova, Republic of"/>
        <entry key="MDA" value="MD" fullname="Moldova, Republic of"/>
        <entry key="Montenegro" value="ME" fullname="Montenegro"
            notes="ME formerly reserved indeterminately for Western Sahara"/>
        <entry key="MNE" value="ME" fullname="Montenegro"/>
        <entry key="French Saint Martin" value="MF" fullname="Saint Martin (French part)"/>
        <entry key="Saint Martin (French part)" value="MF" fullname="Saint Martin (French part)"
            notes="The Dutch part of Saint Martin island is assigned code SX"/>
        <entry key="MAF" value="MF" fullname="Saint Martin (French part)"/>
        <entry key="Madagascar" value="MG" fullname="Madagascar"/>
        <entry key="MDG" value="MG" fullname="Madagascar"/>
        <entry key="Marshall Islands" value="MH" fullname="Marshall Islands"/>
        <entry key="Marshall Islands (the)" value="MH" fullname="Marshall Islands"/>
        <entry key="MHL" value="MH" fullname="Marshall Islands"/>
        <entry key="Macedonia" value="MK" fullname="North Macedonia"/>
        <entry key="North Macedonia" value="MK" fullname="North Macedonia"
            notes="Code taken from name in Macedonian: Severna Makedonija.  Previous ISO country name: Macedonia, the former Yugoslav Republic of (designated as such due to Macedonia naming dispute)"/>
        <entry key="Republic of North Macedonia" value="MK" fullname="North Macedonia"/>
        <entry key="MKD" value="MK" fullname="North Macedonia"/>
        <entry key="Mali" value="ML" fullname="Mali"/>
        <entry key="MLI" value="ML" fullname="Mali"/>
        <entry key="Burma" value="MM" fullname="Myanmar" notes="now Myanmar"/>
        <entry key="Myanmar" value="MM" fullname="Myanmar" notes="Name changed from Burma (BU)"/>
        <entry key="MMR" value="MM" fullname="Myanmar"/>
        <entry key="Mongolia" value="MN" fullname="Mongolia"/>
        <entry key="MNG" value="MN" fullname="Mongolia"/>
        <entry key="Macao" value="MO" fullname="Macao"
            notes="Previous ISO country name: Macau; Macao is officially a Special Administrative Region of the People's Republic of China since 20 December 1999"/>
        <entry key="Macau" value="MO" fullname="Macao"
            notes="Previous ISO country name: Macau; Macao is officially a Special Administrative Region of the People's Republic of China since 20 December 2000"/>
        <entry key="MAC" value="MO" fullname="Macao"/>
        <entry key="Mariana Islands" value="MP" fullname="Northern Mariana Islands"/>
        <entry key="Northern Mariana Islands" value="MP" fullname="Northern Mariana Islands"/>
        <entry key="Northern Mariana Islands (the)" value="MP" fullname="Northern Mariana Islands"/>
        <entry key="MNP" value="MP" fullname="Northern Mariana Islands"/>
        <entry key="Martinique" value="MQ" fullname="Martinique"/>
        <entry key="MTQ" value="MQ" fullname="Martinique"/>
        <entry key="Mauritania" value="MR" fullname="Mauritania"/>
        <entry key="MRT" value="MR" fullname="Mauritania"/>
        <entry key="Montserrat" value="MS" fullname="Montserrat"/>
        <entry key="MSR" value="MS" fullname="Montserrat"/>
        <entry key="Malta" value="MT" fullname="Malta"/>
        <entry key="MLT" value="MT" fullname="Malta"/>
        <entry key="Mauritius" value="MU" fullname="Mauritius"/>
        <entry key="MUS" value="MU" fullname="Mauritius"/>
        <entry key="Maldives" value="MV" fullname="Maldives"/>
        <entry key="MDV" value="MV" fullname="Maldives"/>
        <entry key="Malawi" value="MW" fullname="Malawi"/>
        <entry key="MWI" value="MW" fullname="Malawi"/>
        <entry key="Mexico" value="MX" fullname="Mexico"/>
        <entry key="MEX" value="MX" fullname="Mexico"/>
        <entry key="Malaysia" value="MY" fullname="Malaysia"/>
        <entry key="MYS" value="MY" fullname="Malaysia"/>
        <entry key="Mozambique" value="MZ" fullname="Mozambique"/>
        <entry key="MOZ" value="MZ" fullname="Mozambique"/>
        <entry key="Namibia" value="NA" fullname="Namibia"/>
        <entry key="NAM" value="NA" fullname="Namibia"/>
        <entry key="New Caledonia" value="NC" fullname="New Caledonia"/>
        <entry key="NCL" value="NC" fullname="New Caledonia"/>
        <entry key="Niger" value="NE" fullname="Niger"/>
        <entry key="Niger (the)" value="NE" fullname="Niger"/>
        <entry key="NER" value="NE" fullname="Niger"/>
        <entry key="Norfolk Island" value="NF" fullname="Norfolk Island"
            notes="External territory of Australia"/>
        <entry key="NFK" value="NF" fullname="Norfolk Island"/>
        <entry key="Nigeria" value="NG" fullname="Nigeria"/>
        <entry key="NGA" value="NG" fullname="Nigeria"/>
        <entry key="Nicaragua" value="NI" fullname="Nicaragua"/>
        <entry key="NIC" value="NI" fullname="Nicaragua"/>
        <entry key="Kingdom of the Netherlands" value="NL" fullname="Netherlands, Kingdom of the"/>
        <entry key="Netherlands" value="NL" fullname="Netherlands, Kingdom of the"/>
        <entry key="Netherlands, Kingdom of the" value="NL" fullname="Netherlands, Kingdom of the"
            notes="Officially includes the islands Bonaire, Saint Eustatius and Saba, which also have code BQ in ISO 3166-1. Within ISO 3166-2, Aruba (AW), Curaçao (CW), and Sint Maarten (SX) are also coded as subdivisions of NL. Previous ISO country name: Netherlands"/>
        <entry key="Netherlands (the)" value="NL" fullname="Netherlands, Kingdom of the"/>
        <entry key="NLD" value="NL" fullname="Netherlands, Kingdom of the"/>
        <entry key="Norway" value="NO" fullname="Norway"/>
        <entry key="NOR" value="NO" fullname="Norway"/>
        <entry key="Nepal" value="NP" fullname="Nepal"/>
        <entry key="NPL" value="NP" fullname="Nepal"/>
        <entry key="Nauru" value="NR" fullname="Nauru"/>
        <entry key="NRU" value="NR" fullname="Nauru"/>
        <entry key="Niue" value="NU" fullname="Niue" notes="Previous ISO country name: Niue Island"/>
        <entry key="Niue Island" value="NU" fullname="Niue"/>
        <entry key="NIU" value="NU" fullname="Niue"/>
        <entry key="New Zealand" value="NZ" fullname="New Zealand"/>
        <entry key="NZL" value="NZ" fullname="New Zealand"/>
        <entry key="Oman" value="OM" fullname="Oman"/>
        <entry key="OMN" value="OM" fullname="Oman"/>
        <entry key="Panama" value="PA" fullname="Panama"/>
        <entry key="PAN" value="PA" fullname="Panama"/>
        <entry key="Peru" value="PE" fullname="Peru"/>
        <entry key="PER" value="PE" fullname="Peru"/>
        <entry key="French Polynesia" value="PF" fullname="French Polynesia"
            notes="Code taken from name in French: Polynésie française"/>
        <entry key="PYF" value="PF" fullname="French Polynesia"/>
        <entry key="Papua New Guinea" value="PG" fullname="Papua New Guinea"/>
        <entry key="PNG" value="PG" fullname="Papua New Guinea"/>
        <entry key="Philippines" value="PH" fullname="Philippines"/>
        <entry key="Philippines (the)" value="PH" fullname="Philippines"/>
        <entry key="PHL" value="PH" fullname="Philippines"/>
        <entry key="Pakistan" value="PK" fullname="Pakistan"/>
        <entry key="PAK" value="PK" fullname="Pakistan"/>
        <entry key="Poland" value="PL" fullname="Poland"/>
        <entry key="POL" value="PL" fullname="Poland"/>
        <entry key="Saint Pierre and Miquelon" value="PM" fullname="Saint Pierre and Miquelon"/>
        <entry key="SPM" value="PM" fullname="Saint Pierre and Miquelon"/>
        <entry key="Pitcairn" value="PN" fullname="Pitcairn"
            notes="Previous ISO country name: Pitcairn Islands"/>
        <entry key="Pitcairn Islands" value="PN" fullname="Pitcairn"/>
        <entry key="PCN" value="PN" fullname="Pitcairn"/>
        <entry key="Puerto Rico" value="PR" fullname="Puerto Rico"/>
        <entry key="PRI" value="PR" fullname="Puerto Rico"/>
        <entry key="Palestine, State of" value="PS" fullname="Palestine, State of"
            notes="Previous ISO country name: Palestinian Territory, Occupied.  Consists of the West Bank and the Gaza Strip"/>
        <entry key="Palestine, State of" value="PS" fullname="Palestine, State of"/>
        <entry key="Palestinian Territory" value="PS" fullname="Palestine, State of"/>
        <entry key="PSE" value="PS" fullname="Palestine, State of"/>
        <entry key="Portugal" value="PT" fullname="Portugal"/>
        <entry key="PRT" value="PT" fullname="Portugal"/>
        <entry key="Palau" value="PW" fullname="Palau"/>
        <entry key="PLW" value="PW" fullname="Palau"/>
        <entry key="Paraguay" value="PY" fullname="Paraguay"/>
        <entry key="PRY" value="PY" fullname="Paraguay"/>
        <entry key="Qatar" value="QA" fullname="Qatar"/>
        <entry key="QAT" value="QA" fullname="Qatar"/>
        <entry key="Reunion" value="RE" fullname="Réunion"/>
        <entry key="Réunion" value="RE" fullname="Réunion"/>
        <entry key="REU" value="RE" fullname="Réunion"/>
        <entry key="Romania" value="RO" fullname="Romania"/>
        <entry key="ROU" value="RO" fullname="Romania"/>
        <entry key="Serbia" value="RS" fullname="Serbia" notes="Republic of Serbia"/>
        <entry key="SRB" value="RS" fullname="Serbia"/>
        <entry key="Russia" value="RU" fullname="Russian Federation"/>
        <entry key="Russian Federation" value="RU" fullname="Russian Federation"
            notes="ISO country name follows UN designation (common name: Russia); RU formerly reserved indeterminately for Burundi"/>
        <entry key="Russian Federation (the)" value="RU" fullname="Russian Federation"/>
        <entry key="RUS" value="RU" fullname="Russian Federation"/>
        <entry key="Rwanda" value="RW" fullname="Rwanda"/>
        <entry key="RWA" value="RW" fullname="Rwanda"/>
        <entry key="Saudi Arabia" value="SA" fullname="Saudi Arabia"/>
        <entry key="SAU" value="SA" fullname="Saudi Arabia"/>
        <entry key="British Solomon Islands" value="SB" fullname="Solomon Islands"/>
        <entry key="Solomon Islands" value="SB" fullname="Solomon Islands"
            notes="Code taken from former name: British Solomon Islands"/>
        <entry key="SLB" value="SB" fullname="Solomon Islands"/>
        <entry key="Seychelles" value="SC" fullname="Seychelles"/>
        <entry key="SYC" value="SC" fullname="Seychelles"/>
        <entry key="Sudan" value="SD" fullname="Sudan"/>
        <entry key="Sudan (the)" value="SD" fullname="Sudan"/>
        <entry key="SDN" value="SD" fullname="Sudan"/>
        <entry key="Sweden" value="SE" fullname="Sweden"/>
        <entry key="SWE" value="SE" fullname="Sweden"/>
        <entry key="Singapore" value="SG" fullname="Singapore"/>
        <entry key="SGP" value="SG" fullname="Singapore"/>
        <entry key="Ascension" value="SH" fullname="Saint Helena, Ascension and Tristan da Cunha"/>
        <entry key="Saint Helena" value="SH" fullname="Saint Helena, Ascension and Tristan da Cunha"/>
        <entry key="Saint Helena, Ascension and Tristan da Cunha" value="SH"
            fullname="Saint Helena, Ascension and Tristan da Cunha"
            notes="Previous ISO country name: Saint Helena."/>
        <entry key="Tristan da Cunha" value="SH"
            fullname="Saint Helena, Ascension and Tristan da Cunha"/>
        <entry key="SHN" value="SH" fullname="Saint Helena, Ascension and Tristan da Cunha"/>
        <entry key="Slovenia" value="SI" fullname="Slovenia"/>
        <entry key="SVN" value="SI" fullname="Slovenia"/>
        <entry key="Jan Mayen" value="SJ" fullname="Svalbard and Jan Mayen"/>
        <entry key="Svalbard" value="SJ" fullname="Svalbard and Jan Mayen"/>
        <entry key="Svalbard and Jan Mayen" value="SJ" fullname="Svalbard and Jan Mayen"
            notes="Previous ISO name: Svalbard and Jan Mayen Islands. Consists of two Arctic territories of Norway: Svalbard and Jan Mayen"/>
        <entry key="Svalbard and Jan Mayen Islands" value="SJ" fullname="Svalbard and Jan Mayen"/>
        <entry key="SJM" value="SJ" fullname="Svalbard and Jan Mayen"/>
        <entry key="Slovakia" value="SK" fullname="Slovakia"
            notes="SK previously represented the Kingdom of Sikkim"/>
        <entry key="SVK" value="SK" fullname="Slovakia"/>
        <entry key="Sierra Leone" value="SL" fullname="Sierra Leone"/>
        <entry key="SLE" value="SL" fullname="Sierra Leone"/>
        <entry key="San Marino" value="SM" fullname="San Marino"/>
        <entry key="SMR" value="SM" fullname="San Marino"/>
        <entry key="Senegal" value="SN" fullname="Senegal"/>
        <entry key="SEN" value="SN" fullname="Senegal"/>
        <entry key="Somalia" value="SO" fullname="Somalia"/>
        <entry key="SOM" value="SO" fullname="Somalia"/>
        <entry key="Surinam" value="SR" fullname="Suriname"/>
        <entry key="Suriname" value="SR" fullname="Suriname"
            notes="Previous ISO country name: Surinam"/>
        <entry key="SUR" value="SR" fullname="Suriname"/>
        <entry key="South Sudan" value="SS" fullname="South Sudan"/>
        <entry key="SSD" value="SS" fullname="South Sudan"/>
        <entry key="Sao Tome and Principe" value="ST" fullname="Sao Tome and Principe"/>
        <entry key="STP" value="ST" fullname="Sao Tome and Principe"/>
        <entry key="El Salvador" value="SV" fullname="El Salvador"/>
        <entry key="SLV" value="SV" fullname="El Salvador"/>
        <entry key="Dutch Saint Martin" value="SX" fullname="Sint Maarten (Dutch part)"
            notes="The French part of Saint Martin island is assigned code MF"/>
        <entry key="Dutch Sint Maarten" value="SX" fullname="Sint Maarten (Dutch part)"
            notes="The French part of Saint Martin island is assigned code MF"/>
        <entry key="Sint Maarten" value="SX" fullname="Sint Maarten (Dutch part)"
            notes="The French part of Saint Martin island is assigned code MF"/>
        <entry key="Sint Maarten (Dutch part)" value="SX" fullname="Sint Maarten (Dutch part)"
            notes="The French part of Saint Martin island is assigned code MF"/>
        <entry key="SXM" value="SX" fullname="Sint Maarten (Dutch part)"/>
        <entry key="Syria" value="SY" fullname="Syrian Arab Republic"/>
        <entry key="Syrian Arab Republic" value="SY" fullname="Syrian Arab Republic"
            notes="ISO country name follows UN designation (common name and previous ISO country name: Syria)"/>
        <entry key="SYR" value="SY" fullname="Syrian Arab Republic"/>
        <entry key="Eswatini" value="SZ" fullname="Eswatini"
            notes="Previous ISO country name: Swaziland"/>
        <entry key="Swaziland" value="SZ" fullname="Eswatini" notes="now Eswatini"/>
        <entry key="SWZ" value="SZ" fullname="Eswatini"/>
        <entry key="Caicos Islands" value="TC" fullname="Turks and Caicos Islands"/>
        <entry key="Turks and Caicos Islands" value="TC" fullname="Turks and Caicos Islands"/>
        <entry key="Turks and Caicos Islands (the)" value="TC" fullname="Turks and Caicos Islands"/>
        <entry key="Turks Islands" value="TC" fullname="Turks and Caicos Islands"/>
        <entry key="TCA" value="TC" fullname="Turks and Caicos Islands"/>
        <entry key="Chad" value="TD" fullname="Chad" notes="Code taken from name in French: Tchad"/>
        <entry key="TCD" value="TD" fullname="Chad"/>
        <entry key="French Southern Territories" value="TF" fullname="French Southern Territories"
            notes="Covers the French Southern and Antarctic Lands except Adélie Land. Code taken from name in French: Terres australes françaises"/>
        <entry key="French Southern Territories (the)" value="TF"
            fullname="French Southern Territories"/>
        <entry key="ATF" value="TF" fullname="French Southern Territories"/>
        <entry key="Togo" value="TG" fullname="Togo"/>
        <entry key="TGO" value="TG" fullname="Togo"/>
        <entry key="Thailand" value="TH" fullname="Thailand"/>
        <entry key="THA" value="TH" fullname="Thailand"/>
        <entry key="Tajikistan" value="TJ" fullname="Tajikistan"/>
        <entry key="TJK" value="TJ" fullname="Tajikistan"/>
        <entry key="Tokelau" value="TK" fullname="Tokelau"
            notes="Previous ISO country name: Tokelau Islands"/>
        <entry key="Tokelau Islands" value="TK" fullname="Tokelau"/>
        <entry key="TKL" value="TK" fullname="Tokelau"/>
        <entry key="East Timor" value="TL" fullname="Timor-Leste"/>
        <entry key="Timor-Leste" value="TL" fullname="Timor-Leste"
            notes="Name changed from East Timor (TP)"/>
        <entry key="TLS" value="TL" fullname="Timor-Leste"/>
        <entry key="Turkmenistan" value="TM" fullname="Turkmenistan"/>
        <entry key="TKM" value="TM" fullname="Turkmenistan"/>
        <entry key="Tunisia" value="TN" fullname="Tunisia"/>
        <entry key="TUN" value="TN" fullname="Tunisia"/>
        <entry key="Tonga" value="TO" fullname="Tonga"/>
        <entry key="TON" value="TO" fullname="Tonga"/>
        <entry key="Turkey" value="TR" fullname="Türkiye"/>
        <entry key="Turkiye" value="TR" fullname="Türkiye"/>
        <entry key="Türkiye" value="TR" fullname="Türkiye" notes="Previous ISO country name: Turkey"/>
        <entry key="TUR" value="TR" fullname="Türkiye"/>
        <entry key="Trinidad and Tobago" value="TT" fullname="Trinidad and Tobago"/>
        <entry key="TTO" value="TT" fullname="Trinidad and Tobago"/>
        <entry key="Tuvalu" value="TV" fullname="Tuvalu"/>
        <entry key="TUV" value="TV" fullname="Tuvalu"/>
        <entry key="Taiwan" value="TW" fullname="Taiwan, Province of China"/>
        <entry key="Taiwan, Province of China" value="TW" fullname="Taiwan, Province of China"
            notes="Covers the current jurisdiction of the Republic of China.  ISO country name follows UN designation (due to political status of Taiwan within the UN)  (common name: Taiwan)"/>
        <entry key="Taiwan (Province of China)" value="TW" fullname="Taiwan, Province of China"/>
        <entry key="TWN" value="TW" fullname="Taiwan, Province of China"/>
        <entry key="Tanzania" value="TZ" fullname="Tanzania, United Republic of"/>
        <entry key="Tanzania, United Republic of" value="TZ" fullname="Tanzania, United Republic of"/>
        <entry key="United Republic of Tanzania" value="TZ" fullname="Tanzania, United Republic of"/>
        <entry key="TZA" value="TZ" fullname="Tanzania, United Republic of"/>
        <entry key="Ukraine" value="UA" fullname="Ukraine"
            notes="Previous ISO country name: Ukrainian SSR.  Code assigned as the country was already a UN member since 1945"/>
        <entry key="Ukrainian SSR" value="UA" fullname="Ukraine"/>
        <entry key="UKR" value="UA" fullname="Ukraine"/>
        <entry key="Uganda" value="UG" fullname="Uganda"/>
        <entry key="UGA" value="UG" fullname="Uganda"/>
        <entry key="United States Minor Outlying Islands" value="UM"
            fullname="United States Minor Outlying Islands"
            notes="Consists of nine minor insular areas of the United States: Baker Island, Howland Island, Jarvis Island, Johnston Atoll, Kingman Reef, Midway Islands, Navassa Island, Palmyra Atoll, and Wake Island.  The United States Department of State uses the following user assigned alpha-2 codes for the nine territories, respectively, XB, XH, XQ, XU, XM, QM, XV, XL, and QW.[20]"/>
        <entry key="United States Minor Outlying Islands (the)" value="UM"
            fullname="United States Minor Outlying Islands"/>
        <entry key="UMI" value="UM" fullname="United States Minor Outlying Islands"/>
        <entry key="United States" value="US" fullname="United States of America"/>
        <entry key="United States of America" value="US" fullname="United States of America"
            notes="Previous ISO country name: United States"/>
        <entry key="United States of America (the)" value="US" fullname="United States of America"/>
        <entry key="USA" value="US" fullname="United States of America"/>
        <entry key="USA" value="US" fullname="United States of America"/>
        <entry key="Uruguay" value="UY" fullname="Uruguay"/>
        <entry key="URY" value="UY" fullname="Uruguay"/>
        <entry key="Uzbekistan" value="UZ" fullname="Uzbekistan"/>
        <entry key="UZB" value="UZ" fullname="Uzbekistan"/>
        <entry key="Holy See" value="VA" fullname="Holy See"
            notes="Covers Vatican City, territory of the Holy See.  Previous ISO country names: Vatican City State (Holy See) and Holy See (Vatican City State)"/>
        <entry key="Holy See (the)" value="VA" fullname="Holy See"/>
        <entry key="Vatican City" value="VA" fullname="Holy See"/>
        <entry key="Vatican City State" value="VA" fullname="Holy See"/>
        <entry key="VAT" value="VA" fullname="Holy See"/>
        <entry key="Grenadines" value="VC" fullname="Saint Vincent and the Grenadines"/>
        <entry key="Saint Vincent" value="VC" fullname="Saint Vincent and the Grenadines"/>
        <entry key="Saint Vincent and the Grenadines" value="VC"
            fullname="Saint Vincent and the Grenadines"/>
        <entry key="VCT" value="VC" fullname="Saint Vincent and the Grenadines"/>
        <entry key="Venezuela (Bolivarian Republic of)" value="VE"
            fullname="Venezuela (Bolivarian Republic of)"
            notes="Previous ISO country name: Venezuela"/>
        <entry key="Bolivarian Republic of Venezuela" value="VE"
            fullname="Venezuela (Bolivarian Republic of)"/>
        <entry key="Venezuela" value="VE" fullname="Venezuela (Bolivarian Republic of)"/>
        <entry key="VEN" value="VE" fullname="Venezuela (Bolivarian Republic of)"/>
        <entry key="British Virgin Islands" value="VG" fullname="Virgin Islands (British)"/>
        <entry key="Virgin Islands (British)" value="VG" fullname="Virgin Islands (British)"/>
        <entry key="VGB" value="VG" fullname="Virgin Islands (British)"/>
        <entry key="U.S. Virgin Islands" value="VI" fullname="Virgin Islands (U.S.)"/>
        <entry key="US Virgin Islands" value="VI" fullname="Virgin Islands (U.S.)"/>
        <entry key="Virgin Islands (U.S.)" value="VI" fullname="Virgin Islands (U.S.)"/>
        <entry key="VIR" value="VI" fullname="Virgin Islands (U.S.)"/>
        <entry key="Viet Nam" value="VN" fullname="Viet Nam"
            notes="ISO country name follows UN designation (common name: Vietnam) Code used for Republic of Viet Nam (common name: South Vietnam) before 1977"/>
        <entry key="Vietnam" value="VN" fullname="Viet Nam"/>
        <entry key="VNM" value="VN" fullname="Viet Nam"/>
        <entry key="New Hebrides" value="VU" fullname="Vanuatu"/>
        <entry key="Vanuatu" value="VU" fullname="Vanuatu"
            notes="Name changed from New Hebrides (NH)"/>
        <entry key="VUT" value="VU" fullname="Vanuatu"/>
        <entry key="Futuna Island" value="WF" fullname="Wallis and Futuna"/>
        <entry key="Wallis and Futuna" value="WF" fullname="Wallis and Futuna"
            notes="Previous ISO country name: Wallis and Futuna Islands"/>
        <entry key="Wallis and Futuna Islands" value="WF" fullname="Wallis and Futuna"/>
        <entry key="Wallis Island" value="WF" fullname="Wallis and Futuna"/>
        <entry key="WLF" value="WF" fullname="Wallis and Futuna"/>
        <entry key="Samoa" value="WS" fullname="Samoa"
            notes="Code taken from former name: Western Samoa"/>
        <entry key="Western Samoa" value="WS" fullname="Samoa"/>
        <entry key="WSM" value="WS" fullname="Samoa"/>
        <entry key="Yemen" value="YE" fullname="Yemen"
            notes="Previous ISO country name: Yemen, Republic of (for three years after the unification)"/>
        <entry key="YEM" value="YE" fullname="Yemen"/>
        <entry key="Mayotte" value="YT" fullname="Mayotte"/>
        <entry key="MYT" value="YT" fullname="Mayotte"/>
        <entry key="South Africa" value="ZA" fullname="South Africa"
            notes="Code taken from name in Dutch: Zuid-Afrika"/>
        <entry key="ZAF" value="ZA" fullname="South Africa"/>
        <entry key="Zambia" value="ZM" fullname="Zambia"/>
        <entry key="ZMB" value="ZM" fullname="Zambia"/>
        <entry key="Southern Rhodesia" value="ZW" fullname="Zimbabwe" notes="now Zimbabwe"/>
        <entry key="Zimbabwe" value="ZW" fullname="Zimbabwe"
            notes="Name changed from Southern Rhodesia (RH)"/>
        <entry key="ZWE" value="ZW" fullname="Zimbabwe"/>



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
                    <xsl:value-of select="concat(string($inputTime), ':00')"/>
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
