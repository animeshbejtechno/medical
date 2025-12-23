<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, com.medical.model.CartItem, com.medical.model.User" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Your Cart - Online Medical Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
            <style>
                :root {
                    --primary: #2e8b75;
                    --primary-dark: #246d5c;
                    --bg: #f4f7f6;
                    --text: #333;
                    --white: #ffffff;
                    --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                }

                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg);
                    color: var(--text);
                    line-height: 1.6;
                }

                .header {
                    background: var(--primary);
                    color: var(--white);
                    padding: 1rem 5%;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    box-shadow: var(--shadow);
                    position: sticky;
                    top: 0;
                    z-index: 100;
                }

                .logo {
                    font-size: 1.5rem;
                    font-weight: 600;
                }

                .nav-links a {
                    color: var(--white);
                    text-decoration: none;
                    margin-left: 20px;
                    font-weight: 400;
                    transition: opacity 0.3s;
                }

                .container {
                    max-width: 1000px;
                    margin: 2rem auto;
                    padding: 0 20px;
                }

                .card {
                    background: var(--white);
                    padding: 2rem;
                    border-radius: 12px;
                    box-shadow: var(--shadow);
                }

                h2 {
                    margin-bottom: 1.5rem;
                    color: var(--primary);
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 2rem;
                }

                th,
                td {
                    padding: 1rem;
                    text-align: left;
                    border-bottom: 1px solid #eee;
                }

                th {
                    background: #f9f9f9;
                    color: var(--primary);
                    font-weight: 600;
                }

                .total-row {
                    font-size: 1.2rem;
                    font-weight: 600;
                    text-align: right;
                    padding: 1rem;
                    color: var(--primary);
                }

                .btn {
                    display: inline-block;
                    padding: 0.8rem 2rem;
                    background: var(--primary);
                    color: var(--white);
                    border: none;
                    border-radius: 6px;
                    font-weight: 600;
                    cursor: pointer;
                    text-decoration: none;
                    transition: background 0.3s;
                }

                .btn:hover {
                    background: var(--primary-dark);
                }

                .btn-danger {
                    background: #e74c3c;
                    padding: 0.4rem 0.8rem;
                    font-size: 0.8rem;
                }

                .btn-danger:hover {
                    background: #c0392b;
                }

                .empty-cart {
                    text-align: center;
                    padding: 3rem;
                    color: #888;
                }
            </style>
        </head>

        <body>

            <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.html");
                return; } %>

                <header class="header">
                    <div class="logo">💊 MedicalStore</div>
                    <div class="nav-links">
                        <a href="home.jsp">Home</a>
                        <a href="services.jsp">Medical Services</a>
                        <a href="orders.jsp">My Orders</a>
                        <a href="cart.jsp">Cart</a>
                        <a href="login.html">Logout</a>
                    </div>
                </header>

                <div class="container">
                    <div class="card">
                        <h2>Shopping Cart</h2>

                        <% List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                                if (cart == null || cart.isEmpty()) { %>
                                <div class="empty-cart">
                                    <p>Your cart is empty.</p>
                                    <a href="home.jsp" class="btn" style="margin-top: 1rem;">Go Shopping</a>
                                </div>
                                <% } else { %>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Medicine</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>Total</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% double grandTotal=0; for (CartItem item : cart) { grandTotal
                                                +=item.getTotalPrice(); %>
                                                <tr>
                                                    <td>
                                                        <%= item.getName() %>
                                                    </td>
                                                    <td>₹<%= item.getPrice() %>
                                                    </td>
                                                    <td>
                                                        <%= item.getQuantity() %>
                                                    </td>
                                                    <td>₹<%= item.getTotalPrice() %>
                                                    </td>
                                                    <td>
                                                        <a href="RemoveFromCartServlet?medicineId=<%= item.getMedicineId() %>"
                                                            class="btn btn-danger">Remove</a>
                                                    </td>
                                                </tr>
                                                <% } %>
                                        </tbody>
                                    </table>

                                    <div class="total-row">
                                        Grand Total: ₹<%= grandTotal %>
                                    </div>

                                    <div style="text-align: right; margin-top: 2rem;">
                                        <form action="CheckoutServlet" method="post">
                                            <button type="submit" class="btn">Proceed to Checkout</button>
                                        </form>
                                    </div>
                                    <% } %>
                    </div>
                </div>

        </body>

        </html>