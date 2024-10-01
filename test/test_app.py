import pytest
from app import app  # Assuming your Flask app is in app.py

# This is a pytest fixture that sets up the test client for the Flask app
@pytest.fixture
def client():
    app.config['TESTING'] = True  # Set testing mode
    with app.test_client() as client:
        yield client

# Test for the home page (assuming the route is '/')
def test_homepage(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, World!" in response.data  # Check if "Hello, World!" is in the response
