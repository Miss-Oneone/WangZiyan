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
   <NumberFormat ss:Format="#,##0.00_);[Red]\(#,##0.00\)"/>
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
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table ss:ExpandedColumnCount="30" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Index="1" ss:Width="58.5" ss:Span="2"/>
   <Column ss:Index="4" ss:Width="120"/>
   <Column ss:Width="88"/>
   <Column ss:Width="76.75"/>
   <Column ss:StyleID="s121" ss:Width="89.75"/>
   <Column ss:Width="58.5"/>
   <Column ss:Width="84.75"/>
   <Column ss:Width="80.5"/>
   <Column ss:Width="60"/>
   <Column ss:Width="80"/>
   <Column ss:Width="60"/>
   <Column ss:Width="80"/>
   <Column ss:Width="80"/>
   <Column ss:Width="46.5"/>
   <Column ss:Width="120"/>
   <Column ss:Width="100"/>
   <Column ss:Width="60"/>
   <Column ss:Width="120"/>
   <Row ss:Height="22.5" ss:StyleID="s115">
    <Cell ss:MergeAcross="18" ss:StyleID="s114"><Data ss:Type="String">对账费用</Data></Cell>
   </Row>
   <Row ss:StyleID="s112">
    <Cell ss:Index="1"><Data ss:Type="String">收付类型</Data></Cell>
    <Cell><Data ss:Type="String">业务类型</Data></Cell>
    <Cell><Data ss:Type="String">费用名称</Data></Cell>
    <Cell><Data ss:Type="String">往来单位</Data></Cell>
    <Cell><Data ss:Type="String">订单编号</Data></Cell>
    <Cell><Data ss:Type="String">提单号</Data></Cell>
    <Cell><Data ss:Type="String">柜号</Data></Cell>
    <Cell><Data ss:Type="String">发车日期</Data></Cell>
    <Cell ss:StyleID="s119"><Data ss:Type="String">金额</Data></Cell>
    <Cell><Data ss:Type="String">账单金额</Data></Cell>
    <Cell><Data ss:Type="String">对账状态</Data></Cell>
    <Cell><Data ss:Type="String">本次对账金额</Data></Cell>
    <Cell><Data ss:Type="String">对账状态</Data></Cell>
    <Cell><Data ss:Type="String">核销金额</Data></Cell>
    <Cell><Data ss:Type="String">未核销金额</Data></Cell>
    <Cell><Data ss:Type="String">对账人</Data></Cell>
    <Cell><Data ss:Type="String">对账时间</Data></Cell>
    <Cell><Data ss:Type="String">费用备注</Data></Cell>
    <Cell><Data ss:Type="String">创建人</Data></Cell>
    <Cell><Data ss:Type="String">创建时间</Data></Cell>
    </Row>
<#list feeModelList as feeModel>
    <Row ss:StyleID="s62">
        <Cell ss:Index="1"><Data ss:Type="String">${(feeModel.paymentType)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(feeModel.feeType)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(feeModel.piName)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(feeModel.compyName)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(feeModel.orderNo)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(feeModel.businessNo1)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(feeModel.businessNo2)!''}</Data></Cell>
        <Cell ss:StyleID="s122"><Data ss:Type="String">${(feeModel.businessDate)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(feeModel.amount)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(feeModel.billAmount)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(feeModel.feeStatus)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(feeModel.reconAmount)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(feeModel.fiDoneSts)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(feeModel.fiDoneAmount)!''}</Data></Cell>
        <Cell ss:StyleID="s120"><Data ss:Type="Number">${(feeModel.unFiDoneAmount)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(feeModel.reconPsn)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(feeModel.reconTime)!''}</Data></Cell>
        <Cell ss:StyleID="s123"><Data ss:Type="String">${(feeModel.remarks)!''}</Data></Cell>
        <Cell><Data ss:Type="String">${(feeModel.createBy)!''}</Data></Cell>
        <Cell ss:StyleID="s122"><Data ss:Type="String">${(feeModel.createTime)!''}</Data></Cell>
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
