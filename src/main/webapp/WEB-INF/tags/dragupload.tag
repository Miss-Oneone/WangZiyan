<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID" %>
<%@ attribute name="attachmentType" type="java.lang.String" required="false" description="附件种类" %>
<%@ attribute name="beforeUpload" type="java.lang.String" required="false" description="文件上传前执行的回调函数" %>
<%@ attribute name="onUpload" type="java.lang.String" required="false" description="文件上传执行的回调函数" %>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输" %>
<%@ attribute name="allowed" type="java.lang.String" required="false" description="允许上传的文件类型" %>
<%@ attribute name="sufixNames" type="java.lang.String" required="false" description="允许上传的文件类型(文件后缀名)" %>
<%@ attribute name="maxFileSize" type="java.lang.String" required="false" description="允许上传的最大文件尺寸" %>
<%@ attribute name="errorHandler" type="java.lang.String" required="false" description="用于处理错误信息的方法" %>
<%@ attribute name="multiple" type="java.lang.String" required="false" description="多选" %>
<%@ attribute name="tip" type="java.lang.String" required="false" description="显示的提示文字" %>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="样式" %>
<%@ attribute name="cssStype" type="java.lang.String" required="false" description="样式" %>
<%@ attribute name="params" type="java.lang.String" required="false" description="回调函数传参" %>
<style>
    .upload-box {
        float: left;overflow: hidden;
    }
    .drop-zone {
        border: 1px dashed #ddd; width: 200px;height: 120px;margin: 10px;font-size: 16px;text-align: center;border-radius: 5px;
    }
    .upload-box .hovering{
        background-color: #d1d1d1;
    }
    .upload-box .drop-zone:hover {
        border-color: #409eff;
    }
    .upload-box .file-input {
        width: 100%;
        height: 100%;
        position: relative;
        top: -100px;
        opacity: 0;
    }
    .upload-box .tip {
        font-size: 14px;
        color: #626262;
    }
    .upload-box .icon {
        font-size: 40px;
        color: #c0c4cc;
        margin: 0px;
    }
</style>
<div id="${id}_upload_box" class="upload-box">
    <div>
        <div id="${id}_drop_zone" class="drop-zone ${cssClass}" style="${cssStype}">
            <p class="icon"><i class="Hui-iconfont">&#xe642;</i></p>
            <p class="tip">${empty tip ? '将文件拖到此处，或点击上传' : tip}</p>
            <c:if test="${empty multiple or multiple eq 'false' }">
                <input type="file" id="${id}_file_input" class="file-input" onchange="${id}handleFileDrop(this)">
            </c:if>
            <c:if test="${multiple eq 'true'}">
                <input type="file" id="${id}_file_input" class="file-input" multiple onchange="${id}handleFileDrop(this)">
            </c:if>
        </div>
    </div>
</div>
<script>
    // 声明error code
    var NOT_MATCH_FILE_TYPE, FILE_SIZE_LIMIT
    if (!NOT_MATCH_FILE_TYPE) {
        NOT_MATCH_FILE_TYPE = 0; // 文件类型不匹配
    }
    if (!FILE_SIZE_LIMIT) {
        FILE_SIZE_LIMIT = 1; // 文件超过限制大小
    }
    var ${id}${attachmentType}attachmentType = '${empty attachmentType ? id : attachmentType}'

    $(document).ready(function () {
        ${id}initDragEvent()
    });

    //文件进入事件
    function ${id}handleFileDragEnter(e) {
        //不再派发事件
        e.stopPropagation();
        //取消事件的默认动作
        e.preventDefault();
        //为当前元素添加CSS样式（这里使用到的样式均会在下面展示出来）
        this.classList.add('hovering');
    }

    //文件离开事件
    function ${id}handleFileDragLeave(e) {
        e.stopPropagation();
        e.preventDefault();
        //为当前元素移除CSS样式
        this.classList.remove('hovering');
    }

    //文件拖拽完成效果
    function ${id}handleFileDragOver(e) {
        e.stopPropagation();
        e.preventDefault();
        //把拖动的元素复制到放置目标（注1会给出dropEffect详细属性）。
        e.dataTransfer.dropEffect = 'copy';
        var notAllowed = $("#${id}_file_input").is('.not-allowed')
        if (notAllowed) {
            e.dataTransfer.dropEffect = 'none';
        }
    }

    //文件拖拽到页面后处理方式
    function ${id}handleFileDrop(e) {
        var files
        // 1拖拽上传
        if (e.stopPropagation) {
            e.stopPropagation();
            e.preventDefault();
            //为当前元素移除CSS样式
            this.classList.remove('hovering');
            //target 事件属性可返回事件的目标节点（触发该事件的节点），如生成事件的元素、文档或窗口。
            files = e.dataTransfer.files;
            if (!files || files.length == 0) {
                files = e.target.files;
            }

        // 2点击上传
        } else {
            files = e.files
        }

        var notAllowed = $("#${id}_file_input").is('.not-allowed')
        if (notAllowed) {
            return false;
        }

        //文件类型控制
        if ('${allowed}') {
            var allowedFlag = true;
            for (var i=0; i< files.length; i++) {
                var type = files[i].type.replace('image/', '');
                // 用文件名后缀名判断（苹果系统部分文件不支持问题解决方案）
                var sufixName = files[i].name.substring(files[i].name.indexOf('.') + 1);
                if ((!type || '${allowed}'.indexOf(type) < 0) && (!sufixName || '${sufixNames}'.indexOf(sufixName) < 0)) {
                    allowedFlag = false;
                    break
                }
            }
            if (!allowedFlag) {
                document.getElementById('${id}_file_input').value = '';
                <%=errorHandler%>(${id}${attachmentType}attachmentType, NOT_MATCH_FILE_TYPE, ${params})
                return
            }
        }

        //文件大小控制
        if ('${maxFileSize}') {
            var maxFileSizeFlag = true;
            for (var i=0; i< files.length; i++) {
                if (Number('${maxFileSize}') < files[i].size) {
                    maxFileSizeFlag = false
                }
            }
            if (!maxFileSizeFlag) {
                document.getElementById('${id}_file_input').value = '';
                <%=errorHandler%>(${id}${attachmentType}attachmentType, FILE_SIZE_LIMIT, ${params})
                return
            }
        }

        //文件上传前回调函数
        if (<%=beforeUpload%>&&files&&files.length>0) {
            <%=beforeUpload%>({files: files}, ${id}${attachmentType}attachmentType, ${params})
        }

        //文件上传回调函数
        if (<%=onUpload%>&&files&&files.length>0) {
            <%=onUpload%>({files: files}, ${id}${attachmentType}attachmentType, ${params})
        }
    }

    function ${id}initDragEvent() {
        //为四种方法生成addEventListener事件监听器，addEventListener有三个参数：第一个参数表示事件名称；第二个参数表示要接收事件处理的函数；第三个参数为 useCapture（一般来说为false，true会更改响应顺序），
        var dropZone = document.getElementById('${id}_drop_zone')
        dropZone.addEventListener('dragenter', ${id}handleFileDragEnter, false);
        dropZone.addEventListener('dragleave', ${id}handleFileDragLeave, false);
        dropZone.addEventListener('dragover', ${id}handleFileDragOver, false);
        dropZone.addEventListener('drop', ${id}handleFileDrop, false);
    }
</script>
