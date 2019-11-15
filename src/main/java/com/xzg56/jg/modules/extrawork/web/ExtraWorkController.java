package com.xzg56.jg.modules.extrawork.web;

import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.extrawork.model.ExtraWorkModel;
import com.xzg56.jg.modules.extrawork.model.ExtraWorkSearchModel;
import com.xzg56.jg.modules.extrawork.service.ExtraWorkService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import net.sf.json.JSONObject;
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
 * Created by wzr on 2019/10/22.
 */
@Controller
@RequestMapping(value = {"${adminPath}/extraWork"})
public class ExtraWorkController extends BaseController {

    @Resource
    private ExtraWorkService extraWorkService;

    @RequestMapping(value = {"init", ""})
    public String init(Model model) {
        model.addAttribute("extraWorkGridModel", getGridConfig("extraWorkDetail"));
        model.addAttribute("occurDateFrom", DateUtils.getMonthFirstDate());
        model.addAttribute("occurDateTo", DateUtils.getMonthLastDate());
        return "modules/extraWork/extraWorkDetailList";
    }

    @RequestMapping(value = {"search"}, method = RequestMethod.POST)
    @ResponseBody
    public String search(HttpServletRequest request, Model model){
        ExtraWorkSearchModel extraWorkSearchModel = JsonUtils.getBean(request,ExtraWorkSearchModel.class);
        List<ExtraWorkModel> extraWorkModelList = extraWorkService.getExtraWorkModelList(extraWorkSearchModel);
        JQResultModel resultModel = new JQResultModel(extraWorkModelList, extraWorkSearchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"addAndEdit"}, method = RequestMethod.GET)
    public String addAndEdit(HttpServletRequest request, Model model){
        ExtraWorkModel extraWorkModel = JsonUtils.getBean(request,ExtraWorkModel.class);
        if(StringUtils.isNotBlank(extraWorkModel.getId())){
            extraWorkModel = extraWorkService.getExtraWorkById(extraWorkModel);
        }
        model.addAttribute("extraWorkModel", extraWorkModel);
        return "modules/extraWork/extraWorkAddAndEdit";
    }

    @RequestMapping(value = {"extraWorkPriceItem"}, method = RequestMethod.GET)
    public String extraWorkPriceItem(HttpServletRequest request, Model model){
        model.addAttribute("extraWorkPriceItemGridModel", getGridConfig("extraWorkPriceItem"));
        return "modules/extraWork/extraWorkPriceItemList";
    }

    @RequestMapping(value = {"searchExtraWorkPriceItem"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchExtraWorkPriceItem(HttpServletRequest request, Model model){
        List<ExtraWorkModel> extraWorkPriceItemList = extraWorkService.searchExtraWorkPriceItem();
        JQResultModel resultModel = new JQResultModel(extraWorkPriceItemList, new ExtraWorkSearchModel().getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"addExtraWork"}, method = RequestMethod.POST)
    @ResponseBody
    public String addExtraWork(HttpServletRequest request, Model model)throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            ExtraWorkModel extraWorkModel = JsonUtils.getBean(request, ExtraWorkModel.class);
            extraWorkService.addExtraWork(extraWorkModel);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("新增小活记录失败：\n" + e.getMessage());
            result.setErrorMsg("新增小活记录失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"eidtExtraWork"}, method = RequestMethod.POST)
    @ResponseBody
    public String eidtExtraWork(HttpServletRequest request, Model model) throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            ExtraWorkModel extraWorkModel = JsonUtils.getBean(request, ExtraWorkModel.class);
            extraWorkService.eidtExtraWork(extraWorkModel);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("更新小活记录失败：\n" + e.getMessage());
            result.setErrorMsg("更新小活记录失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"deleteExtraWork"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteExtraWork(HttpServletRequest request, Model model) throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            ExtraWorkModel extraWorkModel = JsonUtils.getBean(request, ExtraWorkModel.class);
            extraWorkService.deleteExtraWork(extraWorkModel);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("删除小活记录失败：\n" + e.getMessage());
            result.setErrorMsg("删除小活记录失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"searchPlateNumLiters"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchPlateNumLiters(HttpServletRequest request, Model model) throws ValidationException{
        ResultModel result = new ResultModel<>();
        String plateNum = request.getParameter("plateNum");
        try {
            String liters = extraWorkService.searchPlateNumLiters(plateNum);
            result.setDataModel(liters);
            if(StringUtils.isBlank(liters) || StringUtils.equals(liters,"0")){
                result.setResultType(GlobalConstants.RESULT_ERROR);
                result.setErrorMsg("该车辆油耗未设置，请添加油耗，请联系管理员添加！");
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"searchExtraWorkPrice"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchExtraWorkPrice(HttpServletRequest request, Model model){
        ResultModel result = new ResultModel<>();
        String id = request.getParameter("id");
        try {
            ExtraWorkModel extraWorkModel = extraWorkService.searchExtraWorkPrice(id);
            result.setDataModel(extraWorkModel);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"getAmount"})
    @ResponseBody
    public String getAmount(HttpServletRequest request, HttpServletResponse response, Model model) {
        ExtraWorkSearchModel extraWorkSearchModel = JsonUtils.getBean(request,ExtraWorkSearchModel.class);
        ResultModel result = new ResultModel();
        extraWorkSearchModel.setPage(null);
        result.setDataModel(extraWorkService.getAmount(extraWorkSearchModel));
        return JsonUtils.toString(result);
    }

}
