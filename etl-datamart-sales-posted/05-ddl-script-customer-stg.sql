DROP TABLE IF EXISTS stage_db.customer_stg;
CREATE TABLE stage_db.customer_stg (
  customer_id int(11) NOT NULL COMMENT 'Primary key for Person records.',
  title varchar(8) DEFAULT NULL COMMENT 'A courtesy title. For example, Mr. or Ms.',
  first_name varchar(100) NOT NULL COMMENT 'First name of the person.',
  middle_name varchar(100) DEFAULT NULL COMMENT 'Middle name or middle initial of the person.',
  last_name varchar(100) NOT NULL COMMENT 'Last name of the person.',
  email_address varchar(50) DEFAULT NULL,
  home_address_line1 varchar(120) DEFAULT NULL,
  home_address_line2 varchar(120) DEFAULT NULL,
  home_address_city varchar(30) NOT NULL COMMENT 'Name of the city.',
  home_address_state varchar(100) NOT NULL COMMENT 'State or province description.',
  home_address_country varchar(100) NOT NULL COMMENT 'Country or region name.',
  regional_group varchar(50) NOT NULL COMMENT 'Geographic area to which the sales territory belong.',
  cell_phone_number varchar(50) DEFAULT NULL COMMENT 'Telephone number identification number.',
  contact_phone_number varchar(20) DEFAULT NULL,
  marital_status char(1) DEFAULT NULL,
  suffix varchar(10) DEFAULT NULL,
  gender varchar(1) DEFAULT NULL,
  yearly_income decimal(19,4) DEFAULT NULL,
  total_children tinyint(3) unsigned DEFAULT NULL,
  number_children_athome tinyint(3) unsigned DEFAULT NULL,
  houseowner_flag char(1) DEFAULT NULL,
  number_cars_owned tinyint(3) unsigned DEFAULT NULL,
  commute_distance varchar(15) DEFAULT NULL,
  modified_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date and time the record was last updated.',
  PRIMARY KEY (customer_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;