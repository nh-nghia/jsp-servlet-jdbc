package com.nhnghia.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.nhnghia.model.CategoryModel;

public class CategoryMapper implements IRowMapper<CategoryModel> {

	@Override
	public CategoryModel mapRow(ResultSet resultSet) {
		CategoryModel category = new CategoryModel();
		try {
			category.setId(resultSet.getLong("id"));
			category.setCode(resultSet.getString("code"));
			category.setName(resultSet.getString("name"));
			
			return category;
		} catch (SQLException e) {
			
			return null;
		}
	}
}
