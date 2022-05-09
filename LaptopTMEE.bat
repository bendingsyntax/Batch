::This batch file was written by Daniel De Jesus
::Verson 1.8

@echo off
powershell.exe Enable-ComputerRestore -Drive C:
vssadmin Resize ShadowStorage /For=C: /On=C: /MaxSize=10%%
cls
powercfg -h off
echo Sleep has been disabled (Required for TMEE)
echo Restore point set to 10%%
manage-bde.exe -off c: > bitlockerstatus.txt 2>&1
findstr /m "ERROR" bitlockerstatus.txt
if %errorlevel%==0 (
del bitlockerstatus.txt
cls
echo Starting TMEE Encryption.
::TMEE generated command goes here
echo TMEE has been initiated, system will now wait 5 minutes and then will reboot
timeout 300 /nobreak
shutdown /r /t 0
) else (
del bitlockerstatus.txt
echo Bitlocker was enabled
echo Decryption started please wait 10 minutes
timeout 600 /nobreak
cls
echo Starting TMEE Encryption.
::TMEE generated command goes here
echo TMEE has been initiated, system will now wait 5 minutes and then will reboot
timeout 300 /nobreak
shutdown /r /t 0
)



:: CHANGE LOG
::1.8
:: added command to disable sleep because TMEE needs it off
::1.7
:: added restore point command to set to 10%
::1.6
:: added nobreak to timeouts
::1.5
:: added timeouts that will display the time in seconds
::1.4
:: added clear screen command as well as reboot commands
::1.3
:: added echo statments for status
::1.2
:: added if else statment to validate bitlocker command (creates "Check" file and deletes)
::1.1
:: added bitlocker decrypt command
::1.0
:: Batch file created with correct TMEE command 02/24/2022
