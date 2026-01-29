// Retrieve customer data from localStorage
var billingData = localStorage.getItem('Billing');
var customerDetailsElement = document.getElementById('customerDetails');

if (billingData) {
    // Parse JSON data
    var billingObject = JSON.parse(billingData);

    // Construct HTML for customer details
    var customerDetailsHTML = `
        <p><strong>Customer Name: </strong> ${billingObject.Name}</p>
        <p><strong>Customer Address: </strong> ${billingObject.Address}</p>
        <p><strong>City: </strong> ${billingObject.City}</p>
        <p><strong>Contact: </strong> ${billingObject.Telephone}</p>
    `;

    // Append customer details to the customerDetailsElement
    customerDetailsElement.innerHTML = customerDetailsHTML;
}

// Generate a random alphanumeric string for the order serial number
function generateOrderSerialNumber(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

// Generate and assign a random order serial number
document.getElementById('orderSerialNumber').textContent = generateOrderSerialNumber(16);

// Get current date
var today = new Date();

// Format date as required (e.g., "yyyy-mm-dd")
var formattedDate = today.toISOString().split('T')[0]; // Adjust format as needed

// Assign current date to the Invoice Date and Order Paid Date fields
document.getElementById('invoiceDate').textContent = formattedDate;
document.getElementById('orderPaidDate').textContent = formattedDate;

// Retrieve total payment amount from localStorage
var totalPayment = localStorage.getItem('Totalpayment');
var paymentDetailsElement = document.getElementById('paymentDetails');

if (totalPayment) {
    // Remove quotes from total payment
    totalPayment = totalPayment.replace(/"/g, '');

    // Construct HTML for payment details
    var paymentDetailsHTML = `<p class="totalPayment"><strong>Total Payment: RM ${totalPayment}</strong></p>`;

    // Append payment details to the paymentDetailsElement
    paymentDetailsElement.innerHTML = paymentDetailsHTML;
}

// Retrieve ordered product details from localStorage
var productContainer = document.getElementById('orderDetails');

// Call function to display cart items
displayCart();

function displayCart() {
    let cartItems = localStorage.getItem('productsInCart');
    cartItems = JSON.parse(cartItems);

    let cart = localStorage.getItem("totalCost");
    cart = parseInt(cart);

    if (cartItems && productContainer) {
        productContainer.innerHTML = `
            <div class="product-details">
                <p><strong>Product Name</strong></p>
                <p><strong>Net Product Price</strong></p>
                <p><strong>Quantity</strong></p>
                <p><strong>Subtotal</strong></p>
            </div>
            <hr>
        `;
        Object.values(cartItems).map((item, index) => {
            productContainer.innerHTML += `
                <div class="product-details">
                    <p>${item.name}</p>
                    <p>RM${item.price}.00</p>
                    <p>${item.inCart}</p>
                    <p>RM${item.inCart * item.price}.00</p>
                </div>
            `;
        });

        productContainer.innerHTML += `
            <div class="basketTotalContainer">
                <h4 class="basketTotalTitle">Total Price:</h4>
                <h4 class="basketTotal">RM${cart}.00</h4>
            </div>
            <div class="basketTotalContainer">
                <h4 class="basketTotalTitle">Shipping Charges:</h4>
                <h4 class="basketTotal">RM5.00</h4>
            </div>`;
    }
}

function backToHomePage() {
    //Clear Cart
    localStorage.removeItem('productsInCart');
    localStorage.removeItem('cartNumbers');
    localStorage.removeItem('totalCost');
    window.location.href = "/index.html";
}