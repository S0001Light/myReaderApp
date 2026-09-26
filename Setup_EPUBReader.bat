@echo off
setlocal EnableExtensions

cd /d "%~dp0"
set "DEST=%~dp0EPUBReader"

echo ========================================
echo       EPUB Reader Setup
echo ========================================
echo.

for %%F in (rootOfFolder.zip part1.zip part2.zip part3.zip part4.zip part5.zip) do (
    if not exist "%%F" (
        echo ERROR: Missing %%F
        pause
        exit /b 1
    )
)

if exist "%DEST%" (
    echo Removing old EPUBReader folder...
    rmdir /s /q "%DEST%"
)

mkdir "%DEST%" || goto :error
mkdir "%DEST%\wwwroot" || goto :error

echo Extracting main project files...
tar -xf "rootOfFolder.zip" -C "%DEST%" || goto :error

for %%F in (part1.zip part2.zip part3.zip part4.zip part5.zip) do (
    echo Extracting %%F to wwwroot...
    tar -xf "%%F" -C "%DEST%\wwwroot" || goto :error
)

echo.
echo ========================================
echo Setup complete.
echo Project folder:
echo %DEST%
echo ========================================
echo.
echo To build and run:
echo   cd /d "%DEST%"
echo   dotnet restore
echo   dotnet build -c Release
echo   dotnet run -c Release
echo.
pause
exit /b 0

:error
echo.
echo ERROR: Setup failed.
pause
exit /b 1
