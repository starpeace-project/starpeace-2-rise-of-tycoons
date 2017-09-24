REM **** a batch file to build the various DLLs **********

call dcc chiefzip -b
copy chiefzip.dll dll\unzipw32.dll
call clean.bat
del *.dll

call vpc -CO chiefzip -b
copy chiefzip.dll dll\unzipos2.dll
call clean.bat
del *.dll


call tpcw chiefzip /b
copy chiefzip.dll dll\unzipw16.dll
call clean.bat
del *.dll

call tpcp chiefzip /b
copy chiefzip.dll dll\unzipp16.dll
call clean.bat
del *.dll

dir dll/od
