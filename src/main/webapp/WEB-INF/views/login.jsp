<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Login</title>

</head>

<body>
    <div class="container">
        <div class="login-form">
            <div class="main-div">
                <div class="panel">
                    <h2>Login</h2>
                    <p>Please enter your email and password</p>
                    <c:if test="${not empty message}">
						<div class="alert alert-${alert}">
                        	<strong>${message}</strong>
                    	</div>                    
                    </c:if>
                </div>
                <form action="<c:url value='/login'/>" id="formLogin" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" id="userName" name="userName" placeholder="Username">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" id="password" name="password"
                            placeholder="Password">
                    </div>
                    <div class="forgot">
                        <a href="#">Forgot password?</a>
                    </div>
                    <input type="hidden" value="login" name="action" />
                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
            </div>
        </div>
    </div>

</body>

</html>