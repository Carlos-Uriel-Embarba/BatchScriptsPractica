@echo off
setlocal enabledelayedexpansion

set "intentos_maximos=3"
set "intentos_actual=0"
set "correctos=0"
set "incorrectos=0"

REM Definir el nombre del archivo de logs
set "logfile=logs.txt"

:MenuPrincipal
cls
echo =====Menú Principal=====
echo 1. Registrarse
echo 2. Iniciar Sesión
echo 3. Salir del Programa
echo =========================
REM Solicitar al usuario que seleccione una opción del menú.
set /p opcion="Seleccione una opción(1-3): "

REM Obtener la fecha y hora actual para el log
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set "datetime=%%a"
set "datetime=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2! !datetime:~8,2!:!datetime:~10,2!:!datetime:~12,2!"

REM Evaluar la opción seleccionada y llamar a la función correspondiente.
if "%opcion%"=="1" call :Registro
if "%opcion%"=="2" call :InicioSesion
if "%opcion%"=="3" exit

REM Mostrar un mensaje de error si la opción no es válida y regresar al menú principal.
echo Opción no válida. Inténtelo de nuevo.
timeout /nobreak /t 1 >nul
goto MenuPrincipal

:Registro
cls
echo ==========REGISTRO============
set /p usuario=Ingrese su nombre de usuario: 
set /p password=Ingrese su contraseña: 
set /p rep_password=Repita su contraseña: 

REM Verificar si las contraseñas coinciden y mostrar un mensaje de error si no.
if "%password%" neq "%rep_password%" (
    echo Las contraseñas no coinciden. Inténtelo de nuevo.
    timeout /nobreak /t 1 >nul
    goto Registro
)

REM Guardar la información del usuario en el archivo usuarios.txt.
echo !usuario!;!password!>> usuarios.txt
echo Registro exitoso.

REM Registrar el evento en el log
echo [!datetime!] Registro exitoso para el usuario: !usuario! >> %logfile%

timeout /nobreak /t 1 >nul
goto MenuPrincipal

:InicioSesion
cls

REM Solicitar al usuario que ingrese su nombre de usuario y contraseña.
set /p usuario=Ingrese su nombre de usuario: 
set /p password=Ingrese su contraseña: 

REM Incrementar el contador de intentos
set /a "intentos_actual+=1"

REM Iterar a través del archivo usuarios.txt para verificar las credenciales.
set "loggin="
for /f "tokens=1,* delims=;" %%a in (usuarios.txt) do (
    if "%%a"=="%usuario%" (
        if "%%b"=="%password%" (
            set "loggin=true"
            set /a "correctos+=1"
            echo Inicio de sesión exitoso.
            REM Registrar el evento en el log
            echo [!datetime!] Inicio de sesión exitoso para el usuario: !usuario! >> %logfile%
            goto InicioSesion2
        ) else (
            echo Contraseña incorrecta.
            set "loggin=false"
            set /a "incorrectos+=1"
            REM Registrar el evento en el log
            echo [!datetime!] Intento de inicio de sesión fallido para el usuario: !usuario! >> %logfile%
            if "%incorrectos%" == "%intentos_maximos%" goto EliminarUsuario2
            timeout /nobreak /t 1 >nul
            goto MenuPrincipal
        )
    )
)

if not defined loggin (
    REM set /a "incorrectos+=1"
    echo Nombre de usuario no encontrado.
    REM Registrar el evento en el log
    echo [!datetime!] Intento de inicio de sesión fallido para el usuario: !usuario! >> %logfile%
    timeout /nobreak /t 2 >nul
    goto MenuPrincipal
)

:InicioSesion2
cls
REM Solicitar al usuario que ingrese una opción posterior al inicio de sesión 
echo ========OPCIONES========
echo a. Modificar contraseña
echo b. Eliminar usuario
echo c. Inicios de sesion
echo d. Cerrar sesión

set /p opcion=Seleccione una opción: 

if "%opcion%"=="a" call :ModificarContraseña
if "%opcion%"=="b" call :EliminarUsuario
if "%opcion%"=="c" (
    cls
    echo Hay %correctos% intentos correctos 
    echo Hay %incorrectos% intentos incorrectos 
    timeout /nobreak /t 2 >nul
)
if "%opcion%"=="d" goto MenuPrincipal

echo Opción no válida. Inténtelo de nuevo.
timeout /nobreak /t 1 >nul
goto InicioSesion2

:ModificarContraseña
cls
REM Solicitar al usuario que ingrese una nueva contraseña.
set /p new_password=Nueva contraseña: 

REM Actualizar la contraseña en el archivo usuarios.txt.
(for /f "tokens=1,* delims=;" %%a in (usuarios.txt) do (
    if "%%a"=="%usuario%" (
        echo %%a;!new_password!
    ) else (
        echo %%a;%%b
    )
)) > usuarios_temp.txt

move /y usuarios_temp.txt usuarios.txt >nul
echo Contraseña modificada exitosamente.
timeout /nobreak /t 1 >nul
goto MenuPrincipal

:EliminarUsuario
cls
REM Eliminar al usuario del archivo usuarios.txt.
(for /f "tokens=1,* delims=;" %%a in (usuarios.txt) do (
    if "%%a" neq "%usuario%" (
        echo %%a;%%b
    )
)) > usuarios_temp.txt

move /y usuarios_temp.txt usuarios.txt >nul
echo Usuario eliminado exitosamente.
REM Registrar el evento en el log
echo [!datetime!] Usuario eliminado: !usuario! >> %logfile%
timeout /nobreak /t 2 >nul
goto MenuPrincipal

:EliminarUsuario2
cls
REM Eliminar al usuario del archivo usuarios.txt.
(for /f "tokens=1,* delims=;" %%a in (usuarios.txt) do (
    if "%%a" neq "%usuario%" (
        echo %%a;%%b
    )
)) > usuarios_temp.txt

move /y usuarios_temp.txt usuarios.txt >nul
echo Usuario eliminado exitosamente debido a exceso de intentos fallidos.
REM Registrar el evento en el log
echo [!datetime!] Usuario eliminado por exceso de intentos fallidos: !usuario! >> %logfile%
timeout /nobreak /t 2 >nul
goto MenuPrincipal
