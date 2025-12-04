## Imagen base de Tomcat con JDK 17 (versión nueva, estable)
FROM tomcat:9.0.80-jdk17 AS builder

# Desactivar container support que rompe Tomcat en Railway
ENV JAVA_OPTS="-Dcom.sun.management.disableContainerSupport=true"

# Instalar Ant y wget para descargar librerías
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Copiar código fuente
WORKDIR /build
COPY . .

# Descargar librerías necesarias (javax.mail y javax.activation)
RUN mkdir -p web/WEB-INF/lib && \
    cd web/WEB-INF/lib && \
    wget -q https://repo1.maven.org/maven2/com/sun/mail/javax.mail/1.6.2/javax.mail-1.6.2.jar && \
    wget -q https://repo1.maven.org/maven2/javax/activation/activation/1.1.1/activation-1.1.1.jar && \
    echo "Librerías descargadas:" && \
    ls -lh *.jar

# Compilar el proyecto (genera dist/ROOT.war)
# Primero intentar con build-simple.xml, si falla usar el WAR existente
RUN echo "=== Iniciando build con Ant ===" && \
    if [ -f build-simple.xml ]; then \
        echo "Usando build-simple.xml..." && \
        ant -f build-simple.xml dist && \
        echo "=== Build completado ===" && \
        ls -lh dist/ROOT.war; \
    elif [ -f dist/ROOT.war ]; then \
        echo "Build simplificado no disponible, usando WAR existente..." && \
        ls -lh dist/ROOT.war; \
    else \
        echo "ERROR: No se puede compilar y no hay WAR existente" && \
        exit 1; \
    fi && \
    echo "=== Verificando que el WAR existe ===" && \
    test -f dist/ROOT.war || (echo "ERROR: WAR no generado" && exit 1)

# Etapa final: imagen de runtime
FROM tomcat:9.0.80-jdk17

# Desactivar container support que rompe Tomcat en Railway
ENV JAVA_OPTS="-Dcom.sun.management.disableContainerSupport=true"

# Eliminar aplicaciones por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar WAR compilado (o existente como fallback) y archivos web
COPY --from=builder /build/dist/ROOT.war /tmp/CEPP.war
COPY web/ /tmp/web-updates/

# Instalar unzip si no está disponible
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Railway ignora EXPOSE, pero lo dejamos
EXPOSE 8080

# Crear script de inicio que configura el puerto dinámicamente
RUN echo '#!/bin/bash\n\
set -e\n\
# Obtener el puerto de Railway o usar 8080 por defecto\n\
if [ -z "$PORT" ]; then\n\
  export PORT=8080\n\
fi\n\
# Validar que el WAR existe y no está corrupto\n\
echo \"Validando WAR...\"\n\
if [ ! -f /tmp/CEPP.war ]; then\n\
  echo \"ERROR: WAR no encontrado en /tmp/CEPP.war\"\n\
  exit 1\n\
fi\n\
# Verificar que es un archivo ZIP válido\n\
if ! unzip -t /tmp/CEPP.war > /dev/null 2>&1; then\n\
  echo \"ERROR: WAR corrupto o inválido\"\n\
  exit 1\n\
fi\n\
echo \"WAR válido, descomprimiendo...\"\n\
# Descomprimir WAR y copiar archivos actualizados\n\
mkdir -p /usr/local/tomcat/webapps/ROOT\n\
cd /usr/local/tomcat/webapps/ROOT\n\
# Usar unzip con opciones más permisivas para evitar errores de zip bomb\n\
unzip -qo /tmp/CEPP.war || {\n\
  echo \"ERROR al descomprimir WAR\"\n\
  exit 1\n\
}\n\
# Copiar TODOS los archivos web actualizados (sobrescribe archivos del WAR)\n\
echo \"Copiando archivos web actualizados...\"\n\
if [ -d /tmp/web-updates ]; then\n\
  cp -rf /tmp/web-updates/* .\n\
fi\n\
# Verificar que informes7.jpg esté presente\n\
echo \"Verificando archivos...\"\n\
ls -la assets/informes/informes7.jpg 2>/dev/null && echo \"✅ informes7.jpg encontrado\" || echo \"❌ WARNING: informes7.jpg NO encontrado\"\n\
ls -la assets/informes/ | head -10\n\
# Modificar server.xml en tiempo de ejecución con el puerto correcto\n\
# Primero restaurar si tiene ${PORT} literal, luego reemplazar 8080\n\
sed -i "s/port=\"\\${PORT}\"/port=\"8080\"/g" /usr/local/tomcat/conf/server.xml\n\
sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /usr/local/tomcat/conf/server.xml\n\
# Iniciar Tomcat\n\
exec catalina.sh run' > /start.sh && chmod +x /start.sh

# Usar nuestro script de inicio
CMD ["/start.sh"]
