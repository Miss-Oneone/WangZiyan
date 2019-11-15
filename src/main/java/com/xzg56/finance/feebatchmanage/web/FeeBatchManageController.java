package com.xzg56.finance.feebatchmanage.web;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageModel;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageSearchModel;
import com.xzg56.finance.feebatchmanage.model.FeeBatchManageUpdateModel;
import com.xzg56.finance.feebatchmanage.service.FeeBatchManageService;
import com.xzg56.jg.modules.finance.expense.model.BatchAddPiModel;
import com.xzg56.utility.DateUtils;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by wjn on 2019/1/3.
 */
@RequestMapping(value = {"${adminPath}/feeBatchManage"})
@Controller
public class FeeBatchManageController extends BaseController {

    @Autowired
    private FeeBatchManageService feeBatchManageService;

    @RequestMapping(value = {"init", ""})
    public String init(HttpServletRequest request, Model model) {
        model.addAttribute("gridModel", getGridConfig("feeBatchManage"));
        model.addAttribute("drvordTimeFrom", DateUtils.getDate());
        model.addAttribute("drvordTimeTo", DateUtils.getDate());
        return "finance/feebatchmanage/feeBatchManage";
    }

    @RequestMapping(value = {"search"})
    @ResponseBody
    public String search(HttpServletRequest request, HttpServletResponse response, Model model) {
        FeeBatchManageSearchModel feeBatchManageSearchModel = (FeeBatchManageSearchModel) JsonUtils.getBean(request, FeeBatchManageSearchModel.class);

        List<FeeBatchManageModel> list = feeBatchManageService.findFeeBatchManageList(feeBatchManageSearchModel);
        JQResultModel resultModel = new JQResultModel(list, feeBatchManageSearchModel.getPage());
        return JSONObject.fromObject(resultModel).toString();
    }

    /**
     * 反审核界面初始化
     *
     * @return
     */
    @RequestMapping(value = "binsUnApproval")
    public String binsUnApproval() {
        return "finance/feebatchmanage/binsUnApproval";
    }

    /**
     * 批量新增界面初始化
     *
     * @return
     */
    @RequestMapping(value = "feeBatchManageAdd")
    public String feeBatchManageAdd(Model model) {
        model.addAttribute("nowDate", DateUtils.getDate());
        return "finance/feebatchmanage/feeBatchManageAdd";
    }

    /**
     * 批量新增校验界面初始化
     *
     * @return
     */
    @RequestMapping(value = "feeBatchManageCheckSave")
    public String feeBatchManageCheckSave(Model model) {
        model.addAttribute("gridModel", getGridConfig("batchAddPiCheck"));
        return "finance/feebatchmanage/feeBatchManageCheckSave";
    }

    /**
     * 批量新增界面初始化
     *
     * @return
     */
    @RequestMapping(value = "feeBatchManageUpdate")
    public String feeBatchManageUpdate() {
        return "finance/feebatchmanage/feeBatchManageUpdate";
    }

    @RequestMapping(value = { "check" })
    @ResponseBody
    public String ajaxCheck(HttpServletRequest request) {
        BatchAddPiModel batchAddPiModel = (BatchAddPiModel) JsonUtils.getBean(request,BatchAddPiModel.class);
        batchAddPiModel.getPage().setPageSize(1000);
        batchAddPiModel.setPiName(request.getParameter("pName"));
        List<BatchAddPiModel> searchList = feeBatchManageService.check(batchAddPiModel);
        JQResultModel resultModel = new JQResultModel(searchList, batchAddPiModel.getPage());
        return JSONObject.fromObject(resultModel).toString();
    }

    @RequestMapping(value = { "feeBatchSave" })
    public String piInsert(HttpServletRequest request) {
        BatchAddPiModel batchAddPiModel = (BatchAddPiModel) JsonUtils.getBean(request, BatchAddPiModel.class);
        feeBatchManageService.feeBatchSave(batchAddPiModel);
        return null;
    }

    @RequestMapping(value = {"feeBatchManageSaveUpdate"}, method = RequestMethod.POST)
    @ResponseBody
    public String feeBatchManageSaveUpdate(HttpServletRequest request, HttpServletResponse response) {
        ResultModel result = new ResultModel();
        try {
            FeeBatchManageUpdateModel feeBatchManageUpdateModel = (FeeBatchManageUpdateModel) JsonUtils.getBean(request, FeeBatchManageUpdateModel.class);

            feeBatchManageService.feeBatchManageSaveUpdate(feeBatchManageUpdateModel);

        } catch (ValidationException ve) {
            result.setErrorMsg(ve.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMsg("提交失败:\n" + e.getMessage());
        }
        return JSONObject.fromObject(result).toString();
    }

    //费用批量修改密码验证
    @RequestMapping(value = {"checkPassword"})
    @ResponseBody
    public String checkPassword(HttpServletRequest request,
                                PrintWriter printWriter, HttpServletResponse response) {
        String password = request.getParameter("password");

        boolean resultCheck = feeBatchManageService.checkPassword(password);
        if (resultCheck)
            return "success";
        return "fail";

    }
}
