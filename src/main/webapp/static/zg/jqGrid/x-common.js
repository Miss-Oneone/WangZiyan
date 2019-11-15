/*
* @Name			        common.js
* @Modify           2005/05/15
* @author			      lixd<lixd@tops.com.cn>
* @version		      1.0
* @copyright(c)     2005
*
*/

function nvl(v, def){
	if(v == null || v == undefined)
		return def;
	else
		return v;
}
function chkStr(checkStr,checkOK,NotZero){
  if (checkStr == ""){return false;}
  
  if (NotZero==1&&parseFloat(checkStr)==0) return false;
  var allValid = true;
  var i, j;
  for (i = 0;  i < checkStr.length;  i++)
  {
    ch = checkStr.charAt(i);
    for (j = 0;  j < checkOK.length;  j++)
      if (ch == checkOK.charAt(j))
      break;
    if (j == checkOK.length)
    {
      allValid = false;
      break;
    }
  }
  return (allValid);
}

/* TODO
 * 
 */
function isUrl(url){
	if(url.length<5) return false;
	return true;
}
/*
function: goUrl
功能：
导向一个URL地址
参数：
url:目标URL值
isNew:是否要在新窗口中打开
email:字串
Author: lixd<lixd@tops.com.cn>
*/
function goUrl(url,isNew){
  if (isNew) {
    window.open(url);
  }
  else{
    document.location.href=url;
  }
}
/*
function: checkall
功能：
用于将传入的一个Checkbox对象全部选中/不选
参数：
objchk：Checkbox对象
check：对象要赋予的值，boolean型，值为true/false
Author: lixd<lixd@tops.com.cn>
*/
function checkAll(objchk,check) {
	if (objchk==null) return false;
	var i;
    if (objchk.length==null){
		objchk.checked=check;
	}	
    else{
		for(i=0; i<objchk.length; i++){
			objchk[i].checked=check;
		}
	}
}
/*
function: checkall
功能：
1、用于将传入的一个Checkbox对象全部选中/不选
2、将Checkbox设置可用/不可用
参数：
objchk：Checkbox对象
check：对象要赋予的值，boolean型，值为true/false
Author: lixd<lixd@tops.com.cn>
*/
function checkAll2(objchk,check) {
	if (objchk==null) return false;
	var i;
    if (objchk.length>1)
	for(i=0; i<objchk.length; i++){
		objchk[i].checked=check;
		objchk[i].disabled=check;
	}
    else{
		objchk.checked=check;
		objchk.disabled=check;
    }
}
/*
function: ischeck
功能：
用来检查是一个Checkbox对象是否至少被选中一个
参数：
objchk：Checkbox对象
Author: lixd<lixd@tops.com.cn>
*/
function isCheck(objchk) {
	var i;
	if (objchk==null) return false;
	if (objchk.length==null){
		return objchk.checked;
	}
    else{
		for(i=0; i<objchk.length; i++){
			if (objchk[i].checked) return true;
		}
	}
    return false;
}

function isAllCheck(objchk) {
	var i;
	if (objchk==null) return false;
	if (objchk.length==null){
		return objchk.checked;
	}
  else{
		for(i=0; i<objchk.length; i++){
			if (!objchk[i].checked) return false;
		}
	}
  return true;
}

function checkSub(objchk,key,check){
	if (objchk==null) return false;
	var i;
	//select parent node then select all child node
    if (objchk.length==null){
		if(objchk.value.indexOf(key)==0){
			objchk.checked=check;
		}
	}	
    else{
		for(i=0; i<objchk.length; i++){
			if(objchk[i].value.indexOf(key)==0) {
				objchk[i].checked=check;
			}
		}
	}
	//if child is checked,then his parent must be also checked
    if (objchk.length!=null&&check){
		for(i=0; i<objchk.length; i++){
			if(key.indexOf(objchk[i].value)==0) {
				objchk[i].checked=check;
			}
		}
	}	
}
function getObjectValue(obj,delimiter){
	var s='',i;
	if (obj==null) return '';
	if(delimiter==null)delimiter=",";
  if (obj.length==null){
	   return obj.value;
	}
	else
      for(i=0; i<obj.length; i++){
        s=s+delimiter+obj[i].value;
      }
    if (s!='')
		if(s.indexOf(delimiter)==0)
		   s=s.substring(delimiter.length);
    return s;
}

function strToDate(str){
	//2012-12-31 HH:mm:ss
	if(str.length < 10) return null;
	try{
		var yr, mn, dy, hr = 0, mi = 0, sec = 0;
		yr = parseInt(str.substr(0, 4));
		mn = parseInt(str.substr(5, 2)) - 1;
		dy = parseInt(str.substr(8, 2));
		str = str.substr(11);
		if(str.length > 0) hr = parseInt(str.substr(0, 2));
		if(str.length > 2) mi = parseInt(str.substr(3, 2));
		if(str.length > 5) sec = parseInt(str.substr(6, 2));
		return new Date(yr, mn, dy, hr, mi, sec);
	}
	catch(e){
		return null;
	}
}

function fmtDate(){
  var d = new Date();                       // 创建 Date 对象。
  var s = d.getFullYear(), s1 = "";
  s1 = "" + (d.getMonth() + 1);
  if(s1.length == 1) s1 = "0" + s1;
  s += "-" + s1;            // 获取月份。
  s1 = "" + d.getDate();
  if(s1.length == 1) s1 = "0" + s1;
  s += "-" + s1;            // 获取日。
  return s;
}


function fmtDateFirst(){
	var d = new Date(); 
	var s = d.getFullYear(), s1 = "";
	s1 = "" + (d.getMonth() + 1);
	if(s1.length == 1) s1 = "0" + s1;
	s += "-" + s1;          // 获取月份。
	s += "-01";            	// 获取日。
	return s;
}

function fmtDate(d, useTime, useSecond){
	if(d == null) d = new Date();
	var s = d.getFullYear(), s1 = "";
	s1 = "" + (d.getMonth() + 1);
	if(s1.length == 1) s1 = "0" + s1;
	s += "-" + s1;            // 获取月份。
	s1 = "" + d.getDate();
	if(s1.length == 1) s1 = "0" + s1;
	s += "-" + s1;            // 获取日。
	if(useTime){
		s1 = "" + d.getHours();
		if(s1.length == 1) s1 = "0" + s1;
		s += " " + s1;
		s1 = "" + d.getMinutes();
		if(s1.length == 1) s1 = "0" + s1;
		s += ":" + s1;
		if(useSecond){
			s1 = "" + d.getSeconds();
			if(s1.length == 1) s1 = "0" + s1;
			s += ":" + s1;
		}
	}
	return s;
}

function fmtDate2(d){
	if(d == null || d == "" || d == "null") return "";
  var s = d.getFullYear(), s1 = "";
  s1 = "" + (d.getMonth() + 1);
  if(s1.length == 1) s1 = "0" + s1;
  s += "-" + s1;            // 获取月份。
  s1 = "" + d.getDate();
  if(s1.length == 1) s1 = "0" + s1;
  s += "-" + s1;            // 获取日。
  return s;
}


function dateAdd(dt, mill){
	if(dt == null) return null;
	var d = new Date();           
	d.setTime(dt.getTime() + mill); 
	return d;
}

function truncDate(d, incSecond){
	if(incSecond)
		return d.substr(0, 19);
	else
		return d.substr(0, 16);
}

/*
function: getcheckvalue
功能：
用来得到一个Checkbox对象被选中的项的字符串联合
参数：
objchk:Checkbox对象
delimiter:连接的字符
Author: lixd<lixd@tops.com.cn>
*/
function getCheckValue(objchk, delimiter) {
	var s='',i;
	if (objchk==null) return '';
	if(delimiter==null)delimiter=",";
    if (objchk.length==null){
	   if(objchk.checked) s=objchk.value;
	}
	else
      for(i=0; i<objchk.length; i++){
        if (objchk[i].checked) s=s+delimiter+objchk[i].value;
      }
    if (s!='')
		if(s.indexOf(delimiter)==0)
		   s=s.substring(delimiter.length);
    return s;
}
/**
得到一个单选框选中的顺序，如果只有一个，则表示为0
*/
function getCheckedIndex(obj) {
	var res = -1,i;
	if (obj == null) return res;
  if (obj.length==null){
	  if(obj.checked) res = 0;
  }
	else{
    for(i=0; i < obj.length; i++){
      if(obj[i].checked){
        res = i;
		    break;
      }
    }
  }
	return res;
}

function getCheckedObj(obj) {
	var Res = null,i;
	if (obj == null) return Res;
  if (obj.length==null){
    if(obj.checked) Res = obj;
  }
	else{
    for(i=0; i < obj.length; i++){
      if(obj[i].checked){
        Res = obj[i]; 
        break;
      }
    }
  }
	return Res;
}

function ExtractFileExt(filename){
	var iPos;
	iPos=filename.lastIndexOf(".");
	if(iPos==-1) return "";							//没有扩展名
	return filename.substr(iPos+1);			//返回扩展名，不带.
}
/*
function: checkemail
功能：
检查一个输入的字串是否是合法的邮件地址格式
参数：
email:字串
Author: lixd<lixd@tops.com.cn>
*/
function checkEmail(email){
  var oRegExp = /^[a-z0-9]([a-z0-9_\-\.]*)@([a-z0-9_\-\.]*)(\.[a-z]{2,3}(\.[a-z]{2}){0,2})$/i;
  return oRegExp.test(email);
}
/*
function: changebg
功能：
改变一个对象的背景色彩
参数：
it:要改变的对象
color:改变的色彩值
email:字串
Author: lixd<lixd@tops.com.cn>
*/
function changeBg(it,color){
	it.bgColor=color;
}

function isUInt(v){
  var re = /^[\d]+$/;
  return re.test(v);
}

function isInt(v,us){
  var s = "0123456789";
  if(us != null) s += "-";
	return chkStr(v,s);
}

function isFloat(v, us){
  var s = "0123456789.";
  if(us != null) s += "-";
	return chkStr(v,s);
}

function inArray(c, arr){
  for(var i = 0; i< arr.length; i++)
    if(c == arr[i]) return true;
  return false;
}

function mergeCell(tb,col,iBegin){
	if (isNaN(iBegin)) iBegin=1;
	if(iBegin<0||iBegin>=tb.rows.length) return false;

	var iPreIndex=iBegin;
	var sPreText=tb.rows(iPreIndex).cells(col).innerText;
	var sCurText="";
	for(var i=iBegin+1;i<tb.rows.length;i++){
		sCurText=tb.rows(i).cells(col).innerText;
		if(sCurText==sPreText){//需要合并
			tb.rows(iPreIndex).cells(col).rowSpan++;
			tb.rows(i).deleteCell(col);
		}
		else{
			iPreIndex=i;
			sPreText=sCurText;
		}
	}
}

function setstatus(s){
	window.status=s;
}

function extractFileExt(s){
	var i=s.lastIndexOf(".");
	if(i>=0)
		return s.substring(i+1);
	else
		return "";
}

String.prototype.trim = function(){ 
	return this.replace(/(^s*)|(s*$)/g, ""); 
};

String.prototype.ltrim = function(){ 
	return this.replace(/(^s*)/g, ""); 
} ;
String.prototype.rtrim = function(){ 
	return this.replace(/(s*$)/g, ""); 
};

String.prototype.replaceAll = function(s1,s2) { 
    return this.replace(new RegExp(s1,"gm"),s2); 
};

//为什么不支持？
//JSON.prototype.print = function(){
//  return JSON.stringify(this);
//};
function alertJSON(o){
  alert(JSON.stringify(o));
}

function getJSONString(o){
  return JSON.stringify(o);
}

function checkExpr(rule){
	alert(rule);return;
  eval( 'rule = ' +$(this).attr('rule') + ';'); 
  if(rule.valid instanceof RegExp && !rule.valid.test($(this).val())){
    if(opts.onFail != null) opts.onFail(this, rule.message); 
    b = false; 
    }
  else if(rule.valid instanceof Function && !rule.valid($(this).val(), this)){
      if(opts.onFail != null) opts.onFail(this, rule.message); 
    b = false; 
  }
}

function getCookie(cookieName) {
	var cookieValue = '';
	var posName = document.cookie.indexOf(escape(cookieName) + '=');
	if (posName != -1) {
		var posValue = posName + (escape(cookieName) + '=').length;
		var endPos = document.cookie.indexOf(';', posValue);
		if (endPos != -1) 
			cookieValue = unescape(document.cookie.substring(posValue, endPos));
		else 
			cookieValue = unescape(document.cookie.substring(posValue));
	}
	//alert(cookieValue);
	return (cookieValue);
};

function setCookie(cookieName, cookieValue, expires, path, domain, secure) {
	document.cookie =
		escape(cookieName) + '=' + escape(cookieValue)
		+ (expires ? '; expires=' + expires.toGMTString() : '')
		+ (path ? '; path=' + path : '')
		+ (domain ? '; domain=' + domain : '')
		+ (secure ? '; secure' : '');
	//alert(document.cookie);
};
//设置回车键为TAB
document.onkeydown=function(event){
	var e = event || window.event;
	var oSrc = e.srcElement;
	var sType='',oNext;
	if(e.keyCode == 27 || e.keyCode==117||e.keyCode==114){//ESC F6、F5、F3 禁止 e.keyCode==116||
		e.keyCode=0;
		e.returnValue=false;
	}
	if (e.keyCode == 13){		 
	    if(oSrc.getAttribute("next") != null){
	      oNext = document.all(oSrc.getAttribute("next"));
	      if(oNext) oNext.focus();
	      e.keyCode = 0;
	      e.returnValue=false;
	      return;
	    }
	    if(oSrc.tagName == 'INPUT'){
	      sType = oSrc.type.toUpperCase();
	      if(sType == 'TEXT' || sType == 'PASSWORD' || sType == 'RADIO'){
	        //e.keyCode = 9;
	        return;
	      }
    }
    if(oSrc.tagName == "SELECT")
      e.keyCode = 9;
	}
};
//导出提示
function encodeParam(param) {
	   return param.replace(/&/g, "^");
	}

/*
document.onselectstart=function(){
	var sTagName=event.srcElement.tagName;
	if(sTagName!='INPUT'&&sTagName!='TEXTAREA'){
		event.keyCode=0;
		event.returnValue=false;
	}
}*/

//限制游览器行为
/*
document.oncontextmenu = function(){
	var sTagName=event.srcElement.tagName;
	if(sTagName!='INPUT'&&sTagName!='TEXTAREA')
		return false;
}
document.onhelp=function(){// F1键帮助处理
  window.open("http://www.asponline.com.cn/forum");
	return false;
}
*/
