<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.javaex.dao.GuestDao" %>
<%@ page import="com.javaex.vo.GuestVo" %>


<%
	int no = Integer.parseInt(request.getParameter("no"));
	String password = request.getParameter("password");
	
	GuestDao guestDao = new GuestDao(); // delete 메소드를 불러오기 위해 필요
	GuestVo guestVo = new GuestVo(no,password); 
	
	//guestDao.guestDelete(no); 비밀번호 추가할경우 dao에서 수정필요(수정)
	//비밀번호 틀림 표시를 위해서는 여기에서 if 문 사용 필요(수정)
	
	//--> 비밀번호가 틀렸는지 번호가 틀렸는지 확인하는 방법은? // addList에서 넘어올때 no값을 가지고옴
	
	//response.sendRedirect("./addList.jsp");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>
	<% int count = guestDao.guestDelete(no,password);%>
	
	<%if(count != 0){%><%-- 리턴값이 0이 아닌경우 / 비밀번호 맞음 --%>
	
		<%response.sendRedirect("./addList.jsp"); %>
	
	<%}else { %><%-- 리턴값이 0인경우 --%>
	
		<p>잘못된 비밀번호 입니다.</p>
		<form action="./addList.jsp" method="post">
			<button type="submit">돌아가기</button><br>
	
		</form>
	<%} %>


</body>
</html>