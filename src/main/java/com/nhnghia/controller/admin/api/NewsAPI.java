package com.nhnghia.controller.admin.api;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nhnghia.model.NewsModel;
import com.nhnghia.model.UserModel;
import com.nhnghia.service.INewsService;
import com.nhnghia.utils.HttpUtil;
import com.nhnghia.utils.SessionUtil;

@WebServlet(urlPatterns = { "/api/admin-news" })
public class NewsAPI extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Inject
	private INewsService newsService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		//json -> NewsModel
		NewsModel newsModel = HttpUtil.of(request.getReader()).toModel(NewsModel.class); 
		newsModel.setCreatedBy(((UserModel) SessionUtil.getInstance().getValue(request, "USERMODEL")).getUserName());
		newsModel = newsService.save(newsModel);
		//NewsModel -> json
		mapper.writeValue(response.getOutputStream(), newsModel); 
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		NewsModel updateNewsModel = HttpUtil.of(request.getReader()).toModel(NewsModel.class);
		updateNewsModel.setModifiedBy(((UserModel) SessionUtil.getInstance().getValue(request, "USERMODEL")).getUserName());
		updateNewsModel = newsService.update(updateNewsModel);
		mapper.writeValue(response.getOutputStream(), updateNewsModel);
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		NewsModel newsModel = HttpUtil.of(request.getReader()).toModel(NewsModel.class);
		newsService.delete(newsModel.getIds());
		mapper.writeValue(response.getOutputStream(), "{}");
	}

}
