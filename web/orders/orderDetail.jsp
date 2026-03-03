<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - Hệ thống Gym</title>

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

        .detail-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            border: none;
        }

        .info-label {
            font-size: 0.85rem;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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

    <a href="${pageContext.request.contextPath}/orders"
       class="btn btn-outline-secondary mb-4">
        <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách đơn hàng
    </a>

    <div class="card detail-card mb-4">
        <div class="card-body p-4">

            <h4 class="mb-4">
                <i class="fas fa-receipt me-2" style="color:#ff7a00"></i>
                Đơn hàng #${order.orderId}
            </h4>

            <div class="row g-4">

                <div class="col-md-4">
                    <div class="info-label">Hội viên</div>
                    <div class="fw-bold fs-5">${orderMember.fullName}</div>
                </div>

                <div class="col-md-4">
                    <div class="info-label">Ngày đặt</div>
                    <div class="fw-bold fs-5">${order.orderDate}</div>
                </div>

                <div class="col-md-4">
                    <div class="info-label">Trạng thái</div>
                    <div>
                        <c:choose>
                            <c:when test="${order.status == 'Pending'}">
                                <span class="badge bg-warning text-dark fs-6">Chờ duyệt</span>
                            </c:when>
                            <c:when test="${order.status == 'Approved'}">
                                <span class="badge bg-info fs-6">Đã duyệt</span>
                            </c:when>
                            <c:when test="${order.status == 'Active'}">
                                <span class="badge bg-success fs-6">Đang hoạt động</span>
                            </c:when>
                            <c:when test="${order.status == 'Expired'}">
                                <span class="badge bg-secondary fs-6">Hết hạn</span>
                            </c:when>
                            <c:when test="${order.status == 'Cancelled'}">
                                <span class="badge bg-danger fs-6">Đã hủy</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-dark fs-6">${order.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="info-label">Ngày bắt đầu</div>
                    <div class="fw-bold">${order.startDate}</div>
                </div>

                <div class="col-md-4">
                    <div class="info-label">Ngày kết thúc</div>
                    <div class="fw-bold">${order.endDate}</div>
                </div>

                <div class="col-md-4">
                    <div class="info-label">Tổng tiền</div>
                    <div class="fw-bold fs-4" style="color:#ff7a00">
                        ${order.totalAmount} VND
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="card detail-card">
        <div class="card-body p-4">
            <h5 class="mb-3">
                <i class="fas fa-list me-2"></i>Chi tiết đơn hàng
            </h5>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Loại mục</th>
                            <th>ID</th>
                            <th>Số lượng</th>
                            <th>Giá</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="d" items="${details}" varStatus="vs">
                            <tr>
                                <td>${vs.index + 1}</td>
                                <td>
                                    <span class="badge ${d.itemType == 'Package' ? 'bg-primary' : 'bg-success'}">
                                        ${d.itemType == 'Package' ? 'Gói tập' : 'Dịch vụ'}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.itemType == 'Package'}">
                                            ${d.packageId}
                                        </c:when>
                                        <c:otherwise>
                                            ${d.serviceId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${d.quantity}</td>
                                <td class="fw-bold">${d.price} VND</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>