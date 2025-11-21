# Despliegue en Railway

## Pasos para subir a Railway:

1. **Asegúrate de tener el archivo WAR compilado:**
   - El archivo `dist/CEPP.war` debe existir
   - Si no existe, necesitarás compilarlo (pero no necesitas Java local si usas Railway)

2. **Instala Railway CLI (opcional, también puedes usar la web):**
   ```bash
   npm install -g @railway/cli
   ```

3. **Inicia sesión en Railway:**
   ```bash
   railway login
   ```

4. **Crea un nuevo proyecto:**
   ```bash
   railway init
   ```

5. **Sube el proyecto:**
   ```bash
   railway up
   ```

   O simplemente conecta tu repositorio Git desde el dashboard de Railway.

## Variables de Entorno y Configuración:

Tu aplicación usa un archivo `CEPP.ini` para configuración. Tienes dos opciones:

### Opción 1: Usar Variables de Entorno (Recomendado)
Modifica el código para leer de variables de entorno en lugar del archivo .ini, o crea el archivo .ini en Railway usando variables.

### Opción 2: Incluir CEPP.ini en el despliegue
Si prefieres usar el archivo .ini, créalo en la raíz del proyecto con esta estructura:
```
EmailFrom=tu-email@gmail.com
EmailTo=destino@gmail.com
Contrasenia=tu-contraseña-app
DIRREPS=/ruta/reportes
DIRREPSTEMP=/ruta/temp
DIASTOLERANCIAREPORTES=30
```

**IMPORTANTE:** No subas credenciales reales al repositorio. Usa variables de entorno de Railway para datos sensibles.

## Notas:

- Railway detectará automáticamente el Dockerfile
- El puerto se configurará automáticamente
- No necesitas Java instalado localmente

