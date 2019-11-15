package com.xzg56.jg.modules.mst.contn.model;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

/**
 * Created by wellen on 2019/4/3.
 */

@Getter
@Setter
public class ContnSearchModel extends IdEntity<ContnSearchModel> {
    private String contnNo;
    private String contnType;
    private String activeFlag;
    private String contnOwnerId;
    private String specialContnType;
}
