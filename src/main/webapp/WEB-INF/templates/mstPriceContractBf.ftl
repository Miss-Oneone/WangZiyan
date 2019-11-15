<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Created>2006-09-16T00:00:00Z</Created>
  <LastSaved>2017-05-16T02:18:44Z</LastSaved>
  <Version>14.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
  <RemovePersonalInformation/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>8010</WindowHeight>
  <WindowWidth>14805</WindowWidth>
  <WindowTopX>240</WindowTopX>
  <WindowTopY>105</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s62">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
  </Style>
  <Style ss:ID="s112">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"  />
  </Style>
   <Style ss:ID="s113">
       <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
       <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"
       ss:Bold="1"/>
       <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
   </Style>
  <Style ss:ID="s114">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="18" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="s115">
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="18" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s119">
   <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"  />
  </Style>
  <Style ss:ID="s120">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
   <NumberFormat ss:Format="#,##0.00_);[Red]\(#,##0.00\)"/>
  </Style>
  <Style ss:ID="s121">
   <NumberFormat ss:Format="#,##0.00_);[Red]\(#,##0.00\)"/>
  </Style>
  <Style ss:ID="s122">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <NumberFormat ss:Format="General Date"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table ss:ExpandedColumnCount="26" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Width="80"/>
      <Column ss:Width="60"/>
      <Column ss:Width="60"/>
      <Column ss:Width="60"/>
   <#--<Column ss:Width="60"/>
   <Column ss:Width="60"/>-->
  <#if "${chargingType}" == "2">
      <Column ss:Width="80"/>
      <Column ss:Width="80"/>
  </#if>
  <#if "${chargingType}" != "2">
      <Column ss:Width="80"/>
  </#if>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="60"/>
   <Column ss:Width="72"/>
   <Column ss:Width="70"/>
   <Column ss:Width="100"/>
   <Column ss:Width="70"/>
   <Column ss:Width="100"/>
   <Row ss:Height="22.5" ss:StyleID="s115">
    <Cell ss:MergeAcross="20" ss:StyleID="s114"><Data ss:Type="String">运费明细</Data></Cell>
   </Row>
   <Row ss:StyleID="s113">
    <Cell><Data ss:Type="String">协议名称</Data></Cell>
       <Cell><Data ss:Type="String">有效状态</Data></Cell>
       <Cell><Data ss:Type="String">内外贸</Data></Cell>
       <Cell><Data ss:Type="String">进出口</Data></Cell>
    <#--<Cell><Data ss:Type="String">目的区域</Data></Cell>
    <Cell><Data ss:Type="String">目的门点</Data></Cell>-->
   <#if "${chargingType}" == "2">
       <Cell><Data ss:Type="String">重量单位(吨)</Data></Cell>
       <Cell><Data ss:Type="String">货种</Data></Cell>
   </#if>
   <#if "${chargingType}" != "2">
       <Cell><Data ss:Type="String">集装箱等级</Data></Cell>
   </#if>
    <Cell><Data ss:Type="String">单价(元)</Data></Cell>
    <Cell><Data ss:Type="String">省</Data></Cell>
    <Cell><Data ss:Type="String">市</Data></Cell>
    <Cell><Data ss:Type="String">区/县</Data></Cell>
    <Cell><Data ss:Type="String">乡/镇</Data></Cell>
    <Cell><Data ss:Type="String">公里数备注</Data></Cell>
    <Cell><Data ss:Type="String">备注</Data></Cell>
	<Cell><Data ss:Type="String">创建人</Data></Cell>
	<Cell><Data ss:Type="String">创建时间</Data></Cell>
	<Cell><Data ss:Type="String">更信人</Data></Cell>
	<Cell><Data ss:Type="String">更新时间</Data></Cell>
   </Row>
   <#list list as model>
        <Row ss:StyleID="s62">
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.priceContractName)!''}</Data></Cell>
            <Cell ss:StyleID="s112"><Data ss:Type="String">${(model.effectiveStatusName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(model.binsName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(model.ioName)!''}</Data></Cell>
            <#--<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.destRegionName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(model.destAddrsName)!''}</Data></Cell>-->
         <#if "${chargingType}" == "2">
             <Cell ss:StyleID="s119"><Data ss:Type="String">${(model.goodsWeight)!''}</Data></Cell>
             <Cell ss:StyleID="s119"><Data ss:Type="String">${(model.goodsName)!''}</Data></Cell>
         </#if>
         <#if "${chargingType}" != "2">
             <Cell ss:StyleID="s119"><Data ss:Type="String">${(model.containerName)!''}</Data></Cell>
         </#if>
            <Cell ss:StyleID="s120"><Data ss:Type="Number">${(model.rCusBfPrice)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(model.provinceName)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.cityName)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.districtName)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.countyName)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(model.distanceKmQty)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.remarks)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.createBy)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(model.createTimeFmt)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(model.updateBy)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(model.updateTimeFmt)!''}</Data></Cell>
       </Row>
   </#list>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <Print>
    <ValidPrinterInfo/>
    <PaperSizeIndex>9</PaperSizeIndex>
    <HorizontalResolution>600</HorizontalResolution>
    <VerticalResolution>600</VerticalResolution>
   </Print>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>10</ActiveRow>
     <ActiveCol>2</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
