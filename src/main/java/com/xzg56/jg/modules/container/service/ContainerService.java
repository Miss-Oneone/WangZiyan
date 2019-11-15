package com.xzg56.jg.modules.container.service;


import com.xzg56.common.module.sys.basic.service.NumberingService;
import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.finance.common.persistence.dao.OrdReceiptsPaymentsDao;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.common.constant.PjConstants;
import com.xzg56.jg.modules.common.domain.IEqpDomain;
import com.xzg56.jg.modules.common.domain.IExpenseDomain;
import com.xzg56.jg.modules.common.model.ContainerModel;
import com.xzg56.jg.modules.common.persistence.dao.*;
import com.xzg56.jg.modules.common.persistence.entity.*;
import com.xzg56.jg.modules.container.dao.ContainerDao;
import com.xzg56.jg.modules.container.model.PriceContractModel;
import com.xzg56.jg.modules.container.model.PriceContractSearchModel;
import com.xzg56.jg.modules.extrawork.dao.ExtraWorkDao;
import com.xzg56.jg.modules.extrawork.model.ExtraWorkModel;
import com.xzg56.jg.modules.helper.model.HelperModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteModel;
import com.xzg56.jg.modules.mst.costroute.model.CostRouteSearchModel;
import com.xzg56.jg.modules.mst.oilManagement.model.SelectModel;
import com.xzg56.jg.modules.mst.truckframe.dao.TruckFrameManDao;
import com.xzg56.jg.modules.mst.truckframe.model.TruckFrameModel;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;


@Service("ContainerService")
@Transactional(readOnly = true)
public class ContainerService extends BaseService {

    @Resource
    private ContainerDao containerDao;

    @Autowired
    private NumberingService numberingService;

    @Resource
    private IEqpDomain eqpDomain;

    @Resource
    private ContnDao contnDao;

    @Resource
    private TrailerDao trailerDao;

    @Resource
    private TruckFrameDao truckFrameDao;

    @Resource
    private EqpAddressHisDao eqpAddressHisDao;

    @Resource
    private OrdReceiptsPaymentsDao ordReceiptsPaymentsDao;

    @Resource
    private OrdRouteInfoDao ordRouteInfoDao;

    @Resource
    private OrdRouteInfoContactDao ordRouteInfoContactDao;

    @Resource
    private IExpenseDomain expenseDomain;

    @Resource
    private TruckFrameManDao truckFrameManDao;

    @Resource
    private ExtraWorkDao extraWorkDao;

    /**
     * 新增订单
     */
    @Transactional(readOnly = false)
    public void addOrder(ContainerModel model){
        Long userId =  UserUtils.getUser().getId();
        model.setUserId(StringUtils.toString(userId));
        if (StringUtils.isBlank(model.getCount())) {
            model.setCount(null);
        }
        if (StringUtils.isBlank(model.getPrice())) {
            model.setPrice(null);
        }
        if (StringUtils.isBlank(model.getOrderDate())) {
            model.setOrderDate(null);
        }
        if (StringUtils.isBlank(model.getDepartureDate())) {
            model.setDepartureDate(null);
        }
        if (StringUtils.isNotBlank(model.getCollectionOrderYes())) {
            model.setAcceptOrderFlag(GlobalConstants.YES);
        } else if(StringUtils.isNotBlank(model.getCollectionOrderNo())){
            model.setAcceptOrderFlag(GlobalConstants.NO);
        } else {
            model.setAcceptOrderFlag(null);
        }
        if (StringUtils.isNotBlank(model.getTripFlagUp())) {
            model.setTripFlag(Constants.TRIP_FLAG_UP);
        }
        if (StringUtils.isNotBlank(model.getTripFlagDown())) {
            model.setTripFlag(Constants.TRIP_FLAG_DOWN);
        }
        if (StringUtils.isBlank(model.getChangeBoxTime())) {
            model.setChangeBoxTime(null);
        }
        if (StringUtils.isBlank(model.getCrossBoxTime())) {
            model.setCrossBoxTime(null);
        }
        if (StringUtils.isBlank(model.getContnOwnerId())) {
            model.setContnOwnerId(null);
        }
        model.setOrderNo(this.searchOrderNo());
        if (StringUtils.isNotBlank(model.getGoodsCodeOut())) {
            model.setGoodsCodeOut(StringUtils.replace(model.getGoodsCodeOut(), "'", ""));
        }

        // 添加履历
        addEqpAdrsHis(model);
        // 绑定箱号和车架号
        if (StringUtils.isNotBlank(model.getContnNo()) && StringUtils.isNotBlank(model.getFrameNo())) {
            eqpDomain.frameBindContn(StringUtils.toInteger(model.getFrameNo()), model.getContnNo());
        }
        // 批量修改截箱时间和还箱时间
        batchUpdateCrossBoxTime(model, null, null);
        // 生成费用
        expenseSubmit(model, PjConstants.ORD_EXPENSE_ACTION_TYPE.ADD);
        // 保存订单
        containerDao.addOrder(model);
        //同步更新mst_contn的特殊箱型
        updateContnSpTy(model);
        // 生成路线地址信息
        createOrdRouteInfo(model);

        //新增时，先保存订单，再判断该箱是否最晚一次的发车，最晚则更新设备地址
        if(StringUtils.equals(model.getOrderNo(),containerDao.lastDepartureDateOrder(model.getContnNo()))) {
            // 设备地址管理
            adrsManage(model.getToZxAdrs(), model.getContnNo(), model.getPlateNum(), model.getFrameNo());
        }

        //小活记录
        if(!StringUtils.equals(model.getGoodsCodeIn(),"空上")){
            extraWork(model);
        }

    }

    //同步更新mst_contn的特殊箱型
    private void updateContnSpTy(ContainerModel model) {
        Contn contn = contnDao.getByContnNo(model.getContnNo());
        if(contn != null) {
            if(StringUtils.isNotBlank(model.getSpecialContnType())) {
                contn.setSpecialContnType(model.getSpecialContnType());
                contnDao.update(contn);
            } else {
                //该柜号所有下的所有订单的特殊箱类型都是空的，如果是才能更新mst_contn，否则不做更新
                Integer count = containerDao.getOrdSpecialContnCount(model.getContnNo());
                if(count == 0) {
                    contn.setSpecialContnType(null);
                    contnDao.update(contn);
                }
            }
        }
    }

    /**
     * 查询订单列表
     */
    public List<ContainerModel> searchOrderList(ContainerModel model) {
        if (StringUtils.isNotBlank(model.getCollectionOrderYes())) {
            model.setAcceptOrderFlag(GlobalConstants.YES);
        }
        if(StringUtils.isNotBlank(model.getCollectionOrderNo())){
            model.setAcceptOrderFlag(GlobalConstants.NO);
        }
        if (StringUtils.isNotBlank(model.getCollectionOrderYes()) && StringUtils.isNotBlank(model.getCollectionOrderNo())) {
            model.setAcceptOrderFlag(null);
        }
        if (StringUtils.isNotBlank(model.getUnScheduling())) {
            model.setUnScheduling("true");
        }
        if (StringUtils.isNotBlank(model.getScheduling())) {
            model.setScheduling("true");
        }
        if (StringUtils.isNotBlank(model.getTripFlagUp())) {
            model.setTripFlag(Constants.TRIP_FLAG_UP);
        }
        if (StringUtils.isNotBlank(model.getTripFlagDown())) {
            model.setTripFlag(Constants.TRIP_FLAG_DOWN);
        }
        if (StringUtils.isNotBlank(model.getTripFlagUp()) && StringUtils.isNotBlank(model.getTripFlagDown())) {
            model.setTripFlag("true");
        }
        if (StringUtils.isNotBlank(model.getWagesFlag())) {
            model.setWagesFlag("true");
        }
        if (StringUtils.isNotBlank(model.getFreightFlag())) {
            model.setFreightFlag("true");
        }
        List<ContainerModel> list = containerDao.searchOrderList(model);
        List<Dict> acceptOrderFlags = DictUtils.getDictList("ACCEPT_ORDER_FLAG");//是否收单
        List<Dict> chargingTypes = DictUtils.getDictList("CHARGING_TYPE");//计费模式
        List<Dict> transportTypes = DictUtils.getDictList("TRANSPORT_TYPE");//运输方式
        List<Dict> tripFlags = DictUtils.getDictList("TRIP_FLAG");//行程标志
        List<Dict> ioTypes = DictUtils.getDictList("IO_TYPE");//业务类型
        List<Dict> trailerBelongTypes = DictUtils.getDictList("TRAILER_BELONG_TYPE");//运力类型
        List<Dict> specialContnTypes = DictUtils.getDictList("SPECIAL_CONTN_TYPE");//特殊箱类型
        for (ContainerModel containerModel: list) {
            if (StringUtils.isNotBlank(containerModel.getAcceptOrderFlag())) {
                for (Dict dict: acceptOrderFlags) {
                    if (StringUtils.equals(dict.getValue(),containerModel.getAcceptOrderFlag())) {
                        containerModel.setAcceptOrderFlag(dict.getLabel());
                        break;
                    }
                }
            }
            if (StringUtils.isNotBlank(containerModel.getChargingType())) {
                for (Dict dict: chargingTypes) {
                    if (StringUtils.equals(dict.getValue(),containerModel.getChargingType())) {
                        containerModel.setChargingType(dict.getLabel());
                        break;
                    }
                }
            }
            if (StringUtils.isNotBlank(containerModel.getTransportType())) {
                for (Dict dict: transportTypes) {
                    if (StringUtils.equals(dict.getValue(),containerModel.getTransportType())) {
                        containerModel.setTransportType(dict.getLabel());
                        break;
                    }
                }
            }
            if (StringUtils.isNotBlank(containerModel.getTripFlag())) {
                for (Dict dict: tripFlags) {
                    if (StringUtils.equals(dict.getValue(),containerModel.getTripFlag())) {
                        containerModel.setTripFlag(dict.getLabel());
                        break;
                    }
                }
            }
            if (StringUtils.isNotBlank(containerModel.getIoType())) {
                for (Dict dict: ioTypes) {
                    if (StringUtils.equals(dict.getValue(),containerModel.getIoType())) {
                        containerModel.setIoType(dict.getLabel());
                        break;
                    }
                }
            }
            if (StringUtils.isNotBlank(containerModel.getTrailerBelongType())) {
                for (Dict dict: trailerBelongTypes) {
                    if (StringUtils.equals(dict.getValue(),containerModel.getTrailerBelongType())) {
                        containerModel.setTrailerBelongType(dict.getLabel());
                        break;
                    }
                }
            }
            if (StringUtils.isNotBlank(containerModel.getSpecialContnType())) {
                for (Dict dict: specialContnTypes) {
                    if (StringUtils.equals(dict.getValue(),containerModel.getSpecialContnType())) {
                        containerModel.setSpecialContnTypeName(dict.getLabel());
                        break;
                    }
                }
            }
        }
        return list;
    }

    /**
     * 根据订单号查询订单信息
     */
    public ContainerModel searchOrder(String orderNo) {
        ContainerModel containerModel = containerDao.searchOrder(orderNo);
        // 根据价格协议ID获取价格协议信息
        if (StringUtils.isNotBlank(containerModel.getContaBfId())) {
            List<String> contaBfIds = new ArrayList<>();
            contaBfIds.add(containerModel.getContaBfId());
            List<PriceContractModel> priceContractModels = containerDao.getPriceContractsByStdAddrsByIds(contaBfIds);
            if (priceContractModels.size() > 0) {
                PriceContractModel priceContract = priceContractModels.get(0);
                containerModel.setLimitWeightTip(StringUtils.isNotBlank(priceContract.getLimitWeight()) ? StringUtils.toDouble(priceContract.getLimitWeight()) : 0d);
                containerModel.setOverweightPriceTip(StringUtils.isNotBlank(priceContract.getOverweightPrice()) ? StringUtils.toDouble(priceContract.getOverweightPrice()) : 0d);
                if (!StringUtils.equals(containerModel.getChargingType(), PjConstants.CHARGING_TYPE.CHARGING_TYPE_1)) {
                    containerModel.setUnitPriceTip(StringUtils.isNotBlank(priceContract.getRCusBfPrice()) ? StringUtils.toDouble(priceContract.getRCusBfPrice()) : 0d);
                }
            }
        }
        // 路线地址信息
        List<OrdRouteInfo> ordRouteInfos = ordRouteInfoDao.listByOrderNo(containerModel.getOrderNo());
        for (OrdRouteInfo ordRouteInfo : ordRouteInfos) {
            // 联系人信息
            List<OrdRouteInfoContact> contacts = ordRouteInfoContactDao.listByRouteInfoId(ordRouteInfo.getId().intValue());
            List<String> names = new ArrayList<>();
            List<String> phones = new ArrayList<>();
            for (OrdRouteInfoContact contact : contacts) {
                if (StringUtils.isNotBlank(contact.getName())) {
                    names.add(contact.getName());
                }
                if (StringUtils.isNotBlank(contact.getPhone())) {
                    phones.add(contact.getPhone());
                }
            }
            // 四级地址信息
            List<String> codes = Arrays.asList(new String[]{ordRouteInfo.getProvinceCode(), ordRouteInfo.getCityCode(), ordRouteInfo.getDistrictCode(), ordRouteInfo.getCountyCode()});
            List<SelectModel> stdAddresses = containerDao.listStdAddressesByCodes(codes);
            if (StringUtils.equals(ordRouteInfo.getAddressType(), PjConstants.ADDRESS_TYPE.ZHD)) {
                containerModel.setFromProvinceCode(ordRouteInfo.getProvinceCode());
                containerModel.setFromCityCode(ordRouteInfo.getCityCode());
                containerModel.setFromDistrictCode(ordRouteInfo.getDistrictCode());
                containerModel.setFromCountyCode(ordRouteInfo.getCountyCode());
                for (SelectModel stdAdrs : stdAddresses) {
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getProvinceCode())) {
                        containerModel.setFromProvinceName(stdAdrs.getText());
                    }
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getCityCode())) {
                        containerModel.setFromCityName(stdAdrs.getText());
                    }
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getDistrictCode())) {
                        containerModel.setFromDistrictName(stdAdrs.getText());
                    }
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getCountyCode())) {
                        containerModel.setFromCountyName(stdAdrs.getText());
                    }
                }
                containerModel.setFromContactPerson(StringUtils.join(names, ","));
                containerModel.setFromContactPhone(StringUtils.join(phones, ","));
                containerModel.setFromAddressFull(ordRouteInfo.getAddressFull());
            } else if (StringUtils.equals(ordRouteInfo.getAddressType(), PjConstants.ADDRESS_TYPE.XHD)) {
                containerModel.setToProvinceCode(ordRouteInfo.getProvinceCode());
                containerModel.setToCityCode(ordRouteInfo.getCityCode());
                containerModel.setToDistrictCode(ordRouteInfo.getDistrictCode());
                containerModel.setToCountyCode(ordRouteInfo.getCountyCode());
                for (SelectModel stdAdrs : stdAddresses) {
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getProvinceCode())) {
                        containerModel.setToProvinceName(stdAdrs.getText());
                    }
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getCityCode())) {
                        containerModel.setToCityName(stdAdrs.getText());
                    }
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getDistrictCode())) {
                        containerModel.setToDistrictName(stdAdrs.getText());
                    }
                    if (StringUtils.equals(stdAdrs.getValue(), ordRouteInfo.getCountyCode())) {
                        containerModel.setToCountyName(stdAdrs.getText());
                    }
                }
                containerModel.setToContactPerson(StringUtils.join(names, ","));
                containerModel.setToContactPhone(StringUtils.join(phones, ","));
                containerModel.setToAddressFull(ordRouteInfo.getAddressFull());
            }
        }

        return containerModel;
    }


    /**
     *更新订单
     */
    @Transactional(readOnly = false)
    public void updateOrder(ContainerModel model){
        if (StringUtils.isBlank(model.getCount())) {
            model.setCount(null);
        }
        if (StringUtils.isBlank(model.getPrice())) {
            model.setPrice(null);
        }
        if (StringUtils.isBlank(model.getOrderDate())) {
            model.setOrderDate(null);
        }
        if (StringUtils.isBlank(model.getDepartureDate())) {
            model.setDepartureDate(null);
        }
        if (StringUtils.isNotBlank(model.getCollectionOrderYes())) {
            model.setAcceptOrderFlag(GlobalConstants.YES);
        } else if(StringUtils.isNotBlank(model.getCollectionOrderNo())){
            model.setAcceptOrderFlag(GlobalConstants.NO);
        } else {
            model.setAcceptOrderFlag(null);
        }
        if (StringUtils.isNotBlank(model.getTripFlagUp())) {
            model.setTripFlag(Constants.TRIP_FLAG_UP);
        }
        if (StringUtils.isNotBlank(model.getTripFlagDown())) {
            model.setTripFlag(Constants.TRIP_FLAG_DOWN);
        }
        if (StringUtils.isBlank(model.getChangeBoxTime())) {
            model.setChangeBoxTime(null);
        }
        if (StringUtils.isBlank(model.getCrossBoxTime())) {
            model.setCrossBoxTime(null);
        }
        if (StringUtils.isBlank(model.getContnOwnerId())) {
            model.setContnOwnerId(null);
        }
        long userId = UserUtils.getUser().getId();
        model.setUserId(StringUtils.toString(userId));
        if (StringUtils.isNotBlank(model.getGoodsCodeOut())) {
            model.setGoodsCodeOut(StringUtils.replace(model.getGoodsCodeOut(), "'", ""));
        }

        //判断该箱是否最晚一次的发车，最晚则更新设备地址
        if(StringUtils.equals(model.getOrderNo(),containerDao.lastDepartureDateOrder(model.getContnNo()))) {
            // 设备地址管理(第一次录入的时候做记录，后续编辑暂不考虑)
            adrsManage(model.getToZxAdrs(), model.getContnNo(), model.getPlateNum(), model.getFrameNo());
        }
        // 记录履历
        addEqpAdrsHis(model);
        // 绑定箱号和车架号
        if (StringUtils.isNotBlank(model.getContnNo()) && StringUtils.isNotBlank(model.getFrameNo())) {
            eqpDomain.frameBindContn(StringUtils.toInteger(model.getFrameNo()), model.getContnNo());
        }
        // 批量修改截箱时间和还箱时间
        ContainerModel containerModel = containerDao.searchOrder(model.getOrderNo());
        batchUpdateCrossBoxTime(model, containerModel.getCrossBoxTime(), containerModel.getChangeBoxTime());
        // 修改费用
        expenseSubmit(model, PjConstants.ORD_EXPENSE_ACTION_TYPE.EDIT);
        // 修改订单
        containerDao.updateOrder(model);
        //同步更新mst_contn的特殊箱型
        updateContnSpTy(model);
        // 修改路线地址信息
        updateOrdRouteInfo(model);

        //小活记录
        extraWork(model);
    }

    /**
     * 查询车架号
     */
    public String searchFrameNum(String id) {
        return containerDao.searchFrameNum(id);
    }

    /**
     * 查询司机
     */
    public ContainerModel getDriverCode(String plateNum) {
        return containerDao.getDriverCode(plateNum);
    }

    /**
     * 查询箱号是mst_contn是否存在
     */
    public ContainerModel getContnNos(String contnNo) {
        ContainerModel contnNoMsg = containerDao.getContainerType(contnNo);
        return contnNoMsg;
    }

    public List<String> getLikeContnNos(String contnNo) {
        return containerDao.getLikeContnNos(contnNo);
    }

    public String getCrossBoxTime(String contnNo) {
        return containerDao.getCrossBoxTimeByContnNo(contnNo);
    }

    public ContainerModel getStdAdrsCodesByZxd(String zxdId) {
        return containerDao.getStdAdrsCodesByZxd(zxdId);
    }

    public List<HelperModel> getPriceContracts(String cusCode) {
        return containerDao.getPriceContracts(cusCode);
    }

    public List<PriceContractModel> getPriceContractBfs(PriceContractSearchModel searchModel) {
        // 查找箱等级
        List<Dict> contns = DictUtils.getDictList("CONTAINER_TYPE");
        for (Dict contn : contns) {
            if (StringUtils.equals(searchModel.getContainerType(), contn.getValue())) {
                searchModel.setLevelCode(contn.getData2());
                break;
            }
        }
        return containerDao.getPriceContractsByStdAddrs(searchModel);
    }

    public List<PriceContractModel> getPriceContractBfs(String priceBfIds) {
        List<String> priceBfIdList = Arrays.asList(StringUtils.split(priceBfIds, ","));
        return containerDao.getPriceContractsByStdAddrsByIds(priceBfIdList);
    }

    public int countRoleWithoutDispatcher() {
        return containerDao.countRoleWithoutDispatcher(UserUtils.getUser().getId());
    }

    public List<CostRouteModel> listCostRoutes(CostRouteSearchModel searchModel) {
        // 根据车辆查找运力类型
        List<CostRouteModel> costRouteModels = new ArrayList<>();
        Trailer trailer = trailerDao.get(searchModel.getPlateNum());
        if (trailer != null) {
            List<String> fromAddrsCodes = new LinkedList<>();
            List<String> toAddrsCodes = new LinkedList<>();
            addStdAddrsCode(fromAddrsCodes, searchModel.getFromProvinceCode());
            addStdAddrsCode(fromAddrsCodes, searchModel.getFromCityCode());
            addStdAddrsCode(fromAddrsCodes, searchModel.getFromDistrictCode());
            addStdAddrsCode(fromAddrsCodes, searchModel.getFromCountyCode());
            addStdAddrsCode(toAddrsCodes, searchModel.getToProvinceCode());
            addStdAddrsCode(toAddrsCodes, searchModel.getToCityCode());
            addStdAddrsCode(toAddrsCodes, searchModel.getToDistrictCode());
            addStdAddrsCode(toAddrsCodes, searchModel.getToCountyCode());

            int fromStdAddrsCodesSize = fromAddrsCodes.size();
            int totdAddrsCodesSize = toAddrsCodes.size();
            List<CostRouteSearchModel> drvSalarySearchModels = new LinkedList<>();
            for (int fromIdx = 0; fromIdx < fromStdAddrsCodesSize; fromIdx++) {
                for (int toIdx = 0; toIdx < totdAddrsCodesSize; toIdx++) {
                    CostRouteSearchModel drvSalarySearchModel = new CostRouteSearchModel();
                    drvSalarySearchModel.setTrailerBelongType(trailer.getTrailerBelongType());
                    if (fromIdx == 0) {
                        drvSalarySearchModel.setFromProvinceCode(fromAddrsCodes.get(fromIdx));
                    } else if (fromIdx == 1) {
                        drvSalarySearchModel.setFromCityCode(fromAddrsCodes.get(fromIdx));
                    } else if (fromIdx == 2) {
                        drvSalarySearchModel.setFromDistrictCode(fromAddrsCodes.get(fromIdx));
                    } else if (fromIdx == 3) {
                        drvSalarySearchModel.setFromCountyCode(fromAddrsCodes.get(fromIdx));
                    }
                    if (toIdx == 0) {
                        drvSalarySearchModel.setToProvinceCode(toAddrsCodes.get(toIdx));
                    } else if (toIdx == 1) {
                        drvSalarySearchModel.setToCityCode(toAddrsCodes.get(toIdx));
                    } else if (toIdx == 2) {
                        drvSalarySearchModel.setToDistrictCode(toAddrsCodes.get(toIdx));
                    } else if (toIdx == 3) {
                        drvSalarySearchModel.setToCountyCode(toAddrsCodes.get(toIdx));
                    }
                    drvSalarySearchModels.add(drvSalarySearchModel);
                }
            }

            //如果不存在则逐层根据四级地址查找
            for (int idx = drvSalarySearchModels.size() - 1; idx > 0; idx--) {
                costRouteModels = containerDao.listCostRoutes(drvSalarySearchModels.get(idx));
                if (costRouteModels.size() > 0) {
                    break;
                }
            }
        }

        return costRouteModels;
    }

    public List<CostRouteModel> listCostRoutes(String costRouteIds) {
        List<String> costRouteIdList = Arrays.asList(StringUtils.split(costRouteIds, ","));
        return containerDao.listCostRoutesByIds(costRouteIdList);
    }

    /**
     * 运输订单号生成
     *
     * @return
     */
    @Transactional
    private String searchOrderNo() {
        String orderNo = numberingService.getNumber(NumberingService.NUMBER_CODE.ORDER_NO, DateUtils.getYear() + DateUtils.getMonth());
        return orderNo;
    }

    /**
     *  设备位置信息记录管理
     * @param address
     * @param contnNo
     * @param plateNum
     * @param frameCardNo
     */
    private void adrsManage(String address, String contnNo, String plateNum, String frameCardNo) {
        String addressName = containerDao.getZxAdrsNameById(address);
        if (StringUtils.isNotBlank(contnNo)) {
            Contn contn = contnDao.getByContnNo(contnNo);
            if (contn != null) {
                eqpDomain.updateAddress(Constants.ADRS_MODIFY_TABLE_TYPE.CONTN,
                        StringUtils.toString(contn.getId()), addressName,null, false);
            }
        }
        if (StringUtils.isNotBlank(plateNum)) {
            eqpDomain.updateAddress(Constants.ADRS_MODIFY_TABLE_TYPE.TRAILER,
                    plateNum, addressName, null,false);
        }
        if (StringUtils.isNotBlank(frameCardNo)) {
            eqpDomain.updateAddress(Constants.ADRS_MODIFY_TABLE_TYPE.TRUCK_FRAME,
                    frameCardNo, addressName,null, false);
        }
    }

    private void addEqpAdrsHis(ContainerModel model) {
        String address = containerDao.getZxAdrsNameById(model.getToZxAdrs());
        EqpAddressHis eqpAddressHis = new EqpAddressHis();
        eqpAddressHis.setOrderNo(model.getOrderNo());
        eqpAddressHis.setContnNo(model.getContnNo());
        eqpAddressHis.setPlateNum(model.getPlateNum());
        eqpAddressHis.setFrameNum(model.getFrameNum());
        eqpAddressHis.setAddress(address);
        if (StringUtils.isNotBlank(model.getFrameNo())) {
            TruckFrame truckFrame = truckFrameDao.get(StringUtils.toInteger(model.getFrameNo()));
            eqpAddressHis.setFrameCardNo(truckFrame.getFrameCardId());
        }
        eqpAddressHisDao.insert(eqpAddressHis);
    }

    /**
     * 批量修改截箱时间
     * @param model
     * @param oldCrossBoxTime
     * @param oldChangeBoxTime
     */
    private void batchUpdateCrossBoxTime(ContainerModel model, String oldCrossBoxTime, String oldChangeBoxTime) {
        if  (StringUtils.isNotBlank(model.getContnNo()) &&
                (StringUtils.equals(model.getIoType(), Constants.BUSINESS_TYPE.IMPORT) ||
                        StringUtils.equals(model.getIoType(), Constants.BUSINESS_TYPE.MD_BORROW_CONTN) ||
                        StringUtils.equals(model.getIoType(), Constants.BUSINESS_TYPE.MD_EXPORT))) {

            if (!StringUtils.equals(model.getCrossBoxTime(), oldChangeBoxTime)) {
                if (StringUtils.isEmpty(model.getCrossBoxTime())) {
                    model.setCrossBoxTime(null);
                }
                containerDao.batchUpdateCrossBoxTimeByContnNo(model.getContnNo(), model.getCrossBoxTime(), oldCrossBoxTime, UserUtils.getUserId());
            }
            if (!StringUtils.equals(model.getChangeBoxTime(), oldChangeBoxTime)) {
                if (StringUtils.isEmpty(model.getChangeBoxTime())) {
                    model.setChangeBoxTime(null);
                }
                containerDao.batchUpdateChangeBoxTimeByContnNo(model.getContnNo(), model.getChangeBoxTime(), oldChangeBoxTime, UserUtils.getUserId());
            }
        }
    }



    /**
     * 生成路线地址信息
     * @param route
     */
    private void createOrdRouteInfo(ContainerModel route) {
        // 起运地地址
        OrdRouteInfo fromRouteInfo = new OrdRouteInfo();
        fromRouteInfo.setOrderNo(route.getOrderNo());
        fromRouteInfo.setZxAddressId(route.getFromZxAdrs());
        fromRouteInfo.setAddressFull(route.getFromAddressFull());
        fromRouteInfo.setSequence(1);
        fromRouteInfo.setAddressType(PjConstants.ADDRESS_TYPE.ZHD);
        fromRouteInfo.setProvinceCode(route.getFromProvinceCode());
        fromRouteInfo.setCityCode(route.getFromCityCode());
        fromRouteInfo.setDistrictCode(route.getFromDistrictCode());
        fromRouteInfo.setCountyCode(route.getFromCountyCode());
        ordRouteInfoDao.insert(fromRouteInfo);
        // 起运地联系人信息
        String[] fromContactNames = StringUtils.split(route.getFromContactPerson(), ",");
        String[] fromContactPhones = StringUtils.split(route.getFromContactPhone(), ",");
        createOrdRouteInfoContacts(fromRouteInfo.getId(), fromContactNames, fromContactPhones);
        // 到达地
        OrdRouteInfo toRouteInfo = new OrdRouteInfo();
        toRouteInfo.setOrderNo(route.getOrderNo());
        toRouteInfo.setZxAddressId(route.getToZxAdrs());
        toRouteInfo.setAddressFull(route.getToAddressFull());
        toRouteInfo.setSequence(2);
        toRouteInfo.setAddressType(PjConstants.ADDRESS_TYPE.XHD);
        toRouteInfo.setProvinceCode(route.getToProvinceCode());
        toRouteInfo.setCityCode(route.getToCityCode());
        toRouteInfo.setDistrictCode(route.getToDistrictCode());
        toRouteInfo.setCountyCode(route.getToCountyCode());
        ordRouteInfoDao.insert(toRouteInfo);
        // 到达地联系人信息
        String[] toContactNames = StringUtils.split(route.getToContactPerson(), ",");
        String[] toContactPhones = StringUtils.split(route.getToContactPhone(), ",");
        createOrdRouteInfoContacts(toRouteInfo.getId(), toContactNames, toContactPhones);
        // todo 中转
    }

    /**
     * 生成路线联系人信息
     * @param contactNames
     * @param contactPhones
     */
    private void createOrdRouteInfoContacts(long routeInfoId, String[] contactNames, String[] contactPhones) {
        int idx = 0;
        for (String contactName : contactNames) {
            OrdRouteInfoContact contact = new OrdRouteInfoContact();
            contact.setOrdRouteId(routeInfoId);
            contact.setName(contactName);
            if (contactPhones.length > idx) {
                contact.setPhone(contactPhones[idx]);
            }
            contact.setSequence(++idx);
            ordRouteInfoContactDao.insert(contact);
        }
    }

    /**
     * 修改路线地址信息
     * @param route
     */
    private void updateOrdRouteInfo(ContainerModel route) {
        // 删除旧地址数据
        List<OrdRouteInfo> ordRouteInfos = ordRouteInfoDao.listByOrderNo(route.getOrderNo());
        for (OrdRouteInfo routeInfo : ordRouteInfos) {
            ordRouteInfoContactDao.deleteByRouteInfoId(routeInfo.getId());
        }
        ordRouteInfoDao.deleteByOrderNo(route.getOrderNo());
        // 新增新地址数据
        createOrdRouteInfo(route);
    }

    /**
     * 费用提交到队列
     * @param container
     * @param type
     */
    private void expenseSubmit(ContainerModel container, String type) {
        Trailer trailer = trailerDao.get(container.getPlateNum());
        if (trailer != null) {
            container.setTrailerBelongType(trailer.getTrailerBelongType());
            CostRoute costRoute = null;
            if (container.getCostRouteId() > 0) {
                costRoute = expenseDomain.getCostRouteDao().get(container.getCostRouteId());
            } else {
                costRoute = expenseDomain.getCostRouteDao().findByAddress(container);
            }
            if (costRoute != null) {
                container.setAdjKm(costRoute.getDistanceAdjKm());
                container.setStdDrvSalPrice(costRoute.getStdDrvSalPrice());
            }

            if (StringUtils.isNotBlank(trailer.getLiters())) {
                String fuelPriceStr = containerDao.getFuelPrice(container.getDepartureDate());
                container.setAdjKmStr(container.getAdjKm());
                container.setFuelPriceStr(fuelPriceStr);
                container.setLiters(trailer.getLiters());
                container.setTrailerTransportType(trailer.getTransportType());
            }
        }
        expenseDomain.registerOrdExpenseTemp(container, type);
    }



    private void extraWork(ContainerModel model) {
        //小活记录(自有车,挂靠车双轴车拉三轴架补10L油)
        //小活记录修改(1.车架从无到有，新增。2.车架有到无，删除。3.改变车架，判断要新增还是删除)
        ExtraWorkModel extraWorkModel = new ExtraWorkModel();
        extraWorkModel.setOrderNo(model.getOrderNo());
        extraWorkModel = extraWorkDao.getExtraWorkById(extraWorkModel);
        if(StringUtils.isNotBlank(model.getPlateNum())){
            Trailer trailer = trailerDao.get(model.getPlateNum());
            //自有车和挂靠车判定，并且是双轴车
            if(!StringUtils.equals(trailer.getTrailerBelongType(),"2") && StringUtils.equals(trailer.getTWheelType(),"2") && StringUtils.isNotBlank(model.getFrameNo())){
                TruckFrameModel truckFrameModel = truckFrameManDao.findTruckFrameById(Integer.parseInt(model.getFrameNo()));
                //车架属于三排架
                if(StringUtils.equals(truckFrameModel.getFrameTypeId(),"4")){
                    if(extraWorkModel != null && StringUtils.isNotBlank(extraWorkModel.getId())){
                        updateExtraWork(model,extraWorkModel);
                    }else{
                        insertExtraWork(model);
                    }
                }else{
                    if(extraWorkModel != null && StringUtils.isNotBlank(extraWorkModel.getId())){
                        deleteExtraWork(extraWorkModel);
                    }
                }
            }else{
                if(extraWorkModel != null && StringUtils.isNotBlank(extraWorkModel.getId())){
                    deleteExtraWork(extraWorkModel);
                }
            }
        }else{
            if(extraWorkModel != null && StringUtils.isNotBlank(extraWorkModel.getId())){
                deleteExtraWork(extraWorkModel);
            }
        }
    }

    //插入小活记录，三排架补油
    private void insertExtraWork(ContainerModel model) {
        ExtraWorkModel extraWorkModel = new ExtraWorkModel();
        extraWorkModel.setCreateBy(model.getUserId());
        extraWorkModel.setOccurDate(model.getDepartureDate());
        extraWorkModel.setDriverCode(model.getDriverCode());
        extraWorkModel.setExtraWorkId("1");
        extraWorkModel.setExtraWorkOilPatch("10");
        extraWorkModel.setPlateNum(model.getPlateNum());
        extraWorkModel.setFrameId(model.getFrameNo());
        extraWorkModel.setOrderNo(model.getOrderNo());
        extraWorkModel.setSystemAutoFlag("Y");
        extraWorkDao.addExtraWork(extraWorkModel);
    }

    //更新小活记录，三排架补油
    private void updateExtraWork(ContainerModel model,ExtraWorkModel extraWorkModel) {
        extraWorkModel.setUpdateBy(model.getUserId());
        extraWorkModel.setOccurDate(model.getDepartureDate());
        extraWorkModel.setDriverCode(model.getDriverCode());
        extraWorkModel.setPlateNum(model.getPlateNum());
        extraWorkModel.setFrameId(model.getFrameNo());
        extraWorkModel.setOrderNo(model.getOrderNo());
        extraWorkDao.eidtExtraWork(extraWorkModel);
    }

    //删除小活记录
    private void deleteExtraWork(ExtraWorkModel extraWorkModel) {
        extraWorkDao.deleteExtraWork(extraWorkModel);
    }

    private void addStdAddrsCode(List<String> stdAddrsCodes, String stdAddrsCode) {
        if (StringUtils.isNotBlank(stdAddrsCode)) {
            stdAddrsCodes.add(stdAddrsCode);
        }
    }
}
