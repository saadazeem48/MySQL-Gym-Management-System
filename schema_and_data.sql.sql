-- SCHEMA 

CREATE DATABASE GymManagementSystem;
USE GymManagementSystem;


-- TABLES

CREATE TABLE Member (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    join_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Gym (
    gym_id INT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(200) NOT NULL,
    contact_no VARCHAR(20),
    opening_hours VARCHAR(100)
);

CREATE TABLE Certificate (
    certificate_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    assing_date DATE,
    issuing_organization VARCHAR(100)
);

CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200)
);

CREATE TABLE Specialization (
    specialization_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Membership_Plan (
    membership_plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    duration_days INT
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    gym_id INT,
    supervisor_id INT,
    role VARCHAR(100),
    hire_date DATE,
    FOREIGN KEY (gym_id) REFERENCES Gym(gym_id),
    FOREIGN KEY (supervisor_id) REFERENCES Staff(staff_id)
);

CREATE TABLE Trainer (
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization_id INT,
    hire_date DATE,
    FOREIGN KEY (specialization_id) REFERENCES Specialization(specialization_id)
);

CREATE TABLE Trainer_Specialization (
    trainer_id INT,
    specialization_id INT,
    PRIMARY KEY (trainer_id, specialization_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id),
    FOREIGN KEY (specialization_id) REFERENCES Specialization(specialization_id)
);

CREATE TABLE Staff_Certificate (
    staff_id INT,
    certificate_id INT,
    date_achieved DATE NOT NULL,
    PRIMARY KEY (staff_id, certificate_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (certificate_id) REFERENCES Certificate(certificate_id)
);

CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY AUTO_INCREMENT,
    equip_name VARCHAR(100) NOT NULL,
    equip_type VARCHAR(100),
    gym_id INT,
    maintenance_date DATE,
    FOREIGN KEY (gym_id) REFERENCES Gym(gym_id)
);

CREATE TABLE Shipment (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT,
    equipment_id INT,
    shipment_date DATE,
    quantity INT,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Workout_Plan (
    workout_plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(100) NOT NULL,
    difficulty VARCHAR(50),
    duration_weeks INT
);

CREATE TABLE Class (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(100) NOT NULL,
    max_capacity INT,
    gym_id INT,
    FOREIGN KEY (gym_id) REFERENCES Gym(gym_id)
);

CREATE TABLE Member_Plan (
    member_id INT,
    workout_plan_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (member_id, workout_plan_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (workout_plan_id) REFERENCES Workout_Plan(workout_plan_id)
);

CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    class_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(50) DEFAULT 'Registered',
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
);

CREATE TABLE Workout_Session (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    workout_plan_id INT,
    trainer_id INT,
    session_date DATETIME NOT NULL,
    duration_minutes INT,
    FOREIGN KEY (workout_plan_id) REFERENCES Workout_Plan(workout_plan_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id)
);

CREATE TABLE Session_Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT,
    member_id INT,
    status VARCHAR(50) DEFAULT 'Present',
    FOREIGN KEY (session_id) REFERENCES Workout_Session(session_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

CREATE TABLE Equipment_Usage (
    usage_id INT PRIMARY KEY AUTO_INCREMENT,
    equipment_id INT,
    session_id INT,
    usage_duration INT,
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id),
    FOREIGN KEY (session_id) REFERENCES Workout_Session(session_id)
);


CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    membership_plan_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (membership_plan_id) REFERENCES Membership_Plan(membership_plan_id)
);

-- DATA INSERTION

INSERT INTO Member (name, email, phone, join_date) VALUES
('Ahmed Khan', 'ahmed.khan@example.com', '03001234567', '2022-01-15'),
('Fatima Ali', 'fatima.ali@example.com', '03111234567', '2022-02-20'),
('Muhammad Hassan', 'm.hassan@example.com', '03211234567', '2022-03-10'),
('Ayesha Riaz', 'ayesha.riaz@example.com', '03331234567', '2022-04-05'),
('Bilal Ahmed', 'bilal.ahmed@example.com', '03451234567', '2022-05-12'),
('Sana Malik', 'sana.malik@example.com', '03021234567', '2022-06-18'),
('Usman Sheikh', 'usman.s@example.com', '03121234567', '2022-07-22'),
('Hina Shah', 'hina.shah@example.com', '03221234567', '2022-08-30'),
('Kamran Aslam', 'kamran.a@example.com', '03341234567', '2022-09-14'),
('Sadia Iqbal', 'sadia.iqbal@example.com', '03461234567', '2022-10-25'),
('Tariq Mahmood', 'tariq.m@example.com', '03031234567', '2022-11-08'),
('Zainab Akhtar', 'zainab.a@example.com', '03131234567', '2022-12-03'),
('Imran Baig', 'imran.baig@example.com', '03231234567', '2023-01-17'),
('Nadia Chaudhry', 'nadia.c@example.com', '03351234567', '2023-02-28'),
('Ali Raza', 'ali.raza@example.com', '03361234567', '2023-03-15'),
('Saima Farooq', 'saima.f@example.com', '03041234567', '2023-04-20'),
('Haroon Siddiqui', 'haroon.s@example.com', '03151234567', '2023-05-25'),
('Mehak Khan', 'mehak.k@example.com', '03261234567', '2023-06-30'),
('Asim Malik', 'asim.m@example.com', '03371234567', '2023-07-05'),
('Fariha Ahmed', 'fariha.a@example.com', '03051234567', '2023-08-10');

INSERT INTO Gym (location, contact_no, opening_hours) VALUES
('Gulshan Iqbal, Karachi', '02134567890', '6:00 AM - 11:00 PM'),
('DHA Phase 5, Lahore', '04234567890', '5:30 AM - 10:30 PM'),
('Saddar, Rawalpindi', '05134567890', '6:30 AM - 10:00 PM'),
('University Road, Peshawar', '09134567890', '7:00 AM - 9:30 PM'),
('Cantt, Islamabad', '05134567891', '6:00 AM - 10:00 PM'),
('Bahadurabad, Karachi', '02134567891', '5:00 AM - 11:30 PM'),
('Model Town, Lahore', '04234567891', '5:00 AM - 11:00 PM'),
('F-8, Islamabad', '05134567892', '6:00 AM - 10:30 PM'),
('Hayatabad, Peshawar', '09134567892', '7:00 AM - 9:00 PM'),
('Clifton, Karachi', '02134567892', '5:30 AM - 11:00 PM'),
('Garden Town, Lahore', '04234567892', '6:00 AM - 10:00 PM'),
('Blue Area, Islamabad', '05134567893', '7:00 AM - 9:00 PM'),
('Warsak Road, Peshawar', '09134567893', '6:30 AM - 8:30 PM'),
('North Nazimabad, Karachi', '02134567893', '5:00 AM - 10:30 PM'),
('Gulistan-e-Jauhar, Karachi', '02134567894', '6:00 AM - 10:00 PM'),
('Johar Town, Lahore', '04234567894', '5:00 AM - 11:00 PM'),
('Satellite Town, Rawalpindi', '05134567894', '6:00 AM - 10:00 PM'),
('University Town, Peshawar', '09134567894', '7:00 AM - 9:00 PM'),
('G-9, Islamabad', '05134567895', '6:00 AM - 10:00 PM'),
('Defence, Karachi', '02134567895', '5:00 AM - 11:00 PM');

INSERT INTO Certificate (name, assing_date, issuing_organization) VALUES
('CPR Certification', '2021-01-10', 'Red Cross Pakistan'),
('Personal Trainer', '2021-02-15', 'Pakistan Fitness Council'),
('Yoga Instructor', '2021-03-20', 'Yoga Alliance Pakistan'),
('Nutrition Specialist', '2021-04-25', 'Pakistan Nutrition Association'),
('CrossFit Trainer', '2021-05-30', 'CrossFit Pakistan'),
('Zumba Instructor', '2021-06-05', 'Zumba Pakistan'),
('Weightlifting Coach', '2021-07-12', 'Pakistan Weightlifting Federation'),
('First Aid Certified', '2021-08-18', 'St. John Ambulance'),
('Pilates Instructor', '2021-09-22', 'Pilates Association Pakistan'),
('Kickboxing Trainer', '2021-10-28', 'Pakistan Martial Arts Association'),
('Aqua Fitness', '2021-11-15', 'Pakistan Swimming Federation'),
('Senior Fitness', '2021-12-20', 'Pakistan Geriatric Society'),
('Sports Nutrition', '2022-01-05', 'Pakistan Dietetic Association'),
('Functional Training', '2022-02-10', 'Pakistan Fitness Council'),
('Advanced Yoga', '2022-03-15', 'Yoga Alliance Pakistan'),
('Sports Medicine', '2022-04-20', 'Pakistan Medical Association'),
('Functional Nutrition', '2022-05-25', 'Pakistan Nutrition Association'),
('Senior Yoga', '2022-06-30', 'Yoga Alliance Pakistan'),
('Rehabilitation Specialist', '2022-07-05', 'Pakistan Physiotherapy Association'),
('Pre/Post Natal Fitness', '2022-08-10', 'Pakistan Fitness Council');

INSERT INTO Supplier (supplier_name, phone, address) VALUES
('Fitness Pro Pakistan', '03001112222', '23 Main Boulevard, Lahore'),
('Gym Equip PK', '03111112222', '45 Commercial Area, Karachi'),
('Strong Body Traders', '03211112222', '12 Mall Road, Rawalpindi'),
('Iron World Suppliers', '03331112222', '78 Saddar Road, Peshawar'),
('Health Plus Equipment', '03451112222', '34 Jinnah Avenue, Islamabad'),
('Power Fitness Imports', '03001113333', '56 Shahrah-e-Faisal, Karachi'),
('Muscle Builders Ltd', '03111113333', '89 The Mall, Lahore'),
('Fit Nation Traders', '03211113333', '67 Murree Road, Rawalpindi'),
('Elite Gym Solutions', '03331113333', '23 University Road, Peshawar'),
('Titan Fitness', '03451113333', '12 Blue Area, Islamabad'),
('Pro Fitness Pakistan', '03001114444', '34 Tariq Road, Karachi'),
('Iron Master Suppliers', '03111114444', '78 Gulberg, Lahore'),
('Body Sculpt Traders', '03211114444', '45 IJP Road, Rawalpindi'),
('Health Fitness Impex', '03331114444', '56 Ring Road, Peshawar'),
('Fitness World Pakistan', '03001115555', '12 MM Alam Road, Lahore'),
('Gym Nation Suppliers', '03111115555', '34 Zamzama, Karachi'),
('Powerhouse Equipment', '03211115555', '78 Sixth Road, Rawalpindi'),
('Iron Paradise', '03331115555', '23 Arbab Road, Peshawar'),
('Body Tech Pakistan', '03451115555', '56 F-7, Islamabad'),
('Fitness Gear PK', '03001116666', '12 Clifton, Karachi');

INSERT INTO Specialization (name) VALUES
('Weight Loss Training'),
('Muscle Building'),
('Yoga Instruction'),
('Nutrition Counseling'),
('CrossFit Coaching'),
('Zumba Instruction'),
('Powerlifting'),
('Senior Fitness'),
('Sports Rehabilitation'),
('Kickboxing'),
('Aqua Aerobics'),
('Postnatal Fitness'),
('Athletic Training'),
('Functional Movement'),
('Pre/Post Natal Yoga'),
('Sports Psychology'),
('Functional Strength'),
('Mobility Training'),
('Corrective Exercise'),
('Mind-Body Fitness');

INSERT INTO Membership_Plan (plan_name, price, duration_days) VALUES
('Basic Monthly', 3000, 30),
('Premium Monthly', 5000, 30),
('Gold Monthly', 7000, 30),
('Basic Quarterly', 8000, 90),
('Premium Quarterly', 12000, 90),
('Gold Quarterly', 15000, 90),
('Basic Annual', 25000, 365),
('Premium Annual', 40000, 365),
('Gold Annual', 55000, 365),
('Student Monthly', 2000, 30),
('Senior Citizen Monthly', 2500, 30),
('Couple Monthly', 8000, 30),
('Family Monthly', 12000, 30),
('Corporate Monthly', 10000, 30),
('Platinum Monthly', 10000, 30),
('Student Quarterly', 5000, 90),
('Senior Citizen Quarterly', 6000, 90),
('Couple Quarterly', 20000, 90),
('Family Quarterly', 30000, 90),
('Corporate Quarterly', 25000, 90);

INSERT INTO Staff (name, gym_id, supervisor_id, role, hire_date) VALUES
('Ali Raza', 1, NULL, 'Manager', '2020-01-15'),
('Saima Khan', 2, 1, 'Assistant Manager', '2020-02-20'),
('Farhan Ahmed', 3, 1, 'Receptionist', '2020-03-10'),
('Nabeela Hussain', 4, 2, 'Cleaner', '2020-04-05'),
('Omar Farooq', 5, 2, 'Security', '2020-05-12'),
('Sara Jamal', 6, 1, 'Accountant', '2020-06-18'),
('Kashif Malik', 7, 3, 'Maintenance', '2020-07-22'),
('Rabia Aslam', 8, 3, 'Receptionist', '2020-08-30'),
('Asad Iqbal', 9, 4, 'Security', '2020-09-14'),
('Fariha Khan', 10, 4, 'Cleaner', '2020-10-25'),
('Waqar Ahmed', 11, 5, 'Maintenance', '2020-11-08'),
('Sobia Riaz', 12, 5, 'Receptionist', '2020-12-03'),
('Tahir Mahmood', 13, 6, 'Security', '2021-01-17'),
('Amina Sheikh', 14, 6, 'Cleaner', '2021-02-28'),
('Bilal Raza', 15, 1, 'Trainer', '2021-03-15'),
('Sana Farooq', 16, 2, 'Trainer', '2021-04-20'),
('Haroon Malik', 17, 3, 'Maintenance', '2021-05-25'),
('Mehak Siddiqui', 18, 4, 'Receptionist', '2021-06-30'),
('Asim Khan', 19, 5, 'Security', '2021-07-05'),
('Fariha Ahmed', 20, 6, 'Cleaner', '2021-08-10');

INSERT INTO Trainer (name, specialization_id, hire_date) VALUES
('Shahid Afridi', 1, '2021-01-10'),
('Sanam Jung', 2, '2021-02-15'),
('Fawad Khan', 3, '2021-03-20'),
('Mahira Khan', 4, '2021-04-25'),
('Wasim Akram', 5, '2021-05-30'),
('Mehwish Hayat', 6, '2021-06-05'),
('Imran Khan', 7, '2021-07-12'),
('Hania Amir', 8, '2021-08-18'),
('Babar Azam', 9, '2021-09-22'),
('Ayeza Khan', 10, '2021-10-28'),
('Fahad Mustafa', 11, '2021-11-15'),
('Sajal Aly', 12, '2021-12-20'),
('Ahsan Khan', 13, '2022-01-05'),
('Yumna Zaidi', 14, '2022-02-10'),
('Ali Zafar', 15, '2022-03-15'),
('Maya Ali', 16, '2022-04-20'),
('Humayun Saeed', 17, '2022-05-25'),
('Aiman Khan', 18, '2022-06-30'),
('Feroze Khan', 19, '2022-07-05'),
('Sarah Khan', 20, '2022-08-10');

INSERT INTO Trainer_Specialization (trainer_id, specialization_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 14),
(15, 15), (16, 16), (17, 17), (18, 18),
(19, 19), (20, 20);

INSERT INTO Staff_Certificate (staff_id, certificate_id, date_achieved) VALUES
(1, 1, '2020-01-10'), (2, 2, '2020-02-15'), (3, 3, '2020-03-20'),
(4, 4, '2020-04-25'), (5, 5, '2020-05-30'), (6, 6, '2020-06-05'),
(7, 7, '2020-07-12'), (8, 8, '2020-08-18'), (9, 9, '2020-09-22'),
(10, 10, '2020-10-28'), (11, 11, '2020-11-15'), (12, 12, '2020-12-20'),
(13, 13, '2021-01-05'), (14, 14, '2021-02-10'),
(15, 15, '2021-03-15'), (16, 16, '2021-04-20'),
(17, 17, '2021-05-25'), (18, 18, '2021-06-30'),
(19, 19, '2021-07-05'), (20, 20, '2021-08-10');

INSERT INTO Equipment (equip_name, equip_type, gym_id, maintenance_date) VALUES
('Treadmill', 'Cardio', 1, '2023-01-15'),
('Elliptical', 'Cardio', 2, '2023-02-20'),
('Stationary Bike', 'Cardio', 3, '2023-03-10'),
('Dumbbell Set', 'Strength', 4, '2023-04-05'),
('Barbell', 'Strength', 5, '2023-05-12'),
('Bench Press', 'Strength', 6, '2023-06-18'),
('Leg Press', 'Strength', 7, '2023-07-22'),
('Cable Machine', 'Strength', 8, '2023-08-30'),
('Rowing Machine', 'Cardio', 9, '2023-09-14'),
('Smith Machine', 'Strength', 10, '2023-10-25'),
('Kettlebell Set', 'Strength', 11, '2023-11-08'),
('Yoga Mats', 'Accessories', 12, '2023-12-03'),
('Resistance Bands', 'Accessories', 13, '2024-01-17'),
('Punching Bag', 'Combat', 14, '2024-02-28'),
('Stair Climber', 'Cardio', 15, '2024-03-15'),
('TRX System', 'Strength', 16, '2024-04-20'),
('Battle Ropes', 'Cardio', 17, '2024-05-25'),
('Medicine Balls', 'Strength', 18, '2024-06-30'),
('Plyo Boxes', 'Plyometrics', 19, '2024-07-05'),
('Foam Rollers', 'Recovery', 20, '2024-08-10');

INSERT INTO Shipment (supplier_id, equipment_id, shipment_date, quantity) VALUES
(1, 1, '2023-01-05', 5), (2, 2, '2023-02-10', 3),
(3, 3, '2023-03-15', 4), (4, 4, '2023-04-20', 10),
(5, 5, '2023-05-25', 8), (6, 6, '2023-06-30', 2),
(7, 7, '2023-07-05', 1), (8, 8, '2023-08-10', 3),
(9, 9, '2023-09-15', 2), (10, 10, '2023-10-20', 1),
(11, 11, '2023-11-25', 6), (12, 12, '2023-12-30', 20),
(13, 13, '2024-01-05', 15), (14, 14, '2024-02-10', 2),
(15, 15, '2024-03-15', 3), (16, 16, '2024-04-20', 5),
(17, 17, '2024-05-25', 4), (18, 18, '2024-06-30', 8),
(19, 19, '2024-07-05', 6), (20, 20, '2024-08-10', 10);

INSERT INTO Workout_Plan (plan_name, difficulty, duration_weeks) VALUES
('Beginner Weight Loss', 'Beginner', 12),
('Intermediate Muscle Gain', 'Intermediate', 8),
('Advanced Strength', 'Advanced', 6),
('Yoga for Beginners', 'Beginner', 4),
('HIIT Challenge', 'Intermediate', 8),
('Senior Fitness', 'Beginner', 12),
('Postnatal Recovery', 'Beginner', 6),
('Athletic Performance', 'Advanced', 8),
('Functional Movement', 'Intermediate', 6),
('Bodyweight Mastery', 'Intermediate', 8),
('Powerlifting Prep', 'Advanced', 12),
('Marathon Training', 'Intermediate', 16),
('Swimmers Program', 'Advanced', 8),
('Rehabilitation Plan', 'Beginner', 6),
('Advanced Yoga', 'Advanced', 8),
('Sports Performance', 'Advanced', 10),
('Functional Strength', 'Intermediate', 6),
('Mobility & Flexibility', 'Beginner', 4),
('Corrective Exercise', 'Intermediate', 6),
('Mind-Body Connection', 'Beginner', 8);

INSERT INTO Class (class_name, max_capacity, gym_id) VALUES
('Morning Yoga', 20, 1), ('Zumba Fitness', 25, 2),
('Spin Class', 15, 3), ('Bootcamp', 30, 4),
('Pilates', 15, 5), ('Kickboxing', 20, 6),
('Senior Stretch', 15, 7), ('Kids Fitness', 20, 8),
('Aqua Aerobics', 15, 9), ('Power Yoga', 20, 10),
('CrossFit', 15, 11), ('Dance Fitness', 25, 12),
('Boxing', 20, 13), ('Meditation', 30, 14),
('Advanced Pilates', 15, 15), ('TRX Training', 20, 16),
('Functional Training', 20, 17), ('Barre', 15, 18),
('Tai Chi', 25, 19), ('Core Conditioning', 20, 20);

INSERT INTO Member_Plan (member_id, workout_plan_id, start_date, end_date) VALUES
(1, 1, '2023-01-01', '2023-03-26'),
(2, 2, '2023-01-15', '2023-03-12'),
(3, 3, '2023-02-01', '2023-03-15'),
(4, 4, '2023-02-15', '2023-03-15'),
(5, 5, '2023-03-01', '2023-04-26'),
(6, 6, '2023-03-15', '2023-06-07'),
(7, 7, '2023-04-01', '2023-05-13'),
(8, 8, '2023-04-15', '2023-06-10'),
(9, 9, '2023-05-01', '2023-06-12'),
(10, 10, '2023-05-15', '2023-07-10'),
(11, 11, '2023-06-01', '2023-08-24'),
(12, 12, '2023-06-15', '2023-10-06'),
(13, 13, '2023-07-01', '2023-08-26'),
(14, 14, '2023-07-15', '2023-08-26'),
(15, 15, '2023-08-01', '2023-09-26'),
(16, 16, '2023-08-15', '2023-11-12'),
(17, 17, '2023-09-01', '2023-10-15'),
(18, 18, '2023-09-15', '2023-10-15'),
(19, 19, '2023-10-01', '2023-11-12'),
(20, 20, '2023-10-15', '2023-12-10');

INSERT INTO Enrollment (member_id, class_id, enrollment_date, status) VALUES
(1, 1, '2023-01-05', 'Active'), (2, 2, '2023-01-10', 'Active'),
(3, 3, '2023-01-15', 'Active'), (4, 4, '2023-01-20', 'Active'),
(5, 5, '2023-01-25', 'Active'), (6, 6, '2023-02-01', 'Active'),
(7, 7, '2023-02-05', 'Active'), (8, 8, '2023-02-10', 'Active'),
(9, 9, '2023-02-15', 'Active'), (10, 10, '2023-02-20', 'Active'),
(11, 11, '2023-02-25', 'Active'), (12, 12, '2023-03-01', 'Active'),
(13, 13, '2023-03-05', 'Active'), (14, 14, '2023-03-10', 'Active'),
(15, 15, '2023-03-15', 'Active'), (16, 16, '2023-03-20', 'Active'),
(17, 17, '2023-03-25', 'Active'), (18, 18, '2023-04-01', 'Active'),
(19, 19, '2023-04-05', 'Active'), (20, 20, '2023-04-10', 'Active');

INSERT INTO Workout_Session (workout_plan_id, trainer_id, session_date, duration_minutes) VALUES
(1, 1, '2023-01-10 08:00:00', 60),
(2, 2, '2023-01-11 09:00:00', 45),
(3, 3, '2023-01-12 10:00:00', 90),
(4, 4, '2023-01-13 07:00:00', 60),
(5, 5, '2023-01-14 17:00:00', 45),
(6, 6, '2023-01-15 11:00:00', 60),
(7, 7, '2023-01-16 16:00:00', 45),
(8, 8, '2023-01-17 18:00:00', 90),
(9, 9, '2023-01-18 08:30:00', 60),
(10, 10, '2023-01-19 19:00:00', 45),
(11, 11, '2023-01-20 07:30:00', 90),
(12, 12, '2023-01-21 10:30:00', 60),
(13, 13, '2023-01-22 15:00:00', 45),
(14, 14, '2023-01-23 17:30:00', 60),
(15, 15, '2023-01-24 08:00:00', 60),
(16, 16, '2023-01-25 09:00:00', 45),
(17, 17, '2023-01-26 10:00:00', 90),
(18, 18, '2023-01-27 07:00:00', 60),
(19, 19, '2023-01-28 17:00:00', 45),
(20, 20, '2023-01-29 11:00:00', 60);

INSERT INTO Session_Attendance (session_id, member_id, status) VALUES
(1, 1, 'Present'), (2, 2, 'Present'),
(3, 3, 'Present'), (4, 4, 'Present'),
(5, 5, 'Present'), (6, 6, 'Present'),
(7, 7, 'Present'), (8, 8, 'Present'),
(9, 9, 'Present'), (10, 10, 'Present'),
(11, 11, 'Present'), (12, 12, 'Present'),
(13, 13, 'Present'), (14, 14, 'Present'),
(15, 15, 'Present'), (16, 16, 'Present'),
(17, 17, 'Present'), (18, 18, 'Present'),
(19, 19, 'Present'), (20, 20, 'Present');

INSERT INTO Equipment_Usage (equipment_id, session_id, usage_duration) VALUES
(1, 1, 30), (2, 2, 20), (3, 3, 45),
(4, 4, 30), (5, 5, 25), (6, 6, 30),
(7, 7, 20), (8, 8, 45), (9, 9, 30),
(10, 10, 25), (11, 11, 45), (12, 12, 30),
(13, 13, 20), (14, 14, 30),
(15, 15, 30), (16, 16, 20),
(17, 17, 45), (18, 18, 30),
(19, 19, 25), (20, 20, 30);

INSERT INTO Payment (member_id, membership_plan_id, amount, payment_date) VALUES
(1, 1, 3000, '2023-01-01'), (2, 2, 5000, '2023-01-05'),
(3, 3, 7000, '2023-01-10'), (4, 4, 8000, '2023-01-15'),
(5, 5, 12000, '2023-01-20'), (6, 6, 15000, '2023-01-25'),
(7, 7, 25000, '2023-02-01'), (8, 8, 40000, '2023-02-05'),
(9, 9, 55000, '2023-02-10'), (10, 10, 2000, '2023-02-15'),
(11, 11, 2500, '2023-02-20'), (12, 12, 8000, '2023-02-25'),
(13, 13, 12000, '2023-03-01'), (14, 14, 10000, '2023-03-05'),
(15, 15, 10000, '2023-03-10'), (16, 16, 5000, '2023-03-15'),
(17, 17, 6000, '2023-03-20'), (18, 18, 20000, '2023-03-25'),
(19, 19, 30000, '2023-04-01'), (20, 20, 25000, '2023-04-05');

-- Sample QUERIES 			

SELECT * FROM Member;

SELECT * FROM Certificate WHERE issuing_organization = 'Pakistan Fitness Council';

SELECT * FROM Member WHERE join_date > '2023-01-01';

SELECT * FROM Certificate WHERE assing_date BETWEEN '2022-01-01' AND '2022-12-31';

SELECT * FROM Supplier WHERE address LIKE '%Lahore%';

SELECT * FROM Gym;

SELECT plan_name, duration_days, price FROM Membership_Plan;

SELECT name, role FROM Staff;

SELECT class_name, gym_id FROM Class;

SELECT T.name AS Trainer, S.name AS Specialization
FROM Trainer T
JOIN Specialization S ON T.specialization_id = S.specialization_id;

SELECT S.name AS Staff, G.location AS Gym, SS.name AS Supervisor
FROM Staff S
JOIN Gym G ON S.gym_id = G.gym_id
LEFT JOIN Staff SS ON S.supervisor_id = SS.staff_id;

SELECT E.equip_name, EU.usage_duration
FROM Equipment_Usage EU
JOIN Equipment E ON EU.equipment_id = E.equipment_id;

SELECT WP.plan_name AS Workout_Plan, WP.duration_weeks AS Duration
FROM Workout_Plan WP;

SELECT M.name AS Member, C.class_name AS Class
FROM Enrollment E
JOIN Member M ON E.member_id = M.member_id
JOIN Class C ON E.class_id = C.class_id
WHERE C.class_id = 1;  -- Change the class_id for different data of classes required

