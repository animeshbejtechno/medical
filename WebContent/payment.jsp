<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.medical.model.User" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Secure Payment - Online Medical Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
            <style>
                :root {
                    --primary: #2e8b75;
                    --primary-dark: #246d5c;
                    --bg: #f4f7f6;
                    --text: #333;
                    --white: #ffffff;
                    --shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                }

                * {
                    box-sizing: border-box;
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background: linear-gradient(135deg, #f4f7f6 0%, #e9f0ee 100%);
                    color: var(--text);
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .payment-card {
                    background: var(--white);
                    padding: 3rem;
                    border-radius: 16px;
                    box-shadow: var(--shadow);
                    width: 100%;
                    max-width: 450px;
                }

                .logo {
                    font-size: 1.5rem;
                    font-weight: 600;
                    color: var(--primary);
                    text-align: center;
                    margin-bottom: 2rem;
                }

                h2 {
                    text-align: center;
                    margin-bottom: 1.5rem;
                    color: #555;
                    font-weight: 600;
                }

                .order-summary {
                    background: #f9f9f9;
                    padding: 1rem;
                    border-radius: 8px;
                    margin-bottom: 2rem;
                    border: 1px solid #eee;
                }

                .form-group {
                    margin-bottom: 1.2rem;
                }

                label {
                    display: block;
                    margin-bottom: 0.4rem;
                    font-weight: 600;
                    font-size: 0.85rem;
                    color: #666;
                }

                input {
                    width: 100%;
                    padding: 0.8rem;
                    border: 1px solid #ddd;
                    border-radius: 8px;
                    font-size: 1rem;
                    transition: border-color 0.3s;
                }

                input:focus {
                    outline: none;
                    border-color: var(--primary);
                }

                .card-row {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 15px;
                }

                .btn {
                    width: 100%;
                    padding: 1rem;
                    background: var(--primary);
                    color: var(--white);
                    border: none;
                    border-radius: 8px;
                    font-size: 1rem;
                    font-weight: 600;
                    cursor: pointer;
                    transition: background 0.3s;
                    margin-top: 1rem;
                }

                .btn:hover {
                    background: var(--primary-dark);
                }

                .secure-badge {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 8px;
                    margin-top: 1.5rem;
                    font-size: 0.8rem;
                    color: #888;
                }
            </style>
        </head>

        <body>

            <div class="payment-card">
                <div class="logo">💊 MedicalStore</div>
                <h2>Secure Checkout</h2>

                <div class="order-summary">
                    <p><strong>Total Amount:</strong> ₹<%= request.getParameter("amount") %>
                    </p>
                </div>

                <style>
                    .payment-methods {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(80px, 1fr));
                        gap: 10px;
                        margin-bottom: 2rem;
                    }

                    .method-option {
                        border: 2px solid #eee;
                        border-radius: 10px;
                        padding: 10px;
                        text-align: center;
                        cursor: pointer;
                        transition: all 0.3s;
                    }

                    .method-option input {
                        display: none;
                    }

                    .method-option i {
                        font-size: 1.5rem;
                        display: block;
                        margin-bottom: 5px;
                        color: #888;
                    }

                    .method-option span {
                        font-size: 0.75rem;
                        font-weight: 600;
                        color: #666;
                    }

                    .method-option:hover {
                        border-color: var(--primary);
                        background: #f0fdfa;
                    }

                    .method-option.active {
                        border-color: var(--primary);
                        background: #f0fdfa;
                    }

                    .method-option.active i,
                    .method-option.active span {
                        color: var(--primary);
                    }

                    .payment-details {
                        display: none;
                        animation: fadeIn 0.3s ease;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .qr-container {
                        text-align: center;
                        padding: 1rem;
                        background: #f9f9f9;
                        border-radius: 12px;
                        border: 2px dashed #ddd;
                    }

                    .qr-code {
                        width: 150px;
                        height: 150px;
                        margin: 0 auto 1rem;
                        background: #eee;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 3rem;
                        color: #ccc;
                    }
                </style>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <form action="ProcessPaymentServlet" method="post" id="paymentForm">
                    <input type="hidden" name="orderIds" value="<%= request.getParameter(" orderIds") %>">

                    <label>Select Payment Method</label>
                    <div class="payment-methods">
                        <label class="method-option active" onclick="selectMethod('card')">
                            <input type="radio" name="paymentMethod" value="Card" checked>
                            <i class="fas fa-credit-card"></i>
                            <span>Card</span>
                        </label>
                        <label class="method-option" onclick="selectMethod('upi')">
                            <input type="radio" name="paymentMethod" value="UPI">
                            <i class="fas fa-mobile-alt"></i>
                            <span>UPI</span>
                        </label>
                        <label class="method-option" onclick="selectMethod('cod')">
                            <input type="radio" name="paymentMethod" value="COD">
                            <i class="fas fa-hand-holding-usd"></i>
                            <span>COD</span>
                        </label>
                    </div>

                    <!-- Card Details -->
                    <div id="cardDetails" class="payment-details" style="display: block;">
                        <div class="form-group">
                            <label>Cardholder Name</label>
                            <input type="text" name="cardName" placeholder="John Doe">
                        </div>
                        <div class="form-group">
                            <label>Card Number</label>
                            <input type="text" name="cardNumber" placeholder="XXXX XXXX XXXX XXXX">
                        </div>
                        <div class="card-row">
                            <div class="form-group">
                                <label>Expiry</label>
                                <input type="text" name="expiry" placeholder="MM/YY">
                            </div>
                            <div class="form-group">
                                <label>CVV</label>
                                <input type="password" name="cvv" placeholder="***">
                            </div>
                        </div>
                    </div>

                    <!-- UPI Details -->
                    <div id="upiDetails" class="payment-details">
                        <div class="qr-container">
                            <div class="qr-code">
                                <i class="fas fa-qrcode"></i>
                            </div>
                            <p style="font-size: 0.8rem; color: #666; margin-bottom: 1rem;">Scan QR with Paytm or GPay
                            </p>
                            <div class="form-group" style="text-align: left;">
                                <label>UPI ID</label>
                                <input type="text" name="upiId" placeholder="username@upi">
                            </div>
                        </div>
                    </div>

                    <!-- COD Details -->
                    <div id="codDetails" class="payment-details">
                        <div class="qr-container"
                            style="border-style: solid; background: #fffbeb; border-color: #fef3c7;">
                            <i class="fas fa-truck" style="font-size: 2rem; color: #d97706; margin-bottom: 1rem;"></i>
                            <p style="font-weight: 600; color: #92400e;">Cash on Delivery</p>
                            <p style="font-size: 0.8rem; color: #b45309;">Pay ₹<%= request.getParameter("amount") %>
                                    when you receive your order.</p>
                        </div>
                    </div>

                    <button type="submit" class="btn" id="payBtn">Pay ₹<%= request.getParameter("amount") %></button>
                </form>

                <script>
                    function selectMethod(method) {
                        // Update active class
                        document.querySelectorAll('.method-option').forEach(opt => opt.classList.remove('active'));
                        event.currentTarget.classList.add('active');

                        // Hide all details
                        document.querySelectorAll('.payment-details').forEach(det => det.style.display = 'none');

                        // Show selected details
                        document.getElementById(method + 'Details').style.display = 'block';

                        // Update button text
                        const payBtn = document.getElementById('payBtn');
                        if (method === 'cod') {
                            payBtn.innerText = 'Confirm Order (COD)';
                        } else {
                            payBtn.innerText = 'Pay ₹<%= request.getParameter("amount") %>';
                        }
                    }
                </script>

                <div class="secure-badge">
                    🔒 SSL Secure Payment | Simulated Gateway
                </div>
            </div>

        </body>

        </html>