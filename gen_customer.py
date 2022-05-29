import pandas as pd
import numpy as np
from faker import Faker
from faker.providers import DynamicProvider
import re
import string
import random
import json

def fake_phone_number(fake: Faker) -> str:
    return f'0{fake.msisdn()[4:]}'

gen_sex = DynamicProvider(
    provider_name = "sex",
    elements = ["MALE","FEMALE","ANOTHER"]
)

def fake_e_id(fake:Faker) -> str:
    return f'2010{fake.msisdn()[-3:]}'

fake = Faker('en_US')
fake.seed_instance(4321)
fake.add_provider(gen_sex)

dict_compact = {
    "CR" : "customer_receive",
    "CS" : "customer_send",
    "DR" : "driver",
    "EE" : "employee"
}

def get_some_location(num):
    return [re.sub('\n','/',fake.unique.address()) for _ in range(num)]

class Person(object):
    def __init__(self,num_customer,mode = "EE"):
        self.num_customer = num_customer
        self.mode = mode
        self.name = dict_compact[self.mode]
        
    def get_data(self):
        customer_data = dict()
        for i in range(self.num_customer):
            customer_data[i] = {}
            customer_data[i]["NAME"] = fake.unique.name()
            customer_data[i]["SSN"] = re.sub('-','',fake.unique.ssn())
            customer_data[i]["PHONE"] = [fake_phone_number(fake.unique) for _ in range(np.random.randint(1,3))]
            customer_data[i]["GMAIL"] = [fake.unique.free_email() for _ in range(np.random.randint(1,3))]
            if self.mode == "CR":
                customer_data[i]["ADDRESS"] = re.sub('\n','/',fake.unique.address())
            elif self.mode == "CS":
                lst_type = ["NORMAL","DISCOUNT","EXPRESS"]
                customer_data[i]["SERVICE"] = random.choice(lst_type)
            elif self.mode == "DR":
                customer_data[i]["LISENCE_ID"] = f"{fake.unique.msisdn()}"
                customer_data[i]["EXPERIENCE"] = np.random.randint(1,10)
            else:
                customer_data[i]["EXPERIENCE"] = f"{np.random.randint(1,4)}"
                customer_data[i]["E_ID"] =  fake_e_id(fake.unique)
                customer_data[i]["DATE_BEGIN"] = "{}".format(fake.past_date())
                customer_data[i]["RATING"] = np.random.randint(1,6)
        return customer_data
        
    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)

    
class Vehicle(object):
    def __init__(self,num_vehicle):
        self.num_vehicle = num_vehicle
        self.name = "vehicle"
        
    def get_data(self):
        vehicle_data = dict()
        for i in range(self.num_vehicle):
            vehicle_data[i] = dict()
            vehicle_data[i]["V_NUMBER"] = "{}{}{}/{}".format(fake.unique.msisdn()[-2:],random.choice(string.ascii_letters),np.random.randint(0,10),fake.unique.msisdn()[-5:])
            vehicle_data[i]["TYPE"] = random.choice(["CAR","TRUCK","BIKE"])
            vehicle_data[i]["RE-NUMBER"] = f"{fake.unique.msisdn()[:-5]}"
        return vehicle_data
    
    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)

class Account(object):
    def __init__(self,num_account,mode,type=None):
        self.num_account = num_account
        if type is None:
            self.name = "account_{}".format(mode)
        else:
            self.name = "account_{}_{}".format(mode,type)
        self.mode = mode
            
    def get_data(self):
        account_data =  dict()
        for i in range(self.num_account):
            account_data[i] = {}
            account_data[i]["TYPE"] = self.mode
            if account_data[i]["TYPE"] == "CUSTOMER":
                account_data[i]["USERNAME"] = "{}_CR@test.com".format(fake.unique.msisdn()[:10])
            elif account_data[i]["TYPE"] == "EMPLOYEE":
                account_data[i]["USERNAME"] = "{}_EE@test.com".format(fake.unique.msisdn()[:10])
            else:
                account_data[i]["USERNAME"] = "{}_DR@test.com".format(fake.unique.msisdn()[:10])
            account_data[i]["PASSWORD"] = "{}".format(fake.msisdn()[:10])
            account_data[i]["ID"] = f"{fake.unique.msisdn()[:10]}"
        account_data[self.num_account] = {"TYPE":"EMPLOYEE",
                                           "USERNAME":"admin@test.com",
                                           "PASSWORD":"01234",
                                            "ID" : "0"}
        return account_data
    
    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)
    
class AlternateReceiver(object):
    def __init__(self,num_alternate):
        self.num_alternate = num_alternate
        self.name = "alternateReceiver"
        
    def get_data(self):
        alternate_data = dict()
        for i in range(self.num_alternate):
            alternate_data[i] = dict()
            alternate_data[i]["RELATIONSHIP"] = random.choice(["FAMILY","FRIEND"])
            alternate_data[i]["PHONE"] = [fake_phone_number(fake.unique) for _ in range(np.random.randint(1,3))]
            alternate_data[i]["NAME"] = fake.unique.name()
            alternate_data[i]["GMAIL"] = [fake.unique.free_email() for _ in range(np.random.randint(1,3))]
            
        return alternate_data

    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)

class Order(object):
    def __init__(self,num_order):
        self.num_order = num_order
        self.name = "order"
        
    def get_data(self):
        order_data = dict()
        for i in range(self.num_order):
            order_data[i] = dict()
            order_data[i]["ORDER_ID"] = "{}".format(fake.unique.msisdn()[:10])
            order_data[i]["ADDRESS_SEND"] = re.sub('\n','/',fake.unique.address())
            order_data[i]["ADDRESS_RECEIVE"] = ""
            
            num_package = np.random.randint(1,5)
            
            order_data[i]["NUM_PACKAGE"] = num_package
            order_data[i]["TOTAL WEIGHT"] = np.random.randint(3 * num_package,50 * num_package)
            order_data[i]["TOTAL_PRICE"] = ""
        return order_data 
    
    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)
        
class Package(object):
    def __init__(self,num_package):
        self.num_package = num_package
        self.name = "package_v0"

    def get_data(self):
        package_data = dict()
        for i in range(self.num_package):
            package_data[i] = {}
            package_data[i]["PACKAGE_ID"] = "{}".format(fake.unique.msisdn()[:9])
            package_data[i]["WEIGHT"] = np.random.randint(3,50)
            package_data[i]["TYPE_NAME"] = random.choice(["FRAGILE","NORMAL","HAZARD"])
            package_data[i]["TYPE_LEVEL"] = np.random.randint(1,5)
        return package_data
        
    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)
    
class RelationshipSend(object):
    def __init__(self,numSend):
        self.numSend = numSend
        self.name = "reSend"
    
    def get_data(self):
        send_data = dict()
        for i in range(self.numSend):
            send_data[i] = {}
            send_data[i]["PAYMENT_TYPE"] = random.choice(["BANK","MOMO","DIRECT"])
            send_data[i]["TIME"] = fake.date()
        return send_data
    
    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)
    
class RelationshipDelivery(object):
    def __init__(self,numDelivery):
        self.numDelivery = numDelivery
        self.name = "reDelivery"
        
    def get_data(self):
        send_data = dict()
        for i in range(self.numDelivery):
            send_data[i] = {}
            send_data[i]["PAYMENT_TYPE"] = random.choice(["BANK","MOMO","DIRECT"])
            send_data[i]["TIME"] = fake.date()
            send_data[i]["LOCATION"] = random.choice(get_some_location(10))
        return send_data
    
    def save_data(self):
        data = self.get_data()
        with open('{}.json'.format(self.name), 'w') as fp:
            json.dump(data, fp)
            
# if __name__ == '__main__':
#     #GEN CUSTOMER RECEIVE:
#     customer_receive = Person(10,"CR")
#     customer_receive.save_data()
    
#     #GEN CUSTOMER SEND
#     customer_send = Person(10,"CS")
#     customer_send.save_data()
    
#     #GEN EMPLOYEE
#     employee = Person(10,"EE")
#     employee.save_data()
    
#     #GEN DRIVER
#     driver = Person(10,"DR")
#     driver.save_data()

#     #GEN VEHICLE
#     vehicle = Vehicle(20)
#     vehicle.save_data()
    
#     #GEN ACCOUNT
#     account_1 = Account(20,"CUSTOMER")
#     account_2 = Account(10,"EMPLOYEE")
#     account_3 = Account(10,"DRIVER")
#     account_1.save_data()
#     account_2.save_data()
#     account_3.save_data()
    
#     #GEN AlternateReceiver
#     alternateReceiver = AlternateReceiver(20)
#     alternateReceiver.save_data()
    
#     #GEN Order
#     order = Order(15)
#     order.save_data()
    
#     #GEN PACKAGE
#     package = Package(25)
#     package.save_data()
    
#     #GEN RelationshipSend
#     relationshipSend = RelationshipSend(10)
#     relationshipSend.save_data()
    
#     #GEN RelationshipDelivery
#     relationShipDelivery = RelationshipDelivery(10)
#     relationShipDelivery.save_data()

if __name__ == "__main__":
    #GEN CUSTOMER SEND
    customer_send = Person(10,"CS")
    customer_send.save_data()