/* ------------------------------
   -- CUSTOMER DENORMALIZATION --
   ------------------------------ */

SELECT p.businessentityid AS customer_id, p.title, p.firstname first_name, 
       p.middlename middle_name, p.lastname last_name,

       REPLACE(e.emailaddress, 'adventure-works.com', 'dummyemail.com') email_address,
       a.addressline1 address_line1, 
       a.addressline2 address_line2,        
       a.city AS home_address_city, 
       s.name AS home_address_state, 
       c.name AS home_address_country, st.group AS regional_group,
       pp.phonenumber AS cell_phone_number,
       cs.phone contact_phone_number,        
       cs.maritalstatus marital_status, 
       cs.suffix suffix, 
       cs.gender gender, 
       cs.yearlyincome yearly_income, 
       cs.totalchildren total_children, 
       cs.numberchildrenathome number_children_athome, 
       cs.houseownerflag houseowner_flag, 
       cs.numbercarsowned number_cars_owned, 
       cs.commutedistance commute_distance,
       p.modifieddate modified_date
  FROM oltp_hr.person p
  LEFT OUTER JOIN oltp_hr.personphone pp
    ON p.businessentityid = pp.businessentityid 
   AND pp.phonenumbertypeid = 1 /* Mobile Number */
       , oltp_hr.emailaddress e, oltp_hr.businessentityaddress pa
       , oltp_hr.address a
       , oltp_hr.stateprovince s, oltp_hr.countryregion c
       , oltp_hr.customer cu
       , oltp_hr.salesterritory st
       , oltp_hr.customersurvey cs
 WHERE p.persontype = 'in' /* Internet Sales */
   AND p.businessentityid = e.businessentityid
   AND p.businessentityid = pa.businessentityid
   AND pa.addressid = a.addressid
   AND a.stateprovinceid = s.stateprovinceid
   AND s.countryregioncode = c.countryregioncode
   AND p.businessentityid = cu.personid
   AND cu.territoryid = st.territoryid
   AND cu.customerid = cs.customerid
   AND pa.addresstypeid = 2; /* Home Address */
