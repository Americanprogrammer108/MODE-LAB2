DROP DATABASE LRCH_ProjectInfo;

CREATE DATABASE LRCH_ProjectInfo;
DROP TABLE IF EXISTS PatientResults;

DROP TABLE IF EXISTS ChargedItems;

DROP TABLE IF EXISTS Admissions;

DROP TABLE IF EXISTS Location;

DROP TABLE IF EXISTS Patient;

DROP TABLE IF EXISTS Physician;

DROP TABLE IF EXISTS Items;

DROP TABLE IF EXISTS CostCenter;

CREATE TABLE Patient
(
	PatientNumber_NuméroDePatient_NúmeroDePaciente int,
	PatientFirstName_PrénomDuPatient_NombreDelPaciente varchar(max),
	PatientLastName_NomDeFamilleDuPatient_ApellidoDelPaciente varchar(max),
	FinancialStatus_StatutFinancier_EstadoFinanciero varchar(max),
	PatientAddress_AddresseDuPatient_DireccionDelPaciente varchar(max),
	City_Ville_Ciudad varchar(max),
	ProvinceORState_ProvinceOUÉtat_ProvinciaOEstado varchar(max),
	PRIMARY KEY (PatientNumber_NuméroDePatient_NúmeroDePaciente)
);

CREATE TABLE Physician
(
	PhysicianID_IDMedecin_IDDelMédico int,
	PhysicianFirstName_PrénomDuMédecin_NombreDelMédico varchar(max),
	PhysicianLastName_NomDeFamilleDuMédecin_ApellidoMédico varchar(max),
	Telephone_Téléphone_Téléfono int,
	Speciality_Spécialité_Especialidad varchar(max)
	PRIMARY KEY (PhysicianID_IDMedecin_IDDelMédico)
);

CREATE TABLE Location
(
	LocationID_IDdEmplacement_IDdeUbicación int,
	RoomNumber_NuméroDecChambre_NúmerodDeHabitación int,
	BedID_IDdeLit_IDdeCama int,
	Extension_Extension_Extensión int,
	Type_Taper_Tipo char,
	PRIMARY KEY (LocationID_IDdEmplacement_IDdeUbicación) 
);


CREATE TABLE Admissions
(
	VisitID_IDdeVisite_IDdeVisita int,
	PatientNumber_NuméroDePatient_NúmeroDePaciente int,
	LocationID_IDdEmplacement_IDdeUbicación int,
	DateAdmitted_DateDAdmission_FechaDeAdmisión date,
	DischargeDate_DateDeSortie_FechaDeAlta date
	PRIMARY KEY (VisitID_IDdeVisite_IDdeVisita),
	FOREIGN KEY (PatientNumber_NuméroDePatient_NúmeroDePaciente) references Patient(PatientNumber_NuméroDePatient_NúmeroDePaciente),
	FOREIGN KEY (LocationID_IDdEmplacement_IDdeUbicación) REFERENCES Location(LocationID_IDdEmplacement_IDdeUbicación) 
);

CREATE TABLE CostCenter
(
	CostCenterID_IDduCentreDeCoûts_IDdelCentroDeCostes int,
	CostCenterName_NomDuCentreDeCoûts_NombreDelCentroDeCostos varchar(max),
	PRIMARY KEY(CostCenterID_IDduCentreDeCoûts_IDdelCentroDeCostes)
);

CREATE TABLE ChargedItems
(
	ItemID_IDdelarticle_IDdelArticulo int,
	CostCenterID_IDduCentreDeCoûts_IDdelCentroDeCostes int,
	ChargeDate_DateDeFacturation_FechaDeCargo date,
	TotalCharge_ChargeTotale_CargaTotal float,
	PRIMARY KEY(ItemID_IDdelarticle_IDdelArticulo),
	FOREIGN KEY (CostCenterID_IDduCentreDeCoûts_IDdelCentroDeCostes) REFERENCES CostCenter(CostCenterID_IDduCentreDeCoûts_IDdelCentroDeCostes)
);

CREATE TABLE Items
(
	ItemID_IDdelarticle_IDdelArticulo int,
	Description_Description_Descripción varchar(max),
	ItemPrice_PrixdelArticle_PrecioDelArticulo float,
	ItemQuantityOnHand_QuantitéDArticlesEnStock_CantidadDeArtículosDisponibles int
);


--NOW INSERT THE Items
--Admissions 10
-- Patient: 10
--Physician: 0
--Items: 
--ChargedItems: 9
--CostCenter: 11

INSERT INTO Patient
VALUES (120833, 'Jason', 'Reinhardt', 'CAA', '44 Lowell St', 'Toronto', 'ON');


INSERT INTO Physician
VALUES (239847, 'Sean', 'Klein', 6472394876, 'X-Ray');

INSERT INTO Location
VALUES (123894, 108, 474763, 338, '3');

INSERT INTO Admissions
VALUES (408194, 120833, 123894, '2021-01-29', '2021-03-01');


INSERT INTO CostCenter
VALUES (28819, 'Ultrason Scan Center');

INSERT INTO ChargedItems
VALUES (14083, 28819, '2021-02-14', 119.97);

INSERT INTO Items
VALUES (539271, 'X-Ray Checkup', 39.99, 3);



--2nd round
INSERT INTO Patient
VALUES (148467, 'Jessica', 'Weiss', 'TD', '426 Weston Rd', 'Guelph', 'ON');

INSERT INTO Physician
VALUES (280172, 'Fiona', 'Wang', 8007235948, 'Cancer');

INSERT INTO Location
VALUES (473632, 144, 923864, 441, 's');


INSERT INTO Admissions
VALUES (338194, 148467, 473632, '2019-05-07', '2019-06-01');


INSERT INTO CostCenter
VALUES (123983, '348');

INSERT INTO ChargedItems
VALUES (21389, 123983, '2019-06-01', 109.99);

INSERT INTO Items
VALUES (599383, 'Cancer Treatment', 54.99, 2);



--3rd round
INSERT INTO Patient
VALUES (148463, 'Rotem', 'Daniel', 'RBC', '1283 Chapman Dr', 'Peterborough', 'ON');

INSERT INTO Physician
VALUES (213876, 'Andrew', 'Knight', 9054407123, 'Operator');

INSERT INTO Location
VALUES (238983, 417, 347829, 430, 't');


INSERT INTO Admissions
VALUES (237816, 148463, 238983, '2019-09-18', '2019-09-30');


INSERT INTO CostCenter
VALUES (378133, 'Research and Development Department');

INSERT INTO ChargedItems
VALUES (123984, 378133, '2019-10-10', 159.99);

INSERT INTO Items
VALUES (519383, 'Cancer Treatment', 53.33, 3);


--4th round
INSERT INTO Patient
VALUES (105250, 'Brandon', 'Rawa', 'CAA', '1283 Chapman Dr', 'Peterborough', 'ON');

INSERT INTO Physician
VALUES (213876, 'Michael', 'Bousouleil', 9052381132, 'Anesthesiology');

INSERT INTO Location
VALUES (919263, 120, 123899, 401, '8');


INSERT INTO Admissions
VALUES (182888, 105250, 919263, '2016-01-28', '2016-02-14');


INSERT INTO CostCenter
VALUES (188826, 'Shoppers Drug Mart');

INSERT INTO ChargedItems
VALUES (123984, 378133, '2019-10-10', 239.97);

INSERT INTO Items
VALUES (519383, 'Hydroxychloroquine', 79.99, 3);


--5th round
INSERT INTO Patient
VALUES (821399, 'Kathleen', 'Benayon', 'RBC', '59 Sesame St', 'York', 'ON');

INSERT INTO Physician
VALUES (213876, 'Allyson', 'Chen', 9057714956, 'Cardiologist');

INSERT INTO Location
VALUES (255108, 425, 138599, 480, '5');


INSERT INTO Admissions
VALUES (481291, 821399, 255108, '2017-12-01', '2018-01-20');


INSERT INTO CostCenter
VALUES (849218, 'The Medicine Shoppe');

INSERT INTO ChargedItems
VALUES (213839, 849218, '2017-01-04', 84.99);

INSERT INTO Items
VALUES (519383, 'Hydroxychloroquine', 19.99, 4);


--6th round
INSERT INTO Patient
VALUES (383712, 'Anna', 'Li', 'BellAirDirect', '88 Yorkville Rd', 'London', 'ON');

INSERT INTO Physician
VALUES (414485, 'Warren', 'Chin', 4168001390, 'Optomitrist');

INSERT INTO Location
VALUES (351376, 505, 590320, 310, '1');


INSERT INTO Admissions
VALUES (213889, 383712, 351376, '2017-12-01', '2018-01-20');


INSERT INTO CostCenter
VALUES (483831, 'Walmart Pharmacy');

INSERT INTO ChargedItems
VALUES (180289, 483831, '2019-03-15', 29.99);

INSERT INTO Items
VALUES (519383, 'Hydroxychloroquine', 4.99, 6);

--7
INSERT INTO Patient
VALUES (192168, 'Lucius', 'Bhagan', 'Desjardin', '48 Dimarino Dr', 'Maple', 'ON');

INSERT INTO Physician
VALUES (299574, 'Joseph', 'Wei', 2881928846, 'Gynecology');

INSERT INTO Location
VALUES (121892, 522, 120839, 220, '6');


INSERT INTO Admissions
VALUES (213889, 192168, 121892, '2018-04-17', '2018-06-11');


INSERT INTO CostCenter
VALUES (393822, 'Walmart Pharmacy');

INSERT INTO ChargedItems
VALUES (129388, 393822, '2018-06-04', 69.99);

INSERT INTO Items
VALUES (519383, 'N/A', 19.99, 4);

--8
INSERT INTO Patient
VALUES (213900, 'Emma', 'Roberts', 'CAA', '78 Little Hannah Ln', 'Maple', 'ON');

INSERT INTO Physician
VALUES (301482, 'Blake', 'Carter', 8882429090, 'Dermatologist');

INSERT INTO Location
VALUES (823199, 901, 213890, 302, '4');


INSERT INTO Admissions
VALUES (210393, 213900, 823199, '2018-06-18', '2018-07-01');


INSERT INTO CostCenter
VALUES (489849, 'Walmart Pharmacy');

INSERT INTO ChargedItems
VALUES (219380, 489849, '2019-01-04', 64.99);

INSERT INTO Items
VALUES (519383, 'N/A', 21.99, 3);

--9
INSERT INTO Patient
VALUES (128839, 'Sam', 'Freedman', 'Desjardin', '33 Beverley Glen Blvd', 'Thornhill', 'ON');

INSERT INTO Physician
VALUES (301482, 'Blake', 'Shelton', 2994782781, 'Cardiologist');

INSERT INTO Location
VALUES (199180, 1002, 239809, 404, '5');


INSERT INTO Admissions
VALUES (830129, 128839, 199180, '2020-02-11', '2020-05-09');


INSERT INTO CostCenter
VALUES (123890, 'Surgical Center');

INSERT INTO ChargedItems
VALUES (218973, 123890, '2020-05-12', 24.99);

INSERT INTO Items
VALUES (519383, 'N/A', 10.99, 7);

--10
INSERT INTO Patient
VALUES (941784, 'Henry', 'Lau', 'Intact', '123 East St', 'Oshawa', 'ON');

INSERT INTO Physician
VALUES (726256, 'Jordan', 'Matter', 6471389931, 'Cardiologist');

INSERT INTO Location
VALUES (129380, 522, 107265, 901, '2');


INSERT INTO Admissions
VALUES (219038, 941784, 129380, '2021-08-13', '2021-09-11');


INSERT INTO CostCenter
VALUES (573821, 'Walmart Pharmacy');

INSERT INTO ChargedItems
VALUES (100028, 573821, '2021-09-17', 34.99);

INSERT INTO Items
VALUES (472189, 'N/A', 11.99, 5);


INSERT INTO Patient
VALUES (230809, 'Jessica', 'Nguyen', 'BBB', '123 Main St', 'Vancouver', 'BC');

INSERT INTO Physician
VALUES (456789, 'Karen', 'Wu', 6042394876, 'Pediatrics');

INSERT INTO Location
VALUES (456123, 305, 475763, 638, '5');

INSERT INTO Admissions
VALUES (509081, 230809, 456123, '2021-03-11', '2021-06-01');

INSERT INTO CostCenter
VALUES (31928, 'MRI Scan Center');

INSERT INTO ChargedItems
VALUES (23849, 31928, '2021-04-05', 300.50);

INSERT INTO Items
VALUES (837592, 'Blood Test', 45.00, 4);
/**/
INSERT INTO Patient
VALUES (306793, 'Samantha', 'Chen', 'CCC', '678 Queen St', 'Calgary', 'AB');

INSERT INTO Physician
VALUES (584739, 'David', 'Lee', 4037394876, 'Dermatology');

INSERT INTO Location
VALUES (658921, 409, 739763, 148, '1');

INSERT INTO Admissions
VALUES (756389, 306793, 658921, '2021-02-20', '2021-03-01');

INSERT INTO CostCenter
VALUES (46938, 'Physical Therapy Center');

INSERT INTO ChargedItems
VALUES (19273, 46938, '2021-03-08', 75.25);

INSERT INTO Items
VALUES (927431, 'EKG Test', 65.00, 2);
/**/
INSERT INTO Patient
VALUES (743920, 'Avery', 'Garcia', 'DDD', '456 Oak St', 'Montreal', 'QC');

INSERT INTO Physician
VALUES (871249, 'Melissa', 'Ng', 5146394876, 'Cardiology');

INSERT INTO Location
VALUES (874923, 701, 918763, 527, '4');

INSERT INTO Admissions
VALUES (912830, 743920, 874923, '2021-04-01', '2021-04-20');

INSERT INTO CostCenter
VALUES (67283, 'Pharmacy');

INSERT INTO ChargedItems
VALUES (39174, 67283, '2021-04-07', 45.99);

INSERT INTO Items
VALUES (123456, 'Flu Shot', 20.00, 1);
/**/
INSERT INTO Patient
VALUES (587234, 'Oliver', 'Murray', 'EEE', '789 King St', 'Victoria', 'BC');

INSERT INTO Physician
VALUES (980734, 'Sophia', 'Li', 2509804876, 'Obstetrics');

INSERT INTO Location
VALUES (876234, 305, 475763, 638, '3');

INSERT INTO Admissions
VALUES (765890, 587234, 876234, '2021-03-15', '2021-04-01');

INSERT INTO CostCenter
VALUES (53891, 'Surgical Center');

INSERT INTO ChargedItems
VALUES (48923, 53891, '2021-03-22', 500.00);

INSERT INTO Items
VALUES (234567, 'Appendectomy', 300.00, 2);
/**/    
INSERT INTO Patient
VALUES (549872, 'Ethan', 'Smith', 'FFF', '567 Main St', 'Winnipeg', 'MB');

INSERT INTO Physician
VALUES (765412, 'Jacob', 'Kim', 2047654876, 'Neurology');

INSERT INTO Location
VALUES (234598, 202, 836763, 218, '2');

INSERT INTO Admissions
VALUES (782346, 549872, 234598, '2021-04-05', '2021-04-20');

INSERT INTO CostCenter
VALUES (92813, 'Radiology Center');

INSERT INTO ChargedItems
VALUES (38127, 92813, '2021-04-12', 150.00);

INSERT INTO Items
VALUES (345678, 'CT Scan', 100.00, 1);
/**/  
INSERT INTO Patient
VALUES (309754, 'Hannah', 'Lee', 'GGG', '1234 Elm St', 'Regina', 'SK');

INSERT INTO Physician
VALUES (876459, 'Emily', 'Park', 3068764590, 'Psychiatry');

INSERT INTO Location
VALUES (908734, 401, 581763, 789, '6');

INSERT INTO Admissions
VALUES (981234, 309754, 908734, '2021-03-22', '2022-08-11');

INSERT INTO CostCenter
VALUES (45681, 'Emergency Department');

INSERT INTO ChargedItems
VALUES (81273, 45681, '2021-03-29', 750.00);

INSERT INTO Items
VALUES (456789, 'Emergency Services', 500.00, 2);
/**/  
INSERT INTO Patient
VALUES (365984, 'Grace', 'Chen', 'HHH', '7895 Oak St', 'Vancouver', 'BC');

INSERT INTO Physician
VALUES (297651, 'David', 'Wong', 6042976512, 'Gastroenterology');

INSERT INTO Location
VALUES (187245, 605, 491763, 918, '5');

INSERT INTO Admissions
VALUES (456789, 365984, 187245, '2021-04-10', '2021-05-01');

INSERT INTO CostCenter
VALUES (10928, 'Laboratory');

INSERT INTO ChargedItems
VALUES (87264, 10928, '2021-04-17', 65.00);

INSERT INTO Items
VALUES (567890, 'Blood Test', 50.00, 1);
/**/ 
INSERT INTO Patient
VALUES (846372, 'Isabella', 'Wang', 'III', '4567 Main St', 'Calgary', 'AB');

INSERT INTO Physician
VALUES (198237, 'Sarah', 'Zhang', 4031982376, 'Dermatology');

INSERT INTO Location
VALUES (675439, 201, 918763, 367, '8');

INSERT INTO Admissions
VALUES (765432, 846372, 675439, '2021-03-30', '2023-01-02');

INSERT INTO CostCenter
VALUES (98012, 'Physical Therapy');

INSERT INTO ChargedItems
VALUES (67543, 98012, '2021-04-06', 90.00);

INSERT INTO Items
VALUES (678901, 'Physical Therapy Session', 75.00, 1);
/**/ 
INSERT INTO Patient
VALUES (539810, 'Oliver', 'Garcia', 'BBB', '789 Pine St', 'Edmonton', 'AB');

INSERT INTO Physician
VALUES (298465, 'Sophia', 'Choi', 7802984650, 'Cardiology');

INSERT INTO Location
VALUES (873246, 401, 678763, 467, '2');

INSERT INTO Admissions
VALUES (913456, 539810, 873246, '2021-04-07', '2021-04-11');

INSERT INTO CostCenter
VALUES (81234, 'Pharmacy');

INSERT INTO ChargedItems
VALUES (12345, 81234, '2021-04-14', 25.00);

INSERT INTO Items
VALUES (789012, 'Prescription Medication', 20.00, 1);
/**/ 
INSERT INTO Patient
VALUES (745983, 'Liam', 'Nguyen', 'III', '456 Oak St', 'Vancouver', 'BC');

INSERT INTO Physician
VALUES (432187, 'Emma', 'Tran', 6044321871, 'Endocrinology');

INSERT INTO Location
VALUES (981234, 301, 782763, 398, '4');

INSERT INTO Admissions
VALUES (234567, 745983, 981234, '2021-03-28', '2021-04-05');

INSERT INTO CostCenter
VALUES (34567, 'MRI Center');

INSERT INTO ChargedItems
VALUES (56789, 34567, '2021-04-04', 300.00);

INSERT INTO Items
VALUES (901234, 'MRI Scan', 250.00, 1);
/**/ 
INSERT INTO Patient
VALUES (837465, 'Mia', 'Chen', 'CCC', '123 Main St', 'Toronto', 'ON');

INSERT INTO Physician
VALUES (384756, 'William', 'Liu', 4163847561, 'Neurology');

INSERT INTO Location
VALUES (675849, 503, 918763, 237, '7');

INSERT INTO Admissions
VALUES (123456, 837465, 675849, '2021-03-15', '2021-03-24');

INSERT INTO CostCenter
VALUES (76543, 'Occupational Therapy');

INSERT INTO ChargedItems
VALUES (98765, 76543, '2021-03-22', 80.00);

INSERT INTO Items
VALUES (234567, 'Occupational Therapy Session', 70.00, 1);
/**/ 
INSERT INTO Patient
VALUES (438571, 'Avery', 'Wu', 'DDD', '5678 First St', 'Calgary', 'AB');

INSERT INTO Physician
VALUES (675849, 'Aiden', 'Zhang', 4036758491, 'Pediatrics');

INSERT INTO Location
VALUES (234567, 101, 567763, 348, '1');

INSERT INTO Admissions
VALUES (890123, 438571, 234567, '2021-04-01', '2021-04-11');

INSERT INTO CostCenter
VALUES (23456, 'Radiology');

INSERT INTO ChargedItems
VALUES (78901, 23456, '2021-04-08', 150.00);

INSERT INTO Items
VALUES (345678, 'CT Scan', 125.00, 1);
/**/ 
INSERT INTO Patient
VALUES (354897, 'Ethan', 'Wong', 'EEE', '456 Main St', 'Vancouver', 'BC');

INSERT INTO Physician
VALUES (908765, 'Isabella', 'Gao', 6049087650, 'Psychiatry');

INSERT INTO Location
VALUES (345678, 202, 856763, 474, '5');

INSERT INTO Admissions
VALUES (123789, 354897, 345678, '2021-03-19', '2021-03-24');

INSERT INTO CostCenter
VALUES (87654, 'Physical Therapy');

INSERT INTO ChargedItems
VALUES (98765, 87654, '2021-03-26', 75.00);

INSERT INTO Items
VALUES (234567, 'Physical Therapy Session', 60.00, 1);
/**/ 
INSERT INTO Patient
VALUES (790321, 'Emma', 'Zhang', 'FFF', '789 Elm St', 'Toronto', 'ON');

INSERT INTO Physician
VALUES (432109, 'Noah', 'Chen', 4164321098, 'Dermatology');

INSERT INTO Location
VALUES (876543, 303, 349763, 256, '6');

INSERT INTO Admissions
VALUES (654321, 790321, 876543, '2021-04-04', '2021-06-01');

INSERT INTO CostCenter
VALUES (345678, 'Ultrasound Center');

INSERT INTO ChargedItems
VALUES (901234, 345678, '2021-04-11', 200.00);

INSERT INTO Items
VALUES (456789, 'Ultrasound', 175.00, 1);
/**/ 
INSERT INTO Patient
VALUES (234561, 'Olivia', 'Liu', 'GGG', '5678 Oak St', 'Vancouver', 'BC');

INSERT INTO Physician
VALUES (987654, 'Lucas', 'Cheng', 6049876543, 'Oncology');

INSERT INTO Location
VALUES (123450, 404, 879763, 143, '2');

INSERT INTO Admissions
VALUES (543210, 234561, 123450, '2021-02-15', '2021-05-21');

INSERT INTO CostCenter
VALUES (901234, 'Radiation Therapy');

INSERT INTO ChargedItems
VALUES (345678, 901234, '2021-02-22', 500.00);

INSERT INTO Items
VALUES (678901, 'Radiation Treatment', 450.00, 1);
/**/ 
INSERT INTO Patient
VALUES (345678, 'Sophia', 'Zhu', 'HHH', '456 Maple St', 'Calgary', 'AB');

INSERT INTO Physician
VALUES (234561, 'Ethan', 'Liu', 4032345617, 'Cardiology');

INSERT INTO Location
VALUES (567890, 606, 243763, 584, '4');

INSERT INTO Admissions
VALUES (890123, 345678, 567890, '2021-03-01', '2021-06-10');

INSERT INTO CostCenter
VALUES (789012, 'Pharmacy');

INSERT INTO ChargedItems
VALUES (901234, 789012, '2021-03-08', 40.00);

INSERT INTO Items
VALUES (123456, 'Prescription Medication', 30.00, 1);
/**/ 
INSERT INTO Patient
VALUES (456789, 'Aiden', 'Chu', 'III', '3456 Pine St', 'Edmonton', 'AB');

INSERT INTO Physician
VALUES (567890, 'Mia', 'Huang', 7805678901, 'Pediatrics');

INSERT INTO Location
VALUES (678901, 505, 986763, 901, '1');

INSERT INTO Admissions
VALUES (789012, 456789, 678901, '2021-04-17', '2021-07-05');

INSERT INTO CostCenter
VALUES (890123, 'MRI Center');

INSERT INTO ChargedItems
VALUES (901234, 890123, '2021-04-24', 350.00);

INSERT INTO Items
VALUES (234561, 'MRI Scan', 300.00, 1);
/**/ 
INSERT INTO Patient
VALUES (543210, 'Aria', 'Chen', 'DDD', '7890 Birch St', 'Toronto', 'ON');

INSERT INTO Physician
VALUES (987654, 'Evelyn', 'Wu', 4169876543, 'Gynecology');

INSERT INTO Location
VALUES (123450, 707, 763963, 444, '6');

INSERT INTO Admissions
VALUES (234561, 543210, 123450, '2021-05-01', '2021-09-14');

INSERT INTO CostCenter
VALUES (345678, 'Physical Exam');

INSERT INTO ChargedItems
VALUES (456789, 345678, '2021-05-08', 120.00);

INSERT INTO Items
VALUES (567890, 'Routine Physical Exam', 100.00, 1);
/**/
INSERT INTO Patient
VALUES (921384, 'Ethan', 'Kim', 'EEE', '456 Second St', 'Vancouver', 'BC');

INSERT INTO Physician
VALUES (293847, 'Isabella', 'Lee', 7782938470, 'Psychiatry');

INSERT INTO Location
VALUES (187234, 201, 987763, 482, '5');

INSERT INTO Admissions
VALUES (901234, 921384, 187234, '2021-02-20', '2021-06-01');

INSERT INTO CostCenter
VALUES (65432, 'Laboratory');

INSERT INTO ChargedItems
VALUES (10987, 65432, '2021-02-27', 50.00);

INSERT INTO Items
VALUES (543210, 'Blood Test', 40.00, 1);
/**/
INSERT INTO Patient
VALUES (763984, 'Sophie', 'Chen', 'FFF', '789 Maple St', 'Toronto', 'ON');

INSERT INTO Physician
VALUES (901823, 'Benjamin', 'Wang', 6479018230, 'Ophthalmology');

INSERT INTO Location
VALUES (789012, 601, 349763, 672, '6');

INSERT INTO Admissions
VALUES (234567, 763984, 789012, '2021-03-02', '2021-05-22');

INSERT INTO CostCenter
VALUES (87654, 'Physical Therapy');

INSERT INTO ChargedItems
VALUES (23456, 87654, '2021-03-09', 100.00);

INSERT INTO Items
VALUES (789012, 'Physical Therapy Session', 90.00, 1);