package com.xzg56.jg.modules.mst.oilManagement.web;


import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.common.utils.SearchColumnUtils;
import com.xzg56.jg.modules.mst.oilManagement.model.*;
import com.xzg56.jg.modules.mst.oilManagement.service.OilSearchService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.excel.ImportExcel;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.*;

@RequestMapping(value={"${adminPath}/oilManage"})
@Controller
public class OilSearchController extends BaseController {

	@Autowired
	private OilSearchService oilSearchService;
	
	/**
	 * 初始化
	 * 查询页面
	 */
	@RequestMapping(value = { "init", "" })
	public String dispatchSearch(Model model, HttpServletRequest request, HttpServletResponse response){
		//放置查询条件的model
		OilSearchModel oilSearchModel = new OilSearchModel();
		oilSearchModel.setOwn("true");
		oilSearchModel.setOut("true");
		model.addAttribute("oilSearchModel", oilSearchModel);
		//Grid的表头
		model.addAttribute("gridModel", getGridConfig("oilRecord"));
		//获取所有的车辆号
		List<OilSearchModel> plateNums=oilSearchService.getAllPlateNum();
		//获取所有的司机名
		List<OilSearchModel> driverName=oilSearchService.getAllDriverName();
		model.addAttribute("plateNums",plateNums);
		model.addAttribute("driverName",driverName);
		model.addAttribute("operationTimeFrom", DateUtils.getDateBefore(3));
		model.addAttribute("operationTimeTo", DateUtils.getDate());
		if(StringUtils.isNotEmpty(request.getParameter("selectValue"))){
			SearchColumnUtils.setColumns(oilSearchModel, request.getParameter("selectValue"));
			model.addAttribute("returnFlag", "1");
		}else{
			model.addAttribute("returnFlag", "0");
		}
		return "modules/mst/oilManagement/oilList";
		
	}
	
	public String dispatchBackSearch(Model model, HttpServletRequest request, HttpServletResponse response, String selectValue){
		
		//放置查询条件的model
		OilSearchModel oilSearchModel = new OilSearchModel();
		SearchColumnUtils.setColumns(oilSearchModel, selectValue, OilSearchModel.class, model);
		oilSearchModel.setDriver(oilSearchModel.getDriverCode());
		model.addAttribute("oilSearchModel", oilSearchModel);
		//Grid的表头
		model.addAttribute("gridModel", getGridConfig("oilRecord"));
		//获取所有的车辆号
		List<OilSearchModel> plateNums=oilSearchService.getAllPlateNum();
		//获取所有的司机名
		List<OilSearchModel> driverName=oilSearchService.getAllDriverName();
		model.addAttribute("plateNums",plateNums);
		model.addAttribute("driverName",driverName);
		model.addAttribute("returnFlag", "1");
		
//		return "modules/mst/oilManagement/oilSearch";
		return "modules/mst/oilManagement/oilList";
	}

	/**
	 * 加油记录查询与变更 —— Grid
	 * @param request
	 * @param response
	 * @param model
	 * @return 加油记录查询界面
	 */
	@RequestMapping(value = {"oilRecordList"})
	@ResponseBody
	public String oilRecordList(HttpServletRequest request,
                                HttpServletResponse response, Model model) {
		//获取前台的查询条件
		OilSearch conModel = (OilSearch) JsonUtils.getBean(request, OilSearch.class);
		//
		List<OilSearchModel> editList = oilSearchService.findOilRecordList(conModel);
		JQResultModel resultModel = new JQResultModel(editList, conModel.getPage());
		return JSONObject.fromObject(resultModel).toString();
	}
	
	/**
	 * 通过查看链接
	 * 初始化
	 * 油量分摊页面
	 */
	@RequestMapping(value = { "showOilShare" })
	public String showOilShare(Model model, HttpServletRequest request, HttpServletResponse response){
		String seq=request.getParameter("seqNo");
		OilShareFormModel oilShareFromModel = new OilShareFormModel();
		
		oilShareFromModel=oilSearchService.getThisMessage(seq);
		OilShareFormModel lastMessage=oilSearchService.getLastMessageBySeq(seq);
		//判断是不是第一次加油的信息
		if(lastMessage==null){
			//是第一次的加油记录，将上次的加油时间设置为记录里的加油时间
			//上次油箱油量（%）设置为本次加油后的油箱油量（%）
			oilShareFromModel.setLastAddTime(oilShareFromModel.getThisAddTime());
			oilShareFromModel.setLastTankStorage(0);
		}else{
			//不是第一次的加油记录，将上次的信息设置进去
			oilShareFromModel.setLastAddTime(lastMessage.getLastAddTime());
			oilShareFromModel.setLastTankStorage(lastMessage.getLastTankStorage());
		}
		
		//派车单的信息list
		List<OilShareTableModel> shareList=oilSearchService.getShareMessage(seq);
		
		if(shareList.size()==0){
			//默认设置所有的派车单的预算-总油耗为零
			oilShareFromModel.setAllBugtAdjGas(0);
		}else{
			//设置所有的派车单的预算-总油耗
			double allBugtAdjGas=0;
			for(int i=0;i<shareList.size();i++){
				allBugtAdjGas +=Double.parseDouble(shareList.get(i).getBugtAdjGas());
			}
			oilShareFromModel.setAllBugtAdjGas(allBugtAdjGas);
		}
		boolean flag=false;
		model.addAttribute("flag", flag);
		model.addAttribute("ffdmList", JSONArray.fromObject(shareList).toString());
		model.addAttribute("oilShareFromModel", oilShareFromModel);
		model.addAttribute("gridModel", getGridConfig("oilShare"));
		return "modules/mst/oilManagement/oilShare";
		
	}
	
	/**
	 * 初始化
	 * 加油页面
	 */
	@RequestMapping(value = { "oilDetail" })
	public String oilAdd(Model model, HttpServletRequest request, HttpServletResponse response){
		String seqNo = request.getParameter("seqNo");
		OilSearchModel oilSearchModel = new OilSearchModel();
		oilSearchModel.setFuelType("CY");
		oilSearchModel.setInnerFlag("Y");
		oilSearchModel.setOperationTime(DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm"));
		if(StringUtils.isNotBlank(seqNo)){
			oilSearchModel = oilSearchService.findReviseOilMsg(seqNo);
		}
		model.addAttribute("oilSearchModel", oilSearchModel);
		
		return "modules/mst/oilManagement/oilDetail";
	}
	
	/**
	 * 车辆和司机关联
	 */
	@RequestMapping(value = {"findDriver"})
	@ResponseBody
	public String findDriver(HttpServletRequest request,
                             HttpServletResponse response, Model model) {
		String plateNum=request.getParameter("plateNum");
		OilSearchModel driverCodeFuel=oilSearchService.findDriver(plateNum);

		return JSONObject.fromObject(driverCodeFuel).toString();
	}

	/**
	 * 车辆和司机关联
	 */
	@RequestMapping(value = {"findTrailer"})
	@ResponseBody
	public String findTrailer(HttpServletRequest request,
                              HttpServletResponse response, Model model) {
		String driverCode=request.getParameter("driverCode");
		OilSearchModel plateNumFuel=oilSearchService.findTrailer(driverCode);
		return JSONObject.fromObject(plateNumFuel).toString();
	}

	/**
	 * 燃油类型、内外库关联油价
	 */
	@RequestMapping(value = {"findOilPrice"})
	@ResponseBody
	public String findOilPrice(HttpServletRequest request,
                               HttpServletResponse response, Model model) {
		String fuelType=request.getParameter("fuelType");
		String innerFlag=request.getParameter("innerFlag");
		String oilPrice=oilSearchService.getOilPrice(fuelType,innerFlag);
		if(oilPrice==null){
			oilPrice="0.0";
		}
		return oilPrice;
	}

	/**
	 * 通过新增加油记录
	 * 初始化
	 * 油量分摊页面
	 */
	@RequestMapping(value = { "turnToShare" })
	@ResponseBody
	public String turnToShare(Model model, HttpServletRequest request
			, HttpServletResponse response, OilSearchModel oilSearchModel){

		ResultModel resultModel = new ResultModel();
		//获取操作人名称
		String operationPsn = UserUtils.getUser().getId().toString();
		oilSearchModel.setOperationPsn(operationPsn);
		/*DecimalFormat df=new DecimalFormat("#.00");*/
		//查找上一次的加油记录
		/*OilShareFormModel lastAddOil = oilSearchService.getLastMessage(oilSearchModel.getPlateNum());*/
		String message="";
		//Check 1
		try{
			oilSearchModel.setFactOilWear(0);
			if(StringUtils.isNotBlank(oilSearchModel.getSeqNo())){
				oilSearchService.updateFuelFilling(oilSearchModel);
				message="修改成功!";
			}else{
				oilSearchService.insertFuelFilling(oilSearchModel);
				message="加油成功!";
			}
//			if(StringUtils.equals(request.getParameter("flag"),"1")){
//				return dialogMessage(message,model,"2");
//			}else{
//				return dialogMessageNext(message,model,"2",oilSearchModel.getSelectValue());
//			}
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error("加油失败！数据异常:" + e.getMessage());
			resultModel.setErrorMsg("加油失败！数据异常");
//			return dialogMessage(message,model,"3");
		}

		return JsonUtils.toString(resultModel);
		/*if(null==lastAddOil){
			//第一次加油记录时,直接插入加油记录中，不插入分摊表和实付表
			//本次加油后司机存油量（升）设置为默认值，既司机的初始存油量
			String storageOil=oilSearchService.getDriStorageOil(oilSearchModel.getDriverCode());
			if(storageOil==null){
				//报错司机的存油量未设置
				message="司机的存油量未设置！";
				return dialogMessage(message,model,"1");
			}
			oilSearchModel.setStorageOil(Double.parseDouble(storageOil));
			
			//插入加油记录表
			try{
				oilSearchModel.setFactOilWear(0);
				oilSearchService.insertFuelFilling(oilSearchModel);
				message="加油成功!";
				return dialogMessage(message,model,"2");
			}catch(Exception e){
				e.printStackTrace();
				message="加油失败！数据异常！";
				return dialogMessage(message,model,"3");
			}
			
		}
		
		//获取上一次司机的存油量
		double lastStorageOil=lastAddOil.getThisStorageOil();
		
		//1.获取全部的运输订单列表
		//场景1
		//场景2
		List<FuelFillingDivModel> ffdmList = oilSearchService
				.getAllDrv(lastAddOil.getLastAddTime(),
						oilSearchModel.getDriverCode());
		//Check 2
		if (ffdmList.isEmpty()) {
			//两次加油之间没跑订单时，直接插入加油记录中，不插入分摊表和实付表
			//本次加油后司机存油量（升）为上一条记录的司机存油量（升）
			oilSearchModel.setStorageOil(lastStorageOil);
			
			//插入加油记录表
			try{
				//计算实际花费多少油量
				double factOil = (lastAddOil.getLastTankStorage()
						- oilSearchModel.getTankStorage()) * oilSearchModel.getTankLiters() / 100
						+ oilSearchModel.getAddLiters();
				double factUsedOil =Double.parseDouble(df.format(factOil));
				
				oilSearchModel.setFactOilWear(factUsedOil);
				
				double thisStorageOil=lastStorageOil-factUsedOil;
				
				if(thisStorageOil<=0){
					//提示，此次加油过后司机存油量为空或为负
					message="司机存油量已不足！不能保存加油记录！";
					return dialogMessage(message,model,"1");
				}
				oilSearchModel.setStorageOil(thisStorageOil);
				oilSearchService.insertFuelFilling(oilSearchModel);
				message="加油成功！"未有分摊情况！此司机上一次存油量为
						+Double.parseDouble(df.format(lastStorageOil))
						+"升，本次存油量为"+Double.parseDouble(df.format(thisStorageOil))
						+"升,减少了"+Double.parseDouble(df.format(lastStorageOil-thisStorageOil))+"升";
				return dialogMessage(message,model,"2");
			}catch(Exception e){
				e.printStackTrace();
				message="加油失败！数据异常！";
				return dialogMessage(message,model,"3");
			}
			
		}
		
		double total = 0.0;
		BigDecimal value1=new BigDecimal(String.valueOf(total));
		for(int i=0;i<ffdmList.size();i++){
			//2.预算总油耗
			BigDecimal value2=new BigDecimal(String.valueOf(ffdmList.get(i).getBugtAdjGas()));
			value1=value1.add(value2);
		}
		total =Double.parseDouble(value1+"");
		oilSearchModel.setTankLiters(lastAddOil.getTankLiters());
		//格式化数据
		
		//3.计算实际花费多少油量
		double factOil = (lastAddOil.getLastTankStorage()
				- oilSearchModel.getTankStorage()) * oilSearchModel.getTankLiters() / 100
				+ oilSearchModel.getAddLiters();
		double factUsedOil =Double.parseDouble(df.format(factOil));
		
		oilSearchModel.setFactOilWear(factUsedOil);
		//Check 3
		if(factUsedOil<0){
			//报错，加油量和加油后的油箱油量输入的有错
			message="加油量和加油后的油箱油量输入有误！请确认！";
			return dialogMessage(message,model,"1");
		}
		
		for(int i=0;i<ffdmList.size();i++){
			ffdmList.get(i).setOilPrice(oilSearchModel.getThePrice());
			ffdmList.get(i).setThisAddOil(oilSearchModel.getAddLiters());
			ffdmList.get(i).setCheckPsn(operationPsn);
			//计算每个运单所花费的油量
			double ordOil = ffdmList.get(i).getBugtAdjGas() / total
					* factUsedOil;
			//将计算过后的油量格式化
			double oilLiter = Double.parseDouble(df.format(ordOil));
			ffdmList.get(i).setLiters(oilLiter);
			ffdmList.get(i).setLitersCheck(oilLiter);
		}
		double thisStorageOil=0;
		if(factUsedOil>total){
			thisStorageOil = lastStorageOil+total-factUsedOil;
		}else{
			thisStorageOil = lastStorageOil;
		}
		
		if(thisStorageOil<=0){
			//提示，此次加油过后司机存油量为空或为负
			message="司机存油量已不足！";
			return dialogMessage(message,model,"1");
		}
		
		//将计算过后的司机存油量记录下来
		oilSearchModel.setStorageOil(Double.parseDouble(df.format(thisStorageOil)));
		
		model.addAttribute("oilSearchModel", JSONObject.fromObject(oilSearchModel).toString());
		model.addAttribute("ffdmList", 	JSONArray.fromObject(ffdmList).toString());

		lastAddOil.setPlateNum(oilSearchModel.getPlateNum());
		lastAddOil.setFactOilWear(factUsedOil);
		lastAddOil.setThisStorageOil(oilSearchModel.getStorageOil());
		lastAddOil.setAllBugtAdjGas(total);
		lastAddOil.setThisAddLiters(oilSearchModel.getAddLiters());
		lastAddOil.setThisTankStorage(oilSearchModel.getTankStorage());
		
		boolean flag=true;
		message="此司机上一次存油量为"+Double.parseDouble(df.format(lastStorageOil))
				+"升，本次存油量为"+Double.parseDouble(df.format(thisStorageOil))
				+"升,减少了"+Double.parseDouble(df.format(lastStorageOil-Double.parseDouble(df.format(thisStorageOil))))+"升";*/
		/*model.addAttribute("oilShareFromModel", lastAddOil);*/
		/*model.addAttribute("flag", flag);*/
		/*model.addAttribute("message", message);*/
		/*return dispatchBackSearch(model, request, response, oilSearchModel.getSelectValue());*/
//		return "modules/mst/oilManagement/oilSearch";
	}
	
	//新增加油记录界面的提示和错误信息
	public String dialogMessage(String message, Model model, String type){
		
		//获取所有的燃油类型label和value
		List<Dict> oilType=oilSearchService.getOilType();
		//获取所有的车辆号
		List<OilSearchModel> driverName=oilSearchService.getAllDriverName();
				
		//获取所有的司机姓名
		List<OilSearchModel> plateNums=oilSearchService.getAllPlateNum();
		
		model.addAttribute("plateNums",plateNums);
		model.addAttribute("driverName",driverName);
		model.addAttribute("oilType",oilType);
		model.addAttribute("message", message);
		model.addAttribute("type", type);
		model.addAttribute("errorFlag", "Y");
		return "modules/mst/oilManagement/oilAdd";
	}
	
	//保存并下一笔
	public String dialogMessageNext(String message, Model model, String type, String selectValue){
		OilSearchModel oilSearchModel = new OilSearchModel();
		oilSearchModel.setSelectValue(selectValue);
		model.addAttribute("oilSearchModel", oilSearchModel);	
		//获取所有的燃油类型label和value
		List<Dict> oilType=oilSearchService.getOilType();
		//获取所有的车辆号
		List<OilSearchModel> driverName=oilSearchService.getAllDriverName();
					
		//获取所有的司机姓名
		List<OilSearchModel> plateNums=oilSearchService.getAllPlateNum();
			
		model.addAttribute("plateNums",plateNums);
		model.addAttribute("driverName",driverName);
		model.addAttribute("oilType",oilType);
		model.addAttribute("message", message);
		model.addAttribute("type", type);
		model.addAttribute("errorFlag", "Y");
		return "modules/mst/oilManagement/oilAdd";
	}
	
	/**
	 * 加油记录录入
	 */
	@ResponseBody
	@RequestMapping(value = { "oilAddRecord" })
	public String oilAddRecord(Model model, HttpServletRequest request, HttpServletResponse response){
		String oilSearchModel=request.getParameter("oilSearchModel");
		JSONObject jsonModel=JSONObject.fromObject(oilSearchModel);
		OilSearchModel oilSearch=(OilSearchModel)JSONObject.toBean(jsonModel, OilSearchModel.class);
		
		String message="";
		try{
			String jsonstr=request.getParameter("jsonstr");
			JSONArray jsonArray = JSONArray.fromObject(jsonstr);
			List<FuelFillingDivModel> ffdList = JSONArray.toList(jsonArray, FuelFillingDivModel.class);
			
			List<ActPayAbleModel> apaList =new ArrayList<ActPayAbleModel>();
			double amount=0;
			for(int i=0;i<ffdList.size();i++){
				//各个订单的油费
				amount = ffdList.get(i).getOilPrice() * ffdList.get(i).getLitersCheck();
				
				//实付明细表model
				ActPayAbleModel payAble = new ActPayAbleModel();
				payAble.setAmount(amount);
				payAble.setOperationPsn(ffdList.get(i).getCheckPsn());
				payAble.setDrvordNo(ffdList.get(i).getDrvordNo());
				payAble.setOrderNo(ffdList.get(i).getOrdNo());
				apaList.add(payAble);
			}
			//插入到加油记录表，加油分摊履历表，实付明细表
			oilSearchService.addOil(ffdList, apaList, oilSearch);
			
			message="加油成功！";
		}catch(Exception e){
			message="加油失败！";
		}
		return message;
	}
	
	/**
	 * 加油分摊记录更新
	 */
	@ResponseBody
	@RequestMapping(value = { "updateRecord" })
	public String updateRecord(Model model, HttpServletRequest request, HttpServletResponse response){
		String jsonstr=request.getParameter("jsonstr");
		JSONArray jsonArray = JSONArray.fromObject(jsonstr);
		List<OilShareTableModel> list = JSONArray.toList(jsonArray, OilShareTableModel.class);
		//获取操作人名称
		String updatePsn = UserUtils.getUser().getName();
		String message="";
		for(int i=0;i<list.size();i++){
			list.get(i).setUpdatePsn(updatePsn);
		}
		
		try{
			//更新加油履历明细表
			oilSearchService.updateFuelFillingDiv(list);
			message="加油分摊记录更新成功！";
		}catch(Exception e){
			message=e.getMessage();
		}
		
		return message;
	}
	
	/**
	 * 导出加油数据
	 */
	@RequestMapping(value = "export")
    public String importFileTemplate(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws IOException {
//		OilSearch conModel = (OilSearch) JsonUtils.getBean(request, OilSearch.class);
//		conModel.setPage(new Page<OilSearch>());
//		List<OilSearchExcelModel> list = oilSearchService.findOilMsg(conModel);
//		String fileName = MessageUtil.getMessage("oilSearchExportTemplate");
//	    new ExportExcel(MessageUtil.getMessage("oilSearch.list"), OilSearchExcelModel.class, 2).setDataList(list).write(response, fileName).dispose();

		//获取前台的查询条件
		OilSearch conModel = (OilSearch) JsonUtils.getBean(request, OilSearch.class);
		conModel.setPage(null);
		List<OilSearchModel> list = oilSearchService.findOilRecordList(conModel);

		// 计算加油总量和金额总计
		BigDecimal addLitersCnt = BigDecimal.ZERO;
		BigDecimal amountCnt = BigDecimal.ZERO;
		for (OilSearchModel oil : list) {
			if (StringUtils.isNotBlank(oil.getAddLiters())) {
				addLitersCnt = addLitersCnt.add(new BigDecimal(oil.getAddLiters()));
			}
			if (oil.getAmount() > 0d) {
				amountCnt = amountCnt.add(new BigDecimal(oil.getAmount()));
			}
		}

		Map<String, Object> dataMap = new HashMap<>();
		String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
		dataMap.put("oilRecordList", list);
		dataMap.put("ExpandedRowCount", list.size() + 6);
		dataMap.put("addLitersCnt", addLitersCnt.setScale(2, BigDecimal.ROUND_HALF_UP).toString());
		dataMap.put("amountCnt", amountCnt.setScale(2, BigDecimal.ROUND_HALF_UP).toString());
		File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
		File outFile = FreeMarkers.exportForTemplate(tempPath, "oilRecord.ftl", dataMap, tempFile);
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("加油记录.xls", "utf-8"));
		try {
			InputStream inputStream = new FileInputStream(outFile);
			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}
			os.close();
			inputStream.close();
			FileUtils.deleteQuietly(tempFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
    }
	
	/**
	 * 导入加油数据
	 */
	@RequestMapping(value = "import", method=RequestMethod.POST)
	@ResponseBody
    public String importFile(MultipartFile doFile , HttpServletRequest request, HttpServletResponse response, Model model) throws InvalidFormatException, IOException, InstantiationException, IllegalAccessException {
		ImportExcel ei = new ImportExcel(doFile, 1, 0);
		List<OilSearchExcelModel> list = ei.getDataList(OilSearchExcelModel.class);
		String res = oilSearchService.insertOilMsg(list);
		return res;
    }
	
	/**
	 * 加油修改
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = { "oilEdit" })
	public String oilEdit(Model model, HttpServletRequest request, HttpServletResponse response){
		
		String selectValue= request.getParameter("selectValue");
	
		String flag = request.getParameter("flag");
		OilSearchModel oilSearchModel = new OilSearchModel();
		if(StringUtils.equals(flag, "revise")){
			oilSearchModel = oilSearchService.findReviseOilMsg(request.getParameter("seqNo"));
			
		}
		model.addAttribute("oilSearchModel", oilSearchModel);
		
		//获取所有的司机姓名
		List<OilSearchModel> driverName=oilSearchService.getAllDriverName();
		
		//获取所有的车辆号
		List<OilSearchModel> plateNums=oilSearchService.getAllPlateNum();
		
		//获取所有的燃油类型label和value
		List<Dict> oilType=oilSearchService.getOilType();
		model.addAttribute("oilType",oilType);
		model.addAttribute("plateNums",plateNums);
		model.addAttribute("driverName",driverName);
		model.addAttribute("selectValue",selectValue);
		
		return "modules/mst/oilManagement/oilAdd";
	}
}
