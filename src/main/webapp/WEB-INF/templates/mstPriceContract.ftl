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
  <Table ss:ExpandedColumnCount="30" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Index="2" ss:Width="100"/>
   <Column ss:Width="120"/>
   <Column ss:Width="100"/>
   <Column ss:Width="100"/>
   <Column ss:Width="80"/>
   <Column ss:Width="50"/>
   <Column ss:Width="100"/>
   <Column ss:Width="100"/>
   <Column ss:Width="100"/>
   <Column ss:Width="60"/>
   <Column ss:Width="60"/>
   <Column ss:Width="60"/>
   <Column ss:Width="60"/>
   <Column ss:Width="60"/>
   <Column ss:Width="60"/>
   <Column ss:Width="100"/>
   <Column ss:Width="60"/>
   <Column ss:Width="100"/>

   <Row ss:Height="22.5" ss:StyleID="s115">
    <Cell ss:MergeAcross="20" ss:StyleID="s114"><Data ss:Type="String">价格协议</Data></Cell>
   </Row>
   <Row ss:StyleID="s113">
    <Cell ss:Index="2"><Data ss:Type="String">价格协议编码</Data></Cell>
    <Cell><Data ss:Type="String">协议名称</Data></Cell>
    <Cell><Data ss:Type="String">协议有效开始日期</Data></Cell>
    <Cell><Data ss:Type="String">协议有效结束日期</Data></Cell>
    <Cell><Data ss:Type="String">结算类型</Data></Cell>
    <Cell><Data ss:Type="String">应到款天数</Data></Cell>
    <Cell><Data ss:Type="String">外排海沧提卸费</Data></Cell>
    <Cell><Data ss:Type="String">港杂费包干天数</Data></Cell>
    <Cell><Data ss:Type="String">充电费包干天数</Data></Cell>
    <Cell><Data ss:Type="String">备注1</Data></Cell>
    <Cell><Data ss:Type="String">备注2</Data></Cell>
    <Cell><Data ss:Type="String">备注3</Data></Cell>
    <Cell><Data ss:Type="String">备注4</Data></Cell>
    <Cell><Data ss:Type="String">备注5</Data></Cell>
    <Cell><Data ss:Type="String">创建人</Data></Cell>
    <Cell><Data ss:Type="String">创建时间</Data></Cell>
    <Cell><Data ss:Type="String">更新人</Data></Cell>
    <Cell><Data ss:Type="String">更新时间</Data></Cell>
   </Row>
   <#list list as mstPriceContractModel>
        <Row ss:StyleID="s62">
			<Cell ss:Index="2" ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.priceContractNo)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.contractName)!''}</Data></Cell>
            <Cell ss:StyleID="s112"><Data ss:Type="String">${(mstPriceContractModel.effectStartTime)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(mstPriceContractModel.effectEndTime)!''}</Data></Cell>
            <Cell ss:StyleID="s112"><Data ss:Type="String">${(mstPriceContractModel.settlementTypeName)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.settlementDays)!''}</Data></Cell>
			<Cell ss:StyleID="s120"><Data ss:Type="String">${(mstPriceContractModel.outHctxFee)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(mstPriceContractModel.portMiscellDays)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(mstPriceContractModel.chartingDays)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.remarks1)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.remarks2)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.remarks3)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.remarks4)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.remarks5)!''}</Data></Cell>
			<Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.createBy)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(mstPriceContractModel.createTimeFmt)!''}</Data></Cell>
            <Cell ss:StyleID="s119"><Data ss:Type="String">${(mstPriceContractModel.updateBy)!''}</Data></Cell>
			<Cell ss:StyleID="s112"><Data ss:Type="String">${(mstPriceContractModel.updateTimeFmt)!''}</Data></Cell>
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
