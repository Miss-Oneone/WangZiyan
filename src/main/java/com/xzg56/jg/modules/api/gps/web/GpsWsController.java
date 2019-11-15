package com.xzg56.jg.modules.api.gps.web;


import com.xzg56.core.utils.JsonUtils;
import com.xzg56.jg.modules.api.gps.model.GpsWsModel;
import com.xzg56.jg.modules.api.gps.service.GpsWsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value={"/webservice/ctcc/gpsWs"})
public class GpsWsController {
	
	@Autowired
	private GpsWsService gpsWsService;
	
	@RequestMapping(value={"/phoneLogin"})
	@ResponseBody
	public String phoneLogin(HttpServletRequest request, HttpServletResponse response, Model model) {
		String result = JsonUtils.toString(gpsWsService.phoneLogin());
		
		return result;
	}
	
	@RequestMapping(value={"/searchCarList"})
	@ResponseBody
	public String searchCarList(HttpServletRequest request, HttpServletResponse response, Model model) {
		String result = JsonUtils.toString(gpsWsService.searchCarList());
		
		return result;
	}
	
	@RequestMapping(value={"/searchCarLocation"})
	@ResponseBody
	public String searchCarLocation(HttpServletRequest request, HttpServletResponse response, Model model, @RequestBody GpsWsModel gpsWsModel) {
		String result = JsonUtils.toString(gpsWsService.searchCarLocation(gpsWsModel.getCarNo()));
		
		return result;
	}
	
	@RequestMapping(value={"/searchCarLocationWitGet"})
	@ResponseBody
	public String searchCarLocation(HttpServletRequest request, HttpServletResponse response, Model model) {
		String result = JsonUtils.toString(gpsWsService.searchCarLocation(request.getParameter("carNo")));
		
		return result;
	}
	
	@RequestMapping(value={"/searchCarTrack"})
	@ResponseBody
	public String searchCarTrack(HttpServletRequest request, HttpServletResponse response, Model model, @RequestBody GpsWsModel gpsWsModel) {
		String result = JsonUtils.toString(gpsWsService.searchCarTrack(gpsWsModel));
		
		return result;
	}
	
	@RequestMapping(value={"/searchCarTrackWitGet"})
	@ResponseBody
	public String searchCarTrack(HttpServletRequest request, HttpServletResponse response, Model model) {
		GpsWsModel gpsWsModel = (GpsWsModel) JsonUtils.getBean(request, GpsWsModel.class);
		String result = JsonUtils.toString(gpsWsService.searchCarTrack(gpsWsModel));
		
		return result;
	}
	
	@RequestMapping(value={"/searchCarMileage"})
	@ResponseBody
	public String searchCarMileage(HttpServletRequest request, HttpServletResponse response, Model model) {
		GpsWsModel gpsWsModel = (GpsWsModel) JsonUtils.getBean(request, GpsWsModel.class);
		String result = JsonUtils.toString(gpsWsService.searchCarMileage(gpsWsModel));
		
		return result;
	}
}