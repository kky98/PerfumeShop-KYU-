<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>회원가입</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
 
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
 
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="script.js"></script>

</head>
<body>
    <div class="container">
    <div class="row">
    <div class="col-sm-12 text-center" >
    <div class="col-sm-3"></div>
     
    <div class="col-sm-6">
    <h2>회원가입</h2>
    <form action="joinAction.jsp" method="post">
        <table class="table table-boardered">
            <tr>
                <th>아이디</th>
                <td>
                <input type="text" class="form-control" name="userID" placeholder="id를 입력하세요" style="margin:5px">
                </td>
                        
            </tr>
            <tr>
                <th>패스워드</th>
                <td><input type="password" class="form-control" name="userPassword" placeholder="비밀번호를 입력하세요"></td>      
            </tr>
             
            <tr>
                <th>이름</th>
                <td><input type="text" class="form-control" name="userName" placeholder="이름을 입력하세요"></td>        
            </tr>
             
            <tr>
                <th>이메일</th>
                <td><input type="email" class="form-control" name="userEmail"></td>       
            </tr>
             
            <tr>
                <th>전화번호</th>
                <td><input type="tel" class="form-control" name="userTel"></td>       
            </tr>
            
            <tr>
            	<th>성별</th>
            	<td>
            	<input type="radio" name="userSex" value="남성">남성&nbsp;&nbsp;&nbsp;&nbsp;
            	<input type="radio" name="userSex" value="여성">여성
            </tr> 
            
            <tr>
                <th>당신의 연령은</th>
                <td>
                <input type="radio"  name="userAge" value="10"> 10대
                <input type="radio"  name="userAge" value="20"> 20대
                <input type="radio"  name="userAge" value="30"> 30대 
                <input type="radio"  name="userAge" value="40"> 40대 
                </td>     
            </tr>
             
            <tr>
                <td colspan="2">
				<button type="submit" class="btn btn-default" value="회원가입" onclick="inputCheck()">가입하기</button>
				<button type="reset" class="btn btn-default" value="돌아가기" onClick="javascript:location.href='login.jsp'">돌아가기</button>
             
                </td>
            </tr>
             
             
        </table>
    </form>
    </div>
     
    </div>
    </div>
</div>
</body>
</html>