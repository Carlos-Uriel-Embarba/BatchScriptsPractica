@echo off
:menu
cls
echo.
echo ============MENU PRINCIPAL============
echo 1 - Opcion 1
echo 2 - Opcion 2
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
echo Has selecionado la Opcion 1.
echo Aqui puedes colocar cualquier comando que desees ejecutar.
pause
goto menu

:Opcion2
echo Has selecionado la Opcion 2.
echo Aqui puedes colocar cualquier comando que desees ejecutar.
pause
goto menu

:Fin
echo Gracias por usar el programa
pause