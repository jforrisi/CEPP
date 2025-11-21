## Imagen base de Tomcat con JDK 17 (versión nueva, estable)
FROM tomcat:9.0.80-jdk17

# Desactivar container support que rompe Tomcat en Railway
ENV JAVA_OPTS="-Dcom.sun.management.disableContainerSupport=true"

# Eliminar aplicaciones por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar WAR como ROOT
COPY dist/CEPP.war /usr/local/tomcat/webapps/ROOT.war

# Modificar el puerto en el server.xml en tiempo de build
RUN sed -i 's/port="8080"/port="${PORT}"/g' /usr/local/tomcat/conf/server.xml

# Railway ignora EXPOSE, pero lo dejamos
EXPOSE 8080

# Entrypoint estándar
CMD ["catalina.sh", "run"]
