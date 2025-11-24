@echo off
echo Construyendo imagen Docker...
docker build -t cepp-local .

echo.
echo Iniciando contenedor...
echo La web estara disponible en http://localhost:8080
echo.
echo Presiona Ctrl+C para detener el servidor
echo.

docker run -p 8080:8080 cepp-local


