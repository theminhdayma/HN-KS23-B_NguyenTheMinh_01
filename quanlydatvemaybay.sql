
create database quanlydatvemaybay;
use quanlydatvemaybay;

-- PHẦN 2: Thiết kế cơ sở dữ liệu

create table Flight (
	flight_id varchar(10) primary key,
    airline_name varchar(100),
    departure_airport varchar(100),
    arrival_airport varchar(100),
    departure_time datetime,
    arrival_time datetime,
    ticket_price decimal
);

create table Passenger (
	passenger_id varchar(10) primary key,
    passenger_full_name varchar(150) not null,
    passenger_email varchar(255) unique,
    passenger_phone varchar(15) unique,
    passenger_bod date
);

create table Booking (
	booking_id int primary key auto_increment,
    passenger_id varchar(10) not null,
    flight_id varchar(10) not null,
    booking_date date,
    booking_status enum ('Confirmed', 'Cancelled','Pending'),
    foreign key (passenger_id) references Passenger(passenger_id),
    foreign key (flight_id) references Flight(flight_id)
);

create table Payment (
	payment_id int primary key auto_increment,
    booking_id int not null,
    payment_method enum ('Credit Card','Bank Transfer','Cash'),
    payment_amount decimal,
    payment_date date,
    payment_status enum ('Success','Failed','Pending'),
    foreign key (booking_id) references Booking(booking_id)
);

-- 2. Thêm cột passenger_gender có kiểu dữ liệu là enum với các giá trị 'Nam', 'Nữ', 'Khác' trong bảng Passenger.
alter table Passenger
add column passenger_gender enum ('Nam', 'Nu', 'Khac');

-- 3. Thêm cột ticket_quantity trong bảng Booking có kiểu dữ liệu là integer, 
-- có rằng buộc NOT NULL và giá trị mặc định là 1. Cột này thể hiện số lượng vé mà hành khách đã đặt
alter table Booking 
add column ticket_quantity integer not null default 1;

-- 4. Thêm rằng buộc cho cột payment_amount trong bảng Payment phải có giá trị lớn hơn 0 và có kiểu dữ liệu là DECIMAL(10, 2).
alter table Payment
modify column payment_amount decimal(10,2) check (payment_amount > 0);

-- PHẦN 3: Thao tác với dữ liệu các bảng
insert into Passenger (passenger_id, passenger_full_name, passenger_email, passenger_phone, passenger_bod, passenger_gender)
values
('P0001', 'Nguyen Anh Tuan', 'tuan.nguyen@example.com', '0901234567', '1995-05-15', 'Nam'),
('P0002', 'Tran Thi Mai', 'mai.tran@example.com', '0912345678', '1996-06-16', 'Nu'), 
('P0003', 'Le Minh Tuan', 'tuan.le@example.com', '0923456789', '1997-07-17', 'Nam'),
('P0004', 'Pham Hong Son', 'son.pham@example.com', '0934567890', '1998-08-18', 'Nam'),
('P0005', 'Nguyen Thi Lan', 'lan.nguyen@example.com', '0945678901', '1999-09-19', 'Nu'),
('P0006', 'Vu Thi Bao', 'bao.vu@example.com', '0956789012', '2000-10-20', 'Nu'),
('P0007', 'Doan Minh Hoang', 'hoang.doan@example.com', '0967890123', '2001-11-21', 'Nam'),
('P0008', 'Nguyen Thi Thanh', 'thanh.nguyen@example.com', '0978901234', '2002-12-22', 'Nu'),
('P0009', 'Trinh Bao Vy', 'vy.trinh@example.com', '0989012345', '2003-01-23', 'Nu'),
('P0010', 'Bui Hoang Nam', 'nam.bui@example.com', '0990123456', '2004-02-24', 'Nam');

insert into Flight(flight_id, airline_name, departure_airport, arrival_airport, departure_time, arrival_time, ticket_price)
values
('F001', 'VietJet Air', 'Tan Son Nhat', 'Nha Trang', '2025/03/01 08:00:00', '2025/03/01 10:00:00', 150.5),
('F002', 'Vietnam Airlines', 'Noi Bai', 'Hanoi', '2025/03/01 09:00:00', '2025/03/01 11:30:00', 200.0),
('F003', 'Bamboo Airways', 'Da Nang', 'Phu Quoc', '2025/03/01 10:00:00', '2025/03/01 12:00:00', 120.8),
('F004', 'Vietravel Airlines', 'Can Tho', 'Ho Chi Minh', '2025/03/01 11:00:00', '2025/03/01 12:30:00', 180.0);

insert into Booking (passenger_id, flight_id, booking_date, booking_status, ticket_quantity)
values
('P0001', 'F001', '2025-02-20', 'Confirmed', 1),
('P0002', 'F002', '2025-02-21', 'Cancelled', 2),
('P0003', 'F003', '2025-02-22', 'Pending', 1),
('P0004', 'F004', '2025-02-23', 'Confirmed', 3),
('P0005', 'F001', '2025-02-24', 'Pending', 1),
('P0006', 'F002', '2025-02-25', 'Confirmed', 2),
('P0007', 'F003', '2025-02-26', 'Cancelled', 1),
('P0008', 'F004', '2025-02-27', 'Pending', 4),
('P0009', 'F001', '2025-02-28', 'Confirmed', 1),
('P0010', 'F002', '2025-02-28', 'Pending', 1),
('P0001', 'F003', '2025-03-01', 'Confirmed', 3),
('P0002', 'F004', '2025-03-02', 'Cancelled', 1),
('P0003', 'F001', '2025-03-03', 'Pending', 2),
('P0004', 'F002', '2025-03-04', 'Confirmed', 1),
('P0005', 'F003', '2025-03-05', 'Cancelled', 2),
('P0006', 'F004', '2025-03-06', 'Pending', 1),
('P0007', 'F001', '2025-03-07', 'Confirmed', 3),
('P0008', 'F002', '2025-03-08', 'Cancelled', 2),
('P0009', 'F003', '2025-03-09', 'Pending', 1),
('P0010', 'F004', '2025-03-10', 'Confirmed', 1);

insert into Payment(booking_id, payment_method, payment_amount, payment_date, payment_status)
values 
(1, 'Credit Card', 150.5, '2025-02-20', 'Success'),
(2, 'Bank Transfer', 200.0, '2025-02-21', 'Failed'),
(3, 'Cash', 120.8, '2025-02-22', 'Pending'),
(4, 'Credit Card', 180.0, '2025-02-23', 'Success'),
(5, 'Bank Transfer', 150.5, '2025-02-24', 'Pending'),
(6, 'Cash', 200.0, '2025-02-25', 'Success'),
(7, 'Credit Card', 120.8, '2025-02-26', 'Failed'),
(8, 'Bank Transfer', 180.0, '2025-02-27', 'Pending'),
(9, 'Cash', 150.5, '2025-02-28', 'Success'),
(10, 'Credit Card', 200.0, '2025-03-01', 'Pending');

-- 2. Viết câu UPDATE cho phép cập nhật trạng thái thanh toán trong bảng Payment:
-- Cập nhật trạng thái thanh toán thành "Success" nếu số tiền thanh toán (payment_amount) > 0 và phương thức thanh toán là "Credit Card".
-- Cập nhật trạng thái thanh toán thành "Pending" nếu phương thức thanh toán là "Bank Transfer" và số tiền thanh toán nhỏ hơn 100.
-- Chỉ cập nhật trạng thái thanh toán cho những giao dịch có ngày thanh toán (payment_date) là trước ngày hiện tại(CURRENT_DATE)
update Payment
set payment_status = 
    case 
        when payment_amount > 0 and payment_method = 'Credit Card' then 'Success'
        when payment_amount < 100 and payment_method = 'Bank Transfer' then 'Pending'
        else payment_status
    end
where date(payment_date) < current_date();

-- 3. Xóa các bản ghi trong bảng Payment nếu trạng thái thanh toán là "Pending" và phương thức thanh toán là "Cash".
delete from Payment
where payment_status = 'Pending' 
	and payment_method = 'Cash';

-- PHẦN 4: Truy vấn dữ liệu
-- 1. Lấy thông tin 5 hành khách gồm mã, tên, email, ngày sinh, và giới tính, sắp xếp theo tên hành khách tăng dần
select 
	passenger_id, 
    passenger_full_name, 
    passenger_email, 
    passenger_bod, 
    passenger_gender
from Passenger
order by passenger_full_name
limit 5;

-- 2. Lấy thông tin các chuyến bay gồm mã, tên hãng hàng không, sân bay khởi hành và sân bay đến, sắp xếp theo giá vé giảm dần
select 
	flight_id, 
    airline_name, 
    departure_airport, 
    arrival_airport
from Flight
order by ticket_price desc;

-- 3. Lấy thông tin các hành khách gồm mã hành khách, tên hành khách, chuyến bay đã đặt và trạng thái vé là "Cancelled"
select 
    p.passenger_id, 
    p.passenger_full_name, 
    b.flight_id, 
    b.booking_status
from Booking b
join Passenger p on b.passenger_id = p.passenger_id
where b.booking_status = 'Cancelled';


-- 4. Lấy danh sách các chuyến bay gồm mã vé, mã hành khách, chuyến bay đã đặt, 
-- và số lượng vé cho chuyến bay có trạng thái "Confirmed", sắp xếp theo số lượng vé giảm dần
select 
    b.booking_id, 
    b.passenger_id, 
    b.flight_id, 
    b.ticket_quantity
from Booking b
where b.booking_status = 'Confirmed'
order by b.ticket_quantity desc;

-- 5. Lấy danh sách các hành khách gồm mã vé, tên hành khách, chuyến bay đã đặt,
-- và số lượng vé cho các hành khách có số lượng vé đặt trong khoảng từ 2 đến 3, sắp xếp theo tên hành khách
select 
    b.booking_id, 
    p.passenger_full_name, 
    b.flight_id, 
    b.ticket_quantity
from Booking b
join Passenger p on b.passenger_id = p.passenger_id
where b.ticket_quantity between 2 and 3
order by p.passenger_full_name;

-- 6. Lấy danh sách các hành khách đã đặt ít nhất 2 vé và có trạng thái thanh toán là "Pending", 
-- gồm mã hành khách, tên hành khách và số lượng vé đã đặt
select 
    p.passenger_id, 
    p.passenger_full_name, 
    sum(b.ticket_quantity) as total_tickets
from Booking b
join Passenger p on b.passenger_id = p.passenger_id
join Payment pay on b.booking_id = pay.booking_id
where pay.payment_status = 'Pending'
group by p.passenger_id, p.passenger_full_name
having total_tickets >= 2;

-- 7. Lấy danh sách các hành khách gồm mã hành khách, tên hành khách và 
-- số tiền thanh toán cho các giao dịch có trạng thái thanh toán "Success"
select 
    p.passenger_id, 
    p.passenger_full_name, 
    sum(pay.payment_amount) as total_payment
from Payment pay
join Booking b on pay.booking_id = b.booking_id
join Passenger p on b.passenger_id = p.passenger_id
where pay.payment_status = 'Success'
group by p.passenger_id, p.passenger_full_name;
 
-- 8. Lấy danh sách 5 hành khách đầu tiên có số lượng vé đặt (ticket_quantity) lớn hơn 1, 
-- sắp xếp theo số lượng vé giảm dần, gồm mã hành khách, tên hành khách, số lượng vé và trạng thái vé
select 
    p.passenger_id, 
    p.passenger_full_name, 
    sum(b.ticket_quantity) as total_tickets,
    b.booking_status
from Booking b
join Passenger p on b.passenger_id = p.passenger_id
group by p.passenger_id, p.passenger_full_name, b.booking_status
having total_tickets > 1
order by total_tickets desc
limit 5;

-- 9. Lấy danh sách các chuyến bay có số lượng vé đặt nhiều nhất, 
-- gồm mã chuyến bay, tên hãng hàng không, và số lượng vé đặt
select 
    f.flight_id, 
    f.airline_name, 
    sum(b.ticket_quantity) as total_tickets
from Booking b
join Flight f on b.flight_id = f.flight_id
group by f.flight_id, f.airline_name
order by total_tickets desc
limit 1;

-- 10. Lấy danh sách các hành khách gồm tên hành khách, số tiền thanh toán,trạng thái thanh toán 
-- cho những hành khách có ngày sinh trước năm 2000, sắp xếp theo tên hành khách
select 
    p.passenger_full_name, 
    sum(pay.payment_amount) as total_payment, 
    pay.payment_status
from Payment pay
join Booking b on pay.booking_id = b.booking_id
join Passenger p on b.passenger_id = p.passenger_id
where p.passenger_bod < '2000-01-01'
group by p.passenger_full_name, pay.payment_status
order by p.passenger_full_name;

-- PHẦN 5: Tạo View
-- 1. Tạo view view_all_passenger_booking để lấy danh sách tất cả các hành khách và vé họ đã đặt, 
-- gồm mã hành khách, tên hành khách, mã vé, mã chuyến bay và số lượng vé đã đặt
create view view_all_passenger_booking as
select 
	p.passenger_id, 
    p.passenger_full_name, 
    b.booking_id, 
    b.flight_id,
    b.ticket_quantity
from Booking b
join Passenger p on b.passenger_id = p.passenger_id;

select * from view_all_passenger_booking;

-- 2. Tạo view view_successful_payment để lấy danh sách các hành khách đã thanh toán thành công, 
-- gồm mã hành khách, tên hành khách và số tiền thanh toán, chỉ lấy các giao dịch có trạng thái thanh toán "Success"
create view view_successful_payment as 
select 
	p.passenger_id, 
    p.passenger_full_name,
    pay.payment_amount
from Payment pay
join Booking b on pay.booking_id = b.booking_id
join Passenger p on b.passenger_id = p.passenger_id
where pay.payment_status = 'Success';

-- PHẦN 6: Tạo Trigger
-- 1. Tạo một trigger để kiểm tra và đảm bảo rằng số lượng vé (ticket_quantity) trong bảng Booking không bị giảm xuống dưới 1 khi có sự thay đổi. 
-- Nếu số lượng vé nhỏ hơn 1, trigger sẽ thông báo lỗi SIGNAL SQLSTATE và không cho phép cập nhật.

DELIMITER //

drop trigger if exists check_ticket_quantity //
create trigger check_ticket_quantity
before update on Booking
for each row
begin
    if new.ticket_quantity < 1 then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng vé phải lớn hơn hoặc bằng 1';
    end if;
end //

DELIMITER ;

-- 2. Tạo một trigger để khi thực hiện chèn dữ liệu vào bảng Payment, sẽ tự động kiểm tra trạng thái thanh toán,
--  nếu như trạng thái thanh toán là “Success” thì tiến hành cập nhật trạng thái booking_status 
-- của ở bảng Booking tương ứng với hóa đơn đó thành “Confirmed”
DELIMITER //

drop trigger if exists update_booking_status //
create trigger update_booking_status
after insert on Payment
for each row
begin
    if new.payment_status = 'Success' then
        update Booking
			set booking_status = 'Confirmed'
			where booking_id = new.booking_id;
    end if;
end //

DELIMITER ;

-- 1. Tạo một stored procedure có tên GetAllPassengerBookings để lấy thông tin tất cả các hành khách và vé họ đã đặt, 
-- bao gồm mã hành khách, tên hành khách, mã vé, mã chuyến bay và số lượng vé
DELIMITER //

drop procedure if exists GetAllPassengerBookings //
create procedure GetAllPassengerBookings()
begin
    select 
        p.passenger_id,
        p.passenger_full_name,
        b.booking_id,
        b.flight_id,
        b.ticket_quantity
    from Booking b
    join Passenger p on b.passenger_id = p.passenger_id;
end //

DELIMITER ;
call GetAllPassengerBookings();

-- 2. Tạo một stored procedure có tên AddBooking để thực hiện thao tác cập nhật một bản ghi trong vào bảng Booking dựa theo khóa chính.
DELIMITER //

drop procedure if exists AddBooking //
create procedure AddBooking(
	p_booking_id int,
    p_passenger_id varchar(10),
    p_flight_id varchar(10),
    p_ticket_quantity integer
)
begin
    
    update Booking
    set passenger_id = p_passenger_id,
        flight_id = p_flight_id,
        ticket_quantity = p_ticket_quantity
	where booking_id = p_booking_id;
    
end //

DELIMITER ;

call addBooking(1, 'P0004', 'F002', 2);

select * from Booking;