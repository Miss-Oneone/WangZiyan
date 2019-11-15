package com.xzg56.jg.modules.mst.relateCompany.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.jg.modules.mst.relateCompany.model.BankModel;
import com.xzg56.jg.modules.mst.relateCompany.model.PsnModel;
import com.xzg56.jg.modules.mst.relateCompany.model.RelateCompanyModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface RelateCompanyDao {
    String repeatJudgeToTuser(@Param("userCode") String userCode);
    //查询往来单位列表
    List<RelateCompanyModel> selectRelatedCompany(RelateCompanyModel model);
    String selectRelatedCompyType(@Param("relatedCompyCode") String relatedCompyCode);
    //通过往来单位编码查找往来单位
    RelateCompanyModel findRelatedCompanyByCode(@Param("relatedCompyCode") String relatedCompanyCode, @Param("RELATED_COMPY_TYPE") String relatedCompyType);
    String checkPsn(PsnModel psnModel);//判断联系人是否重复
    Integer checkPsnPhone(PsnModel psnModel);//判断联系方式是否重复
    RelateCompanyModel checkSname(@Param("compySname") String compySname, @Param("relatedCompyCode") String relatedCompyCode);//判断简称是否重复
    void addPsn(PsnModel psnModel);//新增联系人
    void updatePsns(PsnModel psnModel);//修改联系人
    void deletePsn(PsnModel psnModel);//删除联系人
    int addBank(BankModel model);//新增银行账号
    int updateBank(BankModel model);//修改银行账号
    void deleteBank(BankModel model);//删除银行账号
    String checkBank(BankModel model);//判断银行账号是否重复
    List<PsnModel> selectRelatedCompyPsn(@Param("relatedCompyCode") String relatedCompyCode);//获取联系人信息
    List<BankModel> selectBankData(@Param("relatedCompyCode") String relatedCompyCode);//获取银行信息
    void updateMstRelatedCompy(RelateCompanyModel model);//修改往来单位
    void addMstRelateCompy(RelateCompanyModel model);//新增往来单位
    List<RelateCompanyModel> getRelateCompy(@Param("relateCodes") List<String> relateCodes);//查询选中的往来单位
    void addMstDriver(RelateCompanyModel model);//自由司机
    void addMstAttachDriver(RelateCompanyModel model);//挂靠司机
    void updateMstDrive(RelateCompanyModel model);//修改自由司机
    void updateMstAttachDriver(RelateCompanyModel model);//挂靠司机
    void updateTUser(RelateCompanyModel model);//司机
}
