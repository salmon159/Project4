<?xml version='1.0' encoding='utf-8' ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes"/>	
	<xsl:param name="sLink" select="$sLink"/>
	<xsl:param name="sTitle" select="$sTitle"/>
	<xsl:template match="/">
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
		 xmlns:o="urn:schemas-microsoft-com:office:office"
		 xmlns:x="urn:schemas-microsoft-com:office:excel"
		 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		 xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>Sterling</Author>
				<LastAuthor>Sterling</LastAuthor>
				<Company>Sterling Commerce</Company>
				<Version>11.5606</Version>
			</DocumentProperties>
			<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
				<WindowHeight>13035</WindowHeight>
				<WindowWidth>19995</WindowWidth>
				<WindowTopX>480</WindowTopX>
				<WindowTopY>60</WindowTopY>
				<ProtectStructure>False</ProtectStructure>
				<ProtectWindows>False</ProtectWindows>
			</ExcelWorkbook>
			<Styles>
				<Style ss:ID="Default" ss:Name="Normal">
					<Alignment ss:Vertical="Bottom"/>
					<Borders/>
					<Font/>
					<Interior/>
					<NumberFormat/>
					<Protection/>
				</Style>
				<Style ss:ID="s21" ss:Name="Hyperlink">
					<Font ss:Color="#0000FF" ss:Underline="Single"/>
				</Style>
				<Style ss:ID="s22">
					<NumberFormat/>
				</Style>
				<Style ss:ID="s23">
					<Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
					<NumberFormat/>
				</Style>
				<Style ss:ID="s24">
					<Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
				</Style>
				<Style ss:ID="s26" ss:Parent="s21">
					<Font x:Family="Swiss" ss:Size="14" ss:Bold="1"/>
					<Interior/>
					<NumberFormat/>
				</Style>
				<Style ss:ID="s27">
					<Font x:Family="Swiss" ss:Size="14" ss:Bold="1"/>
					<Interior/>
				</Style>
				<Style ss:ID="s28">
					<Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
					<Font x:Family="Swiss" ss:Size="14" ss:Bold="1"/>
					<Interior/>
					<NumberFormat/>
				</Style>
				<Style ss:ID="s29">
					<Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
					<Font x:Family="Swiss" ss:Size="14" ss:Bold="1"/>
					<Interior/>
				</Style>
				<Style ss:ID="s32">
					<Alignment ss:Vertical="Top"/>
				</Style>
				<Style ss:ID="s33">
					<Alignment ss:Vertical="Top"/>
					<Font x:Family="Swiss" ss:Bold="1"/>
					<Interior ss:Color="#FFFF99" ss:Pattern="Solid"/>
					<NumberFormat/>
				</Style>
				<Style ss:ID="s34">
					<Alignment ss:Vertical="Top"/>
					<Font x:Family="Swiss" ss:Bold="1"/>
					<Interior ss:Color="#FFFF99" ss:Pattern="Solid"/>
				</Style>
				<Style ss:ID="s35">
					<Alignment ss:Horizontal="Left" ss:Vertical="Top"/>
					<Font x:Family="Swiss" ss:Bold="1"/>
					<Interior ss:Color="#FFFF99" ss:Pattern="Solid"/>
					<NumberFormat/>
				</Style>
				<Style ss:ID="s36">
					<Alignment ss:Vertical="Top" ss:WrapText="1"/>
					<Font x:Family="Swiss" ss:Bold="1"/>
					<Interior ss:Color="#FFFF99" ss:Pattern="Solid"/>
				</Style>
			</Styles>
			<Worksheet ss:Name="Data mapping">
				<Table x:FullColumns="1" x:FullRows="1">
					<Column ss:StyleID="s22" ss:AutoFitWidth="0" ss:Width="283"/>
					<Column ss:AutoFitWidth="0" ss:Width="250"/>
					<Column ss:StyleID="s23" ss:AutoFitWidth="0" ss:Width="200"/>
					<Row ss:AutoFitHeight="0" ss:Height="15.75">
						<Cell ss:StyleID="s26">
						<Data ss:Type="String"><xsl:value-of select="$sTitle"/></Data></Cell>
						<Cell ss:StyleID="s27"/>
						<Cell ss:StyleID="s28"/>
						<Cell ss:StyleID="s29"/>
						<Cell ss:StyleID="s27"/>
						<Cell ss:StyleID="s27"/>
					</Row>
					<Row>
						<Cell ss:StyleID="Default"/>
					</Row>
					<Row ss:AutoFitHeight="0" ss:Height="23.25" ss:StyleID="s32">
						<Cell ss:StyleID="s33"><Data ss:Type="String">Attribute Name</Data></Cell>
						<Cell ss:StyleID="s34"><Data ss:Type="String">Mapping</Data></Cell>
						<Cell ss:StyleID="s34"><Data ss:Type="String">Remarks</Data></Cell>
					</Row>
					<xsl:call-template name="ProcessElement"></xsl:call-template>
				</Table>
				<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
					<Print>
						<ValidPrinterInfo/>
						<HorizontalResolution>600</HorizontalResolution>
						<VerticalResolution>600</VerticalResolution>
					</Print>
					<Selected/>
					<Panes>
						<Pane>
							<Number>3</Number>
							<ActiveRow>42</ActiveRow>
							<ActiveCol>3</ActiveCol>
						</Pane>
					</Panes>
					<ProtectObjects>False</ProtectObjects>
					<ProtectScenarios>False</ProtectScenarios>
				</WorksheetOptions>
			</Worksheet>
		</Workbook> 
	</xsl:template>
	<xsl:template name="ProcessElement" match="ProcessElement">
		<xsl:for-each select="*">
			<xsl:variable name="ElementName" select="name()"/>
			<xsl:for-each select="@*">
				<Row xmlns="urn:schemas-microsoft-com:office:spreadsheet"
					 xmlns:o="urn:schemas-microsoft-com:office:office"
					 xmlns:x="urn:schemas-microsoft-com:office:excel"
					 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
					 xmlns:html="http://www.w3.org/TR/REC-html40">
					<Cell ss:StyleID="s21" ss:HRef="file:{$sLink}#{$ElementName}">
						<Data ss:Type="String">
							<xsl:for-each select="ancestor::*">
								<xsl:call-template name="print-step"/>
							</xsl:for-each>
							<!-- <xsl:value-of select="ancestor::$ElementName/*"/> -->
							<!-- <xsl:value-of select="$ElementName"/> -->
							<xsl:text>@</xsl:text>
							<xsl:value-of select="name()"/>
						</Data>
					</Cell>
				   </Row>	  
			</xsl:for-each>
			<Row xmlns="urn:schemas-microsoft-com:office:spreadsheet"
				 xmlns:o="urn:schemas-microsoft-com:office:office"
				 xmlns:x="urn:schemas-microsoft-com:office:excel"
				 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
				 xmlns:html="http://www.w3.org/TR/REC-html40"/>
			<xsl:call-template name="ProcessElement"></xsl:call-template>
		</xsl:for-each>		
	</xsl:template>
	<xsl:template name="print-step">
		<xsl:value-of select="name()"/>
		<xsl:text>\</xsl:text>
	</xsl:template>
</xsl:stylesheet>
