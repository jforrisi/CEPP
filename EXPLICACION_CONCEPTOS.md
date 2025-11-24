# 📚 Explicación de Conceptos: WAR y Dockerfile

## 📦 ¿Qué es un WAR?

**WAR** = **W**eb **AR**chive (Archivo Web)

### **En términos simples:**
Es un archivo comprimido (como un ZIP) que contiene **toda tu aplicación web** lista para desplegarse.

### **¿Qué contiene un WAR?**
- Todos los archivos JSP (páginas web)
- Todas las imágenes, CSS, JavaScript
- Todo el código Java compilado
- Configuraciones (web.xml, etc.)
- Librerías necesarias

### **Ejemplo:**
```
CEPP.war (65 MB)
├── index.jsp
├── informes.jsp
├── assets/
│   ├── informes/
│   │   ├── informes1.png
│   │   ├── informes2.png
│   │   └── informes7.jpg  ← Si se agregó DESPUÉS, no está aquí
├── WEB-INF/
│   ├── classes/ (código Java compilado)
│   └── lib/ (librerías)
└── ...
```

### **¿Por qué se usa?**
- **Facilita el despliegue:** Un solo archivo contiene todo
- **Estándar de Java:** Todos los servidores web Java (Tomcat, etc.) entienden WAR
- **Portable:** Funciona en cualquier servidor que soporte Java

### **El problema que tuvimos:**
- El WAR se construyó **ANTES** de agregar `informes7.jpg`
- Entonces el archivo `informes7.jpg` **NO está dentro del WAR**
- Por eso no aparecía en la web

---

## 🐳 ¿Qué es un Dockerfile?

**Dockerfile** = Instrucciones para construir una "caja" (contenedor) con tu aplicación

### **En términos simples:**
Es un archivo de texto que le dice a Docker **cómo construir y ejecutar tu aplicación**.

### **¿Qué hace un Dockerfile?**
1. **Elige una imagen base** (ej: Tomcat con Java)
2. **Copia tus archivos** (WAR, configuraciones, etc.)
3. **Configura el entorno** (puertos, variables, etc.)
4. **Define cómo iniciar** la aplicación

### **Ejemplo de nuestro Dockerfile:**

```dockerfile
# 1. Usar Tomcat como base (ya tiene Java instalado)
FROM tomcat:9.0.80-jdk17

# 2. Copiar el WAR a Tomcat
COPY dist/CEPP.war /tmp/CEPP.war

# 3. Copiar archivos web actualizados
COPY web/ /tmp/web-updates/

# 4. Crear script que:
#    - Descomprime el WAR
#    - Copia archivos nuevos
#    - Configura el puerto
#    - Inicia Tomcat
RUN echo '#!/bin/bash...' > /start.sh

# 5. Ejecutar el script al iniciar
CMD ["/start.sh"]
```

### **¿Por qué se usa?**
- **Consistencia:** Funciona igual en tu PC, Railway, Codespaces, etc.
- **Aislamiento:** No interfiere con otras aplicaciones
- **Portabilidad:** "Funciona en mi máquina" → Funciona en todas partes
- **Automatización:** Railway lee el Dockerfile y despliega automáticamente

### **Flujo completo:**

```
1. Tú escribes código
   ↓
2. Construyes el WAR (o lo tienes ya hecho)
   ↓
3. Dockerfile lee las instrucciones
   ↓
4. Docker construye una "imagen" (como un molde)
   ↓
5. Docker crea un "contenedor" (instancia de la imagen)
   ↓
6. El contenedor se ejecuta y tu web está online
```

---

## 🔄 ¿Cómo trabajan juntos?

### **Problema que tuvimos:**
```
WAR (viejo) → No tiene informes7.jpg
     ↓
Dockerfile → Solo copiaba el WAR
     ↓
Resultado → informes7.jpg no aparece ❌
```

### **Solución:**
```
WAR (viejo) → No tiene informes7.jpg
     ↓
Dockerfile → Copia WAR + archivos web nuevos
     ↓
Script → Descomprime WAR + Sobrescribe con archivos nuevos
     ↓
Resultado → informes7.jpg aparece ✅
```

---

## 📝 Resumen

| Concepto | ¿Qué es? | ¿Para qué sirve? |
|----------|----------|------------------|
| **WAR** | Archivo comprimido con toda la aplicación web | Desplegar la aplicación en un servidor |
| **Dockerfile** | Instrucciones para construir un contenedor | Automatizar el despliegue en cualquier lugar |

---

## 🎯 Analogía simple

**WAR** = Una caja con todos los muebles de tu casa (aplicación)
**Dockerfile** = Las instrucciones de montaje de IKEA (cómo armar todo)

Si agregas un mueble nuevo (informes7.jpg) pero la caja ya está cerrada (WAR construido), necesitas:
- Abrir la caja (descomprimir WAR)
- Agregar el mueble nuevo (copiar archivos web)
- Cerrar la caja (listo para usar)

