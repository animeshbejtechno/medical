<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="java.util.ArrayList, java.util.List, com.medical.model.Service, com.medical.dao.ServiceDAO, com.medical.model.User, com.medical.model.CartItem"
        %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Home Medical Services - Online Medical Store</title>
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

                .service-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                    gap: 2rem;
                }

                .service-card {
                    background: var(--white);
                    border-radius: 12px;
                    padding: 2rem;
                    box-shadow: var(--shadow);
                    transition: transform 0.3s;
                    display: flex;
                    flex-direction: column;
                }

                .service-card:hover {
                    transform: translateY(-5px);
                }

                .service-name {
                    font-size: 1.4rem;
                    font-weight: 600;
                    color: var(--primary);
                    margin-bottom: 1rem;
                }

                .service-desc {
                    color: #666;
                    margin-bottom: 1.5rem;
                    flex-grow: 1;
                }

                .service-price {
                    font-size: 1.2rem;
                    font-weight: 600;
                    color: #e67e22;
                    margin-bottom: 1.5rem;
                }

                .booking-form {
                    display: flex;
                    flex-direction: column;
                    gap: 10px;
                }

                .input-field {
                    padding: 0.8rem;
                    border: 1px solid #ddd;
                    border-radius: 6px;
                    font-family: inherit;
                }

                .btn {
                    padding: 0.8rem;
                    background: var(--primary);
                    color: var(--white);
                    border: none;
                    border-radius: 6px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: background 0.3s;
                    text-align: center;
                }

                .btn:hover {
                    background: var(--primary-dark);
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
                        <a href="cart.jsp">Cart</a>
                        <span style="margin-left: 20px; font-weight: 600;">Hi, <%= user.getName() %></span>
                        <a href="login.html">Logout</a>
                    </div>
                </header>

                <div class="container">
                    <% String msg=request.getParameter("msg"); %>
                        <% if(msg !=null) { %>
                            <div class="msg <%= msg.contains(" Success") ? "msg-success" : "msg-error" %>"><%= msg %>
                            </div>
                            <% } %>

                                <h2>Home Medical Services</h2>
                                <p style="text-align: center; margin-bottom: 3rem; color: #666;">Professional healthcare
                                    services delivered to your doorstep.</p>

                                <div class="service-grid">
                                    <% ServiceDAO dao=new ServiceDAO(); ArrayList<Service> list = dao.getAllServices();
                                        for(Service s : list) { %>
                                        <div class="service-card">
                                            <div class="service-name">
                                                <%= s.getName() %>
                                            </div>
                                            <div class="service-desc">
                                                <%= s.getDescription() %>
                                            </div>
                                            <div class="service-price">₹<%= s.getPrice() %>
                                            </div>

                                            <form action="BookServiceServlet" method="post" class="booking-form">
                                                <input type="hidden" name="serviceId" value="<%= s.getId() %>">
                                                <input type="text" name="phone" placeholder="Phone Number" required
                                                    class="input-field">
                                                <textarea name="address" placeholder="Service Address" required
                                                    class="input-field" rows="2"></textarea>
                                                <button type="submit" class="btn">Book Now</button>
                                            </form>
                                        </div>
                                        <% } %>
                                </div>
                </div>

                <footer>
                    <p>© 2025 Online Medical Store. All rights reserved.</p>
                </footer>

        </body>

        </html>