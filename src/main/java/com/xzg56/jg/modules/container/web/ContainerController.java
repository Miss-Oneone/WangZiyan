package com.xzg56.jg.modules.container.web;

import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.Page;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.common.model.ContainerModel;
import com.xzg56.jg.modules.container.model.PriceContractModel;
import com.xzg56.jg.modules.container.model.PriceContractSearchModel;
import com.xzg56.jg.modules.container.service.ContainerService;
import com.xzg56.jg.modules.helper.model.HelperModel;
import com.xzg56.jg.modules.helper.service.HelperService;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteSearchModel;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.FileUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;


@Controller
@RequestMapping(value = "${adminPath}/container")
public class ContainerController extends BaseController {

    @Resource(name = "ContainerService")
    private ContainerService containerService;

    @Resource
    private HelperService helperService;

    /**
     * 订单编辑页
     */
    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
        ContainerModel containerModel = new ContainerModel();
        containerModel.setTransportType(Constants.TRANSPORT_TYPE.LONG);//运输类型默认陆运
        containerModel.setCollectionOrderNo(GlobalConstants.NO);//是否收单默认否
        containerModel.setOrderDate(DateUtils.getDate());//当前日期
        String orderNo = request.getParameter("orderNo");
        if (StringUtils.isNotBlank(orderNo)) {
            //编辑 根据订单号查询信息
            containerModel = containerService.searchOrder(orderNo);
        }
        model.addAttribute("containerModel", containerModel);
        return "modules/container/container";
    }

    /**
     * 订单查询页
     */
    @RequestMapping(value = {"orderSearch", ""})
    public String orderSearch(HttpServletRequest request, HttpServletResponse response, Model model) {
        ContainerModel containerModel = new ContainerModel();
        String beginTime = DateUtils.getDate();
        String endTime = DateUtils.getDateAfter(2);
        containerModel.setBeginTime(beginTime);
        containerModel.setEndTime(endTime);
        containerModel.setCollectionOrderYes(GlobalConstants.YES);
        containerModel.setCollectionOrderNo(GlobalConstants.NO);
        containerModel.setScheduling(GlobalConstants.YES);
        containerModel.setUnScheduling(GlobalConstants.YES);
        containerModel.setTripFlagUp(Constants.TRIP_FLAG_UP);
        containerModel.setTripFlagDown(Constants.TRIP_FLAG_DOWN);
        containerModel.setTripFlagNone(Constants.NONE);
        int roleWithoutDispatcherCnt = containerService.countRoleWithoutDispatcher();
        model.addAttribute("roleWithoutDispatcherCnt", roleWithoutDispatcherCnt);
        model.addAttribute("containerModel", containerModel);
        model.addAttribute("gridModel", getGridConfig("container"));
        return "modules/container/orderSearch";
    }


    /**
     * 保存订单
     */
    @RequestMapping(value = {"saveOrder"})
    @ResponseBody
    public String saveOrder(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        ContainerModel containerModel = JsonUtils.getBean(request,ContainerModel.class);
        try {
            if (StringUtils.isBlank(containerModel.getContaBfId())) {
                containerModel.setContaBfId(null);
            }
            if (StringUtils.isBlank(containerModel.getOrderNo())) {
                //新增
                containerService.addOrder(containerModel);
            } else {
                //更新
                containerService.updateOrder(containerModel);
            }
            result.setResultMsg("保存成功");
        }catch (ValidationException ve){
            ve.printStackTrace();
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            result.setErrorMsg("保存失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }


    /**
     * 查询订单列表
     */

    @RequestMapping(value = {"search"})
    @ResponseBody
    public String searchOrderList(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel<ContainerModel> result = new ResultModel<>();
        ContainerModel containerModel = JsonUtils.getBean(request,ContainerModel.class);
        List<ContainerModel> list = new ArrayList<>();
        try {
            list = containerService.searchOrderList(containerModel);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
            System.out.println(e.getMessage());
        }
        JQResultModel resultModel = new JQResultModel(list,containerModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    /**
     * 查询车架号
     */
    @RequestMapping(value = {"searchFrameNum"})
    @ResponseBody
    public String searchFrameNum(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String id = request.getParameter("id");
        try {
            String frameNum = containerService.searchFrameNum(id);
            result.setDataModel(frameNum);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    /**
     * 查询司机
     */
    @RequestMapping(value = {"getDriverCode"})
    @ResponseBody
    public String getDriverCode(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String plateNum = request.getParameter("plateNum");
        try {
            ContainerModel driverCode = containerService.getDriverCode(plateNum);
            result.setDataModel(driverCode);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    /**
     * 查询箱号是mst_contn是否存在
     */
    @RequestMapping(value = {"getContnNos"})
    @ResponseBody
    public String getContnNos(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String contnNo = request.getParameter("contnNo");
        try {
            ContainerModel contnNoMsg = containerService.getContnNos(contnNo);
            result.setDataModel(contnNoMsg);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    /**
     * 模糊查询箱号
     */
    @RequestMapping(value = {"getLikeContnNos"})
    @ResponseBody
    public String getLikeContnNos(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String contnNo = request.getParameter("contnNo");
        try {
            List<String> likeContnNos = containerService.getLikeContnNos(contnNo);
            result.setDataModel(likeContnNos);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    /**
     * 根据箱号查询截箱时间
     */
    @RequestMapping(value = {"getCrossBoxTime"})
    @ResponseBody
    public String getCrossBoxTime(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String contnNo = request.getParameter("contnNo");
        try {
            String crossBoxTime = containerService.getCrossBoxTime(contnNo);
            result.setDataModel(crossBoxTime);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    /**
     * 根据起始到达地获取标准四级地址
     * @param request
     * @return
     * @throws ValidationException
     */
    @RequestMapping(value = {"getStdAdrsCodesByZxd"})
    @ResponseBody
    public String getStdAdrsCodesByZxd(HttpServletRequest request) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String zxdId = request.getParameter("zxdId");
        try {
            ContainerModel stdAdrsCodes = containerService.getStdAdrsCodesByZxd(zxdId);
            result.setDataModel(stdAdrsCodes);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    /**
     * 根据客户获取价格协议
     * @param request
     * @return
     * @throws ValidationException
     */
    @RequestMapping(value = {"getPriceContracts"})
    @ResponseBody
    public String getPriceContracts(HttpServletRequest request) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String cusCode = request.getParameter("cusCode");
        try {
            List<HelperModel> priceContracts = containerService.getPriceContracts(cusCode);
            result.setDataModel(priceContracts);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"getPriceContractBfs"})
    @ResponseBody
    public String getPriceContractBfs(HttpServletRequest request) throws ValidationException {
        ResultModel result = new ResultModel<>();
        PriceContractSearchModel searchModel = JsonUtils.getBean(request, PriceContractSearchModel.class);
        try {
            List<PriceContractModel> priceContractBfs = containerService.getPriceContractBfs(searchModel);
            result.setDataModel(priceContractBfs);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"chosePriceBfList", ""})
    public String chosePriceBfList(HttpServletRequest request, HttpServletResponse response, Model model) {
        String ids = request.getParameter("ids");
        model.addAttribute("ids", ids);
        model.addAttribute("gridModel", getGridConfig("chosePriceBfList"));
        return "modules/container/chosePriceBfList";
    }

    @RequestMapping(value = {"getPriceContractBfsByIds"})
    @ResponseBody
    public String getPriceContractBfsByIds(HttpServletRequest request) throws ValidationException {
        ResultModel result = new ResultModel<>();
        List<PriceContractModel> priceContractBfs = null;
        try {
            String ids = request.getParameter("ids");
             priceContractBfs = containerService.getPriceContractBfs(ids);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        JQResultModel resultModel = new JQResultModel(priceContractBfs, new Page());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"getCityList"})
    @ResponseBody
    public String getCityList(HttpServletRequest request, HttpServletResponse response) {
        ResultModel resultModel = new ResultModel();
        try {
            String provinceCode = request.getParameter("provinceCode");
            List<HelperModel> list = helperService.listChildStdAddress(provinceCode);
            resultModel.setDataList(list);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("helper获取数据失败：" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"getDistrictList"})
    @ResponseBody
    public String getDistrictList(HttpServletRequest request) {
        ResultModel resultModel = new ResultModel();
        try {
            String cityCode = request.getParameter("cityCode");
            List<HelperModel> list = helperService.listChildStdAddress(cityCode);
            resultModel.setDataList(list);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("helper获取数据失败：" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"getCountyList"})
    @ResponseBody
    public String getCountyList(HttpServletRequest request) {
        ResultModel resultModel = new ResultModel();
        try {
            String districtCode = request.getParameter("districtCode");
            List<HelperModel> list = helperService.listChildStdAddress(districtCode);
            resultModel.setDataList(list);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("helper获取数据失败：" + e.getMessage());
        }
        return JsonUtils.toString(resultModel);
    }

    //导出
    @RequestMapping(value = "export")
    public String export(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        ContainerModel containerModel = JsonUtils.getBean(request,ContainerModel.class);
        containerModel.setPage(null);
        List<ContainerModel> orderList = containerService.searchOrderList(containerModel);

        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        dateMap.put("orderList", orderList);
        dateMap.put("ExpandedRowCount", orderList.size() + 2);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "orderList.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("订单列表.xls", "utf-8"));
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

    @RequestMapping(value = {"getCostRoutes"})
    @ResponseBody
    public String getCostRoutes(HttpServletRequest request) throws ValidationException {
        ResultModel result = new ResultModel<>();
        CostRouteSearchModel searchModel = JsonUtils.getBean(request, CostRouteSearchModel.class);
        try {
            List<CostRouteModel> costRouteModels = containerService.listCostRoutes(searchModel);
            result.setDataModel(costRouteModels);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    @RequestMapping(value = {"choseCostRouteList"})
    public String choseCostRouteList(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("ids", request.getParameter("ids"));
        model.addAttribute("plateNum", request.getParameter("plateNum"));
        model.addAttribute("fromAdrs", request.getParameter("fromAdrs"));
        model.addAttribute("toAdrs", request.getParameter("toAdrs"));
        model.addAttribute("gridModel", getGridConfig("choseCostRouteList"));
        return "modules/container/choseCostRouteList";
    }

    @RequestMapping(value = {"getCostRoutesByIds"})
    @ResponseBody
    public String getCostRoutesByIds(HttpServletRequest request) throws ValidationException {
        ResultModel result = new ResultModel<>();
        List<CostRouteModel> priceContractBfs = null;
        try {
            String ids = request.getParameter("ids");
            priceContractBfs = containerService.listCostRoutes(ids);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        JQResultModel resultModel = new JQResultModel(priceContractBfs, new Page());
        return JsonUtils.toString(resultModel);
    }
}
