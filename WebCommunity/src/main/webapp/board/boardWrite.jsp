<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 세션에서 로그인 아이디 가져오기 --%>
<% String id = (String) session.getAttribute("id"); %>

<%-- pageNum 파라미터 가져오기 --%>
<% String pageNum = request.getParameter("pageNum"); %>

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
                        <h5>게시판 새글쓰기</h5>
                        <hr class="featurette-divider">
                        <form action="/board/boardWritePro.jsp" method="POST" enctype="multipart/form-data">
                        	<input type="hidden" name="pageNum" value="<%=pageNum%>">
                            <div class="form-group">
                                <label for="id">아이디</label>
                                <input type="text" class="form-control" id="id" aria-describedby="idHelp" name="id"
                                    value="<%=id %>" readonly>
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="subject">제목</label>
                                <input type="text" class="form-control" id="subject" name="subject" autofocus>
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea class="form-control" id="content" rows="10" name="content"></textarea>
                            </div>
                            <br>
                            
                            <div class="row">
							  <div class="col s12">
								<button type="button" class="btn btn-small btn-outline-dark" id="btnAddFile">파일 추가</button>	
							  </div>
							</div>
							
                            <div class="row" id="fileBox">
								<div class="input-group">
								  <input type="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload" name="file0">
								  <button class="btn btn-outline-secondary file-delete" type="button" id="inputGroupFileAddon04">Delete</button>
								</div>
                            </div>

                            <div class="my-4 text-center">
                                <button type="submit" class="btn btn-outline-dark">
                                    <span class="align-middle">새글등록</span>
                                </button>
                                <button type="reset" class="btn btn-outline-dark ml-3">
                                    <span class="align-middle">초기화</span>
                                </button>
                                <button type="button" class="btn btn-outline-dark ml-3"
                                    onclick="location.href = '/board/boardList.jsp';">
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
  	<script>
  	var fileIndex = 1;
  	var fileCount = 1;
  
    $('button#btnAddFile').on('click', function () {
    	if (fileCount >= 5) {
    		alert('첨부파일은 최대 5개 까지만 첨부할 수 있습니다.');
    		return;
    	}
    	
    	var str = `
    		<div class="col s12">
	    		<input type="file" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload" name="file\${fileIndex}">
	    		<button class="btn btn-outline-secondary file-delete" type="button" id="inputGroupFileAddon04">Delete</button>
            </div>
    	`;
    	
    	$('div#fileBox').append(str);
    	
    	fileIndex++;
    	fileCount++;
    });
    
    // 동적 이벤트 연결 (이벤트 등록을 이미 존재하는 요소에게 위임하는 방식)
    $('div#fileBox').on('click', 'button.file-delete', function () {
    	
    	//$(this).closest('div').remove(); // empty()와 구분 유의!
    	$(this).parent().remove();
    	
    	fileCount--;
    });
    
  </script>
</body>

</html>