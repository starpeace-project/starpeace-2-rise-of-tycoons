{
Simple program for unzip, using a simple Pascal object
   Supports:
        * Delphi v2.x           (Win32)
        * Delphi v3.x           (Win32)
        * Delphi v4.x           (Win32)
        * Delphi v6.x           (Win32)
        * Delphi v7.x           (Win32)
        * Kylix  v3.0           (Linux)
        * Virtual Pascal v2.x   (Win32,
                                 OS/2)
        * Free Pascal v1.x      (Win32)
        * GNU Pascal (v2.1):
                                (Dos32,
                                 Win32,
                                 Linux,
                                 Solaris,
                                 Irix,
                                 Ultrix, etc)

}
PROGRAM unzip32;
{$i unzip.inc}

USES
SysUtils,
unzip,
ziptypes;

{$ifdef Delphi32}
    {$apptype console}
{$endif}

{$H-}

TYPE
UnZipObject = OBJECT
   CONSTRUCTOR Init ( CONST ZipFile, Directory, FileSpecs : String;Report : UnzipReportProc );
   DESTRUCTOR  Done;VIRTUAL;
   FUNCTION    Run : integer;VIRTUAL;
   FUNCTION    ViewFile : integer;VIRTUAL;

   PRIVATE
      NoRecurse : Boolean;
      aName,
      aDir,
      aSpec : TDirType;
      ZipReport : UnzipReportProc;
END;

{/////////////////////////////////////////////////////}
FUNCTION IsParm ( Parm : String; CONST Check : String ) : Boolean;
BEGIN
   Result := False;
   IF ( Parm [1] IN ['/', '-'] )
   THEN BEGIN
      Delete ( Parm, 1, 1 );
      Result := UpperCase ( Parm ) = UpperCase ( Check );
   END;
END;

FUNCTION aTimeToStr ( CONST l : Longint ) : String;
BEGIN
  Result := FormatDateTime ( 'dd/mm/yyyy  hh:nn', FileDateToDateTime ( l ) );
END;

PROCEDURE Report ( Retcode : longint;R : pReportRec );
{$ifdef USE_STDCALL}STDCALL;{$else}
{$ifndef NO_EXPORTS}EXPORT;{$endif}{$endif}
BEGIN
  WITH r^ DO
  CASE Status OF
  file_failure : BEGIN
     writeln ( 'ERROR extracting file: ', strpas ( filename ), '; Errorcode=', retcode );
  END;

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
{$ifNdef NO_EXPORTS}EXPORT;{$endif}{$endif}
BEGIN
 WITH r^ DO BEGIN
   IF ( Time = - 1 ) AND ( Attr = - 1 ) THEN BEGIN
     Writeln ( '------------------------------------------------------' );
     WRITE ( 'Archive:' : 8 );
     Writeln (
     ' ', Size : 9,
     ' ', CompressSize : 9,
     ' ', Ratio : 5, '%',
     ' ', strpas ( filename )
     );
   END
   ELSE BEGIN
     WRITE ( UnzipMethods [ packmethod ] : 8 );
     Writeln (
     ' ', Size : 9,
     ' ', CompressSize : 9,
     ' ', Ratio : 5, '%',
     ' ', aTimeToStr ( Time ) : 10,
     ' ', strpas ( filename )
     );
   END;
 END;
END; {Report2}

{/////////////////////////////////////////////////////}
CONSTRUCTOR UnZipObject.Init;
BEGIN
  ZipReport := Report;
  NoRecurse := IsParm ( paramstr ( ParamCount ), 'D-' ); {/D- = don't recurse}

  IF ( NoRecurse ) AND ( ParamCount < 4 )
     THEN StrPcopy ( aSpec, '*.*' )
        ELSE StrPcopy ( aSpec, FileSpecs );

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
t : TsearchRec;
i, j : Longint;
Dir, s : String [255];
BEGIN
  SetNoRecurseDirs ( NoRecurse );
  {$ifndef UseAT}@{$endif}x := NIL;
  Dir := ExtractFilePath ( StrPas ( aName ) );
  Result := 0;
  i := FindFirst ( Strpas ( aName ), faArchive OR faReadOnly OR faHidden OR faSysFile, t );
  WHILE i = 0
  DO BEGIN
     s := Dir + t.Name + #0;
     j := FileUnzip ( @s [1], aDir, aSpec, ZipReport, x );
     IF j > 0 THEN Inc ( Result, j );
     i := FindNext ( t );
  END;
  FindClose ( t );
END;

FUNCTION    UnZipObject.ViewFile : integer;
VAR
t : TsearchRec;
i, j : Longint;
Dir, s : String [255];
BEGIN
  Dir := ExtractFilePath ( StrPas ( aName ) );
  Result := 0;
  i := FindFirst ( StrPas ( aName ), faArchive + faReadOnly + faHidden + faSysFile, t );
  WHILE i = 0 DO BEGIN
     s := Dir + t.Name + #0;
     j := ViewZip ( @s [1], aSpec, {$ifdef UseAT}@{$endif}Report2 );
     IF j > 0 THEN Inc ( Result, j );
     i := FindNext ( t );
  END;
  FindClose ( t );
END;


{ ////////////////////////////////////////////////////// }
{ ////////////////////////////////////////////////////// }
{ ////////////////////////////////////////////////////// }
{ ////////////////////////////////////////////////////// }
VAR
Zip : UnZipObject;
s, s1, s2   : String [255];
j : longint;
BEGIN
  Writeln ( 'Unzip for Win32, v1.10. (c)2003, Prof A Olowofoyeku (The African Chief).' );
  LowCaseFileNames := True;
  IF ( paramcount < 1 )
  OR ( IsParm ( ParamStr ( 1 ), '?' ) )
  OR ( IsParm ( ParamStr ( 1 ), 'H' ) )
  THEN BEGIN
    Writeln ( 'Syntax  = unzip32 <filespec> [targetdir] [fspecs] [switches]' );
    Writeln ( 'Switches: ' );
    Writeln ( '     -V or -L (view contents of archive).' );
    Writeln ( '     -D-      (do not recreate directory structure when unzipping).' );
    Writeln ( 'Examples:' );
    {$ifdef __OS_DOS__}
    Writeln ( '     unzip32 c:\temp\*.zip -V' );
    Writeln ( '     unzip32 c:\temp\*.zip c:\temp\zips' );
    Writeln ( '     unzip32 c:\temp\*.zip c:\temp\zips *.pas -D-' );
    {$else}
    Writeln ( '     unzip32 /temp/*.zip -V' );
    Writeln ( '     unzip32 /temp/*.zip /temp/zips' );
    Writeln ( '     unzip32 /temp/*.zip /temp/zips *.pas -D-' );
    {$endif}
    halt;
  END;

  s  := ParamStr ( 1 );
  s1 := ParamStr ( 2 );
  s2 := ParamStr ( 3 );
  IF s1 = '' THEN s1 := GetCurrentDir;  { extract to current directory }

  IF ExtractFileExt ( s ) = '' THEN s := ChangeFileExt ( s, '.zip' );
  s := ExpandFileName ( s );

  WITH Zip DO BEGIN
      Init ( s, s1, s2, {$ifdef UseAT}@{$endif}Report );
      IF ( IsParm ( s1, 'V' ) ) OR ( IsParm ( s1, 'L' ) ) { -V or -L : view/list }
      THEN j := ( Zip.ViewFile ) ELSE j := ( Zip.Run );
      Done;
      Writeln ( j, ' file(s).' );
  END;
END.

