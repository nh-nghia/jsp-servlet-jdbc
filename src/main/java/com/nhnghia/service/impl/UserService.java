package com.nhnghia.service.impl;

import javax.inject.Inject;

import com.nhnghia.dao.IUserDAO;
import com.nhnghia.model.UserModel;
import com.nhnghia.service.IUserService;

public class UserService implements IUserService {

	@Inject
	private IUserDAO userDAO;

	@Override
	public UserModel findByUserNameAndPasswordAndStatus(String userName, String password, Integer status) {
		
		return userDAO.findByUserNameAndPasswordAndStatus(userName, password, status);
	}

}
