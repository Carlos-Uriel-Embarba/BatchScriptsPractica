@echo off
setlocal enabledelayedexpansion

set /p "correcta=Contraseña:"
echo ==================================
echo Ingrese la contraseña para iniciar
echo ==================================
set /p "con_ingresada=Ingrese la contraseña: "

if "!con_ingresada!" equ "!correcta!" (
    echo Acceso concedido
) else (
    echo Contraseña incorrecta, acceso denegado
)

pause