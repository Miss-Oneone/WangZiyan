package com.xzg56.jg.modules.mst.gpsKmAdjust.web;

import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.gpsKmAdjust.model.GPSKmAdjustModel;
import com.xzg56.jg.modules.mst.gpsKmAdjust.service.GPSKmAdjustService;
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

/**
 * Created by wzr on 2019/6/10.
 */
@RequestMapping(value = { "${adminPath}/gpsKmAdjust" })
@Controller
public class GPSKmAdjustController extends BaseController {

    @Resource
    private GPSKmAdjustService gpsKmAdjustService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {

        String timeFrom = DateUtils.formatDate(DateUtils.getMonthFirstDate(), "yyyy-MM-dd");
        String timeTo = DateUtils.formatDate(DateUtils.getMonthLastDate(), "yyyy-MM-dd");

        model.addAttribute("gridModel", getGridConfig("gpsKmAdjust"));
        model.addAttribute("timeFrom", timeFrom);
        model.addAttribute("timeTo", timeTo);

        return "modules/mst/gpsKmAdjust/gpsKmAdjust";
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

        GPSKmAdjustModel gpsKmAdjustModel = JsonUtils.getBean(request, GPSKmAdjustModel.class);
        List<GPSKmAdjustModel> gpsKmAdjustModelList = gpsKmAdjustService.search(gpsKmAdjustModel);
        JQResultModel resultModel = new JQResultModel(gpsKmAdjustModelList, gpsKmAdjustModel.getPage());

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
    @RequestMapping(value = "gpsKmAdjustDetail")
    public String driverTrailerChangeHisHeader(HttpServletRequest request, HttpServletResponse response, Model model) {

        GPSKmAdjustModel gpsKmAdjustModel = JsonUtils.getBean(request, GPSKmAdjustModel.class);
        GPSKmAdjustModel gpsKmAdjust = new GPSKmAdjustModel();
        if (StringUtils.isNotBlank(gpsKmAdjustModel.getId())) {
            gpsKmAdjust = gpsKmAdjustService.search(gpsKmAdjustModel).get(0);
        }
        model.addAttribute("gpsKmAdjustModel",gpsKmAdjust);

        return "modules/mst/gpsKmAdjust/gpsKmAdjustDetail";
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

        GPSKmAdjustModel gpsKmAdjustModel = JsonUtils.getBean(request, GPSKmAdjustModel.class);

        ResultModel result = new ResultModel();

        try {
            gpsKmAdjustService.save(gpsKmAdjustModel);
            result.setResultType(GlobalConstants.RESULT_SUCCESS);
            result.setResultMsg("保存成功！");
        } catch (Exception e) {
            e.printStackTrace();
            result.setResultType(GlobalConstants.RESULT_ERROR);
            result.setResultMsg("保存异常，异常信息:\n" + e.getMessage());
        }

        return JsonUtils.toString(result);

    }
}
