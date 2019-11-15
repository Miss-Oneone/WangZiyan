package com.xzg56.jg.modules.helper.common;

import com.xzg56.common.utils.CommonHelper;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class SelectJgUtils {
	public static String getOptionList(String funName, String parameter) {
		String jsonStr = "";
		Class<CommonJgHelper> helperCls = CommonJgHelper.class;
		try {
			Object helper = helperCls.newInstance();
			@SuppressWarnings("rawtypes")
			Class[] param = new Class[1];
			param[0] = String.class;
			Method med = helperCls.getMethod(funName, param);
			Object returnObj = med.invoke(helper, parameter);
			jsonStr = String.valueOf(returnObj);
		} catch (InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return jsonStr;
	}
}
