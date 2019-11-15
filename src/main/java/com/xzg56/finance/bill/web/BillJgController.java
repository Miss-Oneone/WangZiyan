package com.xzg56.finance.bill.web;


import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.bill.service.BillJgService;
import com.xzg56.finance.common.model.BillExportJgModel;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

/**
 * 账单管理
 * 
 * @author wu_jianan
 * 
 */
@RequestMapping(value = { "${adminPath}/billJgManage" })
@Controller
public class BillJgController extends BaseController {

	@Autowired
	private BillJgService billJgService;

	/**
	 * 导出
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "export")
	public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		BillExportJgModel billExportJgModel = (BillExportJgModel) JsonUtils.getBean(request, BillExportJgModel.class);
		billExportJgModel.setPage(null);
		String title = "对账信息导出数据";
		HSSFWorkbook workbook = billJgService.getExportFile(billExportJgModel);

		try {
			// 清空response
			response.reset();
			// 设置response的Header
			response.setContentType("application/vnd.ms-excel");
			response.addHeader("Content-disposition",
					"attachment;filename=" + URLEncoder.encode(title + ".xls", "UTF-8"));
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			// 流形式传输
			workbook.write(toClient);
			toClient.flush();
			toClient.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;

	}


}
