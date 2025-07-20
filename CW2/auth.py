import requests

def verify_user(email: str, password: str) -> bool:
    auth_url = "https://web.socem.plymouth.ac.uk/COMP2001/auth/api/users"
    response = requests.post(auth_url, json={"email": email, "password": password})
    return response.status_code == 200