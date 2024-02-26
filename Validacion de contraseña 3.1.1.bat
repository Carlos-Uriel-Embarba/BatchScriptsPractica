@echo off
setlocal enabledelayedexpansion

set /p "correcta=Guarda una contraseña:"
echo ==================================
echo Ingrese la contraseña para iniciar
echo ==================================

set "intentos=3"

:inicio
set /p "con_ingresada=Contraseña: "
if "!con_ingresada!" equ "!correcta!" (
    echo Acceso concedido
) else if "!con_ingresada!" neq "!correcta!" (
    echo Contraseña incorrecta, acceso denegado
    set /a "intentos-=1"
    echo Tienes !intentos! intentos restantes
) else (
        echo Has agotado tus intentos. Acceso denegado.
    )

pause