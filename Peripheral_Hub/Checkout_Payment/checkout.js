//validation
var tele = document.getElementById("billtele");
var email = document.getElementById("billemail");
var telenum = 0;
var mailboxnum = 0;

var pattern1 = /^(01[0-9])\d{7,8}$/;
tele.onblur = function () {
    if (pattern1.test(tele.value)) {
        telenum = 1;
    } else {
        telenum = 0;
    }
}

var pattern2 = /^[0-9a-zA-Z_]{5,18}@[0-9a-z]+.com$/;
email.onblur = function () {
    if (pattern2.test(email.value)) {
        mailboxnum = 1;
    } else {
        mailboxnum = 0;
    }
}

//-------------------------------------------------------------------------------->
function storebill() {
    let state = document.getElementById("state");
    let name = document.getElementById("billName");
    let add = document.getElementById("billadd");
    let door = document.getElementById("billdoor");
    let city = document.getElementById("billcity");

    if (state.value == "State" || name.value == "" || add.value == "" || city.value == "" || !telenum || !mailboxnum) {
        if (state.value == "State") {
            state.focus();
        }
        else if (!mailboxnum) {
            email.focus();
        }
        else if (name.value == "") {
            name.focus();
        }
        else if (add.value == "") {
            add.focus();
        }
        else if (city.value == "") {
            city.focus();
        }
        else if (!telenum) {
            tele.focus();
        }



        alert("Please ensure that every information is correct before submit!");
    }

    else {
        let billaddress = {

            Name: name.value,
            Address: add.value,
            Doorno: door.value,
            City: city.value,
            Telephone: tele.value,
            Type: "Billing",
        }

        localStorage.setItem("Billing", JSON.stringify(billaddress));

        window.location.href = "../paymentpages/payment.html";
    }
}

//function of displacing prices in pricediv ------- from local storage ----->

let totalprice = JSON.parse(localStorage.getItem("totalCost"));
document.getElementById("totallocal").innerText = "RM" + totalprice;
totalprice += 5;
totalprice = totalprice.toFixed(2);
localStorage.setItem("Totalcheckout", totalprice);
document.getElementById("oritotal").innerText = "RM" + totalprice;

let countedItems = JSON.parse(localStorage.getItem("cartNumbers"));
document.getElementById("Item").innerHTML = countedItems + " " + "ITEMS";







