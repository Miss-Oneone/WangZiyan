package com.xzg56.jg.modules.mst.truckframe.web;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.truckframe.model.TruckFrameModel;
import com.xzg56.jg.modules.mst.truckframe.model.TruckFrameSearchModel;
import com.xzg56.jg.modules.mst.truckframe.service.TruckFrameService;
import com.xzg56.utility.StringUtils;
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
 * Created by wellen on 2019/4/3.
 */

@Controller
@RequestMapping(value = {"${adminPath}/truckFrame"})
public class TruckFrameController extends BaseController {

    @Resource
    private TruckFrameService truckFrameService;

    @RequestMapping(value = {"init", ""})
    public String init(Model model) {
        model.addAttribute("gridModel", getGridConfig("truckFrame"));
        return "modules/mst/truckFrame/truckFrameList";
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
        TruckFrameSearchModel truckFrameSearchModel = (TruckFrameSearchModel) JsonUtils.getBean(request, TruckFrameSearchModel.class);
        List<TruckFrameModel> truckFrameModels = truckFrameService.listTruckFrames(truckFrameSearchModel);
        JQResultModel resultModel = new JQResultModel(truckFrameModels, truckFrameSearchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"truckFrameDetail"}, method = RequestMethod.GET)
    public String truckFrameDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
        TruckFrameModel truckFrameModel = JsonUtils.getBean(request, TruckFrameModel.class);
        if(truckFrameModel.getId() > 0) {
            truckFrameModel = truckFrameService.findTruckFrameById(truckFrameModel.getId());
            truckFrameModel.setDisabledFlag(true);
        }
        model.addAttribute("truckFrameModel", truckFrameModel);
        return "modules/mst/truckFrame/truckFrameDetail";
    }

    @RequestMapping(value = {"addTruckFrame"}, method = RequestMethod.POST)
    @ResponseBody
    public String addTruckFrame(HttpServletRequest request, HttpServletResponse response) throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            TruckFrameModel truckFrameModel = JsonUtils.getBean(request, TruckFrameModel.class);
            truckFrameService.saveTruckFrame(truckFrameModel);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("新增车架失败：\n" + e.getMessage());
            result.setErrorMsg("新增车架失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"eidtTruckFrame"}, method = RequestMethod.POST)
    @ResponseBody
    public String eidtTruckFrame(HttpServletRequest request, HttpServletResponse response) throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            TruckFrameModel truckFrameModel = JsonUtils.getBean(request, TruckFrameModel.class);
            truckFrameService.updateTruckFrame(truckFrameModel);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("编辑车架失败：\n" + e.getMessage());
            logger.error("编辑车架失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"deleteTruckFrame"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteTruckFrame(HttpServletRequest request, HttpServletResponse response) throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            String id = request.getParameter("id");
            truckFrameService.deleteTruckFrame(StringUtils.toInteger(id));
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("删除车架失败：\n" + e.getMessage());
            logger.error("删除车架失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }
}
