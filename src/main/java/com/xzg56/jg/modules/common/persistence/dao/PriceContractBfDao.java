package com.xzg56.jg.modules.common.persistence.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractBf;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisDao
public interface PriceContractBfDao extends BaseDao<PriceContractBf> {

    PriceContractBf get(@Param("id") long id);

    List<PriceContractBf> findPriceContract(PriceContractBf priceContractBf);// todo

    /**
     * 批量新增价格协议
     */
    void batchInsert(List<PriceContractBf> priceContractBfs);

    void deletePriceContractBf(@Param("priceContractNo") String priceContractNo);
}
