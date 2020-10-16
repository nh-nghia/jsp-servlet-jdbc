package com.nhnghia.service.impl;

import java.util.List;

import javax.inject.Inject;

import com.nhnghia.dao.ICategoryDAO;
import com.nhnghia.model.CategoryModel;
import com.nhnghia.service.ICategoryService;

public class CategoryService implements ICategoryService {

	// similar @Autowired in Spring
	@Inject
	private ICategoryDAO categoryDAO;

	@Override
	public List<CategoryModel> findAll() {

		return categoryDAO.findAll();
	}

}
