package com.xzg56.finance.driverssalary.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/5/28.
 */

@Getter
@Setter
public class DriversSalarySearchModel extends IdEntity<DriversSalarySearchModel> {
    private String salaryMonth;
    private String driverCode;
    private String driverName;
}
