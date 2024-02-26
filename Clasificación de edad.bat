@echo off
setlocal enabledelayedexpansion
:inicio
echo ==========================
echo     Introduce tu edad
echo ==========================
set /p edad=Edad:

if !edad! leq 0 (
    echo Error-Edad invalida
     goto inicio
) else if !edad! lss 13 (
    echo Eres un niño.
) else if !edad! lss 18 (
    echo Eres un adolescente.
) else (
    echo Eres un adulto.
)

pause
