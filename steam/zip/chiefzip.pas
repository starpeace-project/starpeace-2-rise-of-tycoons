LIBRARY ChiefZip;
{
DLL for the UNZIP functions
  * original version by Christian Ghisler

  * extended by Prof. Abimbola Olowofoyeku (The African Chief)
            http:www.bigfoot.com/~African_Chief/
     * the main exported functions are now linked in directly
       from UNZIP.PAS
}

{$I unzip.inc}

USES unzip;

FUNCTION GetUnzipDllVersion : word;
{$ifdef USE_STDCALL}STDCALL;{$else}EXPORT;{$endif}
BEGIN
  GetUnzipDllVersion := 2 * 256 + 60;    { Version 2.60 }
END;

EXPORTS
  GetUnzipDllVersion   index 1{$ifdef BY_NAME}  name  'GetUnzipDllVersion' {$endif},
  GetFirstInZip        index 2{$ifdef BY_NAME}  name  'GetFirstInZip' {$endif},
  GetNextInZip         index 3{$ifdef BY_NAME}  name  'GetNextInZip' {$endif},
  CloseZipFile         index 4{$ifdef BY_NAME}  name  'CloseZipFile' {$endif},
  IsZip                index 5{$ifdef BY_NAME}  name  'IsZip' {$endif},
  GetSupportedMethods  index 6{$ifdef BY_NAME}  name  'GetSupportedMethods' {$endif},
  UnzipFile            index 7{$ifdef BY_NAME}  name  'UnzipFile' {$endif},

  {*** the African Chief's functions ***}
  FileUnzip            index 8{$ifdef BY_NAME}  name  'FileUnzip' {$endif},
  ViewZip              index 9{$ifdef BY_NAME}  name  'ViewZip' {$endif},
  UnzipSize            index 10{$ifdef BY_NAME} name  'UnzipSize' {$endif},
  SetUnzipReportProc   index 11{$ifdef BY_NAME} name  'SetUnzipReportProc' {$endif},
  SetUnzipQuestionProc index 12{$ifdef BY_NAME} name  'SetUnzipQuestionProc' {$endif},
  FileUnzipEx          index 13{$ifdef BY_NAME} name  'FileUnzipEx' {$endif},
  ChfUnzip_Init        index 14{$ifdef BY_NAME} name  'ChfUnzip_Init' {$endif},
  SetNoRecurseDirs     index 15{$ifdef BY_NAME} name  'SetNoRecurseDirs' {$endif},
  RecursiveMkDir       index 16{$ifdef BY_NAME} name  'RecursiveMkDir' {$endif},
  GetHeaderOffset      index 17{$ifdef BY_NAME} name  'GetHeaderOffset ' {$endif};
BEGIN
END.

