package com.xzg56.jg.modules.common.domain;

import com.xzg56.jg.modules.common.persistence.dao.ZxAddressDao;
import com.xzg56.jg.modules.common.persistence.entity.PriceContract;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractBf;
import com.xzg56.jg.modules.common.persistence.entity.PriceContractCus;
import com.xzg56.jg.modules.common.persistence.entity.ZxAddress;

import java.util.LinkedHashMap;

public interface IPriceContractDomain {

    void deleteContractBf(long id);

    void registerPriceContractBf(PriceContractBf priceContractBf);

    void modifyPriceContractBf(PriceContractBf priceContractBf);

    PriceContractBf getPriceContractBf(Long id);

    LinkedHashMap getOrdGroupInputListByCusCode();

    LinkedHashMap getOrdGroupInputListByPriceContractNo();

    String getPriceContractNoNum();

    void registerPriceContract(PriceContract priceContract);

    void modifyPriceContract(PriceContract priceContract);

    void delete(String priceContractNo);

    void registerPriceContractCus(PriceContractCus priceContractCus);

    void modifyPriceContractCus(PriceContractCus priceContractCus);

    void registerZxAddress(ZxAddress zxAddress);

    void modifyZxAdress(ZxAddress zxAddress);

    void deleteZxAddress(long id);

    ZxAddressDao getZxAddressDao();
}
