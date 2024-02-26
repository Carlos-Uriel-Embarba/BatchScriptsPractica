@echo off
setlocal enabledelayedexpansion

set "correcta=secreto123"

set /p "con_ingresada=Ingrese la contraseña: "

if "!con_ingresada!" equ "!correcta!" (
    echo Acceso concedido
) else (
    echo Contraseña incorrecta, acceso denegado
)

pause