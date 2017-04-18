
DROP DATABASE IF EXISTS JCrisis_Hotline_DB;

CREATE DATABASE JCrisis_Hotline_DB;

USE JCrisis_Hotline_DB;

Create Table Call_Record (
    Call_Record_ID INT AUTO_INCREMENT NOT NULL COMMENT 'ID of the call record',
    Start_Time DATETIME NOT NULL COMMENT 'Start time of the comment',
    Counselor_ID INT NOT NULL COMMENT 'ID of the counselor overlooking the call',
    Call_Description TEXT COMMENT 'Description of the call record',
    Call_Type_ID VARCHAR(25) NOT NULL COMMENT 'Type of the call record',
    Caller_ID INT COMMENT 'ID of the caller',
    End_Time DATETIME NOT NULL COMMENT 'End time of the call record',
    PRIMARY KEY (Call_Record_ID)
) COMMENT 'Information about a specific call record';



Create Table Call_Record_Resource (
    Call_Record_ID INT NOT NULL COMMENT 'ID of the related Call Record',
    Resource_ID INT NOT NULL COMMENT 'ID of the resource referred to in the Call Record',
    PRIMARY KEY (Call_Record_ID, Resource_ID)
) COMMENT 'Join table of call records and resources; each record indicates a resource that was reccomended during a call record';

Create Table Caller (
    Caller_ID INT NOT NULL COMMENT 'ID of the caller',
    First_Name VARCHAR(25) COMMENT 'First name of the caller',
    Last_Name VARCHAR(25) COMMENT 'Last name of the caller',
    Phone VARCHAR(20) COMMENT 'Phone number of the caller',
    Address VARCHAR(50) COMMENT 'Address of the caller',
    City VARCHAR(25) COMMENT 'City of the caller',
    Territory CHAR(2) COMMENT 'Two digit state code of the caller',
    ZIP VARCHAR(10) COMMENT 'Zip code of the caller',
    PRIMARY KEY(Caller_ID)
) COMMENT 'Information about any caller using our service';

Create Table Call_Type (
    Call_Type_ID VARCHAR(25) NOT NULL COMMENT 'Category of the call type',
    Description TEXT COMMENT 'A more specific descripton for the category',
    PRIMARY KEY(Call_Type_ID)
) COMMENT 'Types of calls and their descriptions';


Create Table Limitation(
    Limitation_ID INT NOT NULL COMMENT 'Limitation Id primary key that references to a varchar string category id',
    Limitation_Category_ID VARCHAR(25) COMMENT 'Limitation Category ID is a foreign key that ties to the limitation category table',
    PRIMARY KEY (Limitation_ID)
);

Create Table Limitation_Category (
    Limitation_Category_ID VARCHAR(25) COMMENT 'Limitation Category ID is a primary key that links to the description',
    Description TEXT COMMENT 'Short description of the limitation',
    PRIMARY KEY (Limitation_Category_ID)
);

Create Table Resource_Provider (
    Resource_ID INT AUTO_INCREMENT NOT NULL COMMENT 'ID of the Resource',
    Name VARCHAR(50) NOT NULL COMMENT 'Name of the Resource',
    Phone VARCHAR(15) NOT NULL COMMENT 'Phone Number of the Resource',
    Address_One VARCHAR(50) NOT NULL COMMENT 'Address of the Resource',
    Address_Two VARCHAR(50) COMMENT 'Optional Address of the Resource',
    City VARCHAR(50) NOT NULL COMMENT 'City of the Resource',
    Territory VARCHAR(50) NOT NULL COMMENT 'State of the Resource',
    Country VARCHAR(50) NOT NULL COMMENT 'Country of the Resource',
    Postal_Code VARCHAR(10) NOT NULL COMMENT 'Zip Code of the Resource',
    Email VARCHAR(100) NOT NULL COMMENT 'Email of the Resource',
    Description TEXT NOT NULL COMMENT 'Description of the Resource',
    PRIMARY KEY(Resource_ID)
);

Create Table Resource_Limitation (
    Resource_ID INT NOT NULL COMMENT 'ID of the Resource',
    Limitation_ID INT NOT NULL COMMENT 'ID of the Limitation',
    PRIMARY KEY(Resource_ID, Limitation_ID)
);

Create Table Resource_Category (
    Resource_Category_ID VARCHAR(25) NOT NULL COMMENT'ID of the resource referred to in the Call Record',
    Description TEXT NOT NULL COMMENT 'Description of the Resource',
    PRIMARY KEY (Resource_Category_ID)
);
/*
Create Table Resource_Category_Hierarchy (
    Super_Category VARCHAR(25) NOT NULL,
    Sub_Category VARCHAR(25) NOT NULL,
    PRIMARY KEY(Super_Category,Sub_Category)
);
*/
Create Table Resource_Category_Resource (
    Resource_Category_ID VARCHAR(25) COMMENT 'ID of the Resource Category',
    Resource_ID INT NOT NULL COMMENT 'ID of the Resource',
    PRIMARY KEY(Resource_Category_ID, Resource_ID)
);

Create Table Role (
    Role_ID VARCHAR(20) NOT NULL COMMENT 'ID for the Role',
    Description TEXT NOT NULL COMMENT 'Description of the Role',
    PRIMARY KEY(Role_ID)
);

Create Table App_User (
    User_ID INT AUTO_INCREMENT NOT NULL COMMENT 'ID of the User',
    Password_Hash CHAR(64) NOT NULL COMMENT 'Password Hass of the User',-- Need to change once we know what the hash will be for the default user.
    Password_Salt CHAR(64) NOT NULL COMMENT 'Password Salt of the User', -- Need to change when we have this implemented.
    First_Name VARCHAR(200) NOT NULL COMMENT 'First Name of the User',
    Last_Name VARCHAR(200) NOT NULL COMMENT 'Last Name of the User',
    Phone VARCHAR(20) NOT NULL COMMENT 'Phone Number of User',
    Address_One VARCHAR(100) NOT NULL COMMENT 'Address One of the User',
    Address_Two VARCHAR(100) COMMENT 'Address Two of the User',
    City VARCHAR(100) NOT NULL COMMENT 'City of the User',
    Territory VARCHAR(50) NOT NULL COMMENT 'Territory of the User',
    Zip VARCHAR(10) NOT NULL COMMENT 'Zip Code of the User',
    PRIMARY KEY(User_ID)
);

ALTER TABLE App_User AUTO_INCREMENT = 10000;

ALTER TABLE Call_Record AUTO_INCREMENT = 10000;

ALTER TABLE Call_Record AUTO_INCREMENT = 10000;

Create Table User_Role (
    User_ID INT NOT NULL COMMENT 'ID of the User',
    Role_ID VARCHAR(20) NOT NULL COMMENT 'ID of the Role ',
    Start_Date DATETIME NOT NULL COMMENT 'Start Date of the User',
    End_Date DATETIME COMMENT 'End Date of the User',
    PRIMARY KEY (User_ID, Role_ID, Start_Date)
);

ALTER TABLE Call_Record
ADD FOREIGN KEY Call_Record_Counselor_ID(Counselor_ID)
REFERENCES App_User(User_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Call_Record
ADD FOREIGN KEY Call_Record_Call_Type_ID(Call_Type_ID)
REFERENCES Call_Type(Call_Type_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Call_Record
ADD FOREIGN KEY Call_Record_Caller_ID(Caller_ID)
REFERENCES Caller(Caller_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Call_Record_Resource
ADD FOREIGN KEY Call_Record_Resource_Call_Record_ID(Call_Record_ID)
REFERENCES Call_Record(Call_Record_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Call_Record_Resource
ADD FOREIGN KEY Call_Record_Resource_Resource_ID(Resource_ID)
REFERENCES Resource_Provider(Resource_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Limitation
ADD FOREIGN KEY Limitation_Limitation_Category_ID(Limitation_Category_ID)
REFERENCES Limitation_Category(Limitation_Category_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Resource_Limitation
ADD FOREIGN KEY Resource_Limitation_Resource_ID(Resource_ID)
REFERENCES Resource_Provider(Resource_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Resource_Limitation
ADD FOREIGN KEY Resource_Limitation_Limitation_ID(Limitation_ID)
REFERENCES Limitation(Limitation_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

/*
ALTER TABLE Resource_Category_Hierarchy
ADD FOREIGN KEY Resource_Category_Hierarchy_Super_Category(Super_Category)
REFERENCES Resource_Category(Resource_Category_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Resource_Category_Hierarchy
ADD FOREIGN KEY Resource_Category_Hierarchy_Sub_Category(Sub_Category)
REFERENCES Resource_Category(Resource_Category_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;
*/

ALTER TABLE Resource_Category_Resource
ADD FOREIGN KEY Resource_Category_Resource_Resource_Category_ID(Resource_Category_ID)
REFERENCES Resource_Category(Resource_Category_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Resource_Category_Resource
ADD FOREIGN KEY Resource_Category_Resource_Resource_ID(Resource_ID)
REFERENCES Resource_Provider(Resource_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE User_Role
ADD FOREIGN KEY User_Role_User_ID(User_ID)
REFERENCES App_User(User_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE User_Role
ADD FOREIGN KEY User_Role_Role_ID(Role_ID)
REFERENCES Role(Role_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;


DROP USER IF EXISTS 'JCrisisServer'@'%';

CREATE USER 'JCrisisServer'@'%' IDENTIFIED BY 'apple';

delimiter  $$


Create PROCEDURE sp_retrieve_user_list()
COMMENT 'Retrieves a list of users'
BEGIN
SELECT User_ID, First_Name, Last_Name, Phone, Address_One, Address_Two, City, Territory, Zip
FROM App_User;
END$$

delimiter  ;

GRANT EXECUTE ON PROCEDURE sp_retrieve_user_list TO 'JCrisisServer'@'%';

delimiter  $$


Create PROCEDURE sp_retrieve_user_by_logon
(
    IN p_User_ID INTEGER,
    IN p_Password_Hash CHAR(64)
)
COMMENT 'Retrieves a user by that user\'s id an password'
BEGIN
SELECT User_ID, First_Name, Last_Name, Phone, Address_One, Address_Two, City, Territory, Zip
FROM App_User
WHERE User_ID = p_User_ID
AND p_Password_Hash = Password_Hash;
END$$

delimiter  ;

GRANT EXECUTE ON PROCEDURE sp_retrieve_user_by_logon TO 'JCrisisServer'@'%';

delimiter  $$


Create PROCEDURE sp_validate_user
(
    IN p_User_ID INTEGER,
    IN p_Password_Hash CHAR(64)
)
COMMENT 'Retrieves a user by that user\'s id an password'
BEGIN
SELECT COUNT(p_User_ID)
FROM App_User
WHERE User_ID = p_User_ID
AND p_Password_Hash = Password_Hash;
END$$

delimiter  ;

GRANT EXECUTE ON PROCEDURE sp_validate_user TO 'JCrisisServer'@'%';


delimiter  $$


Create PROCEDURE sp_retrieve_user_roles
(
    IN p_User_ID INTEGER
)
COMMENT 'Retrieves a list of roles for the given user'
BEGIN
SELECT Role_ID
FROM User_Role
WHERE User_ID = p_User_ID
AND End_Date > NOW();
END$$

delimiter  ;

GRANT EXECUTE ON PROCEDURE sp_retrieve_user_roles TO 'JCrisisServer'@'%';

INSERT INTO resource_provider ( Resource_ID, Name, Phone, Address_One, Address_Two, City, Territory, Country, Postal_Code, Email, Description)
			  VALUES ( 10000 , 'Peter Parker' , '319 999 9999', '20 Ingram Street' , '', 'Flushing', 'NY', 'US', '11375', 'spiderman@heroes.com', 'Super Heroes' )
					, ( 10001 , 'Bruce Wayne' , '319 888 9999', '1007 Mountain Drive' , '', 'Gotham', 'NJ', 'US', '21375', 'batman@heroes.com', 'Super Heroes')
					,( 10002 , 'Thor' , '319 888 8888', 'Some Where in Asgard' , '', 'Asgard', 'AG', 'AJ', '99999', 'thor@heroes.com', 'Super Heroes')
	;	
-- Test data insertion point
INSERT INTO Resource_Category (Resource_Category_ID, Description)
VALUES ('natural disasters', 'Flooding tornadoes weather related incidents fires or any incident that is created by a weather disaster')
	,('suicide', 'When a person threatens suicide or plans to commit suicide')
	,('domestic abuse', 'Violent or aggressive behavior within the home')
	,('economic changes', 'Loss of a job or medical bills or theft of a purse or cash or utilities being shut off')
	,('community resources', 'A lack of housing resources or food resources or inadequate crime protection')
;

INSERT INTO Resource_Category_Resource (Resource_Category_ID, Resource_ID)
VALUES ('natural disasters', 10001)
	,('suicide', 10002)
	,('domestic abuse', 10001)
	,('community resources', 10001)
	,('economic changes', 10000)
	,('community resources', 10000)
;

INSERT INTO Caller (Caller_ID, First_Name, Last_Name, Phone, Address, City, Territory, ZIP)
VALUES (10000, 'John', 'Doe', '1234567890', '123 Somewhere', 'Someburg', 'IA', '52404')
	,  (10001, 'Jane', 'Doe', '1234567891', '123 Somewhere', 'Someburg', 'IA', '52404')
    ,  (10002, 'Ben', 'Dover', '5247841212', '123 Anywhere', 'Knowhere', 'IA', '52403')
;

INSERT INTO Call_Type (Call_Type_ID, Description)
VALUES ('Suicide', 'Calls dealing with people suffering from suicidal thoughts, assisting those who know others with suicidal thoughts, or helping survivors of suicide attempts')
	,  ('Abuse', 'Calls handling acts of physical, emotional, and/or verbal abuse')
    ,  ('Depression', 'Calls assisting those dealing with depression or with callers working with someone suffering from depression')
;
	
INSERT INTO Role (Role_ID, Description)
VALUES ('reports','Any peson needing access to reports.')
	,  ('counselor','Users who create call records, retrieve prior call records, and research crisis resources for use in assisting callers.')
	,  ('manager',"Perform functions of a counselor, update/review call records, update counselors' status, and review reports.")
    ,  ('dataEntry','User who interacts with the Database_System either designing reports or modifying data.')
;

INSERT INTO App_User (Password_Hash, Password_Salt, First_Name, Last_Name, Phone, Address_One, Address_Two, City, Territory, Zip)
VALUES ('password','password','Johnny','Smith', '319-555-5555', '333 Gray Fox Run', '', 'Cedar Rapids', 'IA', '52404')
	,  ('Set Password Hash','Set Password','Bob','Jones', '319-555-5556', 'Kirkwood Apartments', '444 Gray Fox Run', 'Cedar Rapids', 'IA', '52404')
	,  ('Set Password Hash','Set Password','Katie','Perry', '319-555-5557', '555 Gray Fox Run', '', 'Cedar Rapids', 'IA', '52404')
	,  ('Set Password Hash','Set Password','Sara','Walker', '319-555-5558', '666 Gray Fox Run', '', 'Cedar Rapids', 'IA', '52404')
;

INSERT INTO User_Role (User_ID, Role_ID, Start_Date)
VALUES (10000,'counselor','2017-02-24 10:00:00')
	,  (10001,'counselor','2016-10-24 10:00:00')
    ,  (10001,'reports','2016-10-24 10:00:00')
    ,  (10001,'manager','2016-10-24 10:00:00')
    ,  (10002,'reports','2016-11-25 10:00:00')
    ,  (10003,'dataEntry','2016-06-24 10:00:00')
;
/*
INSERT INTO Call_Record (Start_Time, Counselor_ID, Call_Description, Call_Type_ID, Caller_ID, End_Time)
VALUES ('2012-12-31 11:30:45', 10000, "Cool call", 10000, 10000, '2012-12-31 11:30:46')
	,  ('2012-12-31 11:30:45', 10000, "Cool call", 10000, 10000, '2012-12-31 11:30:46')
	,  ('2012-12-31 11:30:45', 10000, "Cool call", 10000, 10000, '2012-12-31 11:30:46')
;

INSERT INTO Call_Record_Resource (Call_Record_ID, Resource_ID)
VALUES (10000, 10000)
	,  (10001, 10001)
	,  (10002, 10002)
;
*/
	  
/*
INSERT INTO Resource_Limitation (Resource_ID, Limitation_ID)
							VALUES( 10000,10000)
								,( 10001,10001)
								,( 10002,10002)
                                ;
*/

INSERT INTO Limitation_Category(Limitation_Category_ID, Description)
VALUES  ('No Limitation', 'There are no limitation for this Resource')
	,	('Males', 'Limited to males')
	,	('Females', 'Limited to Females')
	,	('Males 18 and up', 'Limited to males 18 and up')
	,	('Females 18 and up', 'Limited to females 18 and up')
	,	('Males 17 and under', 'Limited to males 17 amd under')
	,	('Females 17 and under', 'Limited to females 17 and under')
	,	('Children', 'Limited to children')
	,	('Teens', 'Limited to teens')
	,	('Adults', 'Limited to adults')
;

INSERT INTO Limitation(Limitation_ID, Limitation_Category_ID)
VALUES  (10000,'No Limitation')
	,	(10001,'Males')
	,	(10002,'Females')
	,	(10003,'Males 18 and up')
	,	(10004,'Females 18 and up')
	,	(10005,'Males 17 and under')
	,	(10006,'Females 17 and under')
	,	(10007,'Children')
	,	(10008,'Teens')
	,	(10009,'Adults')
;
DELIMITER $$
CREATE PROCEDURE sp_retrieve_limitation_category_ids()
BEGIN
	SELECT Limitation_Category_ID
	FROM Limitation;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_retrieve_limitation_category_id_by_limitation_id(
	IN Limitation_ID INT
)
BEGIN
	SELECT Limitation_Category_ID
	FROM Limitation
	WHERE @Limitation_ID = Limitation_ID;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_retrieve_limitation_description_by_limitation_category_id(
	IN Limitation_Category_ID VARCHAR(25)
)
BEGIN
	SELECT Description
	FROM Limitation_Category
	WHERE @Limitation_Category_ID = Limitation_Category_ID;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_retrieve_all_limitation_category_id_and_descriptions()
BEGIN
	SELECT *
	FROM Limitation_Category;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_create_limitation
(
	IN limitation_id INT,
	IN limitation_category_id INT,
	IN description TEXT
)
BEGIN
	INSERT INTO Limitation
		(
			Limitation_ID,
			Limitation_Category_ID
		)
	VALUES
		(
			limitation_id,
			limitation_category_id
		);
        
	INSERT INTO Limitation_Category
		(
			Limitation_Category_ID,
			Description
		)
	VALUES
		(
			@limitation_category_id,
			@description
		);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_create_resource
(
	IN name VARCHAR(50),
    IN phone VARCHAR(15),
    IN address_one VARCHAR(50),
    IN address_two VARCHAR(50),
    IN city VARCHAR(50),
    IN territory VARCHAR(50),
    IN country VARCHAR(50),
    IN postal_code VARCHAR(10),
    IN email VARCHAR(100),
    IN description TEXT
)
BEGIN
	INSERT INTO Resource_Provider
		(
			Name,
            Phone,
            Address_One,
            Address_Two,
            City,
            Territory,
            Country,
            Postal_Code,
            Email,
            Description
		)
	VALUES
		(
			name,
            phone,
            address_one,
            address_two,
            city,
            territory,
            country,
            postal_code,
            email,
            description
		);
        
        SELECT LAST_INSERT_ID() AS 'new_id';
END $$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE sp_create_resource TO 'JCrisisServer'@'%';