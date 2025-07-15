<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lỗi hệ thống</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
    </head>
    <body class="bg-light text-center mt-5">
        <div class="container">
            <h3 class="text-danger">Đã xảy ra lỗi</h3>
            <p>${requestScope.errorMessage}</p>
            <a href="Presentation/Login.jsp" class="btn btn-primary">Quay về đăng nhập</a>
        </div>
    </body>
</html>
