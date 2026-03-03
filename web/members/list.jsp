<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Members - Gym Management</title>
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/members"><i class="fas fa-users"></i> Members</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/equipment"><i class="fas fa-cogs"></i> Equipment</a>
            </c:if>
            <c:if test="${sessionScope.user.role == 'Admin'}">
                <a class="nav-link" href="${pageContext.request.contextPath}/suppliers"><i class="fas fa-truck"></i> Suppliers</a>
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
            <h2><i class="fas fa-users me-2" style="color:#e94560"></i>Members</h2>
            <a href="${pageContext.request.contextPath}/members?action=create" class="btn btn-danger">
                <i class="fas fa-plus me-1"></i>Add New Member
            </a>
        </div>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <form method="GET" action="${pageContext.request.contextPath}/members" class="row g-3 align-items-end">
                    <input type="hidden" name="action" value="search">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold">Search Members</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" name="keyword" class="form-control" placeholder="Search by name, email, or phone..." value="${param.keyword}">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary me-2"><i class="fas fa-search me-1"></i>Search</button>
                        <a href="${pageContext.request.contextPath}/members" class="btn btn-outline-secondary"><i class="fas fa-redo me-1"></i>Reset</a>
                    </div>
                </form>
            </div>
        </div>

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

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Gender</th>
                                <th>Member Type</th>
                                <th>Join Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="member" items="${members}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td class="fw-semibold">${member.fullName}</td>
                                    <td>${member.email}</td>
                                    <td>${member.phone}</td>
                                    <td>${member.gender}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${member.memberType == 'VIP'}">
                                                <span class="badge bg-danger">VIP</span>
                                            </c:when>
                                            <c:when test="${member.memberType == 'Loyal'}">
                                                <span class="badge bg-warning text-dark">Loyal</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-primary">New</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${member.joinDate}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/members?action=edit&id=${member.memberId}" class="btn btn-sm btn-outline-primary me-1" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/members?action=delete&id=${member.memberId}" class="btn btn-sm btn-outline-danger me-1" title="Delete" onclick="return confirm('Are you sure you want to delete this member?');">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/members?action=history&id=${member.memberId}" class="btn btn-sm btn-outline-info" title="History">
                                            <i class="fas fa-history"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty members}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        <i class="fas fa-inbox fa-2x mb-2 d-block"></i>No members found.
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
