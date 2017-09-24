unit CacheManager_TLB;

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
// File generated on 16/08/2013 23:49:46 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\starpeace\Source\Cache\CacheManager.tlb (1)
// LIBID: {18FC3C40-6450-11D1-A1A8-D5FDEAAE6A6F}
// LCID: 0
// Helpfile: 
// HelpString: CacheManager Library
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
  CacheManagerMajorVersion = 1;
  CacheManagerMinorVersion = 0;

  LIBID_CacheManager: TGUID = '{18FC3C40-6450-11D1-A1A8-D5FDEAAE6A6F}';

  IID_ICachedObject: TGUID = '{18FC3C41-6450-11D1-A1A8-D5FDEAAE6A6F}';
  CLASS_CachedObject: TGUID = '{18FC3C42-6450-11D1-A1A8-D5FDEAAE6A6F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICachedObject = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CachedObject = ICachedObject;


// *********************************************************************//
// Interface: ICachedObject
// Flags:     (4368) Hidden OleAutomation Dispatchable
// GUID:      {18FC3C41-6450-11D1-A1A8-D5FDEAAE6A6F}
// *********************************************************************//
  ICachedObject = interface(IDispatch)
    ['{18FC3C41-6450-11D1-A1A8-D5FDEAAE6A6F}']
    function SetPath(const aPath: WideString; out Value: WordBool): HResult; stdcall;
    function GetPath(out Value: WideString): HResult; stdcall;
    function SetWorld(const Name: WideString; out Value: WordBool): HResult; stdcall;
    function SetClass(const Name: WideString; out Value: WordBool): HResult; stdcall;
    function SetObject(X: Integer; Y: Integer; out Value: WordBool): HResult; stdcall;
    function SetObjectOfWorld(X: Integer; Y: Integer; const World: WideString; out Value: WordBool): HResult; stdcall;
    function GetFolderIterator(const Folder: WideString; out Value: OleVariant): HResult; stdcall;
    function ContainsFolder(const Name: WideString; out Value: WordBool): HResult; stdcall;
    function Get_Recache(out Value: WordBool): HResult; stdcall;
    function Set_Recache(Value: WordBool): HResult; stdcall;
    function Properties(const Name: WideString; out Value: WideString): HResult; stdcall;
    function Get_Path(out Value: WideString): HResult; stdcall;
    function Set_Path(const Value: WideString): HResult; stdcall;
    function Get_ErrorCode(out Value: Integer): HResult; stdcall;
    function ActivateDictionary(Activate: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoCachedObject provides a Create and CreateRemote method to          
// create instances of the default interface ICachedObject exposed by              
// the CoClass CachedObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCachedObject = class
    class function Create: ICachedObject;
    class function CreateRemote(const MachineName: string): ICachedObject;
  end;

implementation

uses ComObj;

class function CoCachedObject.Create: ICachedObject;
begin
  Result := CreateComObject(CLASS_CachedObject) as ICachedObject;
end;

class function CoCachedObject.CreateRemote(const MachineName: string): ICachedObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CachedObject) as ICachedObject;
end;

end.
