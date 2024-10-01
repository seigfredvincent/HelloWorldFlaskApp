import pytest
from app import app

@pytest.fixture
def client():
    # Set up a test client for the Flask app
    with app.test_client() as client:
        yield client

def test_hello_world(client):
    # Send a GET request to the root URL
    response = client.get('/')
    
    # Assert that the status code is 200 (OK)
    assert response.status_code == 200
    
    # Assert that the response data is 'Hello, World!'
    assert response.data == b'Hello, World!'
