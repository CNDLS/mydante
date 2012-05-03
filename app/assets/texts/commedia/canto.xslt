<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
<xsl:template match="/">
  <xsl:param name="italian-version-uri" />
  <xsl:variable name="file1" select="//page/p"/>
  <table>
    <th><xsl:value-of select="$italian-version-uri" /></th>
  <xsl:for-each select="$file1">
    <tr class='stanza'>
      <td class='line_nbr'>1</td>
      <td>
      <xsl:for-each select="l">
        <p><xsl:value-of select="."/></p>
      </xsl:for-each>
      </td>
      <xsl:variable name="pos" select="position()"/>
      <!-- <xsl:apply-templates select="$file1[position() = $pos]" /> -->
      <td>
      <xsl:for-each select="l">
        <p><xsl:value-of select="."/></p>
      </xsl:for-each>
      </td>
      <td class='margin'></td>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

</xsl:stylesheet>

<!--  -->