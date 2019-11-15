package com.xzg56.jg.modules.mst.bankAccount.web;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.persistence.JQResultModel;
import com.xzg56.core.persistence.ResultModel;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.core.web.BaseController;
import com.xzg56.jg.modules.mst.bankAccount.model.BankAccountModel;
import com.xzg56.jg.modules.mst.bankAccount.service.BankAccountService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "${adminPath}/bankAccount")
public class BankAccountController extends BaseController {

    @Resource(name = "BankAccountService")
    private BankAccountService bankAccountService;

    @RequestMapping(value = {"init", ""})
    public String init(Model model) {
        model.addAttribute("gridModel", getGridConfig("bankAccount"));
        return "modules/bankAccount/bankAccountList";
    }

    /**
     *
     * @param request
     * @return
     * @throws ValidationException
     */
    @RequestMapping(value = {"search"})
    @ResponseBody
    public String getBankAccountList(HttpServletRequest request) throws ValidationException {
        ResultModel<BankAccountModel> result = new ResultModel<>();
        BankAccountModel bankAccountModel = JsonUtils.getBean(request, BankAccountModel.class);
        List<BankAccountModel> list = new ArrayList<>();
        try {
            list = bankAccountService.findBankAccountList();
        }catch (ValidationException ve){
            result.setErrorMsg(ve.getMessage());
        }catch (Exception e){
            result.setErrorMsg("查询失败"+e.getMessage());
        }
        JQResultModel resultModel = new JQResultModel(list,bankAccountModel.getPage());
        return JsonUtils.toString(resultModel);
    }
}
