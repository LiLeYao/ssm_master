package com.oracle.web.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor;

import com.oracle.web.bean.Monster;
import com.oracle.web.bean.School;
import com.oracle.web.bean.SubMonster;
import com.oracle.web.bean.pageBean;
import com.oracle.web.service.MonsterService;
import com.oracle.web.service.SchoolService;

@Controller
@Scope(value = "prototype")
public class MontserHandler {

	@Autowired
	private MonsterService monsterService;

	@Autowired
	private SchoolService schoolService;

//	@RequestMapping(value = "/monsters", method = RequestMethod.GET)
//	public String monsters(HttpServletRequest request) {
//
//		List<SubMonster> list = monsterService.list();
//		
//		System.out.println(list);
//
//		request.setAttribute("mlist", list);
//
//		return "list";
//	}

	@RequestMapping(value = "/addUI", method = RequestMethod.GET)
	public String addUI(HttpServletRequest request) {

		List<School> list = schoolService.list();

		request.setAttribute("slist", list);

		return "add";
	}

	@RequestMapping(value = "/monster", method = RequestMethod.POST)
	public String add(Monster monster) {

		monsterService.save(monster);

		return "redirect:/monsters";// 重定向
	}

	@RequestMapping(value = "/monster/{monsterId}", method = RequestMethod.DELETE)
	public String delete(@PathVariable("monsterId") Integer id) {

		Monster m = new Monster();

		m.setMonsterId(id);

		monsterService.delete(m);

		return "redirect:/monsters";// 重定向
	}

	@RequestMapping(value = "/monster/{monsterId}", method = RequestMethod.GET)
	public String updateUI(@PathVariable("monsterId") Integer id, HttpSession session) {

		Monster monster = monsterService.queryOneMonster(id);

		session.setAttribute("m", monster);//request

		List<School> list = schoolService.list();

		session.setAttribute("slist", list);//request
		
		//return "update";//转发
		
		return "redirect:/update.jsp";
	}
	
	@RequestMapping(value = "/monster", method = RequestMethod.PUT)
	public String update(Monster monster){
		
		monsterService.update(monster);
		
		return "redirect:/monsters";// 重定向
	}
	
	@RequestMapping(value = "/monsters", method = RequestMethod.GET)
	public String selectFY(Integer pageNow,HttpServletRequest request){
		
		if (pageNow == null || pageNow < 1) {

			pageNow = 1;

		}
		
		pageBean<SubMonster> pb=this.monsterService.selectAllByPageHelper(pageNow);

		//int pageSize = 2;

		//pageBean<SubMonster> pb = monsterService.showPage(pageNow, pageSize);

		request.setAttribute("pb", pb);
		
		System.out.println(pb);
		
		return "list";
		
		
	}
}
