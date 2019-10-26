set SKOOL=..\HOTMDFL\emu\skoolkit-7.2

rem set BASEDIR=f:\Backa\Dropbox\Eric\
set BASEDIR=
set PY=c:\Python37\python.exe

set TOOLS=..\_zx_tools\

rem set PY=c:\Users\Vass.Kyoto\AppData\Local\Programs\Python\Python36\python.exe
rem set BASEDIR=c:\Users\Vass.Kyoto\Dropbox\Eric\


cls
%TOOLS%sjasmplus.exe eric_decoded.asm
pause
rem sjasmplus.exe _test.asm

%TOOLS%py_diff_bin.py
pause

%PY% %SKOOL%\bin2tap.py --clear 24999 --org 32768 --start 32768 %BASEDIR%eric_decoded.bin %BASEDIR%eric_decoded.tap
pause