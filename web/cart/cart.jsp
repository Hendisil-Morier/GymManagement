<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của tôi - Hệ thống Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f5f5f7; color: #222; }

        .sidebar {
            background: linear-gradient(180deg, #111, #1e1e1e);
            min-height: 100vh;
            color: white;
            position: fixed;
            width: 250px;
        }

        .sidebar .nav-link {
            color: rgba(255,255,255,0.7);
            padding: 12px 20px;
            border-radius: 8px;
            margin: 2px 10px;
            transition: all 0.3s;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: white;
            background: rgba(255,122,0,0.3);
        }

        .sidebar .nav-link i {
            width: 24px;
            text-align: center;
            margin-right: 10px;
        }

        .main-content {
            margin-left: 250px;
            padding: 30px;
        }

        .brand-logo {
            padding: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .brand-logo h4 {
            margin: 0;
            font-weight: 800;
        }

        .user-info {
            padding: 15px 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            position: absolute;
            bottom: 0;
            width: 100%;
        }

        .cart-table {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
        }

        .total-section {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
        }
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
            <a class="nav-link" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Gói tập</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="fas fa-clipboard-list"></i> Đơn hàng</a>
            <c:if test="${sessionScope.user.role == 'Member'}">
                <a class="nav-link active" href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Giỏ hàng của tôi</a>
            </c:if>
        </nav>
        <div class="user-info">
            <small class="text-muted">Đăng nhập với</small>
            <div class="fw-bold">${sessionScope.user.username} <span class="badge bg-info">${sessionScope.user.role}</span></div>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-sm btn-outline-danger mt-2 w-100"><i class="fas fa-sign-out-alt me-1"></i>Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <h2  class="fw-bold text-dark"><i class="fas fa-shopping-cart me-2" style="color:#ff7a00"></i>Giỏ hàng của tôi</h2>

        <c:choose>
            <c:when test="${empty cart.items}">
                <div class="text-center py-5">
                    <i class="fas fa-shopping-cart fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">Giỏ hàng của bạn đang trống</h4>
                    <p class="text-muted">Hãy xem các gói tập và dịch vụ để bắt đầu!</p>
                    <a href="${pageContext.request.contextPath}/packages" class="btn btn-danger mt-2">
                        <i class="fas fa-box me-1"></i>Xem gói tập
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card cart-table">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Tên mục</th>
                                    <th>Loại</th>
                                    <th>Số lượng</th>
                                    <th>Giá</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}" varStatus="vs">
                                    <tr>
                                        <td>${vs.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.itemType == 'Package'}">${item.packageName}</c:when>
                                                <c:otherwise>${item.serviceName}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.itemType == 'Package'}">
                                                    <span class="badge bg-primary">Gói tập</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">Dịch vụ</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${item.quantity}</td>
                                        <td class="fw-bold">${item.price} VND</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/cart?action=remove&index=${vs.index}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa mục này khỏi giỏ hàng?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="total-section p-4 mt-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">Tổng tiền</h4>
                        <h3 class="mb-0" style="color:#ff7a00">${cart.total} VND</h3>
                    </div>
                </div>

                <div class="d-flex gap-3 mt-4 justify-content-end">
                    <a href="${pageContext.request.contextPath}/cart?action=clear" class="btn btn-outline-secondary" onclick="return confirm('Xóa toàn bộ mục trong giỏ hàng?')">
                        <i class="fas fa-trash-alt me-1"></i>Xóa giỏ hàng
                    </a >
                    <a href="${pageContext.request.contextPath}/cart?action=checkout" class="btn btn-danger btn-lg">
                        <i class="fas fa-credit-card me-1"></i>Thanh toán
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
