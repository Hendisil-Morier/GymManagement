<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhà cung cấp - Hệ thống Gym</title>

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

        .card-custom {
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            border: none;
        }

        .btn-primary-custom {
            background: #ff7a00;
            border: none;
            color: white;
        }

        .btn-primary-custom:hover {
            background: #e86f00;
        }

        .table thead {
            background: #111;
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/suppliers">
                <i class="fas fa-truck"></i> Nhà cung cấp
            </a>
        </c:if>

        <a class="nav-link" href="${pageContext.request.contextPath}/packages">
            <i class="fas fa-box"></i> Gói tập
        </a>

        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-clipboard-list"></i> Đơn hàng
        </a>
    </nav>
</div>


<div class="main-content">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="fas fa-truck me-2" style="color:#ff7a00"></i>
            Danh sách nhà cung cấp
        </h2>

        <a href="${pageContext.request.contextPath}/suppliers?action=create"
           class="btn btn-primary-custom">
            <i class="fas fa-plus me-1"></i> Thêm nhà cung cấp
        </a>
    </div>


    <!-- SEARCH -->
    <div class="card card-custom mb-4">
        <div class="card-body">
            <form method="get"
                  action="${pageContext.request.contextPath}/suppliers"
                  class="row g-3 align-items-end">

                <div class="col-md-8">
                    <label class="form-label fw-semibold">Tìm kiếm</label>
                    <input type="text"
                           name="keyword"
                           class="form-control"
                           placeholder="Tìm theo tên công ty, email hoặc loại cung cấp..."
                           value="${param.keyword}">
                </div>

                <div class="col-md-4">
                    <button type="submit" class="btn btn-primary-custom me-2">
                        <i class="fas fa-search me-1"></i> Tìm
                    </button>

                    <a href="${pageContext.request.contextPath}/suppliers"
                       class="btn btn-outline-secondary">
                        Đặt lại
                    </a>
                </div>

            </form>
        </div>
    </div>


    <!-- MESSAGE -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle me-1"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-circle me-1"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>


    <!-- TABLE -->
    <div class="card card-custom">
        <div class="card-body p-0">

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">

                    <thead>
                    <tr>
                        <th>Tên công ty</th>
                        <th>Điện thoại</th>
                        <th>Email</th>
                        <th>Loại cung cấp</th>
                        <th>Địa chỉ</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="supplier" items="${suppliers}">
                        <tr>
                            <td class="fw-semibold">${supplier.companyName}</td>
                            <td>${supplier.phone}</td>
                            <td>${supplier.email}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${supplier.supplyType == 'Equipment'}">
                                        <span class="badge bg-primary">Thiết bị</span>
                                    </c:when>
                                    <c:when test="${supplier.supplyType == 'Supplement'}">
                                        <span class="badge bg-success">Thực phẩm bổ sung</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${supplier.supplyType}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${supplier.address}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${supplier.status == 'Active'}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Ngừng hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/suppliers?action=edit&id=${supplier.supplierId}"
                                   class="btn btn-sm btn-outline-warning me-1"
                                   title="Sửa">
                                    <i class="fas fa-edit"></i>
                                </a>

                                <a href="${pageContext.request.contextPath}/suppliers?action=delete&id=${supplier.supplierId}"
                                   class="btn btn-sm btn-outline-danger"
                                   title="Xóa"
                                   onclick="return confirm('Bạn có chắc muốn xóa nhà cung cấp này?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty suppliers}">
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">
                                <i class="fas fa-inbox fa-2x mb-2 d-block"></i>
                                Không có nhà cung cấp nào.
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