function down(upId,downId,tbl1Id,tbl2Id,tbl3Id){
	document.getElementById(tbl1Id).style.display="none";
	document.getElementById(tbl2Id).style.display="none";
	document.getElementById(tbl3Id).style.display="none";
	document.getElementById(downId).style.display="none";
	document.getElementById(upId).style.display="inline";
} 
function up(upId,downId,tbl1Id,tbl2Id,tbl3Id){
	document.getElementById(tbl1Id).style.display="inline";
	document.getElementById(tbl2Id).style.display="inline";
	document.getElementById(tbl3Id).style.display="inline";
	document.getElementById(downId).style.display="inline";
	document.getElementById(upId).style.display="none";
}