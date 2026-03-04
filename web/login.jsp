<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Gym - Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 40%, #ffe1c2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            overflow: hidden;
            color: #222;
        }
        .brand-side {
            position: relative;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px;
            background: linear-gradient(135deg, rgba(0,0,0,0.6), rgba(0,0,0,0.8)),
                        url("https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg?auto=compress&cs=tinysrgb&w=1200")
                        center/cover no-repeat;
        }
        .brand-side h1 { font-weight: 800; font-size: 2.5rem; letter-spacing: 2px; }
        .brand-side i { font-size: 5rem; margin-bottom: 20px; color: #ffb066; }
        .form-control {
            background-color: #f8f9fa;
            border-color: #ced4da;
            color: #222;
        }
        .form-control::placeholder {
            color: #999;
        }
        .form-control:focus {
            border-color: #ff7a00;
            box-shadow: 0 0 0 0.2rem rgba(255,122,0,0.25);
            background-color: #ffffff;
            color: #222;
        }
        .btn-primary { background: #ff7a00; border-color: #ff7a00; }
        .btn-primary:hover { background: #e56d00; border-color: #e56d00; }
        .btn-outline-primary { color: #ff7a00; border-color: #ff7a00; }
        .btn-outline-primary:hover { background: #ff7a00; border-color: #ff7a00; color: #000; }
        .text-link { color: #ff7a00; }
        .text-link:hover { color: #e56d00; }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="login-card">
                <div class="row g-0">
                    <div class="col-md-5 brand-side d-none d-md-flex">
                        <i class="fas fa-dumbbell"></i>
                        <h1>GYM</h1>
                        <p class="text-center mt-2">Hệ Thống Quản Lý</p>
                        <hr class="w-50 bg-white">
                        <p class="text-center small">Quản lý hội viên, gói tập, thiết bị &amp; doanh thu</p>
                    </div>
                    <div class="col-md-7 p-5">
                        <c:if test="${not empty errorMsg}">
                            <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${errorMsg}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                        </c:if>
                        <c:if test="${not empty successMsg}">
                            <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${successMsg}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                        </c:if>

                        <div id="loginForm" style="${showRegister ? 'display:none' : ''}">
                            <h3 class="mb-4 fw-bold"><i class="fas fa-sign-in-alt me-2"></i>Đăng nhập</h3>
                            <form method="post" action="${pageContext.request.contextPath}/login">
                                <div class="mb-3">
                                    <label class="form-label"><i class="fas fa-user me-1"></i> Tên đăng nhập</label>
                                    <input type="text" name="username" class="form-control form-control-lg" required placeholder="Nhập tên đăng nhập">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label"><i class="fas fa-lock me-1"></i> Mật khẩu</label>
                                    <input type="password" name="password" class="form-control form-control-lg" required placeholder="Nhập mật khẩu">
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg w-100 mb-3"><i class="fas fa-sign-in-alt me-2"></i>Đăng nhập</button>
                            </form>
                            <p class="text-center">Chưa có tài khoản? <a href="#" onclick="toggleForm()" class="text-decoration-none text-link">Đăng ký tại đây</a></p>
                        </div>

                        <div id="registerForm" style="${showRegister ? '' : 'display:none'}">
                            <h3 class="mb-4 fw-bold"><i class="fas fa-user-plus me-2"></i>Đăng ký tài khoản</h3>
                            <form method="post" action="${pageContext.request.contextPath}/login">
                                <input type="hidden" name="action" value="register">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên đăng nhập</label>
                                        <input type="text" name="username" class="form-control" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Mật khẩu</label>
                                        <input type="password" name="password" class="form-control" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Họ và tên</label>
                                    <input type="text" name="fullName" class="form-control" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="text" name="phone" class="form-control">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Giới tính</label>
                                    <select name="gender" class="form-select">
                                        <option value="Male">Nam</option>
                                        <option value="Female">Nữ</option>
                                        <option value="Other">Khác</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg w-100 mb-3"><i class="fas fa-user-plus me-2"></i>Đăng ký</button>
                            </form>
                            <p class="text-center">Đã có tài khoản? <a href="#" onclick="toggleForm()" class="text-decoration-none text-link">Đăng nhập tại đây</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function toggleForm() {
    var login = document.getElementById('loginForm');
    var register = document.getElementById('registerForm');
    login.style.display = login.style.display === 'none' ? '' : 'none';
    register.style.display = register.style.display === 'none' ? '' : 'none';
}
</script>
</body>
</html>
