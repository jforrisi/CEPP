# 🚀 Instrucciones para GitHub Codespaces

## Paso 1: Abrir Codespace
1. Ve a tu repo: https://github.com/jforrisi/CEPP
2. Haz clic en el botón verde **"Code"**
3. Selecciona la pestaña **"Codespaces"**
4. Haz clic en **"Create codespace on main"**
5. Espera 2-3 minutos a que se cree el entorno

---

## Paso 2: Construir la imagen Docker

Una vez que Codespaces esté listo, verás una terminal en la parte inferior. Ejecuta:

```bash
docker build -t cepp-local .
```

Esto construirá la imagen Docker. Puede tardar 1-2 minutos la primera vez.

---

## Paso 3: Ejecutar el contenedor

```bash
docker run -p 8080:8080 cepp-local
```

---

## Paso 4: Abrir la aplicación

1. Codespaces detectará automáticamente que hay algo corriendo en el puerto 8080
2. Verás una notificación o un botón que dice **"Open in Browser"** o **"Ports"**
3. Haz clic en ese botón, o:
   - Ve a la pestaña **"Ports"** en la parte inferior
   - Haz clic derecho en el puerto 8080
   - Selecciona **"Open in Browser"**

La web se abrirá en una nueva pestaña del navegador.

---

## 🛑 Para detener el servidor

Presiona `Ctrl+C` en la terminal donde está corriendo Docker.

---

## 📝 Notas

- **Primera vez:** La construcción de la imagen puede tardar unos minutos
- **Puerto:** Codespaces automáticamente expone el puerto 8080 públicamente
- **URL:** Codespaces te dará una URL temporal tipo: `https://xxxxx-8080.preview.app.github.dev`

---

## 🐛 Si algo falla

1. Verifica que el archivo `dist/CEPP.war` exista:
   ```bash
   ls -la dist/
   ```

2. Verifica que Docker esté funcionando:
   ```bash
   docker --version
   ```

3. Si hay errores, comparte el mensaje de error y te ayudo a solucionarlo.


