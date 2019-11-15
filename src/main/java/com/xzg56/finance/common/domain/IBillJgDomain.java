package com.xzg56.finance.common.domain;


import com.xzg56.finance.common.model.BillExportJgModel;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 * Created by lai_hanzhang on 2017/4/24.
 */
public interface IBillJgDomain {

	/**
	 * 账单导出信息
	 * @param billExportJgModel
	 * @return
	 */
	HSSFWorkbook getExportFile(BillExportJgModel billExportJgModel);

}
