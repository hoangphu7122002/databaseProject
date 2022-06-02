#  CREATE TABLE PERSON_PHONE(
#         SSN     NUMERIC(9) NOT NULL REFERENCES PERSON(SSN),
#         PHONE   NUMERIC(10),
#         PRIMARY KEY (SSN,PHONE)
#     );  

import json
import re
import random

files = ["customer_send.json","customer_receive.json","employee.json","driver.json"]
f = open("INSERT_COMMAND/PERSON_PHONE_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")

for i,file in enumerate(files):
    person = json.load(open(file))
    if i == 0:
        f.write("INSERT INTO PERSON_PHONE(SSN,PHONE) VALUES\n")
    
    for key in person.keys():
        try:
            for j,mail in enumerate(person[key]["PHONE"]):
                insert_query = "\t({},'{}')".format(person[key]["SSN"],mail)
                f.write(insert_query)
                if key == "9" and i == len(files) - 1 and j == len(person[key]["PHONE"]) - 1:
                    f.write(';')
                else:
                    f.write(",\n")
        except:
            continue