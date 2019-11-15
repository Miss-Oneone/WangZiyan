function echartsConfig(option) {
	require.config({
	    paths: {
	        echarts: ctxStatic + '/sunsail/lib/echarts'
	    }
	});
	require(
	    [
	        'echarts',
	        'echarts/chart/line',
	        'echarts/chart/bar',
	        'echarts/chart/pie',
	    ],
	    function (ec) {
	    	echartsInit(ec, option);
	    }
	);
}

var createEcharts = {
	"1":createBar,
	"2":createPie,
	"3":createLine
}

function createChart(gridObj, chartPar) {
    var gridDataObj = gridObj.jqGrid("getRowData");
    var option = {};
    if (gridDataObj.length > 0) {
    	option = createEcharts[chartPar.type](gridDataObj, chartPar);
    }
    return option;
}

function createLine(gridDataObj, chartPar) {
	var propertyNms = Object.getOwnPropertyNames(gridDataObj[0]);
    var propertyNmsLen = propertyNms.length;
    var xAxisAry = [];
    var legendAry = [];
    var seriesAry = [];
    var seriesData = [];
    var colNmsAry = chartPar.colNmsAry;

    if (propertyNmsLen > 0) {
        if (propertyNmsLen > 1) {
        	if (chartPar.seriesType == "1") {//seriesType:1 row;seriesType:2 col
        		xAxisAry = colNmsAry.slice(1);//propertyNms.slice(1);
        		
        		$(gridDataObj).each(function(index){
        			legendAry.push(eval("(" + "this." + propertyNms[0] + ")"));
        			
        			seriesData[index] = [];
        			for (var j = 0; j < xAxisAry.length; j++) {
                		seriesData[index].push(eval("(" + "this." + propertyNms[j + 1] + ")"));
                	}
        			
                	subSeries = {};
                	subSeries.name = legendAry[index];
                	subSeries.type = "line";
                	subSeries.data = seriesData[index];
                	
                	seriesAry.push(subSeries);
                });
        	} else {
        		legendAry = colNmsAry.slice(1);//propertyNms.slice(1);
                for (var i = 0; i < legendAry.length; i++) {
                	seriesData[i] = [];
                	subSeries = {};
                	subSeries.name = legendAry[i];
                	subSeries.type = "line";
                	subSeries.data = seriesData[i];
                	
                	seriesAry.push(subSeries);
                }
                
                $(gridDataObj).each(function(){
                    xAxisAry.push(eval("(" + "this." + propertyNms[0] + ")"));
                    for (var i = 0; i < legendAry.length; i++) {
                    	seriesData[i].push(eval("(" + "this." + propertyNms[i + 1] + ")"));
                    }
                });
        	}
            
        }
    } else {
        return;
    }
    
    option = {
    	title: {text: chartPar.title},
    	tooltip: {
    		trigger: 'item'
    	},
        calculable : true,
        legend: {orient: 'vertical', x: 'left', y: 'center', data: legendAry},
        xAxis: [
            {
                type: "category",
                data: xAxisAry
            }
        ],
        yAxis: [
            {
                type: "value"
            }
        ],
        series: seriesAry
    }
    
    return option;
}

function createBar(gridDataObj, chartPar) {
	var propertyNms = Object.getOwnPropertyNames(gridDataObj[0]);
    var propertyNmsLen = propertyNms.length;
    var xAxisAry = [];
    var legendAry = [];
    var seriesAry = [];
    var seriesData = [];
    var colNmsAry = chartPar.colNmsAry;

    if (propertyNmsLen > 0) {
        if (propertyNmsLen > 1) {
        	if (chartPar.seriesType == "1") {//seriesType:1 row;seriesType:2 col
        		xAxisAry = colNmsAry.slice(1);//propertyNms.slice(1);
        		
        		$(gridDataObj).each(function(index){
        			legendAry.push(eval("(" + "this." + propertyNms[0] + ")"));
        			
        			seriesData[index] = [];
        			for (var j = 0; j < xAxisAry.length; j++) {
                		seriesData[index].push(eval("(" + "this." + propertyNms[j + 1] + ")"));
                	}
        			
                	subSeries = {};
                	subSeries.name = legendAry[index];
                	subSeries.type = "bar";
                	subSeries.data = seriesData[index];
                	
                	seriesAry.push(subSeries);
                });
        	} else {
        		legendAry = colNmsAry.slice(1);//propertyNms.slice(1);
                for (var i = 0; i < legendAry.length; i++) {
                	seriesData[i] = [];
                	subSeries = {};
                	subSeries.name = legendAry[i];
                	subSeries.type = "bar";
                	subSeries.data = seriesData[i];
                	
                	seriesAry.push(subSeries);
                }
                
                $(gridDataObj).each(function(){
                    xAxisAry.push(eval("(" + "this." + propertyNms[0] + ")"));
                    for (var i = 0; i < legendAry.length; i++) {
                    	seriesData[i].push(eval("(" + "this." + propertyNms[i + 1] + ")"));
                    }
                });
        	}
        }
    } else {
        return;
    }
    
    option = {
    	title: {text: chartPar.title},
    	tooltip: {
            trigger: 'item'
        },
        calculable : true,
        legend: {orient: 'vertical', x: 'right', y: 'center', data: legendAry},
        xAxis: [
            {
                type: "category",
                data: xAxisAry
            }
        ],
        yAxis: [
            {
                type: "value"
            }
        ],
        series: seriesAry
    }

    return option;
}

function createPie(gridDataObj, chartPar) {
	var propertyNms = Object.getOwnPropertyNames(gridDataObj[0]);
    var propertyNmsLen = propertyNms.length;
    var xAxisAry = [];
    var legendAry = [];
    var seriesData = [];
    var colNmsAry = chartPar.colNmsAry;

    if (propertyNmsLen > 0) {
        if (propertyNmsLen > 1) {
        	if (chartPar.seriesType == "1") {//seriesType:1 row;seriesType:2 col
        		legendAry = colNmsAry.slice(1);//propertyNms.slice(1);
        		$(gridDataObj).each(function(index){
                    for (var i = 0; i < legendAry.length; i++) {
                    	var dataObj = {};
                    	dataObj.name =legendAry[i];
        				dataObj.value = eval("(" + "this." + propertyNms[i + 1] + ")");
        				seriesData.push(dataObj);
                    }
                    return false;
                });
        	} else {
        		$(gridDataObj).each(function(){
                	legendAry.push(eval("(" + "this." + propertyNms[0] + ")"));
                    var dataObj = {};
                    dataObj.value = eval("(" + "this." + propertyNms[1] + ")");
                    dataObj.name = eval("(" + "this." + propertyNms[0] + ")");
                    seriesData.push(dataObj);
                });
        	}
        }
    } else {
        return;
    }
    
    option = {
    	title: {text: chartPar.title},
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {orient: 'vertical', x: 'left', y: 'center', data: legendAry},
        calculable : true,
        series: [
            {
                "name": "",
                "type": "pie",
                "data": seriesData
            }
        ]
    }
    
    return option;
}