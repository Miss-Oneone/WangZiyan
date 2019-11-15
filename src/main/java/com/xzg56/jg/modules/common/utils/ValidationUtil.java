package com.xzg56.jg.modules.common.utils;

import com.xzg56.core.exception.ValidationException;
import com.xzg56.utility.StringUtils;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author zhoushengping
 * @date 2019/6/26
 */
public class ValidationUtil {

    public static void phoneJudge(List<String> list){
        String regExp = "^((13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8})|(0[0-9]{2,3})-(\\d{7,8})|(0[0-9]{2,3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})$";
        Pattern pattern = Pattern.compile(regExp);
        for (String string: list){
            String phone = string.replace(" ","");
            StringBuffer sb = new StringBuffer();
            for (int i=0; i< phone.length(); i++) {
                if (phone.charAt(i) == '-') {
                    sb.append(phone.charAt(i));
                    continue;
                }
                if (Character.isDigit(phone.charAt(i))) {
                    sb.append(phone.charAt(i));
                }
            }
            phone = sb.toString();
            String phoneFlag = phone.replace("-","");
            int num = phoneFlag.length();
            Matcher matcher ;
            if (!StringUtils.isBlank(phone)){
                if(phone.length()>=6){
                    String a = phoneFlag.substring(0,1);
                    if (num == 11 && StringUtils.equals(a,"1")){
                        matcher = pattern.matcher(phoneFlag);
                    }else {
                        matcher = pattern.matcher(phone);
                    }
                    if(!matcher.matches()){
                        if(num != 11 || !StringUtils.equals(a,"1")){
                            throw new ValidationException(string+":电话号码格式不正确,正确格式：区号-电话号码，例如：0591-63339570");
                        }else {
                            throw new ValidationException("电话号码格式不正确：" + string);
                        }
                    }
                }else {
                    throw new ValidationException("电话号码格式不正确：" + string);
                }
            }
        }
    }
}
