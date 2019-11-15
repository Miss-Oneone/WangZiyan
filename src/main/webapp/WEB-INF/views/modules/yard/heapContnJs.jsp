<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var heapContns, form;
    $(document).ready(function () {
        heapContns = JSON.parse('${heapContns}')
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
                changeHeapType(data.field.heapType)
                return false;
            });
            form.on('submit(heapTypeCancel)', function(data){
                getHeapTypeByHeapNo();
                $('.heap-types').hide();
                $('.mask').hide();
                return false;
            });
            getHeapTypeByHeapNo();
        });
    })

    function changeContnNo(e, pi, i) {
        var contnNo = e.value.toUpperCase();
        e.value = contnNo;
        var heapContnNo = heapContns[pi].heapContns[i].heapContnNo
        var $options = $("#contnNoOptions-" + heapContnNo);
        if (contnNo) {
            $options.addClass('actived')
            $options.show();
            $.ajax({
                url: "${ctxZG}/container/getLikeContnNos?contnNo="+contnNo,
                type: "post",
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        $options.html('')
                        var likeContnNos = obj.dataModel;
                        var html = '';
                        for (var idx in likeContnNos) {
                            html += '<p onclick="choseContnNo(\''+ likeContnNos[idx] + '\'' + ',' + pi + ',' + i + ')">' + likeContnNos[idx] + '</p>'
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
        } else {
            $options.removeClass('actived')
            $options.hide();
        }
    }

    var choseContnNoFlag = false;
    function choseContnNo(contnNo, pi, i) {
        choseContnNoFlag = true;
        updateContnNo(pi, i, contnNo);
        reRendering(pi, i);
        choseContnNoFlag = false;
        $(".contnNoOptions").eq(0).html('');
        $(".contnNoOptions").eq(0).hide();
    }

    function closeContnNoOptions(e, pi, i) {
        setTimeout(function () {
            if (choseContnNoFlag) {
                return;
            }
            heapContns[pi].heapContns[i].contnNo = e.value;
            $(".contnNoOptions.actived").html('');
            $(".contnNoOptions.actived").hide();
            reRendering(pi, i);
            choseContnNoFlag = false;
        }, 400)
    }
    
    function changeRemarks(e, pi, i) {
        updateRemarks(pi, i, e.value)
    }

    function del(pi, i) {
        updateContnNo(pi, i, '');
        updateRemarks(pi, i, '');
        updateHeapContnType(pi, i, '');
        reRendering(pi, i);
    }

    function updateContnNo(pi, i, contnNo) {
        // 修改全局数据
        heapContns[pi].heapContns[i].contnNo = contnNo;
        // 修改展示数据
        var heapContnNo = heapContns[pi].heapContns[i].heapContnNo;
        $("#" + heapContnNo).val(contnNo);
    }

    function updateRemarks(pi, i, remarks) {
        // 修改全局数据
        heapContns[pi].heapContns[i].remarks = remarks;
        // 修改展示数据
        var heapContnNo = heapContns[pi].heapContns[i].heapContnNo;
        $("#r" + heapContnNo).val(remarks);
    }


    function updateHeapContnType(pi, i, heapContnType) {
        // 修改全局数据
        heapContns[pi].heapContns[i].heapContnType = heapContnType;
        // 修改展示数据
        $("#heap-c-t-" + heapContns[pi].heapContns[i].heapContnNo).val(heapContnType);
    }

    var layerIndex2, mPi = -1, mI = -1;
    function move(pi, i) {
        mPi = pi; mI = i;
        layerIndex2  = layer.open({
            type : 2,
            area : [ "600px", "420px"  ],
            title : false,
            content : "${ctxZG}/yard/heapContnMoveView?contnNo=" + heapContns[pi].heapContns[i].contnNo,
            anim: 1,
            cancel : function() {
                //do nothing
            }
        })
        $("#layui-layer" + layerIndex2).css("background-color","rgba(255, 255, 255, 0)")
    }

    function close(flag) {
        layer.close(layerIndex2);
        if (flag) {
            // 清空转移位置的箱号
            heapContns[mPi].heapContns[mI].contnNo = '';
            updateContnNo(mPi, mI, '');
        }
    }

    function up(pi, i) {
        var tempContnNo = heapContns[pi].heapContns[i].contnNo;
        var tempRemarks = heapContns[pi].heapContns[i].remarks;
        var tempHeapContnType = heapContns[pi].heapContns[i].heapContnType;
        updateContnNo(pi, i, heapContns[pi].heapContns[i-1].contnNo);
        updateRemarks(pi, i, heapContns[pi].heapContns[i-1].remarks);
        updateHeapContnType(pi, i, heapContns[pi].heapContns[i-1].heapContnType);
        updateContnNo(pi, i-1, tempContnNo);
        updateRemarks(pi, i-1, tempRemarks);
        updateHeapContnType(pi, i-1, tempHeapContnType);
        reRendering(pi, i);
        reRendering(pi, i-1);
    }

    function down(pi, i) {
        var tempContnNo = heapContns[pi].heapContns[i].contnNo;
        var tempRemarks = heapContns[pi].heapContns[i].remarks;
        var tempHeapContnType = heapContns[pi].heapContns[i].heapContnType;
        updateContnNo(pi, i, heapContns[pi].heapContns[i+1].contnNo);
        updateRemarks(pi, i, heapContns[pi].heapContns[i+1].remarks);
        updateHeapContnType(pi, i, heapContns[pi].heapContns[i+1].heapContnType);
        updateContnNo(pi, i+1, tempContnNo);
        updateRemarks(pi, i+1, tempRemarks);
        updateHeapContnType(pi, i+1, tempHeapContnType);
        reRendering(pi, i);
        reRendering(pi, i+1);
    }
    
    function reRendering(pi, i) {
        var item = heapContns[pi].heapContns[i];
        var heapContnNo = item.heapContnNo;
        var contnNo = item.contnNo;
        $("#del" + heapContnNo).addClass(contnNo != '' && contnNo != null ? "i-show" : "i-hide").removeClass(contnNo != '' && contnNo != null ? "i-hide" : "i-show");
        $("#move" + heapContnNo).addClass(contnNo != '' && contnNo != null ? "i-show" : "i-hide").removeClass(contnNo != '' && contnNo != null ? "i-hide" : "i-show");
        $("#up" + heapContnNo).addClass(contnNo != '' && contnNo != null && i != 0 ? "i-show" : "i-hide").removeClass(contnNo != '' && contnNo != null && i != 0 ? "i-hide" : "i-show");
        $("#down" + heapContnNo).addClass(contnNo != '' && contnNo != null && i != heapContns[pi].heapContns.length-1 ? "i-show" : "i-hide").removeClass(contnNo != '' && contnNo != null && i != heapContns[pi].heapContns.length-1 ? "i-hide" : "i-show");
    }

    function save() {
        $.ajax({
            url: "${ctxZG}/yard/updateHeapContns",
            type: "post",
            data: {heapContns: JSON.stringify(heapContns)},
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    showTip("保存成功");
                    setTimeout(function () {
                        parent.close();
                    }, 1000)
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function getHeapTypeByHeapNo() {
        $.ajax({
            url: "${ctxZG}/yard/getHeapTypeByHeapNo?heapNo=${heapNo}",
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $("input:radio[value=" + obj.dataModel + "]").trigger('click');
                    form.render();
                    var allHeapTypes = JSON.parse('${heapTypes}');
                    var heapTypeName = '';
                    for (var idx in allHeapTypes) {
                        if (allHeapTypes[idx].value == obj.dataModel) {
                            heapTypeName = allHeapTypes[idx].label;
                            break;
                        }
                    }
                    $("#heap-chose").eq(0).html(heapTypeName);
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function openHeapType() {
//        getHeapTypeByHeapNo();
        $('.heap-types').show();
        $('.mask').show();
    }

    function changeHeapType(heapType) {
        $.ajax({
            url: "${ctxZG}/yard/changeHeapType?heapNo=${heapNo}&heapType=" + heapType,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    showTip("修改成功");
                    $('.heap-types').hide();
                    $('.mask').hide();
                    getHeapTypeByHeapNo();
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function cancel() {
        parent.close();
    }

    // 箱子根据floor排序
    function contnFloorSort(pi) {
       heapContns[pi].heapContns.sort(compare('floor'));
    }
    function compare(property){
        return function(a,b){
            var value1 = a[property];
            var value2 = b[property];
            return value2 - value1;
        }
    }

    function changeHeapContnType(e, pi, i) {
        heapContns[pi].heapContns[i].heapContnType = e.value;
    }
</script>