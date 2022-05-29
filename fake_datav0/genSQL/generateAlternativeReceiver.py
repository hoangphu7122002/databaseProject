import json
import re

# CREATE TABLE ALTERNATIVE_RECEIVER(
#         SSN NUMERIC(9) NOT NULL REFERENCES CUSTOMER_RECEIVE(SSN),
#         FNAME VARCHAR NOT NULL,
#       	PHONE 	NUMERIC(10),
#         RELATIONSHIP    VARCHAR,
#       	PRIMARY KEY (SSN,FNAME,PHONE)
#     );

# "19": {
#         "RELATIONSHIP": "FAMILY",
#         "PHONE": [
#             "0822863890",
#             "0941922012"
#         ],
#         "NAME": "Diana Dean",
#         "GMAIL": [
#             "annruiz@gmail.com",
#             "dgay@gmail.com"
#         ]
#     }
# }

alternateReceiver = json.load(open("alternateReceiver.json"))
customerReceiver = json.load(open("customer_receive.json"))

f = open("INSERT_COMMAND/alternateReceiver_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")
f.write("INSERT INTO ALTERNATIVE_RECEIVER(SSN,FNAME,PHONE,RELATIONSHIP) VALUES\n")

ssn = [customerReceiver[key]["SSN"] for key in customerReceiver.keys()]
i = 0
flag = False

for key in alternateReceiver.keys():
    try:
        insert_query = "\t({},'{}',{},'{}')".format(ssn[i],alternateReceiver[key]["NAME"].split(' ')[0],alternateReceiver[key]["PHONE"][0],alternateReceiver[key]["RELATIONSHIP"])
        f.write(insert_query)
        if key == "19":
            f.write(';')
        else:
            f.write(",\n")
        if flag == False:
            flag = True
        else:
            i += 1
            flag = False
    except:
        continue