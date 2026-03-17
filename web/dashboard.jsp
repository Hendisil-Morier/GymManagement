<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
        </c:if>

        <a class="nav-link" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Gói tập</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="fas fa-clipboard-list"></i> Đơn hàng</a>

        <c:if test="${sessionScope.user.role == 'Member'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Giỏ hàng của tôi</a>
        </c:if>
    </nav>
    <div class="user-info">
        <small style="color:rgba(255,255,255,0.5);">Đăng nhập với</small>
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
            <p>Chúc bạn có một ngày tốt lành!</p>
        </div>
        <div class="hero-right text-end">
            <small>Hôm nay</small>
            <div class="fw-bold"><i class="fas fa-calendar me-1"></i><%= new java.text.SimpleDateFormat("EEEE, dd MMMM yyyy").format(new java.util.Date()) %></div>
        </div>
    </div>

    <c:if test="${sessionScope.user.role == 'Admin'}">
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
            <div class="col-12">
                <div class="row mt-4">
    <div class="col-12">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold"><i class="fas fa-chart-line me-2"></i>Doanh thu theo tháng & Dự báo</h5>
            </div>
            <div class="card-body">
                <!-- Biểu đồ Chart.js -->
                <canvas id="revenueChart" height="100"></canvas>

                <!-- Bảng chi tiết bên dưới biểu đồ -->
                <table class="table table-sm mt-4">
                    <thead>
                        <tr>
                            <th>Tháng</th>
                            <th class="text-end">Doanh thu thực tế (VND)</th>
                            <th class="text-end">Dự báo Moving Avg (VND)</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="row" items="${forecastData}">
                        <tr>
                            <td>Tháng ${row[0].intValue()}</td>
                            <td class="text-end fw-bold text-success">
                                <c:choose>
                                    <c:when test="${row[1] > 0}">
                                        <fmt:formatNumber value="${row[1]}" type="number" maxFractionDigits="0"/>
                                    </c:when>
                                    <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end text-warning">
                                <c:choose>
                                    <c:when test="${row[2] >= 0}">
                                        <fmt:formatNumber value="${row[2]}" type="number" maxFractionDigits="0"/>
                                    </c:when>
                                    <c:otherwise><span class="text-muted">Chưa đủ dữ liệu</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty forecastData}">
                        <tr><td colspan="3" class="text-center text-muted">Chưa có dữ liệu doanh thu</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
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
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
(function() {
    // Lấy dữ liệu từ server qua JSP EL -> JS
    var labels = [];
    var actualData = [];
    var forecastData = [];

    <c:forEach var="row" items="${forecastData}">
        labels.push("T${row[0].intValue()}");
        actualData.push(${row[1]});
        forecastData.push(${row[2] >= 0 ? row[2] : 'null'});
    </c:forEach>

    var ctx = document.getElementById('revenueChart');
    if (ctx && labels.length > 0) {
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Doanh thu thực tế',
                        data: actualData,
                        borderColor: '#28a745',
                        backgroundColor: 'rgba(40,167,69,0.1)',
                        borderWidth: 2,
                        pointRadius: 4,
                        fill: true,
                        tension: 0.3
                    },
                    {
                        label: 'Dự báo (Moving Avg 3 tháng)',
                        data: forecastData,
                        borderColor: '#ff7a00',
                        backgroundColor: 'rgba(255,122,0,0.08)',
                        borderWidth: 2,
                        borderDash: [6, 3],
                        pointRadius: 4,
                        fill: false,
                        tension: 0.3
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'top' },
                    tooltip: {
                        callbacks: {
                            label: function(ctx) {
                                if (ctx.raw === null) return ctx.dataset.label + ': Chưa đủ dữ liệu';
                                return ctx.dataset.label + ': ' + ctx.raw.toLocaleString('vi-VN') + ' VND';
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(v) { return v.toLocaleString('vi-VN'); }
                        }
                    }
                }
            }
        });
    }
})();
</script>
</body>
</html>
