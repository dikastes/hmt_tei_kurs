<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@level='a']"/>
                </title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/milligram/1.4.1/milligram.css"/>
            </head>
            <body>
                <h2>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@level='a']"/>
                </h2>
                <table>
                    <thead>
                        <tr>
                            <th>
                                Aktion
                            </th>
                            <th>
                                Person
                            </th>
                            <th>
                                Datum
                            </th>
                            <th>
                                Ort
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>
                                Versand
                            </th>
                            <td>
                                <xsl:value-of select="//tei:correspAction[@type='sent']//tei:persName/@key"/>
                            </td>
                            <td>
                                <xsl:value-of select="//tei:correspAction[@type='sent']//tei:date"/>
                            </td>
                            <td>
                                <xsl:value-of select="//tei:correspAction[@type='sent']//tei:settlement/@key"/>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Empfang
                            </th>
                            <td>
                                <xsl:value-of select="//tei:correspAction[@type='received']//tei:persName/@key"/>
                            </td>
                            <td>
                                <xsl:value-of select="//tei:correspAction[@type='received']//tei:date"/>
                            </td>
                            <td>
                                <xsl:value-of select="//tei:correspAction[@type='received']//tei:settlement/@key"/>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p>
                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div/tei:opener"/>
                </p>
                <p>
                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div/tei:p"/>
                </p>
                <p>
                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div/tei:closer"/>
                </p>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <code>
            <xsl:value-of select="./@quantity"/>
            words unclear
        </code>
    </xsl:template>
    <xsl:template match="tei:lb|tei:pb">
        <br />
    </xsl:template>
    <xsl:template match="tei:hi[@rend='underlined']">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    <xsl:template match="tei:text//tei:persName">
        <a href="{@ref}" title="{@key}" target="_blank" >
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
</xsl:stylesheet>