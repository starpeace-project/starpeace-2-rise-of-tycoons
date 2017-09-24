{
test program for unzip, using a simple Pascal object
}
PROGRAM test2;
{$I unzip.inc}

{.$M 44000, 4096, 655200}

{$ifdef MSWINDOWS}
USES
{$ifdef Win16}
  wintypes, winprocs,
{$else}
  windows, messages,
{$endif}
{$ifdef Delphi}sysutils, {$else} windos, strings, {$endif Delphi}
  unzip,
  ziptypes
{$ifdef Win16}, wincrt{$endif};
{$else}
USES
{$ifdef __GPC__}
  gpc,
{$endif}
  {$ifdef kylix}SysUtils,{$else}strings,{$endif}
  unzip,
  ziptypes;
{$endif}

{$ifdef Delphi32}{$apptype console}{$endif}

TYPE
UnZipObject = OBJECT
   CONSTRUCTOR Init ( CONST ZipFile, Directory, FileSpecs : String;Report : UnzipReportProc );
   DESTRUCTOR  Done; VIRTUAL;
   FUNCTION    Run : integer; VIRTUAL;
   FUNCTION    ViewFile : integer; VIRTUAL;
   {$ifndef __GPC__}PRIVATE{$endif}
      NoRecurse : Boolean;
      aName,
      aDir,
      aSpec : TDirType;
      ZipReport : UnzipReportProc;
END;

{/////////////////////////////////////////////////////}
PROCEDURE Report ( Retcode : longint;R : pReportRec );
{$ifdef USE_STDCALL}STDCALL;{$else}
{$ifndef NO_EXPORTS}EXPORT;{$endif}{$endif}
BEGIN
  WITH r^ DO
  CASE Status OF
  file_failure : BEGIN
     writeln ( 'ERROR extracting file: ', FromOemToDisplay ( strpas ( filename ) ), '; Errorcode=', retcode );
  END;

  file_completed :
   Writeln
   (
   UnzipMethods [ packmethod ] : 9,
   '  ', Size : 9,
   '  ', CompressSize : 9,
   '  ', Ratio : 5, '%',
   '  ', FromOemToDisplay ( strpas ( filename ) )
   );
   unzip_completed :
   Writeln
   (
   'Archived' : 9,
   '  ', Size : 9,
   '  ', CompressSize : 9,
   '  ', Ratio : 5, '%',
   '  ', FromOemToDisplay ( strpas ( filename ) )
   );

 END {case}
END; {Report}
{/////////////////////////////////////////////////////}
PROCEDURE Report2 ( Retcode : longint;R : pReportRec );
{$ifdef USE_STDCALL}STDCALL;{$else}
{$ifNdef NO_EXPORTS}EXPORT;{$endif}{$endif}
BEGIN
   WITH r^ DO
   Writeln
   (
   UnzipMethods [ packmethod ] : 9,
   '  ', Size : 9,
   '  ', CompressSize : 9,
   '  ', Ratio : 5, '%',
   '  ', FromOemToDisplay ( strpas ( filename ) )
   );
END; {Report2}
{/////////////////////////////////////////////////////}
CONSTRUCTOR UnZipObject.Init;
BEGIN
  ZipReport := Report;
  NoRecurse := Upper ( paramstr ( ParamCount ) ) = '/D-'; {/D- = don't recurse}
  IF ( NoRecurse ) AND ( ParamCount < 4 )
  THEN StrPcopy ( aSpec, '*.*' ) ELSE StrPcopy ( aSpec, FileSpecs );
  StrPcopy ( aName, ZipFile );
  IF pos ( '.', Strpas ( aName ) ) = 0 THEN StrCat ( aName, '.zip' );
  StrPcopy ( adir, Directory );
END;

DESTRUCTOR  UnZipObject.Done;
BEGIN
  SetNoRecurseDirs ( FALSE );
END;

FUNCTION    UnZipObject.Run : integer;
VAR
x : UnzipQuestionProc;
BEGIN
  SetNoRecurseDirs ( NoRecurse );
  {$ifndef UseAT}@{$endif}x := NIL;
  Run := FileUnzip ( aName, aDir, aSpec, ZipReport,
  NIL );
END;

FUNCTION    UnZipObject.ViewFile : integer;
VAR
i : longint;
BEGIN
  i := ViewZip ( aName, aSpec, {$ifdef UseAT}@{$endif}Report2 );
  {$ifdef ver70}ViewFile{$else}Result{$endif} := i;
END;

VAR
Zip : UnZipObject;
p : pchar;
BEGIN
  LowCaseFileNames := True;
  IF ( paramcount < 2 )
  THEN BEGIN
    getmem ( p, 512 );
    strcopy ( p, 'Syntax=TEST2 <filename.ZIP> <[target dir] or [/v]> [specs] [/D-]'#13#10#13#10 );
    Strcat ( p, 'Examples: '#13#10 );
    Strcat ( p, '    TEST2 TEST.ZIP C:\TEMP'#13#10 );
    Strcat ( p, '    TEST2 TEST.ZIP C:\TEMP *.PAS'#13#10 );
    Strcat ( p, '    TEST2 TEST.ZIP C:\TEMP ZIP*.*'#13#10 );
    Strcat ( p, '    TEST2 TEST.ZIP C:\TEMP /D-'#13#10 );
    Strcat ( p, '    TEST2 TEST.ZIP /V'#13#10 );
    Strcat ( p, '    TEST2 TEST.ZIP /V *.EXE'#13#10 );

  {$ifdef MSWINDOWS}
     Messagebox ( 0, p, 'Chief''s UNZIP', 0 );
  {$else MSWINDOWS}
     Writeln ( p );
  {$endif MSWINDOWS}
     freemem ( p, 512 );
     halt;
  END;

  {$ifdef Win16}
   WITH ScreenSize DO BEGIN
        x := 75;
        y := 800;
   END;
   WITH WindowOrg DO BEGIN
        x := 1;
        y := 1
   END;
  {$endif}

  WITH Zip DO BEGIN
      Init ( ParamStr ( 1 ), ParamStr ( 2 ), ParamStr ( 3 ), {$ifdef UseAT}@{$endif}Report );
      IF ( upper ( paramstr ( 2 ) ) = '/V' )
      OR ( upper ( paramstr ( 2 ) ) = '-V' )
      THEN Writeln ( Zip.ViewFile ) ELSE Writeln ( Zip.Run );
      Done;
  END;
END.

