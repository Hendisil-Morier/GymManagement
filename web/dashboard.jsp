<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Gym Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .sidebar { background: linear-gradient(180deg, #1a1a2e, #16213e); min-height: 100vh; color: white; position: fixed; width: 250px; }
        .sidebar .nav-link { color: rgba(255,255,255,0.7); padding: 12px 20px; border-radius: 8px; margin: 2px 10px; transition: all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: white; background: rgba(233,69,96,0.3); }
        .sidebar .nav-link i { width: 24px; text-align: center; margin-right: 10px; }
        .main-content { margin-left: 250px; padding: 30px; }
        .stat-card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); transition: transform 0.3s; }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-card .icon { width: 60px; height: 60px; border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .brand-logo { padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .brand-logo h4 { margin: 0; font-weight: 800; }
        .user-info { padding: 15px 20px; border-top: 1px solid rgba(255,255,255,0.1); position: absolute; bottom: 0; width: 100%; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="brand-logo text-center">
        <i class="fas fa-dumbbell fa-2x mb-2" style="color:#e94560"></i>
        <h4>GYM SYSTEM</h4>
    </div>
    <nav class="nav flex-column mt-3">
        <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>

        <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/members"><i class="fas fa-users"></i> Members</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/equipment"><i class="fas fa-cogs"></i> Equipment</a>
        </c:if>

        <c:if test="${sessionScope.user.role == 'Admin'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/suppliers"><i class="fas fa-truck"></i> Suppliers</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/subscriptions"><i class="fas fa-crown"></i> Subscriptions</a>
        </c:if>

        <a class="nav-link" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Packages</a>
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Dashboard</h2>
        <span class="text-muted"><i class="fas fa-calendar me-1"></i><%= new java.text.SimpleDateFormat("EEEE, dd MMMM yyyy").format(new java.util.Date()) %></span>
    </div>

    <c:if test="${sessionScope.user.role == 'Admin'}">
        <c:if test="${upgradeRequired}">
            <div class="alert alert-warning"><i class="fas fa-exclamation-triangle me-2"></i>Member limit reached! Please upgrade your subscription plan.</div>
        </c:if>
        <c:if test="${subscriptionExpired}">
            <div class="alert alert-danger"><i class="fas fa-times-circle me-2"></i>Your subscription has expired! Please renew.</div>
        </c:if>

        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-primary bg-opacity-10 text-primary me-3"><i class="fas fa-dollar-sign"></i></div>
                        <div><small class="text-muted">Total Revenue</small><h5 class="mb-0 fw-bold"><c:out value="${totalRevenue}" default="0"/></h5></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-success bg-opacity-10 text-success me-3"><i class="fas fa-users"></i></div>
                        <div><small class="text-muted">Total Members</small><h5 class="mb-0 fw-bold"><c:out value="${totalMembers}" default="0"/></h5></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-warning bg-opacity-10 text-warning me-3"><i class="fas fa-user-plus"></i></div>
                        <div><small class="text-muted">New This Month</small><h5 class="mb-0 fw-bold"><c:out value="${newMembersThisMonth}" default="0"/></h5></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card stat-card">
                    <div class="card-body d-flex align-items-center">
                        <div class="icon bg-danger bg-opacity-10 text-danger me-3"><i class="fas fa-trophy"></i></div>
                        <div><small class="text-muted">Best Selling</small><h5 class="mb-0 fw-bold" style="font-size:0.9rem"><c:out value="${bestSellingPackage}" default="N/A"/></h5></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 pt-4 px-4"><h5 class="fw-bold"><i class="fas fa-chart-bar me-2"></i>Monthly Revenue</h5></div>
                    <div class="card-body">
                        <table class="table table-sm">
                            <thead><tr><th>Month</th><th class="text-end">Revenue (VND)</th></tr></thead>
                            <tbody>
                            <c:forEach var="entry" items="${monthlyRevenue}">
                                <tr><td>${entry.key}</td><td class="text-end fw-bold text-success">${entry.value}</td></tr>
                            </c:forEach>
                            <c:if test="${empty monthlyRevenue}">
                                <tr><td colspan="2" class="text-center text-muted">No revenue data available</td></tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 pt-4 px-4"><h5 class="fw-bold"><i class="fas fa-crown me-2"></i>Subscription</h5></div>
                    <div class="card-body">
                        <c:if test="${not empty activePlan}">
                            <p><strong>Plan:</strong> ${activePlan.planName}</p>
                            <p><strong>Max Members:</strong> ${activePlan.maxMembers == -1 ? 'Unlimited' : activePlan.maxMembers}</p>
                            <p><strong>Expires:</strong> ${activePlan.endDate}</p>
                        </c:if>
                        <c:if test="${empty activePlan}">
                            <p class="text-muted">No active plan</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${sessionScope.user.role == 'Staff'}">
        <div class="row">
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-users fa-3x text-primary mb-3"></i><h5>Manage Members</h5>
                <a href="${pageContext.request.contextPath}/members" class="btn btn-primary mt-2">Go to Members</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-cogs fa-3x text-success mb-3"></i><h5>Manage Equipment</h5>
                <a href="${pageContext.request.contextPath}/equipment" class="btn btn-success mt-2">Go to Equipment</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-clipboard-list fa-3x text-warning mb-3"></i><h5>Manage Orders</h5>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-warning mt-2">Go to Orders</a>
            </div></div></div>
        </div>
    </c:if>

    <c:if test="${sessionScope.user.role == 'Member'}">
        <div class="row">
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-box fa-3x text-primary mb-3"></i><h5>Browse Packages</h5>
                <a href="${pageContext.request.contextPath}/packages" class="btn btn-primary mt-2">View Packages</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-shopping-cart fa-3x text-success mb-3"></i><h5>My Cart</h5>
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-success mt-2">Go to Cart</a>
            </div></div></div>
            <div class="col-md-4"><div class="card stat-card"><div class="card-body text-center p-4">
                <i class="fas fa-clipboard-list fa-3x text-warning mb-3"></i><h5>My Orders</h5>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-warning mt-2">View Orders</a>
            </div></div></div>
        </div>
        <c:if test="${not empty sessionScope.member}">
            <div class="card border-0 shadow-sm rounded-4 mt-4">
                <div class="card-header bg-white border-0 pt-4 px-4"><h5 class="fw-bold"><i class="fas fa-id-card me-2"></i>My Profile</h5></div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Name:</strong> ${sessionScope.member.fullName}</p>
                            <p><strong>Email:</strong> ${sessionScope.member.email}</p>
                            <p><strong>Phone:</strong> ${sessionScope.member.phone}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Member Type:</strong> <span class="badge bg-${sessionScope.member.memberType == 'VIP' ? 'danger' : sessionScope.member.memberType == 'Loyal Member' ? 'warning' : 'info'}">${sessionScope.member.memberType}</span></p>
                            <p><strong>Total Spending:</strong> ${sessionScope.member.totalSpending} VND</p>
                            <p><strong>Join Date:</strong> ${sessionScope.member.joinDate}</p>
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
