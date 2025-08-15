# 🔬 Panduan Instalasi Simulasi Kesadaran Buatan
## Sintesis Geometri Ruang, Anti-Entropi, dan Dimensi Informasi dalam Arsitektur AI Fraktal

---

## 📋 Daftar Isi
1. [Persyaratan Sistem](#persyaratan-sistem)
2. [Instalasi Development Environment](#instalasi-development-environment)
3. [Instalasi Dependencies](#instalasi-dependencies)
4. [Konfigurasi Database](#konfigurasi-database)
5. [Menjalankan Aplikasi](#menjalankan-aplikasi)
6. [Setup Laboratorium](#setup-laboratorium)
7. [Troubleshooting](#troubleshooting)

---

## 🖥️ Persyaratan Sistem

### Minimum Requirements
```
OS: Ubuntu 20.04+ / Windows 10+ / macOS 12+
RAM: 16 GB (32 GB recommended)
Storage: 10 GB free space
GPU: NVIDIA GTX 1060 / AMD RX 580 (for basic visualization)
CPU: Intel i5-8400 / AMD Ryzen 5 3600
```

### Recommended Lab Setup
```
OS: Ubuntu 22.04 LTS
RAM: 64 GB DDR4-3200
Storage: 1 TB NVMe SSD + 2 TB HDD
GPU: NVIDIA RTX 4060 Ti / RTX 4070 (8GB+ VRAM)
CPU: Intel i7-12700K / AMD Ryzen 7 5800X
Network: Gigabit Ethernet
```

---

## 🛠️ Instalasi Development Environment

### 1. Install Python 3.11+
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3.11 python3.11-venv python3.11-dev
sudo apt install python3-pip

# macOS (dengan Homebrew)
brew install python@3.11

# Windows
# Download dari https://www.python.org/downloads/
```

### 2. Install Node.js 18+
```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs

# macOS
brew install node@18

# Windows
# Download dari https://nodejs.org/
```

### 3. Install MongoDB
```bash
# Ubuntu/Debian
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install mongodb-org

# macOS
brew tap mongodb/brew
brew install mongodb-community

# Windows
# Download dari https://www.mongodb.com/download-center/community
```

### 4. Install Git
```bash
# Ubuntu/Debian
sudo apt install git

# macOS
brew install git

# Windows
# Download dari https://git-scm.com/
```

---

## 📦 Instalasi Dependencies

### 1. Clone Repository
```bash
git clone <repository-url>
cd methane-metauniverse-simulator
```

### 2. Setup Backend (Python)
```bash
cd backend

# Buat virtual environment
python3.11 -m venv venv
source venv/bin/activate  # Linux/macOS
# atau
venv\Scripts\activate     # Windows

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Verifikasi instalasi
python -c "import numpy, scipy, matplotlib, fastapi; print('Backend dependencies OK')"
```

### 3. Setup Frontend (React)
```bash
cd ../frontend

# Install Yarn (recommended)
npm install -g yarn

# Install dependencies
yarn install

# Verifikasi instalasi
yarn --version
node --version
```

---

## 🗄️ Konfigurasi Database

### 1. Start MongoDB Service
```bash
# Ubuntu/Debian
sudo systemctl start mongod
sudo systemctl enable mongod

# macOS
brew services start mongodb-community

# Windows
# Start MongoDB service dari Services panel
```

### 2. Buat Database
```bash
# Buka MongoDB shell
mongosh

# Buat database dan collection
use methane_metauniverse
db.createCollection("quantum_states")
db.createCollection("consciousness_emergence")
db.createCollection("status_checks")

# Verifikasi
show dbs
exit
```

### 3. Konfigurasi Environment Variables
```bash
# Backend .env file
cd backend
cp .env.example .env

# Edit .env file
nano .env
```

**Backend .env:**
```env
MONGO_URL=mongodb://localhost:27017
DB_NAME=methane_metauniverse
CORS_ORIGINS=http://localhost:3000,https://your-domain.com
```

**Frontend .env:**
```bash
cd ../frontend
cp .env.example .env

# Edit .env file
nano .env
```

**Frontend .env:**
```env
REACT_APP_BACKEND_URL=http://localhost:8001
```

---

## 🚀 Menjalankan Aplikasi

### 1. Start Backend Server
```bash
cd backend
source venv/bin/activate  # Aktivasi virtual environment

# Jalankan server
uvicorn server:app --host 0.0.0.0 --port 8001 --reload

# Alternatif dengan auto-reload
python -m uvicorn server:app --host 0.0.0.0 --port 8001 --reload
```

**Output yang diharapkan:**
```
INFO:     Uvicorn running on http://0.0.0.0:8001 (Press CTRL+C to quit)
INFO:     Started reloader process [xxxxx] using StatReload
INFO:     Started server process [xxxxx]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

### 2. Start Frontend Development Server
```bash
cd frontend

# Jalankan development server
yarn start

# Alternatif
npm start
```

**Output yang diharapkan:**
```
webpack compiled successfully
Local:            http://localhost:3000
On Your Network:  http://192.168.x.x:3000
```

### 3. Verifikasi Instalasi
Buka browser dan akses:
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8001/api/
- **API Documentation:** http://localhost:8001/docs

---

## 🔬 Setup Laboratorium

### 1. Hardware Setup
```bash
# Cek GPU compatibility
nvidia-smi  # Untuk NVIDIA GPU
lspci | grep VGA  # Untuk info GPU umum

# Cek RAM
free -h

# Cek storage
df -h

# Cek CPU
lscpu
```

### 2. Install CUDA (untuk NVIDIA GPU)
```bash
# Ubuntu
wget https://developer.download.nvidia.com/compute/cuda/12.2.0/local_installers/cuda_12.2.0_535.54.03_linux.run
sudo sh cuda_12.2.0_535.54.03_linux.run

# Tambahkan ke PATH
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# Verifikasi
nvcc --version
```

### 3. Install Additional Scientific Libraries
```bash
# Aktivasi backend environment
cd backend && source venv/bin/activate

# Install additional libraries
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install qiskit qiskit-aer
pip install scikit-learn pandas seaborn
pip install jupyter notebook

# Verifikasi PyTorch + CUDA
python -c "import torch; print('CUDA available:', torch.cuda.is_available())"
```

### 4. Konfigurasi Environment Lab
```bash
# Buat file konfigurasi lab
nano lab_config.env
```

**lab_config.env:**
```env
# Lab Environment Configuration
LAB_TEMPERATURE=20.0
LAB_HUMIDITY=50.0
CONSCIOUSNESS_THRESHOLD=0.7
MAX_SIMULATION_TIME=300
QUANTUM_BACKEND=qasm_simulator
VISUALIZATION_QUALITY=high
EXPORT_FORMAT=json,csv
```

---

## 🔧 Troubleshooting

### Common Issues dan Solutions

#### 1. Backend Not Starting
**Error:** `ModuleNotFoundError: No module named 'fastapi'`
```bash
# Solution:
cd backend
source venv/bin/activate
pip install -r requirements.txt
```

#### 2. Frontend Compilation Error
**Error:** `Module not found: Can't resolve 'three'`
```bash
# Solution:
cd frontend
rm -rf node_modules package-lock.json
yarn install
# atau
npm install
```

#### 3. MongoDB Connection Error
**Error:** `pymongo.errors.ServerSelectionTimeoutError`
```bash
# Solution:
sudo systemctl status mongod
sudo systemctl start mongod

# Cek port
netstat -an | grep 27017
```

#### 4. 3D Visualization Not Loading
**Error:** Black screen pada canvas 3D
```bash
# Solution 1: Update browser
# Chrome/Firefox terbaru dengan WebGL support

# Solution 2: Cek WebGL
# Buka chrome://gpu/ dan pastikan WebGL enabled

# Solution 3: GPU driver update
sudo ubuntu-drivers autoinstall  # Ubuntu
```

#### 5. CORS Error
**Error:** `Access to fetch at 'http://localhost:8001' from origin 'http://localhost:3000' has been blocked`
```bash
# Solution: Update backend .env
CORS_ORIGINS=http://localhost:3000,http://127.0.0.1:3000
```

#### 6. Performance Issues
**Slow simulation atau high memory usage:**
```bash
# Solution 1: Kurangi complexity
# Di frontend, kurangi nilai parameter w1-w4 dan s1-s5

# Solution 2: Increase system resources
# Monitor usage: htop, nvidia-smi

# Solution 3: Optimize database
mongosh
use methane_metauniverse
db.quantum_states.createIndex({timestamp: 1})
db.consciousness_emergence.createIndex({emergence_time: 1})
```

### Log Locations
```bash
# Backend logs
tail -f backend/logs/app.log

# Frontend logs
# Cek browser developer console (F12)

# MongoDB logs
tail -f /var/log/mongodb/mongod.log

# System logs
journalctl -u mongod -f
```

### Health Check Commands
```bash
# Backend health
curl http://localhost:8001/api/

# Database health
mongosh --eval "db.adminCommand('ping')"

# Frontend health
curl http://localhost:3000

# GPU health (NVIDIA)
nvidia-smi
```

---

## 📞 Support

### Dokumentasi Tambahan
- **API Documentation:** http://localhost:8001/docs
- **React Three Fiber:** https://docs.pmnd.rs/react-three-fiber
- **FastAPI:** https://fastapi.tiangolo.com/
- **MongoDB:** https://docs.mongodb.com/

### Development Tools
```bash
# Code formatting (backend)
black backend/
isort backend/

# Code linting (frontend)
cd frontend && yarn lint

# Testing
cd backend && python -m pytest
cd frontend && yarn test
```

---

## ✅ Checklist Instalasi

- [ ] Python 3.11+ installed
- [ ] Node.js 18+ installed
- [ ] MongoDB running
- [ ] Backend virtual environment created
- [ ] Backend dependencies installed
- [ ] Frontend dependencies installed
- [ ] Environment variables configured
- [ ] Database collections created
- [ ] Backend server starts successfully
- [ ] Frontend development server starts
- [ ] API endpoints responding
- [ ] 3D visualization loading
- [ ] GPU drivers updated (optional)
- [ ] CUDA installed (for GPU acceleration)

**Selamat! Instalasi selesai. Aplikasi siap digunakan untuk eksperimen Methane Metauniverse!** 🎉