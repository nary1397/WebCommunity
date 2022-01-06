<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
        <!-- Page Content-->
        <form class="form-signin" action="/member/loginPro.jsp" method="POST">
            <label for="inputId" class="sr-only">ID</label>
            <input type="text" name="id" id="inputId" class="form-control" placeholder="아이디" required autofocus>
            <br>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" name="passwd" id="inputPassword" class="form-control" placeholder="비밀번호" required>
            <br>
            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" name="rememberMe" value="remember-me"> 로그인 상태 유지
                </label>
                <br>
            </div>
            <button class="w-100 btn btn-lg btn-outline-dark" type="submit">
                <span class="align-middle">로그인</span>
            </button>
            <hr class="featurette-divider">
            <div class="text-center text-secondary">
                <a href="/member/RecoverPassword.jsp">아이디/비밀번호 찾기</a>
                | <a href="/member/join.jsp">회원가입</a>
            </div>
            <br>
        </form>
    </main>

    <!-- footer area -->
  	<jsp:include page="/include/bottom.jsp" />
  	<!-- end of footer area -->
</body>

</html>