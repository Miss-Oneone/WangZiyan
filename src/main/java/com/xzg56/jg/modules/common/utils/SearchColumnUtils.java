/**
 * 
 */
package com.xzg56.jg.modules.common.utils;

import com.xzg56.utility.DateUtils;
import com.xzg56.utility.Reflections;
import org.apache.commons.lang.StringUtils;
import org.springframework.ui.Model;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.util.Date;

/**
 * @author zxl
 *
 */
public class SearchColumnUtils {
	
	private static String[] parsePatterns = { "yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", 
			"yyyy/MM/dd", "yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm" };
	
	public static void setColumns(Object ob, String selectValue){
		String[] values = selectValue.split(";");
		for(int i=0; i<values.length; i++){
			if(values[i].split(":").length > 1){
				Class conClass = ob.getClass();
				PropertyDescriptor pd;
				try {
					pd = new PropertyDescriptor(values[i].split(":")[0], conClass);
					Method method = pd.getWriteMethod();
					if (StringUtils.equalsIgnoreCase("true", values[i].split(":")[1])) {
						method.invoke(ob, Boolean.valueOf("true"));
					} else if (StringUtils.equalsIgnoreCase("false", values[i].split(":")[1])) {
						method.invoke(ob, Boolean.valueOf("false"));
					} else {
						method.invoke(ob, values[i].split(":")[1]);
					}
				} catch (IntrospectionException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
				
			}
		}
	}
	
	public static void setColumns(Object ob, String selectValue, Class<?> targetClass, Model model){
		String[] values = selectValue.split(";");
		for(int i=0; i<values.length; i++){
			if(values[i].split(":").length > 1){
				try {
					Object val = values[i].split(":")[1];
					
					Field[] fields= targetClass.getDeclaredFields();
					for(Field f : fields){
						if(f.getName().indexOf(values[i].split(":")[0])<0) continue;
						Class<?> valType = f.getType();
						if (valType == String.class){
							String s = String.valueOf(val.toString());
							if(StringUtils.endsWith(s, ".0")){
								val = StringUtils.substringBefore(s, ".0");
							}else{
								val = String.valueOf(val.toString());
							}
						}else if (valType == Integer.class){
							val = Double.valueOf(val.toString()).intValue();
						}else if (valType == Long.class){
							val = Double.valueOf(val.toString()).longValue();
						}else if (valType == Double.class){
							val = Double.valueOf(val.toString());
						}else if (valType == Float.class){
							val = Float.valueOf(val.toString());
						}else if (valType == Date.class){
							model.addAttribute(values[i].split(":")[0], DateUtils.formatDateTime(DateUtils.parseDate(val.toString(), parsePatterns)));
						}else if(valType == Boolean.class){
							if(StringUtils.equals("true", String.valueOf(val))){
								val = true;
							}else{
								val = false;
							}
						}
					}
					if(values[i].split(":")[0].indexOf("searchDate")>=0){
						model.addAttribute(values[i].split(":")[0], val.toString());
					}
					Object oriVal = Reflections.invokeGetter(ob, values[i].split(":")[0]);
					if(oriVal != null){
						val = oriVal.toString() + "," + val;
					}
					Reflections.invokeSetter(ob, values[i].split(":")[0], val);
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
