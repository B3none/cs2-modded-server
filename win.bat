@echo off
set ROOT_DIR=%~dp0
title CSGO
if not exist win.ini copy NUL win.ini
for /f %%S in (win.ini) do set %%S
cls
echo If you want to quit, close the SRCDS window and type Y followed by Enter.
:start
echo (%time%) Using SteamCMD to check for updates.
start /wait %ROOT_DIR%steamcmd\steamcmd.exe +login anonymous +force_install_dir ../server +app_update 730 +quit
echo (%time%) Copying mod files.
xcopy "%ROOT_DIR%game\csgo\*" "%ROOT_DIR%server\game\csgo\" /K /S /E /I /H /Y >NUL
echo (%time%) Copying custom files from "%custom_folder%".
xcopy "%ROOT_DIR%%custom_folder%\*" "%ROOT_DIR%server\game\csgo\" /K /S /E /I /H /Y >NUL
echo (%time%) CS2 started.
start /wait %ROOT_DIR%server\game\bin\win64\cs2.exe -dedicated -console -debug -condebug -usercon +game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2 +hostport %csgo_port% -ip 0.0.0.0 +net_public_adr %ip_internet% -tickrate %csgo_tickrate% -maxplayers %csgo_players% -authkey %csgo_api_key%
echo (%time%) WARNING: SRCDS closed or crashed.
pause