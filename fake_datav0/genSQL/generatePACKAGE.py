import json
import re

print(open("Pkg.json"))

package = json.load(open("Pkg.json"))
reDelivery = json.load(open('reDelivery.json'))
order = json.load(open('order.json'))
driver = json.load(open('driver.json'))

num_order = [1] * 5 + [2] * 10
i_order = 0
time_order = 0

i_reDelivery = 0 
time_Delivery = 0

num_driver = [2] * 5 + [3] * 5
i_driver = 0
time_driver = 0

f = open("INSERT_COMMAND/PACKAGE_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")
f.write("INSERT INTO PACKAGE(PID,PWEIGHT,TNAME,TLEVEL,ORDERID,SSN,TIME,LOCATION) VALUES\n")

for key in package.keys():
    pid = package[key]["PACKAGE_ID"]
    pweight = package[key]["WEIGHT"]
    typename = package[key]["TYPE_NAME"]
    typelevel = package[key]["TYPE_LEVEL"]
    orderid = order[str(i_order)]["ORDER_ID"]
    driver_ssn = driver[str(i_driver)]["SSN"]
    time = reDelivery[str(i_reDelivery)]["TIME"]
    location = reDelivery[str(i_reDelivery)]["LOCATION"]
    
    insert_query = "\t({},'{}',{},{},{},{},'{}','{}'),\n".format(pid,pweight,typename,typelevel,orderid,driver_ssn,time,location)
    f.write(insert_query)

    time_driver += 1
    if time_driver == num_driver[i_driver]:
        time_driver = 0
        i_driver += 1
    
    time_order += 1
    if time_order == num_order[i_order]:
        time_order = 0
        i_order += 1
        
    time_Delivery += 1
    if time_Delivery == 5:
        time_Delivery = 0
        i_reDelivery += 1
    