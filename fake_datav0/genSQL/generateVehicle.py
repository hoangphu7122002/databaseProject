import json
import re
 
vehicle = json.load(open("vehicle.json"))

f = open("INSERT_COMMAND/vehicle_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")
f.write("INSERT INTO VEHICLE(VNUM,RNUM,VTYPE) VALUES\n")

for key in vehicle.keys():
    try:
        insert_query = "\t('{}','{}','{}')".format(vehicle[key]["V_NUMBER"],vehicle[key]["RE-NUMBER"],vehicle[key]["TYPE"])
        f.write(insert_query)
        if key == "19":
            f.write(';')
        else:
            f.write(",\n")
    except:
        continue