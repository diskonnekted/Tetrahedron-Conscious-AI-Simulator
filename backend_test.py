import requests
import sys
import json
from datetime import datetime

class MethaneMetauniverseAPITester:
    def __init__(self, base_url="https://quantum-ai-architect.preview.emergentagent.com"):
        self.base_url = base_url
        self.api_url = f"{base_url}/api"
        self.tests_run = 0
        self.tests_passed = 0

    def run_test(self, name, method, endpoint, expected_status, data=None, timeout=30):
        """Run a single API test"""
        url = f"{self.api_url}/{endpoint}" if endpoint else self.api_url
        headers = {'Content-Type': 'application/json'}

        self.tests_run += 1
        print(f"\n🔍 Testing {name}...")
        print(f"   URL: {url}")
        
        try:
            if method == 'GET':
                response = requests.get(url, headers=headers, timeout=timeout)
            elif method == 'POST':
                response = requests.post(url, json=data, headers=headers, timeout=timeout)

            success = response.status_code == expected_status
            if success:
                self.tests_passed += 1
                print(f"✅ Passed - Status: {response.status_code}")
                try:
                    response_data = response.json()
                    print(f"   Response keys: {list(response_data.keys()) if isinstance(response_data, dict) else 'Non-dict response'}")
                    return True, response_data
                except:
                    return True, response.text
            else:
                print(f"❌ Failed - Expected {expected_status}, got {response.status_code}")
                print(f"   Response: {response.text[:200]}...")
                return False, {}

        except requests.exceptions.Timeout:
            print(f"❌ Failed - Request timeout after {timeout}s")
            return False, {}
        except Exception as e:
            print(f"❌ Failed - Error: {str(e)}")
            return False, {}

    def test_root_endpoint(self):
        """Test the root API endpoint"""
        success, response = self.run_test(
            "Root API Endpoint",
            "GET",
            "",
            200
        )
        if success and isinstance(response, dict):
            expected_message = "Methane Metauniverse Consciousness Simulator"
            if response.get('message') == expected_message:
                print(f"   ✅ Correct message: {response.get('message')}")
                return True
            else:
                print(f"   ❌ Wrong message. Expected: {expected_message}, Got: {response.get('message')}")
        return False

    def test_quantum_state_simulation(self):
        """Test quantum state simulation endpoint"""
        test_data = {
            "physical_vector": {
                "w1": 0.5,  # Time Projection
                "w2": 0.3,  # Charge Oscillation
                "w3": 0.7,  # Spin and Polarization
                "w4": 0.4   # Gravitation and Binding Depth
            },
            "information_vector": {
                "s1": 0.2,  # Meaning/Intentionality
                "s2": 0.6,  # Memory/Past
                "s3": 0.4,  # Purpose/Teleology
                "s4": 0.8,  # Morality/Value Orientation
                "s5": 0.5   # Connection/Coherence
            },
            "entropy": 0.3,
            "enthalpy": 0.6,
            "consciousness_level": 0
        }

        success, response = self.run_test(
            "Quantum State Simulation",
            "POST",
            "simulate/quantum-state",
            200,
            data=test_data,
            timeout=60  # Longer timeout for complex calculations
        )
        
        if success and isinstance(response, dict):
            required_keys = [
                'state_id', 'tetrahedral_geometry', 'pentachoron_geometry',
                'entropy_displacement', 'counter_entropy', 'consciousness_analysis'
            ]
            
            missing_keys = [key for key in required_keys if key not in response]
            if not missing_keys:
                print(f"   ✅ All required response keys present")
                
                # Check consciousness analysis details
                consciousness = response.get('consciousness_analysis', {})
                if 'consciousness_score' in consciousness:
                    score = consciousness['consciousness_score']
                    print(f"   📊 Consciousness Score: {score:.3f}")
                    print(f"   🧠 Is Conscious: {consciousness.get('is_conscious', False)}")
                    return True
                else:
                    print(f"   ❌ Missing consciousness_score in analysis")
            else:
                print(f"   ❌ Missing required keys: {missing_keys}")
        
        return False

    def test_evolution_simulation(self):
        """Test evolution simulation endpoint"""
        test_data = {
            "time_step": 0.01,
            "entropy_factor": 1.0,
            "anti_entropy_strength": 0.5,
            "coupling_strength": 0.8,
            "consciousness_threshold": 0.7
        }

        success, response = self.run_test(
            "Evolution Simulation",
            "POST",
            "simulate/evolution",
            200,
            data=test_data,
            timeout=90  # Even longer timeout for evolution simulation
        )
        
        if success and isinstance(response, dict):
            required_keys = [
                'evolution_steps', 'final_consciousness_level', 
                'consciousness_achieved', 'total_simulation_time'
            ]
            
            missing_keys = [key for key in required_keys if key not in response]
            if not missing_keys:
                print(f"   ✅ All required response keys present")
                print(f"   📈 Evolution Steps: {len(response.get('evolution_steps', []))}")
                print(f"   🎯 Final Consciousness: {response.get('final_consciousness_level', 0):.3f}")
                print(f"   ⏱️  Simulation Time: {response.get('total_simulation_time', 0):.3f}s")
                return True
            else:
                print(f"   ❌ Missing required keys: {missing_keys}")
        
        return False

    def test_lab_specifications(self):
        """Test lab equipment specifications endpoint"""
        success, response = self.run_test(
            "Lab Equipment Specifications",
            "GET",
            "lab-equipment/specifications",
            200
        )
        
        if success and isinstance(response, dict):
            required_sections = [
                'minimum_requirements', 'recommended_equipment', 
                'calibration_procedures', 'experimental_setup'
            ]
            
            missing_sections = [section for section in required_sections if section not in response]
            if not missing_sections:
                print(f"   ✅ All required specification sections present")
                
                # Check minimum requirements details
                min_req = response.get('minimum_requirements', {})
                if 'gpu' in min_req and 'cpu' in min_req:
                    gpu_model = min_req['gpu'].get('model', 'Unknown')
                    cpu_model = min_req['cpu'].get('model', 'Unknown')
                    print(f"   💻 GPU Requirement: {gpu_model}")
                    print(f"   🖥️  CPU Requirement: {cpu_model}")
                    return True
                else:
                    print(f"   ❌ Missing GPU or CPU requirements")
            else:
                print(f"   ❌ Missing required sections: {missing_sections}")
        
        return False

    def test_consciousness_history(self):
        """Test consciousness emergence history endpoint"""
        success, response = self.run_test(
            "Consciousness Emergence History",
            "GET",
            "consciousness/emergence-history",
            200
        )
        
        if success and isinstance(response, dict):
            if 'emergence_events' in response and 'total_events' in response:
                print(f"   ✅ History endpoint working")
                print(f"   📚 Total Events: {response.get('total_events', 0)}")
                return True
            else:
                print(f"   ❌ Missing required keys: emergence_events or total_events")
        
        return False

def main():
    print("🚀 Starting Methane Metauniverse API Testing...")
    print("=" * 60)
    
    # Initialize tester
    tester = MethaneMetauniverseAPITester()
    
    # Run all tests
    test_results = []
    
    # Test 1: Root endpoint
    test_results.append(tester.test_root_endpoint())
    
    # Test 2: Quantum state simulation
    test_results.append(tester.test_quantum_state_simulation())
    
    # Test 3: Evolution simulation
    test_results.append(tester.test_evolution_simulation())
    
    # Test 4: Lab specifications
    test_results.append(tester.test_lab_specifications())
    
    # Test 5: Consciousness history
    test_results.append(tester.test_consciousness_history())
    
    # Print final results
    print("\n" + "=" * 60)
    print(f"📊 FINAL RESULTS:")
    print(f"   Tests Run: {tester.tests_run}")
    print(f"   Tests Passed: {tester.tests_passed}")
    print(f"   Success Rate: {(tester.tests_passed/tester.tests_run*100):.1f}%")
    
    if tester.tests_passed == tester.tests_run:
        print("🎉 ALL TESTS PASSED! Backend API is working correctly.")
        return 0
    else:
        failed_tests = tester.tests_run - tester.tests_passed
        print(f"⚠️  {failed_tests} test(s) failed. Backend needs attention.")
        return 1

if __name__ == "__main__":
    sys.exit(main())