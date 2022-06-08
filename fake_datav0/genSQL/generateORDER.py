# CREATE TABLE CORDER(
#         SSN_CR      NUMERIC(9) NOT NULL REFERENCES CUSTOMER_RECEIVE(SSN),
#         SSN_CS      NUMERIC(9) NOT NULL REFERENCES CUSTOMER_SEND(SSN),
#         SSN_EMP     NUMERIC(9) NOT NULL REFERENCES EMPLOYEE(SSN),
#         ORDERID 	NUMERIC(9) NOT NULL,
#         ADD_SEND    VARCHAR,
#         ADD_RECEIVE VARCHAR,
#         TWEIGHT     FLOAT(3),
#         NOPACKAGE   SMALLINT,
#         TPRICE      MONEY,
#         RATE        TINYINT,
#         PTYPE       VARCHAR,
#         OTIME       DATETIME,
#         PRIMARY KEY (ORDERID)
#     );

# "0": {
#         "ORDER_ID": "4096189409",
#         "ADDRESS_SEND": "USS Charles/FPO AE 97075",
#         "ADDRESS_RECEIVE": "",
#         "NUM_PACKAGE": 3,
#         "TOTAL WEIGHT": 23,
#         "TOTAL_PRICE": ""
#     },

# "0": {
#         "PAYMENT_TYPE": "DIRECT",
#         "TIME": "2017-03-25"
#     }

import json
import re
import random

customerReceiver = json.load(open("customer_receive.json"))
customerSend = json.load(open("customer_send.json"))
employee = json.load(open("employee.json"))
order = json.load(open("order.json"))
reSend = json.load(open("reSend.json"))

f = open("INSERT_COMMAND/ORDER_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")
f.write("INSERT INTO CORDER(SSN_CR,SSN_CS,SSN_EMP,ORDERID,ADD_SEND,ADD_RECEIVE,TWEIGHT,NOPACKAGE,TPRICE,RATE,PTYPE,OTIME) VALUES\n")

iterator = 0
num_order = [1] * 5 + [2] * 5
time = 0
for key in order.keys():
    ssn_cr = customerReceiver[str(iterator)]["SSN"]
    ssn_cs = customerSend[str(iterator)]["SSN"]
    ssn_emp = employee[str(iterator)]["SSN"]
    orderid = order[key]["ORDER_ID"]
    #add_sen = order[key]["ADDRESS_SEND"]
    #add_receive = customerReceiver[str(iterator)]["ADDRESS"]
    tweight = order[key]["TOTAL WEIGHT"]
    num_package = order[key]["NUM_PACKAGE"]
    tprice = 0
    rate = random.choice([1,2,3,4,5])
    ptype = reSend[str(iterator)]["PAYMENT_TYPE"]
    otime = reSend[str(iterator)]["TIME"]
    
    insert_query = "\t({},{},{},{},'{}','{}',{},{},{},{},'{}','{}'),\n".format(ssn_cr,ssn_cs,ssn_emp,orderid,add_sen,add_receive,tweight,num_package,tprice,rate,ptype,otime)
    f.write(insert_query)
    
    time += 1
    if time == num_order[iterator]:
        time = 0
        iterator += 1
    