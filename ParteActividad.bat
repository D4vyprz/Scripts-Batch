@echo off
Echo.
Echo.
Echo============================================================
Echo= REGISTRO DE ACTIVIDAD... 
Echo============================================================
Echo.
Echo.

setlocal

for /f "tokens=1-2 delims= " %%a in ('time /t') do set datetime=%date% %%a
set datetime=%datetime::=-%

echo %datetime%
echo.
::Establecemos variables por preguntas
:Pregunta1
set /p nombre="Nombre del cliente: "
echo.

:Pregunta2
set /p contacto="Numero de telefono o correo electronico: "
echo.

:Pregunta3
set /p agregarDireccion="Quieres agregar direccion? (S/N): "
if /i "%agregarDireccion%"=="S" (
    set /p direccion="Cual es la direccion?: "
) else (
    echo.
    goto Pregunta4
)
echo.

:Pregunta4
set /p dispositivo="Dispositivo entregado: "
echo.

:Pregunta5
set /p modelserie="Numero de serie/Modelo: "
echo.

:Pregunta6
set /p motivo="Problema que presenta y otros datos de interes: "
echo.

:: Guarda las respuestas en un archivo de texto

REM Comprobar si el directorio existe
if not exist "%cd%\datos" (
    mkdir "%cd%\datos"
    echo Se ha creado el directorio "datos".
)

if exist "%cd%\datos" (
    echo Fecha y hora: %datetime% >> "%cd%\datos\%nombre%.txt"
    echo Nombre: %nombre% >> "%cd%\datos\%nombre%.txt"
    echo Contacto: %contacto% >> "%cd%\datos\%nombre%.txt"
    if defined direccion echo Direccion: %direccion% >> "%cd%\datos\%nombre%.txt"
    echo Dispositivo: %dispositivo% >> "%cd%\datos\%nombre%.txt"
    echo Modelo/N.Serie: %modelserie% >> "%cd%\datos\%nombre%.txt"
    echo Motivo: %motivo% >> "%cd%\datos\%nombre%.txt"
    echo.

    echo Tus respuestas han sido guardadas en %cd%\datos\%nombre%.txt
) else (
    echo No se pudo guardar el archivo de respuestas. El directorio no existe.
)

endlocal
