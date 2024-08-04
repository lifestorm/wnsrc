..\..\..\bin\gmad.exe create -out .\gma.gma -warninvalid -folder "%~dp0
..\..\..\bin\gmpublish.exe update -id 415143062 -addon .\gma.gma
..\..\..\bin\gmpublish.exe update -id 415143062 -icon "%~dp0/icon.jpg"
del .\gma.gma
pause