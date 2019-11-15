package com.xzg56.jg.modules.mst.selfTrailer.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xzg56.core.constants.GlobalConstants;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.service.BaseService;
import com.xzg56.core.utils.UserUtils;
import com.xzg56.finance.common.constants.BizFcConstants;
import com.xzg56.jg.modules.common.constant.ApiConstant;
import com.xzg56.jg.modules.common.constant.Constants;
import com.xzg56.jg.modules.mst.selfTrailer.dao.SelfTrailerDao;
import com.xzg56.jg.modules.mst.selfTrailer.model.SelfTrailerModel;
import com.xzg56.utility.HttpUtils;
import com.xzg56.utility.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true)
public class SelfTrailerService extends BaseService {

    @Resource
    private SelfTrailerDao selfTrailerDao;

    public List<SelfTrailerModel> findMstTrailerList(SelfTrailerModel selfTrailerModel) {
        List<SelfTrailerModel> selfTrailerModelList = selfTrailerDao.findMstTrailerList(selfTrailerModel);
        return selfTrailerModelList;
    }

    public SelfTrailerModel findMstTrailerByPlateNum(String plateNum) {
        SelfTrailerModel selfTrailerModel = selfTrailerDao.findMstTrailerByPlateNum(plateNum);
        return selfTrailerModel;
    }

    @Transactional(readOnly = false)
    public void saveSelfTrailer(SelfTrailerModel selfTrailerModel, String pageType) {
        SelfTrailerModel selfTrailer = findMstTrailerByPlateNum(selfTrailerModel.getPlateNum());
        if (BizFcConstants.PAGE_TYPE.CREATE.equals(pageType)) {
            if(selfTrailer != null) {
                throw new ValidationException("系统中已存在该车辆信息！");
            } else {
                selfTrailerModel.setCreatePsn(UserUtils.getUserId());
                if (StringUtils.isBlank(selfTrailerModel.getValidFlag())) {
                    selfTrailerModel.setValidFlag("Y");
                }
                if (StringUtils.equals(Constants.TRAILER_BELONG_TYPE.ATTACH, selfTrailerModel.getTrailerBelongType())) {
                    selfTrailerModel.setAttachDrvCode(selfTrailerModel.getRelatedDrvCode());
                }
                if (StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OUTER, selfTrailerModel.getTrailerBelongType())) {
                    selfTrailerModel.setOuterDrvCode(selfTrailerModel.getRelatedDrvCode());
                }
                // 换车处理，如果当前司机之前有绑定车辆，需要解绑(外排和挂靠除外)
                if (StringUtils.isNotBlank(selfTrailerModel.getCurrentDrvCode()) && StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OWN, selfTrailerModel.getTrailerBelongType())) {
                    selfTrailerDao.unBindTrailerByDrvCode(selfTrailerModel.getCurrentDrvCode(), UserUtils.getUserId());
                }
                selfTrailerDao.insertSelfTrailer(selfTrailerModel);
                if (StringUtils.equals(selfTrailerModel.getValidFlag(), GlobalConstants.YES) &&
                        !StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OUTER, selfTrailerModel.getTrailerBelongType())){
                    //新增GPS车辆
                    this.insertGpsCar(selfTrailerModel.getPlateNum(), selfTrailerModel.getGpsPlateNum());
                }
            }
        } else if (BizFcConstants.PAGE_TYPE.EDIT.equals(pageType)) {
            if(selfTrailer == null) {
                throw new ValidationException("该车辆信息不存在，请刷新后重试！");
            } else {
                selfTrailerModel.setUpdatePsn(UserUtils.getUserId());
                if (StringUtils.isBlank(selfTrailerModel.getValidFlag())) {
                    selfTrailerModel.setValidFlag("Y");
                }
                if (StringUtils.equals(Constants.TRAILER_BELONG_TYPE.ATTACH, selfTrailerModel.getTrailerBelongType())) {
                    selfTrailerModel.setAttachDrvCode(selfTrailerModel.getRelatedDrvCode());
                }
                if (StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OUTER, selfTrailerModel.getTrailerBelongType())) {
                    selfTrailerModel.setOuterDrvCode(selfTrailerModel.getRelatedDrvCode());
                }
                // 换车处理,现有车辆当前司机变为新司机，如果新司机之前有绑定车辆，需要解绑
                if (!StringUtils.equals(selfTrailer.getCurrentDrvCode(), selfTrailerModel.getCurrentDrvCode())
                        && StringUtils.isNotBlank(selfTrailerModel.getCurrentDrvCode())
                        && StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OWN, selfTrailerModel.getTrailerBelongType())) {
                    selfTrailerDao.unBindTrailerByDrvCode(selfTrailerModel.getCurrentDrvCode(), UserUtils.getUserId());
                }
                selfTrailerDao.updateSelfTrailer(selfTrailerModel);
                if ((StringUtils.equals(selfTrailerModel.getValidFlag(), GlobalConstants.NO) &&
                        !StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OUTER, selfTrailerModel.getTrailerBelongType())) || (
                    StringUtils.equals(selfTrailerModel.getValidFlag(), GlobalConstants.YES) &&
                            StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OUTER, selfTrailerModel.getTrailerBelongType()) &&
                            !StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OUTER, selfTrailer.getTrailerBelongType())
                    )) {
                    String plateNums = selfTrailerModel.getPlateNum();
                   this.deleteGpsCar(plateNums);
                }
                if (StringUtils.equals(selfTrailerModel.getValidFlag(), GlobalConstants.YES) &&
                        (StringUtils.equals(selfTrailer.getValidFlag(), GlobalConstants.NO) ||
                        StringUtils.equals(selfTrailer.getTrailerBelongType(),Constants.TRAILER_BELONG_TYPE.OUTER)) &&
                        !StringUtils.equals(Constants.TRAILER_BELONG_TYPE.OUTER, selfTrailerModel.getTrailerBelongType())) {
                    //新增GPS车辆
                    this.insertGpsCar(selfTrailerModel.getPlateNum(), selfTrailerModel.getGpsPlateNum());
                }
            }
        }
    }

    @Transactional(readOnly = false)
    public void deleteSelfTrailer(String plateNums) {
        selfTrailerDao.deleteSelfTrailer(plateNums);
        this.deleteGpsCar(plateNums);
    }

    //删除GPS车辆
    private void deleteGpsCar(String plateNums) {
        String url = ApiConstant.GPS_INTERFACE.DELETE_M_T;
        Map<String, String> map = new HashMap<>();
        map.put("plateNum", plateNums);
        map.put("compyCode", "020");
        map.put("userId", UserUtils.getUserId());
        String resultStr = HttpUtils.post(url, map, ApiConstant.GPS_SERVICE_APIKEY);
        JSONObject resultJson = JSON.parseObject(resultStr);
        String code = resultJson.getString("code");

        if (StringUtils.equals(code,"-1")) {
            throw new ValidationException("删除GPS车辆出错！");
        }
    }

    //新增GPS车辆
    private void insertGpsCar(String plateNum, String gpsPlateNum) {
        gpsPlateNum = StringUtils.isBlank(gpsPlateNum) ? plateNum : gpsPlateNum;
        String url = ApiConstant.GPS_INTERFACE.INSERT_M_T;
        Map<String, String> map = new HashMap<>();
        map.put("plateNum", plateNum);
        map.put("gpsPlateNum", gpsPlateNum);
        map.put("compyCode", "020");
        map.put("userId", UserUtils.getUserId());
        String resultStr = HttpUtils.post(url, map, ApiConstant.GPS_SERVICE_APIKEY);
        JSONObject resultJson = JSON.parseObject(resultStr);
        String code = resultJson.getString("code");

        if (StringUtils.equals(code, "-1")) {
            throw new ValidationException("新增GPS车辆出错！");
        }
    }
}
