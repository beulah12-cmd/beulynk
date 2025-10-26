#!/usr/bin/env python3
"""
BEULYNK Backend API Verification Script
Tests all API endpoints to ensure they're working correctly
"""

import requests
import json

BASE_URL = "https://beulynk-backend.onrender.com"

def test_endpoint(name, url, method="GET", data=None, headers=None):
    """Test an API endpoint"""
    try:
        if method == "GET":
            response = requests.get(url, headers=headers)
        elif method == "POST":
            response = requests.post(url, json=data, headers=headers)
        else:
            response = requests.request(method, url, json=data, headers=headers)
        
        status_code = response.status_code
        is_success = 200 <= status_code < 300
        
        print(f"\n{'=' * 60}")
        print(f"Testing: {name}")
        print(f"URL: {url}")
        print(f"Status Code: {status_code}")
        
        if is_success:
            print(f"✅ PASSED")
            if response.text:
                try:
                    data = response.json()
                    print(f"Response: {json.dumps(data, indent=2)[:200]}")
                except:
                    print(f"Response: {response.text[:200]}")
        else:
            print(f"❌ FAILED")
            print(f"Response: {response.text[:200]}")
        
        return is_success, status_code
    
    except Exception as e:
        print(f"❌ ERROR: {str(e)}")
        return False, 0

def main():
    print("🚀 Starting BEULYNK Backend API Verification")
    print(f"Base URL: {BASE_URL}")
    
    results = []
    
    # Test 1: NGO Info endpoint
    success, code = test_endpoint(
        "NGO Information",
        f"{BASE_URL}/api/ngo-info/"
    )
    results.append(("NGO Info", success, code))
    
    # Test 2: Auth register endpoint
    success, code = test_endpoint(
        "Auth Register (Test)",
        f"{BASE_URL}/api/auth/register/",
        method="POST",
        data={
            "username": "testuser",
            "email": "test@test.com",
            "password": "testpass123",
            "confirm_password": "testpass123",
            "role": "volunteer"
        }
    )
    results.append(("Register Endpoint", success, code))
    
    # Test 3: Auth login endpoint (should fail without creds, but endpoint exists)
    success, code = test_endpoint(
        "Auth Login Endpoint",
        f"{BASE_URL}/api/auth/login/",
        method="POST",
        data={"username": "test", "password": "test"}
    )
    results.append(("Login Endpoint", success or code == 401, code))
    
    # Test 4: Contact endpoint
    success, code = test_endpoint(
        "Contact Message",
        f"{BASE_URL}/api/contact/",
        method="POST",
        data={
            "name": "Test User",
            "email": "test@test.com",
            "message": "Test message"
        }
    )
    results.append(("Contact Endpoint", success, code))
    
    # Print Summary
    print("\n" + "=" * 60)
    print("VERIFICATION SUMMARY")
    print("=" * 60)
    
    for name, success, code in results:
        status = "✅ PASS" if success else "❌ FAIL"
        print(f"{status} - {name} ({code})")
    
    total = len(results)
    passed = sum(1 for _, success, _ in results if success)
    
    print(f"\nTotal: {total}")
    print(f"Passed: {passed}")
    print(f"Failed: {total - passed}")

if __name__ == "__main__":
    main()

