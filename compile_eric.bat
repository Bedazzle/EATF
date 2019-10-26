set PY=c:\Python37\python.exe
set BASEDIR=..\..\Dropbox\
set SKOOL=%BASEDIR%HOTMDFL\emu\skoolkit-7.2
set TOOLS=%BASEDIR%_zx_tools\

cls
%TOOLS%sjasmplus.exe eric_decoded.asm
pause

%TOOLS%py_diff_bin.py
pause

%PY% %SKOOL%\bin2tap.py --clear 24999 --org 32768 --start 32768 eric_decoded.bin eric_decoded.tap
pause