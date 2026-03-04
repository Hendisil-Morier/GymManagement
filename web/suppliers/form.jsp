<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty supplier}">Chỉnh sửa nhà cung cấp</c:when>
            <c:otherwise>Thêm nhà cung cấp</c:otherwise>
        </c:choose>
        - Hệ thống Gym
    </title>

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

        .form-card {
            background: #ffffff;
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
            <c:choose>
                <c:when test="${not empty supplier}">Chỉnh sửa nhà cung cấp</c:when>
                <c:otherwise>Thêm nhà cung cấp</c:otherwise>
            </c:choose>
        </h2>

        <a href="${pageContext.request.contextPath}/suppliers"
           class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left me-1"></i>Quay lại
        </a>
    </div>


    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-circle me-1"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>


    <div class="card form-card">
        <div class="card-body p-4">

            <form method="post" action="${pageContext.request.contextPath}/suppliers">

                <c:choose>
                    <c:when test="${not empty supplier}">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="supplierId" value="${supplier.supplierId}">
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="action" value="create">
                    </c:otherwise>
                </c:choose>


                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Tên công ty</label>
                        <input type="text"
                               class="form-control"
                               name="companyName"
                               value="${supplier.companyName}"
                               required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Số điện thoại</label>
                        <input type="text"
                               class="form-control"
                               name="phone"
                               value="${supplier.phone}"
                               required>
                    </div>

                </div>


                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <input type="email"
                               class="form-control"
                               name="email"
                               value="${supplier.email}"
                               required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-semibold">Loại cung cấp</label>
                        <select class="form-select" name="supplyType" required>
                            <option value="">-- Chọn loại --</option>
                            <option value="Equipment"
                                ${supplier.supplyType == 'Equipment' ? 'selected' : ''}>
                                Thiết bị
                            </option>
                            <option value="Supplement"
                                ${supplier.supplyType == 'Supplement' ? 'selected' : ''}>
                                Thực phẩm bổ sung
                            </option>
                        </select>
                    </div>

                </div>


                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ</label>
                    <textarea class="form-control"
                              name="address"
                              rows="3"
                              required>${supplier.address}</textarea>
                </div>


                <c:if test="${not empty supplier}">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Trạng thái</label>
                        <select class="form-select" name="status" required>
                            <option value="Active"
                                ${supplier.status == 'Active' ? 'selected' : ''}>
                                Hoạt động
                            </option>
                            <option value="Inactive"
                                ${supplier.status == 'Inactive' ? 'selected' : ''}>
                                Ngừng hoạt động
                            </option>
                        </select>
                    </div>
                </c:if>


                <div class="d-flex gap-2 mt-4">
                    <button type="submit" class="btn btn-primary-custom">
                        <i class="fas fa-save me-1"></i>
                        <c:choose>
                            <c:when test="${not empty supplier}">Cập nhật</c:when>
                            <c:otherwise>Tạo mới</c:otherwise>
                        </c:choose>
                    </button>

                    <a href="${pageContext.request.contextPath}/suppliers"
                       class="btn btn-outline-secondary">
                        Hủy
                    </a>
                </div>

            </form>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>