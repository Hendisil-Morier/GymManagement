<%-- 
    Document   : confirm-switch
    Created on : Mar 17, 2026, 4:34:15 PM
    Author     : morier
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đổi gói tập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f5f5f7; }
        .confirm-card {
            max-width: 600px;
            margin: 80px auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.08);
            padding: 40px;
        }
        .pkg-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 16px 20px;
        }
        .pkg-box .price { color: #ff7a00; font-weight: 700; font-size: 1.2rem; }
        .warning-banner {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            border-radius: 8px;
            padding: 14px 18px;
        }
    </style>
</head>
<body>

<div class="confirm-card">
    <h4 class="mb-1">Đổi gói tập</h4>
    <p class="text-muted mb-4">Bạn đang có một gói tập đang hoạt động.</p>

    <div class="warning-banner mb-4">
        <i class="fas fa-exclamation-triangle me-2 text-warning"></i>
        Nếu bạn tiếp tục, gói tập hiện tại sẽ bị hủy và giá trị còn lại sẽ không được hoàn lại.
    </div>

    <div class="row g-3 mb-4">
        <div class="col-6">
            <small class="text-muted d-block mb-1">Gói hiện tại</small>
            <div class="pkg-box">
                <div class="fw-bold">${activePkg.packageName}</div>
                <div class="price">${activePkg.price} VND</div>
                <small class="text-muted">${activePkg.durationMonth} tháng</small>
            </div>
        </div>
        <div class="col-6">
            <small class="text-muted d-block mb-1">Gói mới</small>
            <div class="pkg-box">
                <div class="fw-bold">${newPkg.packageName}</div>
                <div class="price">${newPkg.price} VND</div>
                <small class="text-muted">${newPkg.durationMonth} tháng</small>
            </div>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex gap-2">
        <input type="hidden" name="action" value="confirmSwitch">
        <input type="hidden" name="packageId" value="${newPkg.packageId}">
        <input type="hidden" name="expireOrderId" value="${activeOrderId}">

        <a href="${pageContext.request.contextPath}/packages"
           class="btn btn-outline-secondary flex-fill">
            Hủy
        </a>
        <button type="submit" class="btn btn-lg flex-fill text-white"
                style="background:#ff7a00;border:none;">
            <i class="fas fa-check me-1"></i>Xác nhận đổi gói
        </button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
