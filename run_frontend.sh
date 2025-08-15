#!/bin/bash

# Methane Metauniverse - Frontend Launcher
# Starts only the React frontend development server

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
   ⚛️ METHANE METAUNIVERSE FRONTEND ⚛️
   
   ╔═══════════════════════════════════╗
   ║      React 3D Visualization       ║
   ║   Consciousness Interface UI      ║
   ╚═══════════════════════════════════╝
EOF
echo -e "${NC}"

# Check if we're in the right directory
if [ ! -f "frontend/package.json" ]; then
    print_error "Frontend files not found. Please run from project root directory."
    exit 1
fi

# Check if node_modules exists
if [ ! -d "frontend/node_modules" ]; then
    print_error "Dependencies not installed. Please run ./setup.sh first."
    exit 1
fi

# Navigate to frontend directory
cd frontend

print_status "⚛️ Initializing Methane Metauniverse Frontend..."
echo ""

# Check environment file
if [ ! -f ".env" ]; then
    print_error ".env file not found. Creating default configuration..."
    cat > .env << EOF
REACT_APP_BACKEND_URL=http://localhost:8001
EOF
    print_success ".env file created with default settings"
fi

# Determine package manager
if command -v yarn > /dev/null 2>&1; then
    PACKAGE_MANAGER="yarn"
    START_COMMAND="yarn start"
else
    PACKAGE_MANAGER="npm"
    START_COMMAND="npm start"
fi

# Check dependencies
print_status "📦 Checking dependencies..."
if [ ! -d "node_modules" ] || [ ! -f "node_modules/.package-lock.json" ] && [ ! -f "yarn.lock" ]; then
    print_status "Installing dependencies with $PACKAGE_MANAGER..."
    if [ "$PACKAGE_MANAGER" = "yarn" ]; then
        yarn install
    else
        npm install
    fi
fi

# Display startup information
echo ""
print_success "🚀 Starting Methane Metauniverse Frontend Server..."
echo ""
echo -e "${CYAN}🔗 Server Information:${NC}"
echo "  📍 Host: localhost"
echo "  🔌 Port: 3000"
echo "  🌐 URL: http://localhost:3000"
echo "  🚀 Live Demo: https://quantum-ai-architect.preview.emergentagent.com"
echo ""
echo -e "${CYAN}🎨 Frontend Features:${NC}"
echo "  ⚛️ React 19: Modern UI framework"
echo "  🎯 Three.js: 3D consciousness visualization"
echo "  🎨 Tailwind CSS: Modern styling"
echo "  🧩 shadcn/ui: Professional components"
echo ""
echo -e "${CYAN}🧠 Interface Components:${NC}"
echo "  🔬 Simulation Tab: Parameter controls & 3D viz"
echo "  📈 Evolution Tab: Time series consciousness tracking"
echo "  🧪 Lab Tab: Hardware specifications"
echo "  📚 Theory Tab: Theoretical foundations"
echo ""
echo -e "${CYAN}🎯 3D Visualization:${NC}"
echo "  🟢 Tetrahedral Geometry: Physical space (w₁-w₄)"
echo "  🟣 Pentachoron Geometry: Information space (s₁-s₅)"
echo "  ⚡ Real-time Rendering: Interactive consciousness display"
echo ""
echo -e "${YELLOW}💡 Quick Navigation:${NC}"
echo "  • Click tabs to switch between features"
echo "  • Drag in 3D canvas to rotate view"
echo "  • Scroll to zoom in/out"
echo "  • Fill parameters and click 'Jalankan Simulasi'"
echo ""
echo -e "${CYAN}🔗 Backend Connection:${NC}"
echo "  📡 API URL: $(grep REACT_APP_BACKEND_URL .env | cut -d'=' -f2)"
echo "  📋 API Docs: $(grep REACT_APP_BACKEND_URL .env | cut -d'=' -f2)/docs"
echo ""
echo -e "${GREEN}Press Ctrl+C to stop the development server${NC}"
echo ""

# Start the React development server
print_status "⚛️ Launching React development server..."
echo ""

# Set environment variables for development
export BROWSER=none  # Prevent automatic browser opening
export GENERATE_SOURCEMAP=true
export FAST_REFRESH=true

# Start with the appropriate package manager
exec $START_COMMAND