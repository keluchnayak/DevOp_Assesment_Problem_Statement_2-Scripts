import requests

APP_URL = "https://www.thiswebsitedoesnotexist123.com"

def check_application_health(url):
    try:
        response = requests.get(url, timeout=5)
        
        if response.status_code == 200:
            print(f"? Application is UP. (Status Code: {response.status_code})")
        else:
            print(f"??  Application is DOWN. (Status Code: {response.status_code})")
            
    except requests.exceptions.RequestException as error:
        print(f"? Application is DOWN. (Error: {error})")

if __name__ == "__main__":
    print(f"Checking health of: {APP_URL}")
    check_application_health(APP_URL)
