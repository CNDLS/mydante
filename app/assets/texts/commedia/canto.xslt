<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="page">
  <h2>Canto </h2>
  <xsl:for-each select="p">
    <p class='stanza'>
      <xsl:for-each select="l">
        <p><xsl:value-of select="."/></p>
      </xsl:for-each>
    </p>
  </xsl:for-each>
</xsl:template>

</xsl:transform>