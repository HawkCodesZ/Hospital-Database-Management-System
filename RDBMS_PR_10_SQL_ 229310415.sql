--create database and use it
Create database hospital;
--use hospital;

-- Create Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT,
    Gender VARCHAR(10),
    ContactInfo VARCHAR(255),
    Address VARCHAR(255)
);
-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);
-- Create Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(255),
    Specialization VARCHAR(255),
    ContactInfo VARCHAR(255),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Nurses Table
CREATE TABLE Nurses (
    NurseID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create AdministrativeStaff Table
CREATE TABLE AdministrativeStaff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(255),
    Role VARCHAR(255),
    ContactInfo VARCHAR(255)
);

-- Create GeneralStaff Table
CREATE TABLE GeneralStaff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(255),
    Role VARCHAR(255),
    ContactInfo VARCHAR(255),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);



-- Create MedicalRecords Table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Diagnosis VARCHAR(255),
    Treatment VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Medications Table
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    MedicationName VARCHAR(255),
    Dosage VARCHAR(255),
    Frequency VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create TestsProcedures Table
CREATE TABLE TestsProcedures (
    TestProcedureID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Type VARCHAR(255),
    Date DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Rooms Table
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    RoomNumber INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create InventoryItems Table
CREATE TABLE InventoryItems (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(255),
    Quantity INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Surgeries Table
CREATE TABLE Surgeries (
    SurgeryID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create FollowUps Table
CREATE TABLE FollowUps (
    FollowUpID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create EmergencyCases Table
CREATE TABLE EmergencyCases (
    EmergencyID INT PRIMARY KEY,
    PatientID INT,
    Date DATE,
    Time TIME,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Create MedicoLegalCases Table
CREATE TABLE MedicoLegalCases (
    MedicoLegalCaseID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Description TEXT,
    LegalStatus VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create a view to get names and ages of patients
CREATE VIEW PatientNamesAges AS
    SELECT Name, Age FROM Patients;

-- Create a view to get names and specializations of doctors
CREATE VIEW DoctorNamesSpecializations AS
    SELECT Name, Specialization FROM Doctors;

-- Create a view to get names and departments of nurses
CREATE VIEW NurseNamesDepartments AS
    SELECT Nurses.Name, Departments.DepartmentName 
    FROM Nurses 
    INNER JOIN Departments ON Nurses.DepartmentID = Departments.DepartmentID;

-- Create a view to get names and roles of administrative staff
CREATE VIEW AdminStaffNamesRoles AS
    SELECT AdministrativeStaff.Name, AdministrativeStaff.Role FROM AdministrativeStaff;

-- Create a view to get names and departments of general staff
CREATE VIEW GeneralStaffNamesDepartments AS
    SELECT GeneralStaff.Name, Departments.DepartmentName 
    FROM GeneralStaff 
    INNER JOIN Departments ON GeneralStaff.DepartmentID = Departments.DepartmentID;

-- Create a view to get names and types of tests and procedures
CREATE VIEW TestProcedureNamesTypes AS
    SELECT TestsProcedures.PatientID, TestsProcedures.DoctorID, TestProcedureTypes.Type
    FROM TestsProcedures
    INNER JOIN TestProcedureTypes ON TestsProcedures.TypeID = TestProcedureTypes.TypeID;

-- Insert Data into Patients
INSERT INTO Patients (PatientID, Name, Age, Gender, ContactInfo, Address)
VALUES 
    (1, 'John Doe', 30, 'Male', '555-555-5555', '123 Main Street'),
    (2, 'Jane Doe', 25, 'Female', '555-555-5556', '456 Oak Avenue'),
    (3, 'Bob Smith', 35, 'Male', '555-555-5557', '789 Pine Road'),
    (4, 'Samantha Johnson', 28, 'Female', '555-555-5558', '101 Maple Drive'),
    (5, 'Michael Brown', 40, 'Male', '555-555-5559', '202 Cedar Lane');

-- Insert Data into Doctors
INSERT INTO Doctors (DoctorID, Name, Specialization, ContactInfo, DepartmentID)
VALUES 
    (101, 'Dr. Smith', 'Cardiology', '555-555-5558', 1),
    (102, 'Dr. Johnson', 'Pediatrics', '555-555-5559', 2),
    (103, 'Dr. Williams', 'Orthopedics', '555-555-5560', 3),
    (104, 'Dr. Davis', 'Neurology', '555-555-5561', 4),
    (105, 'Dr. Jones', 'Gynecology', '555-555-5562', 5);

-- Insert Data into Nurses
INSERT INTO Nurses (NurseID, Name, ContactInfo, DepartmentID)
VALUES 
    (201, 'Nurse Adams', '555-555-5555', 1),
    (202, 'Nurse Clark', '555-555-5556', 2),
    (203, 'Nurse Baker', '555-555-5557', 3),
    (204, 'Nurse Davis', '555-555-5558', 4),
    (205, 'Nurse Evans', '555-555-5559', 5);

-- Insert Data into AdministrativeStaff
INSERT INTO AdministrativeStaff (StaffID, Name, Role, ContactInfo)
VALUES 
    (301, 'Admin Smith', 'Receptionist', '555-555-5555'),
    (302, 'Admin Johnson', 'Inventory Manager', '555-555-5556'),
    (303, 'Admin Williams', 'Appointment Scheduler', '555-555-5557'),
    (304, 'Admin Davis', 'Billing Coordinator', '555-555-5558'),
    (305, 'Admin Jones', 'IT Support', '555-555-5559');

-- Insert Data into GeneralStaff
INSERT INTO GeneralStaff (StaffID, Name, Role, ContactInfo, DepartmentID)
VALUES 
    (401, 'Staff Brown', 'Support Staff', '555-555-5560', 1),
    (402, 'Staff Clark', 'Support Staff', '555-555-5561', 2),
    (403, 'Staff Evans', 'Support Staff', '555-555-5562', 3),
    (404, 'Staff Green', 'Support Staff', '555-555-5563', 4),
    (405, 'Staff Davis', 'Support Staff', '555-555-5564', 5);

-- Insert Data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
    (1, 'Cardiology'),
    (2, 'Pediatrics'),
    (3, 'Orthopedics'),
    (4, 'Neurology'),
    (5, 'Gynecology');

-- Insert Data into MedicalRecords
INSERT INTO MedicalRecords (RecordID, PatientID, DoctorID, Date, Diagnosis, Treatment)
VALUES 
    (501, 1, 101, '2023-10-29', 'Hypertension', 'Prescribed medication and advised lifestyle changes'),
    (502, 2, 102, '2023-10-28', 'Common Cold', 'Rest and plenty of fluids'),
    (503, 3, 103, '2023-10-27', 'Fractured Arm', 'Performed a cast and prescribed pain relief'),
    (504, 4, 104, '2023-10-26', 'Migraine', 'Prescribed medication for pain relief'),
    (505, 5, 105, '2023-10-25', 'Prenatal Checkup', 'Monitored fetal development and provided guidance');

-- Select all patients
SELECT * FROM Patients;

-- Select patients with age greater than 30
SELECT * FROM Patients WHERE Age > 30;

-- Select doctors in the Pediatrics department
SELECT * FROM Doctors WHERE DepartmentID = 2;

-- Select nurses in the Orthopedics department
SELECT * FROM Nurses WHERE DepartmentID = 3;

-- Select medical records for patient with ID 1
SELECT * FROM MedicalRecords WHERE PatientID = 1;
-- Update age of Patient with ID 2
UPDATE Patients SET Age = 26 WHERE PatientID = 2;

-- Change specialization of Doctor with ID 102
UPDATE Doctors SET Specialization = 'Pediatric Cardiology' WHERE DoctorID = 102;

-- Change role of Administrative Staff with ID 302
UPDATE AdministrativeStaff SET Role = 'Inventory Supervisor' WHERE StaffID = 302;

-- Delete Patient with ID 3
DELETE FROM Patients WHERE PatientID = 3;

-- Delete Doctor with ID 104
DELETE FROM Doctors WHERE DoctorID = 104;

-- Delete Nurse with ID 204
DELETE FROM Nurses WHERE NurseID = 204;

-- Delete Administrative Staff with ID 303
DELETE FROM AdministrativeStaff WHERE StaffID = 303;

-- DROP TABLES (if needed)
-- DROP TABLE Patients;
-- DROP TABLE Doctors;
-- DROP TABLE Nurses;
-- DROP TABLE AdministrativeStaff;
-- DROP TABLE GeneralStaff;
-- DROP TABLE Departments;
-- DROP TABLE MedicalRecords;
-- DROP TABLE Appointments;
-- DROP TABLE Medications;
-- DROP TABLE TestsProcedures;
-- DROP TABLE Rooms;
-- DROP TABLE InventoryItems;
-- DROP TABLE Surgeries;
-- DROP TABLE FollowUps;
-- DROP TABLE EmergencyCases;
-- DROP TABLE MedicoLegalCases;
-- DROP TABLE Amniocentesis;
-- DROP TABLE BloodAnalysis;
-- DROP TABLE BoneMarrowAspiration;
-- DROP TABLE ECG;
-- DROP TABLE Ultrasound;
-- DROP TABLE MRI;
-- DROP TABLE Biopsy;
-- DROP TABLE Autopsy;

-- DROP DATABASE 
-- DROP DATABASE hospital_management;

