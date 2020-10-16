package com.nhnghia.service.impl;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import com.nhnghia.dao.ICategoryDAO;
import com.nhnghia.dao.INewsDAO;
import com.nhnghia.model.CategoryModel;
import com.nhnghia.model.NewsModel;
import com.nhnghia.paging.IPageble;
import com.nhnghia.service.INewsService;

public class NewsService implements INewsService {

	@Inject
	private INewsDAO newsDAO;
	
	@Inject
	private ICategoryDAO categoryDAO;

	@Override
	public List<NewsModel> findByCategoryId(Long categoryId) {
		
		return newsDAO.findByCategoryId(categoryId);
	}

	@Override
	public NewsModel save(NewsModel newsModel) {
		newsModel.setCreatedDate(new Timestamp(System.currentTimeMillis()));
		
		// dropdown list lấy theo categoryCode chứ không phải categoryId
		CategoryModel category = categoryDAO.findOneByCode(newsModel.getCategoryCode());
		newsModel.setCategoryId(category.getId());
		
		// here we can call insert method in IGenericDAO, but this is service layer shouldn't have any sql -> DAO
		Long newsId = newsDAO.save(newsModel);
		
		return newsDAO.findOne(newsId);
	}

	@Override
	public NewsModel update(NewsModel updateNewsModel) {
		NewsModel oldNew = newsDAO.findOne(updateNewsModel.getId());
		updateNewsModel.setCreatedDate(oldNew.getCreatedDate());
		updateNewsModel.setCreatedBy(oldNew.getCreatedBy());
		updateNewsModel.setModifiedDate(new Timestamp(System.currentTimeMillis()));
		
		// dropdown list lấy theo categoryCode chứ không phải categoryId
		CategoryModel category = categoryDAO.findOneByCode(updateNewsModel.getCategoryCode());
		updateNewsModel.setCategoryId(category.getId());
		
		newsDAO.update(updateNewsModel);
		
		return newsDAO.findOne(updateNewsModel.getId());
	}

	@Override
	public void delete(Long[] ids) {
		for (long id : ids) {
			// 1. delete comments
			// 2. delete news
			newsDAO.delete(id);
		}
	}

	@Override
	public List<NewsModel> findAll(IPageble pageble) {
		
		return newsDAO.findAll(pageble);
	}

	@Override
	public int getTotalItems() {
		
		return newsDAO.getTotalItems();
	}

	@Override
	public NewsModel findOne(Long id) {
		NewsModel newsModel = newsDAO.findOne(id);
		CategoryModel categoryModel = categoryDAO.findOne(newsModel.getCategoryId());
		newsModel.setCategoryCode(categoryModel.getCode());
		
		return newsModel;
	}

}
