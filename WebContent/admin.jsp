<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="java.util.ArrayList, com.medical.model.Medicine, com.medical.dao.MedicineDAO, com.medical.model.Order, com.medical.dao.OrderDAO, com.medical.model.ServiceBooking, com.medical.dao.ServiceBookingDAO"
        %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard | Online Medical Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                :root {
                    --primary: #10b981;
                    --primary-dark: #059669;
                    --primary-light: #d1fae5;
                    --secondary: #6366f1;
                    --bg: #f8fafc;
                    --sidebar-bg: #1e293b;
                    --card-bg: #ffffff;
                    --text-main: #1e293b;
                    --text-muted: #64748b;
                    --border: #e2e8f0;
                    --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
                    --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
                }

                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg);
                    color: var(--text-main);
                    display: flex;
                    min-height: 100vh;
                }

                .sidebar {
                    width: 260px;
                    background-color: var(--sidebar-bg);
                    color: white;
                    display: flex;
                    flex-direction: column;
                    position: fixed;
                    height: 100vh;
                    transition: all 0.3s ease;
                    z-index: 1000;
                }

                .sidebar-header {
                    padding: 2rem 1.5rem;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    font-size: 1.25rem;
                    font-weight: 700;
                    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                }

                .sidebar-nav {
                    flex: 1;
                    padding: 1.5rem 0;
                }

                .nav-item {
                    padding: 0.75rem 1.5rem;
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    color: #94a3b8;
                    text-decoration: none;
                    transition: all 0.2s;
                    border-left: 4px solid transparent;
                }

                .nav-item:hover,
                .nav-item.active {
                    background: rgba(255, 255, 255, 0.05);
                    color: white;
                    border-left-color: var(--primary);
                }

                .sidebar-footer {
                    padding: 1.5rem;
                    border-top: 1px solid rgba(255, 255, 255, 0.1);
                }

                .main-content {
                    margin-left: 260px;
                    flex: 1;
                    padding: 2rem;
                    width: calc(100% - 260px);
                }

                .top-bar {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 2rem;
                }

                .page-title h1 {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--text-main);
                }

                .user-profile {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    background: white;
                    padding: 0.5rem 1rem;
                    border-radius: 99px;
                    box-shadow: var(--shadow);
                }

                .stats-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                    gap: 1.5rem;
                    margin-bottom: 2rem;
                }

                .stat-card {
                    background: var(--card-bg);
                    padding: 1.5rem;
                    border-radius: 12px;
                    box-shadow: var(--shadow);
                    display: flex;
                    align-items: center;
                    gap: 1.5rem;
                }

                .stat-icon {
                    width: 48px;
                    height: 48px;
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.25rem;
                }

                .stat-info h3 {
                    font-size: 0.875rem;
                    color: var(--text-muted);
                    margin-bottom: 0.25rem;
                }

                .stat-info p {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--text-main);
                }

                .dashboard-grid {
                    display: grid;
                    grid-template-columns: 1fr 2fr;
                    gap: 2rem;
                    margin-bottom: 2rem;
                }

                .card {
                    background: var(--card-bg);
                    border-radius: 16px;
                    box-shadow: var(--shadow);
                    overflow: hidden;
                    border: 1px solid var(--border);
                }

                .card-header {
                    padding: 1.25rem 1.5rem;
                    border-bottom: 1px solid var(--border);
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .card-header h2 {
                    font-size: 1.125rem;
                    font-weight: 600;
                }

                .card-body {
                    padding: 1.5rem;
                }

                .form-group {
                    margin-bottom: 1.25rem;
                }

                label {
                    display: block;
                    font-size: 0.875rem;
                    font-weight: 500;
                    margin-bottom: 0.5rem;
                    color: var(--text-main);
                }

                input,
                select,
                textarea {
                    width: 100%;
                    padding: 0.75rem;
                    border: 1px solid var(--border);
                    border-radius: 8px;
                    font-family: inherit;
                    font-size: 0.875rem;
                    transition: all 0.2s;
                }

                input:focus,
                select:focus,
                textarea:focus {
                    outline: none;
                    border-color: var(--primary);
                    box-shadow: 0 0 0 3px var(--primary-light);
                }

                .table-container {
                    overflow-x: auto;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                th {
                    background: #f8fafc;
                    padding: 0.75rem 1rem;
                    text-align: left;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    color: var(--text-muted);
                    border-bottom: 1px solid var(--border);
                }

                td {
                    padding: 1rem;
                    border-bottom: 1px solid var(--border);
                    font-size: 0.875rem;
                }

                tr:last-child td {
                    border-bottom: none;
                }

                tr:hover td {
                    background-color: #f8fafc;
                }

                .badge {
                    padding: 0.25rem 0.625rem;
                    border-radius: 99px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: capitalize;
                }

                .badge-pending {
                    background: #fef3c7;
                    color: #92400e;
                }

                .badge-processing {
                    background: #e0f2fe;
                    color: #075985;
                }

                .badge-shipped {
                    background: #e0e7ff;
                    color: #3730a3;
                }

                .badge-delivered {
                    background: #d1fae5;
                    color: #065f46;
                }

                .badge-low-stock {
                    background: #fee2e2;
                    color: #dc2626;
                }

                .badge-normal-stock {
                    background: #f1f5f9;
                    color: #475569;
                }

                .badge-paid {
                    background: #d1fae5;
                    color: #065f46;
                }

                .badge-confirmed {
                    background: #dcfce7;
                    color: #166534;
                }

                .badge-completed {
                    background: #d1fae5;
                    color: #065f46;
                }

                .badge-cancelled {
                    background: #fee2e2;
                    color: #991b1b;
                }

                .btn {
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    gap: 8px;
                    padding: 0.625rem 1.25rem;
                    border-radius: 8px;
                    font-weight: 600;
                    font-size: 0.875rem;
                    cursor: pointer;
                    transition: all 0.2s;
                    border: none;
                    text-decoration: none;
                }

                .btn-primary {
                    background-color: var(--primary);
                    color: white;
                }

                .btn-primary:hover {
                    background-color: var(--primary-dark);
                }

                .btn-danger {
                    background-color: #fee2e2;
                    color: #dc2626;
                }

                .btn-danger:hover {
                    background-color: #fecaca;
                }

                .btn-sm {
                    padding: 0.4rem 0.75rem;
                    font-size: 0.75rem;
                }

                .msg {
                    padding: 1rem;
                    border-radius: 8px;
                    margin-bottom: 1.5rem;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    font-weight: 500;
                }

                .msg-success {
                    background: #d1fae5;
                    color: #065f46;
                    border: 1px solid #a7f3d0;
                }

                .msg-error {
                    background: #fee2e2;
                    color: #991b1b;
                    border: 1px solid #fecaca;
                }

                .close-btn {
                    margin-left: auto;
                    background: none;
                    border: none;
                    font-size: 1.25rem;
                    cursor: pointer;
                    color: currentColor;
                    opacity: 0.5;
                    transition: opacity 0.2s;
                    padding: 0 5px;
                    line-height: 1;
                }

                .close-btn:hover {
                    opacity: 1;
                }

                @media (max-width: 1024px) {
                    .dashboard-grid {
                        grid-template-columns: 1fr;
                    }

                    .sidebar {
                        width: 80px;
                    }

                    .sidebar span {
                        display: none;
                    }

                    .main-content {
                        margin-left: 80px;
                        width: calc(100% - 80px);
                    }
                }
            </style>
        </head>

        <body>
            <aside class="sidebar">
                <div class="sidebar-header">
                    <i class="fas fa-capsules text-primary"></i>
                    <span>MedStore Admin</span>
                </div>
                <nav class="sidebar-nav">
                    <a href="#inventory" class="nav-item active">
                        <i class="fas fa-boxes"></i>
                        <span>Inventory</span>
                    </a>
                    <a href="#orders" class="nav-item">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Orders</span>
                    </a>
                    <a href="#services" class="nav-item">
                        <i class="fas fa-hand-holding-medical"></i>
                        <span>Services</span>
                    </a>
                </nav>
                <div class="sidebar-footer">
                    <a href="login.html" class="nav-item" style="color: #f87171;">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </aside>

            <main class="main-content">
                <div class="top-bar">
                    <div class="page-title">
                        <h1>Dashboard Overview</h1>
                    </div>
                    <div class="user-profile">
                        <i class="fas fa-user-circle fa-lg"></i>
                        <span style="font-weight: 500;">Administrator</span>
                    </div>
                </div>

                <% MedicineDAO medDao=new MedicineDAO(); OrderDAO orderDao=new OrderDAO(); ServiceBookingDAO
                    bookingDao=new ServiceBookingDAO(); ArrayList<Medicine> medList = medDao.getAllMedicines();
                    ArrayList<Order> orderList = orderDao.getAllOrders();
                        ArrayList<ServiceBooking> bookingList = bookingDao.getAllBookings();

                            int totalMeds = medList.size();
                            int totalOrders = orderList.size();
                            int totalBookings = bookingList.size();
                            %>

                            <div class="stats-grid">
                                <div class="stat-card">
                                    <div class="stat-icon" style="background: #dcfce7; color: #166534;"><i
                                            class="fas fa-pills"></i></div>
                                    <div class="stat-info">
                                        <h3>Total Medicines</h3>
                                        <p>
                                            <%= totalMeds %>
                                        </p>
                                    </div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-icon" style="background: #e0e7ff; color: #3730a3;"><i
                                            class="fas fa-truck-loading"></i></div>
                                    <div class="stat-info">
                                        <h3>Total Orders</h3>
                                        <p>
                                            <%= totalOrders %>
                                        </p>
                                    </div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-icon" style="background: #fef3c7; color: #92400e;"><i
                                            class="fas fa-calendar-check"></i></div>
                                    <div class="stat-info">
                                        <h3>Service Bookings</h3>
                                        <p>
                                            <%= totalBookings %>
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <% String msg=request.getParameter("msg"); %>
                                <% if(msg !=null) { %>
                                    <div class="msg <%= msg.toLowerCase().contains(" success") ? "msg-success"
                                        : "msg-error" %>">
                                        <i class="fas <%= msg.toLowerCase().contains(" success") ? "fa-check-circle"
                                            : "fa-exclamation-circle" %>"></i>
                                        <span>
                                            <%= msg %>
                                        </span>
                                        <button type="button" class="close-btn"
                                            onclick="this.parentElement.style.display='none'">&times;</button>
                                    </div>
                                    <% } %>

                                        <div class="dashboard-grid" id="inventory">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h2>Add New Medicine</h2>
                                                </div>
                                                <div class="card-body">
                                                    <form action="AddMedicineServlet" method="post">
                                                        <div class="form-group"><label>Medicine Name</label><input
                                                                type="text" name="name"
                                                                placeholder="e.g. Paracetamol 500mg" required></div>
                                                        <div class="form-group"><label>Price (₹)</label><input
                                                                type="number" step="0.01" name="price"
                                                                placeholder="0.00" required></div>
                                                        <div class="form-group"><label>Stock Quantity</label><input
                                                                type="number" name="stock" placeholder="0" required>
                                                        </div>
                                                        <div class="form-group"><label>Description</label><textarea
                                                                name="description"
                                                                placeholder="Brief description..."></textarea></div>
                                                        <button type="submit" class="btn btn-primary"
                                                            style="width: 100%;"><i class="fas fa-plus"></i> Add
                                                            Medicine</button>
                                                    </form>
                                                </div>
                                            </div>

                                            <div class="card">
                                                <div class="card-header">
                                                    <h2>Inventory Management</h2>
                                                </div>
                                                <div class="card-body table-container">
                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th>Medicine</th>
                                                                <th>Price</th>
                                                                <th>Stock</th>
                                                                <th>Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for(Medicine m : medList) { %>
                                                                <tr>
                                                                    <td style="font-weight: 500;">
                                                                        <%= m.getName() %>
                                                                    </td>
                                                                    <td>₹<%= m.getPrice() %>
                                                                    </td>
                                                                    <td>
                                                                        <% String stockClass=m.getStock() < 10
                                                                            ? "badge-low-stock" : "badge-normal-stock" ;
                                                                            %>
                                                                            <span class="badge <%= stockClass %>">
                                                                                <%= m.getStock() %> units
                                                                            </span>
                                                                    </td>
                                                                    <td>
                                                                        <% String deleteUrl="DeleteMedicineServlet?id="
                                                                            + m.getId(); %>
                                                                            <a href="<%= deleteUrl %>"
                                                                                class="btn btn-danger btn-sm"
                                                                                onclick="return confirm('Are you sure?')"><i
                                                                                    class="fas fa-trash"></i></a>
                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card" id="orders" style="margin-bottom: 2rem;">
                                            <div class="card-header">
                                                <h2>Order Management</h2>
                                            </div>
                                            <div class="card-body table-container">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>Order ID</th>
                                                            <th>Medicine</th>
                                                            <th>Qty</th>
                                                            <th>Total</th>
                                                            <th>Payment</th>
                                                            <th>Status</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for(Order o : orderList) { %>
                                                            <tr>
                                                                <td style="font-weight: 600; color: var(--secondary);">#
                                                                    <%= o.getId() %>
                                                                </td>
                                                                <td>
                                                                    <%= o.getMedicineName() %>
                                                                </td>
                                                                <td>
                                                                    <%= o.getQuantity() %>
                                                                </td>
                                                                <td style="font-weight: 600;">₹<%= o.getTotalPrice() %>
                                                                </td>
                                                                <td><span
                                                                        class="badge badge-<%= o.getPaymentStatus().toLowerCase() %>">
                                                                        <%= o.getPaymentStatus() %>
                                                                    </span></td>
                                                                <td><span
                                                                        class="badge badge-<%= o.getStatus().toLowerCase() %>">
                                                                        <%= o.getStatus() %>
                                                                    </span></td>
                                                                <td>
                                                                    <form action="UpdateOrderStatusServlet"
                                                                        method="post" style="display: flex; gap: 8px;">
                                                                        <input type="hidden" name="orderId"
                                                                            value="<%= o.getId() %>">
                                                                        <select name="status" class="status-select">
                                                                            <option value="Pending"
                                                                                <%=o.getStatus().equals("Pending")
                                                                                ? "selected" : "" %>>Pending</option>
                                                                            <option value="Processing"
                                                                                <%=o.getStatus().equals("Processing")
                                                                                ? "selected" : "" %>>Processing</option>
                                                                            <option value="Shipped"
                                                                                <%=o.getStatus().equals("Shipped")
                                                                                ? "selected" : "" %>>Shipped</option>
                                                                            <option value="Delivered"
                                                                                <%=o.getStatus().equals("Delivered")
                                                                                ? "selected" : "" %>>Delivered</option>
                                                                        </select>
                                                                        <button type="submit"
                                                                            class="btn btn-primary btn-sm">Update</button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="card" id="services">
                                            <div class="card-header">
                                                <h2>Home Service Requests</h2>
                                            </div>
                                            <div class="card-body table-container">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Service</th>
                                                            <th>Address</th>
                                                            <th>Phone</th>
                                                            <th>Status</th>
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for(ServiceBooking b : bookingList) { %>
                                                            <tr>
                                                                <td style="font-weight: 600; color: var(--secondary);">#
                                                                    <%= b.getId() %>
                                                                </td>
                                                                <td style="font-weight: 500;">
                                                                    <%= b.getServiceName() %>
                                                                </td>
                                                                <td
                                                                    style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                                    <%= b.getAddress() %>
                                                                </td>
                                                                <td>
                                                                    <%= b.getPhone() %>
                                                                </td>
                                                                <td><span
                                                                        class="badge badge-<%= b.getStatus().toLowerCase() %>">
                                                                        <%= b.getStatus() %>
                                                                    </span></td>
                                                                <td>
                                                                    <form action="UpdateServiceStatusServlet"
                                                                        method="post" style="display: flex; gap: 8px;">
                                                                        <input type="hidden" name="bookingId"
                                                                            value="<%= b.getId() %>">
                                                                        <select name="status" class="status-select">
                                                                            <option value="Pending"
                                                                                <%=b.getStatus().equals("Pending")
                                                                                ? "selected" : "" %>>Pending</option>
                                                                            <option value="Confirmed"
                                                                                <%=b.getStatus().equals("Confirmed")
                                                                                ? "selected" : "" %>>Confirmed</option>
                                                                            <option value="Completed"
                                                                                <%=b.getStatus().equals("Completed")
                                                                                ? "selected" : "" %>>Completed</option>
                                                                            <option value="Cancelled"
                                                                                <%=b.getStatus().equals("Cancelled")
                                                                                ? "selected" : "" %>>Cancelled</option>
                                                                        </select>
                                                                        <button type="submit"
                                                                            class="btn btn-primary btn-sm">Update</button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
            </main>

            <script>
                window.addEventListener('scroll', () => {
                    let current = '';
                    const sections = document.querySelectorAll('div[id]');
                    sections.forEach(section => {
                        const sectionTop = section.offsetTop;
                        if (pageYOffset >= sectionTop - 100) { current = section.getAttribute('id'); }
                    });
                    document.querySelectorAll('.nav-item').forEach(item => {
                        item.classList.remove('active');
                        if (item.getAttribute('href').includes(current)) { item.classList.add('active'); }
                    });
                });
            </script>
        </body>

        </html>