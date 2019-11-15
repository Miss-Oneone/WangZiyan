package com.xzg56.jg.modules.mst.contn.web;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.contn.model.ContnModel;
import com.xzg56.jg.modules.mst.contn.model.ContnSearchModel;
import com.xzg56.jg.modules.mst.contn.service.ContnService;
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
 * Created by wellen on 2019/4/3.
 */

@Controller
@RequestMapping(value = {"${adminPath}/contn"})
public class ContnController extends BaseController {

    @Resource
    private ContnService contnService;

    @RequestMapping(value = {"init", ""})
    public String init(Model model) {
        model.addAttribute("gridModel", getGridConfig("contn"));
        return "modules/mst/contn/contnList";
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
        ContnSearchModel contnSearchModel = (ContnSearchModel) JsonUtils.getBean(request, ContnSearchModel.class);
        List<ContnModel> contnModels = contnService.listContns(contnSearchModel);
        JQResultModel resultModel = new JQResultModel(contnModels, contnSearchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"contnDetail"}, method = RequestMethod.GET)
    public String contnDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
        ContnModel contnModel = JsonUtils.getBean(request, ContnModel.class);
        contnModel.setActiveFlag("Y");
        if(contnModel.getId() > 0) {
            contnModel = contnService.findContnById(contnModel.getId());
            contnModel.setDisabledFlag(true);
        }
        model.addAttribute("contnModel", contnModel);
        return "modules/mst/contn/contnDetail";
    }

    @RequestMapping(value = {"addContn"}, method = RequestMethod.POST)
    @ResponseBody
    public String addContn(HttpServletRequest request, HttpServletResponse response) throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            ContnModel contnModel = JsonUtils.getBean(request, ContnModel.class);
            contnService.saveContn(contnModel);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("新增集装箱失败：\n" + e.getMessage());
            result.setErrorMsg("新增集装箱失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"eidtContn"}, method = RequestMethod.POST)
    @ResponseBody
    public String eidtContn(HttpServletRequest request, HttpServletResponse response) throws ValidationException {
        ResultModel result = new ResultModel();
        try {
            ContnModel contnModel = JsonUtils.getBean(request, ContnModel.class);
            contnService.updateContn(contnModel);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("编辑集装箱失败：\n" + e.getMessage());
            logger.error("编辑集装箱失败：\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    //导出
    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        ContnSearchModel contnSearchModel = (ContnSearchModel) JsonUtils.getBean(request, ContnSearchModel.class);
        contnSearchModel.setPage(null);
        List<ContnModel> contnModels = contnService.listContns(contnSearchModel);

        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dateMap.put("list", contnModels);
        dateMap.put("ExpandedRowCount", contnModels.size() + 7);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "contnList.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("自备箱管理.xls", "utf-8"));
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
