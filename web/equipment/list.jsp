<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thiết bị - Hệ thống Gym</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: #f5f5f7;
            color: #222;
        }

        /* ===== SIDEBAR ===== */
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

        /* ===== MAIN CONTENT ===== */
        .main-content {
            margin-left: 250px;
            padding: 30px;
        }

        h3 {
            color: #ff7a00;
        }

        /* ===== CARD ===== */
        .card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            border: none;
        }

        /* ===== TABLE ===== */
        .table thead {
            background: #111;
            color: white;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(255,122,0,0.05);
        }

        /* ===== BUTTON TONE CAM ===== */
        .btn-primary {
            background-color: #ff7a00;
            border-color: #ff7a00;
        }

        .btn-primary:hover {
            background-color: #e96d00;
            border-color: #e96d00;
        }

        .btn-outline-warning {
            border-color: #ff7a00;
            color: #ff7a00;
        }

        .btn-outline-warning:hover {
            background: #ff7a00;
            color: white;
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
            <i class="fas fa-home"></i> Trang chủ
        </a>

        <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/members">
                <i class="fas fa-users"></i> Hội viên
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/equipment">
                <i class="fas fa-dumbbell"></i> Thiết bị
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

        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-file-invoice"></i> Đơn hàng
        </a>

        <c:if test="${sessionScope.user.role == 'Member'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng
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

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold">
            <i class="fas fa-dumbbell me-2"></i>Quản lý Thiết bị
        </h3>

        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/equipment?action=maintenance"
               class="btn btn-outline-warning">
                <i class="fas fa-tools me-1"></i>Thiết bị bảo trì
            </a>

            <button type="button" class="btn btn-primary"
                    data-bs-toggle="modal" data-bs-target="#addEquipmentModal">
                <i class="fas fa-plus me-1"></i>Thêm thiết bị
            </button>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead>
                <tr>
                    <th>Tên thiết bị</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
                    <th>Ngày mua</th>
                    <th>Giá</th>
                    <th>Nhà cung cấp</th>
                    <th class="text-center">Thao tác</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="item" items="${equipmentList}">
                    <tr>
                        <td class="fw-semibold">${item.equipmentName}</td>
                        <td>${item.quantity}</td>

                        <td>
                            <c:choose>
                                <c:when test="${item.status == 'Active'}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:when>
                                <c:when test="${item.status == 'Maintenance'}">
                                    <span class="badge bg-warning text-dark">Bảo trì</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${item.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${item.purchaseDate}</td>
                        <td class="fw-bold">${item.purchasePrice} VNĐ</td>

                        <td>
                            <c:forEach var="s" items="${suppliers}">
                                <c:if test="${s.supplierId == item.supplierId}">
                                    ${s.companyName}
                                </c:if>
                            </c:forEach>
                        </td>

                        <td class="text-center">
                            <a href="${pageContext.request.contextPath}/equipment?action=reportMaintenance&id=${item.equipmentId}"
                               class="btn btn-sm btn-outline-warning me-1">
                                <i class="fas fa-tools"></i>
                            </a>

                            <a href="${pageContext.request.contextPath}/equipment?action=delete&id=${item.equipmentId}"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirm('Bạn có chắc muốn xóa thiết bị này?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty equipmentList}">
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">
                            Không có thiết bị nào.
                        </td>
                    </tr>
                </c:if>

                </tbody>
            </table>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>