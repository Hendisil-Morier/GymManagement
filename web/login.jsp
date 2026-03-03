<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gym Management - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%); min-height: 100vh; display: flex; align-items: center; }
        .login-card { background: rgba(255,255,255,0.95); border-radius: 20px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); overflow: hidden; }
        .brand-side { background: linear-gradient(135deg, #e94560, #0f3460); color: white; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 40px; }
        .brand-side h1 { font-weight: 800; font-size: 2.5rem; }
        .brand-side i { font-size: 5rem; margin-bottom: 20px; }
        .form-control:focus { border-color: #e94560; box-shadow: 0 0 0 0.2rem rgba(233,69,96,0.25); }
        .btn-primary { background: #e94560; border-color: #e94560; }
        .btn-primary:hover { background: #c73a52; border-color: #c73a52; }
        .btn-outline-primary { color: #e94560; border-color: #e94560; }
        .btn-outline-primary:hover { background: #e94560; border-color: #e94560; }
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
                        <p class="text-center mt-2">Management System</p>
                        <hr class="w-50 bg-white">
                        <p class="text-center small">Manage members, packages, equipment & revenue</p>
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
                            <h3 class="mb-4 fw-bold"><i class="fas fa-sign-in-alt me-2"></i>Sign In</h3>
                            <form method="post" action="${pageContext.request.contextPath}/login">
                                <div class="mb-3">
                                    <label class="form-label"><i class="fas fa-user me-1"></i> Username</label>
                                    <input type="text" name="username" class="form-control form-control-lg" required placeholder="Enter username">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label"><i class="fas fa-lock me-1"></i> Password</label>
                                    <input type="password" name="password" class="form-control form-control-lg" required placeholder="Enter password">
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg w-100 mb-3"><i class="fas fa-sign-in-alt me-2"></i>Login</button>
                            </form>
                            <p class="text-center">Don't have an account? <a href="#" onclick="toggleForm()" class="text-decoration-none" style="color:#e94560">Register here</a></p>
                        </div>

                        <div id="registerForm" style="${showRegister ? '' : 'display:none'}">
                            <h3 class="mb-4 fw-bold"><i class="fas fa-user-plus me-2"></i>Register</h3>
                            <form method="post" action="${pageContext.request.contextPath}/login">
                                <input type="hidden" name="action" value="register">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Username</label>
                                        <input type="text" name="username" class="form-control" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" name="password" class="form-control" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" name="fullName" class="form-control" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Phone</label>
                                        <input type="text" name="phone" class="form-control">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Gender</label>
                                    <select name="gender" class="form-select">
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg w-100 mb-3"><i class="fas fa-user-plus me-2"></i>Register</button>
                            </form>
                            <p class="text-center">Already have an account? <a href="#" onclick="toggleForm()" class="text-decoration-none" style="color:#e94560">Login here</a></p>
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
