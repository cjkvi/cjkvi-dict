<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="1.0">
  <xsl:output method="html"/>
  <xsl:template match="/">
    <head>
      <title>六書音均表</title>
      <link rel="stylesheet" href="lsyj.css" type="text/css" />
    </head>
    <body lang="zh">
      <xsl:apply-templates/>
    </body>
  </xsl:template>

  <!-- template for preface -->
  <xsl:template match="preface">
      <xsl:apply-templates select="preface_title"/>
      <xsl:apply-templates select="content"/>
  </xsl:template>
  <xsl:template match="preface_title">
      <h2><xsl:apply-templates/></h2>
  </xsl:template>
  <xsl:template match="content">
      <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- template for catalogs -->
  <xsl:template match="catalogs">
    <xsl:apply-templates select="catalogtitle"/>
    <xsl:apply-templates select="author"/>
    <xsl:apply-templates select="catalog"/>
    <xsl:apply-templates select="word_num"/>
  </xsl:template>
  <xsl:template match="catalogtitle">
    <p><xsl:apply-templates/></p>
  </xsl:template>
  <xsl:template match="author">
    <p><xsl:apply-templates/></p>
  </xsl:template>
  <xsl:template match="catalog">
    <p>・
    <xsl:element name="a">
      <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
    </p>
  </xsl:template>
  <xsl:template match="author">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- template for tables -->
  <xsl:template match="table">
    <xsl:apply-templates select=

      <xsl:element name="td">
        <xsl:attribute name="class">wordhead</xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element>
      <!--td class="wordhead"><xsl:apply-templates/></td-->
      <td style="width: 80%; vertical-align:top;">
        <xsl:variable name="current_head">
          <xsl:number level="single" count="*"/>
        </xsl:variable>
        <xsl:variable name="next_head">
          <xsl:for-each select="following-sibling::wordhead[1]">
            <xsl:number level="single" count="*"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$next_head &gt; 0">
            <xsl:apply-templates select="../*[(position() &lt; $next_head) and (position() &gt; $current_head)]"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="following-sibling::*"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="img">
    <xsl:element name="img">
      <xsl:attribute name="src">swjz-img/<xsl:value-of select="@src"/>.png</xsl:attribute>
      <xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
      <xsl:attribute name="width">40%</xsl:attribute>
    </xsl:element>
    <font style="font-size:50%;"><xsl:value-of select="."/></font>
  </xsl:template>
  <xsl:template match="explanation">
    <span style="font-size:200%">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="duan_note">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- template for part_wordnum -->
  <xsl:template match="part_wordnum">
    <table style="width: 100%; background-color: yellow;">
      <tr>
        <td width="10%"></td>
        <td width="90%">
          <xsl:apply-templates mode="normal_text"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  <xsl:template mode="normal_text" match="text()">
    <font style="font-size: 200%;"><xsl:value-of select="."/></font>
  </xsl:template>
  <xsl:template mode="normal_text" match="duan_note">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
