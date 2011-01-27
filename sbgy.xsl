<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0">
  <!--xsl:output method="html"/-->
  <xsl:output method="xml"/>

  <xsl:strip-space elements="*"/>
  <xsl:template match="//volume">
    <xsl:variable name="filename"
                  select="concat('sbgy/',@id,'.html')" />
    <!--xsl:value-of select="$filename" /-->  <!-- 表示用  -->
    <xsl:result-document href="{$filename}">
    <xsl:text>
    </xsl:text>
    <html xmlns="http://www.w3.org/1999/xhtml" lang='zh-tw' xml:lang='zh-tw'>
    <head><xsl:text>
      </xsl:text>
      <title><xsl:value-of select="volume_title"/></title>
      <link rel="stylesheet" href="sbgy.css" type="text/css" /><xsl:text>
      </xsl:text>
    </head><xsl:text>
  </xsl:text>
  <body lang="zh"><xsl:text>
  </xsl:text>
    <h1><xsl:value-of select="volume_title"/></h1><xsl:text>
    </xsl:text>
    <xsl:apply-templates select="rhyme"/>
    <xsl:apply-templates select="accession"/>
  </body><xsl:text>
  </xsl:text>
  </html>
  </xsl:result-document>
  </xsl:template>

  <!-- template for volume -->
  <xsl:template match="volume">
    <table style="background-color: yellow">
      <tr>
        <td style="text-align: center; font-size: 225%">
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:value-of select="volume_title"/>
        </td>
      </tr><xsl:text>
    </xsl:text>
    </table>
    <xsl:apply-templates select="rhyme"/>
    <xsl:apply-templates select="accession"/>
  </xsl:template>

  <!-- template for rhyme -->
  <xsl:template match="rhyme">
    <table style="background-color: yellow">
      <tr>
        <td>
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <span style="font-size: 200%;">
            <xsl:value-of select="./rhyme_num"/>
          </span>
          　　（<xsl:value-of select="../volume_title"/>）
        </td>
      </tr><xsl:text>
    </xsl:text>
    </table><xsl:text>
    </xsl:text>
    <xsl:apply-templates select="voice_part"/>
  </xsl:template>

  <!-- template for accession-->
  <xsl:template match="accession">
    <table style="border-color: red;">
      <tr>
        <td style="font-size: 150%;">
          <xsl:value-of select="accession_title"/>
        </td>
      </tr><xsl:text>
    </xsl:text>
      <tr>
        <td style="width: 90%;">
          <xsl:for-each select="word_head">
            <xsl:apply-templates select="."/>&#xa0;</xsl:for-each>
        </td>
        <td class="fanqie">
          <xsl:for-each select=".//fanqie">
            【<xsl:apply-templates mode="fanqie"/>】<br />
          </xsl:for-each>
        </td>
      </tr><xsl:text>
    </xsl:text>
    </table><xsl:text>
    </xsl:text>
  </xsl:template>

  <!-- template for voice_part -->
  <xsl:template match="voice_part">
    <table>
      <tr>
        <td style="width:90%;">
          <xsl:apply-templates select="word_head|added_word"/>
        </td>
        <td class="fanqie">
          <span lang="ja">《<xsl:value-of select="@onyomi"/>》<br /></span>
          （<xsl:value-of select="@ipa"/>）<br />
          <xsl:for-each select=".//fanqie">
            【<xsl:apply-templates mode="fanqie"/>】
          </xsl:for-each>
        </td>
      </tr><xsl:text>
    </xsl:text>
    </table><xsl:text>
    </xsl:text>
  </xsl:template>

  <xsl:template mode="fanqie" match="text()">
    <xsl:value-of select="."/>
  </xsl:template>
  <xsl:template mode="fanqie" match="original_text">
    <xsl:value-of select="rewrite_text"/>
  </xsl:template>

  <!-- template for word_head-->
  <xsl:template match="word_head">
    <xsl:apply-templates mode="word_head"/>
  </xsl:template>
  <xsl:template match="added_word">
    <span style="color: red"><xsl:apply-templates mode="word_head"/></span>
  </xsl:template>
  <xsl:template mode="word_head" match="fanqie">
    <span style="background-color: #f0f0f0;"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template mode="word_head" match="text()">
    <span class="head">
      <xsl:attribute name="id">
        <xsl:value-of select="parent::*/@id"/>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="parent::*/@id"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  <xsl:template mode="word_head" match="original_word">
    <xsl:apply-templates mode="original_word"/>
  </xsl:template>
  <xsl:template mode="original_word" match="text()">
    <span class="cancel_head"><xsl:value-of select="."/></span>
  </xsl:template>
  <xsl:template mode="original_word" match="rewrite_word">&#xa0;<span class="head" style="color: red">
      <xsl:attribute name="id">
        <xsl:value-of select="../../@id"/>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="../../@id"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  <xsl:template mode="original_word" match="headnote">
    <span style="color: green;">（<xsl:value-of select="."/>）</span>
  </xsl:template>

  <!-- template for note-->
  <xsl:template mode="word_head" match="note">
    <xsl:apply-templates/>&#xa0;</xsl:template>
  <xsl:template mode="word_head" match="added_note">
    <xsl:apply-templates/>&#xa0;</xsl:template>
  <xsl:template match="fanqie">
    <span style="background-color: #e0e0e0;"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="added_text">
    <span style="color: red;"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template match="original_text">
    <xsl:apply-templates mode="original_text"/>
  </xsl:template>
  <xsl:template mode="original_text" match="text()">
    <span class="cancel"><xsl:value-of select="."/></span>
  </xsl:template>
  <xsl:template mode="original_text" match="rewrite_text">
    <span style="color: red;"><xsl:apply-templates/></span>
  </xsl:template>
  <xsl:template mode="original_text" match="check_note">
    <span style="color: green;">（<xsl:value-of select="."/>）</span>
  </xsl:template>
</xsl:stylesheet>
