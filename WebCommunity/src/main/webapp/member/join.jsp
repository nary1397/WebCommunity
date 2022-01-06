<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                            <h5>회원 가입</h5>
                            <hr class="featurette-divider">
                            <form action="/member/joinPro.jsp" method="POST">
                                <div class="form-group">
                                    <label for="id">
                                        <span class="align-middle">아이디</span>
                                    </label>
                                    <input type="text" class="form-control" id="id" aria-describedby="idHelp" name="id"
                                        required autofocus>
                                    <small id="idHelp" class="form-text text-muted">아이디는 필수 입력 요소입니다.</small>
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="password">
                                        <span class="align-middle">비밀번호</span>
                                    </label>
                                    <input type="password" class="form-control" id="password" aria-describedby="pwdHelp"
                                        name="passwd" required>
                                    <small id="pwdHelp" class="form-text text-muted">비밀번호는 필수 입력 요소입니다.</small>
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="password2">
                                        <span class="align-middle">비밀번호 재확인</span>
                                    </label>
                                    <input type="password" class="form-control" id="password2">
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="name">
                                        <span class="align-middle">이름</span>
                                    </label>
                                    <input type="text" class="form-control" id="name" name="name">
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="birthday">
                                        <span class="align-middle">생년월일</span>
                                    </label>
                                    <input type="date" class="form-control" id="birthday" name="birthday">
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="gender">
                                        <span class="align-middle">성별 선택</span>
                                    </label>
                                    <select class="form-control" id="gender" name="gender">
                                        <option value="" disabled selected>성별을 선택하세요.</option>
                                        <option value="M">남자</option>
                                        <option value="F">여자</option>
                                        <option value="U">선택 안함</option>
                                    </select>
                                </div>
                                <br>
                                <div class="form-group">
                                    <label for="email">
                                        <span class="align-middle">이메일 주소</span>
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email">
                                </div>
                                <br>
                                <div class="text-center">
                                    <label class="mr-3">이벤트 등 알림 메일 수신동의 : </label>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="recvEmail" id="recvEmailYes"
                                            value="Y" checked>
                                        <label class="form-check-label" for="recvEmailYes">동의함</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="recvEmail" id="recvEmailNo"
                                            value="N">
                                        <label class="form-check-label" for="recvEmailNo">동의 안함</label>
                                    </div>
                                </div>
                                <div class="my-3 text-center">
                                    <button type="submit" class="btn btn-outline-dark">회원가입</button>
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
	// 입력 문자개수 보이기 기능 활성화
	$('input#id, input#passwd, input#passwd2').characterCounter();
	
/* 	// 아이디 중복확인 버튼 클릭 이벤트 연결
	$('button#btnIdDupChk').on('click', function () {
		// 사용자가 입력한 아이디 문자열 가져오기
		var id = $('input#id').val();
		console.log('id : ' + id);
		
		// id가 공백이면 '아이디 입력하세요' 포커스 주기
		if (id == '') { // id.length == 0
			alert('아이디 입력하세요');
			$('input#id').focus();
			return;
		}
		
		// id 중복확인 자식창 열기  window.open();
		open('/member/joinIdDupChk.jsp?id=' + id, 'idDupChk', 'width=500,height=400');
	});
	 */
	
	
	$('input#id').on('keyup', function () {
		
		var id = $(this).val();
		if (id.length == 0) {
			return;
		}
		
		var $inputId = $(this);
		var $span = $(this).next().next();
		
		// ajax 함수 호출
		$.ajax({
			url: '/api/members/' + id,
			method: 'GET',
			success: function (data) {
				console.log(data);
				console.log(typeof data);
				
				if (data.count == 0) {
					$span.html('사용가능한 아이디 입니다').css('color', 'green');
					$inputId.removeClass('invalid').addClass('valid');
				} else { // data.count == 1
					$span.html('이미 사용중인 아이디 입니다').css('color', 'red');
					$inputId.removeClass('valid').addClass('invalid');
				}
			} // success
		});
	});
	
	
	// #passwd2 요소에 포커스 아웃 이벤트 연결
	$('input#passwd2').on('focusout', function () {
		var passwd = $('input#passwd').val();
		var passwd2 = $(this).val();
		
		var $span = $(this).closest('div.input-field').find('span.helper-text');
		
		if (passwd == passwd2) {
			$span.html('비밀번호 일치함').css('color', 'green');
			$(this).removeClass('invalid').addClass('valid');
		} else {
			$span.html('비밀번호 불일치함').css('color', 'red');
			$(this).removeClass('valid').addClass('invalid');
		}
	});
  
  
    $('form#frm').on('submit', function (event) {
    	// 아이디 입력값 글자개수 검증
    	var id = $('#id').val();
    	if (id.length < 3 || id.length > 13) {
    		event.preventDefault(); // form태그의 기본동작 막기
    		
    		alert('아이디는 3글자 이상 13글자 이하만 가능합니다.');
    		$('#id').select();
    		return;
    	}
    	
    });
  </script>
</body>

</html>