@echo off
setlocal enabledelayedexpansion
title Calculadora Basica

set "s=1"
set "r=2"
set "m=3"
:inicio

echo Introduce los numeros u operadores para la operacion
set /p n1=Introduce el primer numero:
set /p n2=Introduce el segundo numero:

echo ===============================
echo          CALCULADORA
echo ===============================
echo 1. Sumar
echo 2. Restar
echo 3. Multiplicar
echo ===============================
set /p opcion=Selecciona una opcion (1-3):


IF !opcion! EQU %s% (
    set /a suma=n1+n2
    echo El resultado de la suma es: !suma!
) ELSE IF !opcion! EQU %r% (
    set /a resta=n1-n2
    echo El resultado de la resta es: !resta!
) ELSE IF !opcion! EQU %m% (
    set /a mult=n1*n2
    echo El resultado de la multiplicacion es: !mult!
)
 FOR %%p IN (%s% %r% %m%) DO (
   IF !opcion! EQU "%%p" (
       set "opcion_valida=1"
  )
 )
 IF !opcion_valida! neq "1" (
    cls
    echo Opcion no valida. Introduce una opcion valida (1-3)
    goto inicio
 )
pause
cls
goto inicio

