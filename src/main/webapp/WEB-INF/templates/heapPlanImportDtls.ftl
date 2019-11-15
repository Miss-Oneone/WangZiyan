<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Created>2015-06-05T18:19:34Z</Created>
  <LastSaved>2019-10-12T08:46:17Z</LastSaved>
  <Version>16.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
  <RemovePersonalInformation/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>12645</WindowHeight>
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
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s17">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
 </Styles>
 <Worksheet ss:Name="计划整理">
  <Table ss:ExpandedColumnCount="6" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="14.25">
   <Column ss:AutoFitWidth="0" ss:Width="67.5"/>
   <Column ss:AutoFitWidth="0" ss:Width="106.5"/>
   <Column ss:AutoFitWidth="0" ss:Width="84.75"/>
   <Column ss:Index="5" ss:AutoFitWidth="0" ss:Width="69.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="92.25"/>
   <Row>
    <Cell ss:StyleID="s16"><Data ss:Type="String">堆编号</Data></Cell>
    <Cell ss:StyleID="s16"><Data ss:Type="String">货号</Data></Cell>
    <Cell ss:StyleID="s16"><Data ss:Type="String">箱号</Data></Cell>
    <Cell ss:StyleID="s16"><Data ss:Type="String">箱数</Data></Cell>
    <Cell ss:StyleID="s16"><Data ss:Type="String">停放位置</Data></Cell>
    <Cell ss:StyleID="s16"><Data ss:Type="String">需要移动柜子数量</Data></Cell>
   </Row>
   <#list dtlList as dtl>
       <Row>
        <Cell ss:StyleID="s17"><Data ss:Type="String">${(dtl.heapNo)!''}</Data></Cell>
       </Row>
       <#list dtl.heapPlanModels as d>
          <Row>
              <Cell ss:StyleID="s17"><Data ss:Type="String"></Data></Cell>
              <Cell ss:StyleID="s17"><Data ss:Type="String">${(d.goodsNo)!''}</Data></Cell>
              <Cell ss:StyleID="s17"><Data ss:Type="String">${(d.contnNo)!''}</Data></Cell>
              <Cell ss:StyleID="s17"><Data ss:Type="Number">${(d.quantity)!''}</Data></Cell>
              <Cell ss:StyleID="s17"><Data ss:Type="String">${(d.position)!''}</Data></Cell>
              <Cell ss:StyleID="s17"><Data ss:Type="String">${(d.cntNeedMoveContn)!''}</Data></Cell>
          </Row>
       </#list>
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
    <HorizontalResolution>300</HorizontalResolution>
    <VerticalResolution>300</VerticalResolution>
   </Print>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>14</ActiveRow>
     <ActiveCol>9</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
