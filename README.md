## mathGeometry / VJ Fractal & Geometry Engine

Aplicación para exploración visual y performance en vivo (VJing) basada en geometría procedural y fractales renderizados con Three.js / React Three Fiber, con un backend Express para presets, secuencias y animaciones.

### Características principales
- Motor de fractales (Mandelbrot, Julia, Barnsley, Dragon, Lorenz, Koch, Menger, Sierpinski 3D, L-Systems, Burning Ship, etc.)
- Evolución / interpolación de parámetros ("Evolution" classes) para animaciones suaves
- Contextos React para manejar animaciones, presets y secuencias
- Paneles de control (control panel, timeline editor, sequence recorder, VJ interface)
- Backend Node/Express con endpoints REST para animaciones, presets y secuencias
- Infraestructura Docker + Nginx para servir cliente y API

### Estructura del repositorio
```
root
	client/              # Frontend React + Vite + React Three Fiber
		src/components/    # UI y vistas (FractalEngine, TimelineEditor, VJInterface, etc.)
		src/engine/        # Implementaciones de fractales y registro
		src/hooks/         # Hooks personalizados (useFractal, useAnimation, useWebGL,...)
		src/contexts/      # React Contexts (Animation, Preset, Sequence)
	server/              # Backend Express + TypeScript
		src/controllers/   # Controladores REST
		src/routes/        # Rutas Express
		src/models/        # Tipos / modelos compartidos
		src/database/      # Schema SQL y setup
		tests/             # Pruebas (health test base)
	nginx/               # Configuración de Nginx para despliegue
	docker-compose*.yml  # Orquestación de servicios
	Dockerfile*          # Builds (prod y dev)
```

### Requisitos previos
- Node.js 18+
- npm o yarn (usa npm por defecto)
- Docker (opcional para entorno contenerizado)
- PostgreSQL (si usas el backend fuera de Docker)

### Configuración rápida (modo desarrollo)
Backend y frontend se pueden correr separados o vía Docker Compose.

#### 1. Variables de entorno
Crear un archivo `server/.env` (no versionado) basado en `server/.env.example`:
```
PORT=4000
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=mathgeometry
```

#### 2. Instalar dependencias
Desde la raíz:
```
cd client && npm install
cd ../server && npm install
```

#### 3. Base de datos
Ejecuta el schema:
```
psql -d mathgeometry -f server/src/database/schema.sql
```
O usa Docker Compose que levanta PostgreSQL.

#### 4. Ejecutar modo desarrollo sin Docker
Terminal 1 (API):
```
cd server
npm run dev
```
Terminal 2 (Frontend):
```
cd client
npm run dev
```
El frontend (Vite) normalmente en http://localhost:5173 y API en http://localhost:4000.

### Uso con Docker
```
docker compose up --build
```
Nginx expone el frontend y proxy hacia el backend.

### Scripts útiles
Frontend (client/package.json):
- (pendiente) "dev": agregar script para `vite` (recomendado).

Backend (server/package.json):
- build: Transpila TypeScript
- dev: Ejecuta con nodemon
- start: Corre versión compilada
- db:migrate: Aplica schema SQL

### Fractales y Evolución
Cada archivo en `client/src/engine/fractals/*Evolution.ts` extiende una base (`FractalBase`) y define:
- Parámetros del sistema
- Lógica de iteración / generación de puntos
- Mecanismo de transición (evolutionStep) para animar parámetros con el tiempo

El registro central está en `client/src/engine/fractals/registry.ts` para listar fractales disponibles en la UI.

### Contextos
- AnimationContext: Control de timeline / frames / loop
- PresetContext: Manejo de presets guardados
- SequenceContext: Grabación y reproducción de secuencias de cambios

### Rutas API (servidor)
- /animations
- /presets
- /sequences

### Roadmap inicial
- Añadir scripts dev/test faltantes en frontend
- Implementar pruebas unitarias (client y server) con Jest / React Testing Library
- Sistema de autenticación para presets personales
- Exportación de escenas y presets (JSON)
- Integración MIDI / WebMIDI para control en vivo
- Grabación y playback sincronizado con audio

### Contribución
1. Crear rama feature: `git checkout -b feat/nueva-funcionalidad`
2. Commit atómico: `git commit -m "feat: descripción"`
3. Rebase con main antes de PR
4. Abrir Pull Request describiendo cambios y capturas si aplica

### Licencia
MIT. Ver archivo LICENSE si se agrega (pendiente en este repo limpio).

### Notas
Este repo es una versión limpia aislada del proyecto original. El archivo `.env` no se versiona. Asegura no trabajar dentro de un repo que abarque tu home para evitar fugas de archivos.

