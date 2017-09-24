{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{  	    Copyright (c) 1995-2007 CodeGear	        }
{                                                       }
{*******************************************************}

unit ObjComAuto;

interface

uses Windows, ObjAuto, ActiveX, TypInfo;

type
  TDispatchKind = (dkMethod, dkProperty, dkSubComponent);
  TDispatchInfo = record
    Instance: TObject;
    case Kind: TDispatchKind of
      dkMethod: (MethodInfo: PMethodInfoHeader);
      dkProperty: (PropInfo: PPropInfo);
      dkSubComponent: (Index: Integer);
  end;

  TDispatchInfos = array of TDispatchInfo;

  TObjectDispatch = class(TInterfacedObject, IDispatch)
  private
    FDispatchInfoCount: Integer;
    FDispatchInfos: TDispatchInfos;
    FInstance: TObject;
    FOwned: Boolean;
    function AllocDispID(AKind: TDispatchKind; Value: Pointer; AInstance: TObject): TDispID;
  protected
    function GetObjectDispatch(Obj: TObject): TObjectDispatch; virtual;
    function GetMethodInfo(const AName: ShortString; var AInstance: TObject): PMethodInfoHeader; virtual;
    function GetPropInfo(const AName: string; var AInstance: TObject; var CompIndex: Integer): PPropInfo; virtual;
    property Instance: TObject read FInstance;
  public
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount: Integer; LocaleID: Integer; DispIDs: Pointer): HRESULT;
      virtual; stdcall;
    function GetTypeInfo(Index: Integer; LocaleID: Integer;
      out TypeInfo): HRESULT; stdcall;
    function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult: Pointer; ExcepInfo: Pointer;
      ArgErr: Pointer): HRESULT; virtual; stdcall;
  public
    constructor Create(Instance: TObject; Owned: Boolean = True);
    destructor Destroy; override;
  end;

function CreateMethodPointer(const Instance: IDispatch; const MethodName: string;
  TypeInfo: PTypeInfo): TMethod; overload;
function CreateMethodPointer(const Instance: IDispatch; DispID: Integer;
  TypeInfo: PTypeInfo): TMethod; overload;
procedure ReleaseMethodPointer(MethodPointer: TMethod);

implementation

uses ComObj, SysUtils, Classes;

const
  ofDispIDOffset = 100;

function SameText(const S1, S2: ShortString): Boolean;
var
  L: Integer;
begin
  L := Length(S1);
  Result := (L = Length(S2)) and (StrLIComp(@S1[1], @S2[1], L) = 0);
end;

{ TObjectDispatch }

function TObjectDispatch.AllocDispID(AKind: TDispatchKind; Value: Pointer; AInstance: TObject): TDispID;
var
  I: Integer;
begin
  for I := FDispatchInfoCount - 1 downto 0 do
    with FDispatchInfos[I] do
      if (Kind = AKind) and (MethodInfo = Value) then
      begin
        // Already have a dispid for this methodinfo
        Result := ofDispIDOffset + I;
        Exit;
      end;
  if FDispatchInfoCount = Length(FDispatchInfos) then
    SetLength(FDispatchInfos, Length(FDispatchInfos) + 10);
  Result := ofDispIDOffset + FDispatchInfoCount;
  with FDispatchInfos[FDispatchInfoCount] do
  begin
    Instance := AInstance;
    Kind := AKind;
    MethodInfo := Value;
  end;
  Inc(FDispatchInfoCount);
end;

constructor TObjectDispatch.Create(Instance: TObject; Owned: Boolean);
begin
  inherited Create;
  FInstance := Instance;
  FOwned := Owned;
end;

destructor TObjectDispatch.Destroy;
begin
  if FOwned then
    FInstance.Free;
  inherited;
end;

procedure WideCharToShortString(P: PWideChar; var S: ShortString);
var
  I: Integer;
  W: WideChar;
begin
  I := 0;
  repeat
    W := P[I];
    if W = #0 then Break;
    if W >= #256 then W := #0;
    Inc(I);
    S[I] := Char(W);
  until I = 255;
  S[0] := Char(I);
end;

function TObjectDispatch.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT;
type
  PNames = ^TNames;
  TNames = array[0..100] of POleStr;
  PDispIDs = ^TDispIDs;
  TDispIDs = array[0..100] of Cardinal;
var
  Name: ShortString;
  Info: PMethodInfoHeader;
  PropInfo: PPropInfo;
  InfoEnd: Pointer;
  Params, Param: PParamInfo;
  I: Integer;
  ID: Cardinal;
  CompIndex: Integer;
  Instance: TObject;
begin
  Result := S_OK;
  /// This assumes that the DISPIDs returned do not have to be persistable.
  /// If the DISPIDs are persisted by the caller a VMT offset and parent depth
  /// count should be used instead.
  WideCharToShortString(PNames(Names)^[0], Name);
  Info := GetMethodInfo(Name, Instance);
  FillChar(DispIDs^, SizeOf(PDispIds(DispIDs^)[0]) * NameCount, $FF);
  if Info = nil then
  begin
    // Not a  method, try a property.
    PropInfo := GetPropInfo(Name, Instance, CompIndex);
    if PropInfo <> nil then
      PDispIds(DispIds)^[0] := AllocDispID(dkProperty, PropInfo, Instance)
    else if CompIndex > -1 then
      PDispIds(DispIds)^[0] := AllocDispID(dkSubComponent, Pointer(CompIndex), Instance)
    else
      Result := DISP_E_UNKNOWNNAME
  end
  else
  begin
    // Ensure the method information has enough type information
    if Info.Len <= SizeOf(Info^) - SizeOf(ShortString) + 1 + Length(Info.Name) then
      Result := DISP_E_UNKNOWNNAME
    else
    begin
      PDispIds(DispIds)^[0] := AllocDispID(dkMethod, Info, Instance);
      Result := S_OK;
      if NameCount > 1 then
      begin
        // Now find the parameters. The DISPID is assumed to be the parameter
        // index.
        InfoEnd := Pointer(Integer(Info) + Info^.Len);
        Params := PParamInfo(Integer(Info) + SizeOf(Info^) - SizeOf(ShortString) + 1
          + SizeOf(TReturnInfo) + Length(Info^.Name));
        for I := 1 to NameCount - 1 do
        begin
          WideCharToShortString(PNames(Names)^[I], Name);
          Param := Params;
          ID := 0;
          while Integer(Param) < Integer(InfoEnd) do
          begin
            // ignore Self
            if (Param^.ParamType^.Kind <> tkClass) or not SameText(Param^.Name, 'SELF') then
              if SameText(Param.Name, Name) then
              begin
                PDispIDs(DispIDs)^[I] := ID;
                Break;
              end;
            Inc(ID);
            Param := PParamInfo(Integer(Param) + SizeOf(Param^) -
              SizeOf(ShortString) + 1 + Length(Param^.Name));
          end;
          if Integer(Param) >= Integer(InfoEnd) then
            Result := DISP_E_UNKNOWNNAME
        end;
      end;
    end;
  end;
end;

function TObjectDispatch.GetMethodInfo(const AName: ShortString; var AInstance: TObject): PMethodInfoHeader;
begin
  Result := ObjAuto.GetMethodInfo(FInstance, AName);
  if Result <> nil then
    AInstance := FInstance;
end;

function TObjectDispatch.GetObjectDispatch(Obj: TObject): TObjectDispatch;
begin
  Result := TObjectDispatch.Create(Obj, False);
end;

function TObjectDispatch.GetPropInfo(const AName: string; var AInstance: TObject; var CompIndex: Integer): PPropInfo;
var
  Component: TComponent;
begin
  CompIndex := -1;
  Result := TypInfo.GetPropInfo(FInstance, AName);
  if (Result = nil) and (FInstance is TComponent) then
  begin
    // Not a property, try a sub component
    Component := TComponent(FInstance).FindComponent(AName);
    if Component <> nil then
    begin
      AInstance := FInstance;
      CompIndex := Component.ComponentIndex;
    end;
  end else if Result <> nil then
    AInstance := FInstance
  else
    AInstance := nil;
end;

function TObjectDispatch.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TObjectDispatch.GetTypeInfoCount(out Count: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TObjectDispatch.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HRESULT;
type
  PVariantArray = ^TVariantArray;
  TVariantArray = array[0..65535] of Variant;
  PIntegerArray = ^TIntegerArray;
  TIntegerArray = array[0..65535] of Integer;
var
  Parms: PDispParams;
  TempRet: Variant;
  DispatchInfo: TDispatchInfo;
  ReturnInfo: PReturnInfo;
begin
  Result := S_OK;
                                   
  Parms := @Params;
  try
    if VarResult = nil then
      VarResult := @TempRet;
    if (DispID - ofDispIDOffset >= 0) and (DispID - ofDispIDOffset < FDispatchInfoCount) then
    begin
      DispatchInfo := FDispatchInfos[DispID - ofDispIDOffset];
      case DispatchInfo.Kind of
        dkProperty:
          begin
            // The high bit set means the DispID is a property not a method.
            // See GetIDsOfNames
            if Flags and (DISPATCH_PROPERTYPUTREF or DISPATCH_PROPERTYPUT) <> 0 then
              if (Parms.cNamedArgs <> 1) or
                (PIntegerArray(Parms.rgdispidNamedArgs)^[0] <> DISPID_PROPERTYPUT) then
                Result := DISP_E_MEMBERNOTFOUND
              else
                SetPropValue(DispatchInfo.Instance, DispatchInfo.PropInfo,
                  PVariantArray(Parms.rgvarg)^[0])
            else
              if Parms.cArgs <> 0 then
                Result := DISP_E_BADPARAMCOUNT
              else if DispatchInfo.PropInfo^.PropType^.Kind = tkClass then
                POleVariant(VarResult)^ := GetObjectDispatch(
                  TObject(GetOrdProp(DispatchInfo.Instance, DispatchInfo.PropInfo))) as IDispatch
              else
                POleVariant(VarResult)^ := GetPropValue(DispatchInfo.Instance,
                  DispatchInfo.PropInfo, False);
          end;
        dkMethod:
          begin
            ReturnInfo := PReturnInfo(Integer(DispatchInfo.MethodInfo) + SizeOf(TMethodInfoHeader) - SizeOf(ShortString) + 1 +
              Length(DispatchInfo.MethodInfo.Name));
            if (ReturnInfo.ReturnType <> nil) and (ReturnInfo.ReturnType^.Kind = tkClass) then
              POleVariant(VarResult)^ := GetObjectDispatch(TObject(Integer(ObjectInvoke(DispatchInfo.Instance,
                DispatchInfo.MethodInfo,
                Slice(PIntegerArray(Parms.rgdispidNamedArgs)^, Parms.cNamedArgs),
                Slice(PVariantArray(Parms.rgvarg)^, Parms.cArgs))))) as IDispatch
            else
              POleVariant(VarResult)^ := ObjectInvoke(DispatchInfo.Instance,
                DispatchInfo.MethodInfo,
                Slice(PIntegerArray(Parms.rgdispidNamedArgs)^, Parms.cNamedArgs),
                Slice(PVariantArray(Parms.rgvarg)^, Parms.cArgs));
          end;
        dkSubComponent:
          POleVariant(VarResult)^ := GetObjectDispatch(TComponent(DispatchInfo.Instance).Components[DispatchInfo.Index]) as IDispatch;
      end;
    end else
      Result := DISP_E_MEMBERNOTFOUND;
  except
    if ExcepInfo <> nil then
    begin
      FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
      with TExcepInfo(ExcepInfo^) do
      begin
        bstrSource := StringToOleStr(ClassName);
        if ExceptObject is Exception then
          bstrDescription := StringToOleStr(Exception(ExceptObject).Message);
        scode := E_FAIL;
      end;
    end;
    Result := DISP_E_EXCEPTION;
  end;
end;

type
  TComMethodHandler = class(TInterfacedObject, IMethodHandler)
  private
    FInstance: IDispatch;
    FDispID: Integer;
  public
    function Execute(const Args: array of Variant): Variant;
    function InstanceToVariant(Instance: TObject): Variant;
  public
    constructor Create(const Instance: IDispatch; DispID: Integer);
  end;

function CreateMethodPointer(const Instance: IDispatch; DispID: Integer;
  TypeInfo: PTypeInfo): TMethod;
begin
  Result := ObjAuto.CreateMethodPointer(TComMethodHandler.Create(Instance, DispID),
    GetTypeData(TypeInfo));
end;

function CreateMethodPointer(const Instance: IDispatch; const MethodName: string;
  TypeInfo: PTypeInfo): TMethod;
var
  WMethodName: WideString;
  PMethodName: PWideChar;
  DispID: Integer;
begin
  WMethodName := MethodName;
  PMethodName := PWideChar(WMethodName);
  OLECHECK(Instance.GetIDsOfNames(GUID_NULL, @PMethodName, 1, 0, @DispID));
  Result := CreateMethodPointer(Instance, DispID, TypeInfo);
end;

procedure ReleaseMethodPointer(MethodPointer: TMethod);
begin
  ObjAuto.ReleaseMethodPointer(MethodPointer);
end;

{ TComMethodHandler }

constructor TComMethodHandler.Create(const Instance: IDispatch;
  DispID: Integer);
begin
  inherited Create;
  FInstance := Instance;
  FDispID := DispID;
end;

function WashVariant(const Value: Variant): OleVariant;
begin
  if TVarData(Value).VType = (varString or varByRef) then
    Result := PString(TVarData(VAlue).VString)^ + ''
  else
    Result := Value;
end;

function TComMethodHandler.Execute(const Args: array of Variant): Variant;
var
  ExcepInfo: TExcepInfo;
  ArgErr: Integer;
  OleArgs: array of OleVariant;
  I: Integer;
  DispParams: TDispParams;
begin
  SetLength(OleArgs, High(Args) + 1);
  for I := Low(Args) to High(Args) do
    OleArgs[I] := WashVariant(Args[I]);
  DispParams.rgvarg := @OleArgs[0];
  DispParams.cArgs := High(Args) + 1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
                                   
  FInstance.Invoke(FDispID, GUID_NULL, 0, DISPATCH_METHOD, DispParams, @Result,
    @ExcepInfo, @ArgErr);
end;

function TComMethodHandler.InstanceToVariant(Instance: TObject): Variant;
begin
  Result := TObjectDispatch.Create(Instance, False) as IDispatch;
end;

end.