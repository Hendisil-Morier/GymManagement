<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Gym Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f5f5f7; color: #222; }
        .sidebar { background: linear-gradient(180deg, #111, #1e1e1e); min-height: 100vh; color: white; position: fixed; width: 250px; }
        .sidebar .nav-link { color: rgba(255,255,255,0.7); padding: 12px 20px; border-radius: 8px; margin: 2px 10px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: white; background: rgba(255,122,0,0.3); }
        .sidebar .nav-link i { width: 24px; text-align: center; margin-right: 10px; }
        .main-content { margin-left: 250px; padding: 30px; }
        .brand-logo { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .brand-logo h4 { margin: 0; font-weight: 800; }
        .user-info { padding: 15px 20px; border-top: 1px solid rgba(255,255,255,0.1); position: absolute; bottom: 0; width: 100%; }
        .checkout-card { border: none; border-radius: 16px; box-shadow: 0 8px 18px rgba(15,23,42,0.06); }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="brand-logo text-center">
            <i class="fas fa-dumbbell fa-2x mb-2" style="color:#ff7a00"></i>
            <h4>GYM SYSTEM</h4>
        </div>
        <nav class="nav flex-column mt-3">
            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-tachometer-alt"></i> Bảng điều khiển</a>
            <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/members"><i class="fas fa-users"></i> Hội viên</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/equipment"><i class="fas fa-cogs"></i> Thiết bị</a>
            </c:if>
            <c:if test="${sessionScope.user.role == 'Admin'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/suppliers"><i class="fas fa-truck"></i> Nhà cung cấp</a>
            </c:if>
       `       <a class="nav-link" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Gói tập</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="fas fa-clipboard-list"></i> Đơn hàng</a>
            <c:if test="${sessionScope.user.role == 'Member'}">
                <a class="nav-link active" href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Giỏ hàng</a>
            </c:if>
        </nav>
        <div class="user-info">
            <small class="text-muted">Logged in as</small>
            <div class="fw-bold">${sessionScope.user.username} <span class="badge bg-info">${sessionScope.user.role}</span></div>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-sm btn-outline-danger mt-2 w-100"><i class="fas fa-sign-out-alt me-1"></i>Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <h2  class="fw-bold text-dark"><i class="fas fa-credit-card me-2" style="color:#ff7a00"></i>Thanh toán</h2>

        <c:if test="${not empty successMsg}">
            <div class="alert alert-success d-flex align-items-center" role="alert">
                <i class="fas fa-check-circle fa-2x me-3"></i>
                <div>
                    <h5 class="mb-1">Đặt hàng thành công!</h5>
                    <p class="mb-2">${successMsg}</p>
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-success btn-sm">
                        <i class="fas fa-clipboard-list me-1"></i>Xem đơn hàng của tôi
                    </a>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <i class="fas fa-exclamation-circle fa-2x me-3"></i>
                <div>
                    <h5 class="mb-1">Thanh toán thất bại</h5>
                    <p class="mb-0">${errorMsg}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${empty successMsg && empty errorMsg}">
            <div class="card checkout-card">
                <div class="card-body p-4">
                    <h5 class="card-title mb-4">Tóm tắt đơn hàng</h5>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Tên mục</th>
                                    <th>Loại</th>
                                    <th>Số lượng</th>
                                    <th>Giá</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.itemType == 'Package'}">${item.packageName}</c:when>
                                                <c:otherwise>${item.serviceName}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="badge ${item.itemType == 'Package' ? 'bg-primary' : 'bg-success'}">${item.itemType}</span>
                                        </td>
                                        <td>${item.quantity}</td>
                                        <td class="fw-bold">${item.price} VND</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="mb-0">Tổng tiền</h4>
                        <h3 class="mb-0" style="color:#e94560">${cart.total} VND</h3>
                    </div>

                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="alert alert-info">
                                <h5 class="mb-2"><i class="fas fa-credit-card me-2"></i>Thanh toán VNPay</h5>
                                <p class="mb-1">Nhấn nút bên dưới để chuyển tới cổng thanh toán VNPay và hoàn tất giao dịch.</p>
                                <p class="fw-bold mb-0" style="color:#e94560">Số tiền: ${cart.total} VND</p>
                            </div>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="action" value="placeOrder">
                        <div class="d-flex gap-3 justify-content-end">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-1"></i>Quay lại giỏ hàng
                            </a>
                            <button type="submit" class="btn btn-danger btn-lg">
                                <i class="fas fa-check me-1"></i>Đặt hàng
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
