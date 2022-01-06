<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 사용자 세션에서 id 가져오기 --%>
<% String id = (String) session.getAttribute("id"); %>

	<!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container px-5">
            <a class="navbar-brand" href="/index.jsp">Start Developer</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation"><span
                    class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="/board/boardList.jsp">게시판</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdownPortfolio" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-person"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownPortfolio">
                        	<%
					      	if (id == null) {
					    	  %>
                        	<!-- 로그아웃 상태일 때 보이는 항목 -->
                            <li><a class="dropdown-item" href="/member/login.jsp">로그인</a></li>
                            <li><a class="dropdown-item" href="/member/join.jsp">회원가입</a></li>
                            <%
						    } else {
						    	  %>
						    <!-- 로그인 상태일 때 보이는 항목 -->
                            <li><a class="dropdown-item" href="/member/modifyMember.jsp">정보수정</a></li>
                            <li><a class="dropdown-item" href="/member/removeMember.jsp">회원탈퇴</a></li>
                            <li><a class="dropdown-item" href="/member/logout.jsp">로그아웃</a></li>
                            <%
					      	if (id.equals("admin") == true) {
					    	  %>
					    	<li><a class="dropdown-item" href="/ajax/deleteMember.jsp">회원관리</a></li>
					    	<%
						      }
						      %>
                            <%
						      }
						      %>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>















