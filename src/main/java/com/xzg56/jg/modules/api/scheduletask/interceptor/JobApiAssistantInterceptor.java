package com.xzg56.jg.modules.api.scheduletask.interceptor;


import com.xzg56.core.service.BaseService;
import com.xzg56.jg.modules.common.constant.JobApiConstant;
import com.xzg56.utility.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by zxp on 2019/1/3.
 */

public class JobApiAssistantInterceptor extends BaseService implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 接口调用鉴权
        String apikey = request.getHeader("apikey");
        if (StringUtils.isBlank(apikey) || !StringUtils.equals(JobApiConstant.API_KEY, apikey)) {
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}
