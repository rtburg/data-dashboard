LOAD DATA LOCAL INFILE '/home/vaughn.hagerty/nc-voters/data/ncvoter50.txt' REPLACE INTO TABLE nc_voters_new
fields terminated by "\t" optionally enclosed by '"'
lines terminated by "\r\n"
ignore 1 lines
(@var1,@var2,@var3,@var4,@var5,@var6,@var7,@var8,@var9,@var10,@var11,@var12,@var13,@var14,@var15,@var16,@var17,@var18,@var19,@var20,@var21,@var22,@var23,@var24,@var25,@var26,@var27,@var28,@var29,@var30,@var31,@var32,@var33,@var34,@var35,@var36,@var37,@var38,@var39,@var40,@var41,@var42,@var43,@var44,@var45,@var46,@var47,@var48,@var49,@var50,@var51,@var52,@var53,@var54,@var55,@var56,@var57,@var58,@var59,@var60,@var61,@var62,@var63,@var64,@var65,@var66,@var67,@var68,@var69,@var70,@var71)
SET
county_id=trim(@var1),
county_desc=trim(@var2),
voter_reg_num=trim(@var3),
status_cd=trim(@var4),
voter_status_desc=trim(@var5),
reason_cd=trim(@var6),
voter_status_reason_desc=trim(@var7),
absent_ind=trim(@var8),
name_prefx_cd=trim(@var9),
last_name=trim(@var10),
first_name=trim(@var11),
midl_name=trim(@var12),
name_sufx_cd=trim(@var13),
res_street_address=trim(@var14),
res_city_desc=trim(@var15),
state_cd=trim(@var16),
zip_code=trim(@var17),
mail_addr1=trim(@var18),
mail_addr2=trim(@var19),
mail_addr3=trim(@var20),
mail_addr4=trim(@var21),
mail_city=trim(@var22),
mail_state=trim(@var23),
mail_zipcode=trim(@var24),
full_phone_number=trim(@var25),
race_code=trim(@var26),
ethnic_code=trim(@var27),
party_cd=trim(@var28),
gender_code=trim(@var29),
birth_age=trim(@var30),
birth_place=trim(@var31),
drivers_lic=trim(@var32),
registr_dt=str_to_date(@var33,'%m/%d/%Y'),
precinct_abbrv=trim(@var34),
precinct_desc=trim(@var35),
municipality_abbrv=trim(@var36),
municipality_desc=trim(@var37),
ward_abbrv=trim(@var38),
ward_desc=trim(@var39),
cong_dist_abbrv=trim(@var40),
super_court_abbrv=trim(@var41),
judic_dist_abbrv=trim(@var42),
nc_senate_abbrv=trim(@var43),
nc_house_abbrv=trim(@var44),
county_commiss_abbrv=trim(@var45),
county_commiss_desc=trim(@var46),
township_abbrv=trim(@var47),
township_desc=trim(@var48),
school_dist_abbrv=trim(@var49),
school_dist_desc=trim(@var50),
fire_dist_abbrv=trim(@var51),
fire_dist_desc=trim(@var52),
water_dist_abbrv=trim(@var53),
water_dist_desc=trim(@var54),
sewer_dist_abbrv=trim(@var55),
sewer_dist_desc=trim(@var56),
sanit_dist_abbrv=trim(@var57),
sanit_dist_desc=trim(@var58),
rescue_dist_abbrv=trim(@var59),
rescue_dist_desc=trim(@var60),
munic_dist_abbrv=trim(@var61),
munic_dist_desc=trim(@var62),
dist_1_abbrv=trim(@var63),
dist_1_desc=trim(@var64),
dist_2_abbrv=trim(@var65),
dist_2_desc=trim(@var66),
Confidential_ind=trim(@var67),
age=trim(@var68),
ncid=trim(@var69),
vtd_abbrv=trim(@var70),
vtd_desc=trim(@var71);
