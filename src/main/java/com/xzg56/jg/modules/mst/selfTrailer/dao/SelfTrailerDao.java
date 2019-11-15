package com.xzg56.jg.modules.mst.selfTrailer.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.mst.selfTrailer.model.SelfTrailerModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface SelfTrailerDao extends BaseDao<SelfTrailerModel> {
    List<SelfTrailerModel> findMstTrailerList(SelfTrailerModel elfTrailerModel);
    SelfTrailerModel findMstTrailerByPlateNum(@Param("plateNum") String plateNum);
    Integer insertSelfTrailer(SelfTrailerModel elfTrailerModel);
    Integer updateSelfTrailer(SelfTrailerModel elfTrailerModel);
    Integer deleteSelfTrailer(@Param("plateNums") String plateNums);
    void unBindTrailerByDrvCode(@Param("driverCode") String driverCode, @Param("userId") String userId);
}
