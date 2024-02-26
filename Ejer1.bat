@echo off
:menu
cls
echo.
echo ============MENU BIENVENIDAD==========
echo 1 - Mostrar mensaje de Bienvenida
echo 2 - Mostrar Fecha y Hora Actuales
echo 3 - Salir
echo ======================================
echo.
set /p opcion=Ingrese una opcion y presione ENTER:

if "%opcion%"=="1" goto Opcion1
if "%opcion%"=="2" goto Opcion2
if "%opcion%"=="3" goto Fin

echo Opcion invalida, intente de nuevo, pulsa cualquier tecla para volver al menu
pause
goto menu

:Opcion1
echo Bienvenido al programa de Carlos Uriel
pause
goto menu

:Opcion2
echo Fecha:
date /t
echo Hora:
time /t
pause
goto menu

:Fin
echo Gracias por usar el programa
pause