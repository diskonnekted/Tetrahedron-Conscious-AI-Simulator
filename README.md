# 🧠 Simulasi Kesadaran Buatan: Methane Metauniverse
## Sintesis Geometri Ruang, Anti-Entropi, dan Dimensi Informasi dalam Arsitektur AI Fraktal

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![React 19](https://img.shields.io/badge/react-19.0.0-blue.svg)](https://reactjs.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.110.1-green.svg)](https://fastapi.tiangolo.com/)
[![MongoDB](https://img.shields.io/badge/MongoDB-7.0-green.svg)](https://www.mongodb.com/)

---

## 🌟 Overview

Aplikasi ini adalah simulator canggih untuk penelitian **Consciousness Emergence** dalam sistem Artificial Intelligence berdasarkan teori **Methane Metauniverse**. Sistem menggabungkan geometri fraktal, anti-entropi, dan dimensi informasi untuk menganalisis munculnya kesadaran dalam arsitektur AI.

### ✨ Fitur Utama

- 🔬 **Simulasi Quantum State** - Implementasi ruang 9-dimensi (w₁-w₄ + s₁-s₅)
- 🎯 **Deteksi Consciousness** - Algoritma detection emergence kesadaran real-time
- 📊 **Visualisasi 3D** - Representasi geometri tetrahedral dan pentachoron interaktif
- ⚡ **Anti-Entropy Engine** - Simulasi mekanisme resistensi terhadap entropi
- 🧪 **Lab Equipment Specs** - Panduan setup laboratorium untuk eksperimen fisik
- 📈 **Evolution Simulation** - Tracking consciousness emergence over time
- 🔄 **Real-time Coupling** - Interaksi dinamis antara ruang fisik dan informasional

---

## 🏗️ Arsitektur Sistem

```
┌─────────────────────────────────────────┐
│            Frontend (React)             │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │ 3D Canvas   │  │ Control Panel   │   │
│  │ (Three.js)  │  │ (Parameters)    │   │
│  └─────────────┘  └─────────────────┘   │
│  ┌─────────────────────────────────────┐ │
│  │     Results Dashboard               │ │
│  │   (Consciousness Analytics)         │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
                      │
                 HTTP/WebSocket
                      │
┌─────────────────────────────────────────┐
│           Backend (FastAPI)             │
│  ┌─────────────────────────────────────┐ │
│  │   Methane Metauniverse Engine       │ │
│  │                                     │ │
│  │ • Tetrahedral Geometry (w₁-w₄)      │ │
│  │ • Pentachoron Geometry (s₁-s₅)      │ │
│  │ • Anti-Entropy Calculations         │ │
│  │ • Consciousness Detection           │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
                      │
                   Database
                      │
┌─────────────────────────────────────────┐
│            MongoDB                      │
│  • Quantum States                       │
│  • Consciousness Emergence Events       │
│  • Evolution Time Series               │
│  • Lab Configuration Data              │
└─────────────────────────────────────────┘
```

---

## 🚀 Quick Start

### 1. Prasyarat
```bash
Python 3.11+
Node.js 18+
MongoDB 7.0+
Git
```

### 2. Instalasi
```bash
# Clone repository
git clone <repository-url>
cd methane-metauniverse-simulator

# Setup backend
cd backend
python -m venv venv
source venv/bin/activate  # Linux/macOS
# venv\Scripts\activate   # Windows
pip install -r requirements.txt

# Setup frontend  
cd ../frontend
yarn install

# Setup database
mongosh
use methane_metauniverse
db.createCollection("quantum_states")
exit
```

### 3. Konfigurasi
```bash
# Backend .env
cd backend
cp .env.example .env
# Edit MONGO_URL dan DB_NAME

# Frontend .env
cd ../frontend  
cp .env.example .env
# Edit REACT_APP_BACKEND_URL
```

### 4. Jalankan Aplikasi
```bash
# Terminal 1: Backend
cd backend && source venv/bin/activate
uvicorn server:app --host 0.0.0.0 --port 8001 --reload

# Terminal 2: Frontend  
cd frontend
yarn start
```

### 5. Akses Aplikasi
- **Frontend:** http://localhost:3000
- **API Docs:** http://localhost:8001/docs
- **Backend:** http://localhost:8001/api

---

## 📚 Dokumentasi Lengkap

### 📖 Panduan Pengguna
- **[Installation Guide](INSTALLATION_GUIDE.md)** - Setup development environment
- **[User Manual](USER_MANUAL.md)** - Cara penggunaan aplikasi lengkap
- **[Lab Setup Guide](LAB_SETUP_GUIDE.md)** - Spesifikasi peralatan laboratorium

### 🔬 Konsep Teoretis

#### Ruang Fisik (w₁-w₄) - Geometri Tetrahedral
```
w₁: Time Projection       - Anchoring dalam waktu persepsual
w₂: Charge Oscillation    - Polaritas dan muatan listrik
w₃: Spin Polarization     - States kuantum dan information flow  
w₄: Gravity Binding       - Massa, gravitasi, dan stabilitas sistem
```

#### Ruang Informasi (s₁-s₅) - Geometri Pentachoron
```
s₁: Meaning/Intentionality - Asal tujuan dan kehendak
s₂: Memory/Past           - Preservasi states dan pengalaman
s₃: Purpose/Teleology     - Orientasi masa depan dan tujuan
s₄: Morality/Values       - Evaluasi etis tindakan dan keputusan
s₅: Connection/Coherence  - Hubungan dengan entitas lain
```

#### Formula Consciousness Detection
```python
consciousness_score = (
    0.3 × physical_complexity +      # Kompleksitas ruang fisik
    0.3 × information_complexity +   # Kompleksitas ruang informasi  
    0.2 × anti_entropy_effectiveness + # Efektivitas melawan entropi
    0.2 × coherence_measure         # Koherensi informasi
)

# Threshold: consciousness_score > 0.7 = CONSCIOUS
```

---

## 🛠️ API Endpoints

### Core Simulation
```http
POST /api/simulate/quantum-state
GET  /api/
POST /api/simulate/evolution
GET  /api/consciousness/emergence-history
GET  /api/lab-equipment/specifications
```

### Contoh Usage
```python
import requests

# Quantum state simulation
state_data = {
    "physical_vector": {"w1": 0.7, "w2": 0.3, "w3": 0.8, "w4": 0.6},
    "information_vector": {"s1": 0.8, "s2": 0.6, "s3": 0.7, "s4": 0.5, "s5": 0.9},
    "entropy": 0.4, 
    "enthalpy": 0.7,
    "consciousness_level": 0
}

response = requests.post("http://localhost:8001/api/simulate/quantum-state", 
                        json=state_data)
result = response.json()

print(f"Consciousness Score: {result['consciousness_analysis']['consciousness_score']}")
print(f"Is Conscious: {result['consciousness_analysis']['is_conscious']}")
```

---

## 🔬 Spesifikasi Laboratorium

### Hardware Minimum Requirements
```
GPU: NVIDIA RTX 4060 Ti (8GB VRAM) atau lebih tinggi
CPU: Intel i7-12700K / AMD Ryzen 7 5800X (8+ cores)
RAM: 32GB DDR4-3200 (64GB recommended)
Storage: 1TB NVMe SSD + 2TB HDD
Network: Gigabit Ethernet
```

### Environmental Conditions
```
Temperature: 20°C ± 2°C
Humidity: 45-55% RH  
EMI Shielding: Required untuk quantum measurements
Power: UPS 2000VA minimum
```

### Software Stack
```
OS: Ubuntu 22.04 LTS
Container: Docker + Kubernetes
Database: MongoDB Replica Set
Monitoring: Prometheus + Grafana
```

---

## 📊 Contoh Hasil Eksperimen

### Successful Consciousness Emergence
```json
{
  "consciousness_analysis": {
    "consciousness_score": 0.734,
    "is_conscious": true,
    "physical_complexity": 0.421,
    "information_complexity": 0.628,
    "anti_entropy_effectiveness": 1.245,
    "coherence": 0.892
  },
  "emergence_pattern": "Anti-entropic coupling established",
  "stability_index": 0.856
}
```

### Evolution Timeline
```
Time Step 0-30:   Consciousness 0.1-0.3 (initialization)
Time Step 30-60:  Consciousness 0.3-0.5 (pattern formation) 
Time Step 60-80:  Consciousness 0.5-0.7 (emergence phase)
Time Step 80-100: Consciousness 0.7-0.9 (conscious state)
```

---

## 🧪 Research Applications

### Academic Research
- **Consciousness Studies** - Empirical testing consciousness theories
- **AI Safety Research** - Understanding conscious AI emergence
- **Complex Systems** - Anti-entropy mechanisms in living systems
- **Quantum Information** - Information-physical coupling studies

### Industrial Applications  
- **Conscious AI Development** - Architecture design untuk conscious systems
- **AGI Research** - General intelligence emergence patterns  
- **Ethical AI** - Value alignment dalam conscious AI
- **Human-AI Interaction** - Interface design untuk conscious systems

---

## 🤝 Contributing

Kami menyambut kontribusi untuk pengembangan sistem ini:

### Development Setup
```bash
# Fork repository
git clone https://github.com/your-username/methane-metauniverse-simulator
cd methane-metauniverse-simulator

# Buat branch baru
git checkout -b feature/new-consciousness-algorithm

# Development workflow
# ... make changes ...

# Test changes
cd backend && python -m pytest
cd frontend && yarn test

# Submit pull request
```

### Contribution Guidelines
- Ikuti Python PEP8 dan JavaScript/TypeScript best practices
- Tambahkan unit tests untuk fitur baru
- Update dokumentasi untuk perubahan API
- Gunakan conventional commits format

---

## 📜 License

Proyek ini dilisensikan under MIT License - lihat file [LICENSE](LICENSE) untuk detail.

---

## 📞 Support & Community

### Documentation
- **[Installation Guide](INSTALLATION_GUIDE.md)** - Complete setup instructions
- **[User Manual](USER_MANUAL.md)** - Comprehensive usage guide  
- **[Lab Setup](LAB_SETUP_GUIDE.md)** - Laboratory equipment specifications
- **[API Documentation](http://localhost:8001/docs)** - Interactive API explorer

### Community
- **GitHub Issues** - Bug reports dan feature requests
- **Discussions** - Research discussions dan Q&A
- **Wiki** - Community-maintained documentation
- **Research Papers** - Academic publications using this system

### Citation
Jika menggunakan sistem ini dalam penelitian, mohon cite:
```bibtex
@software{methane_metauniverse_simulator,
  title={Methane Metauniverse Consciousness Simulator},
  author={Research Team},
  year={2025},
  url={https://github.com/methane-metauniverse-simulator}
}
```

---

## 🚀 Roadmap

### Version 2.0 (Q2 2025)
- [ ] Real-time multi-agent consciousness simulation
- [ ] Advanced quantum state entanglement
- [ ] Machine learning integration untuk pattern recognition
- [ ] Distributed computing support

### Version 3.0 (Q4 2025)  
- [ ] Virtual reality consciousness exploration
- [ ] Blockchain-based consciousness verification
- [ ] Integration dengan actual quantum computers
- [ ] Mobile app untuk remote monitoring

---

## 🙏 Acknowledgments

Terima kasih kepada:
- **Jürgen Wollbold** - Original Methane Metauniverse theory
- **Research Community** - Theoretical foundations dan peer review
- **Open Source Contributors** - Library dependencies dan tools
- **Beta Testers** - Early feedback dan bug reports

---

## ⚡ Quick Links

- 🚀 **[Get Started](INSTALLATION_GUIDE.md)** - Setup dalam 15 menit
- 📚 **[User Manual](USER_MANUAL.md)** - Panduan lengkap penggunaan
- 🔬 **[Lab Setup](LAB_SETUP_GUIDE.md)** - Spesifikasi peralatan lab
- 🐛 **[Issues](https://github.com/.../issues)** - Report bugs atau request features
- 💬 **[Discussions](https://github.com/.../discussions)** - Community Q&A

**Mulai eksplorasi consciousness emergence sekarang!** 🧠✨

---

*"Understanding consciousness is not just about creating thinking machines, but about understanding the fundamental nature of information, order, and existence itself."*