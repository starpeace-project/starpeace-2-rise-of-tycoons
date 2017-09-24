{
Test program for unzip, using Delphi component/Pascal object
}
PROGRAM Test3;

{$i unzip.inc}

USES
{$ifdef MSWINDOWS}
  {$ifdef Win16}
  Wincrt,
  Winprocs,
 {$else}
  Windows,
  Messages,
 {$endif}
{$endif MSWINDOWS}
{$ifdef Delphi}
  Sysutils,
{$else}
{$ifdef __GPC__} GPC, {$endif}
  Strings,
{$endif Delphi}
  ziptypes,
  chfunzip;

{$ifdef Delphi32}{$apptype console}{$endif}

{/////////////////////////////////////////////////////}
PROCEDURE Report ( Retcode : longint;R : pReportRec );
{$ifdef USE_STDCALL}STDCALL;{$else}{$ifdef MSWINDOWS}EXPORT;{$endif}{$endif}
BEGIN
  WITH r^ DO
  CASE Status OF
  file_completed :
   Writeln
   (
   UnzipMethods [ packmethod ] : 9,
   '  ', Size : 9,
   '  ', CompressSize : 9,
   '  ', Ratio : 5, '%',
   '  ', strpas ( filename )
   );
   unzip_completed :
   Writeln
   (
   'Archived' : 9,
   '  ', Size : 9,
   '  ', CompressSize : 9,
   '  ', Ratio : 5, '%',
   '  ', strpas ( filename )
   );

 END {case}
END; {Report}
{/////////////////////////////////////////////////////}
PROCEDURE Report2 ( Retcode : longint;R : pReportRec );
{$ifdef USE_STDCALL}STDCALL;{$else}
{$ifdef MSWINDOWS}EXPORT;{$endif}{$endif}
BEGIN
   WITH r^ DO
   Writeln
   (
   UnzipMethods [ packmethod ] : 9,
   '  ', Size : 9,
   '  ', CompressSize : 9,
   '  ', Ratio : 5, '%',
   '  ', strpas ( filename )
   );
END; {Report2}
{/////////////////////////////////////////////////////}
{/////////////////////////////////////////////////////}
VAR
Zip : TChiefUnzip;
i : integer;
p : pchar;
NoRecurse : Boolean;

BEGIN
  IF ( paramcount < 2 )
  THEN BEGIN
    getmem ( p, 512 );
    strcopy ( p, 'Syntax=TEST3 <filename.ZIP> <[target dir] or [/v]> [specs] [/D-]'#13#10#13#10 );
    Strcat ( p, 'Examples: '#13#10 );
    Strcat ( p, '    TEST3 TEST.ZIP C:\TEMP'#13#10 );
    Strcat ( p, '    TEST3 TEST.ZIP C:\TEMP *.PAS'#13#10 );
    Strcat ( p, '    TEST3 TEST.ZIP C:\TEMP ZIP*.*'#13#10 );
    Strcat ( p, '    TEST3 TEST.ZIP C:\TEMP /D-'#13#10 );
    Strcat ( p, '    TEST3 TEST.ZIP /V'#13#10 );
    Strcat ( p, '    TEST3 TEST.ZIP /V *.EXE'#13#10 );

  {$ifdef MSWINDOWS}
     Messagebox ( 0, p, 'Chief''s UNZIP', 0 );
  {$else}
     Writeln ( p );
  {$endif}
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
  NoRecurse := Upper ( paramstr ( ParamCount ) ) = '/D-';{/D- = don't recurse}

  Zip {$ifdef Delphi} := TChiefUnzip{$endif}.Create{$ifdef Delphi} ( NIL ) {$endif};
  WITH Zip DO BEGIN
     {$ifdef Delphi}
       ZipFileName := ParamStr ( 1 );
       TargetDirectory := ParamStr ( 2 );
       IF ( NOT NoRecurse ) OR ( ParamCount > 3 ) THEN FilesToExtract := ParamStr ( 3 );
       DontRecurse := NoRecurse;
       ReportProc := Report;
     {$else}
       SetFileName ( ParamStr ( 1 ) );
       SetDirectoryName ( ParamStr ( 2 ) );
       IF ( NOT NoRecurse ) OR ( ParamCount > 3 ) THEN SetFileSpecs ( ParamStr ( 3 ) );
       SetNoRecurse ( NoRecurse );
       SetReportProc ( {$ifdef UseAT}@{$endif}Report );
     {$endif}
       IF ( upper ( paramstr ( 2 ) ) = '/V' ) OR ( upper ( paramstr ( 2 ) ) = '-V' )
       THEN BEGIN
          SetReportProc ( {$ifdef UseAT}@{$endif}Report2 );
          i := Zip.List
       END
       ELSE i := Unzip;
       Destroy;
  END; {With Zip}
END.

