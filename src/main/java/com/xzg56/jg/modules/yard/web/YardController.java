package com.xzg56.jg.modules.yard.web;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.common.constant.ApiConstant;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.persistence.entity.HeapPlanImportHd;
import com.xzg56.jg.modules.yard.model.HeapPlanModel;
import com.xzg56.jg.modules.yard.model.HeapPlanSearchModel;
import com.xzg56.jg.modules.yard.service.YardService;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.FileUtils;
import com.xzg56.utility.HttpUtils;
import com.xzg56.utility.StringUtils;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
 * Created by wellen on 2019/8/21.
 */

@Controller
@RequestMapping(value = {"${adminPath}/yard"})
public class YardController extends BaseController {

    @Resource
    private YardService yardService;

    @RequestMapping(value = {"init", ""})
    public String init(Model model) {
        Map<String, String> params = new HashedMap();
        params.put("userId", UserUtils.getUserId());
        params.put("groupNo", "HEAP_TYPE");
        // 堆数据
        String result = HttpUtils.post(ApiConstant.JGZX_API.GET_HEAPS, params, ApiConstant.JGZX_SERVICE_APIKEY);
        JSONObject res = JSON.parseObject(result);
        JSONArray resData = res.getJSONArray("data");
        // 堆类型
        String heapTypesResult = HttpUtils.post(ApiConstant.JGZX_API.GET_DICTS_BY_GROUP_NO, params,ApiConstant.JGZX_SERVICE_APIKEY);
        JSONObject heapTypesRes = JSON.parseObject(heapTypesResult);
        JSONArray heapTypesResData = heapTypesRes.getJSONArray("data");

        // 箱子按类型统计
        String heapContnTypeResult = HttpUtils.post(ApiConstant.JGZX_API.COUNT_HEAP_CONTNS_BY_HEAP_TYPE, params, ApiConstant.JGZX_SERVICE_APIKEY);
        JSONObject heapContnTypeRes = JSON.parseObject(heapContnTypeResult);
        JSONArray heapContnTypeResData = heapContnTypeRes.getJSONArray("data");

        for(int i=0;i<heapTypesResData.size();i++){
            JSONObject heapType = heapTypesResData.getJSONObject(i);
            heapType.put("count", 0);
            for(int j=0;j<heapContnTypeResData.size();j++) {
                JSONObject heapContnType = heapContnTypeResData.getJSONObject(j);
                if (StringUtils.equals(heapType.getString("value"), heapContnType.getString("heapType"))) {
                    heapType.put("count", heapContnType.getIntValue("count"));
                    break;
                }
            }
        }
        model.addAttribute("heaps", resData);
        model.addAttribute("heapTypes", heapTypesResData);
        return "modules/yard/yardMap";
    }

    @RequestMapping(value = {"heapContnView"})
    public String heapContnView(HttpServletRequest request, Model model) {
        String heapNo = request.getParameter("heapNo");
        Map<String, String> params = new HashedMap();
        params.put("userId", UserUtils.getUserId());
        params.put("heapNo", heapNo);
        params.put("groupNo", "HEAP_TYPE");
        // 箱数据
        String result = HttpUtils.post(ApiConstant.JGZX_API.GET_HEAP_CONTNS, params,ApiConstant.JGZX_SERVICE_APIKEY);
        JSONObject res = JSON.parseObject(result);
        JSONArray resData = res.getJSONArray("data");
        // 堆类型
        String heapTypesResult = HttpUtils.post(ApiConstant.JGZX_API.GET_DICTS_BY_GROUP_NO, params,ApiConstant.JGZX_SERVICE_APIKEY);
        JSONObject heapTypesRes = JSON.parseObject(heapTypesResult);
        JSONArray heapTypesResData = heapTypesRes.getJSONArray("data");

        model.addAttribute("heapContns", resData);
        model.addAttribute("heapNo", heapNo);
        model.addAttribute("heapTypes", heapTypesResData);
        return "modules/yard/heapContn";
    }

    @RequestMapping(value = {"heapContnMoveView"})
    public String heapContnMoveView(HttpServletRequest request, Model model) {
        Map<String, String> params = new HashedMap();
        params.put("userId", UserUtils.getUserId());
        String result = HttpUtils.post(ApiConstant.JGZX_API.GET_HEAP_TREE_FORM_SPEC, params,ApiConstant.JGZX_SERVICE_APIKEY);
        JSONObject res = JSON.parseObject(result);
        JSONArray resData = res.getJSONArray("data");

        model.addAttribute("heapTreeForm", resData);
        model.addAttribute("contnNo", request.getParameter("contnNo"));
        return "modules/yard/heapContnMove";
    }

    @RequestMapping(value = {"updateHeapContn"})
    @ResponseBody
    public String updateHeapContn(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            Map<String, String> params = new HashedMap();
            params.put("userId", UserUtils.getUserId());
            params.put("contnNo", request.getParameter("contnNo"));
            params.put("heapContnNo", request.getParameter("heapContnNo"));
            String result = HttpUtils.post(ApiConstant.JGZX_API.UPDATE_HEAP_CONTN, params,ApiConstant.JGZX_SERVICE_APIKEY);
            JSONObject res = JSON.parseObject(result);
            String resCode = res.getString("code");
            if (!StringUtils.equals("0", resCode)) {
                throw new ValidationException(res.getString("msg"));
            }
        } catch (Exception e) {
            logger.error("快速移箱失败：", e);
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"searchContns"})
    @ResponseBody
    public String searchContns(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            Map<String, String> params = new HashedMap();
            params.put("userId", UserUtils.getUserId());
            params.put("contnNo", request.getParameter("contnNo"));
            String result = HttpUtils.post(ApiConstant.JGZX_API.SEARCH_CONTNS, params,ApiConstant.JGZX_SERVICE_APIKEY);
            JSONObject res = JSON.parseObject(result);
            String resCode = res.getString("code");
            if (!StringUtils.equals("0", resCode)) {
                throw new ValidationException(res.getString("msg"));
            }

            JSONArray resData = res.getJSONArray("data");
            resultModel.setDataModel(resData);
        } catch (Exception e) {
            logger.error("查询堆场箱号失败：", e);
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"getHeapNoByContnNo"})
    @ResponseBody
    public String getHeapNoByContnNo(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            Map<String, String> params = new HashedMap();
            params.put("userId", UserUtils.getUserId());
            params.put("contnNo", request.getParameter("contnNo"));
            String result = HttpUtils.post(ApiConstant.JGZX_API.GET_HEAP_NO_BY_CONTN_NO, params,ApiConstant.JGZX_SERVICE_APIKEY);
            JSONObject res = JSON.parseObject(result);
            String resCode = res.getString("code");
            if (!StringUtils.equals("0", resCode)) {
                throw new ValidationException(res.getString("msg"));
            }

            String resData = res.getString("data");
            resultModel.setDataModel(resData);
        } catch (Exception e) {
            logger.error("查询失败：", e);
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"importPlans"})
    @ResponseBody
    public String importPlans(@RequestParam(value = "files", required = false) MultipartFile[] files) throws IOException {
        ResultModel resultModel = new ResultModel();
        try {
            if (files == null || files.length == 0) {
                throw new ValidationException("请选择上传的文件");
            }
            yardService.doImport(files);

        } catch (ValidationException ve) {
            resultModel.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            logger.error("导入计划失败：", e);
            resultModel.setErrorMsg("系统发生未知错误：" + e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"heapPlanImportHd"})
    public String heapPlanImportHd(HttpServletRequest request, Model model) {
        model.addAttribute("gridModel", getGridConfig("heapPlanImportHd"));
        model.addAttribute("batchNo", request.getParameter("batchNo"));
        model.addAttribute("dateFrom", DateUtils.getDateBefore(1));
        model.addAttribute("dateTo", DateUtils.getDateBefore(0));
        return "modules/yard/heapPlanImportHdList";
    }

    @RequestMapping(value = {"searchHd"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchHd(HttpServletRequest request, HttpServletResponse response, Model model) {
        HeapPlanSearchModel searchModel = JsonUtils.getBean(request, HeapPlanSearchModel.class);
        List<HeapPlanModel> hdList = yardService.listHeapPlanImportHds(searchModel);
        JQResultModel resultModel = new JQResultModel(hdList, searchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"deleteHd"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteHd(HttpServletRequest request) {
        ResultModel resultModel = new ResultModel();
        try {
            String heapPlanImportHdIds = request.getParameter("heapPlanImportHdIds");
            List<String> hdIds = JSON.parseArray(heapPlanImportHdIds, String.class);
            yardService.deleteHd(hdIds);
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
            logger.error("删除导入计划失败：", e);
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"heapPlan"})
    public String heapPlan(HttpServletRequest request, Model model) {
        String planDate = request.getParameter("planDate");
        model.addAttribute("gridModel", getGridConfig("heapPlan"));
        model.addAttribute("dateFrom", DateUtils.getDateBefore(0));
        model.addAttribute("dateTo", StringUtils.isNotBlank(planDate) ? planDate : DateUtils.getDateBefore(0));
        return "modules/yard/heapPlanList";
    }

    @RequestMapping(value = {"searchPlan"}, method = RequestMethod.POST)
    @ResponseBody
    public String searchPlan(HttpServletRequest request, HttpServletResponse response, Model model) {
        HeapPlanSearchModel searchModel = JsonUtils.getBean(request, HeapPlanSearchModel.class);
        List<HeapPlanModel> plans = yardService.listHeapPlans(searchModel);
        JQResultModel resultModel = new JQResultModel(plans, searchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"heapPlanImportDtl"})
    public String heapPlanView(HttpServletRequest request, Model model) {
        model.addAttribute("gridModel", getGridConfig("heapPlanImportDtl"));
        String batchNo = request.getParameter("batchNo");
        model.addAttribute("batchNo", batchNo);
        model.addAttribute("planDate", DateUtils.getDateAfter(1));
        HeapPlanImportHd importHd = yardService.getHdByBatchNo(batchNo);
        model.addAttribute("isCompleted", StringUtils.equals(PjConstants.HEAP_PLAN_IMPORT_HD_STATUS.PROCESSED, importHd.getStatus()));
        return "modules/yard/heapPlanImportDtlList";
    }

    @RequestMapping(value = {"searchDtl"}, method = RequestMethod.POST)
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) {
        HeapPlanSearchModel searchModel = JsonUtils.getBean(request, HeapPlanSearchModel.class);
        List<HeapPlanModel> dtlList = yardService.listHeapPlanImportDtls(searchModel);
        JQResultModel resultModel = new JQResultModel(dtlList, searchModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"createHeapPlan"})
    @ResponseBody
    public String createHeapPlan(HttpServletRequest request){
        ResultModel resultModel = new ResultModel();
        try {
            List<Integer> heapImportDtlIds = JsonUtils.getCollection(request.getParameter("heapImportDtlIds"), Integer.class);
            String batchNo = request.getParameter("batchNo");
            String planDate = request.getParameter("planDate");
            String referFlag = request.getParameter("referFlag");
            yardService.createHeapPlan(heapImportDtlIds, batchNo, planDate, referFlag);
        } catch (ValidationException ve) {
            resultModel.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            logger.error("生成计划失败：", e);
            resultModel.setErrorMsg("系统发生未知错误：" + e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"getHeapTypeByHeapNo"})
    @ResponseBody
    public String getHeapTypeByHeapNo(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            Map<String, String> params = new HashedMap();
            params.put("userId", UserUtils.getUserId());
            params.put("heapNo", request.getParameter("heapNo"));
            String result = HttpUtils.post(ApiConstant.JGZX_API.GET_HEAP_TYPE_BY_HEAP_NO, params,ApiConstant.JGZX_SERVICE_APIKEY);
            JSONObject res = JSON.parseObject(result);
            String resCode = res.getString("code");
            if (!StringUtils.equals("0", resCode)) {
                throw new ValidationException(res.getString("msg"));
            }

            String resData = res.getString("data");
            resultModel.setDataModel(resData);
        } catch (Exception e) {
            logger.error("查询失败：", e);
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"changeHeapType"})
    @ResponseBody
    public String changeHeapType(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            Map<String, String> params = new HashedMap();
            params.put("userId", UserUtils.getUserId());
            params.put("heapNo", request.getParameter("heapNo"));
            params.put("heapType", request.getParameter("heapType"));
            String result = HttpUtils.post(ApiConstant.JGZX_API.CHANGE_HEAP_TYPE, params,ApiConstant.JGZX_SERVICE_APIKEY);
            JSONObject res = JSON.parseObject(result);
            String resCode = res.getString("code");
            if (!StringUtils.equals("0", resCode)) {
                throw new ValidationException(res.getString("msg"));
            }
        } catch (Exception e) {
            logger.error("修改堆类型失败：", e);
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"updateHeapContns"})
    @ResponseBody
    public String updateHeapContns(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            Map<String, String> params = new HashedMap();
            params.put("userId", UserUtils.getUserId());
            params.put("heapContns", request.getParameter("heapContns"));
            String result = HttpUtils.post(ApiConstant.JGZX_API.UPDATE_HEAP_CONTNS, params,ApiConstant.JGZX_SERVICE_APIKEY);
            JSONObject res = JSON.parseObject(result);
            String resCode = res.getString("code");
            if (!StringUtils.equals("0", resCode)) {
                throw new ValidationException(res.getString("msg"));
            }
        } catch (Exception e) {
            logger.error("保存失败：", e);
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"totalPlans"}, method = RequestMethod.POST)
    @ResponseBody
    public String totalPlans(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            HeapPlanSearchModel searchModel = JsonUtils.getBean(request, HeapPlanSearchModel.class);
            int cntUntreated = yardService.totalPlansByStatus(searchModel, PjConstants.HEAP_PLAN_STATUS.UNTREATED);
            int cntProcessed = yardService.totalPlansByStatus(searchModel, PjConstants.HEAP_PLAN_STATUS.PROCESSED);
            HeapPlanModel planModel = new HeapPlanModel();
            planModel.setCntUntreated(cntUntreated);
            planModel.setCntProcessed(cntProcessed);

            resultModel.setDataModel(planModel);
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
            logger.error("查询错误：", e);
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"heapPlanDateEdit"})
    public String heapPlanDateEdit(HttpServletRequest request, Model model) {
        String heapPlanIds = request.getParameter("heapPlanIds");
        model.addAttribute("heapPlanIds", heapPlanIds);
        return "modules/yard/heapPlanDateEdit";
    }

    @RequestMapping(value = {"updatePlanDate"}, method = RequestMethod.POST)
    @ResponseBody
    public String updatePlanDate(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            List<String> heapPlanIds = JSON.parseArray(request.getParameter("heapPlanIds"), String.class);
            String planDate = request.getParameter("planDate");
            yardService.updatePlanDate(heapPlanIds, planDate);
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
            logger.error("计划日期修改失败：", e);
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"countHeapContns"}, method = RequestMethod.POST)
    @ResponseBody
    public String countHeapContns(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel resultModel = new ResultModel();
        try {
            int cnt = yardService.countHeapContns();
            resultModel.setDataModel(cnt);
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
            logger.error("柜量统计失败：", e);
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"countHeapContnsByHeapType"}, method = RequestMethod.POST)
    @ResponseBody
    public String countHeapContnsByHeapType() {
        ResultModel resultModel = new ResultModel();
        try {
            Map<String, String> params = new HashedMap();
            String result = HttpUtils.post(ApiConstant.JGZX_API.COUNT_HEAP_CONTNS_BY_HEAP_TYPE, params, ApiConstant.JGZX_SERVICE_APIKEY);
            JSONObject res = JSON.parseObject(result);
            String resCode = res.getString("code");
            if (!StringUtils.equals("0", resCode)) {
                throw new ValidationException(res.getString("msg"));
            }
            String resData = res.getString("data");
            resultModel.setDataModel(resData);
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg(e.getMessage());
            logger.error("统计失败：", e);
        }

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"exportDtl"})
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
        HeapPlanSearchModel searchModel = JsonUtils.getBean(request, HeapPlanSearchModel.class);
        searchModel.setPage(null);
        List<HeapPlanModel> dtlList = yardService.listHeapPlanImportDtls(searchModel);
        Map<String, Object> dataMap = new HashMap<>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dataMap.put("dtlList", dtlList);
        dataMap.put("ExpandedRowCount", dtlList.size() + 2);
        String batchNo = null, goodsNo = null, customsClearanceDate = null, goodsOweQuantity = null;
        if (dtlList.size() > 0) {
            HeapPlanModel planModel = dtlList.get(0);
            batchNo = planModel.getBatchNo();
            goodsNo = planModel.getGoodsNo();
            customsClearanceDate = planModel.getCustomsClearanceDate();
            goodsOweQuantity = StringUtils.toString(planModel.getGoodsOweQuantity());
        }
        dataMap.put("batchNo", batchNo);
        dataMap.put("goodsNo", goodsNo);
        dataMap.put("customsClearanceDate", customsClearanceDate);
        dataMap.put("goodsOweQuantity", goodsOweQuantity);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "heapPlanImportDtl.ftl", dataMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("导入计划明细.xls", "utf-8"));
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
     * 多批次导出明细
     * @param request
     * @param response
     * @param model
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = {"multBatchExportDtls"})
    public String multBatchExportDtls(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
        List<String> batchNos = JsonUtils.getCollection(request.getParameter("batchNos"), String.class);
        List<HeapPlanModel> dtlList = yardService.listMultBatchHeapPlanImportDtls(batchNos);
        Map<String, Object> dataMap = new HashMap<>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dataMap.put("dtlList", dtlList);
        dataMap.put("ExpandedRowCount", dtlList.get(0).getActSize() + 2);
        String batchNo = null, goodsNo = null, customsClearanceDate = null, goodsOweQuantity = null;
        if (dtlList.size() > 0) {
            HeapPlanModel planModel = dtlList.get(0);
            batchNo = planModel.getBatchNo();
            goodsNo = planModel.getGoodsNo();
            customsClearanceDate = planModel.getCustomsClearanceDate();
            goodsOweQuantity = StringUtils.toString(planModel.getGoodsOweQuantity());
        }
        dataMap.put("batchNo", batchNo);
        dataMap.put("goodsNo", goodsNo);
        dataMap.put("customsClearanceDate", customsClearanceDate);
        dataMap.put("goodsOweQuantity", goodsOweQuantity);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "heapPlanImportDtls.ftl", dataMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("导入计划明细.xls", "utf-8"));
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
