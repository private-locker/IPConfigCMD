@echo off
title Windows Network management
netsh int ipv6 isatap set state disabled 2>NUL >NUL
netsh int ipv6 6to4 set state disabled 2>NUL >NUL
netsh interface teredo set state disable 2>NUL >NUL
netsh interface isatap state disable 2>NUL >NUL

:options
cls
echo.
echo ===============================================
echo              -REDD-'s IP Tool
echo       https://www.private-locker.com
echo ===============================================
echo                MENU OPTIONS:
echo ===============================================
echo.
echo    1 - Network IP (Displays Local IP)
echo    2 - ipconfig ALL (Displays Full Windows Output)
echo    3 - ipconfig renew (Flushes and Renews IP)
echo    4 - Ping (to Google.com)
echo    5 - Traceroute (to Google.com)
echo    6 - Public IP (of the Current Network)
echo    7 - Restart PC (Restarts PC in 60 seconds)
echo.
echo ===============================================
echo    h - Help/Commands
echo    q - Exit
echo ===============================================
echo.
set input=NULL
set /p input="Please Choose a Option #: "

if "%input%"=="1" goto:ipconfig
if "%input%"=="2" goto:ipconfigall
if "%input%"=="3" goto:renew
if "%input%"=="4" goto:ping
if "%input%"=="5" goto:tracert
if "%input%"=="6" goto:ippublic
if "%input%"=="h" goto:help
if "%input%"=="q" goto:exit
if "%input%"=="e" goto:exit
if "%input%"=="0" goto:exit
if "%input%"=="!" goto:exit
if "%input%" EQU "NULL" goto:options
echo Must choose one of the Options.
timeout /t 2 /NOBREAK >NUL
goto:options

:ipconfig
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
echo Network IP: %NetworkIP%
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options


:ipconfigall
ipconfig.exe /all
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options


:renew
ipconfig.exe /release 2>NUL >NUL
ipconfig.exe /flushdns 2>NUL >NUL
ipconfig.exe /renew 2>NUL >NUL
echo IP has been renewed.
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
echo Network IP: %NetworkIP%
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options


:ping
ping google.com
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options


:tracert
tracert google.com
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options

:restart
shutdown -r >NUL
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options

:help
echo   1 - Displays the Network IP of the current Network the Local Machine resides in.
echo.
echo   2 - Displays full output from the command ipconfig all.
echo.
echo   3 - Renews and Flushes the DNS Cache of the Local Machine and displays the current
echo       IP Address given to the Local Machine.
echo.
echo   4 - Pings Google.com to determine if there is a connection to a Active Site.
echo.
echo   5 - Performs a Traceroute to Google.com to make sure no one is redirecting your
echo       traffic.
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options

:ippublic
for /f "tokens=2 delims=: " %%A in (
  'nslookup myip.opendns.com. resolver1.opendns.com 2^>NUL^|find "Address:"'
) Do set ExtIP=%%A

Echo Current Public IP Address: %ExtIP%
echo.
echo Press ANY KEY to Continue..
pause >NUL
goto:options

:exit
echo.
echo Thank you for using this tool!
echo   https://www.private-locker.com
echo.
timeout /t 3 /NOBREAK >NUL
exit