package com.xzg56.jg.modules.mst.costroute.web;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteSearchModel;
import com.xzg56.jg.modules.mst.costroute.service.CostRouteSerivce;
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

/**
 * Created by wellen on 2019/5/30.
 */

@Controller
@RequestMapping(value = {"${adminPath}/costRoute"})
public class CostRouteController extends BaseController {

    @Resource
    private CostRouteSerivce costRouteSerivce;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("gridModel", getGridConfig("costRoute"));
        return "modules/mst/costroute/costRouteList";
    }

    @RequestMapping(value = {"search"})
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        CostRouteSearchModel searchModel = JsonUtils.getBean(request, CostRouteSearchModel.class);

        List<CostRouteModel> list = costRouteSerivce.listCostRoutes(searchModel);
        JQResultModel resultModel = new JQResultModel(list, searchModel.getPage());

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"detail"})
    public String detail(HttpServletRequest request, HttpServletResponse response, Model model) {
        String id = request.getParameter("id");
        CostRouteModel costRouteModel = new CostRouteModel();
        costRouteModel.setValidFlag("Y");
        costRouteModel.setTrailerBelongType("0");
        if (StringUtils.isNotBlank(id)) {
            costRouteModel = costRouteSerivce.findCostRouteById(id);
        }
        model.addAttribute("costRouteModel", costRouteModel);
        return "modules/mst/costroute/costRouteDetail";
    }

    @RequestMapping(value = {"save"})
    @ResponseBody
    public String save(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel resultModel = new ResultModel();
        try {
            CostRouteModel costRouteModel = JsonUtils.getBean(request, CostRouteModel.class);
            if (StringUtils.isEmpty(costRouteModel.getStdDrvSalPrice())) {
                costRouteModel.setStdDrvSalPrice(null);
            }
            if (StringUtils.isBlank(costRouteModel.getId())) {
                costRouteSerivce.doSave(costRouteModel);
            } else {
                costRouteSerivce.doUpdate(costRouteModel);
            }
        }catch (ValidationException ve){
            resultModel.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resultModel.setErrorMsg("成本路线新增或编辑失败" + e.getMessage());
            logger.error("成本路线新增或编辑失败" + e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    /**
     * 导出往来单位
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "export",method = RequestMethod.GET)
    @ResponseBody
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        Map<String, Object> dataMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        CostRouteSearchModel searchModel = JsonUtils.getBean(request, CostRouteSearchModel.class);
        searchModel.setPage(null);
        List<CostRouteModel> list = costRouteSerivce.listCostRoutes(searchModel);
        dataMap.put("list", list);
        dataMap.put("ExpandedRowCount", list.size() + 5);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "costRoute.ftl", dataMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("路线公里与工资.xls", "utf-8"));
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
