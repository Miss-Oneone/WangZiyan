package com.xzg56.jg.modules.mst.zxaddress.web;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.zxaddress.model.ZxAddressModel;
import com.xzg56.jg.modules.mst.zxaddress.model.ZxAddressSearchModel;
import com.xzg56.jg.modules.mst.zxaddress.service.ZxAddressService;
import com.xzg56.utility.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping(value = "${adminPath}/zxAddress")
public class ZxAddressController extends BaseController {

    @Resource(name = "ZxAddressService")
    @Autowired
    private ZxAddressService zxAddressService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
        String provinceCode = request.getParameter("provinceCode");
        String cityCode = request.getParameter("cityCode");
        String districtCode = request.getParameter("districtCode");
        String countyCode = request.getParameter("countyCode");
        String addrsFull = request.getParameter("addrsFull");
        String contactor = request.getParameter("contactor");
        String phone = request.getParameter("phone");
        String type = request.getParameter("type");
        String cusCode = request.getParameter("cusCode");

        model.addAttribute("gridModel", getGridConfig("zxAddress"));
        model.addAttribute("provinceCode",provinceCode);
        model.addAttribute("cityCode",cityCode);
        model.addAttribute("districtCode",districtCode);
        model.addAttribute("countyCode",countyCode);
        model.addAttribute("addrsFull",addrsFull);
        model.addAttribute("contactor",contactor);
        model.addAttribute("phone",phone);
        model.addAttribute("type",type);
        model.addAttribute("cusCode",cusCode);
        return "modules/mst/zxaddress/zxAddressList";
    }

    //获取地址列表
    @RequestMapping(value = {"search"})
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ZxAddressSearchModel searchModel = JsonUtils.getBean(request, ZxAddressSearchModel.class);

        List<ZxAddressModel> list = zxAddressService.getZxAddressList(searchModel);
        JQResultModel resultModel = new JQResultModel(list, searchModel.getPage());

        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = "detail")
    public String detail(HttpServletRequest request, HttpServletResponse response, Model model) {
        ZxAddressModel zxAddressModel = new ZxAddressModel();
        String provinceCode = request.getParameter("provinceCode");
        String cityCode = request.getParameter("cityCode");
        String districtCode = request.getParameter("districtCode");
        String countyCode = request.getParameter("countyCode");
        String addrsFull = request.getParameter("addrsFull");
        String contactor = request.getParameter("contactor");
        String phone = request.getParameter("phone");
        String type = request.getParameter("type");

        zxAddressModel.setProvinceCode(provinceCode);
        zxAddressModel.setCityCode(cityCode);
        zxAddressModel.setDistrictCode(districtCode);
        zxAddressModel.setCountyCode(countyCode);
        zxAddressModel.setAddress(addrsFull);
        zxAddressModel.setContactPerson(contactor);
        zxAddressModel.setContactPhone(phone);

        String id = request.getParameter("id");
        if (StringUtils.isNotBlank(id)) {
            zxAddressModel = zxAddressService.getZxAddressDetail(id);
        }
        model.addAttribute("type",type);
        model.addAttribute("zxAddressModel", zxAddressModel);

        return "modules/mst/zxaddress/zxAddressDetail";
    }

    /**
     * 新增或编辑
     * @param request
     * @return
     */
    @RequestMapping(value = "save")
    @ResponseBody
    public String save(HttpServletRequest request){
        ResultModel resultModel = new ResultModel();
        try {
            ZxAddressModel zxAddressModel = JsonUtils.getBean(request, ZxAddressModel.class);
            if (StringUtils.isBlank(zxAddressModel.getId())) {
                zxAddressService.doSave(zxAddressModel);
            } else {
                zxAddressService.doUpdate(zxAddressModel);
            }
        }catch (ValidationException ve){
            resultModel.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resultModel.setErrorMsg("新增或编辑失败"+e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }

    /**
     * 删除地址
     * @param request
     * @return
     */
    @RequestMapping(value = "deleteAddressList")
    @ResponseBody
    public String deleteAddressList(HttpServletRequest request){
            ResultModel resultModel = new ResultModel();
        try {
            String idList = request.getParameter("idList");
            List<Long> ids = JsonUtils.getCollection(idList,Long.class);
            zxAddressService.deleteAddressList(ids);
        }catch (ValidationException ve){
            resultModel.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resultModel.setErrorMsg("删除失败"+e.getMessage());
        }

        return JsonUtils.toString(resultModel);
    }
}
