package com.xzg56.jg.modules.mst.oilPriceCalendar.service;


import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.mst.oilPriceCalendar.dao.OilPriceCalendarDao;
import com.xzg56.jg.modules.mst.oilPriceCalendar.model.OilPriceCalendarModel;
import com.xzg56.jg.modules.mst.oilPriceCalendar.model.OilPriceCalendarSearchModel;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.List;

/**
 * Created by zxp on 2019/4/22.
 */
@Service
@Transactional(readOnly = true)
public class OilPriceCalendarService extends BaseService {

    @Resource
    private OilPriceCalendarDao oilPriceCalendarDao;

    public List<OilPriceCalendarModel> searchOilPriceCalendar(OilPriceCalendarSearchModel searchModel) {

        List<OilPriceCalendarModel> result = oilPriceCalendarDao.searchOilPriceList(searchModel);

        return result;
    }

    public String searchAvgPrice(String yearMonth){

        String searchDate = DateUtils.getLastDayOfMonth(DateUtils.parseDate(yearMonth, "yyyy-MM"));
        return oilPriceCalendarDao.searchAvgPrice(searchDate);
    }

    public OilPriceCalendarModel searchOilPriceCalendar(OilPriceCalendarModel searchModel){

        return oilPriceCalendarDao.getOilPrice(searchModel);
    }

    @Transactional(readOnly = false)
    public void addPriceCalendar(OilPriceCalendarModel addModel) throws ParseException{

        //生成油价
//        addModel.setpSeq(indirectCostModel.getIndirectPayableId());
        addModel.setLastPrice(addModel.getLastPrice().replaceAll(",",""));

        //预提油价，保存的时候，默认是【无需审核】
        if(StringUtils.equals(addModel.getOilPriceType(), Constants.OIL_PRICE_TYPE.PREDICTIVE_PRICE)){
            addModel.setApprovalStatus(StringUtils.toString(Constants.OIL_APPROVAL_STATUS.NO_NEED_APPROAL));
            addModel.setInnerFlag("Y");
        }
        //结算油价，保存的时候，默认是【未审核】
        if(StringUtils.equals(addModel.getOilPriceType(), Constants.OIL_PRICE_TYPE.SELF_PRICE)){
            addModel.setApprovalStatus(StringUtils.toString(Constants.OIL_APPROVAL_STATUS.UN_AUDIT));
            addModel.setInnerFlag("Y");

        }
        if(StringUtils.equals(addModel.getOilPriceType(), Constants.OIL_PRICE_TYPE.OUT_PRICE)){
            addModel.setApprovalStatus(StringUtils.toString(Constants.OIL_APPROVAL_STATUS.UN_AUDIT));
            addModel.setInnerFlag("Y");
        }
        if(StringUtils.equals(addModel.getOilPriceType(), Constants.OIL_PRICE_TYPE.JG_PRICE)){
            addModel.setApprovalStatus(StringUtils.toString(Constants.OIL_APPROVAL_STATUS.UN_AUDIT));
            addModel.setInnerFlag("Y");
        }
        if(StringUtils.equals(BizFcConstants.PAGE_TYPE.CREATE,addModel.getPageType())) {
            addModel.setCreateBy(UserUtils.getUserId());

            //油价重复定价验证
            OilPriceCalendarModel oilPriceCalendarModel = oilPriceCalendarDao.getOilPrice(addModel);

            if (oilPriceCalendarModel == null) {
                oilPriceCalendarDao.insertOilPrice(addModel);
            } else {
                throw new ValidationException("存在重复价格，请确认");
            }
        } else if(StringUtils.equals(BizFcConstants.PAGE_TYPE.EDIT,addModel.getPageType())) {
            addModel.setUpdateBy(UserUtils.getUserId());
            oilPriceCalendarDao.updateOilPrice(addModel);
        }
    }

    @Transactional(readOnly = false)
    public void approvalOilPrices(List<OilPriceCalendarModel> models) {

        for(OilPriceCalendarModel model: models) {

            model.setUpdateBy(UserUtils.getUserId());
            oilPriceCalendarDao.approvalOilPrice(model);
        }
    }

    @Transactional(readOnly = false)
    public void delOilPrices(List<OilPriceCalendarModel> models) {

        for(OilPriceCalendarModel model: models) {

            oilPriceCalendarDao.delOilPrice(model);
        }
    }
}
