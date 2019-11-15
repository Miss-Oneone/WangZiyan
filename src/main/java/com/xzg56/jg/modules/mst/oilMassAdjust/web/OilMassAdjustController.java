package com.xzg56.jg.modules.mst.oilMassAdjust.web;

import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.oilMassAdjust.model.OilMassAdjustModel;
import com.xzg56.jg.modules.mst.oilMassAdjust.service.OilMassAdjustService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@RequestMapping(value = { "${adminPath}/oilMassAdjust" })
@Controller
public class OilMassAdjustController extends BaseController {

    @Resource
    OilMassAdjustService oilMassAdjustService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {

        String timeFrom = DateUtils.formatDate(DateUtils.getMonthFirstDate(), "yyyy-MM-dd");
        String timeTo = DateUtils.formatDate(DateUtils.getMonthLastDate(), "yyyy-MM-dd");

        model.addAttribute("gridModel", getGridConfig("oilMassAdjust"));
        model.addAttribute("timeFrom", timeFrom);
        model.addAttribute("timeTo", timeTo);

        return "modules/mst/oilPriceAdjust/oilMassAdjust";
    }

    /**
     * 查询
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"search"}, method = RequestMethod.POST)
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) {
        OilMassAdjustModel oilMassAdjustModel = JsonUtils.getBean(request, OilMassAdjustModel.class);

        List<OilMassAdjustModel> gpsKmAdjustModelList = oilMassAdjustService.search(oilMassAdjustModel);
        JQResultModel resultModel = new JQResultModel(gpsKmAdjustModelList, oilMassAdjustModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    /**
     * 编辑
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "oilMassAdjustDetail")
    public String oilMassAdjustDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
        OilMassAdjustModel oilMassAdjustModel = JsonUtils.getBean(request, OilMassAdjustModel.class);
        OilMassAdjustModel oilMassAdjust = new OilMassAdjustModel();
        if (StringUtils.isNotBlank(oilMassAdjustModel.getId())) {
            oilMassAdjust = oilMassAdjustService.search(oilMassAdjustModel).get(0);
        }
        model.addAttribute("oilMassModel",oilMassAdjust);

        return "modules/mst/oilPriceAdjust/oilMassAdjustDetail";
    }


    /**
     * 保存
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "save")
    @ResponseBody
    public String save(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {

        OilMassAdjustModel oilMassAdjustModel = JsonUtils.getBean(request, OilMassAdjustModel.class);

        ResultModel result = new ResultModel();

        try {
            oilMassAdjustService.save(oilMassAdjustModel);

            result.setResultMsg("保存成功！");
        } catch (Exception e) {
            e.printStackTrace();
            result.setResultType(GlobalConstants.RESULT_ERROR);
            result.setResultMsg("保存异常，异常信息:\n" + e.getMessage());
        }

        return JsonUtils.toString(result);

    }


}
