<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thiết bị - Hệ thống Gym</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>

        body {
            background: #f5f5f7;
            color: #222;
        }

        /* ===== SIDEBAR ===== */

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

        .brand-logo h4 {
            margin: 0;
            font-weight: 800;
        }

        .user-info {
            padding: 15px 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            position: absolute;
            bottom: 0;
            width: 100%;
        }


        /* ===== MAIN CONTENT ===== */
        .main-content {
            margin-left: 250px;
            padding: 30px;
        }

        h3 {
            color: #ff7a00;
        }

        /* ===== CARD ===== */

        .card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            border: none;
        }


        /* ===== TABLE ===== */
        .table thead {
            background: #111;
            color: white;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(255,122,0,0.05);
        }

        /* ===== BUTTON TONE CAM ===== */
        .btn-primary {
            background-color: #ff7a00;
            border-color: #ff7a00;
        }

        .btn-primary:hover {
            background-color: #e96d00;
            border-color: #e96d00;
        }

        .btn-outline-warning {
            border-color: #ff7a00;
            color: #ff7a00;
        }

        .btn-outline-warning:hover {
            background: #ff7a00;
            color: white;
        }
        
        .btn-orange{
            background-color:#ff7a00;
            color:white;
            border:none;
            border-radius:10px;
            padding:8px 16px;
            font-weight:500;
         }

        .btn-orange:hover{
            background-color:#e66a00;
            color:white;
         }
         .btn-logout{
            border:2px solid #ff4d4f;
            color:#ff4d4f;
            background:transparent;
            border-radius:10px;
            font-weight:500;
            padding:8px 12px;
            transition:0.3s;
         }

         .btn-logout:hover{
            background:#ff4d4f;
            color:white;
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
            <i class="fas fa-home"></i> Trang chủ
        </a>

        <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/members">
                <i class="fas fa-users"></i> Hội viên
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/equipment">
                <i class="fas fa-dumbbell"></i> Thiết bị
            </a>
        </c:if>

        <c:if test="${sessionScope.user.role == 'Admin'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/suppliers">
                <i class="fas fa-truck"></i> Nhà cung cấp
            </a>
        </c:if>

        <a class="nav-link" href="${pageContext.request.contextPath}/packages">
            <i class="fas fa-box"></i> Gói tập
        </a>

        <a class="nav-link" href="${pageContext.request.contextPath}/orders">
            <i class="fas fa-file-invoice"></i> Đơn hàng
        </a>

        <c:if test="${sessionScope.user.role == 'Member'}">
            <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                <i class="fas fa-shopping-cart"></i> Giỏ hàng
            </a>
        </c:if>
    </nav>

    <div class="user-info">
        <small style="color:rgba(255,255,255,0.5);">Đăng nhập với</small>
        <div class="fw-bold" style="color:#ffffff;">
            ${sessionScope.user.username}
            <span class="badge bg-info">${sessionScope.user.role}</span>
        </div>
        <a href="${pageContext.request.contextPath}/login?action=logout"

           class="btn btn-sm btn-outline-danger mt-2 w-100">

           

            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
        </a>
    </div>
</div>

<div class="main-content">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h2 class="fw-bold text-dark">
            <i class="fas fa-dumbbell me-2" style="color:#ff7a00;"></i>Quản lý Thiết bị
        </h2>

        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/equipment?action=maintenance"
               class="btn btn-outline-warning">
                <i class="fas fa-tools me-1"></i>Thiết bị bảo trì
            </a>

            <button type="button" class="btn btn-orange"
                    data-bs-toggle="modal" data-bs-target="#addEquipmentModal">
                <i class="fas fa-plus me-1"></i>Thêm thiết bị
            </button>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="table-responsive">

            <table class="table table-hover align-middle mb-0">
                <thead>

            <table class="table table-bordered table-hover mb-0">
                <thead class="table-dark">

                <tr>
                    <th>Tên thiết bị</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
                    <th>Cập nhật lần cuối</th>
                    <th>Giá</th>
                    <th>Nhà cung cấp</th>
                    <th class="text-center">Thao tác</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="item" items="${equipmentList}">
                    <tr>
                        <td class="fw-semibold">${item.equipmentName}</td>
                        <td>${item.quantity}</td>

                        <td>
                            <c:choose>
                                <c:when test="${item.status == 'Active'}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:when>
                                <c:when test="${item.status == 'Maintenance'}">
                                    <span class="badge bg-warning text-dark">Bảo trì</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${item.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td><span class="text-muted small"><i class="fas fa-clock me-1"></i>${item.purchaseDate}</span></td>
                        <td class="fw-bold">${item.purchasePrice} VNĐ</td>

                        <td>
                            <c:forEach var="s" items="${suppliers}">
                                <c:if test="${s.supplierId == item.supplierId}">
                                    ${s.companyName}
                                </c:if>
                            </c:forEach>
                        </td>

                        <td class="text-center">
                            <button type="button" class="btn btn-sm btn-outline-primary me-1"
                                    onclick="openEditModal(${item.equipmentId}, '${item.equipmentName}', ${item.quantity}, '${item.status}', '${item.purchasePrice}', '${item.supplierId}')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <a href="${pageContext.request.contextPath}/equipment?action=reportMaintenance&id=${item.equipmentId}"
                               class="btn btn-sm btn-outline-warning me-1">
                                <i class="fas fa-tools"></i>
                            </a>

                            <a href="${pageContext.request.contextPath}/equipment?action=delete&id=${item.equipmentId}"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirm('Bạn có chắc muốn xóa thiết bị này?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty equipmentList}">
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">
                            Không có thiết bị nào.
                        </td>
                    </tr>
                </c:if>

                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- ===== MODAL THÊM THIẾT BỊ ===== -->
<div class="modal fade" id="addEquipmentModal" tabindex="-1" aria-labelledby="addEquipmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="${pageContext.request.contextPath}/equipment">
                <input type="hidden" name="action" value="create">
                <div class="modal-header">
                    <h5 class="modal-title" id="addEquipmentModalLabel">
                        <i class="fas fa-plus-circle me-2" style="color:#ff7a00;"></i>Thêm Thiết Bị Mới
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên thiết bị <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="equipmentName" required placeholder="Nhập tên thiết bị">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số lượng</label>
                        <input type="number" class="form-control" name="quantity" value="1" min="1">
                    </div>
                    <input type="hidden" name="purchaseDate" id="addPurchaseDate">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Giá mua (VNĐ)</label>
                        <input type="number" class="form-control" name="purchasePrice" min="0" step="1000" placeholder="0">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nhà cung cấp</label>
                        <select class="form-select" name="supplierId">
                            <option value="">-- Chọn nhà cung cấp --</option>
                            <c:forEach var="s" items="${suppliers}">
                                <option value="${s.supplierId}">${s.companyName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-orange">
                        <i class="fas fa-save me-1"></i>Lưu thiết bị
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- ===== MODAL EDIT THIẾT BỊ ===== -->
<div class="modal fade" id="editEquipmentModal" tabindex="-1" aria-labelledby="editEquipmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="${pageContext.request.contextPath}/equipment">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="equipmentId" id="editEquipmentId">
                <input type="hidden" name="purchaseDate" id="editPurchaseDate">
                <div class="modal-header">
                    <h5 class="modal-title" id="editEquipmentModalLabel">
                        <i class="fas fa-edit me-2" style="color:#ff7a00;"></i>Chỉnh Sửa Thiết Bị
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên thiết bị <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="equipmentName" id="editEquipmentName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số lượng</label>
                        <input type="number" class="form-control" name="quantity" id="editQuantity" min="1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Trạng thái</label>
                        <select class="form-select" name="status" id="editStatus">
                            <option value="Active">Hoạt động</option>
                            <option value="Maintenance">Bảo trì</option>
                            <option value="Inactive">Ngừng hoạt động</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Giá mua (VNĐ)</label>
                        <input type="number" class="form-control" name="purchasePrice" id="editPurchasePrice" min="0" step="1000">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nhà cung cấp</label>
                        <select class="form-select" name="supplierId" id="editSupplierId">
                            <option value="">-- Chọn nhà cung cấp --</option>
                            <c:forEach var="s" items="${suppliers}">
                                <option value="${s.supplierId}">${s.companyName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-orange">
                        <i class="fas fa-save me-1"></i>Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function getTodayDate() {
    var d = new Date();
    var mm = String(d.getMonth() + 1).padStart(2, '0');
    var dd = String(d.getDate()).padStart(2, '0');
    return d.getFullYear() + '-' + mm + '-' + dd;
}

// Set ngày hôm nay cho modal Thêm khi trang load
document.addEventListener('DOMContentLoaded', function() {
    var addDate = document.getElementById('addPurchaseDate');
    if (addDate) addDate.value = getTodayDate();
});

function openEditModal(id, name, qty, status, price, supplierId) {
    document.getElementById('editEquipmentId').value = id;
    document.getElementById('editPurchaseDate').value = getTodayDate();
    document.getElementById('editEquipmentName').value = name;
    document.getElementById('editQuantity').value = qty;
    document.getElementById('editPurchasePrice').value = price;

    var statusSelect = document.getElementById('editStatus');
    for (var i = 0; i < statusSelect.options.length; i++) {
        if (statusSelect.options[i].value === status) {
            statusSelect.selectedIndex = i;
            break;
        }
    }

    var supplierSelect = document.getElementById('editSupplierId');
    for (var j = 0; j < supplierSelect.options.length; j++) {
        if (supplierSelect.options[j].value == supplierId) {
            supplierSelect.selectedIndex = j;
            break;
        }
    }

    var modal = new bootstrap.Modal(document.getElementById('editEquipmentModal'));
    modal.show();
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>