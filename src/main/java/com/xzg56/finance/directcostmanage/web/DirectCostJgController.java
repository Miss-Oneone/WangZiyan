package com.xzg56.finance.directcostmanage.web;

import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.directcostmanage.model.DirectCostJgModel;
import com.xzg56.finance.directcostmanage.service.DirectCostJgService;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by wjn on 2017/6/6.
 */
@RequestMapping(value = {"${adminPath}/directCostManageJg"})
@Controller
public class DirectCostJgController extends BaseController {

    @Autowired
    private DirectCostJgService directCostJgService;



    @RequestMapping(value = {"search"})
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) {
        DirectCostJgModel directCostModel = (DirectCostJgModel) JsonUtils.getBean(request, DirectCostJgModel.class);
        if (StringUtils.split(directCostModel.getPaymentType(), ",").length != 1) {
            directCostModel.setPaymentType(null);
        } else {
            directCostModel.setPaymentType(StringUtils.replace(directCostModel.getPaymentType(), "'", ""));
        }
        List<DirectCostJgModel> list = directCostJgService.getDirectCost(directCostModel);
        JQResultModel resultModel = new JQResultModel(list, directCostModel.getPage());
        return JSONObject.fromObject(resultModel).toString();
    }

    @RequestMapping(value = {"getAmount"})
    @ResponseBody
    public String getAmount(HttpServletRequest request, HttpServletResponse response, Model model) {
        DirectCostJgModel directCostModel = (DirectCostJgModel) JsonUtils.getBean(request, DirectCostJgModel.class);
        ResultModel result = new ResultModel();
        if (StringUtils.split(directCostModel.getPaymentType(), ",").length != 1) {
            directCostModel.setPaymentType(null);
        } else {
            directCostModel.setPaymentType(StringUtils.replace(directCostModel.getPaymentType(), "'", ""));
        }
        directCostModel.setPage(null);
        result.setDataModel(directCostJgService.getAmount(directCostModel));
        return JSONObject.fromObject(result).toString();
    }

    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
        DirectCostJgModel directCostModel = (DirectCostJgModel) JsonUtils.getBean(request, DirectCostJgModel.class);
        if (StringUtils.split(directCostModel.getPaymentType(), ",").length != 1) {
            directCostModel.setPaymentType(null);
        } else {
            directCostModel.setPaymentType(StringUtils.replace(directCostModel.getPaymentType(), "'", ""));
        }
        directCostModel.setPage(null);
        List<DirectCostJgModel> list = directCostJgService.getDirectCost(directCostModel);
        Map<String, Object> dataMap = new HashMap<>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dataMap.put("directCostList", list);
        dataMap.put("ExpandedRowCount", list.size() + 2);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "directCost.ftl", dataMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("直接费用.xls", "utf-8"));
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
