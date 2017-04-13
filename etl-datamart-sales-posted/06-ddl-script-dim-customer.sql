DROP TABLE IF EXISTS datamart_db.dim_customer;
CREATE TABLE datamart_db.dim_customer (
  customer_skey int(20) NOT NULL DEFAULT '0' COMMENT 'Surrogate Key',
  customer_id int(11) NOT NULL DEFAULT '0' COMMENT 'Primary key for Person records.',
  title varchar(8) DEFAULT NULL DEFAULT '-' COMMENT 'A courtesy title. For example, Mr. or Ms.',
  first_name varchar(100) NOT NULL DEFAULT '-' COMMENT 'First name of the person.',
  middle_name varchar(100) DEFAULT '-' COMMENT 'Middle name or middle initial of the person.',
  last_name varchar(100) NOT NULL DEFAULT '-' COMMENT 'Last name of the person.',
  email_address varchar(50) DEFAULT '-',
  home_address_line1 varchar(120) DEFAULT '-', /* renamed from address_line1 */
  home_address_line2 varchar(120) DEFAULT '-', /* renamed from address_line2 */
  home_address_city varchar(30) NOT NULL DEFAULT '-' COMMENT 'Name of the city.',
  home_address_state varchar(100) NOT NULL DEFAULT '-' COMMENT 'State or province description.',
  home_address_country varchar(100) NOT NULL DEFAULT '-' COMMENT 'Country or region name.',
  regional_group varchar(50) NOT NULL DEFAULT '-' COMMENT 'Geographic area to which the sales territory belong.',
  cell_phone_number varchar(50) DEFAULT '-' COMMENT 'Telephone number identification number.',
  contact_phone_number varchar(20) DEFAULT '-',
  marital_status char(1) DEFAULT '-',
  suffix varchar(10) DEFAULT '-',
  gender varchar(1) DEFAULT '-',
  yearly_income decimal(19,4) DEFAULT -1,
  total_children int(3) DEFAULT -1,
  number_children_athome int(3) DEFAULT -1,
  houseowner_flag char(1) DEFAULT '-',
  number_cars_owned tinyint(3) DEFAULT -1,
  commute_distance varchar(15) DEFAULT '-',
  modified_date datetime DEFAULT NULL COMMENT 'Date and time the record was last updated.',
  version bigint(20) DEFAULT NULL,
  date_from datetime DEFAULT NULL,
  date_to datetime DEFAULT NULL,
  PRIMARY KEY (customer_skey),
  UNIQUE KEY product_id (customer_id,date_from)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;