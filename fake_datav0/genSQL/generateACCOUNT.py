import json
import re

def write_sql(account_file, person_file):
    accountE = json.load(open(account_file))
    e = json.load(open(person_file))
    
    file_sql = "{}_I.sql".format(re.sub('.json','',account_file))
    save_path = "INSERT_COMMAND/"
    
    f = open(save_path + file_sql, 'w')
    f.write("USE DRIVER_SERVICE;\n\n")
    
    f.write("INSERT INTO ACCOUNT(ID,ATYPE,UNAME,PASS,SSN) VALUES\n")
    
    for key,value in accountE.items():
        try:
            insert_query = "\t({},'{}','{}','{}',{})".format(accountE[key]["ID"],accountE[key]["TYPE"],accountE[key]["USERNAME"],accountE[key]["PASSWORD"],e[key]["SSN"])
            f.write(insert_query)
            if key != "9":
                f.write(",\n")
            else:
                f.write(";")
        except:
            continue

if __name__ == "__main__":
    write_sql('account_EMPLOYEE.json','employee.json')
    write_sql('account_CUSTOMER_RECEIVE.json','customer_receive.json')
    write_sql('account_CUSTOMER_SEND.json','customer_send.json')
    write_sql('account_DRIVER.json','driver.json')