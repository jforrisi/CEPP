# 🏗️ Arquitectura y URLs - CEPP

## 📍 Opciones de Despliegue

### **Opción 1: Todo en Railway (Recomendada) 🚀**

#### **Web Java/JSP (Sitio Público)**
- **URL:** `https://cepp-production.railway.app` (o tu dominio personalizado)
- **Qué es:** Tu sitio web principal que ven los usuarios
- **Tecnología:** Java + JSP + Tomcat
- **Estado:** ✅ Ya configurado (Dockerfile listo)

#### **Panel Admin Streamlit (Privado)**
- **URL:** `https://cepp-admin.railway.app` (servicio separado)
- **Qué es:** Panel de administración para subir documentos/links
- **Tecnología:** Python + Streamlit
- **Acceso:** Solo tú (puedes agregar autenticación)
- **Estado:** ⚠️ Necesita Dockerfile para Streamlit

**Flujo:**
1. Tú usas el panel admin → subes documentos/imágenes
2. Los archivos se guardan en el proyecto
3. Haces commit y push a GitHub
4. Railway detecta cambios y redeploya la web automáticamente

---

### **Opción 2: Panel Local + Web en Railway (Más Simple) 🏠**

#### **Web Java/JSP (Sitio Público)**
- **URL:** `https://cepp-production.railway.app`
- **Estado:** ✅ Ya configurado

#### **Panel Admin Streamlit (Local)**
- **URL:** `http://localhost:8501` (solo en tu computadora)
- **Uso:** Lo ejecutas cuando necesites subir contenido
- **Ventaja:** No necesitas desplegarlo, más simple
- **Desventaja:** Solo funciona cuando lo ejecutas localmente

**Flujo:**
1. Ejecutas el panel localmente
2. Subes documentos/imágenes
3. Haces commit y push a GitHub
4. Railway redeploya automáticamente

---

### **Opción 3: Mismo Dominio, Diferentes Rutas (Avanzada) 🌐**

Si tienes un dominio personalizado (ej: `www.ceppuy.com`):

- **Web:** `https://www.ceppuy.com` (o `https://www.ceppuy.com/CEPP/`)
- **Admin:** `https://admin.ceppuy.com` (subdominio)

Requiere configuración de DNS y reverse proxy.

---

## 🎯 **Mi Recomendación: Opción 2 (Panel Local)**

**¿Por qué?**
- ✅ Más simple de implementar
- ✅ No necesitas desplegar el panel
- ✅ Menos costos (solo pagas por la web)
- ✅ El panel solo lo usas tú, no necesita estar siempre online
- ✅ Más seguro (el panel no está expuesto públicamente)

**Flujo de trabajo:**
```
1. Necesitas subir un documento
2. Abres el panel local: streamlit run admin_panel.py
3. Subes el documento
4. Cierras el panel
5. Haces git commit y push
6. Railway actualiza el sitio automáticamente
```

---

## 📝 **Si Quieres la Opción 1 (Todo en Railway)**

Necesitarías crear un `Dockerfile` para Streamlit y desplegarlo como servicio separado. Puedo ayudarte con eso si quieres.

---

## 🔄 **Integración: Cómo se Conectan**

### **Opción Actual (Simple):**
- Panel guarda archivos en `web/assets/`
- Panel guarda metadatos en `content_data.json`
- Haces commit y push
- Railway redeploya con los nuevos archivos
- El sitio Java lee los archivos directamente

### **Opción Futura (Con API):**
- Panel sube archivos → API REST
- API guarda en base de datos
- Sitio Java consume la API
- Más dinámico, pero más complejo

---

## ✅ **Resumen**

**Para empezar rápido:**
- ✅ Web en Railway: `https://tu-app.railway.app`
- ✅ Panel local: `http://localhost:8501` (cuando lo necesites)
- ✅ Flujo: Panel local → Git → Railway (automático)

**¿Quieres que configure algo más?** Dime qué opción prefieres y lo configuro.



