@echo off
set /a n=%RANDOM% %% 20 + 1
set intentos=1
echo %n%
echo =====ADIVINA EL NUMERO=====
:inicio
set /p intro=Introduce tu numero:
set /a intentos+=1
IF %n% equ %intro% (
    goto fin
)
If %intro% lss %n% (
    cls
        echo =====ADIVINA EL NUMERO=====
        echo Tu numero es menor que el seleccionado
        goto inicio
    )
IF %intro% gtr %n% (
        cls
        echo =====ADIVINA EL NUMERO=====
        echo Tu numero es mayor que el seleccionado
        goto inicio
    )

:fin 
echo =====ENHORABUENA=====
echo Enhorabuena has acertado el numero en %intentos% intentos
pause