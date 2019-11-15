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
      <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
      <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s119">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="#,##0.00_);[Red]\(#,##0.00\)"/>
  </Style>
  <Style ss:ID="s120">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
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
  <Table ss:ExpandedColumnCount="20" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Index="1" ss:Width="120"/>
   <Column ss:Width="40"/>
   <Column ss:Width="70"/>
   <Column ss:Width="78"/>
   <Column ss:Width="100"/>
   <Column ss:Width="60"/>
   <Column ss:Width="80"/>
   <Column ss:Width="72"/>
   <Column ss:Width="72"/>
   <Column ss:Width="72"/>
   <Column ss:Width="72"/>
   <Column ss:Width="72"/>
   <Column ss:Width="72"/>
   <Row ss:Height="22.5" ss:StyleID="s115">
    <Cell ss:MergeAcross="13" ss:StyleID="s114"><Data ss:Type="String">强核销关联</Data></Cell>
   </Row>
   <Row ss:StyleID="s112">
    <Cell ss:Index="1"><Data ss:Type="String">日记账/票据号</Data></Cell>
    <Cell ss:StyleID="s119"><Data ss:Type="String">类型</Data></Cell>
    <Cell ss:StyleID="s119"><Data ss:Type="String">票据类型</Data></Cell>
    <Cell><Data ss:Type="String">状态</Data></Cell>
    <Cell><Data ss:Type="String">往来单位</Data></Cell>
    <Cell><Data ss:Type="String">结算单位</Data></Cell>
    <Cell><Data ss:Type="String">票据日期</Data></Cell>
    <Cell><Data ss:Type="String">金额</Data></Cell>
    <Cell><Data ss:Type="String">已核销金额</Data></Cell>
    <Cell><Data ss:Type="String">未核销金额</Data></Cell>
    <Cell><Data ss:Type="String">已入账金额</Data></Cell>
    <Cell><Data ss:Type="String">未入账金额</Data></Cell>
    <Cell><Data ss:Type="String">强关联核销金额</Data></Cell>
   </Row>
   <#list dataModels as dataModel>
        <Row ss:StyleID="s62">
			<Cell ss:Index="1"><Data ss:Type="String">${(dataModel.groupNo)!''}</Data></Cell>
            <Cell><Data ss:Type="String">${(dataModel.paymentType)!''}</Data></Cell>
            <Cell ss:StyleID="s115"><Data ss:Type="String">${(dataModel.invoiceType)!''}</Data></Cell>
			<Cell ss:StyleID="s115"><Data ss:Type="String">${(dataModel.status)!''}</Data></Cell>
            <Cell ss:StyleID="s115"><Data ss:Type="String">${(dataModel.compySname)!''}</Data></Cell>
            <Cell ss:StyleID="s115"><Data ss:Type="String">${(dataModel.belongCompyName)!''}</Data></Cell>
			<Cell ss:StyleID="s122"><Data ss:Type="String">${(dataModel.createTime)!''}</Data></Cell>
			<Cell ss:StyleID="s121"><Data ss:Type="Number">${(dataModel.amount)!''}</Data></Cell>
			<Cell ss:StyleID="s121"><Data ss:Type="Number">${(dataModel.fiDoneAmount)!''}</Data></Cell>
			<Cell ss:StyleID="s121"><Data ss:Type="Number">${(dataModel.unFiDoneAmount)!''}</Data></Cell>
            <Cell ss:StyleID="s121"><Data ss:Type="Number">${(dataModel.connectAmount)!''}</Data></Cell>
			<Cell ss:StyleID="s121"><Data ss:Type="Number">${(dataModel.unConnectAmount)!''}</Data></Cell>
			<Cell ss:StyleID="s121"><Data ss:Type="Number">${(dataModel.forceFiDoneAmount)!''}</Data></Cell>
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
