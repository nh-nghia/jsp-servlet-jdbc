package com.nhnghia.controller.admin;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nhnghia.constant.SystemConstant;
import com.nhnghia.model.NewsModel;
import com.nhnghia.paging.IPageble;
import com.nhnghia.paging.PageRequest;
import com.nhnghia.service.ICategoryService;
import com.nhnghia.service.INewsService;
import com.nhnghia.sorting.Sorter;
import com.nhnghia.utils.FormUtil;
import com.nhnghia.utils.MessageUtil;

@WebServlet(urlPatterns = { "/admin-news" })
public class NewsController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Inject
	private INewsService newsService;
	
	@Inject
	private ICategoryService categoryService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

//		NewsModel newsList = new NewsModel();
//		String pageStr = request.getParameter("page");
//		String maxPageItemStr = request.getParameter("maxPageItem");
//		if (pageStr != null) {
//			newsList.setPage(Integer.parseInt(pageStr));
//		} else {
//			newsList.setPage(1);
//		}
//		if (maxPageItemStr != null) {
//			newsList.setMaxPageItem(Integer.parseInt(maxPageItemStr));
//		}

		String view = "";
		
		// this line replaces the entire code above
		NewsModel newsList = FormUtil.toModel(NewsModel.class, request);
		
		if (newsList.getType().equals(SystemConstant.LIST)) {
			IPageble pageble = new PageRequest(newsList.getPage(), newsList.getMaxPageItem(),
					new Sorter(newsList.getSortName(), newsList.getSortBy()));
			newsList.setListResult(newsService.findAll(pageble));
			newsList.setTotalItems(newsService.getTotalItems());
			newsList.setTotalPages((int) Math.ceil((double) newsList.getTotalItems() / newsList.getMaxPageItem()));
			view = "/WEB-INF/views/admin/news/list.jsp";
		} else if (newsList.getType().equals(SystemConstant.EDIT)) {
			if (newsList.getId() != null) {
				newsList = newsService.findOne(newsList.getId());
			} else {
				
			}
			request.setAttribute("categories", categoryService.findAll());
			view = "/WEB-INF/views/admin/news/edit.jsp";
		}
		MessageUtil.showMessage(request);
		request.setAttribute(SystemConstant.MODEL, newsList);
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(view);
		requestDispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
