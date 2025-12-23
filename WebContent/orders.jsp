<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="java.util.ArrayList, java.util.List, com.medical.model.Order, com.medical.dao.OrderDAO, com.medical.model.User, com.medical.model.CartItem, java.text.SimpleDateFormat"
        %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Orders | Online Medical Store</title>
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
                    --card-bg: rgba(255, 255, 255, 0.9);
                    --text-main: #1e293b;
                    --text-muted: #64748b;
                    --border: #e2e8f0;
                    --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
                }

                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background: linear-gradient(135deg, #f0fdf4 0%, #e0f2fe 100%);
                    color: var(--text-main);
                    min-height: 100vh;
                    line-height: 1.6;
                }

                .header {
                    background: rgba(255, 255, 255, 0.8);
                    backdrop-filter: blur(10px);
                    padding: 1rem 5%;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    position: sticky;
                    top: 0;
                    z-index: 1000;
                    border-bottom: 1px solid var(--border);
                    box-shadow: var(--shadow);
                }

                .logo {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--primary-dark);
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    text-decoration: none;
                }

                .nav-links {
                    display: flex;
                    gap: 25px;
                    align-items: center;
                }

                .nav-links a {
                    color: var(--text-main);
                    text-decoration: none;
                    font-weight: 500;
                    font-size: 0.95rem;
                    transition: all 0.3s;
                    display: flex;
                    align-items: center;
                    gap: 6px;
                }

                .nav-links a:hover {
                    color: var(--primary);
                }

                .nav-links a.active {
                    color: var(--primary);
                    font-weight: 600;
                }

                .container {
                    max-width: 1200px;
                    margin: 3rem auto;
                    padding: 0 20px;
                }

                .glass-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border-radius: 20px;
                    border: 1px solid rgba(255, 255, 255, 0.5);
                    box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
                    padding: 2.5rem;
                }

                .page-header {
                    text-align: center;
                    margin-bottom: 3rem;
                }

                .page-header h1 {
                    font-size: 2.25rem;
                    font-weight: 800;
                    color: var(--text-main);
                    margin-bottom: 0.5rem;
                }

                .page-header p {
                    color: var(--text-muted);
                    font-size: 1.1rem;
                }

                .table-wrapper {
                    overflow-x: auto;
                    border-radius: 12px;
                    border: 1px solid var(--border);
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    background: white;
                }

                th {
                    background: #f8fafc;
                    padding: 1.25rem 1rem;
                    text-align: left;
                    font-size: 0.8rem;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    color: var(--text-muted);
                    border-bottom: 2px solid var(--border);
                }

                td {
                    padding: 1.25rem 1rem;
                    border-bottom: 1px solid var(--border);
                    font-size: 0.95rem;
                    vertical-align: middle;
                }

                tr:last-child td {
                    border-bottom: none;
                }

                tr:hover td {
                    background-color: #f0fdf4;
                }

                .badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    padding: 0.4rem 0.8rem;
                    border-radius: 99px;
                    font-size: 0.75rem;
                    font-weight: 700;
                    text-transform: uppercase;
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

                .badge-paid {
                    background: #d1fae5;
                    color: #065f46;
                }

                .btn-pay {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    padding: 0.6rem 1.2rem;
                    background: var(--secondary);
                    color: white;
                    text-decoration: none;
                    border-radius: 10px;
                    font-size: 0.85rem;
                    font-weight: 600;
                    transition: all 0.3s;
                    box-shadow: 0 4px 6px -1px rgba(99, 102, 241, 0.4);
                }

                .btn-pay:hover {
                    background: #4f46e5;
                    transform: translateY(-2px);
                    box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
                }

                .confirmed-text {
                    color: var(--primary-dark);
                    font-weight: 700;
                    display: flex;
                    align-items: center;
                    gap: 6px;
                }

                .empty-state {
                    text-align: center;
                    padding: 5rem 2rem;
                }

                .empty-state i {
                    font-size: 4rem;
                    color: var(--border);
                    margin-bottom: 1.5rem;
                }

                .empty-state h3 {
                    font-size: 1.5rem;
                    color: var(--text-main);
                    margin-bottom: 1rem;
                }

                .btn-shop {
                    display: inline-flex;
                    align-items: center;
                    gap: 10px;
                    padding: 0.8rem 2rem;
                    background: var(--primary);
                    color: white;
                    text-decoration: none;
                    border-radius: 12px;
                    font-weight: 600;
                    transition: all 0.3s;
                }

                .btn-shop:hover {
                    background: var(--primary-dark);
                    transform: scale(1.05);
                }

                @media (max-width: 768px) {
                    .header {
                        padding: 1rem 20px;
                    }

                    .nav-links {
                        display: none;
                    }

                    .container {
                        margin: 1.5rem auto;
                    }

                    .glass-card {
                        padding: 1.5rem;
                    }
                }
            </style>
        </head>

        <body>
            <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.html");
                return; } SimpleDateFormat sdf=new SimpleDateFormat("dd MMM yyyy, hh:mm a"); %>

                <header class="header">
                    <a href="home.jsp" class="logo"><i class="fas fa-capsules"></i> MedStore</a>
                    <nav class="nav-links">
                        <a href="home.jsp"><i class="fas fa-home"></i> Home</a>
                        <a href="services.jsp"><i class="fas fa-hand-holding-medical"></i> Services</a>
                        <a href="orders.jsp" class="active"><i class="fas fa-shopping-bag"></i> My Orders</a>
                        <a href="cart.jsp" style="position: relative;">
                            <i class="fas fa-shopping-cart"></i> Cart
                            <% List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                                    int cartSize = (cart != null) ? cart.size() : 0;
                                    if (cartSize > 0) {
                                    %>
                                    <span
                                        style="background: #ef4444; color: white; border-radius: 50%; padding: 2px 6px; font-size: 0.7rem; position: absolute; top: -10px; right: -15px;">
                                        <%= cartSize %>
                                    </span>
                                    <% } %>
                        </a>
                        <a href="login.html" style="color: #ef4444;"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </nav>
                </header>

                <div class="container">
                    <div class="glass-card">
                        <div class="page-header">
                            <h1>Order History</h1>
                            <p>Track and manage your medical supplies</p>
                        </div>
                        <div class="table-wrapper">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Medicine</th>
                                        <th>Qty</th>
                                        <th>Total</th>
                                        <th>Order Date</th>
                                        <th>Status</th>
                                        <th>Payment</th>
                                        <th>Delivery</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% OrderDAO dao=new OrderDAO(); ArrayList<Order> list =
                                        dao.getOrdersByUser(user.getId());
                                        for(Order o : list) {
                                        %>
                                        <tr>
                                            <td style="font-weight: 700; color: var(--secondary);">#<%= o.getId() %>
                                            </td>
                                            <td style="font-weight: 600;">
                                                <%= o.getMedicineName() %>
                                            </td>
                                            <td>
                                                <%= o.getQuantity() %>
                                            </td>
                                            <td style="font-weight: 700;">₹<%= o.getTotalPrice() %>
                                            </td>
                                            <td style="color: var(--text-muted); font-size: 0.85rem;">
                                                <%= sdf.format(o.getOrderDate()) %>
                                            </td>
                                            <td>
                                                <span class="badge badge-<%= o.getStatus().toLowerCase() %>">
                                                    <% if(o.getStatus().equalsIgnoreCase("Delivered")) { %><i
                                                            class="fas fa-check-circle"></i>
                                                        <% } else if(o.getStatus().equalsIgnoreCase("Shipped")) { %><i
                                                                class="fas fa-truck"></i>
                                                            <% } else { %><i class="fas fa-clock"></i>
                                                                <% } %>
                                                                    <%= o.getStatus() %>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge badge-<%= o.getPaymentStatus().toLowerCase() %>">
                                                    <% if(o.getPaymentStatus().equalsIgnoreCase("Paid")) { %><i
                                                            class="fas fa-shield-check"></i>
                                                        <% } else { %><i class="fas fa-exclamation-circle"></i>
                                                            <% } %>
                                                                <%= o.getPaymentStatus() %>
                                                </span>
                                            </td>
                                            <td style="font-weight: 500;">
                                                <% String delDate=o.getEstimatedDelivery() !=null ? new
                                                    SimpleDateFormat("dd MMM").format(o.getEstimatedDelivery()) : "TBD"
                                                    ; %>
                                                    <%= delDate %>
                                            </td>
                                            <td>
                                                <% if(o.getPaymentStatus().equals("Pending")) { %>
                                                    <a href="payment.jsp?orderIds=<%= o.getId() %>&amount=<%= o.getTotalPrice() %>"
                                                        class="btn-pay"><i class="fas fa-credit-card"></i> Pay Now</a>
                                                    <% } else { %>
                                                        <span class="confirmed-text"><i class="fas fa-check-double"></i>
                                                            Confirmed</span>
                                                        <% } %>
                                            </td>
                                        </tr>
                                        <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% if(list.isEmpty()) { %>
                            <div class="empty-state"><i class="fas fa-shopping-basket"></i>
                                <h3>No orders found</h3>
                                <p>Looks like you haven't ordered anything yet.</p><br><a href="home.jsp"
                                    class="btn-shop"><i class="fas fa-plus"></i> Start Shopping</a>
                            </div>
                            <% } %>
                    </div>
                </div>
        </body>

        </html>