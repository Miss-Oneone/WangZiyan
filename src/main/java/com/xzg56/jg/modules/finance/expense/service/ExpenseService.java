package com.xzg56.jg.modules.finance.expense.service;


import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.finance.common.persistence.entity.OrdReceiptsPayments;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.domain.IExpenseDomain;
import com.xzg56.jg.modules.finance.expense.dao.ExpenseDao;
import com.xzg56.jg.modules.finance.expense.model.BatchAddPiModel;
import com.xzg56.jg.modules.finance.expense.model.EmOrderModel;
import com.xzg56.jg.modules.finance.expense.model.EmRecPayModel;
import com.xzg56.jg.modules.finance.expense.model.EmSearchModel;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 费用管理
 *
 * @author zyq 2019/03/28
 *
 */
@Service
public class ExpenseService extends BaseService {

	@Resource
	private ExpenseDao expenseDao;

	@Resource
	private IExpenseDomain expenseDomain;

	public EmOrderModel findEmOrderInfo(EmSearchModel searchModel) {
		return expenseDao.findEmOrderInfo(searchModel);
	}

	public List<EmRecPayModel> findEmDetailList(EmSearchModel searchModel) {
		List<EmRecPayModel> list = expenseDao.findEmRecPayList(searchModel);
		//账单状态
		List<Dict> billStatus = DictUtils.getDictList(BizFcConstants.GROUP_NO.BILL_STATUS);
		//票据状态
		List<Dict> invoiceStatus = DictUtils.getDictList(BizFcConstants.GROUP_NO.INVOICE_STATUS);
		for(EmRecPayModel model : list) {
			for (Dict dict : billStatus) {
				if (StringUtils.equals(model.getBillStatus(), dict.getValue())) {
					model.setBillStatusName(dict.getLabel());
					break;
				}
			}
			for (Dict dict : invoiceStatus) {
				if (StringUtils.equals(model.getInvoiceStatus(), dict.getValue())) {
					model.setInvoiceStatusName(dict.getLabel());
					break;
				}
			}
		}
		return list;
	}

	@Transactional(readOnly = false)
	public Boolean saveRecPay(EmRecPayModel recPay) {
		try {
			if(StringUtils.isBlank(recPay.getRecPayId())) {
				recPay.setCreateBy(UserUtils.getUserId());
				recPay.setActiveFlag(PjConstants.FLAG_Y);
				recPay.setEditableFlag(PjConstants.FLAG_Y);

				expenseDao.insertEmRecPay(recPay);
			} else {
				recPay.setUpdateBy(UserUtils.getUserId());

				expenseDao.updateEmRecPay(recPay);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public String getFormatDate(String format,Integer addMonth) {
		Date date = new Date();//当前日期
		SimpleDateFormat sdf = new SimpleDateFormat(format);//格式化对象
		Calendar calendar = Calendar.getInstance();//日历对象
		calendar.setTime(date);//设置当前日期
		calendar.add(Calendar.MONTH, addMonth);
		String pExpDate = sdf.format(calendar.getTime());

		return pExpDate;
	}

	public List<BatchAddPiModel> batchRecPayCheckList(EmRecPayModel emRecPayModel) {
		emRecPayModel.setOrderNos(StringUtils.split(emRecPayModel.getOrderNo(), ","));

		List<BatchAddPiModel> batchAddPiModels = expenseDao.searchRecPayList(emRecPayModel);

		for (BatchAddPiModel batchAddPiModel : batchAddPiModels) {
			if (StringUtils.equals(batchAddPiModel.getCheckResult(), "0")) {
				batchAddPiModel.setCheckResult("通过");
			} else {
				batchAddPiModel.setCheckResult("费用已存在");
			}
		}

		return batchAddPiModels;
	}

	@Transactional(readOnly = false)
	public void batchSaveRecPay(EmRecPayModel emRecPayModel) {
		String[] orderNos = StringUtils.split(emRecPayModel.getSelectOrderNos(), ",");
		String piName = expenseDao.getPiNameByCode(emRecPayModel.getPiCode());

		List<OrdReceiptsPayments> receiptsPayments = new ArrayList<>();
		for (String orderNo : orderNos) {
			OrdReceiptsPayments recPay = new OrdReceiptsPayments();
			recPay.setOrderNo(orderNo);
			recPay.setPaymentType(emRecPayModel.getPaymentType());
			recPay.setPiCode(emRecPayModel.getPiCode());
			recPay.setPiName(piName);
			recPay.setCompyCode(emRecPayModel.getCompyCode());
			recPay.setAmount(StringUtils.isNotBlank(emRecPayModel.getAmount()) ? StringUtils.toDouble(emRecPayModel.getAmount()) : 0d);
			recPay.setExpDate(emRecPayModel.getExpDate());
			recPay.setRemarks(emRecPayModel.getRemarks());
			recPay.setFeeStatus(emRecPayModel.getFeeStatus());
			recPay.setCreateBy(UserUtils.getUserId());
			recPay.setFeeType(PjConstants.FEE_TYPE.DIRECT);
			recPay.setSystemAutoFlag(PjConstants.FLAG_N);
			recPay.setBinsApprovalFlag(PjConstants.FLAG_N);
			recPay.setActiveFlag(PjConstants.FLAG_Y);
			recPay.setEditableFlag(PjConstants.FLAG_Y);

			receiptsPayments.add(recPay);
		}

		expenseDomain.batchCreateOrdRecPayment(receiptsPayments);
	}
}
