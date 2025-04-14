# AWS EC2 Repository Manager for Beginners

A simple GUI interface for students to connect to AWS EC2 instances and manage Git repositories without using the command line. This application provides a step-by-step wizard to guide users through the entire process of setting up and managing Git repositories on AWS EC2 instances.

## Features

- 🔐 Secure SSH connection to EC2 instances with PEM key authentication
- 🧙‍♂️ Step-by-step guided wizard for setting up Git server environment
- 📁 Git repository creation and management
- 🐳 Docker container deployment and management
- 🔄 Automatic command execution with visual feedback
- 📊 Progress tracking and status indicators
- 🛠️ Simple, intuitive interface designed for beginners

## Project Structure

```
├── frontend/           # React application source
│   ├── src/            # React components and logic
│   ├── public/         # Static assets
│   └── dist/           # Built files (production)
├── backend/
│   ├── main.py         # Python server with FastAPI
│   └── requirements.txt # Python dependencies
├── README.md           # Setup instructions
├── PROGRESS.md         # Development progress log
├── DESIGN.md           # Design documentation
├── DEVELOPMENT.md      # Developer guide
├── build-run.sh        # One-click build and run script
└── config/
    └── info.json       # Saved connection settings
```

## Prerequisites

- Python 3.8+ with pip
- Node.js 14+ and yarn
- AWS EC2 instance running Ubuntu
- PEM key file for SSH access to your EC2 instance
- Basic understanding of Git and AWS concepts

## Setup Instructions

### Quick Setup (Recommended)

The easiest way to set up and run the application is using the provided shell script:

```bash
# Make the script executable
chmod +x build-run.sh

# Run the script to build and start the application
./build-run.sh
```

This script automates the entire setup process and starts the application. Once complete, access the application at http://localhost:80.

### Development Setup

For active development with hot reloading:

```bash
chmod +x dev.sh
./dev.sh
```

When running in development mode:

- Frontend will be available at http://localhost:5173
- Backend API will be available at http://localhost:80

### Manual Setup

#### Backend Setup

1. Install Python dependencies:

```bash
cd backend
pip install -r requirements.txt
```

2. Start the backend server:

```bash
python main.py
```

The server will run on http://localhost:80 by default.

#### Frontend Setup

1. Install the dependencies using yarn:

```bash
cd frontend
yarn
```

2. For development, run the Vite development server:

```bash
yarn dev
```

This starts a development server with hot reloading.

3. Build the frontend for production:

```bash
yarn build
```

This will create the compiled files in the `dist` directory.

## Detailed Usage Instructions

### Step 1: Launch the Application

1. Start the backend server:

   ```bash
   cd backend
   python main.py
   ```

2. Open your browser and navigate to http://localhost:80

### Step 2: Connection Setup

1. Enter your EC2 instance URL or IP address
2. Enter your username (default is "ubuntu")
3. Upload your PEM key file
4. Click "Connect to EC2 Instance"

### Step 3: System Preparation

Run the provided commands to update your system and install Git.

### Step 4: Git User Setup

Create a dedicated Git user with the specified password.

### Step 5: SSH Configuration

Set up the SSH directory structure and permissions for the Git user.

### Step 6: SSH Key Management

Generate SSH keys and configure them for Git access.

### Step 7: Repository Setup

Create and initialize a bare Git repository on the server.

### Step 8: Git Configuration

Configure Git on your local machine to work with the EC2 repository.

### Step 9: Code Upload

Push your code to the repository on the EC2 instance.

### Step 10: Repository Refresh

Refresh the repository on the server by re-cloning it.

### Step 11: Docker Management

Manage Docker containers for your application with options for deploying, initializing, and stopping containers.

## Troubleshooting

- **Connection Issues**: Ensure your EC2 instance is running and accessible from your network
- **Permission Errors**: Check that your PEM key has the correct permissions (chmod 400)
- **SSH Problems**: Verify that port 22 is open in your EC2 security group
- **Git Errors**: Make sure Git is properly installed on both your local machine and EC2 instance
- **Build Script Issues**: See the DEVELOPMENT.md file for detailed troubleshooting

## Security Considerations

This tool is designed for educational purposes. For production environments, consider:

- Secure credential storage (not plain text)
- SSH key passphrase protection
- Proper access control for the Git user
- HTTPS for all communications
- Input validation and sanitization
- Regular security updates for all components

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

For detailed development information, see the DEVELOPMENT.md file.

## License

MIT

## Acknowledgements

This project was created to help beginners learn AWS EC2 and Git workflows in a simplified manner. It combines multiple technologies to provide a seamless experience for students learning cloud and version control concepts.
