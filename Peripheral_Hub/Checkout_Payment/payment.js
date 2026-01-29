function changeSucceedStyle(nameID, spanID) { // Modify the style and input box color of the following span if the input is successful
    spanID.firstChild.nodeValue = "*";
    spanID.style.color = "green";
}

function changeFailedStyle(nameID, spanID) { // Style when input fails and focus is not on the input box
    spanID.firstChild.nodeValue = "*"; // Set the font color, format, and size
    spanID.style.color = "red";
}

function changeFailingStyle(nameID, spanID) { // Style when input fails but focus is still on the input box
    spanID.style.color = "lightblue";
}

function spanValue(spanID, spanValue) { // Modify the content of the following words when there is a mismatch
    switch (spanValue) {
        case "cNumberSpan":
            spanID.firstChild.nodeValue = "16 digits only";
            break;
    }
}

var cNumbernum = 0;
var cHoldernum = 0;
var cMonthnum = 0;
var cYearnum = 0;
var cvvnum = 0;

var cNumberI = document.getElementById('<%= txtCardNo.ClientID %>');
var cNumberB = document.querySelector('.card-number-box');
var pattern1 = /^\d{16}$/;
cNumberI.onfocus = function () {
    if (!pattern1.test(cNumberI.value)) {
        spanValue(cNumberSpan, "cNumberSpan");
        changeFailingStyle(cNumberI, cNumberSpan);
    }
}
cNumberI.onkeyup = function () {
    if (pattern1.test(cNumberI.value)) {
        changeSucceedStyle(cNumberI, cNumberSpan);
    } else {
        spanValue(cNumberSpan, "cNumberSpan");
        changeFailingStyle(cNumberI, cNumberSpan);
    }
}
cNumberI.onblur = function () {
    if (pattern1.test(cNumberI.value)) {
        changeSucceedStyle(cNumberI, cNumberSpan);
        cNumbernum = 1;
    } else {
        changeFailedStyle(cNumberI, cNumberSpan);
        cNumbernum = 0;
    }
}

cNumberI.oninput = () => {
    cNumberB.innerText = cNumberI.value;
}

var cHolderI = document.getElementById('nc');
var cHolderB = document.querySelector('.card-holder-name');
var pattern2 = /^[a-zA-Z]+$/;

cHolderI.onblur = function () {
    if (cHolderI.value !== "" && pattern2.test(cHolderI.value)) {
        cHoldernum = 1;
    } else {
        cHoldernum = 0;
    }
}

cHolderI.oninput = () => {
    cHolderB.innerText = cHolderI.value;
}

var cMonthI = document.getElementById('month-input');
var cMonthB = document.querySelector('.exp-month');

cMonthI.onblur = function () {
    if (cMonthI.value == "month") {
        cMonthnum = 0;
    } else {
        cMonthnum = 1;
    }
}

cMonthI.oninput = () => {
    cMonthB.innerText = cMonthI.value + " /";
}

var cYearI = document.getElementById('year-input');
var cYearB = document.querySelector('.exp-year');

cYearI.onblur = function () {
    if (cYearI.value == "year") {
        cYearnum = 0;
    } else {
        cYearnum = 1;
    }
}

cYearI.oninput = () => {
    cYearB.innerText = cYearI.value;
}

var cCvvI = document.getElementById('<%= txtCVV.ClientID %>');
var pattern3 = /^\d{3}$/;

cCvvI.onblur = function () {
    if (pattern3.test(cCvvI.value)) {
        cvvnum = 1;
    } else {
        cvvnum = 0;
    }
}

var cFontB = document.querySelector('.front');
var cBackB = document.querySelector('.back');
cCvvI.onmouseenter = () => {
    cFontB.style.transform = 'perspective(1000px) rotateY(-180deg)';
    cBackB.style.transform = 'perspective(1000px) rotateY(0deg)';
}

cCvvI.onmouseleave = () => {
    cFontB.style.transform = 'perspective(1000px) rotateY(0deg)';
    cBackB.style.transform = 'perspective(1000px) rotateY(180deg)';
}

var cCvvB = document.querySelector('.cvv-box');
cCvvI.oninput = () => {
    cCvvB.innerText = cCvvI.value;
}

function continuePay() {
    var cNumberI = document.getElementById("cn");
    var cHolderI = document.getElementById('nc');
    var cMonthI = document.getElementById('month-input');
    var cYearI = document.getElementById('year-input');
    var cCvvI = document.getElementById('cvv-input');

    var cardDetails = {
        cardName: cNumberI.value,
        cardHolderName: cHolderI.value,
        cardMonth: cMonthI.value,
        cardYear: cYearI.value,
    }
    if (cNumbernum && cHoldernum && cMonthnum && cYearnum & cvvnum) {
        localStorage.setItem("cardPaymentDet", JSON.stringify(cardDetails));
        alert("Payment successful");
        window.location.href = "invoice/invoice.html";
    }
    else {
        if (!cNumbernum) {
            cNumberI.focus();
        } else if (!cHoldernum) {
            cHolderI.focus();
        } else if (!cMonthnum) {
            cMonthI.focus();
        } else if (!cYearnum) {
            cYearI.focus();
        } else if (!cvvnum) {
            cCvvI.focus();
        }
        alert("Please ensure that every information is correct before submit!")
    }
}


let sum = document.getElementById("rText2");
let total = JSON.parse(localStorage.getItem("Totalcheckout"));

total = total.toFixed(2);
sum.innerHTML = "RM" + total;

let itemstotal = document.getElementById("rText1");
const totalitemslocal = JSON.parse(localStorage.getItem("totalCost"));
itemstotal.innerText = "RM" + totalitemslocal;

localStorage.setItem("Totalpayment", JSON.stringify(total));

function changetotal() {

    total -= total * 0.2;
    total = total.toFixed(2)

    sum.innerHTML = "RM" + total;

    localStorage.setItem("Totalpayment", JSON.stringify(total));
}


let countedItems = JSON.parse(localStorage.getItem("cartNumbers"));
document.getElementById("Item").innerHTML = countedItems + " " + "ITEMS";