unit MailBrowser_TLB;

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
// File generated on 01/04/2010 12:09:22 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\starpeace\Source\Mail\MailBrowser.tlb (1)
// LIBID: {4F7EC360-AD33-11D1-A1A8-0080C817C099}
// LCID: 0
// Helpfile: 
// HelpString: MailBrowser Library
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
  MailBrowserMajorVersion = 1;
  MailBrowserMinorVersion = 0;

  LIBID_MailBrowser: TGUID = '{4F7EC360-AD33-11D1-A1A8-0080C817C099}';

  IID_IMailBrowser: TGUID = '{4F7EC361-AD33-11D1-A1A8-0080C817C099}';
  CLASS_MailBrowser_: TGUID = '{4F7EC362-AD33-11D1-A1A8-0080C817C099}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IMailBrowser = interface;
  IMailBrowserDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MailBrowser_ = IMailBrowser;


// *********************************************************************//
// Interface: IMailBrowser
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4F7EC361-AD33-11D1-A1A8-0080C817C099}
// *********************************************************************//
  IMailBrowser = interface(IDispatch)
    ['{4F7EC361-AD33-11D1-A1A8-0080C817C099}']
    function Get_Account: WideString; safecall;
    procedure Set_Account(const Value: WideString); safecall;
    function Get_Folder: WideString; safecall;
    procedure Set_Folder(const Value: WideString); safecall;
    procedure Reset; safecall;
    function Next: WordBool; safecall;
    function DeleteMessage(const MsgPath: WideString): WordBool; safecall;
    function Get_Empty: WordBool; safecall;
    function Get_World: WideString; safecall;
    procedure Set_World(const Value: WideString); safecall;
    function Get_Header(const Name: WideString): WideString; safecall;
    function FullPath: WideString; safecall;
    property Account: WideString read Get_Account write Set_Account;
    property Folder: WideString read Get_Folder write Set_Folder;
    property Empty: WordBool read Get_Empty;
    property World: WideString read Get_World write Set_World;
    property Header[const Name: WideString]: WideString read Get_Header;
  end;

// *********************************************************************//
// DispIntf:  IMailBrowserDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4F7EC361-AD33-11D1-A1A8-0080C817C099}
// *********************************************************************//
  IMailBrowserDisp = dispinterface
    ['{4F7EC361-AD33-11D1-A1A8-0080C817C099}']
    property Account: WideString dispid 1;
    property Folder: WideString dispid 2;
    procedure Reset; dispid 4;
    function Next: WordBool; dispid 5;
    function DeleteMessage(const MsgPath: WideString): WordBool; dispid 11;
    property Empty: WordBool readonly dispid 8;
    property World: WideString dispid 10;
    property Header[const Name: WideString]: WideString readonly dispid 6;
    function FullPath: WideString; dispid 3;
  end;

// *********************************************************************//
// The Class CoMailBrowser_ provides a Create and CreateRemote method to          
// create instances of the default interface IMailBrowser exposed by              
// the CoClass MailBrowser_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMailBrowser_ = class
    class function Create: IMailBrowser;
    class function CreateRemote(const MachineName: string): IMailBrowser;
  end;

implementation

uses ComObj;

class function CoMailBrowser_.Create: IMailBrowser;
begin
  Result := CreateComObject(CLASS_MailBrowser_) as IMailBrowser;
end;

class function CoMailBrowser_.CreateRemote(const MachineName: string): IMailBrowser;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MailBrowser_) as IMailBrowser;
end;

end.
