# Cab Booking System Database Project 🚖💻

A comprehensive relational database management and analytical SQL project designed to model, manage, and query a cab booking platform's operations, customers, drivers, trip metrics, and customer feedback.

---

## 📌 Project Overview
The **Cab Booking System** database structures core operational entities into a fully normalized relational model. It features custom table schemas, mock transactional data, and a suite of **14+ advanced analytical SQL queries** to evaluate business performance, driver ratings, revenue generation, and user activity.

---

## 🛠️ Database Schema & Architecture
The database (`cabbooking`) consists of six interconnected relational tables:
1. **`customers`**: Stores registered user profiles and registration dates.
2. **`drivers`**: Manages driver identification details, contact numbers, and license numbers.
3. **`cabs`**: Tracks vehicle units, cab types (Sedan, SUV, Hatchback), and links drivers via foreign keys.
4. **`booking`**: Records ride requests, timestamps, pickup/drop-off locations, and cancellation logs.
5. **`tripdetails`**: Captures actual trip execution metrics including start/end times, distance covered (km), and total fares.
6. **`feedback`**: Houses post-ride customer ratings and comments.

---

## 📊 Key Analytical Queries Included
The project script provides powerful SQL queries extracting business insights, such as:
* **Active User Tracking:** Identifying customers with at least one completed booking.
* **Service Quality Control:** Filtering feedback ratings below 4 to analyze customer dissatisfaction.
* **Financial Aggregations:** Calculating total fares generated per customer and average fares per cab type.
* **Operational Performance:** Finding the driver who completed the highest number of trips and the cab type yielding the highest revenue.
* **Route & Distance Analytics:** Evaluating average trip distances grouped by pickup locations.

---

## 📂 Repository Contents
* `Swarup_Cab_Booking_Project.sql`: The complete SQL script containing database creation, table DDL statements, sample data insertion scripts, and all 14+ analytical queries.

---

## 🚀 How to Run the Project
1. Clone or download the repository.
2. Open your preferred SQL environment (MySQL Workbench, phpMyAdmin, etc.).
3. Execute the `Swarup_Cab_Booking_Project.sql` script to automatically create the schema, insert mock records, and run the analytical queries.

---
