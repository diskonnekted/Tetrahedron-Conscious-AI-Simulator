#!/bin/bash

# Methane Metauniverse - Backend Launcher
# Starts only the FastAPI backend server

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# ASCII Art Banner
echo -e "${PURPLE}"
cat << "EOF"
   🔬 METHANE METAUNIVERSE BACKEND 🔬
   
   ╔═══════════════════════════════════╗
   ║     FastAPI Physics Engine        ║
   ║   Consciousness Detection API     ║
   ╚═══════════════════════════════════╝
EOF
echo -e "${NC}"

# Check if we're in the right directory
if [ ! -f "backend/server.py" ]; then
    print_error "Backend files not found. Please run from project root directory."
    exit 1
fi

# Check if virtual environment exists
if [ ! -d "backend/venv" ]; then
    print_error "Virtual environment not found. Please run ./setup.sh first."
    exit 1
fi

# Navigate to backend directory
cd backend

print_status "🔬 Initializing Methane Metauniverse Backend..."
echo ""

# Activate virtual environment
print_status "📦 Activating Python virtual environment..."
source venv/bin/activate

# Check if requirements are installed
print_status "🔍 Checking dependencies..."
python -c "import fastapi, numpy, scipy, matplotlib" 2>/dev/null || {
    print_error "Dependencies missing. Installing..."
    pip install -r requirements.txt
}

# Check environment file
if [ ! -f ".env" ]; then
    print_error ".env file not found. Creating default configuration..."
    cat > .env << EOF
MONGO_URL=mongodb://localhost:27017
DB_NAME=methane_metauniverse
CORS_ORIGINS=http://localhost:3000,http://127.0.0.1:3000
EOF
    print_success ".env file created with default settings"
fi

# Check MongoDB connection
print_status "🗄️ Checking MongoDB connection..."
if ! pgrep -x "mongod" > /dev/null; then
    echo -e "${YELLOW}[WARNING]${NC} MongoDB not running. Attempting to start..."
    
    # Try to start MongoDB
    if command -v systemctl > /dev/null 2>&1; then
        sudo systemctl start mongod 2>/dev/null || {
            echo -e "${YELLOW}[WARNING]${NC} Could not start MongoDB automatically."
            echo "Please start MongoDB manually:"
            echo "  sudo systemctl start mongod"
        }
    elif command -v brew > /dev/null 2>&1; then
        brew services start mongodb-community 2>/dev/null || {
            echo -e "${YELLOW}[WARNING]${NC} Could not start MongoDB automatically."
            echo "Please start MongoDB manually:"
            echo "  brew services start mongodb-community"
        }
    fi
    
    # Wait a moment for MongoDB to start
    sleep 3
fi

# Display startup information
echo ""
print_success "🚀 Starting Methane Metauniverse Backend Server..."
echo ""
echo -e "${CYAN}🔗 Server Information:${NC}"
echo "  📍 Host: 0.0.0.0"
echo "  🔌 Port: 8001"
echo "  🌐 URL: http://localhost:8001"
echo "  📋 API Docs: http://localhost:8001/docs"
echo "  🔬 API Endpoint: http://localhost:8001/api"
echo ""
echo -e "${CYAN}🧠 Physics Engine Status:${NC}"
echo "  ⚡ Anti-Entropy Calculator: Ready"
echo "  📐 Tetrahedral Geometry: Initialized (109.5°)"
echo "  🔷 Pentachoron Geometry: Initialized (5D)"
echo "  🎯 Consciousness Detector: Online (threshold: 0.7)"
echo ""
echo -e "${CYAN}📊 API Endpoints Available:${NC}"
echo "  POST /api/simulate/quantum-state"
echo "  POST /api/simulate/evolution"
echo "  GET  /api/lab-equipment/specifications"
echo "  GET  /api/consciousness/emergence-history"
echo ""
echo -e "${YELLOW}💡 Quick Test:${NC}"
echo "  curl http://localhost:8001/api/"
echo ""
echo -e "${GREEN}Press Ctrl+C to stop the server${NC}"
echo ""

# Start the FastAPI server with uvicorn
print_status "🎯 Launching uvicorn server..."
echo ""

uvicorn server:app --host 0.0.0.0 --port 8001 --reload \
    --log-level info \
    --access-log \
    --loop asyncio