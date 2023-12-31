@echo off
echo Login Barcode Generator by Roshan
echo This generator was created with the assumption 
echo that the password is 4 numerical characters long.
echo Longer passwords will cause errors.
echo.
set /p "id=Enter ID: "
set /p "pw=Enter Password: "
 
 
set "data=%id%%%5Ct%pw%"
 
curl -o image.gif --data-urlencode -L "https://barcode.tec-it.com/barcode.ashx?code=Code128&translate-esc=on&data=%data%&showhrt=no&dmsize=Default"
curl --request POST http://api.labelary.com/v1/graphics --form "file=@image.gif" > temp.txt
 
setlocal enabledelayedexpansion
set "search=^XA^FO0,0"
set "replace=^XA^FO25,50"
set "input_file=temp.txt"
set "output_file=temp2.txt"
rem Read the input file line by line and replace the first occurrence of the search string
set "found=0"
(
    for /f "delims=" %%a in (%input_file%) do (
        if !found!==0 (
            set "line=%%a"
            set "line=!line:%search%=%replace%!"
            echo !line!
            set "found=1"
        ) else (
            echo %%a
        )
    )
) > %output_file%

set "search=^XZ"
set "replace=^CF0,15^FO0,170^FD----------------------------^FS^CF0,15^FO10,180^FDCut Here^FS^CF0,30^FO32,215^FDDesigned by Roshan V^FS^CF0,22^FO30,250^FDhttps://github.com/Animeboynz^FS^XZ"
set "input_file=temp2.txt"
set "output_file=Login_Barcode.txt"
rem Read the input file line by line and replace the first occurrence of the search string
set "found=0"
(
    for /f "delims=" %%a in (%input_file%) do (
        if !found!==0 (
            set "line=%%a"
            set "line=!line:%search%=%replace%!"
            echo !line!
            set "found=1"
        ) else (
            echo %%a
        )
    )
) > %output_file%
 
endlocal
 
copy Login_Barcode.txt \\127.0.0.1\Zebra

pause

DEL image.gif
DEL temp.txt
DEL temp2.txt
DEL Login_Barcode.txt

exit 0