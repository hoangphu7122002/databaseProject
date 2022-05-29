import json
import re
import random

def write_sql(person_file):
    per = json.load(open(person_file))
    
    file_sql = "{}_I.sql".format(re.sub('.json','',person_file))
    save_path = "INSERT_COMMAND/"
    
    f = open(save_path + file_sql, 'w')
    f.write("USE DRIVER_SERVICE;\n\n")
    
    
    extension = person_file.split('.')[0]
    if extension == "employee":
        ssn = [per[key]["SSN"] for key in per.keys()]
        random.shuffle(ssn)
        supper_ssn = ssn[:3]
    for key in per.keys():
        # try:
            if extension == "driver":
                if key == "0":
                    f.write("INSERT INTO DRIVER(SSN,LISENCE_ID,EXP) VALUES\n")
                insert_query = "\t({},'{}',{})".format(per[key]["SSN"],per[key]["LISENCE_ID"][:9],per[key]["EXPERIENCE"])
            elif extension == "employee":
                if key == "0":
                    f.write("INSERT INTO EMPLOYEE(SSN,E_ID,DATE_BEGIN,EXPERIENCE,SUPSSN) VALUES\n")
                super = random.choice(supper_ssn)
                prob = random.choice([0,1])
                if per[key]["SSN"] == super or prob == 0:
                    insert_query = "\t({},{},'{}',{},NULL)".format(per[key]["SSN"],per[key]["E_ID"],per[key]["DATE_BEGIN"],per[key]["EXPERIENCE"])
                else:
                    insert_query = "\t({},{},'{}',{},{})".format(per[key]["SSN"],per[key]["E_ID"],per[key]["DATE_BEGIN"],per[key]["EXPERIENCE"],super)
            elif extension == "customer_receive":
                if key == "0":
                    f.write("INSERT INTO CUSTOMER_RECEIVE(SSN,ADDR) VALUES\n")
                insert_query = "\t({},'{}')".format(per[key]["SSN"],per[key]["ADDRESS"])
            elif extension == "customer_send":
                if key == "0":
                    f.write("INSERT INTO CUSTOMER_SEND(SSN,SERV) VALUES\n")
                insert_query = "\t({},'{}')".format(per[key]["SSN"],per[key]["SERVICE"])
            f.write(insert_query)
            if key != "9":
                f.write(",\n")
            else:
                f.write(";")
        # except:
        #     continue

# write_sql("driver.json")
write_sql("employee.json")
# write_sql("customer_receive.json")
# write_sql("customer_send.json")