<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String id = (String) session.getAttribute("id"); %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <jsp:include page="/include/head.jsp" />
</head>

<body class="d-flex flex-column" style="height: 100%">
    <main class="flex-shrink-0">
    
    <!-- Navbar area -->
	<jsp:include page="/include/top.jsp" />
	<!-- end of Navbar area -->
	
        <!-- Pricing section-->
        <section class="py-5">
            <!-- middle container -->
            <div class="container mt-4 ">
                <div class="row justify-content-center">
                    <!-- Right area -->
                    <div class="col-sm-6 ">
                        <!-- Contents area -->
                        <div class="border p-4 rounded border-secondary">
                            <h5>회원 탈퇴</h5>
                            <hr class="featurette-divider">
                            <form action="/member/removeMemberPro.jsp" method="POST" id="frm">
                                <div class="form-group">
                                    <label for="id">
                                        <span class="align-middle">아이디</span>
                                    </label>
                                    <input type="text" class="form-control" id="id" value="<%=id %>" aria-describedby="idHelp" name="id"
                                        required autofocus>
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="passwd">
                                        <span class="align-middle">비밀번호</span>
                                    </label>
                                    <input type="password" class="form-control" id="passwd" aria-describedby="pwdHelp"
                                        name="passwd" required>
                                </div>
                                
                                <div class="my-3 text-center">
                                    <button type="submit" class="btn btn-outline-dark">회원탈퇴</button>
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

  <script>
    $('form#frm').on('submit', function (event) {
    	// alert() - 알림, confirm() - 확인 취소 버튼2개, prompt() - 직접 텍스트상자 입력
		var isDelete = confirm('정말 회원탈퇴 하시겠습니까?'); // true/false 리턴
		console.log('isDelete : ' + isDelete);
		
		if (isDelete == false) {
			event.preventDefault(); // form태그의 기본동작 막기
		}
    });
  </script>
</body>

</html>