package com.nhnghia.mapper;

import java.sql.ResultSet;

public interface IRowMapper<T> {
	
	T mapRow(ResultSet resultSet);
	
}
