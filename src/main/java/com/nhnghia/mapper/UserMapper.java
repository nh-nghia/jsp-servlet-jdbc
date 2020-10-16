package com.nhnghia.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.nhnghia.model.RoleModel;
import com.nhnghia.model.UserModel;

public class UserMapper implements IRowMapper<UserModel> {

	@Override
	public UserModel mapRow(ResultSet resultSet) {
		UserModel user = new UserModel();
		try {
			user.setId(resultSet.getLong("id"));
			user.setUserName(resultSet.getString("username"));
			user.setPassword(resultSet.getString("password"));
			user.setFullName(resultSet.getString("fullname"));
			user.setStatus(resultSet.getInt("status"));
			try {
				// xuất hiện khi query inner join, nếu k sẽ bị chết khi query k có inner join
				RoleModel role = new RoleModel();
				role.setCode(resultSet.getString("code"));
				role.setName(resultSet.getString("name"));
				user.setRole(role);
			} catch (Exception e) {
				System.out.print(e.getMessage());
			}
			
			return user;
		} catch (SQLException e) {
			
			return null;
		}
	}
}
