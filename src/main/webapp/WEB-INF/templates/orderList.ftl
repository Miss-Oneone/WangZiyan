<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
          xmlns:o="urn:schemas-microsoft-com:office:office"
          xmlns:x="urn:schemas-microsoft-com:office:excel"
          xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
          xmlns:html="http://www.w3.org/TR/REC-html40">
    <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
        <Created>2015-06-05T18:19:34Z</Created>
        <LastSaved>2019-05-24T02:48:38Z</LastSaved>
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
             <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
              <Font ss:FontName="Arial" x:Family="Swiss" ss:Bold="1" ss:Shadow="1"/>
            <NumberFormat ss:Format="###0;\-###0"/>
        </Style>
        <Style ss:ID="s17">
            <Borders>
            <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
        </Style>
        <Style ss:ID="s18">
            <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
            <Borders>
             <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
            <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
            </Borders>
        </Style>
    </Styles>
    <Worksheet ss:Name="订单">
        <Table ss:ExpandedColumnCount="32" ss:ExpandedRowCount="${ExpandedRowCount}" x:FullColumns="1"
               x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="14.25">
            <Column ss:Index="32" ss:AutoFitWidth="0" ss:Width="62.25"/>
            <Row ss:AutoFitHeight="0" ss:Height="32.25">
                <Cell ss:StyleID="s16"><Data ss:Type="String">序号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">订单号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">行程标志</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">收单</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">客户</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">对内货物</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">起始地</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">到达地</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">车牌号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">核定公里数</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">司机</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">运力类型</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">箱号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">箱型</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">封签号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">车架编码</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">车架号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">单据号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">批号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">提单号</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">发车时间</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">业务类型</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">截箱时间</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">还箱时间</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">计费模式</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">单价</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">数量</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">运输方式</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">对外货物</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">接单时间</Data></Cell>
                <Cell ss:StyleID="s16"><Data ss:Type="String">备注</Data></Cell>
            </Row>
            <#list orderList as order>
               <Row>
                   <Cell ss:StyleID="s18"><Data ss:Type="Number">${(order_index + 1)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.orderNo)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.tripFlag)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.acceptOrderFlag)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.cusCode)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.goodsCodeIn)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.startArr)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.distination)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.plateNum)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.adjKm)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.driverCode)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.trailerBelongType)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.contnNo)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.bfLevelCode)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.sealNo)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.frameNo)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.frameNum)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.documentNo)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.batchNo)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.blNo)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.departureDate)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.ioType)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.crossBoxTime)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.changeBoxTime)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.chargingType)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.price)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.count)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.transportType)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.goodsCodeOut)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.orderDate)!''}</Data></Cell>
                   <Cell ss:StyleID="s17"><Data ss:Type="String">${(order.remark)!''}</Data></Cell>
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
                <HorizontalResolution>300</HorizontalResolution>
                <VerticalResolution>300</VerticalResolution>
            </Print>
            <Selected/>
            <Panes>
                <Pane>
                    <Number>3</Number>
                    <ActiveRow>1</ActiveRow>
                    <ActiveCol>1</ActiveCol>
                </Pane>
            </Panes>
            <ProtectObjects>False</ProtectObjects>
            <ProtectScenarios>False</ProtectScenarios>
        </WorksheetOptions>
    </Worksheet>
</Workbook>
