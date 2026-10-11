create database cabbooking;

use cabbooking;

-- customer table 
create table customers(
customer_id int primary key,
name varchar(100),
email varchar(100),
registration_date date
);

-- Drivers table
create table drivers(
driver_id int primary key,
name varchar(100),
phone varchar(15),
license_no varchar(20)
);

-- Cabs  Table
Create Table Cabs(
cab_id int primary key,
vehicle_no varchar(20),
cab_type varchar(20),
driver_id int,
foreign key(driver_id) references drivers(driver_id)
);

-- booking table 
Create table booking(
booking_id int primary key,
customer_id int,
cab_id int,
driver_id int,
bookingtime datetime,
pickup_location varchar(100),
dropoff_location varchar(100),
status varchar(20),
cancellation_reason varchar(100),
foreign key(Customer_id)references customers(customer_id),
foreign key(cab_id)references cabs(cab_id),
foreign key(driver_id) references drivers(driver_id)
);

-- tripdetails
create table tripdetails(
trip_id int primary key,
booking_id int,
trip_start_time datetime,
trip_end_time datetime,
distanace_km decimal(10,2),
fare decimal(10,2),
foreign key(booking_id) references booking(booking_id)
);

-- feedback table
create table feedback(
feedback_id int primary key,
booking_id int,
rating decimal(2,1),
comments varchar(100),
feedback_time datetime,
foreign key(booking_id) references booking(booking_id)
);

INSERT INTO Customers VALUES
  (1, 'Anjali Sharma', 'anjali.sharma@email.com', '2024-01-10'),
  (2, 'Rohit Verma', 'rohit.verma@email.com', '2024-01-15'),
  (3, 'Priya Singh', 'priya.singh@email.com', '2024-02-02'),
  (4, 'Amit Patel', 'amit.patel@email.com', '2024-02-12'),
  (5, 'Sneha Iyer', 'sneha.iyer@email.com', '2024-03-01');

  INSERT INTO Drivers VALUES
  (101, 'Sunil Kumar', '9000000001', 'DL202001'),
  (102, 'Seema Reddy', '9000000002', 'DL202002'),
  (103, 'Rajesh Yadav', '9000000003', 'DL202003'),
  (104, 'Rakesh Nair', '9000000004', 'DL202004'),
  (105, 'Meena Sharma', '9000000005', 'DL202005');
  
  INSERT INTO Cabs VALUES
  (201, 'MH01AB1234', 'Sedan', 101),
  (202, 'DL01BC2345', 'SUV', 102),
  (203, 'KA01DE3456', 'Sedan', 103),
  (204, 'GJ01FG4567', 'Hatchback', 104),
  (205, 'TN01HI5678', 'SUV', 105);
  
INSERT INTO Booking VALUES
  (301, 1, 201, 101, '2025-07-28 09:00:00', 'Connaught Place', 'Airport', 'Completed', NULL),
  (302, 2, 202, 102, '2025-07-29 13:30:00', 'MG Road', 'Cyber City', 'Cancelled', 'Changed plans'),
  (303, 3, 202, 102, '2025-07-29 18:00:00', 'Home', 'Market', 'Completed', NULL),
  (304, 5, 203, 103, '2025-07-30 09:45:00', 'Powai', 'Thane', 'Completed', NULL),
  (305, 4, 204, 104, '2025-07-30 11:00:00', 'Gandhinagar', 'Ahmedabad', 'Completed', NULL);

INSERT INTO Tripdetails VALUES
  (401, 301, '2025-07-28 09:10:00', '2025-07-28 09:50:00', 18.5, 450.00),
  (402, 303, '2025-07-29 18:05:00', '2025-07-29 18:20:00', 4.2, 120.00),
  (403, 304, '2025-07-30 09:55:00', '2025-07-30 10:45:00', 22.0, 500.00),
  (404, 305, '2025-07-30 11:05:00', '2025-07-30 11:55:00', 25.7, 630.00);


INSERT INTO Feedback VALUES
  (501, 301, 4.2, 'Smooth ride!', '2025-07-28 10:00:00'),
  (502, 303, 2.8, 'Driver was late', '2025-07-29 18:25:00'),
  (503, 304, 5.0, 'Excellent service', '2025-07-30 10:50:00'),
  (504, 305, 3.0, 'Cab was not clean', '2025-07-30 12:00:00');

-- List all customers who have at least one completed booking.
Select distinct Customers.customer_id,customers.name from
customers
inner join booking
on customers.customer_id=booking.customer_id
where status='completed';

-- Show all feedback with a rating below 4.
select feedback.feedback_id,Customers.name,feedback.rating,feedback.comments from
feedback
inner join Booking on feedback.Booking_id=Booking.Booking_id
inner join customers on customers.customer_id=Booking.customer_id
where feedback.rating<4; 

-- find the total fare paid in completed booking by each customer.
select Customers.customer_id,customers.name,sum(tripdetails.fare),booking.status
from customers
inner join booking on customers.customer_id=booking.customer_id
inner join tripdetails on booking.booking_id=tripdetails.booking_id
where booking.status='Completed'
group by customers.customer_id,customers.name;

-- List all drivers' names and their assigned cab numbers.
select Drivers.name,cabs.vehicle_no as Cab_no from Drivers
inner join cabs on Drivers.driver_id=Cabs.Driver_id;

-- Which cab type has generated the highest revenue so far?
select Cabs.Cab_type,max(fare) as Highest_Revenue from Cabs
inner join booking on Cabs.cab_id=booking.cab_id
inner join tripdetails on booking.Booking_id=tripdetails.booking_id
group by Cab_type
order by Highest_Revenue desc
limit 1;

--  For each pickup location, what is the average trip distance?
Select booking.Pickup_Location,Avg(Tripdetails.distanace_km) as Trip_Distance 
from Booking inner join Tripdetails
on Booking.booking_id=Tripdetails.Booking_id
group by Pickup_location;

-- Which driver has received the lowest average feedback rating?
select Drivers.name,avg(rating) from Drivers 
inner join Booking on Drivers.driver_id=Booking.Driver_id
inner join Feedback on Booking.booking_id = feedback.booking_id
group by name
order by avg(rating)
limit 1;

-- Find all customers whose last booking was cancelled.
select Customers.name,Status from Customers
inner join Booking on Customers.Customer_id = Booking.Customer_id
where Status = "Cancelled";

-- List all completed bookings with customer name and cab type
select Customers.name,Cab_type,Status from Customers
inner join Booking on Customers.customer_id=Booking.Customer_id
inner join Cabs on Booking.cab_id = Cabs.cab_id
where status="Completed";

-- Count total number of bookings for each status
select Status,Count(Booking_id) from Booking
group by status;

-- Find the driver who completed the highest number of trips
Select Drivers.name,Count(Trip_id) from Drivers
inner join booking on Drivers.driver_id=booking.driver_id
inner join tripdetails on booking.booking_id=tripdetails.booking_id
group by Drivers.name;

-- Find average fare per cab type
select Cab_type,round(avg(fare),0) from Cabs
inner join booking on Cabs.driver_id=booking.driver_id
inner join tripdetails on booking.booking_id=tripdetails.booking_id
group by Cab_type;
-- List customers who have never cancelled a booking
select Customers.name,Status from Customers
inner join Booking on Customers.Customer_id=Booking.customer_id
where Status != 'cancelled';

-- Count total number of bookings for each status
select status,Count(Booking_id) as total_number_of_bookings from Booking
group by Status;
