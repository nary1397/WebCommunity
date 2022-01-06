<%@page import="com.example.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.BoardDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 상세보기 글번호 파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));

// 요청 페이지번호 파라미터값 가져오기
String pageNum = request.getParameter("pageNum");

// 글제목 파라미터값 가져오기
String subject = request.getParameter("subject");

// DAO객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
AttachDAO attachDAO = AttachDAO.getInstance();

// 조회수 1 증가시키기
boardDAO.updateReadcount(num);

// 상세보기할 글 한개 가져오기
BoardVO boardVO = boardDAO.getBoard(num);

// 화면에 표시할 날짜형식
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

// 첨부파일 정보 리스트 가져오기
List<AttachVO> attachList = attachDAO.getAttachesByBno(num);
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
	
        <!-- middle container -->
        <section class="bg-light py-5">
            <div class="container" style="width: 60%;">
                <div class="row">
                    <!-- Right area -->
                    <div class="col">
                        <!-- Contents area -->
                        <div class="border border-secondary p-3 rounded">
                            <!-- 글 상세보기 영역 -->
                            <table class="table">
                                <tr>
                                    <td colspan="12" class="tdleft table-border table-secondary"><%=boardVO.getSubject() %></td>
                                </tr>
                                <tr class="table-border">
                                    <th scope="row" class="text-center">작성자</th>
                                    <td class="tdleft"><%=boardVO.getMid() %></td>
                                    <th scope="row" class="text-center">작성일</th>
                                    <td class="tdleft"><%=sdf.format(boardVO.getRegDate()) %></td>
                                    <th scope="row" class="text-center">조회수</th>
                                    <td class="tdleft"><%=boardVO.getReadcount() %></td>
                                    <th scope="row" class="text-center">추천</th>
                                    <td class="text-primary"><%=boardVO.getLikeCount() %></td>
                                </tr>
                                <tr>
                                    <td colspan="12" class="tdleft table-border" style="height: 30rem;">
                                        <%=boardVO.getContent().replace("\r\n","<br>") %>
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td colspan="12" class="tdleft table-border">
								<%
			                   	if (attachList.size() > 0) { // 첨부파일이 있으면
			                   		%>
			                   		<ul>
			                   		<%
			                   		for (AttachVO attach : attachList) {
			                   			if (attach.getFiletype().equals("O")) { // 일반파일
			                   				// 다운로드할 일반파일 경로
			                   				String fileCallPath = attach.getUploadpath() + "/" + attach.getFilename();
			                   				%>
			                       			<li>
                       				<a href="/board/download.jsp?fileName=<%=fileCallPath %>">
	                       				<i class="material-icons">file_present</i>
	                       				<%=attach.getFilename() %>
                       				</a>
                       			</li>
                       			<%
                   			} else if (attach.getFiletype().equals("I")) { // 이미지파일
                   				// 썸네일 이미지 경로
                   				String fileCallPath = attach.getUploadpath() + "/s_" + attach.getFilename();
                   				// 원본 이미지 경로
                   				String fileCallPathOrigin = attach.getUploadpath() + "/" + attach.getFilename();
                   				%>
                       			<li>
                       				<a href="/board/display.jsp?fileName=<%=fileCallPathOrigin %>">
                       					<img src="/board/display.jsp?fileName=<%=fileCallPath %>">
                       				</a>
                       			</li>
                       			<%
	                   				}
		                   		}
		                   		%>
		                   		</ul>
		                   		<%
			                   	} else { // attachList.size() == 0  // 첨부파일이 없으면
			                   		%>첨부파일 없음<%
			                   	}
			                   	%>
                                    </td>
                                </tr>
                            </table>
                            <div class="text-right mt-4" style="text-align: right;">
                            <%
			                  String id = (String) session.getAttribute("id");
			                  if (id != null) { // 로그인 했을때
			                	  %>
			                	  <div class="text-center">
				                	<a class="btn btn-primary btn-lg ml-3 text-center" onclick="return confirm('추천하시겠습니까?')" href="/board/likeAction.jsp?subject=<%=boardVO.getSubject()%>">추천</a>
				                	</div>
				                	<%
			                	  if (id.equals(boardVO.getMid())) { // 로그인 아이디와 글작성자 아이디가 같을때
			                		  %>
                                <button type="button" class="btn btn-outline-dark ml-3" onclick="location.href='/board/boardModify.jsp?num=<%=boardVO.getNum() %>&pageNum=<%=pageNum %>'">
                                    <span class="align-middle">수정</span>
                                </button>
                                <button type="button" class="btn btn-outline-dark ml-3" onclick="remove(event)">
                                    <span class="align-middle">삭제</span>
                                </button>
                               	 <%
			                	  	}
			                	 %>
			                	 
			                	 <button type="button" class="btn btn-outline-dark ml-3" onclick="location.href='/board/replyWrite.jsp?reRef=<%=boardVO.getReRef() %>&reLev=<%=boardVO.getReLev() %>&reSeq=<%=boardVO.getReSeq() %>&pageNum=<%=pageNum %>'">
                                    <span class="align-middle">답글</span>
                                 </button>
			                	  <% 
				                  	}
				                  %>
                                <button type="button" class="btn btn-outline-dark ml-3"
                                    onclick="location.href = '/board/boardList.jsp?pageNum=<%=pageNum %>'" >
                                    <span class="align-middle">목록</span>
                                </button>
                            </div>
                            <!-- end of Comment -->
                        </div>
                        <!-- end of Contents area -->
                    </div>
                    <!-- end of Right area -->
                </div>
            </div>
            <br>
        </section>
        <!-- end of middle container -->
        
    <!-- footer area -->
  	<jsp:include page="/include/bottom.jsp" />
  	<!-- end of footer area -->
  	
  	  <script>
    // 글삭제 버튼을 클릭하면 호출되는 함수
  	function remove(event) {
    	event.preventDefault(); // a태그 기본동작 막기
    	
  		var isRemove = confirm('이 글을 삭제하시겠습니까?');
  		if (isRemove == true) {
  			location.href = '/board/boardRemove.jsp?num=<%=boardVO.getNum() %>&pageNum=<%=pageNum %>';
  		}
  	}
  </script>
</body>

</html>