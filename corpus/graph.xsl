<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <gexf xmlns="http://gexf.net/1.2" version="1.2">
            <meta lastmodifieddate="2009-03-20">
                <creator>Gexf.net</creator>
                <description>A hello world! file</description>
            </meta>
            <graph mode="static" defaultedgetype="directed">
                <nodes>
                    <xsl:for-each select="//tei:correspAction/tei:persName">
                        <node id="{@ref}" label="{@key}" />
                    </xsl:for-each>                   
                    <xsl:for-each select="//tei:correspAction//tei:settlement">
                        <node id="{@ref}" label="{@key}" />
                    </xsl:for-each>
                </nodes>
                <edges>
                    <xsl:for-each select="//tei:correspDesc">
                        <edge 
                            source="{tei:correspAction[@type='sent']/tei:persName/@ref}"
                            target="{tei:correspAction[@type='received']/tei:persName/@ref}" />
                    </xsl:for-each>
                    <xsl:for-each select="//correspAction">
                        <edge source="{tei:persName/@ref}" target="{tei:settlement/@ref}" />
                    </xsl:for-each>
                </edges>
            </graph>
        </gexf>
    </xsl:template>
</xsl:stylesheet>