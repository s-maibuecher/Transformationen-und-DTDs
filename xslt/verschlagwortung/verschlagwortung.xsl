<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- TO-DO: Autorennamen aus Standpunkten sollen ebenfalls ins Autorenverzeichnis-->

    <xsl:output indent="yes" encoding="UTF-8"  method="xml"/>
    
    <!-- Stylesheet, um die Keywords von einzelnen Artikeln zu sammeln und in Registerform darzustellen -->

    <!-- XPath Ausdruck, um maximale Keyword-Tiefe zu berechnen: max(//keyword/count(ancestor-or-self::keyword)) -->
    
    <!-- XPath Ausdruck, um Keywords zu finden, die Blätter sind: //keyword[not(child::*)] -->
    
    <!-- XPath Ausdruck, um Knoten zu vergleichen. Vergleicht nur auf String Gleichheit //A[.= following-sibling::A]
        bzw. //A[some $sibling in following-sibling::A satisfies deep-equal(. ,$sibling)]
    -->
    
    <!-- FÜR DAS WuW AUTORENREGISTER:
    
    <h2>Abhandlungen</h2>
    [ressort/text()='Abhandlung']
    
    <h2>Gastkommentare</h2>
    /gk
    
    <h2>Urteilsanmerkungen</h2>
    /ent
    
    <h2>Ökonomisches Lexikon</h2>
    [ressort/text()='Ökonomisches Lexikon']
    
    <h2>Tagungsbericht</h2>
    [ressort/text()='Tagungsbericht']
    
    <h2>International Developments</h2>
    HIER HABE ICH BISHER NICHTS, WEIL KEINE AUTORENDATEN IN DIESEN DOKUMENTEN
    
    <h2>Literatur</h2>
    HIER HABE ICH BISHER NICHTS, WEIL KEINE AUTORENDATEN IN DIESEN DOKUMENTEN
    
    <h2>Interview</h2>
    /iv
    
    -->

    <xsl:template match="/">
        <xsl:variable name="file-collection" select="collection('file:/c:/verschlagwortung/?recurse=yes;select=*.xml')"/>
        <Register>
            <xsl:apply-templates select="$file-collection/*/metadata[not(starts-with(pub/pages/start_page/text(), 'M'))]/keywords/keyword[@tmid]">
                <xsl:sort/>
            </xsl:apply-templates>
            <xsl:apply-templates select="$file-collection/*/metadata/authors/author"><!-- Autorenverzeichnis -->
                <xsl:sort/>
            </xsl:apply-templates>
        </Register>
    </xsl:template>
    
    <xsl:template match="author">
        <!-- Keine Mantelseiten mit ins Register nehmen:-->
        <xsl:variable name="isDB" select="ancestor::metadata/pub/pubtitle = 'Der Betrieb'"/>
        
        <xsl:if test="not(string(number(normalize-space(ancestor::metadata/pub/pages/start_page))) = 'NaN')">
            <autoren-zeile>
                <autor><xsl:value-of select="surname"/><xsl:text>, </xsl:text><xsl:value-of select="firstname"/></autor>
                <title><xsl:value-of select="../../title"/></title>
                <abkuerzung>
                    <xsl:choose>
                        <xsl:when test="$isDB and /*/name()='kk'"> (K)</xsl:when>
                        <xsl:when test="$isDB and /*/name()='au'"> (A)</xsl:when>
                        <xsl:when test="$isDB and /*/name()='va'"> (Anm.)</xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </abkuerzung>
                <xsl:comment><xsl:if test="ancestor::metadata/pub/pub_suppl"><xsl:text>Beilage </xsl:text><xsl:value-of select="ancestor::metadata/pub/pub_suppl"/><!--<xsl:text>|</xsl:text>--></xsl:if><xsl:if test="not(ancestor::metadata/pub/pub_suppl)"><xsl:value-of select="../../pub/pages/start_page"/></xsl:if></xsl:comment>
            </autoren-zeile>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="keywords/keyword[@tmid]">
        <xsl:variable name="isDBorDK" select="ancestor::metadata/pub/pubtitle = ('Der Betrieb', 'Der Konzern')"/>
        <xsl:choose>
            <xsl:when test=".[not(child::*)]"> <!-- wenn es sich um ein Blatt handelt -->
                <xsl:variable name="isMantelseite" select="starts-with(./ancestor::metadata/pub/pages/start_page/text(), 'M')"/>
                <xsl:variable name="kuerzel">
                    <xsl:choose>
                        <xsl:when test="$isMantelseite"><xsl:text> MANTELSEITE!</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'au'"><xsl:text> (A)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'kk'"><xsl:text> (K)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'va'"><xsl:text> (V)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = ('ent', 'entk')"><xsl:text> (E)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'nr' and ancestor::metadata/ressort/text() = 'bw'"><xsl:text> (R)</xsl:text></xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:variable name="seitenzahl" select="./../../pub/pages/start_page"/>
                <xsl:variable name="beilagen_prefix">
                    <xsl:choose>
                        <xsl:when test="ancestor::metadata/pub/pub_suppl">
                            <xsl:text>Beilage </xsl:text><xsl:value-of select="ancestor::metadata/pub/pub_suppl"/><xsl:text> S.</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text></xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <reg-zeile>
                    <hauptebene><xsl:value-of select="replace(text(),'\n','')"/></hauptebene>
                    <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                    <xsl:comment><xsl:value-of select="concat($beilagen_prefix, $seitenzahl, $kuerzel)"/></xsl:comment>
                </reg-zeile>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="keyword[@tmid]">
                    <xsl:sort/>
                    <xsl:with-param name="ersteEbene" select="replace(text()[1],'\n','')"/>
                    <xsl:with-param name="isDBorDK" select="$isDBorDK"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    
    </xsl:template>

    <xsl:template match="keywords/keyword/keyword[@tmid]">
        <xsl:param name="ersteEbene"/>
        <xsl:param name="isDBorDK"/>
        <xsl:variable name="seitenzahl" select="./../../../pub/pages/start_page/text()"/>
        <xsl:choose>
            <xsl:when test=".[not(child::*)]"> <!-- wenn es sich um ein Blatt handelt -->
                <xsl:variable name="isMantelseite" select="starts-with(./ancestor::metadata/pub/pages/start_page/text(), 'M')"/>
                <xsl:variable name="kuerzel">
                    <xsl:choose>
                        <xsl:when test="$isMantelseite"><xsl:text> MANTELSEITE!</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'au'"><xsl:text> (A)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'kk'"><xsl:text> (K)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'va'"><xsl:text> (V)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = ('ent', 'entk')"><xsl:text> (E)</xsl:text></xsl:when>
                        <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'nr' and ancestor::metadata/ressort/text() = 'bw'"><xsl:text> (R)</xsl:text></xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <xsl:variable name="seitenzahl" select="./../../../pub/pages/start_page/text()"/>
                
                <xsl:variable name="beilagen_prefix">
                    <xsl:choose>
                        <xsl:when test="ancestor::metadata/pub/pub_suppl">
                            <xsl:text>Beilage </xsl:text><xsl:value-of select="ancestor::metadata/pub/pub_suppl"/><xsl:text> S.</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text></xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                
                <reg-zeile>
                    <hauptebene><xsl:value-of select="$ersteEbene"/></hauptebene>
                    <zweite-ebene><xsl:value-of select="replace(text(),'\n','')"/></zweite-ebene>
                    <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                    <xsl:comment><xsl:value-of select="concat($beilagen_prefix, $seitenzahl, $kuerzel)"/></xsl:comment>
                </reg-zeile>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="keyword[@tmid]">
                    <xsl:sort/>
                    <xsl:with-param name="ersteEbene" select="$ersteEbene"/>
                    <xsl:with-param name="zweiteEbene" select="replace(text()[1],'\n','')"/>
                    <xsl:with-param name="isDBorDK" select="$isDBorDK"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
    <xsl:template match="keywords/keyword/keyword/keyword[@tmid]">
        <xsl:param name="ersteEbene"/>
        <xsl:param name="zweiteEbene"/>
        <xsl:param name="isDBorDK"/>
        <xsl:variable name="seitenzahl" select="./../../../../pub/pages/start_page/text()"/>
        <xsl:variable name="isMantelseite" select="starts-with(./ancestor::metadata/pub/pages/start_page/text(), 'M')"/>
        <xsl:variable name="kuerzel">
            <xsl:choose>
                <xsl:when test="$isMantelseite"><xsl:text> MANTELSEITE!</xsl:text></xsl:when>
                <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'au'"><xsl:text> (A)</xsl:text></xsl:when>
                <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'kk'"><xsl:text> (K)</xsl:text></xsl:when>
                <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'va'"><xsl:text> (V)</xsl:text></xsl:when>
                <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = ('ent', 'entk')"><xsl:text> (E)</xsl:text></xsl:when>
                <xsl:when test="$isDBorDK and ./ancestor::metadata/parent::*/name() = 'nr' and ancestor::metadata/ressort/text() = 'bw'"><xsl:text> (R)</xsl:text></xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
            <reg-zeile>
                <hauptebene><xsl:value-of select="$ersteEbene"/></hauptebene>
                <zweite-ebene><xsl:value-of select="$zweiteEbene"/></zweite-ebene>
                <dritte-ebene><xsl:value-of select="replace(text(),'\n','')"/></dritte-ebene>
                <xsl:variable name="beilagen_prefix">
                    <xsl:choose>
                        <xsl:when test="ancestor::metadata/pub/pub_suppl">
                            <xsl:text>Beilage </xsl:text><xsl:value-of select="ancestor::metadata/pub/pub_suppl"/><xsl:text> S.</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text></xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!--<fundstelle><xsl:value-of select="$seitenzahl"/></fundstelle>-->
                <xsl:comment><xsl:value-of select="concat($beilagen_prefix, $seitenzahl, $kuerzel)"/></xsl:comment>
            </reg-zeile>
    </xsl:template>

</xsl:stylesheet>
