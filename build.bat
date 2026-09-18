@echo off
rem ==============================================================
rem  CUGThesis build script  (Windows)
rem
rem  Usage:  build.bat            -> build demo.tex
rem          build.bat example    -> build example.tex
rem          build.bat mythesis   -> build mythesis.tex
rem
rem  Needs:  XeLaTeX (TeX Live or MiKTeX)
rem          Python + latexminted + pygments  -- only if you enabled
rem          [minted] in tcode.sty (syntax highlighting)
rem
rem  -shell-escape is harmless but only strictly needed for minted.
rem  See README.md for details.
rem ==============================================================
setlocal enabledelayedexpansion
cd /d "%~dp0"

set JOB=%1
if "%JOB%"=="" set JOB=demo

rem ---- locate xelatex: PATH first, then common install locations ----
where xelatex >nul 2>nul
if not errorlevel 1 goto found

for %%D in (
    "G:\texlive\2026\bin\windows"
    "C:\texlive\2026\bin\windows"
    "C:\texlive\2025\bin\windows"
    "D:\texlive\2026\bin\windows"
) do (
    if exist "%%~D\xelatex.exe" (
        set "PATH=%%~D;!PATH!"
        set "TLROOT=%%~D"
    )
)

where xelatex >nul 2>nul
if errorlevel 1 (
    echo [ERROR] xelatex not found.
    echo         Install TeX Live, or add its bin\windows folder to PATH,
    echo         or extend the location list inside this script.
    exit /b 1
)

:found

rem ---- fontconfig: some TeX Live installs need it spelled out ----
rem      (the font caching step is normally done by the installer)
for %%F in (
    "G:\texlive\2026\texmf-var\fonts\conf\fonts.conf"
    "C:\texlive\2026\texmf-var\fonts\conf\fonts.conf"
) do (
    if exist %%F set "FONTCONFIG_FILE=%%~F"
)

echo ==== pass 1 ====
xelatex -shell-escape -interaction=nonstopmode "%JOB%.tex"
if errorlevel 1 goto fail

if exist "%JOB%.aux" (
    echo ==== bibtex ====
    bibtex "%JOB%"
)

echo ==== pass 2 ====
xelatex -shell-escape -interaction=nonstopmode "%JOB%.tex" >nul
echo ==== pass 3 ====
xelatex -shell-escape -interaction=nonstopmode "%JOB%.tex" >nul

echo.
echo [OK] "%JOB%.pdf" done.
exit /b 0

:fail
echo.
echo [FAILED] see "%JOB%.log" for details.
exit /b 1
