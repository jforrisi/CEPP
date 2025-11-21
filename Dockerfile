# Usar imagen base de Tomcat con Java
FROM tomcat:9-jdk17-openjdk-slim

# Eliminar aplicaciones de ejemplo
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar el archivo WAR al directorio de aplicaciones de Tomcat
COPY dist/CEPP.war /usr/local/tomcat/webapps/ROOT.war

# Exponer el puerto (Railway asignará uno dinámicamente)
EXPOSE 8080

# Crear script para iniciar Tomcat con el puerto correcto de Railway
RUN echo '#!/bin/bash\n\
set -e\n\
if [ -z "$PORT" ]; then\n\
  export PORT=8080\n\
fi\n\
# Modificar server.xml para usar el puerto dinámico\n\
sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /usr/local/tomcat/conf/server.xml\n\
exec catalina.sh run' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]

