package com.nhnghia.dao;

import java.util.List;

import com.nhnghia.model.NewsModel;
import com.nhnghia.paging.IPageble;

public interface INewsDAO {

	NewsModel findOne(Long id);
	
	List<NewsModel> findByCategoryId(Long categoryId);

	Long save(NewsModel newsModel);
	
	void update(NewsModel updateNewsModel);
	
	void delete(long id);
	
	List<NewsModel> findAll(IPageble pageble);
	
	int getTotalItems();

}
