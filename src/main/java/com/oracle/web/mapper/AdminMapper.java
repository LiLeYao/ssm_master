package com.oracle.web.mapper;

import com.oracle.web.bean.Admin;

public interface AdminMapper {

	int save(Admin admin);

	Admin queryOne(String userName);

	Admin login(Admin admin);

}
