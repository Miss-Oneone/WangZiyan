package com.xzg56.jg.modules.mst.gps.web;

import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.gps.model.GpsModel;
import com.xzg56.jg.modules.mst.gps.model.GpsSearchModel;
import com.xzg56.jg.modules.mst.gps.service.GpsService;
import com.xzg56.utility.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by wzr on 2019/4/20.
 */
@RequestMapping(value = {"${adminPath}/gps"})
@Controller
public class GpsController extends BaseController {

    @Resource
    private GpsService gpsService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {

        model.addAttribute("gridModel", getGridConfig("gpsDailyKm"));
        model.addAttribute("dateFrom", DateUtils.getMonthFirstDate());
        model.addAttribute("dateTo", DateUtils.getMonthLastDate());
        return "modules/mst/gps/gpsDailyKm";
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
        GpsSearchModel gpsSearchModel = (GpsSearchModel) JsonUtils.getBean(request, GpsSearchModel.class);
        List<GpsModel> gpsSearchModelList = gpsService.findGpsSearchModelList(gpsSearchModel);
        JQResultModel resultModel = new JQResultModel(gpsSearchModelList, gpsSearchModel.getPage());
        return JsonUtils.toString(resultModel);

    }
}
