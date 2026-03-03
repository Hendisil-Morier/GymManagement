<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách đơn hàng - Hệ thống Gym</title>

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

        .card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            border: none;
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
        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
            <i class="fas fa-tachometer-alt"></i> Bảng điều khiển
        </a>

        <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/members">
                <i class="fas fa-users"></i> Hội viên
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/equipment">
                <i class="fas fa-cogs"></i> Thiết bị
            </a>
        </c:if>

        <c:if test="${sessionScope.user.role == 'Admin'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/suppliers">
                <i class="fas fa-truck"></i> Nhà cung cấp
            </a>
        </c:if>

        <a class="nav-link" href="${pageContext.request.contextPath}/packages">
            <i class="fas fa-box"></i> Gói tập
        </a>

        <a class="nav-link active" href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-clipboard-list"></i> Đơn hàng
        </a>

        <c:if test="${sessionScope.user.role == 'Member'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng của tôi
            </a>
        </c:if>
    </nav>

    <div class="user-info">
        <small class="text-muted">Đăng nhập với</small>
        <div class="fw-bold">
            ${sessionScope.user.username}
            <span class="badge bg-info">${sessionScope.user.role}</span>
        </div>
        <a href="${pageContext.request.contextPath}/login?action=logout"
           class="btn btn-sm btn-outline-danger mt-2 w-100">
            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
        </a>
    </div>
</div>

<div class="main-content">

    <h2 class="mb-4">
        <i class="fas fa-clipboard-list me-2" style="color:#ff7a00"></i>
        Danh sách đơn hàng
    </h2>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>Mã đơn</th>
                        <th>Hội viên</th>
                        <th>Ngày đặt</th>
                        <th>Trạng thái</th>
                        <th>Tổng tiền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>

                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td class="fw-bold">#${order.orderId}</td>

                        <td>
                            <c:forEach var="m" items="${allMembers}">
                                <c:if test="${m.memberId == order.memberId}">
                                    ${m.fullName}
                                </c:if>
                            </c:forEach>
                        </td>

                        <td>${order.orderDate}</td>

                        <td>
                            <c:choose>
                                <c:when test="${order.status == 'Pending'}">
                                    <span class="badge bg-warning text-dark">Chờ duyệt</span>
                                </c:when>
                                <c:when test="${order.status == 'Approved'}">
                                    <span class="badge bg-info">Đã duyệt</span>
                                </c:when>
                                <c:when test="${order.status == 'Active'}">
                                    <span class="badge bg-success">Đang hoạt động</span>
                                </c:when>
                                <c:when test="${order.status == 'Expired'}">
                                    <span class="badge bg-secondary">Hết hạn</span>
                                </c:when>
                                <c:when test="${order.status == 'Cancelled'}">
                                    <span class="badge bg-danger">Đã hủy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-dark">${order.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td class="fw-bold">${order.totalAmount} VND</td>

                        <td>
                            <a href="${pageContext.request.contextPath}/orders?action=detail&id=${order.orderId}"
                               class="btn btn-sm btn-outline-primary me-1"
                               title="Xem chi tiết">
                                <i class="fas fa-eye"></i>
                            </a>

                            <c:if test="${(sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff') && order.status == 'Pending'}">

                                <a href="${pageContext.request.contextPath}/orders?action=approve&id=${order.orderId}"
                                   class="btn btn-sm btn-outline-success me-1"
                                   onclick="return confirm('Bạn có chắc chắn muốn duyệt đơn hàng này?');"
                                   title="Duyệt">
                                    <i class="fas fa-check"></i>
                                </a>

                                <a href="${pageContext.request.contextPath}/orders?action=cancel&id=${order.orderId}"
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');"
                                   title="Hủy">
                                    <i class="fas fa-times"></i>
                                </a>

                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>