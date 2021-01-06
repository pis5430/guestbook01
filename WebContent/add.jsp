<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import= "java.util.List" %>
<%@ page import= "com.javaex.vo.GuestVo" %>
<%@ page import= "com.javaex.dao.GuestDao" %>


<%

	// method="post" 일때 한글깨짐 현상을 해결하는 법
	request.setCharacterEncoding("UTF-8"); 

	//get 방식 --> http://localhost:8088/phonebook1/insert.jsp?name=표이슬&hp=010-1111-1111&company=02-2222-2222
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	//String reg = request.getParameter("reg_date");
	
	GuestVo guestVo = new GuestVo(name, password, content);
	
	GuestDao guestDao = new GuestDao();
	
	/*저장*/
	//guestDao.guestInsert(guestVo);
	
	//주소를 심어둠-- 중요 --> 다시 리스트.jsp로 돌아감
	//response.sendRedirect("./addList.jsp");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add</title>
</head>
<body>
<%--입력값이 없으면 추가되지 않게 코드 짜보기 --%>
<%--1.name값이 없는경우(password 없는경우, content 없는경우) 2. 이중에 두개이상 없는경우 3. 세가지 다 없는경우--%>
<%--sql 테이블 생성시 not null값 넣어준경우 (name 값에 not null 넣어줌) --%>
<%--password 없는경우, content 없는경우 입력이 안되도록 코드 짜보기/구동안됨 대부분 자바스크립트로 만든다고함 --%>

	<% if((guestVo.getPassword()) == (null) & (guestVo.getContent()) == (null)){ %><%--password,content 둘다 없는경우 --%>
		
		<p>password, content 입력해주세요</p>
		<form action="./addList.jsp" method="post">
			<button type="submit">돌아가기</button><br>
	
		</form>

	<%}else if((guestVo.getPassword()).equals(null)){%><%--password 없는경우 --%>
	
		<p>password를 입력해주세요</p>
		<form action="./addList.jsp" method="post">
			<button type="submit">돌아가기</button><br>
	
		</form>


	<%}else if((guestVo.getContent()).equals(null)){ %><%--content 없는경우 --%>
	
		<p>content를 입력해주세요</p>
		<form action="./addList.jsp" method="post">
			<button type="submit">돌아가기</button><br>
	
		</form>


	<%}else { %>
	
			
		<% guestDao.guestInsert(guestVo); %>
	
		<% response.sendRedirect("./addList.jsp");%>
		
	<%} %>

</body>
</html>