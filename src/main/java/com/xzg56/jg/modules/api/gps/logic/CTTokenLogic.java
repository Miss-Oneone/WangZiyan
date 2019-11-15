package com.xzg56.jg.modules.api.gps.logic;

import com.alibaba.fastjson.JSONObject;
import com.xzg56.common.module.sys.persistence.dao.DictDao;
import com.xzg56.common.module.sys.persistence.entity.Dict;
import com.xzg56.common.utils.DictUtils;
import com.xzg56.core.exception.ValidationException;
import com.xzg56.core.utils.SpringContextHolder;
import com.xzg56.core.utils.WebServiceUtil;
import com.xzg56.utility.DateUtils;
import com.xzg56.utility.StringUtils;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * 电信token处理逻辑
 * Created by wellen on 2019/6/14.
 */


public class CTTokenLogic {

    private static DictDao dictDao = SpringContextHolder.getBean(DictDao.class);

    // token有效时间(分钟)
    private static final long EFFECTIVE_TIME = 25;
    private String token;
    private Date expireTime;
    private static CTTokenLogic ctToken = new CTTokenLogic();

    private CTTokenLogic() {

    }

    public static CTTokenLogic getInstance() {
        return ctToken;
    }

    public synchronized String getToken() {
        if (StringUtils.isBlank(token) || DateUtils.getNow().compareTo(expireTime) > 0) {
            JSONObject loginJson = login();

            token = loginJson.getJSONObject("DATA").getString("USERID");
            expireTime = DateUtils.addMinute(new Date(), EFFECTIVE_TIME);
        }

        return token;
    }

    public synchronized String refreshToken() {
        JSONObject loginJson = login();

        token = loginJson.getJSONObject("DATA").getString("USERID");
        expireTime = DateUtils.addMinute(new Date(), EFFECTIVE_TIME);

        return token;
    }

    private JSONObject login() {
        String loginMsg = doLogin();
        JSONObject loginJson = JSONObject.parseObject(loginMsg);

        if (!StringUtils.equals(loginJson.getString("RET"), "0")) {
            throw new ValidationException(loginJson.getString("MSG"));
        }

        return loginJson;
    }

    /**
     * 登录（电信）
     * @return
     */
    private static String doLogin() {
        LinkedHashMap<String, String> wsMap = getWsParamMap("CTCC_NP_LOGIN_PARAM");
        LinkedHashMap<String, String> restfulMap = setPhoneLoginPars(wsMap);
        return WebServiceUtil.callRestfulWebService(restfulMap);
    }

    /**
     * 获取登录请求参数（电信）
     * @return
     */
    private static LinkedHashMap<String, String> getWsParamMap(String type) {
        List<Dict> dictList = DictUtils.getDictList(type);
        LinkedHashMap<String,String> map = new LinkedHashMap<String, String>();
        for(Dict d : dictList){
            map.put(d.getLabel(), d.getValue());
        }

        return map;
    }

    private static LinkedHashMap<String, String> setPhoneLoginPars(LinkedHashMap<String,String> map) {
        LinkedHashMap<String, String> restfulMap = new LinkedHashMap<String, String>();
        restfulMap.put("URL", map.get("URL"));
        net.sf.json.JSONObject parasJson = new net.sf.json.JSONObject();
        parasJson.put("USERNAME", map.get("USERNAME"));
        parasJson.put("PASSWORD", map.get("PASSWORD"));
        parasJson.put("BDTOKENID", map.get("BDTOKENID"));
        parasJson.put("BDCHANNELID", map.get("BDCHANNELID"));
        parasJson.put("MOBILEOS", map.get("MOBILEOS"));
        parasJson.put("USERTYPE", map.get("USERTYPE"));
        restfulMap.put("PARAS", parasJson.toString());

        return restfulMap;
    }

    public static void main(String[] args) throws InterruptedException {
        for (int i=0; i<1000; i++) {
            CTTokenLogic c = CTTokenLogic.getInstance();
            Thread.sleep(1000);
            Thread thread1 = new Thread(new Runnable() {
                public void run() {
                    String token = c.refreshToken();
                    System.out.println(DateUtils.getDateTime() + "--------" + token);
                }
            });
            Thread thread2 = new Thread(new Runnable() {
                public void run() {
                    String token = c.getToken();
                    System.out.println(DateUtils.getDateTime() + "--------" + token);
                }
            });
            if (i%12 == 0) {

                thread1.start();
            } else {

                thread2.start();
            }
        }
    }
}
