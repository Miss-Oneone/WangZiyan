<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var dragWidth = 4252, dragHeight = 3685, maxScale = 1, minScale = 0.2;
    var hammerFuncs, initX, initY, posTargetEleId;
    var enableScaleAdd = true, enableScaleDel = true;
    $(document).ready(function(){
        screenResize();
        hammerFuncs = hammerEle("drag");
        initPosEle();
        window.onmousewheel = scrollFunc;
        initUpload();
        countHeapContns();

        $("#importedPlan").click(function(){
            layerIndex = layer.open({
                title: '已导计划',
                type : 2,
                area : [ "600px", "420px" ],
                content : "${ctxZG}/yard/heapPlanImportHd",
                maxmin : true,
                cancel : function() {
                    //do nothing
                }
            })
            layer.full(layerIndex);
        })

        $("#planList").click(function(){
            layerIndex = layer.open({
                type : 2,
                area : [ "600px", "420px" ],
                title : '计划列表',
                content : "${ctxZG}/yard/heapPlan",
                maxmin : true,
                cancel : function() {
                    //do nothing
                }
            })
            layer.full(layerIndex);
        })
        layui.use(['carousel', 'form'], function(){
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#container'
                ,width: '100%' //设置容器宽度
                ,height: '100%' //设置容器高度
                ,arrow:  'always'//始终显示箭头
                ,index: 0
                ,full: true
                ,autoplay: false
                ,indicator: 'inside'
            });

            form = layui.form;

            //监听提交
            form.on('submit(heapTypeSubmit)', function(data){
                $('.heap-types').hide();
                $('.mask').hide();
                highlight(data.field.heapType)
                var allHeapTypes = JSON.parse('${heapTypes}');
                var heapTypeName = '';
                for (var idx in allHeapTypes) {
                    if (allHeapTypes[idx].value == data.field.heapType) {
                        heapTypeName = allHeapTypes[idx].label;
                        break;
                    }
                }
                if (!heapTypeName) {
                    heapTypeName = '全部';
                }
                $("#heap-types-btn").html(heapTypeName.substring(0,2));
                return false;
            });
            form.on('submit(heapTypeCancel)', function(data){
                $('.heap-types').hide();
                $('.mask').hide();
                return false;
            });
        });
    })

    function screenResize() {
        var width = window.outerWidth;
        var height = window.outerHeight;
       initX = Math.ceil((width - dragWidth)/2 + width/10);
       initY = Math.ceil((height - dragHeight)/2) - 120;
        var ele = document.getElementById("drag");
        ele.style.transform = "translate3d(" + initX + "px, " + initY + "px, 0) scale(" + 0.5 + ")";
    }

    function scrollFunc(e) {
        if (e.target.getAttribute("isOptions")) {
            return;
        }
        if (e.deltaY > 0) {
            scaleDel()
        } else {
            scaleAdd()
        }
    }

    function initUpload() {
        layui.use('upload', function(){
            var upload = layui.upload;

            //执行实例
            var uploadInst = upload.render({
                elem: '#importPlan' //绑定元素
                ,url: '${ctxZG}/yard/importPlans' //上传接口
                ,field: 'files'
                ,accept: 'file'
                ,done: function(res){
                    //上传完毕回调
                    if (res.resultType < 0) {
                        showError(res.resultMsg);
                    } else {
                        showTip("导入成功");
                    }
                }
                ,error: function(){
                    //请求异常回调
                    showError("系统未知错误");
                }
            });
        });
    }
    
    function countHeapContns() {
        $.ajax({
            url: "${ctxZG}/yard/countHeapContns",
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $("#totalHeapContns").html(obj.dataModel)
                } else {
                    $("#totalHeapContns").html("统计出错...")
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function create() {
        alert("create");
    }

    function center() {
        fixedPosition()
    }

    function scaleAdd() {
        hammerFuncs.scaleAdd();
        enableScale();
    }

    function scaleDel() {
        hammerFuncs.scaleDel();
        enableScale();
    }

    function enableScale() {
        enableScaleAdd = hammerFuncs.getParams().z != maxScale;
        enableScaleDel = hammerFuncs.getParams().z != minScale;
        $("#scaleAdd").prop("disabled", !enableScaleAdd);
        $("#scaleDel").prop("disabled", !enableScaleDel);
    }
    
    function initPosEle(heapNo, isSetCurrent) {
        var posEle = document.getElementById('pos');
        if (heapNo) {
            posEle.style.display = 'block';
            posTargetEleId = heapNo;
            var current = hammerFuncs.getParams();
            hammerFuncs = hammerEle('drag', posTargetEleId, isSetCurrent ? current : '');
            var posTargetEle = document.getElementById(posTargetEleId);
            var posTargetEleRect = posTargetEle.getBoundingClientRect()
            // posEle.style.top = (posTargetEleRect.top - posEle.offsetHeight + Math.round(posTargetEleRect.height / 2)) + 'px';
            // posEle.style.left = (posTargetEleRect.left - Math.round(posEle.offsetWidth / 2) + Math.round(posTargetEleRect.width / 2)) + 'px';
            var posy = (posTargetEleRect.top - posEle.offsetHeight + Math.round(posTargetEleRect.height / 2)) + 0;
            var posx = (posTargetEleRect.left - Math.round(posEle.offsetWidth / 2) + Math.round(posTargetEleRect.width / 2));
            posEle.style.transition = 'all 0ms'
            posEle.style.transform = "translate3d(" + posx + "px, " + posy + "px, 0) scale(" + 1 + ")";
        } else {
            posEle.style.display = 'none';
        }
    }

    var layerIndex;
    function choseContn(heapNo, stock) {
        initPosEle(heapNo, true);
        $("#pos").attr("title", stock);
        layerIndex = layer.open({
            type : 2,
            area : [ "600px", "420px" ],
            title : false,
            content : "${ctxZG}/yard/heapContnView?heapNo=" + heapNo,
            cancel : function() {
                //do nothing
            },
            end : function(){

            }
        })
    }
    <%--var layerIndex2--%>
    <%--function moveView() {--%>
        <%--layerIndex2  = layer.open({--%>
            <%--type : 2,--%>
            <%--area : [ "600px", "420px"  ],--%>
            <%--title : false,--%>
            <%--content : "${ctxZG}/yard/heapContnMoveView",--%>
            <%--anim: 1,--%>
            <%--cancel : function() {--%>
                <%--//do nothing--%>
            <%--}--%>
        <%--})--%>
        <%--$("#layui-layer" + layerIndex2).css("background-color","rgba(255, 255, 255, 0)")--%>
    <%--}--%>

    function close() {
        layer.close(layerIndex);
    }

//    function colseHeapContnMove() {
//        layer.close(layerIndex2);
//    }

    // 定位中心点
    function fixedPosition() {
        // 计算目标在中心点的偏移量
        var body = document.body;
        var ele = document.getElementById('drag');
        var eleRect = ele.getBoundingClientRect();
        var posTargetEle = document.getElementById(posTargetEleId);
        var posTargetEleRect = posTargetEle.getBoundingClientRect()
        // var mx = Math.round(body.clientWidth/2 - posTargetEleRect.left + eleRect.left)
        // var my = Math.round(body.clientHeight/2 - posTargetEleRect.top + eleRect.top)
        var mx = Math.round(body.clientWidth/2 - posTargetEleRect.left)
        var my = Math.round(body.clientHeight/2 - posTargetEleRect.top)
        var posEle = document.getElementById('pos');
        posEle.style.zIndex = '-100';
        // 设置偏移量
        var translates = getTransformValue('drag');
        mx = mx + translates[4];
        my = my + translates[5];
        ele.style.transform = "translate3d(" + mx + "px, " + my + "px, 0) scale(" + translates[0] + ")";
        ele.style.transition = 'all 0ms'
        hammerFuncs.setCurrent({x: mx, y: my, z: translates[0]})
        // ele.style.left = (mx + 430) + 'px'; // 不知道计算后数值老差430, 200，这里暂时直接补上
        // ele.style.top = (my + 200) + 'px';
        // 重新获取目标坐标并计算和赋值标记坐标
        posTargetEleRect = posTargetEle.getBoundingClientRect();
        // posEle.style.top = (posTargetEleRect.top - posEle.offsetHeight + Math.round(posTargetEleRect.height / 2)) + 'px';
        // posEle.style.left = (posTargetEleRect.left - Math.round(posEle.offsetWidth / 2) + Math.round(posTargetEleRect.width / 2)) + 'px';
        var posy = (posTargetEleRect.top - posEle.offsetHeight + Math.round(posTargetEleRect.height / 2)) + 0;
        var posx = (posTargetEleRect.left - Math.round(posEle.offsetWidth / 2) + Math.round(posTargetEleRect.width / 2));
        posEle.style.transition = 'all 0ms'
        posEle.style.transform = "translate3d(" + posx + "px, " + posy + "px, 0) scale(" + 1 + ")";
        posEle.style.zIndex = '2';

        // hammerFuncs.initParams();
        enableScale();
    }

    function getTransformValue(id) {
        var translates = document.defaultView.getComputedStyle(document.getElementById(id), null).transform;
        var translatesArr = translates.substring(7).split(',');
        var returnArr = [];
        for (var i in translatesArr) {
            returnArr.push(Number.parseFloat(translatesArr[i]))
        }
        return returnArr;
    }

    function inputContnNo(e) {
        e.value = e.value.toUpperCase();
        var contnNo = e.value;
        var $options = $("#contnNoOptions")
        $options.show();
        $.ajax({
            url: "${ctxZG}/yard/searchContns?contnNo="+contnNo,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $options.html('')
                    var likeContnNos = obj.dataModel;
                    var html = '';
                    for (var idx in likeContnNos) {
                        html += '<p isOptions="true" onclick="searchContn(\''+ likeContnNos[idx].contnNo + '\')">' + likeContnNos[idx].contnNo + '<br><span style="font-size: 12px; color: #aaaaaa">位置：' + likeContnNos[idx].heapContnNo + '</span></p>'
                    }
                    $options.html(html);

                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function search() {
        var e = {value: $("#contnNo").val()}
        setTimeout(function () {
            $("#contnNo").focus();
            inputContnNo(e);
        }, 500)
    }

    var choseContnNoFlag = false;
    function searchContn(contnNo) {
        choseContnNoFlag = true;
        // 搜索框赋值
        $("#contnNo").val(contnNo);
        // 查找箱号对应heapno和坐标
        $.ajax({
            url: "${ctxZG}/yard/getHeapNoByContnNo?contnNo="+contnNo,
            type: "post",
            success: function (res) {
                var obj = JSON.parse(res);
                var heapNo = obj.dataModel;
                // 定位
                    // 根据heapNo标记定位
                    initPosEle(heapNo)
                    fixedPosition();

                    // 弹出选择框
                    choseContn(heapNo);
                    choseContnNoFlag = false;
                    closeContnNoOptions();

            }, error: function (xhr, status, error) {
                showError("系统错误");
                choseContnNoFlag = false;
            }
        })
    }

    function closeContnNoOptions() {
        setTimeout(function () {
            if (choseContnNoFlag) {
                return;
            }
            $("#contnNoOptions").html('');
            $("#contnNoOptions").hide();
            choseContnNoFlag = false;
        },400)
    }

    function importPlan() {
        layerIndex = layer.open({
            type : 2,
            area : [ "400px", "220px" ],
            title : false,
            content : "${ctxZG}/yard/heapPlanImport",
            cancel : function() {
                //do nothing
            }
        })
    }

    function openHeapType() {
        $('.heap-types').show();
        $('.mask').show();
    }
    
    function highlight(highlightHeapType) {
        var heaps = JSON.parse('${heaps}')
        if (highlightHeapType) {
            for (var idx in heaps) {
                $("#code-" + heaps[idx].heapNo).css({'color': '#111','border-color': '#111'})
                if (heaps[idx].heapType == highlightHeapType) {
                    $("#code-" + heaps[idx].heapNo).css({'color': '#ffbb00','border-color': '#ffbb00'})
                } else if ( heaps[idx].mixContnTypes &&
                    heaps[idx].mixContnTypes.indexOf(highlightHeapType) > -1) {
                    // 判断其他类型里面是否有该类型
                    $("#code-" + heaps[idx].heapNo).css({'color': '#ffbb00','border-color': '#ffbb00'})
                }
            }
        } else {
            for (var idx in heaps) {
                $("#code-" + heaps[idx].heapNo).css({'color': '#111','border-color': '#111'})
            }
        }
    }

    // 拖拽缩放
    function hammerEle(elmid, posTargetEleid, opts) {
        var element = document.getElementById(elmid)
        var hammertime = new Hammer(element, {});

        hammertime.get('pinch').set({ enable: true });
        hammertime.get('pan').set({ threshold: 0 });

        var fixHammerjsDeltaIssue = undefined;
        var pinchStart = { x: undefined, y: undefined }
        var lastEvent = undefined;
        var maxScale = 1;
        var minScale = 0.2;

        var originalSize = {
            width: element.clientWidth,
            height: element.clientHeight
        }

        var current = {
            x: initX,
            y: initY,
            z: 0.5,
            zooming: false,
            width: originalSize.width * 1,
            height: originalSize.height * 1,
        }
        if (opts) {
            current = opts;
        }

        var last = {
            x: current.x,
            y: current.y,
            z: current.z
        }

        function getRelativePosition(element, point, originalSize, scale) {
            var domCoords = getCoords(element);

            var elementX = point.x - domCoords.x;
            var elementY = point.y - domCoords.y;

            var relativeX = elementX / (originalSize.width * scale / 2) - 1;
            var relativeY = elementY / (originalSize.height * scale / 2) - 1;
            return { x: relativeX, y: relativeY }
        }

        function getCoords(elem) { // crossbrowser version
            var box = elem.getBoundingClientRect();

            var body = document.body;
            var docEl = document.documentElement;

            var scrollTop = window.pageYOffset || docEl.scrollTop || body.scrollTop;
            var scrollLeft = window.pageXOffset || docEl.scrollLeft || body.scrollLeft;

            var clientTop = docEl.clientTop || body.clientTop || 0;
            var clientLeft = docEl.clientLeft || body.clientLeft || 0;

            var top  = box.top +  scrollTop - clientTop;
            var left = box.left + scrollLeft - clientLeft;

            return { x: Math.round(left), y: Math.round(top) };
        }

        function scaleFrom(zoomOrigin, currentScale, newScale) {
            var currentShift = getCoordinateShiftDueToScale(originalSize, currentScale);
            var newShift = getCoordinateShiftDueToScale(originalSize, newScale)

            var zoomDistance = newScale - currentScale

            var shift = {
                x: currentShift.x - newShift.x,
                y: currentShift.y - newShift.y,
            }

        var output = {
                x: zoomOrigin.x * shift.x,
                y: zoomOrigin.y * shift.y,
                z: zoomDistance
            }
            return output
        }

        function getCoordinateShiftDueToScale(size, scale){
            var newWidth = scale * size.width;
            var newHeight = scale * size.height;
            var dx = (newWidth - size.width) / 2
            var dy = (newHeight - size.height) / 2
            return {
                x: dx,
                y: dy
            }
        }

        hammertime.on('doubvarap', function(e) {
            var scaleFactor = 1;
            if (current.zooming === false) {
                current.zooming = true;
            } else {
                current.zooming = false;
                scaleFactor = -scaleFactor;
            }

            element.style.transition = "0.3s";
            setTimeout(function() {
                element.style.transition = "none";
            }, 300)

            var zoomOrigin = getRelativePosition(element, { x: e.center.x, y: e.center.y }, originalSize, current.z);
            var d = scaleFrom(zoomOrigin, current.z, current.z + scaleFactor)
            current.x += d.x;
            current.y += d.y;
            current.z += d.z;

            last.x = current.x;
            last.y = current.y;
            last.z = current.z;

            update();
        })

        hammertime.on('pan', function(e) {
            if (lastEvent !== 'pan') {
                fixHammerjsDeltaIssue = {
                    x: e.deltaX,
                    y: e.deltaY
                }
            }

            current.x = last.x + e.deltaX - fixHammerjsDeltaIssue.x;
            current.y = last.y + e.deltaY - fixHammerjsDeltaIssue.y;
            lastEvent = 'pan';
            update();
        })

        hammertime.on('pinch', function(e) {
            var d = scaleFrom(pinchZoomOrigin, last.z, last.z * e.scale)
            current.z = Math.max(Math.min(d.z + last.z, maxScale), minScale);
            if (current.z != maxScale && current.z != minScale) {
                current.x = d.x + last.x + e.deltaX;
                current.y = d.y + last.y + e.deltaY;
            }
            lastEvent = 'pinch';
            update();
        })

        var pinchZoomOrigin = undefined;
            hammertime.on('pinchstart', function(e) {
            pinchStart.x = e.center.x;
            pinchStart.y = e.center.y;
            pinchZoomOrigin = getRelativePosition(element, { x: pinchStart.x, y: pinchStart.y }, originalSize, current.z);
            lastEvent = 'pinchstart';
        })

        hammertime.on('panend', function(e) {
            last.x = current.x;
            last.y = current.y;
            lastEvent = 'panend';
        })

        hammertime.on('pinchend', function(e) {
            last.x = current.x;
            last.y = current.y;
            last.z = current.z;
            lastEvent = 'pinchend';
        })

        function update(speed) {
            var defaultSpeed = 0;
            if (speed) {
                defaultSpeed = speed;
            }
            element.style.transition = 'all ' + defaultSpeed + 'ms'
            current.height = originalSize.height * current.z;
            current.width = originalSize.width * current.z;
            element.style.transform = "translate3d(" + current.x + "px, " + current.y + "px, 0) scale(" + current.z + ")";
            updatePos(speed);
        }

        function updatePos(speed) {
            if (posTargetEleid) {
                // setTimeout(() => {
                var defaultSpeed = 0;
                if (speed) {
                    defaultSpeed = speed;
                }

                var posEle = document.getElementById('pos');
                var posTargetEle = document.getElementById(posTargetEleid);
                var posTargetEleRect = posTargetEle.getBoundingClientRect()
                // posEle.style.top = (posTargetEleRect.top - posEle.offsetHeight + Math.round(posTargetEleRect.height / 2)) + 'px';
                // posEle.style.left = (posTargetEleRect.left - Math.round(posEle.offsetWidth / 2) + Math.round(posTargetEleRect.width / 2)) + 'px';
                var posy = (posTargetEleRect.top - posEle.offsetHeight + Math.round(posTargetEleRect.height / 2)) + 0;
                var posx = (posTargetEleRect.left - Math.round(posEle.offsetWidth / 2) + Math.round(posTargetEleRect.width / 2));
                posEle.style.transition = 'all ' + defaultSpeed + 'ms'
                posEle.style.transform = "translate3d(" + posx + "px, " + posy + "px, 0) scale(" + 1 + ")";
                // }, speed)
            }
        }

        function initParams() {
            fixHammerjsDeltaIssue = undefined;
            pinchStart = { x: undefined, y: undefined }
            lastEvent = undefined;

            originalSize = {
                width: element.clientWidth,
                height: element.clientHeight
            }

            current = {
                x: initX,
                y: initY,
                z: 0.3,
                zooming: false,
                width: originalSize.width * 1,
                height: originalSize.height * 1,
            }

            last = {
                x: current.x,
                y: current.y,
                z: current.z
            }
        }

        function scaleAdd() {
            current.z = Math.min(current.z + 0.1, maxScale);
            update(0);
        }

        function scaleDel() {
            current.z = Math.max(current.z - 0.1, minScale);
            update(0);
        }

        function getParams() {
            return current;
        }

        function setCurrent(obj) {
            current.x = obj.x;
            current.y = obj.y;
            current.z = obj.z;
            last.x = obj.x;
            last.y = obj.y;
            last.z = obj.z;
        }

        var funcs = {
            initParams: initParams,
            scaleAdd: scaleAdd,
            scaleDel: scaleDel,
            getParams: getParams,
            setCurrent: setCurrent
        }

        return funcs;
    }

    function reloadYard() {
        window.location.reload();
    }
</script>
