package com.xzg56.finance.binsApprovalOrd.web;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.binsApprovalOrd.model.BinsApprovalOrdJg;
import com.xzg56.finance.binsApprovalOrd.model.BinsApprovalOrdJgModel;
import com.xzg56.finance.binsApprovalOrd.service.BinsApprovalOrdJgService;
import com.xzg56.utility.DateUtils;
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
 * 商务审核
 *
 * @author HT1310HL0227
 */
@Controller
@RequestMapping(value = "${adminPath}/binsApprovalOrdJg")
public class BinsApprovalOrdJgController extends BaseController {
    @Resource
    BinsApprovalOrdJgService binsApprovalOrdJgService;



    @RequestMapping(value = {"list"}, method = RequestMethod.POST)
    @ResponseBody
    public String list(HttpServletRequest request, HttpServletResponse response) throws ValidationException {
        BinsApprovalOrdJg binsApprovalOrdJg = (BinsApprovalOrdJg) JsonUtils.getBean(request, BinsApprovalOrdJg.class);
        binsApprovalOrdJg.setProfitFrom(StringUtils.replace(binsApprovalOrdJg.getProfitFrom(), ",", ""));
        binsApprovalOrdJg.setProfitTo(StringUtils.replace(binsApprovalOrdJg.getProfitTo(), ",", ""));
        List<BinsApprovalOrdJgModel> list = binsApprovalOrdJgService.find(binsApprovalOrdJg);
        JQResultModel resultModel = new JQResultModel(list, binsApprovalOrdJg.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {

        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        BinsApprovalOrdJg binsApprovalOrd = (BinsApprovalOrdJg) JsonUtils.getBean(request, BinsApprovalOrdJg.class);
        binsApprovalOrd.setPage(null);

        binsApprovalOrd.setProfitFrom(StringUtils.replace(binsApprovalOrd.getProfitFrom(), ",", ""));
        binsApprovalOrd.setProfitTo(StringUtils.replace(binsApprovalOrd.getProfitTo(), ",", ""));
        List<BinsApprovalOrdJgModel> list = binsApprovalOrdJgService.find(binsApprovalOrd);

        dateMap.put("binsApprovalOrdModelList", list);
        dateMap.put("ExpandedRowCount", list.size() + 2);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "binsApprovalOrd.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("商务审核_直接_" + DateUtils.getDate() + ".xls", "utf-8"));
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
