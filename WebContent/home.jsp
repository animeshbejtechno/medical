<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="java.util.ArrayList, java.util.List, com.medical.model.Medicine, com.medical.dao.MedicineDAO, com.medical.model.CartItem, com.medical.model.User"
        %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Home - Online Medical Store</title>
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

                .nav-links a:hover {
                    opacity: 0.8;
                }

                .hero {
                    background: linear-gradient(135deg, var(--primary), #4ca1af);
                    color: white;
                    padding: 4rem 5%;
                    text-align: center;
                }

                .hero h1 {
                    font-size: 2.5rem;
                    margin-bottom: 1rem;
                }

                .container {
                    max-width: 1200px;
                    margin: 2rem auto;
                    padding: 0 20px;
                }

                h2 {
                    margin-bottom: 2rem;
                    color: var(--primary);
                    text-align: center;
                }

                .medicine-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 2rem;
                }

                .medicine-card {
                    background: var(--white);
                    border-radius: 12px;
                    overflow: hidden;
                    box-shadow: var(--shadow);
                    transition: transform 0.3s;
                    display: flex;
                    flex-direction: column;
                }

                .medicine-card:hover {
                    transform: translateY(-5px);
                }

                .medicine-info {
                    padding: 1.5rem;
                    flex-grow: 1;
                }

                .medicine-name {
                    font-size: 1.25rem;
                    font-weight: 600;
                    margin-bottom: 0.5rem;
                    color: var(--primary);
                }

                .medicine-price {
                    font-size: 1.1rem;
                    font-weight: 600;
                    color: #e67e22;
                    margin-bottom: 1rem;
                }

                .medicine-desc {
                    font-size: 0.9rem;
                    color: #666;
                    margin-bottom: 1rem;
                    height: 3.6rem;
                    overflow: hidden;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    line-clamp: 2;
                    -webkit-box-orient: vertical;
                }

                .medicine-stock {
                    font-size: 0.85rem;
                    color: #888;
                    margin-bottom: 1.5rem;
                }

                .buy-form {
                    display: flex;
                    gap: 10px;
                    align-items: center;
                }

                .qty-input {
                    width: 60px;
                    padding: 0.5rem;
                    border: 1px solid #ddd;
                    border-radius: 4px;
                }

                .btn {
                    flex-grow: 1;
                    padding: 0.6rem;
                    background: var(--primary);
                    color: var(--white);
                    border: none;
                    border-radius: 6px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: background 0.3s;
                    text-align: center;
                    text-decoration: none;
                }

                .btn:hover {
                    background: var(--primary-dark);
                }

                .btn:disabled {
                    background: #ccc;
                    cursor: not-allowed;
                }

                .msg {
                    padding: 1rem;
                    margin-bottom: 2rem;
                    border-radius: 6px;
                    text-align: center;
                    max-width: 600px;
                    margin-left: auto;
                    margin-right: auto;
                }

                .msg-success {
                    background: #d4edda;
                    color: #155724;
                }

                .msg-error {
                    background: #f8d7da;
                    color: #721c24;
                }

                footer {
                    background: #333;
                    color: white;
                    text-align: center;
                    padding: 2rem;
                    margin-top: 4rem;
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
                        <a href="cart.jsp" style="position: relative;">
                            Cart 🛒
                            <% List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                                    int cartSize = (cart != null) ? cart.size() : 0;
                                    if (cartSize > 0) { %>
                                    <span
                                        style="background: #e67e22; color: white; border-radius: 50%; padding: 2px 6px; font-size: 0.7rem; position: absolute; top: -10px; right: -15px;">
                                        <%= cartSize %>
                                    </span>
                                    <% } %>
                        </a>
                        <span style="margin-left: 20px; font-weight: 600;">Hi, <%= user.getName() %></span>
                        <a href="login.html">Logout</a>
                    </div>
                </header>

                <section class="hero">
                    <h1>Your Health, Our Priority</h1>
                    <p>Get your medicines delivered at your doorstep with just a few clicks.</p>
                </section>

                <div class="container">
                    <% String msg=request.getParameter("msg"); %>
                        <% if(msg !=null) { %>
                            <div class="msg <%= msg.contains(" Success") ? "msg-success" : "msg-error" %>"><%= msg %>
                            </div>
                            <% } %>

                                <h2>Available Medicines</h2>

                                <div class="medicine-grid">
                                    <% MedicineDAO dao=new MedicineDAO(); ArrayList<Medicine> list =
                                        dao.getAllMedicines();
                                        for(Medicine m : list) {
                                        %>
                                        <div class="medicine-card">
                                            <div class="medicine-info">
                                                <div class="medicine-name">
                                                    <%= m.getName() %>
                                                </div>
                                                <div class="medicine-price">₹<%= m.getPrice() %>
                                                </div>
                                                <div class="medicine-desc">
                                                    <%= m.getDescription() !=null ? m.getDescription()
                                                        : "No description available." %>
                                                </div>
                                                <div class="medicine-stock">Stock: <%= m.getStock() %> units</div>

                                                <form action="AddToCartServlet" method="post" class="buy-form">
                                                    <input type="hidden" name="medicineId" value="<%= m.getId() %>">
                                                    <input type="number" name="quantity" value="1" min="1"
                                                        max="<%= m.getStock() %>" class="qty-input" <%=m.getStock() <=0
                                                        ? "disabled" : "" %>>
                                                    <button type="submit" class="btn" <%=m.getStock() <=0 ? "disabled"
                                                        : "" %>>
                                                        Add to Cart
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <% } %>
                                            <% if(list.isEmpty()) { %>
                                                <p style="grid-column: 1/-1; text-align: center; color: #888;">No
                                                    medicines available at the moment. Please check back later.</p>
                                                <% } %>
                                </div>
                </div>

                <footer>
                    <p>© 2025 Online Medical Store. All rights reserved.</p>
                </footer>

        </body>

        </html>