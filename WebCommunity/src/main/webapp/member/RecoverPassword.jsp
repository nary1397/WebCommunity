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
        <section class="py-5">
            <div class="container" style="width: 40%;">
                <div class="dialog card recover-password border-secondary">
                    <div class="card-block">
                        <h4 class="card-title">아이디/비밀번호 찾기</h4>
                        <h6 class="card-subtitle text-muted">
                            ID 또는 비밀번호를 찾습니다.
                        </h6>
                        <br>
                        <form action="" method="POST" id="signup_form">
                            <input type="hidden" name="_csrf" value="NDtrzTab-Af979Q8-71yQuTG5b-l-GeS0NHQ">
                            <div class="form-group row">
                                <label for="emailInput" class="col-3 col-form-label">이메일</label>
                                <div class="col-9">
                                    <input class="form-control" type="text" id="emailInput" name="email"
                                        style="width: 200px; display: inline-block">
                                    <p class="form-text text-muted">
                                        가입시 입력하신 이메일로 안내 메일을 보내드립니다.
                                    </p>
                                </div>
                            </div>
                            <div class="btns btn-recover-password">
                                <button class="btn btn-outline-dark" type="submit" id="submitBtn">아이디/비밀번호 찾기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- footer area -->
  	<jsp:include page="/include/bottom.jsp" />
  	<!-- end of footer area -->
</body>

</html>