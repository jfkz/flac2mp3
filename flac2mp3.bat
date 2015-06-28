@echo off
rem --------------------------------------------
rem Original code written by @jfkz
rem You can download newest version from https://github.com/jfkz/flac2mp3
rem Dont forget to setup artist and album info at the top.
rem Good luck and have a nice day!
rem License: MIT (http://opensource.org/licenses/MIT)
rem --------------------------------------------
setlocal 
set folder=MP3
set album="Album Name"
set artist="Author name"
set genre="Genre"
set year=2012
echo %folder%
mkdir %folder%
for %%F in (*.flac) do (
    echo "Decoding %%F to %%~nF.wav"
    flac -d "%%F"
    metaflac.exe --export-tags-to "%folder%/%%~nF.tags" "%%F"
    lame -V 0 "%%~nF.wav" "%folder%/%%~nF.mp3"
    id3 -12 -t "%%~nF" -a "%artist%" -l "%album%" -y %year% -g "%genre%" "%folder%/%%~nF.mp3"
    del "%%~nF.wav"
)
id3 -m "%folder%/%n %t.mp3"
@echo on