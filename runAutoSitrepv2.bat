
::Created by Tim De Smet
::Last edit: 23/05/2021@1145
 
:: 1  7777777 555555
::111     777 55
:: 11    777  555555
:: 11   777      5555
::111  777    555555

::-------[ ENJOY ]-------
@echo off

"AutoSitRepv2.jl"
SetLocal EnableDelayedExpansion
for /f "eol=@ delims=" %%a in (AutoSitRepGeneratedLink.txt) do set l=%%a
start "" ^"!l!^"
ENDLOCAL

echo Success
pause
exit