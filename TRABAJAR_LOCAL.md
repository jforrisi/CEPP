# 🔧 Trabajar Localmente (Sin Instalar Nada)

## ✅ Opción 1: GitHub Codespaces (Recomendado)

### **Paso 1: Abrir Codespace**
1. Ve a: https://github.com/jforrisi/CEPP
2. Haz clic en el botón verde **"Code"**
3. Pestaña **"Codespaces"** → **"Create codespace on main"**
4. Espera 2-3 minutos

### **Paso 2: Construir y Ejecutar**
En la terminal de Codespaces:

```bash
# Construir la imagen
docker build -t cepp-local .

# Ejecutar el contenedor
docker run -p 8080:8080 cepp-local
```

### **Paso 3: Ver la Web**
- Codespaces detectará el puerto 8080
- Haz clic en "Open in Browser" o ve a la pestaña "Ports"
- La web estará en: `https://tu-codespace-xxxxx-8080.preview.app.github.dev`

### **Paso 4: Verificar Cambios**
1. Edita los archivos en Codespaces
2. Reconstruye: `docker build -t cepp-local .`
3. Ejecuta de nuevo: `docker run -p 8080:8080 cepp-local`
4. Recarga el navegador para ver los cambios

---

## ✅ Opción 2: Verificar Antes de Push (Sin Ejecutar)

### **Checklist de Verificación:**

1. **Verificar nombres de archivos:**
   ```bash
   # Ver qué archivos de imágenes existen
   ls web/assets/informes/
   ```

2. **Verificar referencias en código:**
   - Busca en `informes.jsp`: `informes7.png` o `informes7.jpg`
   - Asegúrate que coincidan con el archivo real

3. **Verificar sintaxis JSP:**
   - Revisa que todas las etiquetas `<img>` tengan `src` correcto
   - Revisa que los links a Google Drive estén completos

4. **Verificar estructura:**
   - Los archivos deben estar en `web/assets/informes/`
   - Las referencias deben ser relativas: `assets/informes/archivo.jpg`

---

## ✅ Opción 3: Script de Verificación Rápida

Crea un script que verifique automáticamente:

```bash
# Verificar que todos los archivos referenciados existan
grep -o 'assets/informes/[^"]*' web/informes.jsp | while read img; do
  if [ ! -f "web/$img" ]; then
    echo "❌ ERROR: Archivo no encontrado: web/$img"
  else
    echo "✅ OK: web/$img"
  fi
done
```

---

## 🐛 Problemas Comunes

### **1. Imagen no aparece:**
- ✅ Verifica la extensión: `.png` vs `.jpg`
- ✅ Verifica la ruta: debe ser `assets/informes/archivo.jpg`
- ✅ Verifica que el archivo esté en `web/assets/informes/`

### **2. Cambios no se ven en Railway:**
- ✅ Verifica que hiciste `git add` y `git commit`
- ✅ Verifica que hiciste `git push`
- ✅ Espera 2-3 minutos para que Railway termine el deploy
- ✅ Limpia la caché del navegador (Ctrl+F5)

### **3. Error 404 en Railway:**
- ✅ Verifica que el archivo esté en el repositorio (no en .gitignore)
- ✅ Verifica que el archivo esté dentro de `web/` (Tomcat sirve desde webapps/ROOT)

---

## 📝 Flujo de Trabajo Recomendado

1. **Editar localmente** (en tu PC)
2. **Abrir Codespaces** para probar
3. **Verificar** que todo funcione
4. **Hacer commit y push** solo cuando esté verificado
5. **Esperar** a que Railway actualice automáticamente

---

## 🚀 Comandos Rápidos

```bash
# Verificar cambios antes de commit
git status
git diff web/informes.jsp

# Ver qué archivos están en el repo
git ls-files web/assets/informes/

# Verificar que un archivo específico esté en el commit
git show HEAD:web/assets/informes/informes7.jpg
```


