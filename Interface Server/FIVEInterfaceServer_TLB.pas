unit FIVEInterfaceServer_TLB;

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
// File generated on 11/07/2011 22:32:47 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\starpeace\Source\Interface Server\FIVEInterfaceServer.tlb (1)
// LIBID: {73C41811-C0DD-11D1-ABE2-008029EC1811}
// LCID: 0
// Helpfile: 
// HelpString: FIVEInterfaceServer Library
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
  FIVEInterfaceServerMajorVersion = 1;
  FIVEInterfaceServerMinorVersion = 0;

  LIBID_FIVEInterfaceServer: TGUID = '{73C41811-C0DD-11D1-ABE2-008029EC1811}';

  IID_ITURLTrigger: TGUID = '{73C41812-C0DD-11D1-ABE2-008029EC1811}';
  CLASS_TURLTrigger: TGUID = '{73C41813-C0DD-11D1-ABE2-008029EC1811}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ITURLTrigger = interface;
  ITURLTriggerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TURLTrigger = ITURLTrigger;


// *********************************************************************//
// Interface: ITURLTrigger
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {73C41812-C0DD-11D1-ABE2-008029EC1811}
// *********************************************************************//
  ITURLTrigger = interface(IDispatch)
    ['{73C41812-C0DD-11D1-ABE2-008029EC1811}']
  end;

// *********************************************************************//
// DispIntf:  ITURLTriggerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {73C41812-C0DD-11D1-ABE2-008029EC1811}
// *********************************************************************//
  ITURLTriggerDisp = dispinterface
    ['{73C41812-C0DD-11D1-ABE2-008029EC1811}']
  end;

// *********************************************************************//
// The Class CoTURLTrigger provides a Create and CreateRemote method to          
// create instances of the default interface ITURLTrigger exposed by              
// the CoClass TURLTrigger. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTURLTrigger = class
    class function Create: ITURLTrigger;
    class function CreateRemote(const MachineName: string): ITURLTrigger;
  end;

implementation

uses ComObj;

class function CoTURLTrigger.Create: ITURLTrigger;
begin
  Result := CreateComObject(CLASS_TURLTrigger) as ITURLTrigger;
end;

class function CoTURLTrigger.CreateRemote(const MachineName: string): ITURLTrigger;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TURLTrigger) as ITURLTrigger;
end;

end.
