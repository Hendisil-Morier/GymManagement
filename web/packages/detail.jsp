<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Package Detail - Gym Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .sidebar { background: linear-gradient(180deg, #1a1a2e, #16213e); min-height: 100vh; color: white; position: fixed; width: 250px; }
        .sidebar .nav-link { color: rgba(255,255,255,0.7); padding: 12px 20px; border-radius: 8px; margin: 2px 10px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: white; background: rgba(233,69,96,0.3); }
        .sidebar .nav-link i { width: 24px; text-align: center; margin-right: 10px; }
        .main-content { margin-left: 250px; padding: 30px; }
        .brand-logo { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .brand-logo h4 { margin: 0; font-weight: 800; }
        .user-info { padding: 15px 20px; border-top: 1px solid rgba(255,255,255,0.1); position: absolute; bottom: 0; width: 100%; }
        .detail-card { border: none; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .price-display { font-size: 2.5rem; font-weight: 800; color: #e94560; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="brand-logo text-center">
            <i class="fas fa-dumbbell fa-2x mb-2" style="color:#e94560"></i>
            <h4>GYM SYSTEM</h4>
        </div>
        <nav class="nav flex-column mt-3">
            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/members"><i class="fas fa-users"></i> Members</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/equipment"><i class="fas fa-cogs"></i> Equipment</a>
            </c:if>
            <c:if test="${sessionScope.user.role == 'Admin'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/suppliers"><i class="fas fa-truck"></i> Suppliers</a>
            </c:if>
            <a class="nav-link active" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Packages</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="fas fa-clipboard-list"></i> Orders</a>
            <c:if test="${sessionScope.user.role == 'Member'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> My Cart</a>
            </c:if>
        </nav>
        <div class="user-info">
            <small class="text-muted">Logged in as</small>
            <div class="fw-bold">${sessionScope.user.username} <span class="badge bg-info">${sessionScope.user.role}</span></div>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-sm btn-outline-danger mt-2 w-100"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
        </div>
    </div>

    <div class="main-content">
        <a href="${pageContext.request.contextPath}/packages" class="btn btn-outline-secondary mb-4">
            <i class="fas fa-arrow-left me-1"></i>Back to Packages
        </a>

        <div class="card detail-card">
            <div class="card-body p-5">
                <div class="row">
                    <div class="col-md-8">
                        <h2 class="mb-3">${pkg.packageName}</h2>
                        <p class="text-muted fs-5">${pkg.description}</p>
                        <div class="d-flex gap-3 mt-4">
                            <div class="bg-light rounded-3 p-3 text-center" style="min-width:120px">
                                <i class="fas fa-calendar-alt fa-lg mb-2" style="color:#e94560"></i>
                                <div class="fw-bold">${pkg.durationMonth} Month<c:if test="${pkg.durationMonth > 1}">s</c:if></div>
                                <small class="text-muted">Duration</small>
                            </div>
                            <div class="bg-light rounded-3 p-3 text-center" style="min-width:120px">
                                <i class="fas fa-info-circle fa-lg mb-2" style="color:#e94560"></i>
                                <div class="fw-bold">${pkg.status}</div>
                                <small class="text-muted">Status</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 text-center d-flex flex-column justify-content-center">
                        <div class="price-display">${pkg.price} VND</div>
                        <c:if test="${sessionScope.user.role == 'Member'}">
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-3">
                                <input type="hidden" name="action" value="addPackage">
                                <input type="hidden" name="packageId" value="${pkg.packageId}">
                                <button type="submit" class="btn btn-danger btn-lg w-100">
                                    <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                </button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
