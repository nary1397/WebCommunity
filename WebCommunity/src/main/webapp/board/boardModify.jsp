<%@page import="com.example.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 세션에서 로그인 아이디 가져오기 --%>
<% String id = (String) session.getAttribute("id"); %>

<% 
// num  pageNum 파라미터 가져오기 
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum"); 

// DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
AttachDAO attachDAO = AttachDAO.getInstance();

// 글번호에 해당하는 글내용 가져오기
BoardVO boardVO = boardDAO.getBoard(num);
// 글번호에 해당하는 첨부파일 리스트 가져오기
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
        <div class="container mt-5">
            <div class="row justify-content-center">
                <!-- Right area -->
                <div class="col-sm-9">
                    <!-- Contents area -->
                    <div class="border border-secondary p-4 rounded">
                    
                        <h5>글수정</h5>
                        <hr class="featurette-divider">
                        
                        <form action="/board/boardModifyPro.jsp" method="POST" enctype="multipart/form-data">
                        	<input type="hidden" name="pageNum" value="<%=pageNum %>">
              				<input type="hidden" name="num" value="<%=boardVO.getNum() %>">
			              	
                            <div class="form-group">
                                <label for="id">아이디</label>
                                <input type="text" class="form-control" id="id" aria-describedby="idHelp" name="id"
                                    value="<%=id %>" readonly>
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input type="text" class="form-control" id="title" name="subject" autofocus value="<%=boardVO.getSubject() %>">
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="textarea1">내용</label>
                                <textarea class="form-control" id="textarea1" rows="10" name="content"><%=boardVO.getContent() %></textarea>
                            </div>
                            <br>
                            
                    		<div class="row">
							  <div class="col s12">
								<button type="button" class="btn btn-small btn-outline-dark" id="btnAddFile">파일 추가</button>	
							  </div>
							</div>
							
							<!-- 기존 첨부파일 영역 -->
                            <div class="row" id="olfFileBox">
                            <%
			                for (AttachVO attach : attachList) {
			                	%>
			                	<%-- .delete-oldfile 버튼 클릭시 hidden input의 name 속성값이 oldfile -> delfile 변환됨 --%>
								 <input type="hidden" class="form-control" name="oldfile" value="<%=attach.getUuid() %>">
								<div class="input-group">
								  <span class="filename"><%=attach.getFilename() %></span>
								  <button class="btn btn-outline-secondary delete-oldfile" type="button">Delete</button>
								</div>
			                <%
			                	}
			                %>
                            </div>
                            
                            <!-- 신규 첨부파일 영역 -->
                			<div class="row" id="newFileBox"></div>
                            
                            <div class="my-4 text-center">
                                <button type="submit" class="btn btn-outline-dark">
                                    <span class="align-middle">글수정</span>
                                </button>
                                <button type="reset" class="btn btn-outline-dark ml-3">
                                    <span class="align-middle">초기화</span>
                                </button>
                                <button type="button" class="btn btn-outline-dark ml-3"
                                    onclick="location.href = '/board/boardList.jsp?pageNum=<%=pageNum %>'">
                                    <span class="align-middle">글목록</span>
                                </button>
                            </div>
                        </form>
                    </div>
                    <!-- end of Contents area -->
                </div>
                <!-- end of Right area -->
            </div>
        </div>
        <!-- end of middle container -->
	</main>
  <!-- footer area -->
  <jsp:include page="/include/bottom.jsp" />
  <!-- end of footer area -->
  
  <!-- Scripts -->
  <jsp:include page="/include/commonJs.jsp" />
  <script>
  	var fileIndex = 0;
  	
  	var currentfileCount = <%=attachList.size() %>;  // 현재 첨부된 파일 갯수
  	const MAX_FILE_COUNT = 5; // 최대 첨부파일 갯수
  
  	// [첨부파일 추가] 버튼을 클릭하면
    $('button#btnAddFile').on('click', function () {
    	if (currentfileCount >= MAX_FILE_COUNT) {
    		alert(`첨부파일은 최대 \${MAX_FILE_COUNT}개 까지만 첨부할 수 있습니다.`);
    		return;
    	}
    	
    	var str = `
    		<div class="col s12">
	            <input type="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload" name="file\${fileIndex}">
	            <button class="btn btn-outline-secondary file-delete" type="button" id="inputGroupFileAddon04">Delete</button>
            </div>
    	`;
    	
    	$('div#newFileBox').append(str);
    	
    	fileIndex++;
    	currentfileCount++;
    });
    
    // 동적 이벤트 연결 (이벤트 등록을 이미 존재하는 요소에게 위임하는 방식)
    $('div#newFileBox').on('click', 'button.file-delete', function () {
    	
    	//$(this).closest('div').remove(); // empty()와 구분 유의!
    	$(this).parent().remove();
    	
    	currentfileCount--;
    });
    
    // 기존 첨부파일에 삭제버튼 눌렀을때
    $('button.delete-oldfile').on('click', function () {
    	
    	$(this).parent().prev().prop('name', 'delfile'); // oldfile -> delfile(서버에서 찾을 파라미터값. 파일삭제용도)
    	
    	// 현재 클릭한 요소의 직계부모(parent) 요소를 삭제하기
    	$(this).parent().remove();
    	currentfileCount--;
    });
    
  </script>
</body>

</html>




