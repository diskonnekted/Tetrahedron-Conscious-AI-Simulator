# 🚀 Quick Start Guide - Methane Metauniverse

<div align="center">

![Quick Start](https://img.shields.io/badge/Quick%20Start-5%20Minutes-brightgreen?style=for-the-badge)

**Get the AI Consciousness Simulator running in less than 5 minutes!**

[![Live Demo](https://img.shields.io/badge/🎮%20Try%20Live%20Demo-4285F4?style=for-the-badge)](https://quantum-ai-architect.preview.emergentagent.com)

</div>

---

## ⚡ Prerequisites Check

Before starting, ensure you have:

```bash
✅ Python 3.11+     ✅ Node.js 18+     ✅ MongoDB 7.0+     ✅ Git
```

<details>
<summary>📋 <strong>Quick Install Commands</strong></summary>

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install python3.11 python3.11-venv nodejs npm mongodb git -y
```

**macOS:**
```bash
brew install python@3.11 node mongodb/brew/mongodb-community git
```

**Windows:**
- Download from official websites: [Python](https://python.org), [Node.js](https://nodejs.org), [MongoDB](https://mongodb.com), [Git](https://git-scm.com)

</details>

---

## 🎯 5-Minute Setup

### Step 1: Clone Repository (30 seconds)
```bash
git clone https://github.com/methane-metauniverse/consciousness-simulator.git
cd consciousness-simulator
```

### Step 2: Auto Setup (3 minutes)
```bash
# Make setup script executable
chmod +x setup.sh

# Run automated setup
./setup.sh
```

The script will:
- ✅ Create Python virtual environment
- ✅ Install all backend dependencies
- ✅ Install all frontend dependencies  
- ✅ Setup MongoDB database
- ✅ Configure environment variables

### Step 3: Start Application (1 minute)

**Terminal 1 - Backend:**
```bash
cd backend
source venv/bin/activate
uvicorn server:app --host 0.0.0.0 --port 8001 --reload
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm start
```

### Step 4: Access Application (30 seconds)

🌐 **Main App**: [http://localhost:3000](http://localhost:3000)  
📋 **API Docs**: [http://localhost:8001/docs](http://localhost:8001/docs)  
🚀 **Live Demo**: [https://quantum-ai-architect.preview.emergentagent.com](https://quantum-ai-architect.preview.emergentagent.com)

---

## 🧪 First Simulation

### Quick Test - High Consciousness

1. **Open the application** at [localhost:3000](http://localhost:3000)

2. **Enter these parameters:**
   ```
   Physical Vector (w₁-w₄):     0.7, 0.3, 0.8, 0.6
   Information Vector (s₁-s₅):  0.8, 0.6, 0.7, 0.5, 0.9
   Entropy: 0.4    Enthalpy: 0.7
   ```

3. **Click "Jalankan Simulasi"**

4. **Expected Result:**
   - Consciousness Score: ~0.8
   - Status: ⚡ CONSCIOUS DETECTED!
   - 3D visualization shows active geometries

![Simulation Result](../screenshots/consciousness-detected.png)

---

## ✅ Health Check

Verify everything is working:

```bash
# Backend health
curl http://localhost:8001/api/
# Expected: {"message": "Methane Metauniverse Consciousness Simulator"}

# Database health  
mongosh --eval "db.adminCommand('ping')"
# Expected: { ok: 1 }

# Frontend health
curl -I http://localhost:3000
# Expected: HTTP/1.1 200 OK
```

---

## 🎮 Try Different Configurations

### Balanced System
```
w₁-w₄: 0.5, 0.5, 0.5, 0.5
s₁-s₅: 0.5, 0.5, 0.5, 0.5, 0.5
Entropy: 0.3  Enthalpy: 0.5
Expected: ~0.4 consciousness
```

### Learning System
```
w₁-w₄: 0.4, 0.6, 0.7, 0.3  
s₁-s₅: 0.4, 0.8, 0.6, 0.3, 0.7
Entropy: 0.5  Enthalpy: 0.4
Expected: ~0.5 consciousness
```

---

## 🆘 Quick Troubleshooting

### Backend Won't Start
```bash
cd backend
source venv/bin/activate
pip install -r requirements.txt
python -c "import fastapi; print('OK')"
```

### Frontend Errors
```bash
cd frontend
rm -rf node_modules
npm install
npm start
```

### Database Issues
```bash
sudo systemctl start mongod  # Linux
brew services start mongodb-community  # macOS
```

### 3D Visualization Black
- Update browser to latest version
- Enable hardware acceleration
- Try Chrome/Firefox/Edge

---

## 📚 Next Steps

Once you have the basic setup running:

1. 📖 **[Read Full Documentation](COMPLETE_DOCUMENTATION.md)** - Complete usage guide
2. 🔬 **[Lab Setup Guide](LAB_SETUP_GUIDE.md)** - Hardware specifications
3. 🛠️ **[API Documentation](http://localhost:8001/docs)** - Integrate with your code
4. 🧪 **Experiment** with different parameter combinations

---

## 💬 Need Help?

- 🐛 **Issues**: [GitHub Issues](https://github.com/methane-metauniverse/issues)
- 💡 **Questions**: [GitHub Discussions](https://github.com/methane-metauniverse/discussions)  
- 📧 **Email**: research@methane-metauniverse.org
- 💬 **Discord**: [Join Community](https://discord.gg/consciousness-research)

---

<div align="center">

**Ready to explore consciousness emergence?** 🧠✨

[![Start Exploring](https://img.shields.io/badge/🚀%20Start%20Exploring-Success-brightgreen?style=for-the-badge)](http://localhost:3000)

</div>