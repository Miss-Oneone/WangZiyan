package com.xzg56.jg.modules.finance.expense.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmSearchModel extends IdEntity<EmSearchModel> {
	private static final long serialVersionUID = 1795533270091310196L;

	private String recPayId;
	private String orderNo;
	private String paymentType;
	private String feeType;
	private String orderNosKey;
}
