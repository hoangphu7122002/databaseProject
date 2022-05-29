# CREATE TABLE PERSON_MAIL(
#         SSN NUMERIC(9) NOT NULL REFERENCES PERSON(SSN),
#         MAIL    VARCHAR,
#         PRIMARY KEY (SSN,MAIL)
#     );

# "1": {
#         "NAME": "Miss Christine Morgan",
#         "SSN": "658299807",
#         "PHONE": [
#             "0661154933",
#             "0756147811"
#         ],
#         "GMAIL": [
#             "bradley34@gmail.com",
#             "fosterroberto@hotmail.com"
#         ],
#         "SERVICE": "DISCOUNT"
#     },

import json
import re
import random

files = ["customer_send.json","customer_receive.json","employee.json","driver.json"]
f = open("INSERT_COMMAND/PERSON_MAIL_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")

for i,file in enumerate(files):
    person = json.load(open(file))
    if i == 0:
        f.write("INSERT INTO PERSON_MAIL(SSN,MAIL) VALUES\n")
    
    for key in person.keys():
        try:
            for j,mail in enumerate(person[key]["GMAIL"]):
                insert_query = "\t({},'{}')".format(person[key]["SSN"],mail)
                f.write(insert_query)
                if key == "9" and i == len(files) - 1 and j == len(person[key]["GMAIL"]) - 1:
                    f.write(';')
                else:
                    f.write(",\n")
        except:
            continue
