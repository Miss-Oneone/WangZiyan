package com.xzg56.jg.modules.finance.expense.web;

import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.Page;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.finance.expense.model.BatchAddPiModel;
import com.xzg56.jg.modules.finance.expense.model.EmOrderModel;
import com.xzg56.jg.modules.finance.expense.model.EmRecPayModel;
import com.xzg56.jg.modules.finance.expense.model.EmSearchModel;
import com.xzg56.jg.modules.finance.expense.service.ExpenseService;
import com.xzg56.utility.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 费用管理
 * 
 * @author zyq 2019/03/28
 * 
 */
@RequestMapping(value = { "finance/expense" })
@Controller
public class ExpenseController extends BaseController {

	@Autowired
	private ExpenseService expenseService;

	@RequestMapping(value = {"ordRecPayManage"}, method = RequestMethod.GET)
	public String ordRecPayManage(HttpServletRequest request, HttpServletResponse response, Model model) {

		EmSearchModel searchModel = (EmSearchModel) JsonUtils.getBean(request, EmSearchModel.class);
		model.addAttribute("receiveGrid", getGridConfig("receiveTableGrid"));
		model.addAttribute("payGrid", getGridConfig("payTableGrid"));

		EmOrderModel order = expenseService.findEmOrderInfo(searchModel);
		model.addAttribute("order", order);
		model.addAttribute("orderNosKey", searchModel.getOrderNosKey());
		model.addAttribute("loginId", UserUtils.getUserId());

		return "modules/expenseManagement/expenseManagementSearch";
	}

	/*
     * 应收列表获取
     */
	@RequestMapping(value = {"recList"}, method = RequestMethod.POST)
	@ResponseBody
	public String searchRecList(HttpServletRequest request, HttpServletResponse response, Model model) {
		EmSearchModel searchModel = (EmSearchModel) JsonUtils.getBean(request, EmSearchModel.class);
		List<EmRecPayModel> list = expenseService.findEmDetailList(searchModel);
		JQResultModel resultModel = new JQResultModel(list, searchModel.getPage());
		return JsonUtils.toString(resultModel);
	}

	/*
     * 应付列表获取
     */
	@ResponseBody
	@RequestMapping(value = {"payList"}, method = RequestMethod.POST)
	public String searchPayList(HttpServletRequest request, HttpServletResponse response, Model model) {
		EmSearchModel searchModel = (EmSearchModel) JsonUtils.getBean(request, EmSearchModel.class);
		List<EmRecPayModel> list = expenseService.findEmDetailList(searchModel);
		JQResultModel resultModel = new JQResultModel(list, searchModel.getPage());
		return JsonUtils.toString(resultModel);
	}

	/*
     * 应收应付，增加和修改
     */
	@RequestMapping(value = {"recPayUpdate"}, method = RequestMethod.GET)
	public String route(HttpServletRequest request, Model model) {
		String actionType = request.getParameter("actionType");
		String orderNo = request.getParameter("orderNo");
		EmRecPayModel recPay = new EmRecPayModel();
		if(StringUtils.equals("recAdd",actionType) || StringUtils.equals("payAdd",actionType)) {

			if(StringUtils.equals("recAdd",actionType)) {
				String cusCode = request.getParameter("cusCode");
				recPay.setPaymentType(PjConstants.PAYMENT_TYPE.REC);
				recPay.setCompyCode(cusCode);

				String pExpDate = expenseService.getFormatDate("yyyy-MM-28",2);
				recPay.setExpDate(pExpDate);
			} else {
				recPay.setPaymentType(PjConstants.PAYMENT_TYPE.PAY);
				String driverCode = request.getParameter("driverCode");
				recPay.setCompyCode(driverCode);

				String pExpDate = expenseService.getFormatDate("yyyy-MM-25",1);
				recPay.setExpDate(pExpDate);
			}

			recPay.setFeeType(PjConstants.FEE_TYPE.DIRECT);
			recPay.setOrderNo(orderNo);
		} else if(StringUtils.equals("recUpdate",actionType) || StringUtils.equals("payUpdate",actionType)) {
			String recPayId = request.getParameter("recPayId");
			EmSearchModel searchModel = new EmSearchModel();
			searchModel.setRecPayId(recPayId);
			recPay = expenseService.findEmDetailList(searchModel).get(0);
		}

		model.addAttribute("recPay", recPay);
		model.addAttribute("actionType", actionType);
		model.addAttribute("loginId", UserUtils.getUserId());

		return "modules/expenseManagement/recPayAdd";
	}

	@RequestMapping(value = {"saveRecPay"}, method = RequestMethod.POST)
	@ResponseBody
	public String saveRecPay(HttpServletRequest request, EmRecPayModel recPay) {
		return expenseService.saveRecPay(recPay).toString();
	}

	/**
	 * 费用批量录入
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"batchRecPayAdd"}, method = RequestMethod.GET)
	public String batchRecPayAdd(HttpServletRequest request, HttpServletResponse response, Model model) {
		EmRecPayModel emRecPayModel = new EmRecPayModel();
		emRecPayModel.setSelectedOrderNum(request.getParameter("selectedOrderNum"));
		model.addAttribute("recPay", emRecPayModel);
		return "modules/expenseManagement/batchRecPayAdd";
	}

	/**
	 * 费用批量录入校验
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"batchRecPayCheck"}, method = RequestMethod.GET)
	public String batchRecPayCheck(HttpServletRequest request, HttpServletResponse response, Model model) {
		EmRecPayModel emRecPayModel = JsonUtils.getBean(request, EmRecPayModel.class);
		model.addAttribute("recPay", emRecPayModel);
		model.addAttribute("gridModel", getGridConfig("batchAddPiCheck"));
		return "modules/expenseManagement/batchRecPayCheck";
	}

	/**
	 * 费用批量录入校验数据集合
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "batchRecPayCheckList" })
	@ResponseBody
	public String batchRecPayCheckList(HttpServletRequest request, HttpServletResponse response, Model model) {
		EmRecPayModel emRecPayModel = JsonUtils.getBean(request, EmRecPayModel.class);
		List<BatchAddPiModel> searchList = expenseService.batchRecPayCheckList(emRecPayModel);
		JQResultModel resultModel = new JQResultModel(searchList, new Page());
		return JsonUtils.toString(resultModel);
	}

	/**
	 * 费用批量录入
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"batchSaveRecPay"}, method = RequestMethod.POST)
	@ResponseBody
	public String batchSaveRecPay(HttpServletRequest request) {
		ResultModel result = new ResultModel();
		try {
			EmRecPayModel emRecPayModel = JsonUtils.getBean(request, EmRecPayModel.class);
			expenseService.batchSaveRecPay(emRecPayModel);
		} catch (Exception e) {
			e.printStackTrace();
			result.setErrorMsg("费用批量录入失败：" + e.getMessage());
			logger.error("费用批量录入失败：" + e.getMessage());
		}

		return JsonUtils.toString(result);
	}
}
