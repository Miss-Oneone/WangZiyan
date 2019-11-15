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
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
   <Column ss:Width="100"/>
   <Column ss:Width="120"/>
   <Column ss:Width="120"/>
      <Column ss:Width="120"/>
   <Column ss:Width="120"/>
      <Column ss:Width="120"/>
   <Column ss:Width="100"/>
   <Column ss:Width="100"/>
   <Column ss:Width="60"/>
   <Column ss:Width="60"/>
   <Column ss:Width="100"/>
   <Row ss:StyleID="s113">
    <Cell ><Data ss:Type="String">订单号</Data></Cell>
    <Cell><Data ss:Type="String">提单号</Data></Cell>
    <Cell><Data ss:Type="String">集装箱号</Data></Cell>
    <Cell><Data ss:Type="String">应付费用</Data></Cell>
    <Cell><Data ss:Type="String">应付金额</Data></Cell>
    <Cell><Data ss:Type="String">收款单位</Data></Cell>
    <Cell><Data ss:Type="String">已录入费用名称</Data></Cell>
    <Cell><Data ss:Type="String">已录入应收金额</Data></Cell>
    <Cell><Data ss:Type="String">已录入付款单位</Data></Cell>
    <Cell><Data ss:Type="String">需生成费用</Data></Cell>
    <Cell><Data ss:Type="String">需生成应收</Data></Cell>
    <Cell><Data ss:Type="String">需生成付款单位</Data></Cell>
    <Cell><Data ss:Type="String">备注(计算公式)</Data></Cell>
    <Cell><Data ss:Type="String">生成状态</Data></Cell>
    <Cell><Data ss:Type="String">托运人</Data></Cell>
    <Cell><Data ss:Type="String">往来单位</Data></Cell>
       <Cell><Data ss:Type="String">散客</Data></Cell>
    <Cell><Data ss:Type="String">二段客户</Data></Cell>
       <Cell><Data ss:Type="String">二段散客</Data></Cell>
    <Cell><Data ss:Type="String">提箱地</Data></Cell>
    <Cell><Data ss:Type="String">还箱地</Data></Cell>
    <Cell><Data ss:Type="String">内外贸</Data></Cell>
    <Cell><Data ss:Type="String">进出口</Data></Cell>
    <Cell><Data ss:Type="String">箱型</Data></Cell>
    <Cell><Data ss:Type="String">拖箱时间</Data></Cell>
   </Row>
   <#list list as dockCostRevModel>
        <Row ss:StyleID="s62">
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.orderNo)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.blNo)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.contnNo)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.piName)!''}</Data></Cell>
            <Cell ss:StyleID="s120"><Data ss:Type="Number">${(dockCostRevModel.amount)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.rCompyName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.sysPiName)!''}</Data></Cell>
            <Cell ss:StyleID="s120"><Data ss:Type="Number">${(dockCostRevModel.sysAmount)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.sysCompyName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.createPiName)!''}</Data></Cell>
            <Cell ss:StyleID="s120"><Data ss:Type="Number">${(dockCostRevModel.createAmount)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.createCompyName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.createRemarks)!''}</Data></Cell>
            <Cell ss:StyleID="s112"><Data ss:Type="String">${(dockCostRevModel.createStatusName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.cusName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.payCompyName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.payFitName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.secondPCompyName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.secondPFitName)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.txAddrsAbbr)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(dockCostRevModel.hxAddrsAbbr)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(dockCostRevModel.binsName)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(dockCostRevModel.ioName)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(dockCostRevModel.containerType)!''}</Data></Cell>
            <Cell ss:StyleID="s112"><Data ss:Type="String">${(dockCostRevModel.contnTime)!''}</Data></Cell>
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
