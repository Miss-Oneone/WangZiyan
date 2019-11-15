package com.xzg56.jg.modules.equipment.web;


import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.equipment.model.EqpModel;
import com.xzg56.jg.modules.equipment.model.EqpSearchModel;
import com.xzg56.jg.modules.equipment.service.EqpService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by wellen on 2019/4/8.
 */

@Controller
@RequestMapping(value = {"${adminPath}/eqpManage"})
public class EqpController extends BaseController {

    @Resource
    private EqpService eqpService;

    @RequestMapping(value = {"init", ""})
    public String init(Model model) {
        model.addAttribute("contnGridModel", getGridConfig("contnMan"));
        model.addAttribute("truckFrameGridModel", getGridConfig("truckFrameMan"));
        model.addAttribute("selfTrailerGridModel", getGridConfig("selfTrailerMan"));
        model.addAttribute("dateFrom", DateUtils.getMonthFirstDate());
        model.addAttribute("dateTo", DateUtils.getMonthLastDate());
        return "modules/equipment/equipmentList";
    }

    /**
     * 查询(自有车)
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = {"searchTrailers"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchTrailers(HttpServletRequest request, Model model) {
        EqpSearchModel searchModel = (EqpSearchModel) JsonUtils.getBean(request, EqpSearchModel.class);
        List<EqpModel> eqpModels = eqpService.listTrailers(searchModel);
        JQResultModel resultModel = new JQResultModel(eqpModels, searchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    /**
     * 查询(车架)
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = {"searchTurckFrames"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchTurckFrames(HttpServletRequest request, Model model) {
        EqpSearchModel searchModel = (EqpSearchModel) JsonUtils.getBean(request, EqpSearchModel.class);
        List<EqpModel> eqpModels = eqpService.listTruckFrames(searchModel);
        JQResultModel resultModel = new JQResultModel(eqpModels, searchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    /**
     * 查询(自备箱)
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = {"searchContns"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchContns(HttpServletRequest request, Model model) {
        EqpSearchModel searchModel = (EqpSearchModel) JsonUtils.getBean(request, EqpSearchModel.class);
        List<EqpModel> eqpModels = eqpService.listContns(searchModel);
        JQResultModel resultModel = new JQResultModel(eqpModels, searchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    /**
     *  修改位置
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = {"updateAddress"}, method = RequestMethod.POST)
    @ResponseBody
    public String updateAddress(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            String mstType = request.getParameter("mstType");
            String key = request.getParameter("key");
            String address = request.getParameter("address");
            String currBindContnNo = request.getParameter("currBindContnNo");
            eqpService.updateAdrs(mstType, key, address,currBindContnNo);
        } catch (ValidationException ve) {
            resultModel.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("修改位置失败：" + e.getMessage());
            resultModel.setErrorMsg("修改位置失败：" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    //导出
    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        EqpSearchModel searchModel = (EqpSearchModel) JsonUtils.getBean(request, EqpSearchModel.class);
        List<EqpModel> trailers = eqpService.listTrailers(searchModel);
        List<EqpModel> truckFrames = eqpService.listTruckFrames(searchModel);
        List<EqpModel> contns = eqpService.listContns(searchModel);
        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dateMap.put("trailersList", trailers);
        dateMap.put("TrailersExpandedRowCount", trailers.size() + 4);
        dateMap.put("truckFramesList", truckFrames);
        dateMap.put("TruckFramesExpandedRowCount", truckFrames.size() + 4);
        dateMap.put("contnsList", contns);
        dateMap.put("ContnsExpandedRowCount", contns.size() + 4);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "eqpManage.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("设备位置统计.xls", "utf-8"));
        try {
            InputStream inputStream = new FileInputStream(outFile);
            OutputStream os = response.getOutputStream();
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }
            os.close();
            inputStream.close();
            FileUtils.deleteQuietly(tempFile);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
