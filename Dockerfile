## Imagen base de Tomcat con JDK 17 (versión nueva, estable)
FROM tomcat:9.0.80-jdk17

# Desactivar container support que rompe Tomcat en Railway
ENV JAVA_OPTS="-Dcom.sun.management.disableContainerSupport=true"

# Eliminar aplicaciones por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar WAR como ROOT
COPY dist/CEPP.war /usr/local/tomcat/webapps/ROOT.war

# Railway ignora EXPOSE, pero lo dejamos
EXPOSE 8080

# Crear script de inicio que configura el puerto dinámicamente
RUN echo '#!/bin/bash\n\
set -e\n\
# Obtener el puerto de Railway o usar 8080 por defecto\n\
if [ -z "$PORT" ]; then\n\
  export PORT=8080\n\
fi\n\
# Modificar server.xml en tiempo de ejecución con el puerto correcto\n\
sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /usr/local/tomcat/conf/server.xml\n\
# Iniciar Tomcat\n\
exec catalina.sh run' > /start.sh && chmod +x /start.sh

# Usar nuestro script de inicio
CMD ["/start.sh"]
