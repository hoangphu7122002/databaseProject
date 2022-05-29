import json
import re
import random

files = ["customer_send.json","customer_receive.json","employee.json","driver.json"]
f = open("INSERT_COMMAND/PERSON_I.sql",'w')
f.write("USE DRIVER_SERVICE;\n\n")

for i,file in enumerate(files):
    person = json.load(open(file))
    if i == 0:
        f.write("INSERT INTO PERSON(SSN,First_name,Last_name,Gender) VALUES\n")
    
    for key in person.keys():
        try:
            names = person[key]["NAME"].split(' ')
            gender = random.choice(["M","F"])
            insert_query = "\t({},'{}','{}','{}')".format(person[key]["SSN"],names[0],names[1],gender)
            f.write(insert_query)
            if key == "9" and i == len(files) - 1:
                f.write(';')
            else:
                f.write(",\n")
        except:
            continue
