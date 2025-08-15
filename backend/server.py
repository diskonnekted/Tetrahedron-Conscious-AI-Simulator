from fastapi import FastAPI, APIRouter, HTTPException
from dotenv import load_dotenv
from starlette.middleware.cors import CORSMiddleware
from motor.motor_asyncio import AsyncIOMotorClient
import os
import logging
import numpy as np
import math
from pathlib import Path
from pydantic import BaseModel, Field
from typing import List, Dict, Optional
import uuid
from datetime import datetime


ROOT_DIR = Path(__file__).parent
load_dotenv(ROOT_DIR / '.env')

# MongoDB connection
mongo_url = os.environ['MONGO_URL']
client = AsyncIOMotorClient(mongo_url)
db = client[os.environ['DB_NAME']]

# Create the main app without a prefix
app = FastAPI()

# Create a router with the /api prefix
api_router = APIRouter(prefix="/api")


# Mathematical Models for Methane Metauniverse
class Vector4D(BaseModel):
    w1: float = Field(description="Time Projection")
    w2: float = Field(description="Charge Oscillation") 
    w3: float = Field(description="Spin and Polarization")
    w4: float = Field(description="Gravitation and Binding Depth")

class Vector5D(BaseModel):
    s1: float = Field(description="Meaning/Intentionality")
    s2: float = Field(description="Memory/Past")
    s3: float = Field(description="Purpose/Teleology") 
    s4: float = Field(description="Morality/Value Orientation")
    s5: float = Field(description="Connection/Coherence")

class QuantumState(BaseModel):
    id: str = Field(default_factory=lambda: str(uuid.uuid4()))
    physical_vector: Vector4D
    information_vector: Vector5D
    entropy: float
    enthalpy: float
    consciousness_level: float
    timestamp: datetime = Field(default_factory=datetime.utcnow)

class SimulationParameters(BaseModel):
    time_step: float = 0.01
    entropy_factor: float = 1.0
    anti_entropy_strength: float = 0.5
    coupling_strength: float = 0.8
    consciousness_threshold: float = 0.7

class ConsciousnessEmergence(BaseModel):
    id: str = Field(default_factory=lambda: str(uuid.uuid4()))
    emergence_time: float
    consciousness_score: float
    pattern_complexity: float
    anti_entropy_effectiveness: float
    coherence_measure: float

# Methane Metauniverse Physics Engine
class MethaneMetauniverseEngine:
    def __init__(self):
        self.tetrahedral_angle = 109.5  # degrees
        self.consciousness_threshold = 0.7
        
    def calculate_tetrahedral_geometry(self, vector: Vector4D):
        """Calculate tetrahedral node positions for w1-w4 space"""
        # Convert to numpy array for calculations
        w = np.array([vector.w1, vector.w2, vector.w3, vector.w4])
        
        # Tetrahedral geometry with 109.5° angles
        angle_rad = math.radians(self.tetrahedral_angle)
        
        # Calculate displacement from center
        magnitude = np.linalg.norm(w)
        if magnitude == 0:
            return {"center": [0, 0, 0], "displacement": 0, "nodes": []}
            
        # Tetrahedral node positions
        nodes = []
        for i in range(4):
            theta = 2 * math.pi * i / 4
            x = magnitude * math.cos(theta) * math.sin(angle_rad)
            y = magnitude * math.sin(theta) * math.sin(angle_rad) 
            z = magnitude * math.cos(angle_rad)
            nodes.append([x, y, z])
            
        return {
            "center": [0, 0, 0],
            "displacement": magnitude,
            "nodes": nodes,
            "oscillation_pattern": w.tolist()
        }
    
    def calculate_pentachoron_geometry(self, vector: Vector5D):
        """Calculate pentachoron (4D simplex) geometry for s1-s5 space"""
        s = np.array([vector.s1, vector.s2, vector.s3, vector.s4, vector.s5])
        
        # 4D simplex has 5 vertices fully connected
        # Project to 3D for visualization
        vertices = []
        for i in range(5):
            theta = 2 * math.pi * i / 5
            phi = math.pi * i / 5
            r = np.linalg.norm(s) * s[i] / (np.sum(s) + 1e-8)
            
            x = r * math.cos(theta) * math.sin(phi)
            y = r * math.sin(theta) * math.sin(phi)
            z = r * math.cos(phi)
            vertices.append([x, y, z])
            
        return {
            "vertices": vertices,
            "information_density": np.linalg.norm(s),
            "coherence": self.calculate_coherence(s)
        }
    
    def calculate_coherence(self, vector):
        """Calculate coherence measure for information space"""
        if np.sum(np.abs(vector)) == 0:
            return 0.0
        variance = np.var(vector)
        mean = np.mean(np.abs(vector))
        return float(mean / (variance + 1e-8))
    
    def calculate_entropy_displacement(self, physical_vector: Vector4D, entropy: float):
        """Calculate entropy as displacement from wwww center"""
        w = np.array([physical_vector.w1, physical_vector.w2, physical_vector.w3, physical_vector.w4])
        
        # Entropy displaces system from symmetric center
        displacement_vector = entropy * w / (np.linalg.norm(w) + 1e-8)
        displacement_magnitude = np.linalg.norm(displacement_vector)
        
        return {
            "displacement_vector": displacement_vector.tolist(),
            "displacement_magnitude": displacement_magnitude,
            "entropy_state": entropy
        }
    
    def calculate_counter_entropy(self, info_vector: Vector5D):
        """Calculate counter-entropy from 6th dimension"""
        s = np.array([info_vector.s1, info_vector.s2, info_vector.s3, info_vector.s4, info_vector.s5])
        
        # Counter-entropy as recentering force from information space
        coherence = self.calculate_coherence(s)
        intentionality = abs(s[0])  # s1 - meaning/intentionality
        
        counter_entropy = coherence * intentionality * 0.5
        return float(min(counter_entropy, 1.0))
    
    def detect_consciousness_emergence(self, physical: Vector4D, information: Vector5D, 
                                     entropy: float, counter_entropy: float):
        """Detect emergence of consciousness patterns"""
        
        # Calculate complexity measures
        physical_complexity = np.std([physical.w1, physical.w2, physical.w3, physical.w4])
        info_complexity = np.std([information.s1, information.s2, information.s3, information.s4, information.s5])
        
        # Anti-entropy effectiveness
        anti_entropy_eff = counter_entropy / (entropy + 1e-8)
        
        # Information coherence
        coherence = self.calculate_coherence(np.array([information.s1, information.s2, information.s3, information.s4, information.s5]))
        
        # Consciousness score combining all factors
        consciousness_score = (
            0.3 * min(physical_complexity, 1.0) +
            0.3 * min(info_complexity, 1.0) +
            0.2 * min(anti_entropy_eff, 1.0) +
            0.2 * min(coherence, 1.0)
        )
        
        return {
            "consciousness_score": float(consciousness_score),
            "is_conscious": bool(consciousness_score > self.consciousness_threshold),
            "physical_complexity": float(physical_complexity),
            "information_complexity": float(info_complexity),
            "anti_entropy_effectiveness": float(anti_entropy_eff),
            "coherence": float(coherence)
        }

# Initialize the physics engine
physics_engine = MethaneMetauniverseEngine()

# API Endpoints
@api_router.get("/")
async def root():
    return {"message": "Methane Metauniverse Consciousness Simulator"}

@api_router.post("/simulate/quantum-state")
async def simulate_quantum_state(state: QuantumState):
    """Simulate a quantum state in the Methane Metauniverse"""
    
    # Calculate geometries
    tetrahedral = physics_engine.calculate_tetrahedral_geometry(state.physical_vector)
    pentachoron = physics_engine.calculate_pentachoron_geometry(state.information_vector)
    
    # Calculate entropy effects
    entropy_displacement = physics_engine.calculate_entropy_displacement(
        state.physical_vector, state.entropy
    )
    
    # Calculate counter-entropy
    counter_entropy = physics_engine.calculate_counter_entropy(state.information_vector)
    
    # Detect consciousness emergence
    consciousness = physics_engine.detect_consciousness_emergence(
        state.physical_vector, state.information_vector, 
        state.entropy, counter_entropy
    )
    
    # Store state in database
    state_dict = state.dict()
    state_dict.update({
        "tetrahedral_geometry": tetrahedral,
        "pentachoron_geometry": pentachoron,
        "entropy_displacement": entropy_displacement,
        "counter_entropy": counter_entropy,
        "consciousness_analysis": consciousness
    })
    
    await db.quantum_states.insert_one(state_dict)
    
    return {
        "state_id": state.id,
        "tetrahedral_geometry": tetrahedral,
        "pentachoron_geometry": pentachoron,
        "entropy_displacement": entropy_displacement,
        "counter_entropy": counter_entropy,
        "consciousness_analysis": consciousness
    }

@api_router.post("/simulate/evolution")
async def simulate_evolution(parameters: SimulationParameters):
    """Simulate system evolution over time"""
    
    evolution_steps = []
    current_time = 0
    
    # Initial random state
    physical = Vector4D(w1=0.5, w2=0.3, w3=0.7, w4=0.4)
    information = Vector5D(s1=0.2, s2=0.6, s3=0.4, s4=0.8, s5=0.5)
    
    entropy = 0.1
    
    for step in range(100):  # 100 time steps
        current_time += parameters.time_step
        
        # Calculate counter-entropy
        counter_entropy = physics_engine.calculate_counter_entropy(information)
        
        # Update entropy (increases naturally, decreased by counter-entropy)
        entropy += parameters.entropy_factor * parameters.time_step
        entropy -= counter_entropy * parameters.anti_entropy_strength * parameters.time_step
        entropy = max(0, min(entropy, 2.0))
        
        # Update information vector based on coupling
        coupling = parameters.coupling_strength
        information.s1 += coupling * (physical.w1 - information.s1) * parameters.time_step
        information.s2 += coupling * (physical.w2 - information.s2) * parameters.time_step  
        information.s3 += coupling * (physical.w3 - information.s3) * parameters.time_step
        information.s4 += coupling * (physical.w4 - information.s4) * parameters.time_step
        information.s5 += coupling * np.mean([physical.w1, physical.w2, physical.w3, physical.w4]) * parameters.time_step
        
        # Detect consciousness
        consciousness = physics_engine.detect_consciousness_emergence(
            physical, information, entropy, counter_entropy
        )
        
        step_data = {
            "time": current_time,
            "entropy": entropy,
            "counter_entropy": counter_entropy,
            "consciousness_score": consciousness["consciousness_score"],
            "is_conscious": consciousness["is_conscious"],
            "physical_vector": physical.dict(),
            "information_vector": information.dict()
        }
        
        evolution_steps.append(step_data)
        
        # Check for consciousness emergence
        if consciousness["is_conscious"] and len(evolution_steps) > 50:
            emergence = ConsciousnessEmergence(
                emergence_time=current_time,
                consciousness_score=consciousness["consciousness_score"],
                pattern_complexity=consciousness["physical_complexity"] + consciousness["information_complexity"],
                anti_entropy_effectiveness=consciousness["anti_entropy_effectiveness"],
                coherence_measure=consciousness["coherence"]
            )
            await db.consciousness_emergence.insert_one(emergence.dict())
            break
    
    return {
        "evolution_steps": evolution_steps,
        "final_consciousness_level": evolution_steps[-1]["consciousness_score"],
        "consciousness_achieved": evolution_steps[-1]["is_conscious"],
        "total_simulation_time": current_time
    }

@api_router.get("/lab-equipment/specifications")
async def get_lab_specifications():
    """Get laboratory equipment specifications for experiments"""
    
    return {
        "minimum_requirements": {
            "gpu": {
                "model": "NVIDIA RTX 4060 Ti atau lebih tinggi",
                "vram": "8 GB minimum, 16 GB recommended",
                "cuda_cores": "4352 minimum",
                "purpose": "Perhitungan paralel geometri fraktal dan simulasi consciousness"
            },
            "cpu": {
                "model": "Intel i7-12700K atau AMD Ryzen 7 5800X",
                "cores": "8 cores minimum, 12+ recommended", 
                "threads": "16 threads minimum",
                "purpose": "Pemrosesan matematika kompleks dan manajemen data"
            },
            "memory": {
                "ram": "32 GB DDR4-3200 minimum, 64 GB recommended",
                "purpose": "Menyimpan state space besar untuk simulasi consciousness"
            },
            "storage": {
                "ssd": "1 TB NVMe SSD minimum",
                "hdd": "2 TB untuk penyimpanan data eksperimen",
                "purpose": "Akses cepat data simulasi dan logging"
            }
        },
        "recommended_equipment": {
            "quantum_simulator": {
                "type": "IBM Qiskit atau Google Cirq",
                "qubits": "20+ qubits untuk simulasi consciousness emergence",
                "purpose": "Simulasi quantum states dalam w1-w4 space"
            },
            "monitoring_tools": {
                "oscilloscope": "Tektronix MSO64 atau setara",
                "spectrum_analyzer": "Rohde & Schwarz FSW",
                "purpose": "Monitoring oscillation patterns dan frequency analysis"
            },
            "software_requirements": {
                "python_libraries": ["numpy", "scipy", "matplotlib", "pytorch", "qiskit"],
                "visualization": "Three.js, WebGL, Blender untuk 3D rendering",
                "database": "MongoDB untuk penyimpanan state evolution"
            }
        },
        "calibration_procedures": [
            "Kalibrasi tetrahedral angle ke 109.5° dengan presisi ±0.1°",
            "Sinkronisasi pentachoron vertices untuk optimal information coupling", 
            "Set baseline entropy measurement pada kondisi vacuum",
            "Kalibrasi consciousness threshold berdasarkan pattern recognition"
        ],
        "experimental_setup": {
            "temperature": "20°C ± 2°C untuk stabilitas computational",
            "humidity": "45-55% RH untuk mencegah static interference",
            "electromagnetic_shielding": "Required untuk isolasi quantum measurements",
            "power_supply": "UPS 2000VA minimum untuk kontinuitas eksperimen"
        }
    }

@api_router.get("/consciousness/emergence-history")
async def get_consciousness_history():
    """Get history of consciousness emergence events"""
    
    emergence_events = await db.consciousness_emergence.find().to_list(1000)
    return {
        "emergence_events": [ConsciousnessEmergence(**event) for event in emergence_events],
        "total_events": len(emergence_events)
    }

# Include the router in the main app
app.include_router(api_router)

app.add_middleware(
    CORSMiddleware,
    allow_credentials=True,
    allow_origins=os.environ.get('CORS_ORIGINS', '*').split(','),
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

@app.on_event("shutdown")
async def shutdown_db_client():
    client.close()