<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subscriptions - Gym Management</title>
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
        .plan-card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); transition: transform 0.3s; }
        .plan-card:hover { transform: translateY(-5px); }
        .plan-card.active-plan { border: 3px solid #e94560; }
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/subscriptions"><i class="fas fa-crown"></i> Subscriptions</a>
        </c:if>
        <a class="nav-link" href="${pageContext.request.contextPath}/packages"><i class="fas fa-box"></i> Packages</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/orders"><i class="fas fa-clipboard-list"></i> Orders</a>
    </nav>
    <div class="user-info">
        <small class="text-muted">Logged in as</small>
        <div class="fw-bold">${sessionScope.user.username} <span class="badge bg-info">${sessionScope.user.role}</span></div>
        <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-sm btn-outline-danger mt-2 w-100"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
</div>

<div class="main-content">
    <h2 class="fw-bold mb-4"><i class="fas fa-crown me-2"></i>System Subscription Plans</h2>

    <c:if test="${upgradeRequired}">
        <div class="alert alert-warning"><i class="fas fa-exclamation-triangle me-2"></i>You have reached the member limit for your current plan (<strong>${totalMembers} members</strong>). Please upgrade!</div>
    </c:if>
    <c:if test="${expired}">
        <div class="alert alert-danger"><i class="fas fa-times-circle me-2"></i>Your current subscription has expired! Please renew.</div>
    </c:if>

    <div class="row">
        <c:forEach var="plan" items="${plans}">
            <div class="col-md-4 mb-4">
                <div class="card plan-card ${activePlan != null && activePlan.subscriptionId == plan.subscriptionId ? 'active-plan' : ''}">
                    <div class="card-body text-center p-4">
                        <c:choose>
                            <c:when test="${plan.planName == 'Free'}">
                                <i class="fas fa-gift fa-3x text-secondary mb-3"></i>
                            </c:when>
                            <c:when test="${plan.planName == 'Standard'}">
                                <i class="fas fa-star fa-3x text-primary mb-3"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-crown fa-3x text-warning mb-3"></i>
                            </c:otherwise>
                        </c:choose>
                        <h4 class="fw-bold">${plan.planName}</h4>
                        <h3 class="text-primary mb-3">
                            <c:choose>
                                <c:when test="${plan.price.intValue() == 0}">Free</c:when>
                                <c:otherwise>${plan.price} VND</c:otherwise>
                            </c:choose>
                        </h3>
                        <p class="text-muted">
                            <strong>Max Members:</strong> 
                            ${plan.maxMembers == -1 ? 'Unlimited' : plan.maxMembers}
                        </p>
                        <p><strong>Period:</strong> ${plan.startDate} - ${plan.endDate}</p>
                        <p>
                            <span class="badge bg-${plan.status == 'Active' ? 'success' : 'secondary'}">${plan.status}</span>
                            <c:if test="${activePlan != null && activePlan.subscriptionId == plan.subscriptionId}">
                                <span class="badge bg-danger">Current Plan</span>
                            </c:if>
                        </p>
                        <c:if test="${activePlan == null || activePlan.subscriptionId != plan.subscriptionId}">
                            <form method="post" action="${pageContext.request.contextPath}/subscriptions">
                                <input type="hidden" name="action" value="changePlan">
                                <input type="hidden" name="planId" value="${plan.subscriptionId}">
                                <button type="submit" class="btn btn-outline-primary mt-2">Switch to this plan</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
