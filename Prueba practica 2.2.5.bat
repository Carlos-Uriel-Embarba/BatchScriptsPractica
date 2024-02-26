@echo off
:menu_principal
cls
echo Menú Principal
echo 1. Registrarse
echo 2. Iniciar Sesión
echo 3. Salir
set /p opcion="Seleccione una opción: "

if "%opcion%"=="1" (
    call :registrar_usuario
) else if "%opcion%"=="2" (
    call :iniciar_sesion
) else if "%opcion%"=="3" (
    exit
) else (
    echo Opción no válida. Inténtelo de nuevo.
    timeout /nobreak /t 2 >nul
    goto :menu_principal
)

:registrar_usuario
cls
echo Registrarse
set /p nombre_usuario="Ingrese su nombre de usuario: "
set /p contraseña="Ingrese su contraseña: "
set /p confirmar_contraseña="Confirme su contraseña: "

if "%contraseña%"=="%confirmar_contraseña%" (
    echo %nombre_usuario% %contraseña% >> usuarios.txt
    echo Registro exitoso. Presione Enter para volver al menú principal.
) else (
    echo Las contraseñas no coinciden. Presione Enter para volver al menú principal.
)
pause >nul
goto :menu_principal

:iniciar_sesion
cls
echo Iniciar Sesión
set /p nombre_usuario="Ingrese su nombre de usuario: "
set /p contraseña="Ingrese su contraseña: "

if exist usuarios.txt (
    findstr /i /c:"%nombre_usuario% %contraseña%" usuarios.txt >nul
    if %errorlevel% equ 0 (
        echo ¡Bienvenido!
        call :opciones_despues_inicio_sesion
    ) else (
        echo Nombre de usuario o contraseña incorrecta. Presione Enter para volver al menú principal.
        pause >nul
        goto :menu_principal
    )
) else (
    echo Nombre de usuario no encontrado. Presione Enter para volver al menú principal.
    pause >nul
    goto :menu_principal
)

:opciones_despues_inicio_sesion
:menu_despues_inicio_sesion
cls
echo Opciones después de iniciar sesión:
echo a. Modificar contraseña
echo b. Eliminar usuario
echo c. Cerrar sesión
set /p opcion="Seleccione una opción: "

if "%opcion%"=="a" (
    call :modificar_contraseña
) else if "%opcion%"=="b" (
    call :eliminar_usuario
) else if "%opcion%"=="c" (
    goto :menu_principal
) else (
    echo Opción no válida. Inténtelo de nuevo.
    timeout /nobreak /t 2 >nul
    goto :menu_despues_inicio_sesion
)

:modificar_contraseña
cls
echo Modificar contraseña
set /p nueva_contraseña="Ingrese la nueva contraseña: "
(findstr /i /v /c:"%nombre_usuario%" usuarios.txt) > usuarios_temp.txt
echo %nombre_usuario% %nueva_contraseña% >> usuarios_temp.txt
del usuarios.txt
ren usuarios_temp.txt usuarios.txt
echo Contraseña modificada. Presione Enter para volver al menú principal.
pause >nul
goto :menu_principal

:eliminar_usuario
cls
echo Eliminar usuario
(findstr /i /v /c:"%nombre_usuario%" usuarios.txt) > usuarios_temp.txt
del usuarios.txt
ren usuarios_temp.txt usuarios.txt
echo Usuario eliminado. Presione Enter para volver al menú principal.
pause >nul
goto :menu_principal
