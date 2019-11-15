<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Created>2015-06-05T18:19:34Z</Created>
  <LastSaved>2017-06-19T06:31:40Z</LastSaved>
  <Version>16.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
  <RemovePersonalInformation/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>12648</WindowHeight>
  <WindowWidth>22260</WindowWidth>
  <WindowTopX>0</WindowTopX>
  <WindowTopY>0</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font ss:FontName="等线" x:CharSet="134" ss:Size="11" ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s16">
   <Font ss:FontName="等线" x:CharSet="134" ss:Size="11" ss:Color="#FFFFFF"/>
   <Interior ss:Color="#595959" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s17">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#333333"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#333333"/>
   </Borders>
   <Font ss:FontName="Tahoma" x:Family="Swiss" ss:Size="9" ss:Color="#333333"/>
   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s18">
   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#333333"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#333333"/>
   </Borders>
   <Font ss:FontName="Tahoma" x:Family="Swiss" ss:Size="9" ss:Color="#333333"/>
   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s19">
   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table ss:ExpandedColumnCount="13" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultRowHeight="13.8">
   <Column ss:Width="60.6"/>
   <Column ss:Width="75"/>
   <Column ss:Width="51.6"/>
   <Column ss:Width="81"/>
   <Column ss:Width="63"/>
   <Column ss:Width="51.6"/>
   <Column ss:Width="30"/>
   <Column ss:Width="51.6"/>
   <Column ss:Width="301.79999999999995"/>
   <Column ss:Width="51.6" ss:Span="1"/>
   <Column ss:Index="12" ss:Width="78"/>
   <Column ss:Width="30"/>
   <Row ss:StyleID="s16">
    <Cell><Data ss:Type="String">导入批次</Data></Cell>
    <Cell><Data ss:Type="String">导入文件名</Data></Cell>
    <Cell><Data ss:Type="String">往来单位</Data></Cell>
    <Cell><Data ss:Type="String">提单号</Data></Cell>
    <Cell><Data ss:Type="String">集装箱号</Data></Cell>
    <Cell><Data ss:Type="String">费用名称</Data></Cell>
    <Cell><Data ss:Type="String">金额</Data></Cell>
    <Cell><Data ss:Type="String">发生日期</Data></Cell>
    <Cell><Data ss:Type="String">校验异常信息</Data></Cell>
    <Cell><Data ss:Type="String">强制通过</Data></Cell>
    <Cell><Data ss:Type="String">提交状态</Data></Cell>
    <Cell><Data ss:Type="String">校验通过标志 </Data></Cell>
    <Cell><Data ss:Type="String">备注</Data></Cell>
   </Row>
   <#list list as model> 
	   <Row ss:Height="23.400000000000002" ss:StyleID="s19">
	    <Cell ss:StyleID="s17"><Data ss:Type="Number">${(model.importBatchNo)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.excelFileName)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.relatedCompyCode)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.blNo)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.coninNo)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.piName)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="Number">${(model.amount)!''}</Data></Cell>
	    <Cell ss:StyleID="s18"><Data ss:Type="DateTime">${(model.occurDate)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.checkRemarks)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.forceFlag)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.submitTypeFat)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.checkSucessFlagFat)!''}</Data></Cell>
	    <Cell ss:StyleID="s17"><Data ss:Type="String">${(model.checkRemarks)!''}</Data></Cell>
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
     <ActiveRow>8</ActiveRow>
     <ActiveCol>8</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
