package com.xzg56.jg.modules.mst.selfTrailer.web;

import com.xzg56.common.utils.SelectUtils;
import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.jg.modules.mst.selfTrailer.model.SelfTrailerModel;
import com.xzg56.jg.modules.mst.selfTrailer.service.SelfTrailerService;
import com.xzg56.utility.FileUtils;
import com.xzg56.utility.StringUtils;
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

@RequestMapping(value = {"${adminPath}/selfTrailer"})
@Controller
public class SelfTrailerController extends BaseController {

    @Resource
    private SelfTrailerService selfTrailerService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("gridModel", getGridConfig("selfTrailerModel"));

        return "modules/mst/selfTrailer/selfTrailer";
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
        SelfTrailerModel selfTrailerModel = (SelfTrailerModel) JsonUtils.getBean(request, SelfTrailerModel.class);

        List<SelfTrailerModel> selfTrailerModelList = selfTrailerService.findMstTrailerList(selfTrailerModel);
        JQResultModel resultModel = new JQResultModel(selfTrailerModelList, selfTrailerModel.getPage());
        return JsonUtils.toString(resultModel);

    }

    /**
     * 新增、编辑
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "selfTrailerDetail")
    public String selfTrailerDetail(HttpServletRequest request, HttpServletResponse response, Model model) {

        String pageType = request.getParameter("pageType");
        String plateNum = request.getParameter("plateNum");
        SelfTrailerModel selfTrailer = new SelfTrailerModel();
        selfTrailer.setFuelType("CY");
        selfTrailer.setTrailerBelongType("0");
        if (StringUtils.endsWith(BizFcConstants.PAGE_TYPE.EDIT, pageType)) {
            selfTrailer = selfTrailerService.findMstTrailerByPlateNum(plateNum);
        }
        model.addAttribute("pageType", pageType);
        model.addAttribute("selfTrailer", selfTrailer);

        return "modules/mst/selfTrailer/selfTrailerHeader";
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
    public String save(HttpServletRequest request, HttpServletResponse response, Model model) {

        SelfTrailerModel selfTrailerModel = (SelfTrailerModel) JsonUtils.getBean(request, SelfTrailerModel.class);

        String pageType = request.getParameter("pageType");
        ResultModel result = new ResultModel();
        try {
            selfTrailerService.saveSelfTrailer(selfTrailerModel, pageType);
            result.setResultType(GlobalConstants.RESULT_SUCCESS);
            result.setResultMsg("保存成功！");
        } catch (Exception e) {
            e.printStackTrace();
            result.setResultType(GlobalConstants.RESULT_ERROR);
            result.setResultMsg("保存异常，异常信息:\n" + e.getMessage());
        }

        return JsonUtils.toString(result);

    }

    @RequestMapping(value = "deleteSelfTrailer")
    @ResponseBody
    public String deleteSelfTrailer(HttpServletRequest request, HttpServletResponse response, Model model) {
        SelfTrailerModel selfTrailerModel = (SelfTrailerModel) JsonUtils.getBean(request, SelfTrailerModel.class);
        ResultModel result = new ResultModel();
        String plateNums = request.getParameter("plateNums");
        try {
            selfTrailerService.deleteSelfTrailer(plateNums);
            result.setResultType(GlobalConstants.RESULT_SUCCESS);
            result.setResultMsg("删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            result.setResultType(GlobalConstants.RESULT_ERROR);
            result.setResultMsg("保存异常，异常信息:\n" + e.getMessage());
        }

        return JsonUtils.toString(result);

    }

    //导出
    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        SelfTrailerModel selfTrailerModel = (SelfTrailerModel) JsonUtils.getBean(request, SelfTrailerModel.class);

        List<SelfTrailerModel> selfTrailerModelList = selfTrailerService.findMstTrailerList(selfTrailerModel);

        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dateMap.put("selfTrailerModelList", selfTrailerModelList);
        dateMap.put("ExpandedRowCount", selfTrailerModelList.size() + 7);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "selfTrailer.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("自有车辆.xls", "utf-8"));
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

    @RequestMapping(value = "getTruckPlateNo")
    @ResponseBody
    public String getTruckPlateNo(HttpServletRequest request, HttpServletResponse response, Model model) {
        String truckPlateNos = SelectUtils.getOptionList("getTruckPlateNo","");
        truckPlateNos = truckPlateNos.replaceAll("\\\\", "");
        return truckPlateNos;
    }
}