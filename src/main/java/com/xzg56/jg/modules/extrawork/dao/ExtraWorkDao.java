package com.xzg56.jg.modules.extrawork.dao;


import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.core.persistence.basecrud.BaseDao;
import com.xzg56.jg.modules.extrawork.model.ExtraWorkModel;
import com.xzg56.jg.modules.extrawork.model.ExtraWorkSearchModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by wzr on 2019/10/22.
 */
@MyBatisDao
public interface ExtraWorkDao extends BaseDao {

    List<ExtraWorkModel> getExtraWorkModelList(ExtraWorkSearchModel extraWorkSearchModel);

    List<ExtraWorkModel> searchExtraWorkPriceItem();

    ExtraWorkModel getExtraWorkById(ExtraWorkModel extraWorkModel);

    String searchPlateNumLiters(String plateNum);

    ExtraWorkModel searchExtraWorkPrice(@Param("id")String id);

    void addExtraWork(ExtraWorkModel extraWorkModel);

    void eidtExtraWork(ExtraWorkModel extraWorkModel);

    void deleteExtraWork(ExtraWorkModel extraWorkModel);

    ExtraWorkModel getAmount(ExtraWorkSearchModel extraWorkSearchModel);
}
