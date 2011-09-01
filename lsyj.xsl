<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="1.0">
  <xsl:output method="html"/>

  <xsl:template match="book">
    <head>
      <title>六書音均表</title>
      <link rel="stylesheet" href="lsyj.css" type="text/css" />
    </head>
    <body>
      <xsl:apply-templates/>
    </body>
  </xsl:template>

  <xsl:template match="preface">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="content">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="catalogs">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="catalogtitle">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>

  <xsl:template match="author">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="note">
    <span style='font-size: 50%'><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="catalog">
    <h4>
    <xsl:element name="a">
      <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
    </h4>
  </xsl:template>

  <xsl:template match="word_num">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="preface_title">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>

  <xsl:template match="table">
    <xsl:element name="div">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="tabletitle">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>

  <xsl:template match="prevue">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="seventeen_parts">
    <table><xsl:apply-templates/></table>
  </xsl:template>

  <xsl:template match="seventeen_part">
    <xsl:element name="tr">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="seventeen_part/partname">
    <th><xsl:apply-templates/></th>
  </xsl:template>

  <xsl:template match="fourtune">
    <td><xsl:apply-templates/></td>
  </xsl:template>

  <xsl:template match="rhythmic_entry">
    <p><xsl:element name="a">
      <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element></p>
  </xsl:template>

  <xsl:template match="midtitle">
    <h4><xsl:apply-templates/></h4>
  </xsl:template>

  <xsl:template match="endtable">
    <h4><xsl:apply-templates/></h4>
    <hr/>
  </xsl:template>

  <xsl:template match="tone_parts">
    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="tone_part">
    <xsl:apply-templates select="partname"/>
    <xsl:for-each select="partial_tone[(position() mod 4) = 1]">
      <xsl:call-template name="row"/>
    </xsl:for-each>
    <xsl:apply-templates select="explanation"/>
  </xsl:template>

  <xsl:template match="tone_part/partname">
    <tr><th colspan="4">
      <xsl:element name="a">
        <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element>
    </th></tr>
  </xsl:template>

  <xsl:template match="tone_part/explanation">
    <tr><td colspan="4"><xsl:apply-templates/></td></tr>
  </xsl:template>

  <xsl:template name="row">
    <tr>
    <xsl:apply-templates select="."/>
    <xsl:apply-templates select="following-sibling::partial_tone[position()=1]"/>
    <xsl:apply-templates select="following-sibling::partial_tone[position()=2]"/>
    <xsl:apply-templates select="following-sibling::partial_tone[position()=3]"/>
    </tr>
  </xsl:template>

  <xsl:template match="partial_tone">
    <td><xsl:apply-templates/></td>
  </xsl:template>

  <xsl:template match="sorts">
    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="sort">
    <xsl:apply-templates select="sortname"/>
  </xsl:template>

  <xsl:template match="sortname">
    <tr>
      <xsl:element name="td">
        <xsl:attribute name="rowspan"><xsl:value-of select="count(following-sibling::part_entry)"/></xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element>
      <xsl:apply-templates select="following-sibling::part_entry[position()=1]"/>
    </tr>
    <xsl:for-each select="following-sibling::part_entry[position()>1]">
      <tr><xsl:apply-templates select="."/></tr>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="part_entry">
    <td><xsl:apply-templates/></td>
  </xsl:template>

  <!-- table 4 -->

  <xsl:template match="parts">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="part">
    <hr/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="part/partname">
    <h4>
      <xsl:element name="a">
        <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element>
    </h4>
  </xsl:template>

  <xsl:template match="verses">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="verse">
    <xsl:apply-templates/><br/>
  </xsl:template>

  <xsl:template match="letter">
    <xsl:apply-templates/><br/>
  </xsl:template>

  <xsl:template match="origin_tune">
    <span style="text-emphasis-style: open sesame; font-weight: bold;"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="synactic_tune">
    <span style="border-style: solid"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="rhyme">
    <hr/><p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="rhymetitle">
    <span style="border-style: solid; font-size: 120%;"><xsl:apply-templates/></span><br/>
  </xsl:template>

  <xsl:template match="word">
    <xsl:apply-templates/><br/>
  </xsl:template>

</xsl:stylesheet>
