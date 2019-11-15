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
  <Style ss:ID="s65">
      <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
      <Borders>
       <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
      </Borders>
        <Font ss:FontName="Arial" x:CharSet="134" ss:Bold="1" ss:Size="10" ss:Shadow="1"/>
      <Interior ss:Color="#F5F5F5" ss:Pattern="Solid"/>
      <NumberFormat ss:Format="###0;\-###0"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table ss:ExpandedColumnCount="26" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="120"/>
   <Column ss:Width="150"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="120"/>
   <Column ss:Width="150"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Row ss:Height="22.5" ss:StyleID="s115">
    <Cell ss:MergeAcross="8" ss:StyleID="s114"><Data ss:Type="String">路线公里与工资</Data></Cell>
   </Row>
      <Row ss:Height="22.5" ss:StyleID="s115">
          <Cell ss:MergeAcross="3" ss:StyleID="s65"><Data ss:Type="String">起运地</Data></Cell>
          <Cell ss:MergeAcross="3" ss:StyleID="s65"><Data ss:Type="String">到达地</Data></Cell>
          <Cell ss:MergeDown="1" ss:StyleID="s65"><Data ss:Type="String">核定公里数</Data></Cell>
          <Cell ss:MergeDown="1" ss:StyleID="s65"><Data ss:Type="String">司机工资</Data></Cell>
          <Cell ss:MergeDown="1" ss:StyleID="s65"><Data ss:Type="String">运力类型</Data></Cell>
          <Cell ss:MergeDown="1" ss:StyleID="s65"><Data ss:Type="String">有效标志</Data></Cell>
          <Cell ss:MergeDown="1" ss:StyleID="s65"><Data ss:Type="String">备注</Data></Cell>
      </Row>
   <Row ss:Height="15">
    <Cell ss:StyleID="s65"><Data ss:Type="String">省</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">市</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">区/县</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">乡镇</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">省</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">市</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">区/县</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">乡镇</Data></Cell>
   </Row>
   <#list list as costRoute>
        <Row ss:StyleID="s62">
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.fromProvinceName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.fromCityName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.fromDistrictName)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.fromCountyName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.toProvinceName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.toCityName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.toDistrictName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.toCountyName)!''}</Data></Cell>
            <Cell ss:StyleID="s120"><Data ss:Type="Number">${(costRoute.distanceAdjKm)!''}</Data></Cell>
            <Cell ss:StyleID="s120"><Data ss:Type="Number">${(costRoute.stdDrvSalPrice)!''}</Data></Cell>
			<Cell ss:StyleID="s122"><Data ss:Type="String">${(costRoute.trailerBelongType)!''}</Data></Cell>
            <Cell ss:StyleID="s122"><Data ss:Type="String">${(costRoute.validFlag)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(costRoute.remarks)!''}</Data></Cell>
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
