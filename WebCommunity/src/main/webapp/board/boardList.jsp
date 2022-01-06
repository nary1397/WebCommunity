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

//요청 추천수 파라미터값 가져오기
String strLikeCount = request.getParameter("likeCount");
if (strLikeCount != null) {
	cri.setLikeCount(Integer.parseInt(strLikeCount));
}

// 요청 검색유형 파라미터값 가져오기
String type = request.getParameter("type"); // null or ""
if (type != null && type.length() > 0) {
	cri.setType(type);
}
//요청 검색어 파라미터값 가져오기
String keyword = request.getParameter("keyword"); // null or ""
if (keyword != null && keyword.length() > 0) {
	cri.setKeyword(keyword);
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
  <style>
  /* .reply-level {
  	padding-left: 15px;
  } */
  </style>
</head>

<body class="d-flex flex-column">
    <main class="flex-shrink-0">
    
    <!-- Navbar area -->
	<jsp:include page="/include/top.jsp" />
	<!-- end of Navbar area -->
	
		<!-- Page content-->
        <section class="py-5">
            <div class="container px-5">
                <!-- Contact form-->
                <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                    <div class="container" style="width: 95%;">
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
						                    	<span class="reply-level" style="width: <%=boardVO.getReLev() * 1500 %> px"></span>
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
                                <%
								if (session.getAttribute("id") != null) {
									%>
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="button" onclick="location.href='/board/boardWrite.jsp?pageNum=<%=pageDTO.getCri().getPageNum() %>'" 
                                    class="btn btn-outline-dark btn-sm ">글쓰기</button>
                                </div>
                                <%
									}
								%>
                                <form method="get" class="form-inline search-form justify-content-end" id="frm">
                                    <input type="hidden" class="form-control" name="mode" value="best">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <select class="form-control form-control-sm" name="type">
                                                <option value="subject" <%=(pageDTO.getCri().getType().equals("subject")) ? "selected" : "" %>>제목</option>
                                                <option value="content" <%=(pageDTO.getCri().getType().equals("content")) ? "selected" : "" %>>내용</option>
                                                <option value="mid" <%=(pageDTO.getCri().getType().equals("mid")) ? "selected" : "" %>>작성자</option>
                                            </select>
                                        </div>
                                        <input type="text" class="form-control form-control-sm" name="keyword" value="<%=pageDTO.getCri().getKeyword() %>">
                                        <div class="input-group-append">
                                            <button class="btn btn-arca btn-sm" id="btnSearch" type="submit">검색</button>
                                        </div>
                                    </div>
                                </form>
                                
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-center">
                                    <%
						              // 이전
						              if (pageDTO.isPrev()) {
						            	  %>
                                        <li class="page-item">
                                            <a class="page-link" href="/board/boardList.jsp?pageNum=<%=pageDTO.getStartPage() - 1 %>&type=<%=pageDTO.getCri().getType() %>&keyword=<%=pageDTO.getCri().getKeyword() %>#board" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                     <%
							            }
							         %>
							         <%
						              // 페이지블록 내 최대 5개 페이지씩 출력
						              for (int i=pageDTO.getStartPage(); i<=pageDTO.getEndPage(); i++) {
						            	  %>
                                        <li class="page-item <%=(pageDTO.getCri().getPageNum() == i) ? "active" : "" %>">
                                        <a class="page-link" href="/board/boardList.jsp?pageNum=<%=i %>&type=<%=pageDTO.getCri().getType() %>&keyword=<%=pageDTO.getCri().getKeyword() %>#board"><%=i %></a>
                                        </li>
							            <%
							            	}
							            %>
                                        <%
							            // 다음
							            if (pageDTO.isNext()) {
							            	%>
                                        <li class="page-item">
                                            <a class="page-link" href="/board/boardList.jsp?pageNum=<%=pageDTO.getEndPage() + 1 %>&type=<%=pageDTO.getCri().getType() %>&keyword=<%=pageDTO.getCri().getKeyword() %>#board" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                        <%
							            	}
							            %>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <!-- footer area -->
  	<jsp:include page="/include/bottom.jsp" />
  	<!-- end of footer area -->
  	
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <!-- * *                               SB Forms JS                               * *-->
    <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    
    <script>
    // 검색 버튼 클릭시
  	$('#btnSearch').on('click', function () {
  		
  		var query = $('#frm').serialize();
  		console.log(query);
  		
  		location.href = '/board/boardList.jsp?' + query + '#board';
  	});
  </script>
</body>

</html>