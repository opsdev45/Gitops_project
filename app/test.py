import pytest
import requests


def test_runner():
    """Get request to check if the site available"""
    
    response = requests.request("GET", f"http://localhost:8000/") # change the url to alb
    assert response.status_code == 200

if __name__ == "__main__":
    print("Test python available")
    test_runner()
    