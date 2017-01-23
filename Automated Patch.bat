@echo off
Pushd "%~dp0"
REM Do not change any of this code. If I find out that you have changed this code and published it for other users to use, with out asking me ahead of time, I will have to mark you as malicious on the thread. This is to protect our minecraft users. Thank you for understanding. Anything you need to change is located in the param file.


:PROMPT
echo   This is a program designed to assit in instal update patchs your minecraft instance. It does not require internet. The source code can be viewed by editing the .bat file. This program will be editing and viewing things on your hardrive. I, Miss Potato, is not liable for any damage caused by this. If you are concerned go to %THREAD% to learn more.
echo.
set /P AREYOUSURE=Would you like to continue? (Y/[N])?
if /I "%AREYOUSURE%" EQU "Y" (
    goto requiredFiles
) 
    else(
    set error=Did not accept disclaimer.
    set failReason=Restart Automated Patch and type Y.
    goto END1
)



:requiredFiles
cls
echo Checking for required file...
timeout /t 2
IF EXIST %cd%\parameters.txt (
	echo parameters.txt
	IF EXIST %cd%\newMods (
	echo newMods
		IF EXIST %cd%\newConfig\ (
			echo newConfig
			IF EXIST %cd%\version.txt (
			echo version.txt
				IF EXIST %cd%\mods\ (
				echo mods
					IF EXIST %cd%\config\ (
						echo All files found succesfully.
						timeout /t 2
						goto load
						) else (
                        set error=Missing config! 
						set failReason=Re-extract the update zip to your isntance, its the one with the old config folder. Should be something like ".../peractorum/minecraft/" If this still fails, report this to the pack dev.
						goto end1
					)
					) else (
					set error=Missing mods!
					set failReason=Re-extract the update zip to your isntance, its the one with the old mods folder. Should be something like ".../peractorum/minecraft/" If this still fails, report this to the pack dev.
					goto end1
				)
				) else (
			         set error=Missing version.txt! 
                set failReason=Re-extract the update zip to your isntance, its the one with the old version text file. Should be something like ".../peractorum/minecraft/" If this still fails, your pack does not have a version. Report this to the pack dev.
                goto end1
		)
                ) else (
            set error=Missing newConfig! 
            set failReason=Re-extract the update zip to your isntance, its the one with the configs folder. Should be something like ".../peractorum/minecraft/" If this still fails, the update does not have newConfig. Report this to the pack dev.
            goto end1
		)
		) else (
        set error=Missing newMods! 
        set failReason=Re-extract the update zip to your isntance, its the one with the old mods folder. Should be something like ".../peractorum/minecraft/" If this still fails, your pack is missing the newMods folder, report this to the pack dev.
            goto end1
		)
		) else (
    set error=Missing paramters.txt! 
    set failReason=Re-extract the update zip to your isntance, its the one with the old mods folder. Should be something like ".../peractorum/minecraft/" If this still fails, your pack is missing the paramters text file, report this to the pack dev.
goto end1
) 



:load
cls
echo Loading paramters.
for /f "delims=" %%x in (parameters.txt) do (set %%x)
set error=UNKOWN ERROR
set failReason=Fail safes failed to detect issue. Report to Miss Potato on the forum thread.
echo Pack: %pack% by %author%
echo Update version: %updateVersion%
echo Version being updated: %lastVersion%
timeout /t 2
goto currentVersion



:currentVersion
cls
echo Checking version...
for /f "delims=" %%x in (version.txt) do (set %%x)
findstr /m %lastVersion% version.txt 
if %errorlevel%==0  (
	goto :backup
) else (
     set error=Wrong version!
     set failReason=The current version of the pack miss-matches with the required pervious version. Make sure you downloaded the right patch. VERSION DETECTED %currentVersion%
     goto end1
)



:backup
cls
echo Not implimented yet, please make your own backup, if you wish!
echo Done!
pause
goto update1



:update1
cls
echo Deleting un-needed files...
for /f "usebackq" %%x in ("outdated files.txt") do (del %cd%%%x)
pause
goto update2




:update2
cls
echo Installing new files...
xcopy /e newmods mods 
xcopy /e newconfig config 
del version.txt
echo currentVersion=%updateVersion%
pause
set error=Success!
set failReason=Finished updating pack!
goto end1


:END1
cls
echo %error%
echo.
echo %failReason%
echo.
echo Safe to exit.
pause
exit