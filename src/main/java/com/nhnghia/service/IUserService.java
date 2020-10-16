package com.nhnghia.service;

import com.nhnghia.model.UserModel;

public interface IUserService {
	
	UserModel findByUserNameAndPasswordAndStatus(String userName, String password, Integer status);
	
}
