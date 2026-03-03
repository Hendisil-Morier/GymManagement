<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gói tập & Dịch vụ - Hệ thống Gym</title>

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

        .package-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            border: none;
            transition: all 0.25s;
        }

        .package-card:hover {
            transform: translateY(-6px);
        }

        .price-tag {
            font-size: 1.4rem;
            font-weight: 700;
            color: #ff7a00;
        }

        .duration-badge {
            background: #ff7a00;
            color: white;
            border-radius: 20px;
            padding: 4px 12px;
            font-size: 0.8rem;
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

        <a class="nav-link active" href="${pageContext.request.contextPath}/packages">
            <i class="fas fa-box"></i> Gói tập
        </a>

        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-clipboard-list"></i> Đơn hàng
        </a>

        <c:if test="${sessionScope.user.role == 'Member'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng của tôi
            </a>
        </c:if>
    </nav>
</div>


<div class="main-content">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="fas fa-box me-2" style="color:#ff7a00"></i>
            Danh sách gói tập
        </h2>

        <c:if test="${sessionScope.user.role == 'Admin'}">
            <button class="btn text-white"
                    style="background:#ff7a00"
                    data-bs-toggle="modal"
                    data-bs-target="#addPackageModal">
                <i class="fas fa-plus me-1"></i> Thêm gói tập
            </button>
        </c:if>
    </div>


    <!-- PACKAGES -->
    <div class="row g-4 mb-5">
        <c:forEach var="pkg" items="${packages}">
            <div class="col-md-6 col-lg-4">
                <div class="card package-card h-100">
                    <div class="card-body d-flex flex-column">

                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h5 class="card-title mb-0">${pkg.packageName}</h5>
                            <span class="duration-badge">
                                ${pkg.durationMonth} Tháng
                            </span>
                        </div>

                        <p class="card-text text-muted flex-grow-1">
                            ${pkg.description}
                        </p>

                        <div class="price-tag mb-3">
                            ${pkg.price} VND
                        </div>

                        <!-- MEMBER -->
                        <c:if test="${sessionScope.user.role == 'Member'}">
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="addPackage">
                                <input type="hidden" name="packageId" value="${pkg.packageId}">
                                <button type="submit"
                                        class="btn w-100 text-white"
                                        style="background:#ff7a00">
                                    <i class="fas fa-cart-plus me-1"></i>
                                    Thêm vào giỏ
                                </button>
                            </form>
                        </c:if>

                        <!-- ADMIN -->
                        <c:if test="${sessionScope.user.role == 'Admin'}">
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/packages?action=edit&id=${pkg.packageId}"
                                   class="btn btn-outline-primary flex-fill">
                                    <i class="fas fa-edit me-1"></i> Sửa
                                </a>

                                <a href="${pageContext.request.contextPath}/packages?action=delete&id=${pkg.packageId}"
                                   class="btn btn-outline-danger flex-fill"
                                   onclick="return confirm('Bạn có chắc muốn xóa gói này?')">
                                    <i class="fas fa-trash me-1"></i> Xóa
                                </a>
                            </div>
                        </c:if>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>


    <!-- SERVICES -->
    <h2 class="mb-4">
        <i class="fas fa-concierge-bell me-2" style="color:#ff7a00"></i>
        Dịch vụ bổ sung
    </h2>

    <div class="row g-4">
        <c:forEach var="svc" items="${services}">
            <div class="col-md-6 col-lg-4">
                <div class="card package-card h-100">
                    <div class="card-body d-flex flex-column">

                        <h5 class="card-title">${svc.serviceName}</h5>

                        <p class="card-text text-muted flex-grow-1">
                            ${svc.description}
                        </p>

                        <div class="price-tag mb-3">
                            ${svc.price} VND
                        </div>

                        <c:if test="${sessionScope.user.role == 'Member'}">
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="addService">
                                <input type="hidden" name="serviceId" value="${svc.serviceId}">
                                <button type="submit"
                                        class="btn w-100 text-white"
                                        style="background:#ff7a00">
                                    <i class="fas fa-cart-plus me-1"></i>
                                    Thêm vào giỏ
                                </button>
                            </form>
                        </c:if>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

</div>


<!-- MODAL ADMIN -->
<c:if test="${sessionScope.user.role == 'Admin'}">
<div class="modal fade" id="addPackageModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/packages" method="post">
                <input type="hidden" name="action" value="create">

                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-plus-circle me-2"></i>
                        Thêm gói tập mới
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <div class="mb-3">
                        <label class="form-label">Tên gói</label>
                        <input type="text" class="form-control" name="packageName" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Giá</label>
                        <input type="number" class="form-control" name="price" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Thời hạn (Tháng)</label>
                        <input type="number" class="form-control" name="durationMonth" min="1" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description" rows="3"></textarea>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn text-white" style="background:#ff7a00">
                        Tạo gói tập
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>