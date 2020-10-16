package com.nhnghia.dao;

import java.util.List;

import com.nhnghia.model.CategoryModel;

public interface ICategoryDAO {
	
	List<CategoryModel> findAll();
	
	CategoryModel findOne(Long id);
	
	CategoryModel findOneByCode(String code);

}
