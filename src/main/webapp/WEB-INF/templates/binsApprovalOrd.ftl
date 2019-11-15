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
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="18" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s119">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="#,##0.00_);[Red]\(#,##0.00\)"/>
  </Style>
  <Style ss:ID="s120">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
   <NumberFormat ss:Format="#,##0.00"/>
  </Style>
  <Style ss:ID="s121">
   <NumberFormat ss:Format="#,##0.00_);[Red]\(#,##0.00\)"/>
  </Style>
  <Style ss:ID="s122">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <NumberFormat ss:Format="General Date"/>
  </Style>
  <Style ss:ID="s123">
      <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
  </Style>
  <Style ss:ID="s124">
      <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table ss:ExpandedColumnCount="30" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Width="78.5" />
   <Column ss:Width="110.5"/>
   <Column ss:Width="88"/>
   <Column ss:Width="46.75"/>
   <Column ss:Width="86.5"/>
   <Column ss:Width="118.5"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="60.5"/>
   <Column ss:Width="150" ss:Span="1"/>
   <Row ss:Height="22.5" ss:StyleID="s115">
    <Cell ss:MergeAcross="18" ss:StyleID="s114"><Data ss:Type="String">直接审核</Data></Cell>
   </Row>
   <Row ss:StyleID="s112">
    <Cell ss:Index="1"><Data ss:Type="String">订单编号</Data></Cell>
    <Cell><Data ss:Type="String">提单号</Data></Cell>
    <Cell><Data ss:Type="String">柜号</Data></Cell>
    <Cell><Data ss:Type="String">柜型</Data></Cell>
    <Cell><Data ss:Type="String">客户</Data></Cell>
    <Cell><Data ss:Type="String">发车日期</Data></Cell>
    <Cell ss:StyleID="s119"><Data ss:Type="String">应收合计</Data></Cell>
    <Cell ss:StyleID="s119"><Data ss:Type="String">应付合计</Data></Cell>
    <Cell ss:StyleID="s119"><Data ss:Type="String">预期毛利</Data></Cell>
     <Cell ss:StyleID="s119"><Data ss:Type="String">毛利率</Data></Cell>
    <Cell><Data ss:Type="String">审核状态</Data></Cell>
    <Cell><Data ss:Type="String">价格备注</Data></Cell>
    </Row>
<#list binsApprovalOrdModelList as binsApprovalOrdModel>
    <Row ss:StyleID="s62">
        <Cell ss:Index="1"><Data ss:Type="String">${(binsApprovalOrdModel.orderNo)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(binsApprovalOrdModel.businessNo1)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(binsApprovalOrdModel.businessNo2)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(binsApprovalOrdModel.containerType)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(binsApprovalOrdModel.cusCode)!''}</Data></Cell>
        <Cell ss:StyleID="s122"><Data ss:Type="String">${(binsApprovalOrdModel.businessDate)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(binsApprovalOrdModel.rAmountSum)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(binsApprovalOrdModel.pAmountSum)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(binsApprovalOrdModel.profit)!''}</Data></Cell>
        <Cell ss:StyleID="s124"><Data ss:Type="String">${(binsApprovalOrdModel.profitRate)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(binsApprovalOrdModel.binsApprovalFlag)!''}</Data></Cell>
		<Cell ss:StyleID="s123"><Data ss:Type="String">${(binsApprovalOrdModel.remarks)!''}</Data></Cell>
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
<Worksheet ss:Name="Sheet2">
<Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"
x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
</Table>
<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
<PageSetup>
<Header x:Margin="0.3"/>
<Footer x:Margin="0.3"/>
<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
</PageSetup>
<ProtectObjects>False</ProtectObjects>
<ProtectScenarios>False</ProtectScenarios>
</WorksheetOptions>
</Worksheet>
<Worksheet ss:Name="Sheet3">
<Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"
x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
</Table>
<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
<PageSetup>
<Header x:Margin="0.3"/>
<Footer x:Margin="0.3"/>
<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
</PageSetup>
<ProtectObjects>False</ProtectObjects>
<ProtectScenarios>False</ProtectScenarios>
</WorksheetOptions>
</Worksheet>
</Workbook>
