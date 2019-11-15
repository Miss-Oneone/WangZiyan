package com.xzg56.jg.modules.mst.zxaddress.service;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.domain.IPriceContractDomain;
import com.xzg56.jg.modules.common.persistence.entity.ZxAddress;
import com.xzg56.jg.modules.common.utils.ValidationUtil;
import com.xzg56.jg.modules.mst.zxaddress.dao.ZxAddressManDao;
import com.xzg56.jg.modules.mst.zxaddress.model.ZxAddressModel;
import com.xzg56.jg.modules.mst.zxaddress.model.ZxAddressSearchModel;
import com.xzg56.utility.StringUtils;
import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections.comparators.ComparableComparator;
import org.apache.commons.collections.comparators.ComparatorChain;
import org.apache.commons.collections.comparators.NullComparator;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@SuppressWarnings("all")
@Service("ZxAddressService")
@Transactional(readOnly = true)
public class ZxAddressService extends BaseService {
    @Resource
    private ZxAddressManDao zxAddressManDao;

    @Resource
    private IPriceContractDomain priceContractDomain;

    @Transactional(readOnly = false)
    public List<ZxAddressModel> getZxAddressList(ZxAddressSearchModel searchModel) {
        return zxAddressManDao.getZxAddressList(searchModel);
    }

    public ZxAddressModel getZxAddressDetail(String id) {
        return zxAddressManDao.getZxAddrsDetail(id);
    }

    @Transactional(readOnly = false)
    public void doSave(ZxAddressModel addressModel) {
        ZxAddress zxAddress = new ZxAddress();
        transformAddress(addressModel, zxAddress);

        priceContractDomain.registerZxAddress(zxAddress);
    }

    @Transactional(readOnly = false)
    public void doUpdate(ZxAddressModel addressModel) {
        ZxAddress zxAddress = priceContractDomain.getZxAddressDao().get(StringUtils.toLong(addressModel.getId()));
        transformAddress(addressModel, zxAddress);
        if (zxAddress == null) {
            throw new ValidationException("当前地址不存在或已被删除.");
        }

        priceContractDomain.modifyZxAdress(zxAddress);
    }

    private void transformAddress(ZxAddressModel addressModel, ZxAddress zxAddress) {
        List<String> telList = new ArrayList<>();
        telList.add(addressModel.getContactPhone());
        telList.add(addressModel.getContactPhone2());
        telList.add(addressModel.getContactPhone3());
        ValidationUtil.phoneJudge(telList);

        zxAddress.setName(addressModel.getName());
        zxAddress.setProvinceCode(addressModel.getProvinceCode());
        zxAddress.setCityCode(addressModel.getCityCode());
        zxAddress.setDistrictCode(addressModel.getDistrictCode());
        zxAddress.setCountyCode(addressModel.getCountyCode());
        zxAddress.setAddress(addressModel.getAddress());
        zxAddress.setContactPerson(addressModel.getContactPerson());
        zxAddress.setContactPhone(addressModel.getContactPhone());
        zxAddress.setContactPerson2(addressModel.getContactPerson2());
        zxAddress.setContactPhone2(addressModel.getContactPhone2());
        zxAddress.setContactPerson3(addressModel.getContactPerson3());
        zxAddress.setContactPhone3(addressModel.getContactPhone3());
        zxAddress.setRelatedCompyCode(addressModel.getRelatedCompyCode());
    }

    //带有三个条件的集合排序方法
    private List sort(List list, String[] fields) throws IllegalArgumentException {
        boolean[] reverses = new boolean[fields.length];

        if (list == null || list.size() == 0) {
            return list;
        }

        if (fields == null) {
            throw new IllegalArgumentException("fields is null.");
        }

        if (reverses == null) {
            throw new IllegalArgumentException("reverses is null.");
        }

        if (fields.length != reverses.length) {
            throw new IllegalArgumentException("The size of fields and reverses is not in agreement.");
        }

        if (fields.length == 0) {
            return list;
        }

        ComparatorChain cc = new ComparatorChain();

        for (int i = 0; fields != null && i < fields.length; i++) {

            String  field   = fields[i];
            boolean reverse = reverses[i];

            if (field.trim().length() == 0) {
                continue;
            }

            cc.addComparator(
                    new BeanComparator(
                            field,
                            new NullComparator(ComparableComparator.getInstance())),
                    reverse);
        }

        if (cc.size() != 0) {
            Collections.sort(list, cc);
        }

        return list;
    }


//    //增加地址
//    @Transactional(readOnly = false)
//    public String addressAdd(MstZxAddress mstZxAddress,String priceContractBfIdList,String priceContractLclBfIdList,String costOutContractBfIdList,String mstCostRouteIdList){
//            List<String> telList = new ArrayList<>();
//
//            telList.add(mstZxAddress.getContactPhone());
//            telList.add(mstZxAddress.getContactPhone2());
//            telList.add(mstZxAddress.getContactPhone3());
//            telValidateLogic.phoneJudge(telList);
//        if(!StringUtils.isBlank(mstZxAddress.getContactPhone())){
//            String phone = mstZxAddress.getContactPhone().replace(" ","");
//            //String phoneFlag = phone.replace("-","");
//            mstZxAddress.setContactPhone(phone);
//        }
//        if(!StringUtils.isBlank(mstZxAddress.getContactPhone2())){
//            String phone = mstZxAddress.getContactPhone2().replace(" ","");
//            //String phoneFlag = phone.replace("-","");
//            mstZxAddress.setContactPhone2(phone);
//        }
//
//        if(!StringUtils.isBlank(mstZxAddress.getContactPhone3())){
//            String phone = mstZxAddress.getContactPhone3().replace(" ","");
//            //String phoneFlag = phone.replace("-","");
//            mstZxAddress.setContactPhone3(phone);
//        }
//            //this.phoneJudge(mstZxAddress);
//            ZxAddressModel zxAddressModel = new ZxAddressModel();
//            List<ZxAddressModel> list = zxAddressDao.getZxAddressList(zxAddressModel);
//            for (ZxAddressModel model: list){
//                if (StringUtils.equals(model.getName(),mstZxAddress.getName())){
//                    throw new ValidationException("<"+mstZxAddress.getName()+">"+"装卸地址名称已存在！");
//                }
//            }
//        if (StringUtils.isBlank(mstZxAddress.getCountyCode())){
//            mstZxAddress.setCountyCode(null);
//        }
//        if (StringUtils.isBlank(mstZxAddress.getDistrictCode())){
//            mstZxAddress.setDistrictCode(null);
//        }
//            String mstZxAddressId = StringUtils.toString(addressDomain.mstZxAddressRegister(mstZxAddress));
//            this.specialContract(mstZxAddressId,priceContractBfIdList,priceContractLclBfIdList,costOutContractBfIdList,mstCostRouteIdList);
//            return mstZxAddressId;
//    }
//
//    public MstZxAddress mstZxAddressSelect(MstZxAddress mstZxAddress){
//        return addressDomain.mstZxAddressSelect(mstZxAddress);
//    }
//
//    //保存地址修改
//    @Transactional(readOnly = false)
//    public void saveAddress(ZxAddressModel zxAddressModel,String priceContractBfIdList,String priceContractLclBfIdList,String costOutContractBfIdList,String mstCostRouteIdList) {
//        List<String> list = new ArrayList<>();
//        String id = zxAddressModel.getZxdId();
//        MstZxAddress mstZxAddress = new MstZxAddress();
//
//        mstZxAddress.setName(zxAddressModel.getName());
//        mstZxAddress.setProvinceCode(zxAddressModel.getProvinceCode());
//        mstZxAddress.setCityCode(zxAddressModel.getCityCode());
//        if (StringUtils.isBlank(zxAddressModel.getDistrictCode())){
//            mstZxAddress.setDistrictCode(null);
//        }else {
//            mstZxAddress.setDistrictCode(zxAddressModel.getDistrictCode());
//        }
//        if (StringUtils.isBlank(zxAddressModel.getCountyCode())){
//            mstZxAddress.setCountyCode(null);
//        }else {
//            mstZxAddress.setCountyCode(zxAddressModel.getCountyCode());
//        }
//        mstZxAddress.setAddress(zxAddressModel.getAddress());
//        mstZxAddress.setContactPerson(zxAddressModel.getContactPerson());
//        mstZxAddress.setContactPerson2(zxAddressModel.getContactPerson2());
//        mstZxAddress.setContactPerson3(zxAddressModel.getContactPerson3());
//        mstZxAddress.setContactPhone(zxAddressModel.getContactPhone());
//        mstZxAddress.setContactPhone2(zxAddressModel.getContactPhone2());
//        mstZxAddress.setContactPhone3(zxAddressModel.getContactPhone3());
//
//            mstZxAddress.setId(StringUtils.toLong(id));
//            mstZxAddress.setDeletedflag("N");
//            list.add(mstZxAddress.getContactPhone());
//            list.add(mstZxAddress.getContactPhone2());
//            list.add(mstZxAddress.getContactPhone3());
//            telValidateLogic.phoneJudge(list);
//        if(!StringUtils.isBlank(mstZxAddress.getContactPhone())){
//            String phone = mstZxAddress.getContactPhone().replace(" ","");
//            //String phoneFlag = phone.replace("-","");
//            mstZxAddress.setContactPhone(phone);
//        }
//        if(!StringUtils.isBlank(mstZxAddress.getContactPhone2())){
//            String phone = mstZxAddress.getContactPhone2().replace(" ","");
//            //String phoneFlag = phone.replace("-","");
//            mstZxAddress.setContactPhone2(phone);
//        }
//
//        if(!StringUtils.isBlank(mstZxAddress.getContactPhone3())){
//            String phone = mstZxAddress.getContactPhone3().replace(" ","");
//            //String phoneFlag = phone.replace("-","");
//            mstZxAddress.setContactPhone3(phone);
//        }
//            //this.phoneJudge(mstZxAddress);
//            addressDomain.updateMstZxAddress(mstZxAddress);
//            addressDomain.deleteContractBfAddress(id);
//            addressDomain.deleteContractLclbfAddress(id);
//            addressDomain.deleteCostOutContractBfAddress(id);
//            addressDomain.deleteMstCostRouteAddress(id);
//            this.specialContract(id,priceContractBfIdList,priceContractLclBfIdList,costOutContractBfIdList,mstCostRouteIdList);
//    }

    //地址删除
    @Transactional(readOnly = false)
    public void deleteAddressList(List<Long> ids){
        for (Long id : ids) {
            priceContractDomain.deleteZxAddress(id);
        }
    }
}
