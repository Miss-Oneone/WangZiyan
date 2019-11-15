//运单号生成,create by chy 2014.6.27
function lspDelivNumInport(fristNum,count,classify) {
	var numArr = [];
	var pattern = /^[0-9]*$/;
	if(classify =="YZGNXB" || classify =="EMS") {
		if(fristNum.length != 13 || !pattern.test(fristNum)) {
			alert("第一个运单号不正确,请输入正确的运单号");
			return false;
		}
		numArr = EMSLspDelivNum(fristNum,count);
	}else if(classify =="SF") {
		if(fristNum.length != 12 || !pattern.test(fristNum)) {
			alert("第一个运单号不正确,请输入正确的运单号");
			return false;
		}
		numArr = SFLspDelivNum(fristNum,count);
	}else {
		if(!pattern.test(fristNum)) {
			alert("第一个运单号不正确,请输入正确的运单号");
			return false;
		}
		numArr = LspDelivNum(fristNum,count);
	}
	return numArr;
}

//EMS,国内邮政小包运单号生成 start
function EMSLspDelivNum(fristNum,count) {
	var numArr = [];
	for(var i = 0; i < count; i++) {
		var fristTwoNum = fristNum.substring(0,2);
		var middleEightNum = fristNum.substring(2,10);
		var calculateMiddleEightNum = EMSMiddleNumCalculate(middleEightNum);
		var calculateCheckNum = EMSCheckNumCalculate(calculateMiddleEightNum);
		var lastTwoNum = fristNum.substring(11,13);
		var NumStr = fristTwoNum + calculateMiddleEightNum + calculateCheckNum + lastTwoNum;
		numArr[i] = NumStr;
		fristNum = NumStr;
	}
	return numArr;
}
function EMSMiddleNumCalculate(middleEightNum) {
	var middleEightNum_INT = parseInt(middleEightNum) + 1;
	var middleEightNum_STR = "00000000" + middleEightNum_INT;
	var middleEightNum_STR_8 = middleEightNum_STR.substring(middleEightNum_STR.length-8,middleEightNum_STR);
	return middleEightNum_STR_8;
}
function EMSCheckNumCalculate(middleEightNum) {
	var num_1 = parseInt(middleEightNum.substring(0,1));
	var num_2 = parseInt(middleEightNum.substring(1,2));
	var num_3 = parseInt(middleEightNum.substring(2,3));
	var num_4 = parseInt(middleEightNum.substring(3,4));
	var num_5 = parseInt(middleEightNum.substring(4,5));
	var num_6 = parseInt(middleEightNum.substring(5,6));
	var num_7 = parseInt(middleEightNum.substring(6,7));
	var num_8 = parseInt(middleEightNum.substring(7,8));
	var checkNum = 11 - ((num_1*8 + num_2*6 + num_3*4 + num_4*2 + num_5*3 + num_6*5 + num_7*9 + num_8*7) % 11);
	if(checkNum == 11) {
		return "5";
	}else if(checkNum == 10) {
		return "0";
	}else {
		return checkNum;
	}
}
//EMS,国内邮政小包运单号生成 end

//SF运单号生成 start
/*
function SFLspDelivNum(fristNum,count) {
	var numArr = [];
	for(var i = 0; i < count; i++) {
		var fristThreeNum = fristNum.substring(0,3);
		var middleEightNum = fristNum.substring(3,11);
		var calculateMiddleEightNum = SFMiddleEightNumCalculate(middleEightNum);
		var lastNum = fristNum.substring(11,12);
		var checkNum = SFChenkNum(calculateMiddleEightNum,lastNum);
		var numStr = fristThreeNum + calculateMiddleEightNum + checkNum;
		numArr[i] = numStr;
		fristNum = numStr;
	}
	return numArr;
}*/

//SF运单号生成 重写  add by cwh 2014/09/26
function SFLspDelivNum(fristNum,count) {
	var numArr = [];
    var fri,xfri,Yuandanhao;
    
    var num1=0;
    var num2=0;
    var num3=0;
    var num4=0;
    var num5=0;
    var num6=0;
    var num7=0;
    var num8=0;
    var num9=0;
    var num10=0;
    var num11=0;
    var num12=0;
    var xNum12=0;
    
    //var xNum1,xNum2,xNum3,xNum4,xNum5,xNum6,xNum7,xNum8,xNum9,xNum10,xNum11,xNum12;
    //var mid;
    
    fri = fristNum.substring(0,11);
    //numArr[0]=fri;
    Yuandanhao=fristNum;
	for(var i = 0; i < count; i++){
		xfri=(parseInt(fri)+1);
        num1=parseInt(Yuandanhao.substring(0, 1));
        num2=parseInt(Yuandanhao.substring(1, 2));
        num3=parseInt(Yuandanhao.substring(2, 3));
        num4=parseInt(Yuandanhao.substring(3, 4));
        num5=parseInt(Yuandanhao.substring(4, 5));
        num6=parseInt(Yuandanhao.substring(5, 6));
        num7=parseInt(Yuandanhao.substring(6, 7));
        num8=parseInt(Yuandanhao.substring(7, 8));
        num9=parseInt(Yuandanhao.substring(8, 9));
        num10=parseInt(Yuandanhao.substring(9, 10));
        num11=parseInt(Yuandanhao.substring(10, 11));
        num12=parseInt(Yuandanhao.substring(11, 12));  //12位没有，就11位，添加两个变量存储原始直

        xfri = xfri.toString();
        /*
        xNum1=parseInt(xfri.substring(0,1));
        xNum2=parseInt(xfri.substring(1,2));
        xNum3=parseInt(xfri.substring(2,3));
        xNum4=parseInt(xfri.substring(3,4));
        xNum5=parseInt(xfri.substring(4,5));
        xNum6=parseInt(xfri.substring(5,6));
        xNum7=parseInt(xfri.substring(6,7));
        xNum8=parseInt(xfri.substring(7,8));
        xNum9=parseInt(xfri.substring(8,9));
        xNum10=parseInt(xfri.substring(9,10));
        xNum11=parseInt(xfri.substring(10,11));
        */
        
        if(num11==9 && num10==9 && num9==9 && num8==9 && num7==9 && num6==9 && num5==9){
        	if(num4==0 || num4==2 || num4==4 || num4==6 || num4==8){
        		xNum12 = (num12 + 5) % 10;
        	} else if(num4==1 || num4==3 || num4==5 || num4==7){
        		xNum12 = (num12 + 4) % 10;
        	}
        }else if(num11==9 && num10==9 && num9==9 && num8==9 && num7==9 && num6==9){
        	if(num5==0 || num5==1 || num5==2 || num5==4 || num5==5 || num5==7 || num5==8){
        		xNum12 = (num12 + 9) % 10;
        	} else if(num5==3 || num5==6){
        		xNum12 = (num12 + 8) % 10;
        	}
        }else if(num11==9 && num10==9 && num9==9 && num8==9 && num7==9){
        	if(num6==0 || num6==1 || num6==2 || num6==3|| num6==4 || num6==5 || num6==6 || num6==7 || num6==8){
        		xNum12 = (num12 + 3) % 10;
        	}
        }else if(num11==9 && num10==9 && num9==9 && num8==9){
        	if(num7==0){
        		xNum12 = (num12 + 7) % 10;
        	}else if(num7==1 || num7==2 || num7==3|| num7==4 || num7==5 || num7==6 || num7==7 || num7==8){
        		xNum12 = (num12 + 6) % 10;
        	}
        }else if(num11==9 && num10==9 && num9==9){
        	if(num8==0 || num8==3 || num8==6){
        		xNum12 = (num12 + 0) % 10;
        	}else if(num8==1 || num8==2 || num8==4 || num8==5 || num8==7 || num8==8){
        		xNum12 = (num12 + 9) % 10;
        	}
        }else if(num11==9 && num10==9){
        	if(num9==0 || num9==2 || num9==4 || num9==6 || num9==8){
        		xNum12 = (num12 + 3) % 10;
        	}else if(num9==1 || num9==3 || num9==5 || num9==7){
        		xNum12 = (num12 + 2) % 10;
        	}
        }else if(num11==9){
        	if(num10==0 || num10==1 || num10==2 || num10==4 || num10==5 || num10==7 || num10==8){
        		xNum12 = (num12 + 6) % 10;
        	}else if(num10==3 || num10==6){
        		xNum12 = (num12 + 5) % 10;
        	}
        }else{
        	xNum12 = (num12 + 9) % 10;
        }
        
        numArr[i]=xfri.concat(xNum12);
        Yuandanhao=xfri.concat(xNum12);
        fri=(parseInt(fri)+1);
	}
	
	return numArr;	
}

function SFMiddleEightNumCalculate(middleEightNum) {
	var calculateMiddleEightNum_INT = parseInt(middleEightNum) + 1;
	var calculateMiddleEightNum_STR = "00000000" + calculateMiddleEightNum_INT;
	var calculateMiddleEightNum_STR_8 = calculateMiddleEightNum_STR.substring(calculateMiddleEightNum_STR.length-8,calculateMiddleEightNum_STR.length);
	return calculateMiddleEightNum_STR_8;
}
function SFChenkNum(calculateMiddleEightNum,lastNum) {
	var checkNum = 0;
	switch(calculateMiddleEightNum.substring(7,8)) {
		case "9" :
			switch(calculateMiddleEightNum.substring(6,7)) {
				case "0" :
				case "1" :
				case "2" :
				case "4" :
				case "5" :
				case "7" :
				case "8" :
					checkNum = (parseInt(lastNum) + 6) % 10;
					break;
				case "3" :
				case "6" :
					checkNum = (parseInt(lastNum) + 5) % 10;
					break;
				case "9" :
					switch(calculateMiddleEightNum.substring(5,6)) {
						case "0":
						case "2":
						case "4":
						case "6":
						case "8":
							checkNum = (parseInt(lastNum) + 3) % 10;
							break;
						case "1":
						case "3":
						case "5":
						case "7":
							checkNum = (parseInt(lastNum) + 2) % 10;
							break;
						case "9":
							switch(calculateMiddleEightNum.substring(4,5)) {
								case "0":
								case "3":
								case "6":
									checkNum = (parseInt(lastNum)) % 10;
									break;
								case "1":
								case "2":
								case "4":
								case "5":
								case "7":
								case "8":
									checkNum = (parseInt(lastNum) + 9) % 10;
									break;
								case "9":
									switch(calculateMiddleEightNum.substring(3,4)) {
										case "0":
											checkNum = (parseInt(lastNum) + 7) % 10;
											break;
										case "1":
										case "2":
										case "3":
										case "4":
										case "5":
										case "6":
										case "7":
										case "8":
											checkNum = (parseInt(lastNum) + 6) % 10;
											break;
										case "9":
											switch(calculateMiddleEightNum.substring(2,3)) {
												case "0":
												case "1":
												case "2":
												case "3":
												case "4":
												case "5":
												case "6":
												case "7":
												case "8":
													checkNum = (parseInt(lastNum) + 3) % 10;
													break;
												case "9":
													switch(calculateMiddleEightNum.substring(1,2)) {
														case "0":
														case "1":
														case "2":
														case "4":
														case "5":
														case "7":
														case "8":
															checkNum = (parseInt(lastNum) + 9) % 10;
															break;
														case "3":
														case "6":
															checkNum = (parseInt(lastNum) + 8) % 10;
															break;
														case "9":
															switch(calculateMiddleEightNum.substring(0,1)) {
																case "0":
																case "2":
																case "4":
																case "6":
																case "8":
																	checkNum = (parseInt(lastNum) + 5) % 10;
																	break;
																case "1":
																case "3":
																case "5":
																case "7":
																	checkNum = (parseInt(lastNum) + 4) % 10;
																	break;
															}
															break;
													}
													break;
											}
											break;
									}
									break;
							}
							break;
					}
					break;
			}
			break;
		default :
			checkNum = (parseInt(lastNum) + 9) % 10;
			break;
	}
	return checkNum;
}
//SF运单号生成 end

//运单号生成 start
function LspDelivNum(fristNum,count) {
	var length = fristNum.length;
	var numArr = [];
	for(var i = 0; i < count; i++) {
		var fristNum_INT = parseInt(fristNum);
		var calculateNum = fristNum_INT + 1;
		var calculateNum_STR = "00000000000000" + calculateNum;
		var calculateNum_length = calculateNum_STR.substring(calculateNum_STR.length - length,calculateNum_STR.length);
		numArr[i] = calculateNum_length;
		fristNum = calculateNum_length;
	}
	return numArr;
}
//运单号生成 end