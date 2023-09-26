
-- Users table
 CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `userID` int NOT NULL,
  `userType` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`username`)
);


 CREATE TABLE `doctors` (
  `id` int AUTO_INCREMENT PRIMARY KEY,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `contact_number` varchar(11) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `entry_fee` int DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `doctor_type` varchar(50) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL
);


 CREATE TABLE `patients` (
  `id` int AUTO_INCREMENT PRIMARY KEY,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `gender` varchar(5) DEFAULT NULL,
  `contact_number` varchar(11) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL
);


create table appointments (
	ID int AUTO_INCREMENT primary key,
    problem varchar(50),
	patient_Id int,
    doctor_ID int,
    doctor_fees int,
    payment_status varchar(33),
    appointment_status varchar(30),
    CONSTRAINT FK_p FOREIGN KEY (patient_Id)REFERENCES Patients(id),
    CONSTRAINT FK_docid FOREIGN KEY (doctor_ID) REFERENCES Doctors(id)
);



SELECT a.id, a.problem, a.patient_id, a.doctor_id, a.doctor_fees, a.payment_status, a.appointment_status, d.doctor_type, d.qualification 
FROM appointments a 
JOIN doctors d ON a.doctor_id = d.id 
where a.patient_id = 2;

create table Reports
(
	ReportID int AUTO_INCREMENT,
    appointmentID int,
    MedicinePrescribed varchar(200),
    DoctorComment varchar(200),
    primary key (ReportID),
    CONSTRAINT FK_apid FOREIGN KEY (appointmentID) REFERENCES appointments(id)
);


CREATE TABLE feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_ID INT,
    rating INT,
    address TEXT,
    comment TEXT,
    FOREIGN KEY (patient_ID) REFERENCES Patients(id)
);

select r.reportid, r.MedicinePrescribed, r.doctorcomment, a.doctor_id, d.first_name, a.patient_id, p.first_name 
from reports as r 
join appointments as a on r.appointmentid = a.id 
join doctors as d on a.doctor_id = d.id 
join patients as p on a.patient_Id = p.id;


select u.userID, u.userType from users as u where 
u.userId in (select d.id
    FROM doctors as d
    WHERE d.first_name = ? AND d.last_name = ? AND d.contact_number = ? AND d.email = ?
) or u.userid in (SELECT p.id
    FROM patients as p
    WHERE p.first_name = ? AND p.last_name = ? AND p.contact_number = ? AND p.email = ?);

