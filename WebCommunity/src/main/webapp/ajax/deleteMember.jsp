<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>회원정보 삭제하기</h1>
<hr>

<input type="text" name="id" id="id">
<button type="button" id="btn">회원삭제</button>
<p id="message"></p>
<br>

<h3>회원 리스트</h3> 
<table width="100%" border="1">
<tr>
	<td>아이디</td>
	<td>비번</td>
	<td>이름</td>
	<td>생년월일</td>
	<td>성별</td>
	<td>이메일</td>
</tr>

<%
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		String jdbcDriver = "jdbc:mysql://localhost:3306/webproject?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
		String dbUser = "webid";
		String dbPass = "1234";
		con = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);	
		pstmt = con.prepareStatement("select * from member");
		rs = pstmt.executeQuery();
		while(rs.next()){
%>
<tr>
	<td> <%= rs.getString("id") %> </td>
	<td> <%= rs.getString("passwd") %> </td>
	<td> <%= rs.getString("name") %> </td>
	<td> <%= rs.getString("birthday") %> </td>
	<td> <%= rs.getString("gender") %> </td>
	<td> <%= rs.getString("email") %> </td>
</tr>
<%
		}
	}catch(SQLException e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close(); } catch(SQLException e) {}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
		if (con != null) try { con.close(); } catch(SQLException e) {}
}
%>
</table>

<script src="/resources/js/jquery-3.6.0.js"></script>
<script>
	$('#btn').on('click', function () {
		
		var id = $('#id').val();

		// ajax 함수 호출
		$.ajax({
			url: '/api/members/' + id,
			method: 'DELETE',
			success: function (data) {
				console.log(data);
				
				if (data.isDeleted == true) {
					$('p#message').html(id + ' : 회원정보 삭제 성공')
								  .css('color', 'green');
				} else {
					$('p#message').html(id + ' : 회원정보 삭제 실패')
					              .css('color', 'red');
				}
			} // success
		});
	});
</script>
</body>
</html>




