<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử hội viên - Hệ thống Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #111; color: #f5f5f5; }
        .sidebar { background: linear-gradient(180deg, #000, #1a1a1a); min-height: 100vh; color: white; position: fixed; width: 250px; }
        .sidebar .nav-link { color: rgba(255,255,255,0.7); padding: 12px 20px; border-radius: 8px; margin: 2px 10px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: white; background: rgba(255,122,0,0.3); }
        .sidebar .nav-link i { width: 24px; text-align: center; margin-right: 10px; }
        .main-content { margin-left: 250px; padding: 30px; }
        .brand-logo { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .brand-logo h4 { margin: 0; font-weight: 800; }
        .user-info { padding: 15px 20px; border-top: 1px solid rgba(255,255,255,0.1); position: absolute; bottom: 0; width: 100%; }
        .profile-card { border-left: 4px solid #ff7a00; }
        .card { background:#1c1c1c; color:#f5f5f5; }
        .table { color:#f5f5f5; }
        .table thead.table-dark { background:#000; }
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/members"><i class="fas fa-users"></i> Hội viên</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/equipment"><i class="fas fa-cogs"></i> Thiết bị</a>
            </c:if>
            <c:if test="${sessionScope.user.role == 'Admin'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/suppliers"><i class="fas fa-truck"></i> Nhà cung cấp</a>
            </c:if>
            <a class="nav-link" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Gói tập</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="fas fa-clipboard-list"></i> Đơn hàng</a>
            <c:if test="${sessionScope.user.role == 'Member'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Giỏ hàng của tôi</a>
            </c:if>
        </nav>
        <div class="user-info">
            <small class="text-muted">Đăng nhập với</small>
            <div class="fw-bold">${sessionScope.user.username} <span class="badge bg-info">${sessionScope.user.role}</span></div>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-sm btn-outline-danger mt-2 w-100"><i class="fas fa-sign-out-alt me-1"></i>Đăng xuất</a>
        </div>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-history me-2" style="color:#ff7a00"></i>Lịch sử hội viên</h2>
            <a href="${pageContext.request.contextPath}/members" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách hội viên
            </a>
        </div>

        <div class="card shadow-sm profile-card mb-4">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-auto">
                        <div class="rounded-circle bg-danger bg-opacity-10 d-flex align-items-center justify-content-center" style="width:70px;height:70px;">
                            <i class="fas fa-user fa-2x" style="color:#e94560"></i>
                        </div>
                    </div>
                    <div class="col">
                        <h4 class="mb-1">${member.fullName}</h4>
                        <span class="text-muted">${member.email}</span>
                    </div>
                    <div class="col-auto text-end">
                        <div class="mb-1">
                            <c:choose>
                                <c:when test="${member.memberType == 'VIP'}">
                                    <span class="badge bg-danger fs-6">VIP</span>
                                </c:when>
                                <c:when test="${member.memberType == 'Loyal'}">
                                    <span class="badge bg-warning text-dark fs-6">Loyal</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-primary fs-6">New</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="row text-center">
                        <div class="col-md-3">
                            <small class="text-muted d-block">Số điện thoại</small>
                            <span class="fw-semibold">${member.phone}</span>
                        </div>
                        <div class="col-md-3">
                            <small class="text-muted d-block">Giới tính</small>
                            <span class="fw-semibold">${member.gender}</span>
                        </div>
                        <div class="col-md-3">
                            <small class="text-muted d-block">Ngày tham gia</small>
                            <span class="fw-semibold">${member.joinDate}</span>
                        </div>
                        <div class="col-md-3">
                            <small class="text-muted d-block">Tổng chi tiêu</small>
                            <span class="fw-bold text-danger">${member.totalSpending} VND</span>
                        </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white">
                <h5 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Lịch sử đơn hàng</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Mã đơn</th>
                                <th>Ngày đặt</th>
                                <th>Trạng thái</th>
                                <th>Tổng tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td><span class="fw-semibold">#${order.orderId}</span></td>
                                    <td>${order.orderDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'Completed'}">
                                                <span class="badge bg-success">Hoàn tất</span>
                                            </c:when>
                                            <c:when test="${order.status == 'Pending'}">
                                                <span class="badge bg-warning text-dark">Đang chờ</span>
                                            </c:when>
                                            <c:when test="${order.status == 'Cancelled'}">
                                                <span class="badge bg-danger">Đã hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-semibold">${order.totalAmount} VND</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-4">
                                        <i class="fas fa-inbox fa-2x mb-2 d-block"></i>Không có lịch sử đơn hàng.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
