unit RemoteAdmin_TLB;

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

// PASTLWTR : 1.2
// File generated on 17/12/2004 12:54:06 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\starpeace\Source\Remote Admin\RemoteAdmin.tlb (1)
// LIBID: {B00DDE31-2732-11D3-8F76-00A0CC2C4AEF}
// LCID: 0
// Helpfile: 
// HelpString: RemoteAdmin Library
// DepndLst: 
//   (1) v1.0 stdole, (C:\WINDOWS\system32\stdole32.tlb)
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
  RemoteAdminMajorVersion = 1;
  RemoteAdminMinorVersion = 0;

  LIBID_RemoteAdmin: TGUID = '{B00DDE31-2732-11D3-8F76-00A0CC2C4AEF}';

  IID_ITaskManager: TGUID = '{B00DDE32-2732-11D3-8F76-00A0CC2C4AEF}';
  CLASS_TaskManager: TGUID = '{B00DDE33-2732-11D3-8F76-00A0CC2C4AEF}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ITaskManager = interface;
  ITaskManagerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TaskManager = ITaskManager;


// *********************************************************************//
// Interface: ITaskManager
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B00DDE32-2732-11D3-8F76-00A0CC2C4AEF}
// *********************************************************************//
  ITaskManager = interface(IDispatch)
    ['{B00DDE32-2732-11D3-8F76-00A0CC2C4AEF}']
    procedure EnumTasks; safecall;
    function Get_TaskCount: Integer; safecall;
    procedure Set_TaskCount(Value: Integer); safecall;
    function GetTaskName(idx: Integer): OleVariant; safecall;
    procedure StopTask(id: Integer); safecall;
    procedure KillTask(id: Integer); safecall;
    function Reboot: WordBool; safecall;
    function GetTaskId(idx: Integer): OleVariant; safecall;
    function LaunchTask(const filename: WideString): WordBool; safecall;
    property TaskCount: Integer read Get_TaskCount write Set_TaskCount;
  end;

// *********************************************************************//
// DispIntf:  ITaskManagerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {B00DDE32-2732-11D3-8F76-00A0CC2C4AEF}
// *********************************************************************//
  ITaskManagerDisp = dispinterface
    ['{B00DDE32-2732-11D3-8F76-00A0CC2C4AEF}']
    procedure EnumTasks; dispid 1;
    property TaskCount: Integer dispid 2;
    function GetTaskName(idx: Integer): OleVariant; dispid 3;
    procedure StopTask(id: Integer); dispid 4;
    procedure KillTask(id: Integer); dispid 5;
    function Reboot: WordBool; dispid 6;
    function GetTaskId(idx: Integer): OleVariant; dispid 7;
    function LaunchTask(const filename: WideString): WordBool; dispid 8;
  end;

// *********************************************************************//
// The Class CoTaskManager provides a Create and CreateRemote method to          
// create instances of the default interface ITaskManager exposed by              
// the CoClass TaskManager. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTaskManager = class
    class function Create: ITaskManager;
    class function CreateRemote(const MachineName: string): ITaskManager;
  end;

implementation

uses ComObj;

class function CoTaskManager.Create: ITaskManager;
begin
  Result := CreateComObject(CLASS_TaskManager) as ITaskManager;
end;

class function CoTaskManager.CreateRemote(const MachineName: string): ITaskManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TaskManager) as ITaskManager;
end;

end.
