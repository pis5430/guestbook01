<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.javaex.dao.GuestDao" %>
<%@ page import="com.javaex.vo.GuestVo" %>


<%
	int no = Integer.parseInt(request.getParameter("no"));
	String password = request.getParameter("password");
	
	GuestDao guestDao = new GuestDao();
	GuestVo guestVo = new GuestVo(no,password);
	
	//guestDao.guestDelete(no); 비밀번호 추가할경우 dao에서 수정필요
	//여기에서 if문으로 걸러낼건지 , 다른방법으로 할건지
	
	//response.sendRedirect("./addList.jsp");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>

	
		<%-- 비밀번호가 같으면 --%>
		<% if(guestVo.getPassword().equals(password)){%>
		
			<%response.sendRedirect("./addList.jsp");%>
		<%}else{%>
		 <%System.out.println("비밀번호가 틀렸습니다.");
		}%>

</body>
</html>