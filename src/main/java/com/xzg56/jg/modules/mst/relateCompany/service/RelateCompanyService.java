package com.xzg56.jg.modules.mst.relateCompany.service;

import com.xzg56.common.module.sys.persistence.dao.RoleUserDao;
import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.module.sys.persistence.entity.RoleUser;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.persistence.sys.dao.UserDao;
import com.xzg56.core.persistence.sys.entity.User;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.service.sys.SystemService;
import com.xzg56.core.utils.JsonUtils;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.common.utils.ValidationUtil;
import com.xzg56.jg.modules.mst.relateCompany.dao.RelateCompanyDao;
import com.xzg56.jg.modules.mst.relateCompany.model.BankModel;
import com.xzg56.jg.modules.mst.relateCompany.model.PsnModel;
import com.xzg56.jg.modules.mst.relateCompany.model.RelateCompanyModel;
import com.xzg56.utility.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service("RelateCompanyService")
@Transactional(readOnly = true)
public class RelateCompanyService extends BaseService {

    @Resource
    private RelateCompanyDao relateCompanyDao;

    public List<RelateCompanyModel> findRelateCompany(RelateCompanyModel model) {
        List<RelateCompanyModel> list = relateCompanyDao.selectRelatedCompany(model);
        List<Dict> validFlags = DictUtils.getDictList("VALID_FLAG");//是否有效标志
        List<Dict> relatedCompyTypes = DictUtils.getDictList("RELATED_COMPY_TYPE");//往来单位类型
        for (RelateCompanyModel relateCompanyModel: list) {
            for (Dict dict: validFlags) {
                if (StringUtils.equals(dict.getValue(),relateCompanyModel.getActiveFlag())) {
                    relateCompanyModel.setActiveFlag(dict.getLabel());
                    break;
                }
            }
            for (Dict dict: relatedCompyTypes) {
                if (StringUtils.equals(dict.getValue(),relateCompanyModel.getRelatedCompyType())) {
                    relateCompanyModel.setRelatedCompyType(dict.getLabel());
                    break;
                }
            }
        }
        return list;
    }

    public RelateCompanyModel selectCompany(String relatedCompyCode){
        String relateCompyType = relateCompanyDao.selectRelatedCompyType(relatedCompyCode);
        RelateCompanyModel model = relateCompanyDao.findRelatedCompanyByCode(relatedCompyCode,relateCompyType);
        return model;
    }

    //获取联系人信息
    @Transactional(readOnly = false)
    public List<PsnModel> selectPsnDate(String relatedComprCode){
        return relateCompanyDao.selectRelatedCompyPsn(relatedComprCode);
    }
    //获取银行信息
    @Transactional(readOnly = false)
    public List<BankModel> selectBankData(String relatedCode){
        return relateCompanyDao.selectBankData(relatedCode);
    }

    //手机号码验证
    @Transactional(readOnly = false)
    public void telCheck(List<String> telList) {
        ValidationUtil.phoneJudge(telList);
    }

    //判断联系人是否重复
    @Transactional(readOnly = false)
    public String checkPsn(PsnModel psnModel){
        return relateCompanyDao.checkPsn(psnModel);
    }

    //判断联系方式是否重复
    @Transactional(readOnly = false)
    public Integer checkPsnPhone(PsnModel psnModel){
        return relateCompanyDao.checkPsnPhone(psnModel);
    }

    //判断简称是否重复
    @Transactional(readOnly = false)
    public RelateCompanyModel checkSname(String compySname,String relatedCompyCode){
        return relateCompanyDao.checkSname(compySname,relatedCompyCode);
    }

    @Transactional(readOnly = false)
    public Boolean repeatJudgeToTuser(String userCode){
        String code = relateCompanyDao.repeatJudgeToTuser(userCode);
        Boolean flag = false;
        if (StringUtils.isNotBlank(code)){
            flag = true;
        }
        return flag;
    }

    //判断银行账号是否重复
    @Transactional(readOnly = false)
    public String checkBank(BankModel model){
        return relateCompanyDao.checkBank(model);
    }

    //新增联系人
    @Transactional(readOnly = false)
    public void addPsn(PsnModel psnModel){
        relateCompanyDao.addPsn(psnModel);
    }

    //修改联系人
    @Transactional(readOnly = false)
    public void updatePsn(PsnModel psnModel){
        relateCompanyDao.updatePsns(psnModel);//修改联系人

    }

    //删除联系人
    @Transactional(readOnly = false)
    public void deletePsn(PsnModel psnModel){
        relateCompanyDao.deletePsn(psnModel);
    }

    //新增价格银行账号
    @Transactional(readOnly = false)
    public int addBank(BankModel bankModels){
        return relateCompanyDao.addBank(bankModels);
    }

    //修改银行账号
    @Transactional(readOnly = false)
    public void updateBank(BankModel bankModel){
        relateCompanyDao.updateBank(bankModel);//修改银行账号

    }

    //删除银行账号
    @Transactional(readOnly = false)
    public void deleteBank(BankModel bankModels){
        relateCompanyDao.deleteBank(bankModels);
    }

    //修改
    @Transactional(readOnly = false)
    public void updataRelatedCompy(RelateCompanyModel companyModel){
        if(StringUtils.equals(companyModel.getCertificateFlag(),"null")|| StringUtils.isBlank(companyModel.getCertificateFlag())){
            companyModel.setCertificateFlag(null);
        }
        if(StringUtils.equals(companyModel.getDangerousFlag(),"null")|| StringUtils.isBlank(companyModel.getDangerousFlag())){
            companyModel.setDangerousFlag(null);
        }
        if(StringUtils.isBlank(companyModel.getStorageOil())){
            companyModel.setStorageOil(null);
        }
        relateCompanyDao.updateMstRelatedCompy(companyModel);
        List<String> telList = new ArrayList<>();
        if(!StringUtils.isBlank(companyModel.getPhone1())){
            telList.add(companyModel.getPhone1());
        }
        if (!StringUtils.isBlank(companyModel.getPhone2())) {
            telList.add(companyModel.getPhone2());
        }
        if (StringUtils.equals(companyModel.getRelatedCompyType(), Constants.RELATED_COMPY_TYPE.DR) ||
                StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.ADR) ||
                StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.PDR)){
            if(telList.size()> 0){
                ValidationUtil.phoneJudge(telList);
            }

            // 司机类型
            transfDriverType(companyModel);
            companyModel.setUserCode(companyModel.getHelperCode());
            relateCompanyDao.updateTUser(companyModel);
            relateCompanyDao.updateMstDrive(companyModel);
        }
    }

    //新增
    @Transactional(readOnly = false)
    public void addRelatedCompy(RelateCompanyModel companyModel, String object, String PsnObj){
        User user = new User();
        user.setLanguage(Constants.DEFAULT_LANGUAGE);
        List<PsnModel> psnModels = JsonUtils.getCollection(PsnObj,PsnModel.class);

        RoleUser roleUser = new RoleUser();
        List<String> telList = new ArrayList<>();
        if(!StringUtils.isBlank(companyModel.getPhone1())){
            telList.add(companyModel.getPhone1());
        }
        if(!StringUtils.isBlank(companyModel.getPhone2())){
            telList.add(companyModel.getPhone2());
        }
        if (StringUtils.equals(companyModel.getRelatedCompyType(), Constants.RELATED_COMPY_TYPE.DR) ||
                StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.ADR) ||
                StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.PDR)){
            if(telList.size()> 0){
                ValidationUtil.phoneJudge(telList);
            }
            user.setPassword(SystemService.entryptPassword(Constants.JG_DEFAULT_PASSWORD));
            user.setUserCode(companyModel.getHelperCode());
            user.setName(companyModel.getCompySname());
            user.setEmail(companyModel.getEmail());
            user.setUserType(Constants.USER_TYPE.DRIVER);
            roleUser.setRoleId(new Long((long)76));
            List<RoleUser> list = new ArrayList<>();
            list.add(roleUser);
            //userDao.insert(user);

            // 司机类型
            transfDriverType(companyModel);
            companyModel.setUserCode(StringUtils.toString(user.getId()));
            relateCompanyDao.addMstRelateCompy(companyModel);
            roleUser.setUserId(user.getId());
            //roleUserDao.insertRoleUserList(list);
            relateCompanyDao.addMstDriver(companyModel);
        } else {
            relateCompanyDao.addMstRelateCompy(companyModel);
            if(psnModels.size()>0){
                for (PsnModel psnModel: psnModels){
                    psnModel.setRelatedCompyCode(companyModel.getRelatedCompyCode());
                    psnModel.setCreatePsn(companyModel.getCreatePsn());
                    relateCompanyDao.addPsn(psnModel);
                }
            }
            // 如果是同行，是需要添加同行司机信息
            if (StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.P)) {
                transfDriverType(companyModel);
                relateCompanyDao.addMstDriver(companyModel);
            }
        }
    }

    public List<RelateCompanyModel> getRelateCompy(List<String> relateCode){
        List<RelateCompanyModel> list = relateCompanyDao.getRelateCompy(relateCode);

        List<Dict> validFlags = DictUtils.getDictList("VALID_FLAG");//是否有效标志
        List<Dict> relatedCompyTypes = DictUtils.getDictList("RELATED_COMPY_TYPE");//往来单位类型
        for (RelateCompanyModel compy: list){
            for (Dict validFlag: validFlags){
                if(StringUtils.equals(compy.getActiveFlag(),validFlag.getValue())){
                    compy.setActiveFlag(validFlag.getLabel());
                }
            }
            for (Dict relatedCompyType: relatedCompyTypes){
                if (StringUtils.equals(compy.getRelatedCompyType(),relatedCompyType.getValue())){
                    compy.setRelatedCompyType(relatedCompyType.getLabel());
                }
            }
        }
        return list;
    }

    private void transfDriverType (RelateCompanyModel companyModel) {
        if (StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.DR)) {
            companyModel.setDriverType(Constants.DRIVER_TYPE.OWN);
        } else if (StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.ADR)) {
            companyModel.setDriverType(Constants.DRIVER_TYPE.ATTACH);
        } else if (StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.PDR) ||
                StringUtils.equals(companyModel.getRelatedCompyType(),Constants.RELATED_COMPY_TYPE.P)) {
            companyModel.setDriverType(Constants.DRIVER_TYPE.OUT);
        }
    }
}
