<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>

    <xsl:variable name="aktuelles-Heft" select="collection('file:/c:/tempWuW/?recurse=yes;select=*.xml')"/>

    <xsl:template match="/">
            <html>
                <head>
                    <meta charset="UTF-8"/>
                </head>

                <body>
                    <div class="content-wrapper">
                        <h1 class="pagehead small">Inhaltsverzeichnis</h1>
                        <div>Sie suchen das Inhaltsverzeichnis einer älteren Ausgabe von WIRTSCHAFT UND WETTBEWERB? Die Übersicht aller in der Datenbank verfügbaren Ausgaben finden Sie in der <a href="https://wuw-online.owlit.de/Browse.aspx?level=roex%3abron.Zeitschriften.d4d652b1019840bfac5d28ebd0ec6c9f&amp;title=Wirtschaft%2bund%2bWettbewerb" target="_blank">Bibliothek der Recherche-Datenbank.</a></div>
                        <!-- Linke Spalte -->
                        <section class="left" id="content" style="width:630px">
                            <div class="content-list inhaltsverzeichnis">
                                <div class="content-text">
                                    <div class="ihv_level1">
                                        <div class="ihv_headline">Inhaltsverzeichnis</div>
                                        <div class="ihv_heftnr">
                                            <xsl:for-each select="$aktuelles-Heft[position()=1]">
                                                <xsl:value-of select="/*/metadata/pub/pubedition"/>
                                            </xsl:for-each>
                                        </div>
                                        <div class="ihv_datum">
                                            <xsl:for-each select="$aktuelles-Heft[position()=1]">
                                                <xsl:value-of select="format-date(/*/metadata/pub/date, '[D].[M].[Y]')" />
                                            </xsl:for-each>
                                        </div>
                                        <!--  style="border-bottom:#ee7000" -->
                                                
                                        <div class="ihv_level2"> 
                                        <xsl:if test="$aktuelles-Heft//gk">
                                            <div id="gk" class="ihv_headline ressort">Gastkommentar</div>
                                        </xsl:if>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                           
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- KOMMENTAR -->
                                            
                                            <xsl:if test="gk">
                                                <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                <div class="ihv_headline titel">
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </div>
                                                <div class="ihv_autor">
                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                        <xsl:choose>
                                                            <xsl:when test="position()=1">
                                                                <xsl:value-of select="prefix"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="firstname"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                            </xsl:when>
                                                            <xsl:when test="position()=last()">
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:value-of select="prefix"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="firstname"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:value-of select="prefix"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="firstname"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </div>
                                              <div class="ihv_seite">
                                                  <xsl:choose>
                                                      <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                          <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                          <xsl:value-of select="$siriusID"/>
                                                      </xsl:when>
                                                      <xsl:otherwise>
                                                          <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                          <xsl:value-of select="$siriusID"/>
                                                      </xsl:otherwise>
                                                  </xsl:choose>
                                              </div>
                                              </a>
                                            </xsl:if>
                                        </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="ihv_level2">                                            
                                            <xsl:if test="$aktuelles-Heft//ressort[text()='Abhandlung']">
                                                    <div id="abh" class="ihv_headline ressort">Abhandlungen</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                           
                                            <!-- ABHANDLUNGEN -->
                                            
                                     <!--       <xsl:if test="$ressortbez='Abhandlung'">   -->
                                            <xsl:if test="($ressortbez='Abhandlung')">
                                                <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                <div class="ihv_headline titel">
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </div>
                                                <div class="ihv_autor">
                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                        <xsl:choose>
                                                            <xsl:when test="position()=1">
                                                                <xsl:value-of select="prefix"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="firstname"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                            </xsl:when>
                                                            <xsl:when test="position()=last()">
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:value-of select="prefix"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="firstname"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:value-of select="prefix"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="firstname"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </div>
                                                    <div class="ihv_abstract">
                                                        <p><xsl:value-of select="/*/metadata/summary/p[not(@lang='en')]"/></p>
                                                    </div>
                                                    <div class="ihv_seite" >
                                                        <xsl:choose>
                                                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                               </a>
                                            </xsl:if>
                                             </xsl:for-each>
                                                 
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- LElXIKON -->                                        
                                        
                                        <div class="ihv_level2">                                            
                                            <xsl:if test="$aktuelles-Heft//ressort[text()='Ökonomisches Lexikon']">
                                                <div class="ihv_headline ressort">Ökonomisches Lexikon</div>
                                            </xsl:if>
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        
                                                        <xsl:variable name="docum"
                                                            select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez"
                                                            select="$docum/*/metadata/ressort"/>
                                                        
                                                        <!-- Ökonomisches Lexikon -->
                                                        
                                                        <xsl:if test="($ressortbez='Ökonomisches Lexikon')">
                                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                                <div class="ihv_headline titel">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </div>
                                                                <div class="ihv_autor">
                                                                    <xsl:for-each select="/*/metadata/authors/author">
                                                                        <xsl:choose>
                                                                            <xsl:when test="position()=1">
                                                                                <xsl:value-of select="prefix"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="firstname"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                                            </xsl:when>
                                                                            <xsl:when test="position()=last()">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="prefix"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="firstname"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="prefix"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="firstname"/>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="replace(surname, ' ', '')"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:for-each>
                                                                </div>
                                                                <div class="ihv_abstract">
                                                                    <p><xsl:value-of select="/*/metadata/summary/p[not(@lang='en')]"/></p>
                                                                </div>
                                                                <div class="ihv_seite" >
                                                                    <xsl:choose>
                                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                            <xsl:value-of select="$siriusID"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                            <xsl:value-of select="$siriusID"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </a>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                   
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- LITERATUR -->
                                        
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//rez">
                                                <div class="ihv_headline ressort">Literatur</div>
                                            </xsl:if>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    
                                                    <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                                    <xsl:for-each select="$aktuelles-Heft">
                                                        
                                                        <xsl:variable name="docum"
                                                            select="document(document-uri(.))"/>
                                                        <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                                        <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                                        <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                                        
                                                        <xsl:if test="rez">
                                                            <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                                <div class="ihv_headline titel">
                                                                    <xsl:value-of select="/*/metadata/title"/>
                                                                </div>
                                                                <div class="ihv_seite"> 
                                                                    <xsl:choose>
                                                                        <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                            <xsl:value-of select="$siriusID"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                            <xsl:value-of select="$siriusID"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </div>
                                                            </a>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        
                                        <div class="ihv_level2">
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Tagungsbericht']">
                                            <div class="ihv_headline ressort">Tagungsbericht</div>
                                        </xsl:if>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                           
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            <!-- TAGUNGSBERICHT -->
                                            
                                            <xsl:if test="$ressortbez='Tagungsbericht'">
                                                <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                <div class="ihv_headline titel">
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </div>
                                                    <div class="ihv_seite" >
                                                        <xsl:choose>
                                                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </a>
                                            </xsl:if>
                                        </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="ihv_level2">
                                           
                                            <xsl:choose>
                                                <xsl:when test="$aktuelles-Heft//ressort[text()='International Developments']">
                                                    <div class="ihv_headline ressort">International Developments</div>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            
                                            
                                            
                                  <!--   
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='International Developments']">
                                            <div class="ihv_headline ressort">International Developments</div>
                                        </xsl:if>
                                            
                                        <xsl:if test="$aktuelles-Heft//ressort[text()='Fusionskontrolle']">
                                            <div class="ihv_headline ressort">Fusionskontrolle</div>
                                        </xsl:if>
                                         -->   

                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- INTERNATIONAL DEVELOPMENTS -->
                                            
                                            <xsl:if test="$ressortbez='International Developments'">
                                                <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                <div class="ihv_headline titel">
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </div>
                                                    <div class="ihv_seite" >
                                                        <xsl:choose>
                                                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </a>
                                            </xsl:if>
                                            
                                         
                                        </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="ihv_level2">
                                            <xsl:if test="$aktuelles-Heft//ent or $aktuelles-Heft//nr">
                                            <div id="entsch" class="ihv_headline ressort">Entscheidungen</div>
                                        </xsl:if>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                                    
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez"
                                                select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- ENTSCHEIDUNGEN -->
                                            
                                            <xsl:if test="ent">
                                                <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                <div class="ihv_headline titel">
                                                    <i><xsl:value-of select="/*/metadata/instdoc/inst"/><xsl:text>: </xsl:text></i>
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </div>
                                                    <div class="ihv_seite" >
                                                        <xsl:choose>
                                                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </a>
                                            </xsl:if>
                                            
                                            <!-- FUSIONSKONTROLLE -->
                                            
                                            <xsl:if test="$ressortbez='Fusionskontrolle'">
                                                <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                    <div class="ihv_headline titel">
                                                        <xsl:value-of select="/*/metadata/title"/>
                                                    </div>
                                                    <div class="ihv_seite" >
                                                        <xsl:choose>
                                                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </a>
                                            </xsl:if>
                                        </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="ihv_level2">
                                        <xsl:if test="$aktuelles-Heft//iv">
                                            <div id="interv" class="ihv_headline ressort">Interview</div>
                                        </xsl:if>
                                            
                                            <div class="ihv_level3">
                                                <div class="ihv_level4">
                                        
                                        <!-- SCHLEIFE ÜBER JEDES XML DOKUMENT -->
                                        <xsl:for-each select="$aktuelles-Heft">
                                            
                                            <xsl:variable name="docum"
                                                select="document(document-uri(.))"/>
                                            <xsl:variable name="siriusID" select="$docum/*/@rawid"/>
                                            <xsl:variable name="dok-nr" select="$docum/*/@sid"/>
                                            <xsl:variable name="ressortbez" select="$docum/*/metadata/ressort"/>
                                            
                                            
                                            <!-- INTERVIEW -->
                                            
                                            <xsl:if test="iv">
                                                <a href="https://research.owlit.de/lx-document/WUW{$siriusID}" target="_blank">
                                                <div class="ihv_headline titel">
                                                    <xsl:value-of select="/*/metadata/title"/>
                                                </div>
                                                    <div class="ihv_seite"> 
                                                        <xsl:choose>
                                                            <xsl:when test="/*/metadata/pub/pages[start_page = last_page]">
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="/*/metadata/pub/pages/start_page"/> &#x2011; <xsl:value-of select="/*/metadata/pub/pages/last_page"/>,  <xsl:text>WUW</xsl:text>
                                                                <xsl:value-of select="$siriusID"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </a>
                                            </xsl:if>
                                        </xsl:for-each>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </body>
            </html>
        
    </xsl:template>
</xsl:stylesheet>
