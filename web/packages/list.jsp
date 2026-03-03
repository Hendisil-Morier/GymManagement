<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Packages & Services - Gym Management</title>
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
        .package-card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); transition: transform 0.2s; }
        .package-card:hover { transform: translateY(-4px); }
        .price-tag { font-size: 1.5rem; font-weight: 700; color: #e94560; }
        .duration-badge { background: #e94560; color: white; border-radius: 20px; padding: 4px 12px; font-size: 0.8rem; }
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
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-box me-2" style="color:#e94560"></i>Gym Packages</h2>
            <c:if test="${sessionScope.user.role == 'Admin'}">
                <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#addPackageModal">
                    <i class="fas fa-plus me-1"></i>Add Package
                </button>
            </c:if>
        </div>

        <div class="row g-4 mb-5">
            <c:forEach var="pkg" items="${packages}">
                <div class="col-md-6 col-lg-4">
                    <div class="card package-card h-100">
                        <div class="card-body d-flex flex-column">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <h5 class="card-title mb-0">${pkg.packageName}</h5>
                                <span class="duration-badge">${pkg.durationMonth} month<c:if test="${pkg.durationMonth > 1}">s</c:if></span>
                            </div>
                            <p class="card-text text-muted flex-grow-1">${pkg.description}</p>
                            <div class="price-tag mb-3">${pkg.price} VND</div>
                            <c:if test="${sessionScope.user.role == 'Member'}">
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="addPackage">
                                    <input type="hidden" name="packageId" value="${pkg.packageId}">
                                    <button type="submit" class="btn btn-danger w-100"><i class="fas fa-cart-plus me-1"></i>Add to Cart</button>
                                </form>
                            </c:if>
                            <c:if test="${sessionScope.user.role == 'Admin'}">
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/packages?action=edit&id=${pkg.packageId}" class="btn btn-outline-primary flex-fill"><i class="fas fa-edit me-1"></i>Edit</a>
                                    <a href="${pageContext.request.contextPath}/packages?action=delete&id=${pkg.packageId}" class="btn btn-outline-danger flex-fill" onclick="return confirm('Delete this package?')"><i class="fas fa-trash me-1"></i>Delete</a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <h2 class="mb-4"><i class="fas fa-concierge-bell me-2" style="color:#e94560"></i>Additional Services</h2>

        <div class="row g-4">
            <c:forEach var="svc" items="${services}">
                <div class="col-md-6 col-lg-4">
                    <div class="card package-card h-100">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">${svc.serviceName}</h5>
                            <p class="card-text text-muted flex-grow-1">${svc.description}</p>
                            <div class="price-tag mb-3">${svc.price} VND</div>
                            <c:if test="${sessionScope.user.role == 'Member'}">
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="addService">
                                    <input type="hidden" name="serviceId" value="${svc.serviceId}">
                                    <button type="submit" class="btn btn-danger w-100"><i class="fas fa-cart-plus me-1"></i>Add to Cart</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <c:if test="${sessionScope.user.role == 'Admin'}">
        <div class="modal fade" id="addPackageModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/packages" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fas fa-plus-circle me-2"></i>Add New Package</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Package Name</label>
                                <input type="text" class="form-control" name="packageName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Price</label>
                                <input type="number" class="form-control" name="price" step="0.01" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Duration (Months)</label>
                                <input type="number" class="form-control" name="durationMonth" min="1" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" name="description" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Create Package</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
