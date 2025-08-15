#!/bin/bash

# Methane Metauniverse - Application Launcher
# Starts both backend and frontend services

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
                                                                                                           
                          🚀 Application Launcher 🚀
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

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Health check function
health_check() {
    print_status "Performing health check..."
    
    local issues=()
    
    # Check if backend virtual environment exists
    if [ ! -d "backend/venv" ]; then
        issues+=("Backend virtual environment missing. Run: ./setup.sh")
    fi
    
    # Check if frontend node_modules exists
    if [ ! -d "frontend/node_modules" ]; then
        issues+=("Frontend dependencies missing. Run: cd frontend && npm install")
    fi
    
    # Check if MongoDB is running
    if ! pgrep -x "mongod" > /dev/null; then
        issues+=("MongoDB not running. Start with: sudo systemctl start mongod")
    fi
    
    # Check environment files
    if [ ! -f "backend/.env" ]; then
        issues+=("Backend .env file missing")
    fi
    
    if [ ! -f "frontend/.env" ]; then
        issues+=("Frontend .env file missing")
    fi
    
    # Report issues
    if [ ${#issues[@]} -ne 0 ]; then
        print_error "Health check failed. Issues found:"
        for issue in "${issues[@]}"; do
            echo -e "  ${RED}❌${NC} $issue"
        done
        echo ""
        print_warning "Please fix these issues and try again."
        echo "Tip: Run ${GREEN}./setup.sh${NC} to automatically fix most issues."
        return 1
    fi
    
    print_success "Health check passed!"
    return 0
}

# Function to start services
start_services() {
    print_status "Starting Methane Metauniverse services..."
    echo ""
    
    # Determine the best way to open terminals based on OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux - try different terminal emulators
        if command_exists gnome-terminal; then
            print_status "Using gnome-terminal..."
            gnome-terminal --tab --title="🔬 Backend API" --working-directory="$(pwd)" -- bash -c '
                echo "Starting Methane Metauniverse Backend...";
                echo "🔬 Physics Engine: Initializing...";
                cd backend;
                source venv/bin/activate;
                echo "🧠 Consciousness Detector: Online";
                echo "⚡ Anti-Entropy Engine: Ready";
                echo "🌐 API Server: Starting on http://localhost:8001";
                echo "";
                uvicorn server:app --host 0.0.0.0 --port 8001 --reload;
                exec bash'
            
            sleep 2
            
            gnome-terminal --tab --title="⚛️ Frontend UI" --working-directory="$(pwd)" -- bash -c '
                echo "Starting Methane Metauniverse Frontend...";
                echo "⚛️ React App: Initializing...";
                cd frontend;
                echo "🎨 3D Visualization: Loading Three.js...";
                echo "🎯 UI Components: Ready";
                echo "🌐 Development Server: Starting on http://localhost:3000";
                echo "";
                if command -v yarn &> /dev/null; then
                    yarn start;
                else
                    npm start;
                fi;
                exec bash'
                
        elif command_exists xterm; then
            print_status "Using xterm..."
            xterm -title "Backend API" -e "cd backend && source venv/bin/activate && uvicorn server:app --host 0.0.0.0 --port 8001 --reload" &
            xterm -title "Frontend UI" -e "cd frontend && npm start" &
            
        elif command_exists konsole; then
            print_status "Using konsole..."
            konsole --new-tab --title "Backend API" -e bash -c "cd backend && source venv/bin/activate && uvicorn server:app --host 0.0.0.0 --port 8001 --reload" &
            konsole --new-tab --title "Frontend UI" -e bash -c "cd frontend && npm start" &
            
        else
            print_warning "No suitable terminal emulator found."
            print_manual_instructions
            return 1
        fi
        
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        print_status "Using macOS Terminal..."
        osascript -e 'tell app "Terminal" to do script "cd '"$(pwd)"'/backend && source venv/bin/activate && echo \"🔬 Starting Backend API...\" && uvicorn server:app --host 0.0.0.0 --port 8001 --reload"'
        sleep 2
        osascript -e 'tell app "Terminal" to do script "cd '"$(pwd)"'/frontend && echo \"⚛️ Starting Frontend UI...\" && npm start"'
        
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows (Git Bash/WSL)
        print_status "Using Windows terminals..."
        start "Backend API" cmd /c "cd backend && venv\\Scripts\\activate && uvicorn server:app --host 0.0.0.0 --port 8001 --reload"
        sleep 2
        start "Frontend UI" cmd /c "cd frontend && npm start"
        
    else
        print_warning "Unsupported operating system: $OSTYPE"
        print_manual_instructions
        return 1
    fi
    
    print_success "Services are starting in separate terminals!"
    echo ""
    print_status "🔗 Access points:"
    echo -e "  ${BLUE}🌐 Frontend:${NC} http://localhost:3000"
    echo -e "  ${BLUE}📋 API Docs:${NC} http://localhost:8001/docs"
    echo -e "  ${BLUE}🔬 Backend:${NC} http://localhost:8001/api"
    echo -e "  ${BLUE}🚀 Live Demo:${NC} https://quantum-ai-architect.preview.emergentagent.com"
    echo ""
    print_status "🧪 Quick Test:"
    echo -e "  ${CYAN}Parameters:${NC} w₁-w₄ = 0.7,0.3,0.8,0.6 | s₁-s₅ = 0.8,0.6,0.7,0.5,0.9"
    echo -e "  ${CYAN}Expected:${NC} ~80% consciousness score! 🧠✨"
}

# Function to print manual instructions
print_manual_instructions() {
    echo ""
    print_warning "Could not automatically open terminals."
    echo ""
    echo -e "${YELLOW}Please manually run these commands in separate terminals:${NC}"
    echo ""
    echo -e "${GREEN}Terminal 1 (Backend):${NC}"
    echo "  cd backend"
    echo "  source venv/bin/activate"
    echo "  uvicorn server:app --host 0.0.0.0 --port 8001 --reload"
    echo ""
    echo -e "${GREEN}Terminal 2 (Frontend):${NC}"
    echo "  cd frontend"
    if command_exists yarn; then
        echo "  yarn start"
    else
        echo "  npm start"
    fi
    echo ""
    echo -e "${BLUE}Then access:${NC}"
    echo "  🌐 Frontend: http://localhost:3000"
    echo "  📋 API Docs: http://localhost:8001/docs"
}

# Function to monitor services
monitor_services() {
    print_status "Monitoring services..."
    echo ""
    echo "Press Ctrl+C to stop monitoring"
    echo ""
    
    while true; do
        # Check backend
        if curl -s http://localhost:8001/api/ > /dev/null 2>&1; then
            backend_status="${GREEN}✅ Online${NC}"
        else
            backend_status="${RED}❌ Offline${NC}"
        fi
        
        # Check frontend
        if curl -s http://localhost:3000 > /dev/null 2>&1; then
            frontend_status="${GREEN}✅ Online${NC}"
        else
            frontend_status="${RED}❌ Offline${NC}"
        fi
        
        # Check database
        if pgrep -x "mongod" > /dev/null; then
            db_status="${GREEN}✅ Running${NC}"
        else
            db_status="${RED}❌ Stopped${NC}"
        fi
        
        # Clear previous line and show status
        echo -ne "\r🔬 Backend: $backend_status | ⚛️ Frontend: $frontend_status | 🗄️ Database: $db_status"
        
        sleep 2
    done
}

# Main function
main() {
    echo -e "${CYAN}🚀 Methane Metauniverse Application Launcher${NC}"
    echo ""
    
    # Check if we're in the right directory
    if [ ! -f "setup.sh" ]; then
        print_error "Please run this script from the project root directory"
        exit 1
    fi
    
    # Parse command line arguments
    case "${1:-start}" in
        "start")
            # Perform health check
            if ! health_check; then
                echo ""
                read -p "Continue anyway? (y/N): " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    print_status "Exiting. Run ./setup.sh to fix issues."
                    exit 1
                fi
            fi
            
            echo ""
            start_services
            ;;
            
        "monitor")
            monitor_services
            ;;
            
        "status")
            health_check
            ;;
            
        "help"|"-h"|"--help")
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  start    Start the application (default)"
            echo "  monitor  Monitor service status"
            echo "  status   Check system health"
            echo "  help     Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0              # Start application"
            echo "  $0 start        # Start application"
            echo "  $0 monitor      # Monitor services"
            echo "  $0 status       # Health check"
            ;;
            
        *)
            print_error "Unknown command: $1"
            echo "Use '$0 help' for usage information."
            exit 1
            ;;
    esac
}

# Handle Ctrl+C gracefully
trap 'echo -e "\n${YELLOW}[INFO]${NC} Application launcher stopped."; exit 0' INT

# Run main function
main "$@"