<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import= "java.util.List" %>
<%@ page import= "com.javaex.vo.GuestVo" %>
<%@ page import= "com.javaex.dao.GuestDao" %>


<%
	//get 방식 --> http://localhost:8088/phonebook1/insert.jsp?name=표이슬&hp=010-1111-1111&company=02-2222-2222
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	//String reg = request.getParameter("reg_date");
	
	GuestVo guestVo = new GuestVo(name, password, content);
	
	GuestDao guestDao = new GuestDao();
	
	/*저장*/
	guestDao.guestInsert(guestVo);
	
	//주소를 심어둠-- 중요 --> 다시 리스트.jsp로 돌아감
	response.sendRedirect("./addList.jsp");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add</title>
</head>
<body>
add
</body>
</html>