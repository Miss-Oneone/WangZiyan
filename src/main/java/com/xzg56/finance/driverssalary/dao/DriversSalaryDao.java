package com.xzg56.finance.driverssalary.dao;

import com.xzg56.core.persistence.annotation.MyBatisDao;
import com.xzg56.finance.driverssalary.model.DriversSalaryDetailModel;
import com.xzg56.finance.driverssalary.model.DriversSalaryModel;
import com.xzg56.finance.driverssalary.model.DriversSalarySearchModel;

import java.util.List;
import java.util.Map;

/**
 * Created by wellen on 2019/5/28.
 */

@MyBatisDao
public interface DriversSalaryDao {
    List<DriversSalaryModel> listDriversSalarys(DriversSalarySearchModel salarySearchModel);

    List<DriversSalaryModel> listSalaryAdditionals(Map<String, Object> params);

    DriversSalaryModel findDriverAddtionInfo(DriversSalarySearchModel driversSalaryModel);

    List<DriversSalaryDetailModel> searchDetail(DriversSalarySearchModel salarySearchModel);

    List<DriversSalaryDetailModel> searchOilAndKmList(DriversSalarySearchModel salarySearchModel);

    String searchOilMassAdjust(DriversSalarySearchModel salarySearchModel);

    DriversSalaryModel searchDriversSalaryAdditional(DriversSalarySearchModel salarySearchModel);

    String findDriverName(String driverCode);

    String searchExtraWorkSubsidy(DriversSalarySearchModel salarySearchModel);
}
