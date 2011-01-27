<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0">
  <!--xsl:output method="html"/-->
  <xsl:output method="xml"/>

  <xsl:template match="//chapter">
    <xsl:variable name="filename"
                  select="concat('swjz/',chaptertitle/@id,'.html')" />
    <!--xsl:value-of select="$filename" /-->  <!-- 表示用  -->
    <xsl:result-document href="{$filename}">
    <xsl:text>
    </xsl:text>
    <html xmlns="http://www.w3.org/1999/xhtml" lang='zh-tw' xml:lang='zh-tw'><xsl:text>
    </xsl:text>
    <head><xsl:text>
      </xsl:text>
      <title><xsl:value-of select="chaptertitle"/></title><xsl:text>
      </xsl:text>
      <link rel="stylesheet" href="swjz.css" type="text/css" /><xsl:text>
      </xsl:text>
    </head><xsl:text>
    </xsl:text>
    <body lang="zh"><xsl:text>
    </xsl:text>
      <h1><xsl:value-of select="chaptertitle"/></h1><xsl:text>
      </xsl:text>
      <xsl:apply-templates select="shuowen|part_wordnum"/>
      </body><xsl:text>
    </xsl:text>
  </html>
  </xsl:result-document>
  </xsl:template>

  <!-- template for shuowen -->
  <xsl:template match="shuowen">
    <table>
      <xsl:apply-templates select="wordhead"/>
      </table><xsl:text>
    </xsl:text>
  </xsl:template>
  <xsl:template match="wordhead">
    <tr>
      <xsl:element name="td">
        <xsl:attribute name="class">wordhead</xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
        <xsl:element name="img">
          <xsl:attribute name="src">swjz-img/<xsl:value-of select="@img"/>s.png</xsl:attribute>
          <xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
          <!--xsl:attribute name="width">40%</xsl:attribute-->
        </xsl:element>
        <font style="font-size:50%;"><xsl:value-of select="."/></font>
      </xsl:element>
      <!--td class="wordhead"><xsl:apply-templates/></td-->
      <td class="body">
        <xsl:variable name="current_head">
          <xsl:number level="single" count="*"/>
        </xsl:variable>
        <xsl:variable name="next_head">
          <xsl:for-each select="following-sibling::wordhead[1]">
            <xsl:number level="single" count="*"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$next_head != '' and $next_head &gt; 0">
            <xsl:apply-templates select="../*[(position() &lt; $next_head) and (position() &gt; $current_head)]"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="following-sibling::*"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      </tr><xsl:text>
    </xsl:text>
  </xsl:template>
  <xsl:template match="explanation">
    <span class="explanation">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="duan_note">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- template for part_wordnum -->
  <xsl:template match="part_wordnum">
    <table class="part_wordnum">
      <tr>
        <td width="10%"></td>
        <td width="90%">
          <xsl:apply-templates mode="normal_text"/>
        </td>
        </tr><xsl:text>
      </xsl:text>
      </table><xsl:text>
    </xsl:text>
  </xsl:template>
  <xsl:template mode="normal_text" match="text()">
    <font class="explanation"><xsl:value-of select="."/></font>
  </xsl:template>
  <xsl:template mode="normal_text" match="duan_note">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
