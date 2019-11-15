package com.xzg56.jg.modules.mst.oilPriceCalendar.web;

import com.alibaba.fastjson.JSONArray;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.jg.modules.mst.oilPriceCalendar.model.OilPriceCalendarModel;
import com.xzg56.jg.modules.mst.oilPriceCalendar.model.OilPriceCalendarSearchModel;
import com.xzg56.jg.modules.mst.oilPriceCalendar.service.OilPriceCalendarService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.NumberUtils;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zxp on 2019/4/22.
 */
@RequestMapping(value = { "${adminPath}/oilPriceCalendar" })
@Controller
public class OilPriceCalendarController extends BaseController {

    @Autowired
    private OilPriceCalendarService oilPriceCalendarService;

    @RequestMapping(value = { "init", "" })
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
		String monthEnd = DateUtils.getMonthEnd();
        String monthBegin = DateUtils.formatDate(DateUtils.getAfterMonth(monthEnd, -1), "yyyy-MM").concat("-01");

		//当前财务月取得
        //当前财务月
        String currentFinancialDate = DictUtils.getDictList("CURRENT_FINANCIAL_DATE").get(0).getValue();

        model.addAttribute("gridModel", getGridConfig("oilPriceCalendarGrid"));
        model.addAttribute("createTimeFr", monthBegin);
        model.addAttribute("createTimeTo", monthEnd);
        model.addAttribute("effectiveDateFr", monthBegin);
        model.addAttribute("effectiveDateTo", monthEnd);
        model.addAttribute("userId", UserUtils.getUserId());
        model.addAttribute("currentFinancialDate", currentFinancialDate);

        return "modules/mst/oilPriceCalendar/oilPriceCalendar";
    }

    @RequestMapping(value = {"search"})
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) {
        OilPriceCalendarSearchModel searchModel = (OilPriceCalendarSearchModel) JsonUtils.getBean(request, OilPriceCalendarSearchModel.class);

        List<OilPriceCalendarModel> list = oilPriceCalendarService.searchOilPriceCalendar(searchModel);
        JQResultModel resultModel = new JQResultModel(list, searchModel.getPage());

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"add"})
    public String add(HttpServletRequest request, HttpServletResponse response, Model model) {

        OilPriceCalendarModel addModel = new OilPriceCalendarModel();

        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

//        String avgPrice = oilPriceCalendarService.searchAvgPrice(sdf.format(d));
//        if (StringUtils.isBlank(avgPrice)) {
        String avgPrice = "0.00";
//        }
        addModel.setOilType("CY");
        addModel.setOilPriceType("1");
        addModel.setAvgPrice(NumberUtils.formatNumber(avgPrice, 2));
        addModel.setPageType(BizFcConstants.PAGE_TYPE.CREATE);
        model.addAttribute("addModel", addModel);

        return "modules/mst/oilPriceCalendar/addOilPrice";
    }

    @RequestMapping(value = {"addConfirm"}, method = RequestMethod.POST)
    @ResponseBody
    public String save(HttpServletRequest request, HttpServletResponse response) {
        ResultModel result = new ResultModel();
        OilPriceCalendarModel oilPriceCalendarModel = (OilPriceCalendarModel) JsonUtils.getBean(request, OilPriceCalendarModel.class);

        //不能增加当前财务月前的油价
        String currentFinancialDate = DictUtils.getDictList("CURRENT_FINANCIAL_DATE").get(0).getValue();
        String effectiveDate = oilPriceCalendarModel.getEffectiveDate();

        Integer financialDate = Integer.parseInt(currentFinancialDate.replace("-", ""));
        String[] effectieYm = effectiveDate.split("-");
        if(financialDate > Integer.parseInt(effectieYm[0]+effectieYm[1])) {
            throw new ValidationException("新增油价的生效时间不能小于当前财务年月。");
        }

        try {
            oilPriceCalendarService.addPriceCalendar(oilPriceCalendarModel);
        }catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("新增油价失败:\n" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

    @RequestMapping(value = {"edit"})
    public String edit(HttpServletRequest request, HttpServletResponse response, Model model) {

        String fuelPurchaseId = request.getParameter("fuelPurchaseId");

        String effectiveDate = request.getParameter("effectiveDate");
        String oilPriceType = request.getParameter("oilPriceType");
        String oilType = request.getParameter("oilType");
        String approvalStatus = request.getParameter("approvalStatus");
        String innerFlag = request.getParameter("innerFlag");

        OilPriceCalendarModel addModel = new OilPriceCalendarModel();
        addModel.setEffectiveDate(effectiveDate);
        addModel.setOilPriceType(oilPriceType);
        addModel.setOilType(oilType);
        addModel.setApprovalStatus(approvalStatus);
        addModel.setInnerFlag(innerFlag);

        OilPriceCalendarModel editModel = oilPriceCalendarService.searchOilPriceCalendar(addModel);

        if(editModel != null){
            addModel.setLastPrice(editModel.getLastPrice());
            addModel.setRemarks(editModel.getRemarks());
        } else {
            throw new ValidationException("编辑的油价已被删除，请确认");
        }

        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

//        String avgPrice = oilPriceCalendarService.searchAvgPrice(sdf.format(d));
        String avgPrice = "0.00";
        addModel.setAvgPrice(NumberUtils.formatNumber(avgPrice, 2));
        addModel.setPageType(BizFcConstants.PAGE_TYPE.EDIT);
        model.addAttribute("addModel", addModel);

        return "modules/mst/oilPriceCalendar/addOilPrice";
    }


    @RequestMapping(value = {"approval"}, method = RequestMethod.POST)
    @ResponseBody
    public String approval(HttpServletRequest request, HttpServletResponse response) {
        ResultModel result = new ResultModel();
        try {
            String oilPriceList = request.getParameter("oilPriceList");

            List<OilPriceCalendarModel> models = JSONArray.parseArray(oilPriceList, OilPriceCalendarModel.class);
            oilPriceCalendarService.approvalOilPrices(models);

        }catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("审批失败:\n" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }


    @RequestMapping(value = {"del"}, method = RequestMethod.POST)
    @ResponseBody
    public String del(HttpServletRequest request, HttpServletResponse response) {
        ResultModel result = new ResultModel();
        try {
            String oilPriceList = request.getParameter("oilPriceList");

            List<OilPriceCalendarModel> models = JSONArray.parseArray(oilPriceList, OilPriceCalendarModel.class);
            oilPriceCalendarService.delOilPrices(models);

        }catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("删除失败:\n" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }
}
