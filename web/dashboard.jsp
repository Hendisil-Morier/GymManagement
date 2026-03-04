<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển - Hệ thống Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f5f5f7; color: #222; }
        .sidebar { background: linear-gradient(180deg, #111, #1e1e1e); min-height: 100vh; color: white; position: fixed; width: 250px; }
        .sidebar .nav-link { color: rgba(255,255,255,0.7); padding: 12px 20px; border-radius: 8px; margin: 2px 10px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: white; background: rgba(255,122,0,0.3); }
        .sidebar .nav-link i { width: 24px; text-align: center; margin-right: 10px; }
        .main-content { margin-left: 250px; padding: 30px; }
        .dashboard-hero {
            background: linear-gradient(135deg, rgba(0,0,0,0.55), rgba(0,0,0,0.75)),
                        url("https://images.pexels.com/photos/841130/pexels-photo-841130.jpeg?auto=compress&cs=tinysrgb&w=1600")
                        center/cover no-repeat;
            border-radius: 18px;
            padding: 28px 32px;
            margin-bottom: 24px;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 12px 35px rgba(0,0,0,0.25);
        }
        .dashboard-hero h2 {
            font-size: 1.9rem;
            font-weight: 800;
            color: #ffb066;
        }
        .dashboard-hero p {
            margin: 4px 0 0;
            opacity: 0.9;
        }
        .dashboard-hero .hero-badge {
            background-color: rgba(255,122,0,0.18);
            border-radius: 999px;
            padding: 6px 14px;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .dashboard-hero .hero-right small {
            display: block;
            opacity: 0.8;
        }
        .stat-card { border: none; border-radius: 15px; box-shadow: 0 8px 18px rgba(15,23,42,0.12); background:#ffffff; color:#222; transition: transform 0.3s, box-shadow 0.3s; }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-card .icon { width: 60px; height: 60px; border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .brand-logo { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .brand-logo h4 { margin: 0; font-weight: 800; }
        .user-info { padding: 15px 20px; border-top: 1px solid rgba(255,255,255,0.1); position: absolute; bottom: 0; width: 100%; }
        .card { background:#ffffff; color:#222; box-shadow: 0 8px 18px rgba(15,23,42,0.06); border-radius: 16px; }
        .card-header.bg-white { background:#ffffff !important; border-bottom:1px solid #edf1f7 !important; }
        .table { color:#222; }
        .table thead.table-dark { background:#111; }
        .alert-warning { background-color: rgba(255,193,7,0.1); border-color:#ffc107; color:#ffc107; }
        .alert-danger { background-color: rgba(220,53,69,0.1); border-color:#dc3545; color:#ff6b6b; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="brand-logo text-center">
        <i class="fas fa-dumbbell fa-2x mb-2" style="color:#ff7a00"></i>
        <h4>GYM SYSTEM</h4>
    </div>
    <nav class="nav flex-column mt-3">
        <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-tachometer-alt"></i> Bảng điều khiển</a>

        <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/members"><i class="fas fa-users"></i> Hội viên</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/equipment"><i class="fas fa-cogs"></i> Thiết bị</a>
        </c:if>

        <c:if test="${sessionScope.user.role == 'Admin'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/suppliers"><i class="fas fa-truck"></i> Nhà cung cấp</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/subscriptions"><i class="fas fa-crown"></i> Gói hệ thống</a>
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
    <div class="dashboard-hero">
        <div>
            <span class="hero-badge">
                <i class="fas fa-bolt"></i> Trung tâm điều khiển phòng gym
            </span>
            <h2 class="mt-2">Xin chào, ${sessionScope.user.username}!</h2>
            <p>Quan sát nhanh doanh thu, hội viên và hoạt động trong ngày.</p>
        </div>
        <div class="hero-right text-end">
            <small>Hôm nay</small>
            <div class="fw-bold"><i class="fas fa-calendar me-1"></i><%= new java.text.SimpleDateFormat("EEEE, dd MMMM yyyy").format(new java.util.Date()) %></div>
        </div>
    </div>

    <c:if test="${sessionScope.user.role == 'Admin'}">
        <c:if test="${upgradeRequired}">
            <div class="alert alert-warning"><i class="fas fa-exclamation-triangle me-2"></i>Đã đạt giới hạn số lượng hội viên! Vui lòng nâng cấp gói hệ thống.</div>
        </c:if>
        <c:if test="${subscriptionExpired}">
            <div class="alert alert-danger"><i class="fas fa-times-circle me-2"></i>Gói hệ thống của bạn đã hết hạn! Vui lòng gia hạn.</div>
        </c:if>

        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-primary bg-opacity-10 text-warning me-3"><i class="fas fa-dollar-sign"></i></div>
                        <div><small class="text-muted">Tổng doanh thu</small><h5 class="mb-0 fw-bold"><c:out value="${totalRevenue}" default="0"/></h5></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-success bg-opacity-10 text-success me-3"><i class="fas fa-users"></i></div>
                        <div><small class="text-muted">Tổng số hội viên</small><h5 class="mb-0 fw-bold"><c:out value="${totalMembers}" default="0"/></h5></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-warning bg-opacity-10 text-warning me-3"><i class="fas fa-user-plus"></i></div>
                        <div><small class="text-muted">Hội viên mới trong tháng</small><h5 class="mb-0 fw-bold"><c:out value="${newMembersThisMonth}" default="0"/></h5></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-danger bg-opacity-10 text-warning me-3"><i class="fas fa-trophy"></i></div>
                        <div><small class="text-muted">Gói bán chạy nhất</small><h5 class="mb-0 fw-bold" style="font-size:0.9rem"><c:out value="${bestSellingPackage}" default="N/A"/></h5></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 pt-4 px-4"><h5 class="fw-bold"><i class="fas fa-chart-bar me-2"></i>Doanh thu theo tháng</h5></div>
                    <div class="card-body">
                        <table class="table table-sm">
                            <thead><tr><th>Tháng</th><th class="text-end">Doanh thu (VND)</th></tr></thead>
                            <tbody>
                            <c:forEach var="entry" items="${monthlyRevenue}">
                                <tr><td>${entry.key}</td><td class="text-end fw-bold text-success">${entry.value}</td></tr>
                            </c:forEach>
                            <c:if test="${empty monthlyRevenue}">
                                <tr><td colspan="2" class="text-center text-muted">Chưa có dữ liệu doanh thu</td></tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 pt-4 px-4"><h5 class="fw-bold"><i class="fas a-crown me-2"></i>Gói hệ thống</h5></div>
                    <div class="card-body">
                        <c:if test="${not empty activePlan}">
                            <p><strong>Gói:</strong> ${activePlan.planName}</p>
                            <p><strong>Số hội viên tối đa:</strong> ${activePlan.maxMembers == -1 ? 'Không giới hạn' : activePlan.maxMembers}</p>
                            <p><strong>Ngày hết hạn:</strong> ${activePlan.endDate}</p>
                        </c:if>
                        <c:if test="${empty activePlan}">
                            <p class="text-muted">Chưa có gói đang hoạt động</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${sessionScope.user.role == 'Staff'}">
        <div class="row">
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-users fa-3x text-primary mb-3"></i><h5>Quản lý hội viên</h5>
                <a href="${pageContext.request.contextPath}/members" class="btn btn-primary mt-2">Tới trang hội viên</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-cogs fa-3x text-success mb-3"></i><h5>Quản lý thiết bị</h5>
                <a href="${pageContext.request.contextPath}/equipment" class="btn btn-success mt-2">Tới trang thiết bị</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-clipboard-list fa-3x text-warning mb-3"></i><h5>Quản lý đơn hàng</h5>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-warning mt-2">Tới trang đơn hàng</a>
            </div></div></div>
        </div>
    </c:if>

    <c:if test="${sessionScope.user.role == 'Member'}">
        <div class="row">
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-box fa-3x text-primary mb-3"></i><h5>Xem gói tập</h5>
                <a href="${pageContext.request.contextPath}/packages" class="btn btn-primary mt-2">Xem các gói tập</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-shopping-cart fa-3x text-success mb-3"></i><h5>Giỏ hàng của tôi</h5>
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-success mt-2">Tới giỏ hàng</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-clipboard-list fa-3x text-warning mb-3"></i><h5>Đơn hàng của tôi</h5>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-warning mt-2">Xem đơn hàng</a>
            </div></div></div>
        </div>
        <c:if test="${not empty sessionScope.member}">
            <div class="card border-0 shadow-sm rounded-4 mt-4">
                <div class="card-header bg-white border-0 pt-4 px-4"><h5 class="fw-bold"><i class="fas fa-id-card me-2"></i>My Profile</h5></div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Họ tên:</strong> ${sessionScope.member.fullName}</p>
                            <p><strong>Email:</strong> ${sessionScope.member.email}</p>
                            <p><strong>Phone:</strong> ${sessionScope.member.phone}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Loại hội viên:</strong> <span class="badge bg-${sessionScope.member.memberType == 'VIP' ? 'danger' : sessionScope.member.memberType == 'Loyal Member' ? 'warning' : 'info'}">${sessionScope.member.memberType}</span></p>
                            <p><strong>Tổng chi tiêu:</strong> ${sessionScope.member.totalSpending} VND</p>
                            <p><strong>Ngày tham gia:</strong> ${sessionScope.member.joinDate}</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
