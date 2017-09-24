@echo off
REM --- converts a DLL to a '.a' library with a .def file
REM -- syntax = dll2lib <dllname>

if "%1" == "" goto syntax
if EXIST "%1" goto doit
goto notfound

:doit
echo dll2lib v1.0

REM *** create a .def file from the raw DLL
pexports -o %1 > %1.def

REM *** create the import library (e.g., libmydll.dll.a)
dlltool --input-def %1.def --dllname %1 --output-lib lib%1.a

REM *** did we succeed?
if EXIST "lib%1.a" echo Success! ("%1 --> lib%1.a")
goto end


:notfound
echo dll2lib v1.0
echo I cannot find "%1"
goto end

:syntax
echo dll2lib v1.0
echo syntax = "dll2lib <dllname.dll>"
echo * this produces "libdllname.a" and "dllname.def"
goto end

:end
