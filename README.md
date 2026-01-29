# Peripheral Hub — E-Commerce Web Application (ASP.NET Web Forms)

Peripheral Hub is an e-commerce web application built with **ASP.NET Web Forms (C#)** and a SQL database.  
It supports customer shopping flows (browse → cart → checkout → invoice) and an admin dashboard for managing products, orders, and customers.

## Tech Stack
- **C#**, **ASP.NET Web Forms** (`.aspx`, `.aspx.cs`)
- **ADO.NET** (`SqlConnection`, `SqlCommand`, `SqlDataReader`)
- **SQL Server LocalDB** (`.mdf` in `App_Data`)
- Built-in ASP.NET features: **Session**, Validators, Web Forms controls (GridView, etc.)

## Key Features

### Customer Features
- Account registration and sign-in
- Browse products and view product details
- Cart management: view items, update quantity, remove items
- Checkout calculations (subtotal, tax, delivery charge, final total)
- Payment pages + invoice page

### Admin Features
- Admin login (restricted page access via session)
- Manage products (CRUD)
- Upload product images and store references in the database
- Manage orders and view customer/account records
- Dashboard pages for products / orders / clients

## Database Notes
This project uses SQL Server LocalDB with `.mdf` files stored in:
- `App_Data/PeripheralHub.mdf`
- `App_Data/membership.mdf`

`Web.config` includes the LocalDB connection strings.

## How to Run (Visual Studio)
1. Open `Peripheral_Hub.sln` in **Visual Studio**.
2. Restore NuGet packages (if prompted).
3. Build the solution.
4. Run the project.

### Important
- Ensure `App_Data` is included and the `.mdf` files are available.
- If the database does not attach automatically, confirm:
  - `Web.config` connection string points to `|DataDirectory|\PeripheralHub.mdf`
  - Visual Studio has permission to access LocalDB.

## Default Admin Login (Coursework)
This project uses a simple admin gate (coursework/demo style).
- Username: `admin2`
- Password: `admin2`

(You can change this in `Admin.aspx.cs`.)

## Project Structure
- `*.aspx` — UI pages
- `*.aspx.cs` — server-side logic (database queries, validation, workflow)
- `App_Data/` — LocalDB databases (`.mdf`)
- `Images/` — product images uploaded from admin dashboard
