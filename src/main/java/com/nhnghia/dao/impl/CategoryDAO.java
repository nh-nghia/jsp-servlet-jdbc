package com.nhnghia.dao.impl;

import java.util.List;

import com.nhnghia.dao.ICategoryDAO;
import com.nhnghia.mapper.CategoryMapper;
import com.nhnghia.model.CategoryModel;

public class CategoryDAO extends AbstractDAO<CategoryModel> implements ICategoryDAO {

	@Override
	public List<CategoryModel> findAll() {
		String sql = "SELECT * FROM categories;";
		
		return query(sql, new CategoryMapper());
	}

	@Override
	public CategoryModel findOne(Long id) {
		String sql = "SELECT * FROM categories WHERE id = ?;";
		List<CategoryModel> categories = query(sql, new CategoryMapper(), id);

		return categories.isEmpty() ? null : categories.get(0);
	}

	@Override
	public CategoryModel findOneByCode(String code) {
		String sql = "SELECT * FROM categories WHERE code = ?;";
		List<CategoryModel> categories = query(sql, new CategoryMapper(), code);

		return categories.isEmpty() ? null : categories.get(0);
	}
}
