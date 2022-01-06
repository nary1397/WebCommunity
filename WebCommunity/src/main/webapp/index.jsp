<%@page import="com.example.domain.PageDTO"%>
<%@page import="com.example.domain.Criteria"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.BoardDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 글목록 가져오기 조건객체 준비
Criteria cri = new Criteria(); // 기본값 1페이지 10개
// 요청 페이지번호 파라미터값 가져오기
String strPageNum = request.getParameter("pageNum");
if (strPageNum != null) { // 요청 페이지번호 있으면
	cri.setPageNum(Integer.parseInt(strPageNum)); // cri에 값 설정
}
//요청 글개수 파라미터값 가져오기
String strAmount = request.getParameter("amount");
if (strAmount != null) {
	cri.setAmount(Integer.parseInt(strAmount));
}



//============= 요청 파라미터값 가져와서 Criteria에 저장 완료 =============

// DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
// board 테이블에서 전체글 리스트로 가져오기 
List<BoardVO> boardList = boardDAO.getBoards(cri);

// 전체 글개수 가져오기
//int totalCount = boardDAO.getCountAll();
int totalCount = boardDAO.getCountBySearch(cri); // 검색유형, 검색어가 있으면 적용하여 글개수 가져오기

// 페이지블록 정보 객체준비. 필요한 정보를 생성자로 전달.
PageDTO pageDTO = new PageDTO(cri, totalCount);
%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <jsp:include page="/include/head.jsp" />
</head>

<body class="d-flex flex-column h-100">
    <main class="flex-shrink-0">
    
    <!-- Navbar area -->
	<jsp:include page="/include/top.jsp" />
	<!-- end of Navbar area -->
	
	    <!-- Header-->
	    <header class="bg-dark py-5">
	        <div class="container px-5">
	            <div class="row gx-5 align-items-center justify-content-center">
	                <div class="col-lg-8 col-xl-7 col-xxl-6">
	                    <div class="my-5 text-center text-xl-start">
	                        <h1 class="display-5 fw-bolder text-white mb-2">개발자 커뮤니티 <br>사이트입니다
	                        </h1>
	                        <p class="lead fw-normal text-white-50 mb-4">실력있는 개발자부터 주니어 개발자까지 다양한 스펙트럼의<br>
	                            개발자들이 활동하고 있습니다<br>
	                            코딩을 하다 막히는 부분이 있다면 망설이지 말고 질문하세요!</p>
	                    </div>
	                </div>
	                <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5"
	                        src="/resources/images/0002.png" alt="..." /></div>
	            </div>
	        </div>
	    </header>
	    <br><br>
	    <div class="container" style="width: 60%;">
	        <h3>자유게시판</h3>
	        <hr>
	        <div class="row">
               <div class="col">
                   <table class="table table-striped">
                       <thead>
                           <th class="center-align" style="width: 10%;">번호</th>
                           <th class="center-align" style="width: 50%; text-align: left;">제목</th>
                           <th class="center-align" style="width: 10%;">작성자</th>
                           <th class="center-align" style="width: 10%;">작성일</th>
                           <th class="center-align" style="width: 10%;">조회수</th>
                           <th class="center-align" style="width: 10%;">추천수</th>
                       </thead>
                       <tbody>
                       <%
				        if (pageDTO.getTotalCount() > 0) {
				        	
				        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
				        	
				        	for (BoardVO boardVO : boardList) {
				        		String strRegDate = sdf.format(boardVO.getRegDate());
				        		%>
                           <tr onclick="location.href='/board/boardContent.jsp?num=<%=boardVO.getNum() %>&pageNum=<%=pageDTO.getCri().getPageNum() %>'">
                               <th scope="row"><%=boardVO.getNum() %></th>
                               <td style="text-align: left;">
                               <%
			                    if (boardVO.getReLev() > 0) { // 답글이면
			                    	%>
			                    	<span class="reply-level" style="width: <%=boardVO.getReLev() * 15 %> px"></span>
			                    	<i class="bi bi-arrow-return-right"></i>
			                    	<%
			                    }
			                    %>
                               <%=boardVO.getSubject() %>
                               </td>
                               <td><%=boardVO.getMid() %></td>
                               <td><%=strRegDate %></td>
                               <td><%=boardVO.getReadcount() %></td>
                               <td><%=boardVO.getLikeCount() %></td>
                           </tr>
                           <%
					         } // for
					      } else { // pageDTO.getTotalCount() == 0
					         	%>
					         	<tr>
					         		<td colspan="5">게시판 글이 없습니다.</td>
					         	</tr>
					         	<%
					         }
					         %>
                       </tbody>
                   </table>
	            </div>
	        </div>
	    </div>
	    <br><br>
	</main>
	
    <!-- footer area -->
  	<jsp:include page="/include/bottom.jsp" />
  	<!-- end of footer area -->
</body>

</html>