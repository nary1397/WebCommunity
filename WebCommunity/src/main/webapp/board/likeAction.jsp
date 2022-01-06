<%@ page import="com.example.repository.MemberDAO"%>
<%@ page import="com.example.repository.BoardDAO"%>
<%@ page import="com.example.domain.BoardVO"%>
<%@ page import="com.example.repository.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
public static String getClientIP(HttpServletRequest request) {

    String ip = request.getHeader("X-FORWARDED-FOR"); 
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("Proxy-Client-IP");
    }

    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("WL-Proxy-Client-IP");
    }

    if (ip == null || ip.length() == 0) {
        ip = request.getRemoteAddr() ;
    }
    return ip;
}
%>

<%
    // 로그인한 유저의 아이디를 가져오기(세션 확인)
	String id = null;

	if(session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}

	if(id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = '/member/login.jsp'");
		script.println("</script>");
		script.close();
		
		return;
	}

	request.setCharacterEncoding("UTF-8");

    // 이전의 파라매터로 보낸 게시판 글제목 가져오기
	String subject = null;
	if(request.getParameter("subject") != null) {
		subject = (String) request.getParameter("subject");
	}

	// BoardDAO, LikeyDAO 객체 준비
	BoardDAO boardDAO = BoardDAO.getInstance();
	LikeyDAO likeyDAO = LikeyDAO.getInstance();

	// id와 subject가 PK, NN 설정이므로 중복 불가
	int result = likeyDAO.like(id, subject, getClientIP(request));
	
	// 정상적으로 1번 데이터가 들어가면 1이 출력되고
	if (result == 1) {
		result = boardDAO.like(subject);

		if (result == 1) { // 1인경우 디비에서 해당 게시물 추천 완료
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천이 완료되었습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
			
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();

			return;
		} 
	} else { // 이미 PK, NN으로 설정되어 중복되면 1 반환이 되지 않음
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천을 누른 글입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();

		return;

	}
%>