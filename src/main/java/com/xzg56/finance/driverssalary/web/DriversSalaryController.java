package com.xzg56.finance.driverssalary.web;

import com.alibaba.fastjson.JSONArray;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.common.persistence.entity.OrdSalaryAdditional;
import com.xzg56.finance.driverssalary.model.DriversSalaryDetailModel;
import com.xzg56.finance.driverssalary.model.DriversSalaryModel;
import com.xzg56.finance.driverssalary.model.DriversSalarySearchModel;
import com.xzg56.finance.driverssalary.service.DriversSalaryService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.FileUtils;
import org.apache.commons.lang.StringUtils;
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
 * Created by wellen on 2019/5/28.
 */

@Controller
@RequestMapping(value = {"${adminPath}/driversSalary"})
public class DriversSalaryController extends BaseController {

    @Resource
    private DriversSalaryService driversSalaryService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("gridModel", getGridConfig("driversSalary"));
        String salaryMonth = DateUtils.formatDate(DateUtils.getLastMonthFirstTime(), "yyyy-MM");
        model.addAttribute("salaryMonth", salaryMonth);

        return "finance/driverssalary/driversSalary";
    }

    @RequestMapping(value = {"search"}, method = RequestMethod.POST)
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) {
        DriversSalarySearchModel salarySearchModel = JsonUtils.getBean(request, DriversSalarySearchModel.class);
        salarySearchModel.setPage(null);

        List<DriversSalaryModel> driversSalaryModels = driversSalaryService.search(salarySearchModel);

        JQResultModel resultModel = new JQResultModel(driversSalaryModels, salarySearchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = "updateAmountForm")
    public String updateAmountForm(HttpServletRequest request, HttpServletResponse response, Model model) {
        DriversSalaryModel amountInfo = (DriversSalaryModel) JsonUtils.getBean(request, DriversSalaryModel.class);
        model.addAttribute("model", amountInfo);
        return "finance/driverssalary/updateAmountForm";
    }

    @RequestMapping(value = "findDriverAddtionInfo")
    @ResponseBody
    public String findDriverAddtionInfo(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        DriversSalarySearchModel salarySearchModel = JsonUtils.getBean(request, DriversSalarySearchModel.class);
        try {
            DriversSalaryModel driverAddtionInfo = driversSalaryService.findDriverAddtionInfo(salarySearchModel);
            resultModel.setDataModel(driverAddtionInfo);
        } catch (Exception e) {
            resultModel.setErrorMsg("查找司机工资附加项信息出错");
            logger.error("查找司机工资附加项信息出错:" + e.getMessage());
            e.printStackTrace();
        }
        return JsonUtils.toString(resultModel);
    }

    /**
     * 保存或修改司机工资附加项
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "saveOrUpdateDriverSalaryAmount")
    @ResponseBody
    public String saveOrUpdateDriverSalaryAmount(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            OrdSalaryAdditional ordSalaryAdditional = (OrdSalaryAdditional) JsonUtils.getBean(request, OrdSalaryAdditional.class);
            driversSalaryService.saveOrUpdateDriverSalaryAmount(ordSalaryAdditional);
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg("保存异常，异常信息:\n" + e.getMessage());
            logger.error("保存异常，异常信息:\n" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = "updateAmountFormBatch")
    public String updateAmountFormBatch(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "finance/driverssalary/updateAmountFormBatch";
    }

    /**
     * 保存或修改司机工资附加项(批量)
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "saveOrUpdateDriverSalaryAmountBatch")
    @ResponseBody
    public String saveOrUpdateDriverSalaryAmountBatch(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        String dataList = request.getParameter("data");
        List<OrdSalaryAdditional> ordSalaryAdditionalList = JSONArray.parseArray(dataList, OrdSalaryAdditional.class);
        try {
            driversSalaryService.saveOrUpdateDriverSalaryAmountBatch(ordSalaryAdditionalList);
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg("保存异常，异常信息:\n" + e.getMessage());
            logger.error("保存异常，异常信息:\n" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    //导出
    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        DriversSalarySearchModel salarySearchModel = JsonUtils.getBean(request, DriversSalarySearchModel.class);
        salarySearchModel.setPage(null);

        List<DriversSalaryModel> driversSalaryList = driversSalaryService.search(salarySearchModel);

        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dateMap.put("driversSalaryList", driversSalaryList);
        dateMap.put("ExpandedRowCount", driversSalaryList.size() + 4);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "driversSalary.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("司机工资.xls", "utf-8"));
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

    /**
     * 司机明细页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "driversSalaryDetail")
    public String driversSalaryDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("gridModel", getGridConfig("driversSalaryDetail"));
        String driverCode = request.getParameter("driverCode");
        String salaryMonth = request.getParameter("salaryMonth");
        model.addAttribute("driverCode", driverCode);
        model.addAttribute("salaryMonth", salaryMonth);
        return "finance/driverssalary/driversSalaryDetail";
    }

    /**
     * 司机明细查询
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"searchDetail"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
        DriversSalarySearchModel salarySearchModel = JsonUtils.getBean(request, DriversSalarySearchModel.class);
        salarySearchModel.setPage(null);
        List<DriversSalaryDetailModel> driversSalaryDetailModels = driversSalaryService.searchDetail(salarySearchModel);
        JQResultModel resultModel = new JQResultModel(driversSalaryDetailModels, salarySearchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    /**
     * 单个司机明细下载
     * @param request
     * @param response
     * @param model
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "download")
    public String download(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        String driverCode = request.getParameter("driverCode");
        String salaryMonth = request.getParameter("salaryMonth");
        DriversSalarySearchModel salarySearchModel = new DriversSalarySearchModel();
        salarySearchModel.setDriverCode(driverCode);
        salarySearchModel.setSalaryMonth(salaryMonth);
        String driverName = driversSalaryService.fingDriverName(driverCode);
        List<DriversSalaryDetailModel> driversSalaryDetailModels = driversSalaryService.searchDetail(salarySearchModel);

        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dateMap.put("driversSalaryDetailModels", driversSalaryDetailModels);
        dateMap.put("ExpandedRowCount", driversSalaryDetailModels.size()+8);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "driversSalaryDetail.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode(driverName+ StringUtils.substring(salaryMonth,salaryMonth.length()-2)+"月工资明细.xls", "utf-8"));
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
