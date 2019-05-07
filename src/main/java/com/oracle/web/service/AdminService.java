package com.oracle.web.service;

import com.oracle.web.bean.Admin;

public interface AdminService {

	

	Admin queryone(String userName);

	Admin login(Admin admin);

	int save(Admin admin);

	

}
