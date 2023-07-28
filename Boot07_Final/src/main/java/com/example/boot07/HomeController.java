package com.example.boot07;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping("/")
	public String home(HttpServletRequest request) {

		List<String> noticeList = new ArrayList<>();
		noticeList.add("Spring Boot");
		noticeList.add("JSP");
		noticeList.add("HTML");

		request.setAttribute("noticeList", noticeList);

		return "home";
	}
}
