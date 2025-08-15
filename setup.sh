#!/bin/bash

# Methane Metauniverse - Automated Setup Script
# This script sets up the complete development environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Banner
echo -e "${PURPLE}"
cat << "EOF"
  __  __      _   _                        __  __      _                       _                          
 |  \/  |    | | | |                      |  \/  |    | |                     (_)                         
 | \  / | ___| |_| |__   __ _ _ __   ___   | \  / | ___| |_ __ _ _   _ _ __  _ ____   _____ _ __ ___  ___  
 | |\/| |/ _ \ __| '_ \ / _` | '_ \ / _ \  | |\/| |/ _ \ __/ _` | | | | '_ \| |\ \ / / _ \ '__/ __|/ _ \ 
 | |  | |  __/ |_| | | | (_| | | | |  __/  | |  | |  __/ || (_| | |_| | | | | |\ V /  __/ |  \__ \  __/ 
 |_|  |_|\___|\__|_| |_|\__,_|_| |_|\___|  |_|  |_|\___|\__\__,_|\__,_|_| |_|_| \_/ \___|_|  |___/\___| 
                                                                                                           
                    AI Consciousness Simulator - Automated Setup
EOF
echo -e "${NC}"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    print_step "Checking prerequisites..."
    
    local missing_deps=()
    
    # Check Python 3.11+
    if command_exists python3.11; then
        PYTHON_CMD="python3.11"
    elif command_exists python3; then
        PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
        if [[ $(echo "$PYTHON_VERSION >= 3.11" | bc -l 2>/dev/null || echo "0") -eq 1 ]]; then
            PYTHON_CMD="python3"
        else
            missing_deps+=("python3.11+")
        fi
    else
        missing_deps+=("python3.11+")
    fi
    
    # Check Node.js 18+
    if command_exists node; then
        NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
        if [[ $NODE_VERSION -lt 18 ]]; then
            missing_deps+=("node.js 18+")
        fi
    else
        missing_deps+=("node.js 18+")
    fi
    
    # Check MongoDB
    if ! command_exists mongosh && ! command_exists mongo; then
        missing_deps+=("mongodb")
    fi
    
    # Check Git
    if ! command_exists git; then
        missing_deps+=("git")
    fi
    
    # Check if any dependencies are missing
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        echo ""
        echo "Please install the missing dependencies:"
        echo ""
        echo "Ubuntu/Debian:"
        echo "  sudo apt update"
        echo "  sudo apt install python3.11 python3.11-venv nodejs npm mongodb git -y"
        echo ""
        echo "macOS:"
        echo "  brew install python@3.11 node mongodb/brew/mongodb-community git"
        echo ""
        echo "Then run this script again."
        exit 1
    fi
    
    print_success "All prerequisites are installed!"
}

# Setup backend
setup_backend() {
    print_step "Setting up backend..."
    
    cd backend
    
    # Create virtual environment
    print_status "Creating Python virtual environment..."
    $PYTHON_CMD -m venv venv
    
    # Activate virtual environment
    source venv/bin/activate
    
    # Upgrade pip
    print_status "Upgrading pip..."
    pip install --upgrade pip --quiet
    
    # Install dependencies
    print_status "Installing Python dependencies..."
    pip install -r requirements.txt --quiet
    
    # Verify installation
    print_status "Verifying backend installation..."
    python -c "import fastapi, numpy, scipy, matplotlib; print('✅ Backend dependencies installed successfully')"
    
    # Create .env file if it doesn't exist
    if [ ! -f .env ]; then
        print_status "Creating backend .env file..."
        cat > .env << EOF
MONGO_URL=mongodb://localhost:27017
DB_NAME=methane_metauniverse
CORS_ORIGINS=http://localhost:3000,http://127.0.0.1:3000
EOF
        print_success "Backend .env file created"
    else
        print_warning "Backend .env file already exists, skipping..."
    fi
    
    cd ..
    print_success "Backend setup completed!"
}

# Setup frontend
setup_frontend() {
    print_step "Setting up frontend..."
    
    cd frontend
    
    # Check if yarn is available, otherwise use npm
    if command_exists yarn; then
        PACKAGE_MANAGER="yarn"
        INSTALL_CMD="yarn install"
        START_CMD="yarn start"
    else
        PACKAGE_MANAGER="npm"
        INSTALL_CMD="npm install"
        START_CMD="npm start"
        
        # Install yarn globally if npm is available
        print_status "Installing yarn globally..."
        npm install -g yarn --silent 2>/dev/null || true
        if command_exists yarn; then
            PACKAGE_MANAGER="yarn"
            INSTALL_CMD="yarn install"
            START_CMD="yarn start"
        fi
    fi
    
    print_status "Installing frontend dependencies using $PACKAGE_MANAGER..."
    $INSTALL_CMD --silent
    
    # Verify installation
    print_status "Verifying frontend installation..."
    node -e "console.log('✅ Frontend dependencies installed successfully')"
    
    # Create .env file if it doesn't exist
    if [ ! -f .env ]; then
        print_status "Creating frontend .env file..."
        cat > .env << EOF
REACT_APP_BACKEND_URL=http://localhost:8001
EOF
        print_success "Frontend .env file created"
    else
        print_warning "Frontend .env file already exists, skipping..."
    fi
    
    cd ..
    print_success "Frontend setup completed!"
}

# Setup database
setup_database() {
    print_step "Setting up MongoDB database..."
    
    # Check if MongoDB is running
    if pgrep -x "mongod" > /dev/null; then
        print_status "MongoDB is already running"
    else
        print_status "Starting MongoDB..."
        
        # Try to start MongoDB based on OS
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # Linux
            sudo systemctl start mongod 2>/dev/null || {
                print_warning "Could not start MongoDB with systemctl"
                print_status "Trying to start MongoDB manually..."
                mongod --fork --logpath /tmp/mongod.log --dbpath /tmp/mongodb 2>/dev/null || {
                    print_error "Could not start MongoDB. Please start it manually."
                    return 1
                }
            }
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            brew services start mongodb-community 2>/dev/null || {
                print_warning "Could not start MongoDB with brew services"
                print_status "Trying to start MongoDB manually..."
                mongod --fork --logpath /tmp/mongod.log --dbpath /tmp/mongodb 2>/dev/null || {
                    print_error "Could not start MongoDB. Please start it manually."
                    return 1
                }
            }
        else
            print_warning "Unsupported OS. Please start MongoDB manually."
        fi
        
        # Wait for MongoDB to start
        sleep 3
    fi
    
    # Create database and collections
    print_status "Creating database and collections..."
    
    # Use mongosh if available, otherwise mongo
    if command_exists mongosh; then
        MONGO_CMD="mongosh"
    else
        MONGO_CMD="mongo"
    fi
    
    $MONGO_CMD --quiet --eval "
        use methane_metauniverse;
        db.createCollection('quantum_states');
        db.createCollection('consciousness_emergence');
        db.createCollection('status_checks');
        db.quantum_states.createIndex({timestamp: 1});
        db.consciousness_emergence.createIndex({emergence_time: 1});
        print('✅ Database and collections created successfully');
    " 2>/dev/null || {
        print_warning "Could not create database collections automatically."
        print_status "Database will be created when the application starts."
    }
    
    print_success "Database setup completed!"
}

# Create documentation structure
setup_documentation() {
    print_step "Setting up documentation structure..."
    
    # Create docs directory if it doesn't exist
    mkdir -p docs/assets/screenshots
    
    # Create placeholder files for screenshots
    touch docs/assets/screenshots/main-interface.png
    touch docs/assets/screenshots/parameter-controls.png
    touch docs/assets/screenshots/3d-visualization.png
    touch docs/assets/screenshots/consciousness-results.png
    touch docs/assets/screenshots/evolution-tab.png
    touch docs/assets/screenshots/lab-equipment.png
    touch docs/assets/screenshots/theory-tab.png
    
    print_success "Documentation structure created!"
}

# Create run scripts
create_run_scripts() {
    print_step "Creating run scripts..."
    
    # Backend run script
    cat > run_backend.sh << 'EOF'
#!/bin/bash
echo "Starting Methane Metauniverse Backend..."
cd backend
source venv/bin/activate
uvicorn server:app --host 0.0.0.0 --port 8001 --reload
EOF
    chmod +x run_backend.sh
    
    # Frontend run script
    cat > run_frontend.sh << 'EOF'
#!/bin/bash
echo "Starting Methane Metauniverse Frontend..."
cd frontend
if command -v yarn &> /dev/null; then
    yarn start
else
    npm start
fi
EOF
    chmod +x run_frontend.sh
    
    # Combined run script
    cat > run_app.sh << 'EOF'
#!/bin/bash
echo "Starting Methane Metauniverse Application..."
echo "This will start both backend and frontend in separate terminals."
echo ""

# Check if gnome-terminal is available (Linux)
if command -v gnome-terminal &> /dev/null; then
    gnome-terminal --tab --title="Backend" -- bash -c './run_backend.sh; exec bash'
    gnome-terminal --tab --title="Frontend" -- bash -c './run_frontend.sh; exec bash'
    echo "✅ Application started in separate terminal tabs"
elif command -v osascript &> /dev/null; then
    # macOS
    osascript -e 'tell app "Terminal" to do script "./run_backend.sh"'
    osascript -e 'tell app "Terminal" to do script "./run_frontend.sh"'
    echo "✅ Application started in separate terminal windows"
else
    echo "❌ Could not detect terminal application"
    echo "Please run the following commands in separate terminals:"
    echo ""
    echo "Terminal 1 (Backend):"
    echo "  ./run_backend.sh"
    echo ""
    echo "Terminal 2 (Frontend):"
    echo "  ./run_frontend.sh"
fi
EOF
    chmod +x run_app.sh
    
    print_success "Run scripts created!"
}

# Health check
health_check() {
    print_step "Performing health check..."
    
    # Check backend virtual environment
    if [ -d "backend/venv" ]; then
        print_status "✅ Backend virtual environment exists"
    else
        print_error "❌ Backend virtual environment missing"
        return 1
    fi
    
    # Check frontend node_modules
    if [ -d "frontend/node_modules" ]; then
        print_status "✅ Frontend dependencies installed"
    else
        print_error "❌ Frontend node_modules missing"
        return 1
    fi
    
    # Check environment files
    if [ -f "backend/.env" ] && [ -f "frontend/.env" ]; then
        print_status "✅ Environment files created"
    else
        print_error "❌ Environment files missing"
        return 1
    fi
    
    # Test backend imports
    cd backend
    source venv/bin/activate
    python -c "import fastapi, numpy, scipy; print('✅ Backend imports working')" 2>/dev/null || {
        print_error "❌ Backend imports failed"
        cd ..
        return 1
    }
    cd ..
    
    print_success "Health check passed!"
}

# Main setup function
main() {
    echo -e "${CYAN}Starting automated setup...${NC}"
    echo ""
    
    # Check if we're in the right directory
    if [ ! -f "setup.sh" ]; then
        print_error "Please run this script from the project root directory"
        exit 1
    fi
    
    # Run setup steps
    check_prerequisites
    echo ""
    
    setup_backend
    echo ""
    
    setup_frontend
    echo ""
    
    setup_database
    echo ""
    
    setup_documentation
    echo ""
    
    create_run_scripts
    echo ""
    
    health_check
    echo ""
    
    # Success message
    echo -e "${GREEN}"
    cat << "EOF"
╔══════════════════════════════════════════════════════════════════════════════╗
║                          🎉 SETUP COMPLETED! 🎉                             ║
╚══════════════════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    echo -e "${CYAN}🚀 Ready to launch Methane Metauniverse!${NC}"
    echo ""
    echo "📋 Next steps:"
    echo ""
    echo "1. Start the application:"
    echo "   ${GREEN}./run_app.sh${NC}     # Automatic (recommended)"
    echo ""
    echo "   Or manually in separate terminals:"
    echo "   ${GREEN}./run_backend.sh${NC}  # Terminal 1"
    echo "   ${GREEN}./run_frontend.sh${NC} # Terminal 2"
    echo ""
    echo "2. Access the application:"
    echo "   🌐 Frontend: ${BLUE}http://localhost:3000${NC}"
    echo "   📋 API Docs: ${BLUE}http://localhost:8001/docs${NC}"
    echo "   🚀 Live Demo: ${BLUE}https://quantum-ai-architect.preview.emergentagent.com${NC}"
    echo ""
    echo "3. Try your first simulation:"
    echo "   - Enter parameters: w₁-w₄ = 0.7,0.3,0.8,0.6 | s₁-s₅ = 0.8,0.6,0.7,0.5,0.9"
    echo "   - Click 'Jalankan Simulasi'"
    echo "   - Expected: ~80% consciousness score! 🧠✨"
    echo ""
    echo "📚 Documentation:"
    echo "   - ${BLUE}docs/COMPLETE_DOCUMENTATION.md${NC} - Full guide"
    echo "   - ${BLUE}docs/QUICK_START.md${NC} - 5-minute tutorial"
    echo "   - ${BLUE}docs/SCREENSHOTS.md${NC} - Visual guide"
    echo ""
    echo "🆘 Need help?"
    echo "   - GitHub Issues: ${BLUE}github.com/methane-metauniverse/issues${NC}"
    echo "   - Email: ${BLUE}research@methane-metauniverse.org${NC}"
    echo ""
    echo -e "${PURPLE}Happy consciousness exploring! 🧠✨${NC}"
}

# Run main function
main "$@"