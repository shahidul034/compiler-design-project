@ECHO OFF
SET /A argC=0
FOR %%x IN (%*) do SET /A argC+=1
CLS
IF %argC% EQU 0 (
    SET /p fname="Enter .y filename: "
) ELSE (
    SET fname=%1
)
ECHO bisoning %fname% ...
bison -d %fname%.y
IF NOT ERRORLEVEL 1 (
    ECHO bison successful & ECHO.
    ECHO flexing ...
    flex %fname%.l
    IF NOT ERRORLEVEL 1 (
        ECHO flexing successful & ECHO.
        
        gcc %fname%.tab.c lex.yy.c -o apt
    )
	 ECHO Running %fname%.exe ... & ECHO.
	apt.exe
)
