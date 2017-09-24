{
Test program for Chief's UNZIP;
  Under Windows and OS/2, it uses the DLL (in chiefzip.pas), which must be
  compiled first
}

PROGRAM Test1;
{$I unzip.inc}

{$ifdef MSWINDOWS}
USES
{$ifdef Win16}
  wintypes,
  winprocs,
{$else}
  windows,
  messages,
{$endif}
{$ifdef Delphi}
  SysUtils,
{$else Delphi}
  windos,
  strings,
{$endif Delphi}
  zipinter,
  ziptypes
  {$ifdef Win16}, WinCrt{$endif}
  ;
{$else}{MSWINDOWS}
USES
{$ifdef __GPC__}
  gpc,
{$endif} {__GPC__}
{$ifdef OS2}
  Windows,
  Sysutils,
{$else OS2}
  strings,
{$endif}{OS2}
  Ziptypes,
{$ifdef Can_Use_DLL}
  ZipInter;
{$else}
  Unzip;
{$endif}{Can_Use_DLL}
{$endif}{MSWINDOWS}

{$ifdef Delphi32}{$apptype console}{$endif}

VAR
SkipAll : Boolean;

PROCEDURE Report ( Retcode : longint;R : pReportRec );
{$ifdef USE_STDCALL}STDCALL;{$else}{$ifndef NO_EXPORTS}EXPORT;{$endif}{$endif}
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
   '  ', Strpas ( filename )
   );
   unzip_completed :
   Writeln
   (
   'Archived' : 9,
   '  ', Size : 9,
   '  ', CompressSize : 9,
   '  ', Ratio : 5, '%',
   '  ', Strpas ( filename )
   );

 END {case}
END; {Report}
{/////////////////////////////////////////////////////}
FUNCTION Ask ( R : pReportRec ) : Boolean;
{$ifdef USE_STDCALL}STDCALL;{$else}{$ifndef NO_EXPORTS}EXPORT;{$endif}{$endif}
VAR
i : integer;
s : String [1];
BEGIN
   Ask := FALSE;

   IF SkipAll THEN BEGIN
      Exit;
   END;

   WITH r^
   DO BEGIN
     {$ifdef MSWINDOWS}
       i := Messagebox
       ( 0,
       'The above file already exists! Should I overwrite it?',
       filename,
       mb_YESNOCancel );
       CASE i OF
          idYes : Ask := TRUE;
          idNo  : Ask := FALSE;
          idCancel :
          BEGIN
             Ask := FALSE;
             SkipAll := TRUE;
          END;
       END; {Case}
     {$else}
      Ask := FALSE;
      Writeln ( strpas ( filename ), ': (', Size, ' bytes)' );
      WRITE ( 'This file already exists! Overwrite? ([Y]es [N]o [S]kip all): ' );
      Readln ( s );
      CASE Upcase ( s [ 1 ] ) OF
       'Y' : Ask := TRUE;
       'S' : BEGIN
              Ask := FALSE;
              Skipall := TRUE;
            END;
       END; {Case}
     {$endif MSWINDOWS}
   END;
END; {Report}
{/////////////////////////////////////////////////////}
VAR
thename, target : TDirType;
DLLVersion, i : word;
NoRecursion : Boolean;
s           : TString;
BEGIN
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

  SkipAll := FALSE;
  NoRecursion := FALSE;

 {$ifdef Can_Use_DLL}
  DLLVersion := GetUnzipDLLVersion;
  WRITE ( 'DLL Version ', Hi ( DLLVersion ), '.' );
  IF lo ( DLLVersion ) < 10 THEN WRITE ( '0' );
  writeln ( LO ( DLLVersion ) );
 {$endif}

  Writeln ( 'Supported ZIP Unzipmethods:' );

  FOR i := 0 TO 8 DO     {8 because of array above}
    IF ( ( 1 SHL i ) AND GetSupportedmethods ) <> 0
      THEN writeln ( Unzipmethods [ i ] );

  Writeln ( '--------------------------' );

  IF paramcount >= 2 THEN BEGIN
      Strpcopy ( thename, paramstr ( 1 ) );
      Strpcopy ( target, paramstr ( 2 ) );
      NoRecursion := Upper ( paramstr ( 3 ) ) = '/D-'; {/D- = don't recurse}
  END ELSE BEGIN
      Writeln;
      WRITE ( 'Please enter ZIP filename:' );
      readln ( s );
      IF s = '' THEN halt;
      strpcopy ( thename, s );
      WRITE ( 'Please enter target directory:' );
      readln ( s );
      IF s = '' THEN halt;
      strpcopy ( target, s );
  END;

  SetNoRecurseDirs ( NoRecursion );
  Writeln ( FileUnzip (
            thename,
            target,
            '*.*',
            {$ifdef UseAt}@{$endif}Report,
            {$ifdef UseAt}@{$endif}Ask ),
            ' files processed.' );
END.

