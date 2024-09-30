@echo off
:: Vamos a hacer un script que le de la bienvenida al usuario cada vez que inicie el sistema.
:: Script que le de la bienvenida al usuario cada vez que inicie el sistema.
:: Incluye automatización de mensaje através de WhatsApp Web.
:: By D4vy_prz el 12/01/2023. // Modificado a 22/04/2024

:: Establecemos las variables de usuario y hora.
set "usuario=%username%"
set "hora_actual=%time:~0,2%"
Echo.
:: Adaptación de la bienvenida según la hora del día.
if %hora_actual% LSS 12 (
    echo ==============================================
    echo Buenos dias, bienvenido al sistema %username%!
    echo ==============================================
) else if %hora_actual% LSS 21 (
    echo ================================================
    echo Buenas tardes, bienvenido al sistema %username%!
    echo ================================================
) else (
    echo ===============================================
    echo Buenas noches, bienvenido al sistema %username%!
    echo ===============================================
)
Echo.

:: Fumanda para la fecha y hora actual.
for /f "tokens=1-3 delims=/" %%a in ("%DATE%") do (
    set "dia=%%a"
    set "mes=%%b"
    set "año=%%c"
)

for /f "tokens=1-3 delims=:." %%a in ("%TIME%") do (
    set "hora=%%a"
    set "minutos=%%b"
    set "segundos=%%c"
)
:: Elimina el decimal después de los segundos
set "segundos=%segundos:~0,2%"

:: Fumada para obtener el día de la semana actual en formato númerico y se le asgina una variable.
for /f %%a in ('wmic path win32_localtime get dayofweek ^| findstr /r "[0-9]"') do set day=%%a

:: Aquí según la variable concida responderá el día en el que actualemente estemos.
if "%day%"=="1" (
    echo Hoy es Lunes %dia%-%mes%-%año% y son las %hora%:%minutos%:%segundos%
    echo.
    echo.
) else if "%day%"=="2" (
    echo Hoy es Martes %dia%-%mes%-%año% y son las %hora%:%minutos%:%segundos%
    echo.
    echo.
) else if "%day%"=="3" (
    echo Hoy es Miercoles %dia%-%mes%-%año% y son las %hora%:%minutos%:%segundos%
    echo.
    echo.
) else if "%day%"=="4" (
    echo Hoy es Jueves %dia%-%mes%-%año% y son las %hora%:%minutos%:%segundos%
    echo.
    echo.
) else if "%day%"=="5" (
    echo Hoy es Viernes %dia%-%mes%-%año% y son las %hora%:%minutos%:%segundos%
    echo.
    echo.
) else if "%day%"=="6" (
    echo Hoy es Sabado %dia%-%mes%-%año% y son las %hora%:%minutos%:%segundos%
    echo.
    echo.
) else if "%day%"=="7" (
    echo Hoy es Domingo %dia%-%mes%-%año% y son las %hora%:%minutos%:%segundos%
    echo.
    echo.
) else (
    echo Error: El dia de la semana es invalido!
)
echo.
pause
echo.
:: ---------------------------------------------------------------------------------------------------------------------
:: Configuremos para comprobar si tiene que hacer una copia de seguridad (dias 1 y 15 de cada mes)
:: Comprobación si es el día 1 o 15 de cada mes para la copia de seguridad.
:Copia
if "%dia%"=="01" (
    goto :EjecutarCopia
) else if "%dia%"=="15" (
    goto :EjecutarCopia
) else (
    echo Hoy no toca hacer copias de seguridad...
    echo.
)

timeout /t 5
goto :Mensaje

:EjecutarCopia

Echo Hoy es dia %day%, toca realizar copias de seguridad...
Echo Espera mientras se realiza la copia automaticamente
Echo.
timeout /t 3

:: Tonterias de Windows para evitar fallos y que todo vaya de chill.
:: Establecer entorno local y habilitar expansiones retardadas y extensiones de comandos
SetLocal EnableDelayedExpansion EnableExtensions

:: Mostrar mensaje de bienvenida
Echo.
Echo.
Echo============================================================
Echo= BIENVENIDO AL GENERADOR DE COPIAS... 
Echo============================================================
Echo.
Echo.
Echo. Copiando archivos, espere...
Echo.

:: Llamar a la función que copia solo los archivos nuevos o modificados
call :CopiarArchivos "C:\Users\dpere.DESKTOP-JN022TD\OneDrive\Documentos\DocsLearn" "S:\COPIAS_SEGURIDAD_DPC"

:: Función para copiar solo archivos nuevos o modificados
:CopiarArchivos
:: Obtener argumentos de la función
set "origen=%~1"
set "destino=%~2"

:: Copiar archivos nuevos o modificados
robocopy "%origen%" "%destino%" /e /r:1 /w:1 /mir /xo
:: Mostrar mensaje de copia finalizada
Echo.
Echo. COPIA FINALIZADA.
Echo.
Pause
:: ---------------------------------------------------------------------------------------------------------------------
:: Configuremos para comprobar si tiene que enviar mensajes (dias 15 y 18 de cada mes)
:Mensaje
if "%dia%"=="15" (
    goto :MensajeAutomatico1
) else if "%dia%"=="18" (
    goto :MensajeAutomatico2
) else (
    echo No hay ningun mensaje que enviar...
    echo.
)

timeout /t 5
goto :Final

:MensajeAutomatico1
echo.
echo==============================================
echo EJECUTANDO ENVIO AUTOMATICO DE MENSAJES...
echo==============================================
echo.
:: Todo esta en la URL, no consigo mejor manera de hacerlo... Diosito iluminame.
:Accion
start chrome "https://web.whatsapp.com/send?phone=+34634428946&text=*Notificacion Mensual:* Se recuerda al usuario abonar su correspondiente parte para el uso de la plataforma de streaming HBO Max antes de *7 dias*. El correspondiente parte de *5,00 EUR*."
echo Se esta ejecuntado el envio, por favor espere...
timeout /t 30
echo.
:: Es de hombre sabido que mejor el remedio que la enfermedad, preguntar es de caballeros...
:Pregunta2
echo ¿El mensaje ha sido enviado correctamente? (S/N)
set /p respuesta2=
if /i "%respuesta2%"=="S" (
    echo Listo, el mensaje ha sido enviado correctamente.
) else if /i "%respuesta2%"=="N" (
    echo Entendido volvemos a intentarlo.
    echo.
    goto Accion
) else (
    echo Respuesta no válida. Por favor, introduce S para Sí o N para No.
    goto Pregunta1
)

:MensajeAutomatico2
echo.
echo==============================================
echo EJECUTANDO ENVIO AUTOMATICO DE MENSAJES...
echo==============================================
echo.
:: Todo esta en la URL, no consigo mejor manera de hacerlo... Diosito iluminame.
:Accion
start chrome "https://web.whatsapp.com/send?group=🥐MILEURISTAS🥐&text=*Notificacion Mensual:* Se recuerda a los usuarios abonar su correspondiente parte para el uso de la plataformas de streaming Disney+ antes de *7 dias*. @Pandigata *4,00 EUR* y @BOBO  *4,00 EUR*."
echo Se esta ejecuntado el envio, por favor espere...
timeout /t 30
echo.
:: Es de hombre sabido que mejor el remedio que la enfermedad, preguntar es de caballeros...
:Pregunta2
echo ¿El mensaje ha sido enviado correctamente? (S/N)
set /p respuesta2=
if /i "%respuesta2%"=="S" (
    echo Listo, el mensaje ha sido enviado correctamente.
) else if /i "%respuesta2%"=="N" (
    echo Entendido volvemos a intentarlo.
    echo.
    goto Accion
) else (
    echo Respuesta no válida. Por favor, introduce S para Sí o N para No.
    goto Pregunta1
)
:: ---------------------------------------------------------------------------------------------------------------------
:: Momento de la despedida.
:Final
if %hora_actual% LSS 12 (
    echo ==============================================
    echo "Espero que tengas una maravilloso dia %username%!"
    echo ==============================================
) else if %hora_actual% LSS 21 (
    echo ================================================
    echo "Espero que tengas una maravilloso tarde %username%!"
    echo ================================================
) else (
    echo ===============================================
    echo "Espero que tengas una maravillosa noche %username%!"
    echo ===============================================
)
Echo.
pause
exit