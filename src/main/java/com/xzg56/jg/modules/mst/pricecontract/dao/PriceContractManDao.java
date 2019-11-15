package com.xzg56.jg.modules.mst.pricecontract.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.finance.common.model.PriceContractTransModel;
import com.xzg56.jg.modules.mst.pricecontract.model.PriceContractBfModel;
import com.xzg56.jg.modules.mst.pricecontract.model.PriceContractCusModel;
import com.xzg56.jg.modules.mst.pricecontract.model.PriceContractModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by wellen on 2019/5/7.
 */

@MyBatisDao
public interface PriceContractManDao {
    List<PriceContractTransModel> getOrdGroupInputListByCusCode();

    List<PriceContractTransModel> getOrdGroupInputListByPriceContractNo();

    List<PriceContractBfModel> getPriceContractBfList(PriceContractBfModel priceContractBfModel);

    List<PriceContractBfModel> getName(@Param("pcode") String pcode);

    PriceContractModel getPriceContractInfo(PriceContractModel priceContractModel);

    PriceContractBfModel checkInfo(PriceContractBfModel priceContractBfModel);

    List<Map<String,String>> getPriceContractMapList(PriceContractBfModel priceContractBfModel);

    String getPriceContractNoEffectiveStatus(String priceContractNo);

    List<PriceContractModel> getPriceContractList(PriceContractModel priceContractModel);

    List<PriceContractCusModel> getPriceContractCusList(PriceContractCusModel mstPriceContractCusModel);
}
