package com.xzg56.jg.modules.mst.pricecontract.service;

import com.alibaba.druid.support.json.JSONUtils;
import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.jg.modules.common.domain.IPriceContractDomain;
import com.xzg56.jg.modules.common.persistence.dao.PriceContractBfDao;
import com.xzg56.jg.modules.common.persistence.entity.PriceContract;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractBf;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractCus;
import com.xzg56.jg.modules.mst.pricecontract.dao.PriceContractManDao;
import com.xzg56.jg.modules.mst.pricecontract.model.PriceContractBfExcelModel;
import com.xzg56.jg.modules.mst.pricecontract.model.PriceContractBfModel;
import com.xzg56.jg.modules.mst.pricecontract.model.PriceContractCusModel;
import com.xzg56.jg.modules.mst.pricecontract.model.PriceContractModel;
import com.xzg56.utility.BeanUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service("priceContractService")
@Transactional(readOnly = true)
public class PriceContractService extends BaseService {
    @Resource
    private PriceContractManDao priceContractManDao;

    @Resource
    private IPriceContractDomain priceContractDomain;

    @Resource
    private PriceContractBfDao priceContractBfDao;

    public List<PriceContractModel> getPriceContractList(PriceContractModel priceContractModel) {
        List<PriceContractModel> list = priceContractManDao.getPriceContractList(priceContractModel);
        List<Dict> settlementType = DictUtils.getDictList(BizFcConstants.GROUP_NO.SETTLEMENT_TYPE);
        List<Dict> sysConfirmFlag = DictUtils.getDictList(BizFcConstants.GROUP_NO.SYS_CONFIRM_FLAG);
        for (PriceContractModel model : list) {
            for (Dict dict : settlementType) {
                if (StringUtils.equals(model.getSettlementType(), dict.getValue())) {
                    model.setSettlementTypeName(dict.getLabel());
                    break;
                }
            }
        }
        return list;
    }

    @Transactional(readOnly = false)
    public void save(PriceContract priceContract) {
        if (StringUtils.isBlank(priceContract.getPriceContractNo())) {
           priceContractDomain.registerPriceContract(priceContract);
        } else {
            priceContractDomain.modifyPriceContract(priceContract);
        }
    }

    @Transactional(readOnly = false)
    public void delete(String priceContractNo) {
        priceContractDomain.delete(priceContractNo);
    }

    public List<PriceContractCusModel> getPriceContractCusList(PriceContractCusModel mstPriceContractCusModel) {
        return priceContractManDao.getPriceContractCusList(mstPriceContractCusModel);
    }

    @Transactional(readOnly = false)
    public void saveCus(PriceContractCus priceContractCus) {
        PriceContractCusModel priceContractCusModel = new PriceContractCusModel();
        priceContractCusModel.setCusCode(priceContractCus.getCusCode());
        priceContractCusModel.setPriceContractNo(priceContractCus.getPriceContractNo());
        List<PriceContractCusModel> mstPriceContractCusModelList = priceContractManDao.getPriceContractCusList(priceContractCusModel);
        if (mstPriceContractCusModelList.size() == 0) {
           priceContractDomain.registerPriceContractCus(priceContractCus);
        } else {
           priceContractDomain.modifyPriceContractCus(priceContractCus);
        }
    }

    @Transactional(readOnly = false)
    public void deleteCus(PriceContractCus priceContract) {
//        priceContractManDao.deletePriceContractCus(priceContract.getPriceContractNo(), priceContract.getCusCode());
//        Integer existsPriceContractCusCnt = priceContractManDao.cntPriceContractCus(priceContract);
//        if (existsPriceContractCusCnt == 0) {
//            priceContractManDao.updateUnPriceContractCus(priceContract);
//        }
    }

    //获取运费明细列表
    @Transactional(readOnly = false)
    public List<PriceContractBfModel> getPriceContractBfList(PriceContractBfModel priceContractBfModel, boolean hasTransform) {
        List<PriceContractBfModel> list = priceContractManDao.getPriceContractBfList(priceContractBfModel);
        List<Dict> bfLevelCode = DictUtils.getDictList(BizFcConstants.GROUP_NO.BF_LEVEL_CODE);
        List<Dict> binsType = DictUtils.getDictList(BizFcConstants.GROUP_NO.BINS_TYPE);
        List<Dict> ioType = DictUtils.getDictList(BizFcConstants.GROUP_NO.IO_TYPE);
        List<Dict> effectiveStatus = DictUtils.getDictList(BizFcConstants.GROUP_NO.EFFECTIVE_STATUS);
        List<Dict> roundTrips = DictUtils.getDictList(BizFcConstants.GROUP_NO.SYS_CONFIRM_FLAG);
        List<Dict> chargingTypes = DictUtils.getDictList(BizFcConstants.GROUP_NO.CHARGING_TYPE);
        if (hasTransform) {
            for (PriceContractBfModel model : list) {
                for (Dict dict : bfLevelCode) {
                    if (StringUtils.equals(model.getContainerType(), dict.getData2())) {
                        model.setContainerName(dict.getValue());
                    }
                }
                for (Dict dict : binsType) {
                    if (StringUtils.equals(model.getBinsType(), dict.getValue())) {
                        model.setBinsName(dict.getLabel());
                    }
                    if (StringUtils.isBlank(model.getBinsType())) {
                        model.setBinsName("全部");
                    }
                }
                for (Dict dict : ioType) {
                    if (StringUtils.equals(model.getIoType(), dict.getValue())) {
                        model.setIoName(dict.getLabel());
                    }
                    if (StringUtils.isBlank(model.getIoType())) {
                        model.setIoName("全部");
                    }
                }
                for (Dict dict : effectiveStatus) {
                    if (StringUtils.equals(model.getEffectiveStatus(), dict.getValue())) {
                        model.setEffectiveStatusName(dict.getLabel());
                    }

                }
                for (Dict dict : roundTrips) {
                    if (StringUtils.equals(model.getRoundTripFlag(), dict.getValue())) {
                        model.setRoundTripFlag(dict.getLabel());
                    }
                }
                for (Dict dict : chargingTypes) {
                    if (StringUtils.equals(model.getChargingType(), dict.getValue())) {
                        model.setChargingType(dict.getLabel());
                    }
                }
            }
        }
        return list;
    }

    //获取四级地址
    public List<PriceContractBfModel> getName(String pcode) {
        return priceContractManDao.getName(pcode);
    }

    //增加
    @Transactional(readOnly = false)
    public void save(PriceContractBfModel priceContractBfModel){
        PriceContractBf priceContractBf;
        if (StringUtils.equals(BizFcConstants.PAGE_TYPE.COPY, priceContractBfModel.getPageType())){
            priceContractBfModel.setId(null);
        }
        if (!this.checkValid(priceContractBfModel)){
            throw new ValidationException("该协议已失效！");
        }

        if (!this.checkInfo(priceContractBfModel)){
            throw new ValidationException("已存在该运费！");
        }

        priceContractBf = this.getPriceContractBf(priceContractBfModel);
        if (StringUtils.equals(BizFcConstants.PAGE_TYPE.CREATE, priceContractBfModel.getPageType())||
                StringUtils.equals(BizFcConstants.PAGE_TYPE.COPY, priceContractBfModel.getPageType())){
            priceContractDomain.registerPriceContractBf(priceContractBf);
        } else if (StringUtils.equals(BizFcConstants.PAGE_TYPE.EDIT, priceContractBfModel.getPageType())){
            if(StringUtils.isBlank(priceContractDomain.getPriceContractBf(priceContractBfModel.getId()))){
                throw new ValidationException("所选运费明细已被删除！");
            }
            priceContractBf.setId(priceContractBfModel.getId());
            priceContractDomain.modifyPriceContractBf(priceContractBf);
        }
    }

    private boolean checkInfo(PriceContractBfModel mstPriceContractBfModel) {
        PriceContractBfModel result = priceContractManDao.checkInfo(mstPriceContractBfModel);
        if(StringUtils.isNotBlank(result))
            return false;
        return true;
    }

    private boolean checkValid(PriceContractBfModel priceContractBfModel) {
        PriceContractModel para = new PriceContractModel();
        para.setPriceContractNo(priceContractBfModel.getPriceContractNo());
        para.setValidFlag(BizFcConstants.YES);
        PriceContractModel mstPriceContractModel = priceContractManDao.getPriceContractInfo(para);
        if (StringUtils.isBlank(mstPriceContractModel))
            return false;
        return true;
    }

    private PriceContractBf getPriceContractBf(PriceContractBfModel priceContractBfModel) {
        PriceContractBf priceContractBf = new PriceContractBf();
        priceContractBf.setPriceContractNo(priceContractBfModel.getPriceContractNo());
        priceContractBf.setChargingType(priceContractBfModel.getChargingType());
        priceContractBf.setContainerType(priceContractBfModel.getContainerType());
        priceContractBf.setFromProvinceCode(priceContractBfModel.getFromProvinceCode());
        priceContractBf.setFromCityCode(priceContractBfModel.getFromCityCode());
        priceContractBf.setFromDistrictCode(priceContractBfModel.getFromDistrictCode());
        priceContractBf.setFromCountyCode(priceContractBfModel.getFromCountyCode());
        priceContractBf.setToProvinceCode(priceContractBfModel.getToProvinceCode());
        priceContractBf.setToCityCode(priceContractBfModel.getToCityCode());
        priceContractBf.setToDistrictCode(priceContractBfModel.getToDistrictCode());
        priceContractBf.setToCountyCode(priceContractBfModel.getToCountyCode());
        priceContractBf.setRemarks(priceContractBfModel.getRemarks());
        priceContractBf.setrCusBfPrice(priceContractBfModel.getrCusBfPrice());
        priceContractBf.setrCusBfPriceNoTax(priceContractBfModel.getrCusBfPrice());
        priceContractBf.setBinsType(priceContractBfModel.getBinsType());
        priceContractBf.setIoType(priceContractBfModel.getIoType());
        priceContractBf.setRoundTripFlag(priceContractBfModel.getRoundTripFlag());
        priceContractBf.setOverweightPrice(priceContractBfModel.getOverweightPrice());
        priceContractBf.setLimitWeight(priceContractBfModel.getLimitWeight());
        return priceContractBf;
    }

    public PriceContractModel getPriceContractInfo(PriceContractModel mstPriceContractModel) {
        return priceContractManDao.getPriceContractInfo(mstPriceContractModel);
    }

    @Transactional(readOnly = false)
    public void delete(List<PriceContractBfModel> mstPriceContractModelList) {
        PriceContractBf priceContractBf;
        for (PriceContractBfModel model:mstPriceContractModelList) {
            priceContractBf = priceContractDomain.getPriceContractBf(model.getId());
            if(StringUtils.isBlank(priceContractBf))
                throw new ValidationException("存在运费明细已被删除！");
        }
        for (PriceContractBfModel model : mstPriceContractModelList) {
            priceContractDomain.deleteContractBf(model.getId());
        }
    }

    public String getPriceContractList(PriceContractBfModel priceContractBfModel) {
        List<Map<String, String>> priceContractList = priceContractManDao.getPriceContractMapList(priceContractBfModel);
        return JSONUtils.toJSONString(priceContractList);
    }

    public String getPriceContractNoEffectiveStatus(String priceContractNo) {
        return priceContractManDao.getPriceContractNoEffectiveStatus(priceContractNo);
    }

    /**
     * 批量导入价格协议
     */
    @Transactional(readOnly = false)
    public void importPrice(File file){
//        LinkedHashMap<String, Integer> fieldMap = ExcelToModel.getFieldMap();
//        List<ImportExcelDataModel> models = ExcelToModel.excelToList(file, ImportExcelDataModel.class, fieldMap);
//        //转化成PriceContractBf对象集合
//        List<PriceContractBf> list = this.getMstPcbModels(models);
//        if (list.size() > 0) {
//            //批量新增
//            mstPriceContractBfDao.insertPriceContractBf(list);
//        }
    }

    /**
     * 批量导入价格协议
     */
    @Transactional(readOnly = false)
    public void importPrices(List<PriceContractBfExcelModel> priceContractBfExcelModels){
        List<PriceContractBf> priceContractBfs = transformPriceContractBf(priceContractBfExcelModels);
        if (priceContractBfs.size() > 0) {
            //批量新增
            priceContractBfDao.batchInsert(priceContractBfs);
        }
    }

    private List<PriceContractBf> transformPriceContractBf(List<PriceContractBfExcelModel> priceContractBfExcelModels) {
        List<PriceContractBf> priceContractBfs = new ArrayList<>();
        for (PriceContractBfExcelModel model : priceContractBfExcelModels) {
            if (StringUtils.isNotBlank(model.getPriceContractNo())) {
                PriceContractBf priceContractBf = new PriceContractBf();
                priceContractBf.setPriceContractNo(model.getPriceContractNo());
                priceContractBf.setChargingType(model.getChargingType());
                priceContractBf.setFromProvinceCode(model.getFromProvinceCode());
                priceContractBf.setFromCityCode(model.getFromCityCode());
                priceContractBf.setFromDistrictCode(model.getFromDistrictCode());
                priceContractBf.setFromCountyCode(model.getFromCountyCode());
                priceContractBf.setToProvinceCode(model.getToProvinceCode());
                priceContractBf.setToCityCode(model.getToCityCode());
                priceContractBf.setToDistrictCode(model.getToDistrictCode());
                priceContractBf.setToCountyCode(model.getToCountyCode());
                priceContractBf.setContainerType(model.getContainerType());
                priceContractBf.setRemarks(model.getRemarks());
                priceContractBf.setrCusBfPrice(model.getrCusBfPrice());
                priceContractBf.setrCusBfPriceNoTax(model.getrCusBfPriceNoTax());
                priceContractBf.setRoundTripFlag(StringUtils.isBlank(model.getRoundTripFlag()) ? GlobalConstants.NO : GlobalConstants.YES);
                priceContractBf.setOverweightPrice(StringUtils.isBlank(model.getOverweightPrice()) ? null : model.getOverweightPrice());
                priceContractBf.setLimitWeight(StringUtils.isBlank(model.getLimitWeight()) ? null : model.getLimitWeight());
                priceContractBf.setValidFlag(GlobalConstants.YES);
                priceContractBf.setCreateBy(UserUtils.getUserId());

                priceContractBfs.add(priceContractBf);
            }
        }

        return priceContractBfs;
    }

    /**
     * 数据转化
     */
//    private List<PriceContractBf> getMstPcbModels(List<ImportExcelDataModel> models) {
//        List<PriceContractBf> insertPriceContractBfs = new ArrayList<>();
//        //内贸
//        String internaltrade = PriceContractBfConstant.BINS_TYPE.INTERNALTRADE;
//        //外贸
//        String externaltrade = PriceContractBfConstant.BINS_TYPE.EXTERNALTRADE;
//        //进口
//        String in = PriceContractBfConstant.IO_TYPE.IN;
//        //出口
//        String out = PriceContractBfConstant.IO_TYPE.OUT;
//        //小柜
//        String smallCabinet = PriceContractBfConstant.BF_LEVEL_CODE.SMALL;
//        //大柜
//        String bigCabinet = PriceContractBfConstant.BF_LEVEL_CODE.BIG;
//        //冻小柜
//        String iceSmallCabinet = PriceContractBfConstant.BF_LEVEL_CODE.ICESMALL;
//        //冻大柜
//        String iceBigCabinet = PriceContractBfConstant.BF_LEVEL_CODE.ICEBIG;
//        //价格
//        String bfPrice;
//
//        for (ImportExcelDataModel model: models) {
//            PriceContractBf priceContractBf = new PriceContractBf();
//            //设置协议编码
//            priceContractBf.setPriceContractNo(model.getContractCode());
//            //设置四级地址
//            priceContractBf.setProvinceCode(model.getProvinceCode());
//            priceContractBf.setCityCode(model.getCityCode());
//            priceContractBf.setDistrictCode(model.getDistrictCode());
//            priceContractBf.setCountyCode(model.getCountyCode());
//            //设置区域门点
//            priceContractBf.setDestRegionName(model.getCityName());
//            String destAddrsName = StringUtils.isNotBlank(model.getCountyName()) ? model.getDistrictName().concat(model.getCountyName()) : model.getDistrictName();
//            priceContractBf.setDestAddrsName(StringUtils.isNotBlank(destAddrsName) ? destAddrsName : null);
//            //码头编码
//            priceContractBf.setDockCode(PriceContractBfConstant.DOCK_CODE.DOCKCODE);
//            //出发地编码
//            priceContractBf.setStartAddrsCode(PriceContractBfConstant.START_ADDRS_CODE.STARTADDRSCODE);
//            //设置备注
//            priceContractBf.setRemarks(model.getRemarks());
//            priceContractBf.setCreateBy(StringUtils.toString(UserUtils.getUser().getId()));
//            if (StringUtils.isNotBlank(model.getiISmallCabinet())) {
//                //设置内贸进口小柜
//                bfPrice = model.getiISmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,in,smallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getiIIceSmallCabinet())) {
//                //设置内贸进口冻小柜
//                bfPrice = model.getiIIceSmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,in,iceSmallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getiIBigCabinet())) {
//                //设置内贸进口大柜
//                bfPrice = model.getiIBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,in,bigCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getiIIceBigCabinet())) {
//                //设置内贸进口冻大柜
//                bfPrice = model.getiIIceBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,in,iceBigCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getiOSmallCabinet())) {
//                //设置内贸出口小柜
//                bfPrice = model.getiOSmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,out,smallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getiOIceSmallCabinet())) {
//                //设置内贸出口冻小柜
//                bfPrice = model.getiOIceSmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,out,iceSmallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getiOBigCabinet())) {
//                //设置内贸出口大柜
//                bfPrice = model.getiOBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,out,bigCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getiOIceBigCabinet())) {
//                //设置内贸出口冻大柜
//                bfPrice = model.getiOIceBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,internaltrade,out,iceBigCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoISmallCabinet())) {
//                //设置外贸进口小柜
//                bfPrice = model.getoISmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,in,smallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoIIceSmallCabinet())) {
//                //设置外贸进口冻小柜
//                bfPrice = model.getoIIceSmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,in,iceSmallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoIBigCabinet())) {
//                //设置外贸进口大柜
//                bfPrice = model.getoIBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,in,bigCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoIIceBigCabinet())) {
//                //设置外贸进口冻大柜
//                bfPrice = model.getoIIceBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,in,iceBigCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoOSmallCabinet())) {
//                //设置外贸出口小柜
//                bfPrice = model.getoOSmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,out,smallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoOIceSmallCabinet())) {
//                //设置外贸出口冻小柜
//                bfPrice = model.getoOIceSmallCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,out,iceSmallCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoOBigCabinet())) {
//                //设置外贸出口大柜
//                bfPrice = model.getoOBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,out,bigCabinet,insertPriceContractBfs,bfPrice);
//            }
//            if (StringUtils.isNotBlank(model.getoOIceBigCabinet())) {
//                //设置外贸出口冻大柜
//                bfPrice = model.getoOIceBigCabinet();
//                insertPriceContractBfs = getPcbList(priceContractBf,externaltrade,out,iceBigCabinet,insertPriceContractBfs,bfPrice);
//            }
//
//        }
//        return insertPriceContractBfs;
//    }

    private List<PriceContractBf> getPcbList(PriceContractBf model, String binsType,
                                             String ioType,String containerType,List<PriceContractBf> list,String price) {
        //克隆一个新对象
        PriceContractBf priceContractBf = null;
        try {
            priceContractBf = (PriceContractBf) BeanUtils.cloneBean(model);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        //内外贸
        priceContractBf.setBinsType(binsType);
        //进出口
        priceContractBf.setIoType(ioType);
        //箱型
        priceContractBf.setContainerType(containerType);
        //设置价格
        priceContractBf.setrCusBfPrice(price);
        priceContractBf.setrCusBfPriceNoTax(price);

        //判断价格协议是否存在
        List<PriceContractBf> priceContractBfs = priceContractBfDao.findPriceContract(priceContractBf);
        if (priceContractBfs.size() == 0) {
            list.add(priceContractBf);
        }
        return list;
    }
}
