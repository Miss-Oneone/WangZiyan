package com.xzg56.jg.modules.mst.relateCompany.web;

import com.xzg56.common.module.sys.basic.service.NumberingService;
import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.FreeMarkers;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.relateCompany.entity.MstRelatedCompy;
import com.xzg56.jg.modules.mst.relateCompany.model.BankModel;
import com.xzg56.jg.modules.mst.relateCompany.model.PsnModel;
import com.xzg56.jg.modules.mst.relateCompany.model.RelateCompanyModel;
import com.xzg56.jg.modules.mst.relateCompany.service.RelateCompanyService;
import com.xzg56.utility.StringUtils;
import org.apache.commons.io.FileUtils;
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
import java.util.*;

@Controller
@RequestMapping(value = "${adminPath}/relateCompany")
public class RelateCompanyController extends BaseController {

    @Resource(name = "RelateCompanyService")
    private RelateCompanyService relateCompanyService;

    @Resource
    public NumberingService numberingService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("gridModel", getGridConfig("relateCompany"));
        return "modules/relateCompany/relateCompanyList";
    }

    //查询
    @RequestMapping(value = {"search"})
    @ResponseBody
    public String getMstRelateCompanyList(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel<RelateCompanyModel> result = new ResultModel<>();
        RelateCompanyModel relateCompanyModel = JsonUtils.getBean(request, RelateCompanyModel.class);
        List<RelateCompanyModel> list = new ArrayList<>();
        try {
            list = relateCompanyService.findRelateCompany(relateCompanyModel);
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        JQResultModel resultModel = new JQResultModel(list,relateCompanyModel.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"add"})
    public String addOrEdit(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        String relateCode = request.getParameter("relatedCompyCode");
        String flag = "add";
        RelateCompanyModel relateCompanyModel = new RelateCompanyModel();
        relateCompanyModel.setQuitFlag("N");
        if (StringUtils.isNotBlank(relateCode)){
            flag = "edit";
            relateCompanyModel  = relateCompanyService.selectCompany(relateCode);
        }
        model.addAttribute("bankGridModel", getGridConfig("bankAccout"));
        model.addAttribute("psnGridModel", getGridConfig("relatedCompyPsnModel"));
        model.addAttribute("flag",flag);
        model.addAttribute("relateCompanyModel",relateCompanyModel);
        return "modules/relateCompany/relateCompanyAdd";
    }

    //获取联系人信息
    @RequestMapping(value = {"getPsn"})
    @ResponseBody
    public String getPsn(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        RelateCompanyModel relatedCompy = JsonUtils.getBean(request,RelateCompanyModel.class);
        List<PsnModel> list = new ArrayList<>();
        try {
            list = relateCompanyService.selectPsnDate(relatedCompy.getRelatedCompyCode());
        }catch (ValidationException ve){
            ve.getMessage();
        }catch (Exception e){
            e.printStackTrace();
            e.getMessage();
        }
        relatedCompy.getPage().setCount(list.size());
        JQResultModel resultModel = new JQResultModel(list, relatedCompy.getPage());
        return JsonUtils.toString(resultModel);
    }

    //获取银行账号信息
    @RequestMapping(value = {"getBank"})
    @ResponseBody
    public String getBank(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        RelateCompanyModel relatedCompy = JsonUtils.getBean(request,RelateCompanyModel.class);
        //relatedCompy.setPage(null);
        List<BankModel> list = new ArrayList<>();
        try {
            list = relateCompanyService.selectBankData(relatedCompy.getRelatedCompyCode());
        }catch (ValidationException ve){
            ve.getMessage();
        }catch (Exception e){
            e.printStackTrace();
            e.getMessage();
        }
        relatedCompy.getPage().setCount(list.size());
        JQResultModel resultModel = new JQResultModel(list, relatedCompy.getPage());
        return JsonUtils.toString(resultModel);
    }

    @RequestMapping(value = {"addPsnView"})
    public String addPsnView(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        String psnFlag = request.getParameter("psnFlag");
        String flag = request.getParameter("flag");
        String id = request.getParameter("id");
        String relatedCompyCode = request.getParameter("relateCompyCode");
        String relatedPsnName = request.getParameter("relatedPsnName");
        String relatedPsnPosition = request.getParameter("relatedPsnPosition");
        String relatedPsnTel1 = request.getParameter("relatedPsnTel1");
        String relatedPsnTel2 = request.getParameter("relatedPsnTel2");
        String relatedPsnTel3 = request.getParameter("relatedPsnTel3");
        model.addAttribute("relatedCompyCode",relatedCompyCode);
        model.addAttribute("relatedPsnName",relatedPsnName);
        model.addAttribute("relatedPsnPosition",relatedPsnPosition);
        model.addAttribute("relatedPsnTel1",relatedPsnTel1);
        model.addAttribute("relatedPsnTel2",relatedPsnTel2);
        model.addAttribute("relatedPsnTel3",relatedPsnTel3);
        model.addAttribute("psnFlag",psnFlag);
        model.addAttribute("flag",flag);
        model.addAttribute("id",id);
        return "modules/relateCompany/psn";
    }

    @RequestMapping(value = {"addBankView"})
    public String addBankView(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        String bankFlag = request.getParameter("bankFlag");
        String flag = request.getParameter("flag");
        String id = request.getParameter("id");
        String relatedCompyCode = request.getParameter("relateCompyCode");
        String relatedAccountName = request.getParameter("relatedAccountName");
        String relatedAccountNo = request.getParameter("relatedAccountNo");
        String relatedAccountBank = request.getParameter("relatedAccountBank");
        String realId = request.getParameter("realId");
        model.addAttribute("relatedCompyCode",relatedCompyCode);
        model.addAttribute("relatedAccountName",relatedAccountName);
        model.addAttribute("relatedAccountNo",relatedAccountNo);
        model.addAttribute("relatedAccountBank",relatedAccountBank);
        model.addAttribute("bankFlag",bankFlag);
        model.addAttribute("flag",flag);
        model.addAttribute("id",id);
        model.addAttribute("realId",realId);
        return "modules/relateCompany/bank";
    }

    //编辑增加或修改联系人
    @RequestMapping(value = {"addOrUpdatePsn"})
    @ResponseBody
    public String addOrUpdatePsn(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String relatedCompyCode = request.getParameter("relatedCompyCode");
        String relatedPsnName = request.getParameter("relatedPsnName");
        String relatedPsnPosition = request.getParameter("relatedPsnPosition");
        String relatedPsnTel1 = request.getParameter("relatedPsnTel1");
        String relatedPsnTel2 = request.getParameter("relatedPsnTel2");
        String relatedPsnTel3 = request.getParameter("relatedPsnTel3");
        String flag = request.getParameter("flag");
        String beforeRelatedPsnName = request.getParameter("beforeRelatedPsnName");
        long userId = UserUtils.getUser().getId();//获取当前用户ID
        PsnModel psnModel = new PsnModel();
        psnModel.setRelatedCompyCode(relatedCompyCode);
        psnModel.setRelatedPsnName(relatedPsnName);
        psnModel.setRelatedPsnPosition(relatedPsnPosition);
        psnModel.setRelatedPsnTel1(relatedPsnTel1);
        psnModel.setRelatedPsnTel2(relatedPsnTel2);
        psnModel.setRelatedPsnTel3(relatedPsnTel3);
        psnModel.setBeforeRelatedPsnName(beforeRelatedPsnName);

        List<String> telList = new ArrayList<>();
        if(!StringUtils.isBlank(psnModel.getRelatedPsnTel1())){
            telList.add(psnModel.getRelatedPsnTel1());
        }
        if(!StringUtils.isBlank(psnModel.getRelatedPsnTel2())){
            telList.add(psnModel.getRelatedPsnTel2());
        }
        if(!StringUtils.isBlank(psnModel.getRelatedPsnTel3())){
            telList.add(psnModel.getRelatedPsnTel3());
        }
        if(telList.size()>0){
            relateCompanyService.telCheck(telList);
        }
        try {
            if (StringUtils.equals(flag,"addFlag")){
                if(!StringUtils.isBlank(relateCompanyService.checkPsn(psnModel))){
                    result.setErrorMsg("联系人已存在！");
                }else if(relateCompanyService.checkPsnPhone(psnModel)!=0){
                    result.setErrorMsg("联系方式已存在！");
                }else {
                    psnModel.setCreatePsn(StringUtils.toString(userId));
                    relateCompanyService.addPsn(psnModel);
                    result.setDataModel(relatedCompyCode);
                }
            }else {
                psnModel.setUpdatePsn(StringUtils.toString(userId));
                if(StringUtils.equals(relatedPsnName,beforeRelatedPsnName)){
                    if(relateCompanyService.checkPsnPhone(psnModel)!=0){
                        result.setErrorMsg("联系方式已存在！");
                    }else{
                        relateCompanyService.updatePsn(psnModel);
                    }
                }else {
                    if(!StringUtils.isBlank(relateCompanyService.checkPsn(psnModel))){
                        result.setErrorMsg("联系人已存在！");
                    }else if(relateCompanyService.checkPsnPhone(psnModel)!=0){
                        result.setErrorMsg("联系方式已存在！");
                    }else {
                        relateCompanyService.updatePsn(psnModel);
                    }
                }
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("保存失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    //编辑增加或修改银行账号
    @RequestMapping(value = {"addOrUpdateBank"})
    @ResponseBody
    public String addOrUpdateBank(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String id = request.getParameter("id");
        String relatedCompyCode = request.getParameter("relatedCompyCode");
        String relatedAccountName = request.getParameter("relatedAccountName");
        String relatedAccountNo = request.getParameter("relatedAccountNo");
        String relatedAccountBank = request.getParameter("relatedAccountBank");
        String flag = request.getParameter("flag");
        String beforeRelatedAccountNo = request.getParameter("beforeRelatedAccountNo");
        String realId = request.getParameter("realId");
        long userId = UserUtils.getUser().getId();//获取当前用户ID
        BankModel bankModel = new BankModel();
        bankModel.setRelatedCompyCode(relatedCompyCode);
        bankModel.setRelatedAccountName(relatedAccountName);
        bankModel.setRelatedAccountNo(relatedAccountNo);
        bankModel.setRelatedAccountBank(relatedAccountBank);
        bankModel.setUserId(StringUtils.toString(userId));
        try {
            if (StringUtils.equals(flag,"addFlag")){
                if(StringUtils.isBlank(relateCompanyService.checkBank(bankModel))){
                    relateCompanyService.addBank(bankModel);
                    result.setDataModel(bankModel.getId());
                }else {
                    result.setErrorMsg("账号已存在！");
                }
            }else {
                if(StringUtils.isBlank(realId)){
                    bankModel.setId(StringUtils.toLong(id));
                }else {
                    bankModel.setId(StringUtils.toLong(realId));
                }
                if(StringUtils.equals(relatedAccountNo,beforeRelatedAccountNo)){
                    relateCompanyService.updateBank(bankModel);
                }else {
                    if(StringUtils.isBlank(relateCompanyService.checkBank(bankModel))){
                        relateCompanyService.updateBank(bankModel);
                    }else {
                        result.setErrorMsg("账号已存在！");
                    }
                }

            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("保存失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    //编辑删联系人
    @RequestMapping(value = {"deletePsn"})
    @ResponseBody
    public String deletePsn(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel<MstRelatedCompy> result = new ResultModel<>();
        String objs = request.getParameter("objs");
        try {
            List<PsnModel> list = JsonUtils.getCollection(objs,PsnModel.class);
            for(PsnModel psnModel: list){
                relateCompanyService.deletePsn(psnModel);
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("删除失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    //编辑删除银行账号
    @RequestMapping(value = {"deleteBank"})
    @ResponseBody
    public String deleteBank(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel<MstRelatedCompy> result = new ResultModel<>();
        String ids = request.getParameter("ids");
        try {
            List<String> list = JsonUtils.getCollection(ids,String.class);
            for(String id: list){
                BankModel bankModel = new BankModel();
                bankModel.setId(StringUtils.toLong(id));
                relateCompanyService.deleteBank(bankModel);
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("删除失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    //判断简称是否有重
    @RequestMapping(value = {"repeatJudgeSname"})
    @ResponseBody
    public String repeatJudgeSname(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel<MstRelatedCompy> result = new ResultModel<>();
        String compySname = request.getParameter("compySname");
        String relatedCompyCode = request.getParameter("relatedCompyCode");
        try {
            RelateCompanyModel relateCompanyModel = relateCompanyService.checkSname(compySname,relatedCompyCode);
            if (!StringUtils.isBlank(relateCompanyModel)){
                if(StringUtils.equals(relateCompanyModel.getActiveFlag(),"Y")){
                    result.setResultType(99);
                    result.setResultMsg("系统中存在相同的简称，请确认是否可以继续使用原有数据。如果真的需要新增相同的简称，请在简称上用括号备注。例如：张三(同行)");
                }else {
                    result.setResultType(99);
                    result.setResultMsg("系统中存在相同的简称，但是已经处于失效状态。请确认是否需要更改原有数据。如果真的需要新增相同的简称，请在简称上用括号备注。例如：张三(同行)");
                }
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    //判断司机助手账号是否有重
    @RequestMapping(value = {"repeatJudgeHelperCode"})
    @ResponseBody
    public String repeatJudgeHelperCode(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel<MstRelatedCompy> result = new ResultModel<>();
        String helperCode = request.getParameter("helperCode");
        try {
            Boolean flag = relateCompanyService.repeatJudgeToTuser(helperCode);
            if (flag == true){
                result.setResultType(99);
                result.setResultMsg("该账号已存在！");
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
    }

    //保存
    @RequestMapping(value = {"save"})
    @ResponseBody
    public String save(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel<RelateCompanyModel> result = new ResultModel<>();
        RelateCompanyModel relatedCompy = JsonUtils.getBean(request,RelateCompanyModel.class);
        long userId = UserUtils.getUser().getId();//获取当前用户ID
        String object = null;
        String PsnObj = null;
        String bankObj = request.getParameter("bankObj");
        List<BankModel> bankModels = JsonUtils.getCollection(bankObj,BankModel.class);
        try {
            //往来单位编码不为空做编辑；
            if(StringUtils.isNotBlank(relatedCompy.getRelatedCompyCode())){
                relatedCompy.setUpdatePsn(StringUtils.toString(userId));
                relateCompanyService.updataRelatedCompy(relatedCompy);
            }else {
                //做新增
                //系统自动生成relatedCompyCode编码
                relatedCompy.setCreatePsn(StringUtils.toString(userId));
                String  number = NumberingService.NUMBER_CODE.MST_RELATED_COMPY_CODE;
                String numberCode =  numberingService.getNumber(number,"");
                relatedCompy.setRelatedCompyCode(numberCode);
                if(bankModels.size()>0){
                    for(BankModel bankModel: bankModels){
                        bankModel.setRelatedCompyCode(numberCode);
                        bankModel.setUserId(StringUtils.toString(userId));
                        relateCompanyService.addBank(bankModel);
                    }
                }
                PsnObj = request.getParameter("psnObj");
                relateCompanyService.addRelatedCompy(relatedCompy,object,PsnObj);
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            result.setErrorMsg("保存失败"+e.getMessage());
        }
        result.setDataModel(relatedCompy);
        return JsonUtils.toString(result);
    }

    //增加联系人时校验电话
    @RequestMapping(value = {"checkPsnPhone"})
    @ResponseBody
    public String checkPsnPhone(HttpServletRequest request, HttpServletResponse response, Model model) throws ValidationException {
        ResultModel result = new ResultModel<>();
        String relatedPsnTel1 = request.getParameter("relatedPsnTel1");
        String relatedPsnTel2 = request.getParameter("relatedPsnTel2");
        String relatedPsnTel3 = request.getParameter("relatedPsnTel3");
        PsnModel psnModel = new PsnModel();
        psnModel.setRelatedPsnTel1(relatedPsnTel1);
        psnModel.setRelatedPsnTel2(relatedPsnTel2);
        psnModel.setRelatedPsnTel3(relatedPsnTel3);
        List<String> telList = new ArrayList<>();
        if(!StringUtils.isBlank(psnModel.getRelatedPsnTel1())){
            telList.add(psnModel.getRelatedPsnTel1());
        }
        if(!StringUtils.isBlank(psnModel.getRelatedPsnTel2())){
            telList.add(psnModel.getRelatedPsnTel2());
        }
        if(!StringUtils.isBlank(psnModel.getRelatedPsnTel3())){
            telList.add(psnModel.getRelatedPsnTel3());
        }
        if(telList.size()>0){
            relateCompanyService.telCheck(telList);
        }
        try {
            if(relateCompanyService.checkPsnPhone(psnModel)!=0){
                result.setErrorMsg("联系方式已存在！");
                result.setResultType(GlobalConstants.RESULT_ERROR);
            }
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("保存失败"+e.getMessage());
        }
        return JsonUtils.toString(result);
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
    @RequestMapping(value = "exportRelateCompy",method = RequestMethod.POST)
    @ResponseBody
    public String exportRelateCompy(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        Map<String, Object> dateMap = new HashMap<String, Object>();
        String tempPath = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/templates/";
        RelateCompanyModel relateCompanyModel= JsonUtils.getBean(request, RelateCompanyModel.class);
        String objs = relateCompanyModel.getObjs();
        List<String> relateCodeList = JsonUtils.getCollection(objs,String.class);
        List<RelateCompanyModel> list = relateCompanyService.getRelateCompy(relateCodeList);
        dateMap.put("relateCompyList", list);
        dateMap.put("ExpandedRowCount", list.size() + 2);
        File tempFile = FileUtils.getFile(tempPath, UUID.randomUUID().toString() + ".xls");
        File outFile = FreeMarkers.exportForTemplate(tempPath, "relateCompy.ftl", dateMap, tempFile);
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("往来单位.xls", "utf-8"));
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
