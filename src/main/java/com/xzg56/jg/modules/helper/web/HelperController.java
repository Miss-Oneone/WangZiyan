package com.xzg56.jg.modules.helper.web;

import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.helper.model.HelperModel;
import com.xzg56.jg.modules.helper.service.HelperService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by wellen on 2019/4/26.
 */

@Controller
@RequestMapping(value = {"${adminPath}/helper"})
public class HelperController extends BaseController {

    @Resource
    private HelperService helperService;

    @RequestMapping(value = {"getCityList"})
    @ResponseBody
    public String getCityList(HttpServletRequest request, HttpServletResponse response) {
        ResultModel resultModel = new ResultModel();
        try {
            String provinceCode = request.getParameter("provinceCode");
            List<HelperModel> list = helperService.listChildStdAddress(provinceCode);
            resultModel.setDataList(list);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("helper获取数据失败：" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"getDistrictList"})
    @ResponseBody
    public String getDistrictList(HttpServletRequest request) {
        ResultModel resultModel = new ResultModel();
        try {
            String cityCode = request.getParameter("cityCode");
            List<HelperModel> list = helperService.listChildStdAddress(cityCode);
            resultModel.setDataList(list);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("helper获取数据失败：" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"getCountyList"})
    @ResponseBody
    public String getCountyList(HttpServletRequest request) {
        ResultModel resultModel = new ResultModel();
        try {
            String districtCode = request.getParameter("districtCode");
            List<HelperModel> list = helperService.listChildStdAddress(districtCode);
            resultModel.setDataList(list);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("helper获取数据失败：" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }
}
