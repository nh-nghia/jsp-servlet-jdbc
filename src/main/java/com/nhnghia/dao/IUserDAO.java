package com.nhnghia.dao;

import com.nhnghia.model.UserModel;

public interface IUserDAO {

	UserModel findByUserNameAndPasswordAndStatus(String userName, String password, Integer status);
	
}
