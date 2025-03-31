# Manage Project

A management system with Next.js frontend and Go backend.

## Docker Setup

This project uses Docker to manage development and production environments. All services (frontend, backend, and database) are containerized for consistency across environments.

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Environment Configuration

1. Copy the example environment file:

```bash
cp .env.example .env
```

2. Edit the `.env` file to customize your environment settings.

### Development Environment

Start the development environment with:

```bash
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```

This will:

- Start the Next.js frontend with hot reloading at http://localhost:3000
- Start the Go backend with hot reloading at http://localhost:8080
- Set up a PostgreSQL database at localhost:5432

### Production Environment

Start the production environment with:

```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

This will:

- Build and start the optimized Next.js frontend
- Build and start the optimized Go backend
- Set up a PostgreSQL database (not exposed to host)
- Run all services in detached mode

### Useful Commands

#### View logs

```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f frontend
docker-compose logs -f backend
docker-compose logs -f postgres
```

#### Rebuild containers

```bash
# Rebuild all containers
docker-compose -f docker-compose.yml -f docker-compose.dev.yml build

# Rebuild a specific container
docker-compose -f docker-compose.yml -f docker-compose.dev.yml build frontend
```

#### Stop containers

```bash
# Stop all containers
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## Project Structure

```
manage/
├── frontend/        - Next.js-based web application
├── backend/         - Go-based API service
├── .docker/         - Docker configuration files
│   ├── postgres/    - PostgreSQL initialization scripts
│   ├── frontend.Dockerfile
│   └── backend.Dockerfile
└── docker-compose.yml - Main Docker Compose configuration
```

## Database Migrations

The initial database schema is set up automatically in development. For subsequent migrations:

1. Connect to the database container:

```bash
docker-compose exec postgres psql -U postgres -d manage
```

2. Apply your SQL migrations or use a migration tool.

## Accessing the Application

- Frontend: http://localhost:3000
- Backend API: http://localhost:8080
- Database (in development): localhost:5432 (User: postgres, Password: postgres)
