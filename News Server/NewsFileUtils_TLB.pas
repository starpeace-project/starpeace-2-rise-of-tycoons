unit NewsFileUtils_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 5081 $
// File generated on 01/04/2010 12:09:21 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\starpeace\Source\News Server\NewsFileUtils.tlb (1)
// LIBID: {36349ED0-AF75-11D2-9764-008029EC1811}
// LCID: 0
// Helpfile: 
// HelpString: NewsFileUtils Library
// DepndLst: 
//   (1) v1.0 stdole, (C:\Windows\system32\stdole32.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  NewsFileUtilsMajorVersion = 1;
  NewsFileUtilsMinorVersion = 0;

  LIBID_NewsFileUtils: TGUID = '{36349ED0-AF75-11D2-9764-008029EC1811}';

  IID_IFolderIterator: TGUID = '{36349ED1-AF75-11D2-9764-008029EC1811}';
  CLASS_FolderIterator: TGUID = '{36349ED2-AF75-11D2-9764-008029EC1811}';
  IID_ITools: TGUID = '{EFE5D5F5-B332-11D2-976F-008029EC1811}';
  CLASS_Tools: TGUID = '{EFE5D5F6-B332-11D2-976F-008029EC1811}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFolderIterator = interface;
  IFolderIteratorDisp = dispinterface;
  ITools = interface;
  IToolsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  FolderIterator = IFolderIterator;
  Tools = ITools;


// *********************************************************************//
// Interface: IFolderIterator
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {36349ED1-AF75-11D2-9764-008029EC1811}
// *********************************************************************//
  IFolderIterator = interface(IDispatch)
    ['{36349ED1-AF75-11D2-9764-008029EC1811}']
    function FindFirst(const path: WideString): WideString; safecall;
    function FindNext: WideString; safecall;
    procedure FindClose; safecall;
    function Get_LangId: WideString; safecall;
    procedure Set_LangId(const Value: WideString); safecall;
    property LangId: WideString read Get_LangId write Set_LangId;
  end;

// *********************************************************************//
// DispIntf:  IFolderIteratorDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {36349ED1-AF75-11D2-9764-008029EC1811}
// *********************************************************************//
  IFolderIteratorDisp = dispinterface
    ['{36349ED1-AF75-11D2-9764-008029EC1811}']
    function FindFirst(const path: WideString): WideString; dispid 1;
    function FindNext: WideString; dispid 2;
    procedure FindClose; dispid 3;
    property LangId: WideString dispid 4;
  end;

// *********************************************************************//
// Interface: ITools
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EFE5D5F5-B332-11D2-976F-008029EC1811}
// *********************************************************************//
  ITools = interface(IDispatch)
    ['{EFE5D5F5-B332-11D2-976F-008029EC1811}']
    function EncodeNewsDate(const date: WideString): WideString; safecall;
    function DecodeNewsDate(const date: WideString): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IToolsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EFE5D5F5-B332-11D2-976F-008029EC1811}
// *********************************************************************//
  IToolsDisp = dispinterface
    ['{EFE5D5F5-B332-11D2-976F-008029EC1811}']
    function EncodeNewsDate(const date: WideString): WideString; dispid 1;
    function DecodeNewsDate(const date: WideString): WideString; dispid 2;
  end;

// *********************************************************************//
// The Class CoFolderIterator provides a Create and CreateRemote method to          
// create instances of the default interface IFolderIterator exposed by              
// the CoClass FolderIterator. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFolderIterator = class
    class function Create: IFolderIterator;
    class function CreateRemote(const MachineName: string): IFolderIterator;
  end;

// *********************************************************************//
// The Class CoTools provides a Create and CreateRemote method to          
// create instances of the default interface ITools exposed by              
// the CoClass Tools. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTools = class
    class function Create: ITools;
    class function CreateRemote(const MachineName: string): ITools;
  end;

implementation

uses ComObj;

class function CoFolderIterator.Create: IFolderIterator;
begin
  Result := CreateComObject(CLASS_FolderIterator) as IFolderIterator;
end;

class function CoFolderIterator.CreateRemote(const MachineName: string): IFolderIterator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FolderIterator) as IFolderIterator;
end;

class function CoTools.Create: ITools;
begin
  Result := CreateComObject(CLASS_Tools) as ITools;
end;

class function CoTools.CreateRemote(const MachineName: string): ITools;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Tools) as ITools;
end;

end.
