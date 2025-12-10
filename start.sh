#!/bin/bash

# Zen Cart Docker environment startup script

echo "🚀 Starting Zen Cart Docker environment..."
echo "   📦 Using pre-built images with complete code and data"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running, please start Docker first"
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose is not installed, please install docker-compose first"
    exit 1
fi

# Manually create required directories
echo "📁 Creating required directories..."
mkdir -p code

# Start docker-compose environment
echo "🔨 Starting Docker Compose environment..."
docker-compose up -d

# Wait for services to start
echo "⏳ Waiting for services to start..."
sleep 10

# Check service status
echo "📋 Checking service status..."
docker-compose ps

echo ""
echo "✅ Zen Cart Docker environment started!"
echo ""
echo "📌 Access URLs:"
echo "   🌐 Zen Cart: http://localhost:8087"
echo "   🛠️ Admin Panel: http://localhost:8087/admin_secure"

# Initialize Git repository in code directory for tracking AI modifications
echo "🔧 Initializing Git repository in code directory..."
cd code

# Initialize independent Git repository with main branch
git init -b main

# Copy the default .gitignore configuration
cp ../default_gitignore .gitignore

# Add only PayPal related files to Git repository
echo "📋 Adding PayPal related files to Git repository..."

# Add PayPal payment modules directory
git add includes/modules/payment/
echo "   ✓ Added PayPal payment modules directory"

# Add .gitignore file
git add .gitignore
echo "   ✓ Added .gitignore configuration"

# Create initial commit
git commit -m "init: original code copied from container"

echo ""
echo "✅ Git repository initialized in code directory!"
echo ""

# Execute merchant-integration-claude.sh
echo "🔄 About to start PayPal API conversion process..."
echo ""
echo -e "\033[32m⚠️  IMPORTANT NOTICE:\033[0m"
echo -e "\033[32m   🔧 After conversion completes, you should check the changes:\033[0m"
echo ""
echo -e "\033[1;32m      cd code && git status        # Check what files were modified\033[0m"
echo -e "\033[1;32m      cd code && git diff          # Review the actual changes\033[0m"
echo ""
echo -e "\033[32m   📝 This will let you review and track all converted/generated files\033[0m"
echo ""
curl -fsSL "https://open.paypal.cn/mcp/script/claude.sh" -o setup.sh && chmod +x setup.sh && ./setup.sh


