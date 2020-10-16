package com.nhnghia.service;

import java.util.List;

import com.nhnghia.model.NewsModel;
import com.nhnghia.paging.IPageble;

public interface INewsService {

	List<NewsModel> findByCategoryId(Long categoryId);

	NewsModel save(NewsModel newsModel);
	
	NewsModel update(NewsModel updateNewsModel);
	
	void delete(Long[] ids);
	
	List<NewsModel> findAll(IPageble pageble);
	
	int getTotalItems();
	
	NewsModel findOne(Long id);
	
}
