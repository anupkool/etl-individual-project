DROP Table address;
CREATE TABLE address (
  AddressID INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key for Address records.',
  AddressLine1 VARCHAR(60) NOT NULL COMMENT 'First street address line.',
  AddressLine2 VARCHAR(60) DEFAULT NULL COMMENT 'Second street address line.',
  City VARCHAR(30) NOT NULL COMMENT 'Name of the city.',
  StateProvinceID INT(11) NOT NULL COMMENT 'Unique identification number for the state or province. Foreign key to StateProvince table.',
  PostalCode VARCHAR(15) NOT NULL COMMENT 'Postal code for the street address.',
  SpatialLocation GEOMETRY DEFAULT NULL COMMENT 'Latitude and longitude of this address.',
  rowguid VARCHAR(64) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (AddressID),
  UNIQUE KEY rowguid (rowguid),
  UNIQUE KEY AK_Address_rowguid (rowguid),
  UNIQUE KEY IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_Post1 (AddressLine1,AddressLine2,City,StateProvinceID,PostalCode),
  KEY IX_Address_StateProvinceID (StateProvinceID)) 
  ENGINE=INNODB AUTO_INCREMENT=32522 DEFAULT CHARSET=latin1 COMMENT='Street address information for customers, employees, and vendors.';
  
  
  DROP TABLE businessentityaddress;
  CREATE TABLE businessentityaddress (
  BusinessEntityID INT(11) NOT NULL COMMENT 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.',
  AddressID INT(11) NOT NULL COMMENT 'Primary key. Foreign key to Address.AddressID.',
  AddressTypeID INT(11) NOT NULL COMMENT 'Primary key. Foreign key to AddressType.AddressTypeID.',
  rowguid VARCHAR(64) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (BusinessEntityID,AddressID,AddressTypeID),
  UNIQUE KEY rowguid (rowguid),
  UNIQUE KEY AK_BusinessEntityAddress_rowguid (rowguid),
  KEY IX_BusinessEntityAddress_AddressID (AddressID),
  KEY IX_BusinessEntityAddress_AddressTypeID (AddressTypeID))
  ENGINE=INNODB DEFAULT CHARSET=latin1 COMMENT='Cross-reference table mapping customers, vendors, and employees to their addresses.';

DROP TABLE countryregion;
CREATE TABLE countryregion (
  CountryRegionCode VARCHAR(3) NOT NULL COMMENT 'ISO standard code for countries and regions.',
  NAME VARCHAR(100) NOT NULL COMMENT 'Country or region name.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (CountryRegionCode),
  UNIQUE KEY AK_CountryRegion_Name (NAME)) 
  ENGINE=INNODB DEFAULT CHARSET=latin1 COMMENT='Lookup table containing the ISO standard codes for countries and regions.';



DROP TABLE customer;
CREATE TABLE customer (
  CustomerID INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key.',
  PersonID INT(11) DEFAULT NULL COMMENT 'Foreign key to Person.BusinessEntityID',
  StoreID INT(11) DEFAULT NULL COMMENT 'Foreign key to Store.BusinessEntityID',
  TerritoryID INT(11) DEFAULT NULL COMMENT 'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.',
  AccountNumber VARCHAR(10) NOT NULL COMMENT 'Unique number identifying the customer assigned by the accounting system.',
  rowguid VARCHAR(64) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (CustomerID),
  UNIQUE KEY rowguid (rowguid),
  UNIQUE KEY AK_Customer_rowguid (rowguid),
  UNIQUE KEY AK_Customer_AccountNumber (AccountNumber),
  KEY IX_Customer_TerritoryID (TerritoryID),
  KEY FK_Customer_Person_PersonID (PersonID),
  KEY FK_Customer_Store_StoreID (StoreID)) 
  ENGINE=INNODB AUTO_INCREMENT=30119 DEFAULT CHARSET=latin1 COMMENT='Current customer information. Also see the Person and Store tables.';

 DROP TABLE customersurvey;
CREATE TABLE customersurvey (
  customerid INT(11) NOT NULL DEFAULT '0' COMMENT 'Primary key.',
  Phone VARCHAR(20) CHARACTER SET latin1 DEFAULT NULL,
  MaritalStatus CHAR(1) CHARACTER SET latin1 DEFAULT NULL,
  Suffix VARCHAR(10) CHARACTER SET latin1 DEFAULT NULL,
  Gender VARCHAR(1) CHARACTER SET latin1 DEFAULT NULL,
  YearlyIncome DECIMAL(19,4) DEFAULT NULL,
  TotalChildren TINYINT(3) UNSIGNED DEFAULT NULL,
  NumberChildrenAtHome TINYINT(3) UNSIGNED DEFAULT NULL,
  EnglishEducation VARCHAR(40) CHARACTER SET latin1 DEFAULT NULL,
  SpanishEducation VARCHAR(40) CHARACTER SET latin1 DEFAULT NULL,
  FrenchEducation VARCHAR(40) CHARACTER SET latin1 DEFAULT NULL,
  EnglishOccupation VARCHAR(100) CHARACTER SET latin1 DEFAULT NULL,
  SpanishOccupation VARCHAR(100) CHARACTER SET latin1 DEFAULT NULL,
  FrenchOccupation VARCHAR(100) CHARACTER SET latin1 DEFAULT NULL,
  DateFirstPurchase DATE DEFAULT NULL,
  HouseOwnerFlag CHAR(1) CHARACTER SET latin1 DEFAULT NULL,
  NumberCarsOwned TINYINT(3) UNSIGNED DEFAULT NULL,
  CommuteDistance VARCHAR(15) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (customerid))
  ENGINE=INNODB DEFAULT CHARSET=utf8;

  
DROP TABLE emailaddress;
CREATE TABLE emailaddress (
  BusinessEntityID INT(11) NOT NULL COMMENT 'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID',
  EmailAddressID INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key. ID of this email address.',
  EmailAddress VARCHAR(50) DEFAULT NULL COMMENT 'E-mail address for the person.',
  rowguid VARCHAR(64) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (EmailAddressID,BusinessEntityID),
  UNIQUE KEY rowguid (rowguid),
  KEY IX_EmailAddress_EmailAddress (EmailAddress),
  KEY FK_EmailAddress_Person_BusinessEntityID (BusinessEntityID))
  ENGINE=INNODB AUTO_INCREMENT=19973 DEFAULT CHARSET=latin1 COMMENT='Where to send a person email.';

 DROP TABLE person;
CREATE TABLE person (
  BusinessEntityID INT(11) NOT NULL COMMENT 'Primary key for Person records.',
  PersonType CHAR(2) NOT NULL COMMENT 'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact',
  NameStyle TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.',
  Title VARCHAR(8) DEFAULT NULL COMMENT 'A courtesy title. For example, Mr. or Ms.',
  FirstName VARCHAR(100) NOT NULL COMMENT 'First name of the person.',
  MiddleName VARCHAR(100) DEFAULT NULL COMMENT 'Middle name or middle initial of the person.',
  LastName VARCHAR(100) NOT NULL COMMENT 'Last name of the person.',
  Suffix VARCHAR(10) DEFAULT NULL COMMENT 'Surname suffix. For example, Sr. or Jr.',
  EmailPromotion INT(11) NOT NULL DEFAULT '0' COMMENT '0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. ',
  AdditionalContactInfo TEXT COMMENT 'Additional contact information about the person stored in xml format. ',
  Demographics TEXT COMMENT 'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.',
  rowguid VARCHAR(64) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (BusinessEntityID),
  UNIQUE KEY rowguid (rowguid),
  UNIQUE KEY AK_Person_rowguid (rowguid),
  KEY IX_Person_LastName_FirstName_MiddleName (LastName,FirstName,MiddleName),
  KEY PXML_Person_AddContact (AdditionalContactInfo(255)),
  KEY PXML_Person_Demographics (Demographics(255)),
  KEY XMLPATH_Person_Demographics (Demographics(255)),
  KEY XMLPROPERTY_Person_Demographics (Demographics(255)),
  KEY XMLVALUE_Person_Demographics (Demographics(255))) 
  ENGINE=INNODB DEFAULT CHARSET=latin1 COMMENT='Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.';

DROP TABLE personphone;
CREATE TABLE personphone (
  BusinessEntityID INT(11) NOT NULL COMMENT 'Business entity identification number. Foreign key to Person.BusinessEntityID.',
  PhoneNumber VARCHAR(50) NOT NULL COMMENT 'Telephone number identification number.',
  PhoneNumberTypeID INT(11) NOT NULL COMMENT 'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (BusinessEntityID,PhoneNumber,PhoneNumberTypeID),
  KEY IX_PersonPhone_PhoneNumber (PhoneNumber),
  KEY FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID (PhoneNumberTypeID))
  ENGINE=INNODB DEFAULT CHARSET=latin1 COMMENT='Telephone number and type of a person.';

DROP TABLE salesterritory;
 CREATE TABLE salesterritory (
  TerritoryID INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key for SalesTerritory records.',
  NAME VARCHAR(100) NOT NULL COMMENT 'Sales territory description',
  CountryRegionCode VARCHAR(3) NOT NULL COMMENT 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ',
  `Group` VARCHAR(50) NOT NULL COMMENT 'Geographic area to which the sales territory belong.',
  SalesYTD DECIMAL(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Sales in the territory year to date.',
  SalesLastYear DECIMAL(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Sales in the territory the previous year.',
  CostYTD DECIMAL(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Business costs in the territory year to date.',
  CostLastYear DECIMAL(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Business costs in the territory the previous year.',
  rowguid VARCHAR(64) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (TerritoryID),
  UNIQUE KEY rowguid (rowguid),
  UNIQUE KEY AK_SalesTerritory_Name (NAME),
  UNIQUE KEY AK_SalesTerritory_rowguid (rowguid),
  KEY FK_SalesTerritory_CountryRegion_CountryRegionCode (CountryRegionCode))
  ENGINE=INNODB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='Sales territory lookup table.';

DROP TABLE stateprovince;
  CREATE TABLE stateprovince (
  StateProvinceID INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key for StateProvince records.',
  StateProvinceCode CHAR(3) NOT NULL COMMENT 'ISO standard state or province code.',
  CountryRegionCode VARCHAR(3) NOT NULL COMMENT 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ',
  IsOnlyStateProvinceFlag TINYINT(1) NOT NULL DEFAULT '1' COMMENT '0 = StateProvinceCode exists. 1 = StateProvinceCode unavailable, using CountryRegionCode.',
  NAME VARCHAR(100) NOT NULL COMMENT 'State or province description.',
  TerritoryID INT(11) NOT NULL COMMENT 'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.',
  rowguid VARCHAR(64) NOT NULL COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
  ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (StateProvinceID),
  UNIQUE KEY rowguid (rowguid),
  UNIQUE KEY AK_StateProvince_Name (NAME),
  UNIQUE KEY AK_StateProvince_StateProvinceCode_CountryRegionCode (StateProvinceCode,CountryRegionCode),
  UNIQUE KEY AK_StateProvince_rowguid (rowguid),
  KEY FK_StateProvince_CountryRegion_CountryRegionCode (CountryRegionCode),
  KEY FK_StateProvince_SalesTerritory_TerritoryID (TerritoryID))
  ENGINE=INNODB AUTO_INCREMENT=182 DEFAULT CHARSET=latin1 COMMENT='State and province lookup table.';