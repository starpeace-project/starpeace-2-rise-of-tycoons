unit OutputSrch_TLB;

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
// File generated on 01/04/2010 12:09:23 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\starpeace\Source\Cache\OutputSrch.tlb (1)
// LIBID: {48DB8B20-6705-11D1-A1A8-955D74A3A3E2}
// LCID: 0
// Helpfile: 
// HelpString: OutputSrch Library
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
  OutputSrchMajorVersion = 1;
  OutputSrchMinorVersion = 0;

  LIBID_OutputSrch: TGUID = '{48DB8B20-6705-11D1-A1A8-955D74A3A3E2}';

  IID_IOutputSearch: TGUID = '{48DB8B21-6705-11D1-A1A8-955D74A3A3E2}';
  CLASS_OutputSearch: TGUID = '{48DB8B22-6705-11D1-A1A8-955D74A3A3E2}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IOutputSearch = interface;
  IOutputSearchDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  OutputSearch = IOutputSearch;


// *********************************************************************//
// Interface: IOutputSearch
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {48DB8B21-6705-11D1-A1A8-955D74A3A3E2}
// *********************************************************************//
  IOutputSearch = interface(IDispatch)
    ['{48DB8B21-6705-11D1-A1A8-955D74A3A3E2}']
    procedure Search(const Output: WideString; const World: WideString; const Town: WideString; 
                     const Company: WideString; Count: Integer; X: Integer; Y: Integer); safecall;
    function Get_Count: Integer; safecall;
    function Get_X(row: Integer): Integer; safecall;
    function Get_Y(row: Integer): Integer; safecall;
    function Get_K(row: Integer): Integer; safecall;
    function Get_P(row: Integer): Single; safecall;
    function Get_C(row: Integer): Single; safecall;
    function Get_Town(row: Integer): WideString; safecall;
    function Get_Company(row: Integer): WideString; safecall;
    function Get_Utility(row: Integer): WideString; safecall;
    function Get_SortMode: Integer; safecall;
    procedure Set_SortMode(SortMode: Integer); safecall;
    function Get_Role: Integer; safecall;
    procedure Set_Role(Kind: Integer); safecall;
    function Get_Circuits: WideString; safecall;
    procedure Set_Circuits(const Circuits: WideString); safecall;
    function Get_Connected(index: Integer): WordBool; safecall;
    property Count: Integer read Get_Count;
    property X[row: Integer]: Integer read Get_X;
    property Y[row: Integer]: Integer read Get_Y;
    property K[row: Integer]: Integer read Get_K;
    property P[row: Integer]: Single read Get_P;
    property C[row: Integer]: Single read Get_C;
    property Town[row: Integer]: WideString read Get_Town;
    property Company[row: Integer]: WideString read Get_Company;
    property Utility[row: Integer]: WideString read Get_Utility;
    property SortMode: Integer read Get_SortMode write Set_SortMode;
    property Role: Integer read Get_Role write Set_Role;
    property Circuits: WideString read Get_Circuits write Set_Circuits;
    property Connected[index: Integer]: WordBool read Get_Connected;
  end;

// *********************************************************************//
// DispIntf:  IOutputSearchDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {48DB8B21-6705-11D1-A1A8-955D74A3A3E2}
// *********************************************************************//
  IOutputSearchDisp = dispinterface
    ['{48DB8B21-6705-11D1-A1A8-955D74A3A3E2}']
    procedure Search(const Output: WideString; const World: WideString; const Town: WideString; 
                     const Company: WideString; Count: Integer; X: Integer; Y: Integer); dispid 1;
    property Count: Integer readonly dispid 2;
    property X[row: Integer]: Integer readonly dispid 3;
    property Y[row: Integer]: Integer readonly dispid 4;
    property K[row: Integer]: Integer readonly dispid 5;
    property P[row: Integer]: Single readonly dispid 6;
    property C[row: Integer]: Single readonly dispid 7;
    property Town[row: Integer]: WideString readonly dispid 8;
    property Company[row: Integer]: WideString readonly dispid 9;
    property Utility[row: Integer]: WideString readonly dispid 10;
    property SortMode: Integer dispid 11;
    property Role: Integer dispid 13;
    property Circuits: WideString dispid 14;
    property Connected[index: Integer]: WordBool readonly dispid 15;
  end;

// *********************************************************************//
// The Class CoOutputSearch provides a Create and CreateRemote method to          
// create instances of the default interface IOutputSearch exposed by              
// the CoClass OutputSearch. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoOutputSearch = class
    class function Create: IOutputSearch;
    class function CreateRemote(const MachineName: string): IOutputSearch;
  end;

implementation

uses ComObj;

class function CoOutputSearch.Create: IOutputSearch;
begin
  Result := CreateComObject(CLASS_OutputSearch) as IOutputSearch;
end;

class function CoOutputSearch.CreateRemote(const MachineName: string): IOutputSearch;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_OutputSearch) as IOutputSearch;
end;

end.
