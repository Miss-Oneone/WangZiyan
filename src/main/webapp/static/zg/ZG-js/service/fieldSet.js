function down(upId,downId,tblId){
	document.getElementById(tblId).style.display="none";
	document.getElementById(downId).style.display="none";
	document.getElementById(upId).style.display="inline";
} 
function up(upId,downId,tblId){
	document.getElementById(tblId).style.display="inline";
	document.getElementById(downId).style.display="inline";
	document.getElementById(upId).style.display="none";
}
