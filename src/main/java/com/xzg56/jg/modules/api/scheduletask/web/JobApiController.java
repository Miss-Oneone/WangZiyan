package com.xzg56.jg.modules.api.scheduletask.web;


import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.utils.UserThreadLocal;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.api.gps.model.CarGpsInfoDetailModel;
import com.xzg56.jg.modules.api.gps.service.CarGpsInfoService;
import com.xzg56.jg.modules.api.scheduletask.model.ApiResultModel;
import com.xzg56.jg.modules.api.scheduletask.service.JobApiService;
import com.xzg56.jg.modules.common.constant.JobApiConstant;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.persistence.entity.OrdExpenseTemporary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Job调用
 */
@Controller
@RequestMapping(value = "/api/job")
public class JobApiController extends BaseController {

	@Autowired
	private CarGpsInfoService carGpsInfoService;

	@Autowired
	private JobApiService jobApiService;

	/**
	 * 日里程抓取
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value = "/getGpsKmTrigger", method = RequestMethod.POST)
	@ResponseBody
	public String getGpsKmTrigger(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ApiResultModel apiResultModel = new ApiResultModel();
		List<CarGpsInfoDetailModel> resultList = new ArrayList<>();
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try {
			carGpsInfoService.getCarGpsInfoNew(startTime, endTime);
		}catch (Exception e) {
			logger.error("日里程抓取失败：", e.getMessage(), e);
			apiResultModel.setCode(JobApiConstant.JOB_RETURN_CODE.FAIL);
			apiResultModel.setMsg("日里程抓取失败");
			response.reset();
			return JsonUtils.toString(apiResultModel);
		} finally {
			apiResultModel.setCode(JobApiConstant.JOB_RETURN_CODE.SUCCESS);
			apiResultModel.setMsg("日里程抓取成功");
			response.reset();
			return JsonUtils.toString(apiResultModel);
		}
	}

	/**
	 * 费用生成
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value = "/autoSubmitExpense", method = RequestMethod.POST)
	@ResponseBody
	public String autoSubmitExpense(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ApiResultModel apiResultModel = new ApiResultModel();
		List<OrdExpenseTemporary> expenseTemporaries = jobApiService.listOrdExpTempsForBatch();
		if (expenseTemporaries.size() == 0) {
			apiResultModel.setMsg("生成费用0笔...");
		}

		for (OrdExpenseTemporary expenseTemp : expenseTemporaries) {
			try {
				UserThreadLocal.setUserId(expenseTemp.getCreateBy());
				// 费用处理
				jobApiService.autoSubmitExpense(expenseTemp);
				// 结果返回
				expenseTemp.setStatus(PjConstants.QUEUE_STATUS.SUCCESS);
				jobApiService.updateOrdExpTempStatus(expenseTemp);
				String msg = "费用生成成功.批次:" + expenseTemp.getBatchId();
				logger.info(msg);
				apiResultModel.setMsg(msg);
			} catch (Exception e) {
				expenseTemp.setStatus(PjConstants.QUEUE_STATUS.FAILURE);
				expenseTemp.setCount(expenseTemp.getCount() + 1);
				jobApiService.updateOrdExpTempStatus(expenseTemp);
				String msg = "费用生成失败.批次:" + expenseTemp.getBatchId() + "; 原因:" + e.getMessage();
				logger.error(msg);
				apiResultModel.error(msg);
			} finally {
				UserThreadLocal.clear();
			}
		}

		return JsonUtils.toString(apiResultModel);
	}
}