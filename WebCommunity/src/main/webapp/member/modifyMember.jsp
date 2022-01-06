<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 세션에서 로그인 아이디 가져오기
String id = (String) session.getAttribute("id");

// DAO 객체 준비
MemberDAO memberDAO = MemberDAO.getInstance();

// 아이디에 해당하는 자신의 정보를 DB에서 가져오기
MemberVO memberVO = memberDAO.getMemberById(id);

// input type="date" 태그에 설정가능한 값이 되도록 생년월일 문자열을 변경하기
String birthday = memberVO.getBirthday(); // "20020127" -> "2002-01-27"

// 문자열 -> Date 객체 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Date date = sdf.parse(birthday); // 생년월일 문자열을 Date 객체로 변환

// Date 객체 -> 문자열 변환
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String strBirthday = sdf2.format(date);
%>
    
<!DOCTYPE html>
<html lang="ko">

<head>
  <jsp:include page="/include/head.jsp" />
</head>

<body class="d-flex flex-column">
    <main class="flex-shrink-0">
    
    <!-- Navbar area -->
	<jsp:include page="/include/top.jsp" />
	<!-- end of Navbar area -->
	
        <!-- Pricing section-->
        <section class="bg-light py-5">
            <!-- middle container -->
            <div class="container mt-4 ">
                <div class="row justify-content-center">
                    <!-- Right area -->
                    <div class="col-sm-6 ">
                        <!-- Contents area -->
                        <div class="border p-4 rounded border-secondary">
                            <h5>정보 수정</h5>
                            <hr class="featurette-divider">
                            <form action="/member/modifyMemberPro.jsp" method="POST" id="frm">
                            
                                <div class="form-group">
                                    <label for="id">
                                        <span class="align-middle">아이디</span>
                                    </label>
                                    <input type="text" class="form-control" id="id" aria-describedby="idHelp" name="id"
                                        value="<%=memberVO.getId() %>" readonly>
                                </div>
                                <br>
                                
                                <div class="form-group">
                                    <label for="passwd">
                                        <span class="align-middle">비밀번호</span>
                                    </label>
                                    <input type="password" class="form-control" id="passwd" aria-describedby="pwdHelp"
                                        name="passwd" required>
                                </div>
                                <br>

                                <div class="form-group">
                                    <label for="name">
                                        <span class="align-middle">이름</span>
                                    </label>
                                    <input type="text" class="form-control" id="name" name="name" value="<%=memberVO.getName() %>">
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="birthday">
                                        <span class="align-middle">생년월일</span>
                                    </label>
                                    <input type="date" class="form-control" id="birthday" name="birthday" value="<%=strBirthday %>">
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="gender">
                                        <span class="align-middle">성별 선택</span>
                                    </label>
                                    <select class="form-control" id="gender" name="gender">
                                        <option value="" disabled <%=(memberVO.getGender() == null) ? "selected" : "" %>>성별을 선택하세요.</option>
                                        <option value="M" <%=(memberVO.getGender().equals("M")) ? "selected" : "" %>>남자</option>
                                        <option value="F" <%=(memberVO.getGender().equals("F")) ? "selected" : "" %>>여자</option>
                                        <option value="U" <%=(memberVO.getGender().equals("N")) ? "selected" : "" %>>선택 안함</option>
                                    </select>
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="email">
                                        <span class="align-middle">이메일 주소</span>
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email" value="<%=memberVO.getEmail() %>">
                                </div>
                                <br>
                                <div class="text-center">
                                    <label class="mr-3">이벤트 등 알림 메일 수신동의 : </label>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" value="Y" type="radio" <%=(memberVO.getRecvEmail().equals("Y")) ? "checked" : "" %> name="recvEmail" id="recvEmailYes" />
                                        <label class="form-check-label" for="recvEmailYes">동의함</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" value="N" type="radio" <%=(memberVO.getRecvEmail().equals("N")) ? "checked" : "" %> name="recvEmail" id="recvEmailNo"/>
                                        <label class="form-check-label" for="recvEmailNo">동의 안함</label>
                                    </div>
                                </div>
                                <div class="my-3 text-center">
                                    <button type="submit" class="btn btn-outline-dark">수정</button>
                                    <button type="reset" class="btn btn-outline-dark ml-3">초기화</button>
                                </div>
                            </form>
                        </div>
                        <!-- end of Contents area -->
                    </div>
                    <!-- end of Right area -->
                </div>
            </div>
            <!-- end of middle container -->
        </section>
    </main>

  <!-- footer area -->
  <jsp:include page="/include/bottom.jsp" />
  <!-- end of footer area -->
  	
  <!--  Scripts-->
  <jsp:include page="/include/commonJs.jsp" />

</body>

</html>





