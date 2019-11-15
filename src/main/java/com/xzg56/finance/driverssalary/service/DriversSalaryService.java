package com.xzg56.finance.driverssalary.service;


import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.service.BaseService;
import com.xzg56.finance.common.persistence.dao.OrdSalaryAdditionalDao;
import com.xzg56.finance.common.persistence.entity.OrdSalaryAdditional;
import com.xzg56.finance.driverssalary.dao.DriversSalaryDao;
import com.xzg56.finance.driverssalary.model.DriversSalaryDetailModel;
import com.xzg56.finance.driverssalary.model.DriversSalaryModel;
import com.xzg56.finance.driverssalary.model.DriversSalarySearchModel;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.NumberUtils;
import com.xzg56.utility.StringUtils;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by wellen on 2019/5/28.
 */

@Service
@Transactional(readOnly = true)
public class DriversSalaryService extends BaseService {

    @Resource
    private DriversSalaryDao driversSalaryDao;

    @Resource
    private OrdSalaryAdditionalDao ordSalaryAdditionalDao;

    public List<DriversSalaryModel> search(DriversSalarySearchModel salarySearchModel) {
        List<DriversSalaryModel> driversSalaryModels = driversSalaryDao.listDriversSalarys(salarySearchModel);
        List<Dict> trailerBelongTypes = DictUtils.getDictList("TRAILER_BELONG_TYPE");
        List<Dict> quitFlags = DictUtils.getDictList("QUIT_FLAG");
        List<Dict> transportTypes = DictUtils.getDictList("TRANSPORT_TYPE");
        // 查询附加项
        List<String> drivers = new ArrayList<>();
        for (DriversSalaryModel salaryModel : driversSalaryModels) {
            drivers.add(salaryModel.getDriverCode());
            // 字典值处理
            for (Dict trailerBelongType : trailerBelongTypes) {
                if (StringUtils.equals(salaryModel.getDriverType(), trailerBelongType.getValue())) {
                    salaryModel.setDriverType(trailerBelongType.getLabel());
                    break;
                }
            }
            for (Dict quitFlag : quitFlags) {
                if (StringUtils.equals(salaryModel.getQuitFlag(), quitFlag.getValue())) {
                    salaryModel.setQuitFlag(quitFlag.getLabel());
                    break;
                }
            }
            for (Dict transportType : transportTypes) {
                if (StringUtils.equals(salaryModel.getTransportTypeCd(), transportType.getValue())) {
                    salaryModel.setTransportType(transportType.getLabel());
                    break;
                }
            }
        }
        List<DriversSalaryModel> salaryAddtionals = new ArrayList<>();
        if (drivers.size() > 0) {
            Map<String, Object> params = new HashedMap();
            params.put("drivers", drivers);
            params.put("salaryMonth", salarySearchModel.getSalaryMonth());
            salaryAddtionals = driversSalaryDao.listSalaryAdditionals(params);
        }

        for (DriversSalaryModel salaryModel : driversSalaryModels) {
            // 计算油补，短途没有油补（(标准油升 + 补油数 - 实际加油) * 4）
            if (StringUtils.equals(salaryModel.getTransportTypeCd(), Constants.TRANSPORT_TYPE.LONG)) {
                BigDecimal oilSubsidyTem = new BigDecimal(salaryModel.getStdOilQty()).add(new BigDecimal(salaryModel.getOilMass()).
                        subtract(new BigDecimal(salaryModel.getActualOil())));
                salaryModel.setOilSubsidy(oilSubsidyTem.multiply(new BigDecimal(4)).toString());
            } else {
                salaryModel.setOilSubsidy("0.00");
            }
            // 附加项
            BigDecimal salaryAddtionalAmounts = BigDecimal.ZERO;
            for (DriversSalaryModel salaryAddtional : salaryAddtionals) {
                if (StringUtils.equals(salaryAddtional.getDriverCode(), salaryModel.getDriverCode())) {
                    salaryModel.setDeductSsAmount(StringUtils.isNotBlank(salaryAddtional.getDeductSsAmount()) ? salaryAddtional.getDeductSsAmount() : "0.00");
                    salaryModel.setDeductTaxAmount(StringUtils.isNotBlank(salaryAddtional.getDeductTaxAmount()) ? salaryAddtional.getDeductTaxAmount() : "0.00");
                    salaryModel.setDeductLoanAmount(StringUtils.isNotBlank(salaryAddtional.getDeductLoanAmount()) ? salaryAddtional.getDeductLoanAmount() : "0.00");
                    salaryModel.setDeductOtherAmount(StringUtils.isNotBlank(salaryAddtional.getDeductOtherAmount()) ? salaryAddtional.getDeductOtherAmount() : "0.00");
                    salaryModel.setBaseSubsidy(StringUtils.isNotBlank(salaryAddtional.getBaseSubsidy()) ? salaryAddtional.getBaseSubsidy() : "0.00");
                    salaryAddtionalAmounts = new BigDecimal(salaryModel.getDeductSsAmount()).add(new BigDecimal(salaryModel.getDeductTaxAmount())).
                            add(new BigDecimal(salaryModel.getDeductLoanAmount())).add(new BigDecimal(salaryModel.getDeductOtherAmount()));
                    break;
                }
            }
            // 工资合计（基本工资 + 油补 + 其他补贴 + 基础补贴 + 小活补贴）
            salaryModel.setTotalSalary(new BigDecimal(salaryModel.getBaseSalary()).add(new BigDecimal(salaryModel.getOilSubsidy()).
                    add(new BigDecimal(salaryModel.getOtherSubsidy()))).add(new BigDecimal(salaryModel.getBaseSubsidy())).add(new BigDecimal(salaryModel.getExtraWorkSubsidy())).toString());

            // 应发工资
            salaryModel.setFinalSalary(new BigDecimal(salaryModel.getTotalSalary()).subtract(salaryAddtionalAmounts).toString());

        }

        return driversSalaryModels;
    }

    public DriversSalaryModel findDriverAddtionInfo(DriversSalarySearchModel driversSalaryModel) {
        return driversSalaryDao.findDriverAddtionInfo(driversSalaryModel);
    }

    /**
     * 录入或修改附加项
     * @param ordSalaryAdditional
     */
    @Transactional(readOnly = false)
    public void saveOrUpdateDriverSalaryAmount(OrdSalaryAdditional ordSalaryAdditional) {
        OrdSalaryAdditional ordSalaryAdditionalEntity = ordSalaryAdditionalDao.get(ordSalaryAdditional.getSalaryMonth()
                , ordSalaryAdditional.getDriverCode());
        if (StringUtils.isBlank(ordSalaryAdditionalEntity)) {
            ordSalaryAdditionalDao.insert(ordSalaryAdditional);
        } else {
            ordSalaryAdditional.setId(ordSalaryAdditionalEntity.getId());
            ordSalaryAdditionalDao.update(ordSalaryAdditional);
        }
    }

    /**
     * 批量录入或修改附加项（目前只有扣-社保）
     * @param ordSalaryAdditionalList
     */
    @Transactional(readOnly = false)
    public void saveOrUpdateDriverSalaryAmountBatch(List<OrdSalaryAdditional> ordSalaryAdditionalList) {
        OrdSalaryAdditional ordSalaryAdditionalEntity;
        for (OrdSalaryAdditional ordSalaryAdditional : ordSalaryAdditionalList) {
            ordSalaryAdditionalEntity = ordSalaryAdditionalDao.get(ordSalaryAdditional.getSalaryMonth()
                    , ordSalaryAdditional.getDriverCode());

            if (StringUtils.isBlank(ordSalaryAdditionalEntity)) {
                ordSalaryAdditionalDao.insert(ordSalaryAdditional);
            } else {
                ordSalaryAdditional.setId(ordSalaryAdditionalEntity.getId());
                ordSalaryAdditional.setLeaveDays(ordSalaryAdditionalEntity.getLeaveDays());
                ordSalaryAdditionalDao.update(ordSalaryAdditional);
            }
        }
    }

    /**
     * 查询每个司机明细
     * @param salarySearchModel
     * @return
     */
    @Transactional(readOnly = false)
    public List<DriversSalaryDetailModel> searchDetail(DriversSalarySearchModel salarySearchModel) {
        List<DriversSalaryDetailModel>  driversSalaryDetail = driversSalaryDao.searchDetail(salarySearchModel);
        List<DriversSalaryDetailModel>  driversSalaryDetailAll = new ArrayList<>();
        //找出当月总的天数
        String fromTime = salarySearchModel.getSalaryMonth() + "-" + "01";
        String toTime = DateUtils.getLastDayOfMonth(DateUtils.parseDate(fromTime, "yyyy-MM"));
        int num = DateUtils.getDifferenceOfDays(DateUtils.parseDate(fromTime, "yyyy-MM-dd"), DateUtils.parseDate(toTime, "yyyy-MM-dd"));
        //循环明细，相同日期下的校正公里数,标准油升和加油量只保留一天有数据，其他设置为0
        for(int i=1;i<driversSalaryDetail.size();i++){
            if(StringUtils.equals(driversSalaryDetail.get(i).getDrvordTime(),driversSalaryDetail.get(i-1).getDrvordTime())){
                //一天开两趟及以上的情况下，又有补公里数，第二趟开始计算标准油升不能把补公里数算计去
                if(!StringUtils.equals(driversSalaryDetail.get(i).getStdOilQty(),"0")){
                    driversSalaryDetail.get(i).setStdOilQty(new BigDecimal(driversSalaryDetail.get(i).getStdKmQty()).multiply(new BigDecimal(driversSalaryDetail.get(i).getLiters()).divide(new BigDecimal(100))).toString());
                }
                driversSalaryDetail.get(i).setAdjustKm("0");
                driversSalaryDetail.get(i).setActualOil("0");
            }
        }
        //查找所有加油和补公里的数据
        List<DriversSalaryDetailModel> oilAndKmList =  driversSalaryDao.searchOilAndKmList(salarySearchModel);

        //循环日期，把每天对应的日数据插入
        for(int i=0;i<num;i++){

            if (i>0) {
                fromTime = DateUtils.formatDate(DateUtils.getSpecifiedDayEndStr(DateUtils.parseDate(fromTime, "yyyy-MM-dd"), 1),"yyyy-MM-dd");
            }

            //把出车明细对应天数的数据插入
            for(int x=0;x<driversSalaryDetail.size();x++){
                if(StringUtils.equals(fromTime,driversSalaryDetail.get(x).getDrvordTime())){
                    driversSalaryDetailAll.add(driversSalaryDetail.get(x));
                }
            }

            //校验哪些天未出车但是有加油或者补公里数据的，加入明细数据中
            for(int p=0;p<oilAndKmList.size();p++){
                if(StringUtils.equals(fromTime,oilAndKmList.get(p).getDrvordTime())){
                    String addFlag = "Y";
                    for(int x=0;x<driversSalaryDetail.size();x++){
                        if(StringUtils.equals(fromTime,driversSalaryDetail.get(x).getDrvordTime()) && StringUtils.equals(oilAndKmList.get(p).getPlateNum(),driversSalaryDetail.get(x).getPlateNum())){
                            addFlag = "N";
                            break;
                        }
                    }
                    if(StringUtils.equals("Y",addFlag)){
                        driversSalaryDetailAll.add(oilAndKmList.get(p));
                    }
                }
            }

        }
        //合计一行
        DriversSalaryDetailModel totalLine = new DriversSalaryDetailModel();
        totalLine.setGoodsName("合计");
        Double totalStdKmQty = 0.00;//标准公里数合计
        Double totalAdjustKm = 0.00;//校正公里数合计
        Double totalStdOilQty = 0.00;//标准油升合计
        Double totalActualOil = 0.00;//实际加油合计
        Double totalBaseSalary = 0.00;//基本工资合计
        Double totalOtherSubsidy = 0.00;//其他补贴合计
        Double totalAmount = 0.00;//金额小计合计
        Double judgeOil = 0.00;//计算油补时使用，长途有油补，短途没有
        for(int i=0;i<driversSalaryDetailAll.size();i++){
            totalStdKmQty += Double.parseDouble(driversSalaryDetailAll.get(i).getStdKmQty());
            totalAdjustKm += Double.parseDouble(driversSalaryDetailAll.get(i).getAdjustKm());
            totalStdOilQty += Double.parseDouble(driversSalaryDetailAll.get(i).getStdOilQty());
            totalActualOil += Double.parseDouble(driversSalaryDetailAll.get(i).getActualOil());
            totalBaseSalary += Double.parseDouble(driversSalaryDetailAll.get(i).getBaseSalary());
            totalOtherSubsidy += Double.parseDouble(driversSalaryDetailAll.get(i).getOtherSubsidy());
            totalAmount += Double.parseDouble(driversSalaryDetailAll.get(i).getTotalAmount());
            if(StringUtils.equals(driversSalaryDetailAll.get(i).getTransportType(),Constants.TRANSPORT_TYPE.LONG)){
                judgeOil += Double.parseDouble(driversSalaryDetailAll.get(i).getStdOilQty());
            }
        }

        //明细显示需要
        if(driversSalaryDetail.size()!=0){
            totalLine.setDriverName(driversSalaryDetail.get(0).getDriverName());
            totalLine.setStdKmQty(totalStdKmQty.toString());
            totalLine.setAdjustKm(totalAdjustKm.toString());
            totalLine.setStdOilQty(totalStdOilQty.toString());
            totalLine.setActualOil(totalActualOil.toString());
            totalLine.setBaseSalary(totalBaseSalary.toString());
            totalLine.setOtherSubsidy(totalOtherSubsidy.toString());
            totalLine.setTotalAmount(totalAmount.toString());
            driversSalaryDetailAll.add(totalLine);
        }
        //统计栏
        if (driversSalaryDetailAll.size() > 0) {
            DecimalFormat df = new DecimalFormat("#####0.00");
            DriversSalaryModel driversSalaryAdditional = driversSalaryDao.searchDriversSalaryAdditional(salarySearchModel);
            if(StringUtils.isBlank(driversSalaryAdditional)){
                driversSalaryAdditional = new DriversSalaryModel();
                driversSalaryAdditional.setBaseSubsidy("0");
                driversSalaryAdditional.setDeductSsAmount("0");
                driversSalaryAdditional.setDeductTaxAmount("0");
                driversSalaryAdditional.setDeductLoanAmount("0");
                driversSalaryAdditional.setDeductOtherAmount("0");
            }
            DriversSalaryDetailModel line = new DriversSalaryDetailModel();
            DriversSalaryDetailModel line1 = new DriversSalaryDetailModel();
            line1.setDrvordTime("总里程");
            line1.setDriverName(df.format(totalStdKmQty+totalAdjustKm));
            line1.setPlateNum("标准油升");
            line1.setGoodsName(df.format(totalStdOilQty));
            DriversSalaryDetailModel line2 = new DriversSalaryDetailModel();
            line2.setDrvordTime("补油数");
            String oilMassAdjust = driversSalaryDao.searchOilMassAdjust(salarySearchModel);
            line2.setDriverName(df.format(Double.parseDouble(oilMassAdjust)));
            line2.setPlateNum("加油量");
            line2.setGoodsName(df.format(totalActualOil));
            DriversSalaryDetailModel line3 = new DriversSalaryDetailModel();
            line3.setDrvordTime("基本工资");
            line3.setDriverName(df.format(totalBaseSalary));
            line3.setPlateNum("油补");
            Double oilPatch = 0.00;
            if(judgeOil != 0.00){
               oilPatch = (totalStdOilQty+Double.parseDouble(oilMassAdjust)-totalActualOil)* NumberUtils.parseDouble(DictUtils.getDictList("OIL_PATCH").get(0).getValue());
            }
            line3.setGoodsName(df.format(oilPatch));
            DriversSalaryDetailModel line4 = new DriversSalaryDetailModel();
            line4.setDrvordTime("其他补贴");
            line4.setDriverName(df.format(totalOtherSubsidy));
            line4.setPlateNum("基础补贴");
            line4.setGoodsName(df.format(Double.parseDouble(driversSalaryAdditional.getBaseSubsidy())));
            DriversSalaryDetailModel line5 = new DriversSalaryDetailModel();
            line5.setDrvordTime("扣-社保");
            line5.setDriverName(df.format(Double.parseDouble(driversSalaryAdditional.getDeductSsAmount())));
            line5.setPlateNum("扣-个税");
            line5.setGoodsName(df.format(Double.parseDouble(driversSalaryAdditional.getDeductTaxAmount())));
            DriversSalaryDetailModel line6 = new DriversSalaryDetailModel();
            line6.setDrvordTime("扣-借款");
            line6.setDriverName(df.format(Double.parseDouble(driversSalaryAdditional.getDeductLoanAmount())));
            line6.setPlateNum("扣-其他");
            line6.setGoodsName(df.format(Double.parseDouble(driversSalaryAdditional.getDeductOtherAmount())));
            DriversSalaryDetailModel line7 = new DriversSalaryDetailModel();
            line7.setDrvordTime("小活补贴");
            String extraWorkSubsidy = driversSalaryDao.searchExtraWorkSubsidy(salarySearchModel);
            line7.setDriverName(df.format(Double.parseDouble(extraWorkSubsidy)));
            line7.setPlateNum("总计-实发工资");
            Double totalSalary = totalBaseSalary+oilPatch+totalOtherSubsidy+Double.parseDouble(driversSalaryAdditional.getBaseSubsidy())+Double.parseDouble(extraWorkSubsidy)
                    -Double.parseDouble(driversSalaryAdditional.getDeductSsAmount())-Double.parseDouble(driversSalaryAdditional.getDeductTaxAmount())
                    -Double.parseDouble(driversSalaryAdditional.getDeductLoanAmount())-Double.parseDouble(driversSalaryAdditional.getDeductOtherAmount());
            line7.setGoodsName(df.format(totalSalary));
            driversSalaryDetailAll.add(line);
            driversSalaryDetailAll.add(line1);
            driversSalaryDetailAll.add(line2);
            driversSalaryDetailAll.add(line3);
            driversSalaryDetailAll.add(line4);
            driversSalaryDetailAll.add(line5);
            driversSalaryDetailAll.add(line6);
            driversSalaryDetailAll.add(line7);
        }
        return driversSalaryDetailAll;
    }

    @Transactional(readOnly = false)
    public String fingDriverName(String driverCode) {
        return driversSalaryDao.findDriverName(driverCode);
    }
}
