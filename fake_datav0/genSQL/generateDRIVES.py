import json
import re
 
# CREATE TABLE DRIVES(
#         SSN NUMERIC(9) NOT NULL REFERENCES DRIVER(SSN),
#         VNUM VARCHAR(10) NOT NULL REFERENCES VEHICLE(VNUM),
#         PRIMARY KEY (SSN, VNUM)
#     ); 
 
vehicle = json.load(open("vehicle.json"))
driver = json.load(open("driver.json"))

f = open("INSERT_COMMAND/drives_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")
f.write("INSERT INTO DRIVES(SSN,VNUM) VALUES\n")

ssn = [driver[key]["SSN"] for key in driver.keys()]
vnum = [vehicle[key]["V_NUMBER"] for key in vehicle.keys()]

print(len(ssn))
print(len(vnum))
i_ssn = 0
i_vnum = 0
segment_ssn = 2
segment_vnum = 4
while i_ssn < len(ssn):
    for i in range(i_ssn,i_ssn + segment_ssn):
        for j in range(i_vnum,i_vnum + segment_vnum):
            insert_query = "\t({},'{}'),\n".format(ssn[i],vnum[j])
            f.write(insert_query)
    i_ssn += segment_ssn
    i_vnum += segment_vnum

# for key in vehicle.keys():
#     try:
#         insert_query = "\t('{}','{}','{}')".format(vehicle[key]["V_NUMBER"],vehicle[key]["RE-NUMBER"],vehicle[key]["TYPE"])
#         f.write(insert_query)
#         if key == "19":
#             f.write(';')
#         else:
#             f.write(",\n")
#     except:
#         continue