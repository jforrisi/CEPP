# Script de verificación para CEPP
# Verifica que todos los archivos referenciados en informes.jsp existan

Write-Host "🔍 Verificando archivos de informes..." -ForegroundColor Cyan
Write-Host ""

# Leer el archivo informes.jsp
$informesJsp = Get-Content "web\informes.jsp" -Raw

# Buscar todas las referencias a imágenes
$matches = [regex]::Matches($informesJsp, 'assets/informes/([^"]+)')

$errores = 0
$ok = 0

foreach ($match in $matches) {
    $archivo = $match.Groups[1].Value
    $rutaCompleta = "web\assets\informes\$archivo"
    
    if (Test-Path $rutaCompleta) {
        Write-Host "✅ OK: $archivo" -ForegroundColor Green
        $ok++
    } else {
        Write-Host "❌ ERROR: No encontrado - $archivo" -ForegroundColor Red
        Write-Host "   Ruta esperada: $rutaCompleta" -ForegroundColor Yellow
        $errores++
    }
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "Resumen:" -ForegroundColor Cyan
Write-Host "  ✅ Archivos encontrados: $ok" -ForegroundColor Green
Write-Host "  ❌ Archivos faltantes: $errores" -ForegroundColor $(if ($errores -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($errores -gt 0) {
    Write-Host "⚠️  NO HAGAS PUSH hasta corregir estos errores!" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✅ Todo está correcto. Puedes hacer push." -ForegroundColor Green
    exit 0
}

