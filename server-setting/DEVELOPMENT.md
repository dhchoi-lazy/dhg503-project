# Development Guide for AWS EC2 Repository Manager

This guide provides detailed instructions for setting up a development environment and working with the AWS EC2 Repository Manager codebase.

## Prerequisites

Before you begin development, ensure you have the following installed:

- **Python 3.8+** - Required for the backend
- **Node.js 14+** - Required for the frontend
- **Yarn** - Package manager for the frontend
- **Git** - For version control

- **Visual Studio Code** (recommended) or another IDE

## Development Scripts

The project includes two main scripts for different development workflows:

**Important:** Pay close attention to your current working directory when running backend and frontend scripts. The backend commands should be run from the `backend` directory, and the frontend commands from the `frontend` directory.

### Backend Setup

```bash
# Navigate to the backend directory
cd backend

# Install Python dependencies
pip install -r requirements.txt

# Start the backend server
python main.py
```

### Frontend Setup

The frontend is built using **React**, **TypeScript**, **Tailwind CSS**, and **shadcn/ui**.

```bash
# Navigate to the frontend directory
cd frontend

# Install dependencies
yarn

# Start the development server (with hot reloading)
yarn dev
```

#### Using shadcn/ui Components

We use `shadcn/ui` for UI components. To add a new component, run the following command from the `frontend` directory:

```bash
npx shadcn-ui@latest add <component_name>
```

Replace `<component_name>` with the name of the component you want to add (e.g., `button`, `dialog`).

When using the development server, the frontend will be available at http://localhost:5173 (or another port if 5173 is in use). The Vite development server proxies API requests to the backend running on port 80.

## Building for Production

To build the application for production:

```bash
# Build the frontend
cd frontend
yarn build

# This generates the optimized files in the dist/ directory
```

## Development Workflow

1. Make changes to the frontend or backend code
2. Test your changes using the development servers
3. Build the frontend for production when ready
4. Run the complete application to ensure everything works together

## Using uv Package Manager

The project supports using the `uv` package manager for Python dependencies, which offers faster installation:

```bash
# Install uv
pip install uv

# Create virtual environment
uv venv .venv

# Activate the environment
source .venv/bin/activate  # On Linux/macOS
.venv\Scripts\activate     # On Windows

# Install dependencies
cd backend
uv pip install -r requirements.txt
```

Both build scripts will automatically detect and use uv if it's installed.

## Troubleshooting

### Common Issues

- **"Module not found" errors**: Run `yarn` in the frontend directory to install missing dependencies
- **Backend connection errors**: Ensure the backend server is running on port 80
- **"Permission denied" when running scripts**: Run `chmod +x build-run.sh` and `chmod +x dev.sh` to make them executable
- **Port already in use**: Check if another application is using port 80, stop it or change the port in the backend config
- **Frontend not appearing**: Ensure the frontend is built properly with `yarn build` in the frontend directory

### Debugging

- Backend logs are output to the console when running `python main.py`
- Frontend development server logs are available in the console when running `yarn dev`
- Check browser console logs for frontend errors
- For API issues, use browser developer tools to inspect network requests

## Code Standards

- Follow PEP 8 guidelines for Python code
- Use ESLint with React recommended settings for JavaScript/JSX
- Write meaningful commit messages
- Document new functions and components with docstrings/comments

## Contributing

1. Create a new branch for your feature or bugfix
2. Make your changes
3. Test thoroughly
4. Submit a pull request with a clear description of the changes
