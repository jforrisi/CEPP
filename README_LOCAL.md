# 🖥️ Ejecutar CEPP Localmente

## ✅ Opción 1: Docker (Recomendada - Más Fácil)

### Requisitos:
- **Docker Desktop** para Windows: [Descargar aquí](https://www.docker.com/products/docker-desktop)

### Pasos:
1. Instala Docker Desktop y reinicia tu computadora
2. Abre PowerShell o CMD en la carpeta del proyecto
3. Ejecuta:
   ```bash
   docker build -t cepp-local .
   docker run -p 8080:8080 cepp-local
   ```
   O simplemente ejecuta el archivo `run_local.bat`

4. Abre tu navegador en: **http://localhost:8080**

### Para detener:
- Presiona `Ctrl+C` en la terminal

---

## ✅ Opción 2: Instalación Manual (Sin Docker)

### Requisitos:
1. **Java JDK 17** (o superior)
   - Descargar: [Oracle JDK](https://www.oracle.com/java/technologies/downloads/#java17) o [OpenJDK](https://adoptium.net/)
   - Verificar instalación: `java -version`

2. **Apache Tomcat 9**
   - Descargar: [Tomcat 9](https://tomcat.apache.org/download-90.cgi)
   - Extraer en una carpeta (ej: `C:\apache-tomcat-9.0.80`)

### Pasos:
1. **Configurar variables de entorno** (opcional):
   - `JAVA_HOME` = ruta a tu JDK (ej: `C:\Program Files\Java\jdk-17`)
   - `CATALINA_HOME` = ruta a Tomcat (ej: `C:\apache-tomcat-9.0.80`)

2. **Copiar el WAR a Tomcat**:
   ```bash
   copy dist\CEPP.war C:\apache-tomcat-9.0.80\webapps\ROOT.war
   ```
   (Reemplaza la ruta con tu ubicación de Tomcat)

3. **Iniciar Tomcat**:
   ```bash
   C:\apache-tomcat-9.0.80\bin\startup.bat
   ```

4. Abre tu navegador en: **http://localhost:8080**

### Para detener:
```bash
C:\apache-tomcat-9.0.80\bin\shutdown.bat
```

---

## 📝 Notas Importantes:

- **Puerto**: La aplicación corre en el puerto `8080` por defecto
- **Archivo WAR**: Ya está compilado en `dist/CEPP.war`
- **Configuración**: Si necesitas el archivo `CEPP.ini`, créalo en la raíz del proyecto o configúralo como variable de entorno

---

## 🐛 Solución de Problemas:

### Puerto 8080 ocupado:
- Cambia el puerto en `server.xml` de Tomcat (línea con `port="8080"`)
- O detén el servicio que usa el puerto 8080

### Error al iniciar:
- Verifica que Java esté instalado: `java -version`
- Verifica que el WAR exista: `dir dist\CEPP.war`


