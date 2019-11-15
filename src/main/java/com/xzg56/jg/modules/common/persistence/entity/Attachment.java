package com.xzg56.jg.modules.common.persistence.entity;

import com.xzg56.core.persistence.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by zhuyi on 2019/6/27.
 */
@Getter
@Setter
@Table(name = "attachment")
public class Attachment extends IdEntity<Attachment> {

    @Column(name = "URL")
    private String url;//名称

    @Column(name = "NAME")
    private String name;//省
}
