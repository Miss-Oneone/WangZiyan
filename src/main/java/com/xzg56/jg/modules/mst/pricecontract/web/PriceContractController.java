package com.xzg56.jg.modules.mst.pricecontract.web;

import com.alibaba.fastjson.JSONArray;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.jg.modules.common.persistence.entity.PriceContract;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractCus;
import com.xzg56.jg.modules.mst.pricecontract.model.*;
import com.xzg56.jg.modules.mst.pricecontract.service.PriceContractService;
import com.xzg56.utility.StringUtils;
import com.xzg56.utility.excel.ImportExcel;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.util.*;

@Controller
@RequestMapping(value = "${adminPath}/priceContract")
public class PriceContractController extends BaseController {

    @Resource(name = "priceContractService")
    @Autowired
    private PriceContractService priceContractService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("gridModel", getGridConfig("priceContract"));
        model.addAttribute("cusGridModel", getGridConfig("priceContractCus"));
        String searchFlag = request.getParameter("searchFlag");
        if(StringUtils.equals(BizFcConstants.YES,searchFlag)) {
            model.addAttribute("displayNone", "display:none");
        }
        return "modules/mst/pricecontract/priceContractList";
    }

    //获取价格协议列表
    @RequestMapping(value = {"search"})
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        PriceContractModel priceContractModel = JsonUtils.getBean(request, PriceContractModel.class);
        List<PriceContractModel> list = priceContractService.getPriceContractList(priceContractModel);
        JQResultModel resultModel = new JQResultModel(list, priceContractModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    //获取价格协议客户关联列表
    @RequestMapping(value = {"cusSearch"})
    @ResponseBody
    public String cusSearch(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        PriceContractCusModel priceContractCusModel = JsonUtils.getBean(request, PriceContractCusModel.class);
        List<PriceContractCusModel> list = null;
        list = priceContractService.getPriceContractCusList(priceContractCusModel);
        JQResultModel resultModel = new JQResultModel(list, priceContractCusModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    //跳转到协议编辑页面
    @RequestMapping(value = {"priceContractDetail"})
    public String mstPriceContractAddOrEdit(HttpServletRequest request, HttpServletResponse response, Model model) {
        String pageType = request.getParameter("pageType");
        PriceContractModel priceContractModel = new PriceContractModel();
        if (StringUtils.equals(BizFcConstants.PAGE_TYPE.EDIT, pageType)
                || StringUtils.equals(BizFcConstants.PAGE_TYPE.COPY, pageType)) {
            priceContractModel = JsonUtils.getBean(request, PriceContractModel.class);
            PriceContractModel result = priceContractService.getPriceContractList(priceContractModel).get(0);
            if (StringUtils.equals(BizFcConstants.PAGE_TYPE.COPY, pageType)) {
                result.setPriceContractNo(null);
            }
            model.addAttribute("mstPriceContractModel", result);
        } else {
            priceContractModel.setSecondEnableFlag(BizFcConstants.YES);
            priceContractModel.setValidFlag(BizFcConstants.YES);
            priceContractModel.setSettlementType("1");
            model.addAttribute("mstPriceContractModel", priceContractModel);
        }

        model.addAttribute("pageType", pageType);
        return "modules/mst/pricecontract/priceContractDetail";
    }

    //保存价格协议
    @RequestMapping(value = {"save"})
    @ResponseBody
    public String save(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel<>();
        PriceContract priceContract = JsonUtils.getBean(request, PriceContract.class);
        try {
            priceContractService.save(priceContract);
            resultModel.setResultMsg("保存成功");
        } catch (ValidationException ve) {
            resultModel.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg("保存失败" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"delete"}, method = RequestMethod.POST)
    @ResponseBody
    public String delete(HttpServletRequest request) {
        ResultModel result = new ResultModel();
        try {
            String priceContractNo = request.getParameter("priceContractNo");
            priceContractService.delete(priceContractNo);
            result.setResultMsg("删除成功");
        } catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("删除失败:\n" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

    //跳转到协议编辑页面
    @RequestMapping(value = {"priceContractCusDetail"})
    public String mstPriceContractCusAddOrEdit(HttpServletRequest request, HttpServletResponse response, Model model) {
        String pageType = request.getParameter("pageType");
        PriceContractCusModel priceContractCusModel = JsonUtils.getBean(request, PriceContractCusModel.class);
        if (StringUtils.equals(BizFcConstants.PAGE_TYPE.EDIT, pageType)
                || StringUtils.equals(BizFcConstants.PAGE_TYPE.COPY, pageType)) {
            PriceContractCusModel result = priceContractService.getPriceContractCusList(priceContractCusModel).get(0);
            model.addAttribute("mstPriceContractCusModel", result);
        } else {
            model.addAttribute("mstPriceContractCusModel", priceContractCusModel);
        }

        model.addAttribute("pageType", pageType);
        return "modules/mst/pricecontract/priceContractCusDetail";
    }

    //保存价格协议客户
    @RequestMapping(value = {"saveCus"})
    @ResponseBody
    public String saveCus(HttpServletRequest request, Model model) {
        ResultModel resultModel = new ResultModel<>();
        PriceContractCus priceContract = JsonUtils.getBean(request, PriceContractCus.class);
        try {
            priceContractService.saveCus(priceContract);
            resultModel.setResultMsg("保存成功");
        } catch (ValidationException ve) {
            resultModel.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resultModel.setErrorMsg("保存失败" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"deleteCus"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteCus(HttpServletRequest request) {
        ResultModel result = new ResultModel();
        try {
            PriceContractCus priceContract = JsonUtils.getBean(request, PriceContractCus.class);
            priceContractService.deleteCus(priceContract);
            result.setResultMsg("删除成功");
        } catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("删除失败:\n" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        PriceContractModel priceContractModel = JsonUtils.getBean(request, PriceContractModel.class);

        priceContractModel.setPage(null);
        List<PriceContractModel> list = priceContractService.getPriceContractList(priceContractModel);

        Map<String, Object> dataMap = new HashMap<>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dataMap.put("list", list);
        dataMap.put("ExpandedRowCount", list.size() + 2);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "mstPriceContract.ftl", dataMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("价格协议.xls", "utf-8"));
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
     * 价格协议明细页面初始化
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"priceContractBfInit"})
    public String priceContractBfInit(HttpServletRequest request, HttpServletResponse response, Model model) {
        String effectiveStatus = request.getParameter("effectiveStatus");
        model.addAttribute("gridModel", getGridConfig("priceContractBf"));
        model.addAttribute("priceContractNo", request.getParameter("priceContractNo"));
        model.addAttribute("fromProvinceCode", request.getParameter("fromProvinceCode"));
        model.addAttribute("fromCityCode", request.getParameter("fromCityCode"));
        model.addAttribute("fromDistrictCode", request.getParameter("fromDistrictCode"));
        model.addAttribute("fromCountyCode", request.getParameter("fromCountyCode"));
        model.addAttribute("toProvinceCode", request.getParameter("toProvinceCode"));
        model.addAttribute("toCityCode", request.getParameter("toCityCode"));
        model.addAttribute("toDistrictCode", request.getParameter("toDistrictCode"));
        model.addAttribute("toCountyCode", request.getParameter("toCountyCode"));
        model.addAttribute("effectiveStatus", StringUtils.isBlank(effectiveStatus)?BizFcConstants.YES:effectiveStatus);
        return "modules/mst/pricecontract/priceContractBfList";
    }

    /**
     * 获取运费明细列表
     * @param request
     * @param response
     * @param model
     * @return
     * @throws ValidationException
     */
    @RequestMapping(value = {"searchBf"})
    @ResponseBody
    public String searchBf(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        PriceContractBfModel mstPriceContractBfModel = JsonUtils.getBean(request, PriceContractBfModel.class);
        List<PriceContractBfModel> list = null;
        list = priceContractService.getPriceContractBfList(mstPriceContractBfModel, true);
        JQResultModel resultModel = new JQResultModel(list, mstPriceContractBfModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    /**
     * 获取市列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"getCityList"})
    @ResponseBody
    public String getCityList(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel<PriceContractBfModel> result = new ResultModel<>();

        try {
            String provinceCode = request.getParameter("provinceCode");
            List<PriceContractBfModel> list = priceContractService.getName(provinceCode);
            result.setDataList(list);
        } catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg(e.getLocalizedMessage());
        }

        return JsonUtils.toString(result);
    }

    /**
     * 获取县/区列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"getDistrictList"})
    @ResponseBody
    public String getDistrictList(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel<PriceContractBfModel> result = new ResultModel<>();

        try {
            String provinceCode = request.getParameter("cityCode");
            List<PriceContractBfModel> list = priceContractService.getName(provinceCode);
            result.setDataList(list);
        } catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg(e.getLocalizedMessage());
        }

        return JsonUtils.toString(result);
    }

    /**
     * 获取乡/镇列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"getCountyList"})
    @ResponseBody
    public String getCountyList(HttpServletRequest request, HttpServletResponse response, Model model) {
        ResultModel<PriceContractBfModel> result = new ResultModel<>();

        try {
            String provinceCode = request.getParameter("districtCode");
            List<PriceContractBfModel> list = priceContractService.getName(provinceCode);
            result.setDataList(list);
        } catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg(e.getLocalizedMessage());
        }

        return JsonUtils.toString(result);
    }

    /**
     * 跳转到编辑页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"priceContractBfDetail"})
    public String priceContractBfDetail(HttpServletRequest request, HttpServletResponse response, Model model){
        String pageType = request.getParameter("pageType");
        String priceContractNoIsSelct = request.getParameter("priceContractNoIsSelct");
        if(StringUtils.equals(BizFcConstants.PAGE_TYPE.EDIT,pageType)
                || StringUtils.equals(BizFcConstants.PAGE_TYPE.COPY,pageType)){
            PriceContractBfModel priceContractBfModel = JsonUtils.getBean(request, PriceContractBfModel.class);
            priceContractBfModel.setChargingType(null);
            PriceContractBfModel result = priceContractService.getPriceContractBfList(priceContractBfModel, false).get(0);
            model.addAttribute("priceContractBfModel",result);
            model.addAttribute("chargingType",priceContractBfModel.getChargingType());
        }else {
            model.addAttribute("priceContractNo",priceContractNoIsSelct);
        }

        model.addAttribute("pageType",pageType);
        return "modules/mst/pricecontract/priceContractBfDetail";
    }

    /**
     * 增加运费明细
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"saveBf"})
    @ResponseBody
    public String saveBf(HttpServletRequest request, HttpServletResponse response, Model model){
        ResultModel resultModel = new ResultModel<>();
        PriceContractBfModel mstPriceContractBfModel = JsonUtils.getBean(request, PriceContractBfModel.class);

        try {
            priceContractService.save(mstPriceContractBfModel);
            resultModel.setResultMsg("保存成功");
        }catch (ValidationException ve){
            resultModel.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resultModel.setErrorMsg("增加失败"+e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"deleteBf"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteBf(HttpServletRequest request, HttpServletResponse response) {
        ResultModel result = new ResultModel();
        try {
            String priceContractBfList = request.getParameter("data");
            List<PriceContractBfModel> models = JSONArray.parseArray(priceContractBfList, PriceContractBfModel.class);
            priceContractService.delete(models);
            result.setResultMsg("删除成功");
        }catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("提交失败:\n" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

    @RequestMapping(value = "exportBf")
    public String exportBf(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
        PriceContractBfModel mstPriceContractBfModel = JsonUtils.getBean(request, PriceContractBfModel.class);
        String chargingType = mstPriceContractBfModel.getChargingType();
        mstPriceContractBfModel.setPage(null);
        List<PriceContractBfModel> list = priceContractService.getPriceContractBfList(mstPriceContractBfModel, true);

        Map<String, Object> dataMap = new HashMap<>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dataMap.put("list", list);
        dataMap.put("chargingType", StringUtils.isBlank(chargingType)?"":chargingType );
        dataMap.put("ExpandedRowCount", list.size() + 2);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "mstPriceContractBf.ftl", dataMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("价格协议运费明细.xls", "utf-8"));
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

    @RequestMapping(value = "exportTemp")
    public String exportTemp(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
//        try {
//            // 清空response
//            response.reset();
//            // 设置response
//            response.setContentType("application/octet-stream; charset=utf-8");
//            response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("标准合同模板.xlsx", "utf-8"));
//            String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/views/excelTemplate/标准合同模板.xlsx";
//            File tempFile = new File(tempPath);
//            InputStream inputStream = new FileInputStream(tempFile);
//            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
//            byte[] b = new byte[2048];
//            int length;
//            while ((length = inputStream.read(b)) > 0) {
//                toClient.write(b, 0, length);
//            }
//            toClient.flush();
//            toClient.close();
//            inputStream.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;

        List<AddressModel> list = new ArrayList<>();
        AddressModel addressModel = new AddressModel();
        addressModel.setName("test");
        addressModel.setProvinceCode("350000000");
        addressModel.setCityCode("351000000");
        addressModel.setDistrictCode("35120000");
        addressModel.setCountyCode("350000001");
        list.add(addressModel);

        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dateMap.put("addressList", list);
        dateMap.put("ExpandedRowCount", list.size());
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "priceContractBf.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("价格协议导入模板.xls", "utf-8"));
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
     * 对方账户改变事件
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = { "changePriceContractList" })
    @ResponseBody
    public String changePriceContractList(HttpServletRequest request, HttpServletResponse response, Model model) {
        PriceContractBfModel mstPriceContractBfModel = (PriceContractBfModel) JsonUtils.getBean(request, PriceContractBfModel.class);
        String priceContractList = priceContractService.getPriceContractList(mstPriceContractBfModel);
        return priceContractList;
    }

    @RequestMapping(value = { "changePriceContractNoEffectiveStatus" })
    @ResponseBody
    public String changePriceContractNoEffectiveStatus(HttpServletRequest request, HttpServletResponse response, Model model) {
        String priceContractNo = request.getParameter("priceContractNo");
        String priceContractNoEffectiveStatus = priceContractService.getPriceContractNoEffectiveStatus(priceContractNo);
        return priceContractNoEffectiveStatus;
    }

    @RequestMapping(value = "importPrice")
    public String importPrice(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/mst/pricecontract/importPrice";
    }

    /**
     * 导出价格协议模板
     */
    @RequestMapping(value = "exportPriceTemp")
    public String exportPriceTemp(HttpServletRequest request, HttpServletResponse response, Model model) {
        try {
            // 清空response
            response.reset();
            // 设置response
            response.setContentType("application/octet-stream; charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("价格导入模板.xls", "utf-8"));
            String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/excelTemplates/价格导入模板.xlsx";
            File tempFile = new File(tempPath);
            InputStream inputStream = new FileInputStream(tempFile);
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            byte[] b = new byte[2048];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                toClient.write(b, 0, length);
            }
            toClient.flush();
            toClient.close();
            inputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 保存上传数据
     */
    @RequestMapping(value = {"upload"}, method = RequestMethod.POST)
    @ResponseBody
    public String upload(HttpServletRequest request, HttpServletResponse response, Model model,
                         @RequestParam("file") MultipartFile file) {
        ResultModel result = new ResultModel();
        try {
            ImportExcel ie = new ImportExcel(file, 0, 0);
            List<PriceContractBfExcelModel> priceContractBfExcelModels = ie.getDataList(PriceContractBfExcelModel.class);

            priceContractService.importPrices(priceContractBfExcelModels);
        }catch(ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
            logger.error("：导入失败\n" + e.getMessage());
            result.setErrorMsg("：导入失败\n" + e.getMessage());
        }
        return JsonUtils.toString(result);
    }
}
