package com.xzg56.jg.modules.mst.oilManagement.web;

import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.persistence.sys.entity.User;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.oilManagement.model.*;
import com.xzg56.jg.modules.mst.oilManagement.service.OilManService;
import com.xzg56.jg.modules.mst.oilManagement.service.OilSearchService;
import com.xzg56.utility.DateUtils;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by wellen on 2019/4/17.
 */

@RequestMapping(value={"${adminPath}/oilManage"})
@Controller
public class OilManController extends BaseController {

    @Resource
    private OilManService oilManService;

    @Resource
    private OilSearchService oilSearchService;

    @RequestMapping(value = { "balance" })
    public String init(Model model){
        model.addAttribute("gridModel", getGridConfig("fuelBalance"));
        model.addAttribute("dateFrom", DateUtils.getMonthBegin());
        model.addAttribute("dateTo", DateUtils.getMonthEnd());
        return "modules/mst/oilManagement/oilBalanceList";
    }

    @RequestMapping(value = {"balanceSearch"})
    @ResponseBody
    public String balanceSearch(HttpServletRequest request, HttpServletResponse response, Model model) {
        OilBalanceSearchModel searchModel = JsonUtils.getBean(request, OilBalanceSearchModel.class);
        List<OilBalanceModel> oilBalanceModels = oilManService.listOilBalances(searchModel);
        JQResultModel resultModel = new JQResultModel(oilBalanceModels, searchModel.getPage());
        return JSONObject.fromObject(resultModel).toString();
    }

    /**
     *  获取司机集合（供兆冠调用）
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"/api/listDrivers"})
    @ResponseBody
    public String listDrivers(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            List<SelectModel> drivers = oilManService.listDrivers();
            resultModel.setDataModel(drivers);
        } catch (Exception e) {
            resultModel.setErrorMsg("获取司机失败");
            e.printStackTrace();
            logger.error("获取司机失败：" + e.getMessage());
        }

        return JSONObject.fromObject(resultModel).toString();
    }

    /**
     *  获取车辆集合（供兆冠调用）
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"/api/listTrailers"})
    @ResponseBody
    public String listTrailers(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            List<SelectModel> trailers = oilManService.listTrailers();
            resultModel.setDataModel(trailers);
        } catch (Exception e) {
            resultModel.setErrorMsg("获取车辆失败");
            e.printStackTrace();
            logger.error("获取车辆失败：" + e.getMessage());
        }

        return JSONObject.fromObject(resultModel).toString();
    }

    /**
     * 车辆和司机关联
     */
    @RequestMapping(value = {"/api/findDriver"})
    @ResponseBody
    public String findDriver(HttpServletRequest request) {
        String plateNum = request.getParameter("plateNum");
        OilSearchModel driverCodeFuel = oilSearchService.findDriver(plateNum);
        return JSONObject.fromObject(driverCodeFuel).toString();
    }

    /**
     * 保存
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = { "/api/oilSave" })
    @ResponseBody
    public String oilSave(Model model, HttpServletRequest request
            , HttpServletResponse response) {
        OilSearchModel oilSearchModel = JsonUtils.getBean(request, OilSearchModel.class);
        ResultModel resultModel = new ResultModel();
        //获取操作人名称
        String operationPsn = oilSearchModel.getOperationPsn();
        try {
            User user = UserUtils.getUserByLoginName(oilSearchModel.getOperationPsn());
            if (user != null) {
                operationPsn = user.getId().toString();
            }
        } catch (Exception e) {
            logger.error("用户user_code不匹配：" + operationPsn);
        }

        oilSearchModel.setOperationPsn(operationPsn);
        oilSearchModel.setAutoFlag(true);
        //根据车牌号查询司机信息
        OilSearchModel driver = oilSearchService.findDriver(oilSearchModel.getPlateNum());
        if (driver != null) {
            oilSearchModel.setDriverCode(driver.getDriverCode());
        }
        //查找上一次的加油记录
        String message = "";
        try {
            oilSearchModel.setFactOilWear(0);
            if (StringUtils.isNotBlank(oilSearchModel.getSeqNo())) {
                // 判断是否有此车辆，如果没有，则表示修改为兆冠车辆，玖戈这边数据需要删除
                int cnt = oilSearchService.countTrailersByPlateNum(oilSearchModel.getPlateNum());
                if (cnt == 0) {
                    if (StringUtils.isNotBlank(oilSearchModel.getSeqNo())) {
                        oilSearchService.deleteOil(oilSearchModel.getSeqNo());
                    }
                } else {
                    oilSearchService.updateFuelFilling(oilSearchModel);
                }
                message = "修改成功!";
            } else {
                oilSearchService.insertFuelFilling(oilSearchModel);
                message = "加油成功!";
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("加油失败！数据异常:" + e.getMessage());
            resultModel.setErrorMsg("加油失败！数据异常");
        }

        return JsonUtils.toString(resultModel);
    }

    /**
     * 导入（供兆冠调用）
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = { "/api/import" })
    @ResponseBody
    public String importOils(Model model, HttpServletRequest request , HttpServletResponse response) {
        List<OilSearchExcelModel> oils = JsonUtils.getCollection(request.getParameter("jgDatas"), OilSearchExcelModel.class);
        ResultModel resultModel = new ResultModel();
        //获取操作人名称
        String operationPsn = oils.get(0).getOperationPsn();
        try {
            User user = UserUtils.getUserByLoginName(oils.get(0).getOperationPsn());
            if (user != null) {
                operationPsn = user.getId().toString();
            }
        } catch (Exception e) {
            logger.error("用户user_code不匹配：" + operationPsn);
        }
        for (OilSearchExcelModel oil : oils) {
            oil.setOperationPsn(operationPsn);
            oil.setCreatePsn(operationPsn);
            oil.setUpdatePsn(operationPsn);
        }
        try {
            oilSearchService.importFromZg(oils);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("导入加油数据失败！数据异常:" + e.getMessage());
            resultModel.setErrorMsg("导入加油数据失败！数据异常");
        }

        return JsonUtils.toString(resultModel);
    }
}
