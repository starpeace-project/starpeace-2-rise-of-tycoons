{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.7    10/26/2004 8:20:04 PM  JPMugaas
  Fixed some oversights with conversion.  OOPS!!!

  Rev 1.6    10/26/2004 8:12:32 PM  JPMugaas
  Now uses TIdStrings and TIdStringList for portability.

  Rev 1.5    12/06/2004 15:17:20  CCostelloe
  Restructured to correspond with IdStackWindows, now works.

  Rev 1.4    07/06/2004 21:31:02  CCostelloe
  Kylix 3 changes

  Rev 1.3    4/18/04 10:43:22 PM  RLebeau
  Fixed syntax error

  Rev 1.2    4/18/04 10:29:46 PM  RLebeau
  Renamed Int64Parts structure to TIdInt64Parts

  Rev 1.1    4/18/04 2:47:28 PM  RLebeau
  Conversion support for Int64 values

  Removed WSHToNs(), WSNToHs(), WSHToNL(), and WSNToHL() methods, obsolete

  Rev 1.0    2004.02.03 3:14:48 PM  czhower
  Move and updates

  Rev 1.3    10/19/2003 5:35:14 PM  BGooijen
  SetSocketOption

  Rev 1.2    2003.10.01 9:11:24 PM  czhower
  .Net

  Rev 1.1    7/5/2003 07:25:50 PM  JPMugaas
  Added functions to the Linux stack which use the new TIdIPAddress record type
  for IP address parameters.  I also fixed a compile bug.

  Rev 1.0    11/13/2002 08:59:24 AM  JPMugaas
}

unit IdStackLibc;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  Libc,
  IdStack,
  IdStackConsts,
  IdGlobal,
  IdStackBSDBase;

{$UNDEF LIBCPASS_STRUCT}
{$IFDEF KYLIX}
  {$DEFINE LIBCPASS_STRUCT}
{$ENDIF}
{$IFDEF DELPHI_CROSS}
  {$DEFINE LIBCPASS_STRUCT}
{$ENDIF}
type

  TIdSocketListLibc = class (TIdSocketList)
  protected
    FCount: integer;
    FFDSet: TFDSet;
    //
    class function FDSelect(AReadSet: PFDSet; AWriteSet: PFDSet; AExceptSet: PFDSet;
     const ATimeout: Integer = IdTimeoutInfinite): integer;
    function GetItem(AIndex: Integer): TIdStackSocketHandle; override;
  public
    procedure Add(AHandle: TIdStackSocketHandle); override;
    procedure Remove(AHandle: TIdStackSocketHandle); override;
    function Count: Integer; override;
    procedure Clear; override;
    function Clone: TIdSocketList; override;
    function ContainsSocket(AHandle: TIdStackSocketHandle): boolean; override;
    procedure GetFDSet(var VSet: TFDSet);
    procedure SetFDSet(var VSet: TFDSet);
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
      AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean;
      override;
    function SelectReadList(var VSocketList: TIdSocketList;
      const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
  End;//TIdSocketList

  TIdStackLibc = class(TIdStackBSDBase)
  private
//    procedure SetSocketOption(ASocket: TIdStackSocketHandle;
//      ALevel: TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
    procedure WriteChecksumIPv6(s: TIdStackSocketHandle;
      var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
      const APort: TIdPort);
  protected
    function GetLastError : Integer;
    procedure SetLastError(Const AError : Integer);
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    function ReadHostName: string; override;
    function WSCloseSocket(ASocket: TIdStackSocketHandle): Integer; override;
    function WSRecv(ASocket: TIdStackSocketHandle;
      var ABuffer; const ABufferLength, AFlags: Integer): Integer; override;
    function WSSend(ASocket: TIdStackSocketHandle; const ABuffer; const ABufferLength, AFlags: Integer): Integer; override;
    function WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer; override;
  public
    procedure SetBlocking(ASocket: TIdStackSocketHandle;
        const ABlocking: Boolean); override;
    function WouldBlock(const AResult: Integer): Boolean; override;
    function WSTranslateSocketErrorMsg(const AErr: Integer): string; override;
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion): TIdStackSocketHandle; override;
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function HostByAddress(const AAddress: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    function WSGetLastError: Integer; override;
    procedure WSSetLastError(const AErr : Integer);  override;
    function WSGetServByName(const AServiceName: string): TIdPort; override;
    function WSGetServByPort(const APortNumber: TIdPort): TStrings; override;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle;
      Alevel, AOptname: Integer; AOptval: PAnsiChar; var AOptlen: Integer); override;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
      out AOptVal: Integer); override;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer); override;
    function HostToNetwork(AValue: Word): Word; override;
    function NetworkToHost(AValue: Word): Word; override;
    function HostToNetwork(AValue: LongWord): LongWord; override;
    function NetworkToHost(AValue: LongWord): LongWord; override;
    function HostToNetwork(AValue: Int64): Int64; override;
    function NetworkToHost(AValue: Int64): Int64; override;
    function RecvFrom(const ASocket: TIdStackSocketHandle; var VBuffer;
      const ALength, AFlags: Integer; var VIP: string; var VPort: TIdPort;
      AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; override;
    function ReceiveMsg(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
       APkt: TIdPacketInfo): LongWord; override;
    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer;
      const AIP: string; const APort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function WSSocket(AFamily : Integer; AStruct : TIdSocketType; AProtocol: Integer;
      const AOverlapped: Boolean = False): TIdStackSocketHandle; override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle; ALevel:TIdSocketOptionLevel;
      AOptName: TIdSocketOption; AOptVal: Integer); overload;override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle;
      const Alevel, Aoptname: Integer; Aoptval: PAnsiChar; const Aoptlen: Integer ); overload; override;
    function SupportsIPv6: Boolean; overload; override;
    function CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean; override;
    constructor Create; override;
    destructor Destroy; override;
    //In Windows, this writes a checksum into a buffer.  In Linux, it would probably
    //simply have the kernal write the checksum with something like this (RFC 2292):
//
//    int  offset = 2;
//    setsockopt(fd, IPPROTO_IPV6, IPV6_CHECKSUM, &offset, sizeof(offset));
//
//  Note that this should be called
    //IMMEDIATELY before you do a SendTo because the Local IPv6 address might change

    procedure WriteChecksum(s : TIdStackSocketHandle;
      var VBuffer : TIdBytes;
      const AOffset : Integer;
      const AIP : String;
      const APort : TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function IOControl(const s: TIdStackSocketHandle; const cmd: LongWord;
      var arg: LongWord): Integer; override;

    procedure AddLocalAddressesToList(AAddresses: TStrings); override;
  end;

  TLinger = record
    l_onoff: Word;
    l_linger: Word;
  end;
  TIdLinger = TLinger;

implementation

uses
  IdResourceStrings,
  IdException,
  SysUtils;

type
  psockaddr_in6 = ^sockaddr_in6;

const
  Id_MSG_NOSIGNAL = MSG_NOSIGNAL;
  Id_WSAEPIPE = EPIPE;

constructor TIdStackLibc.Create;
begin
  inherited Create;
end;

destructor TIdStackLibc.Destroy;
begin
  inherited Destroy;
end;

function TIdStackLibc.GetLastError : Integer;
begin
  Result := errno;
end;

procedure TIdStackLibc.SetLastError(Const AError : Integer);
begin
  __errno_location^ := AError;
end;

procedure TIdStackLibc.WSSetLastError(const AErr : Integer);
begin
  SetLastError(AErr);
end;

function TIdStackLibc.Accept(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion): TIdStackSocketHandle;
var
  LN: LongWord;
  LAddr: sockaddr_in6;
begin
  LN := SizeOf(LAddr);
  Result := Libc.accept(ASocket, PSockAddr(@LAddr), @LN);
  if Result <> SOCKET_ERROR then begin
    case LAddr.sin6_family of
      Id_PF_INET4: begin
        with Psockaddr(@LAddr)^ do
        begin
          VIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
          VPort := Ntohs(sin_port);
        end;
        VIPVersion := Id_IPV4;
      end;
      Id_PF_INET6: begin
        with LAddr do
        begin
          VIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
          VPort := ntohs(sin6_port);
        end;
        VIPVersion := Id_IPV6;
      end;
      else begin
        Libc.__close(Result);
        Result := Id_INVALID_SOCKET;
        IPVersionUnsupported;
      end;
    end;
  end else begin
    if GetLastError = EBADF then begin
      SetLastError(EINTR);
    end;
  end;
end;

procedure TIdStackLibc.Bind(ASocket: TIdStackSocketHandle;
  const AIP: string; const APort: TIdPort;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: sockaddr_in6;
begin
  FillChar(LAddr, SizeOf(LAddr), 0);
  case AIPVersion of
    Id_IPv4: begin
        with Psockaddr(@LAddr)^ do
        begin
          sin_family := Id_PF_INET4;
          if AIP <> '' then begin
            TranslateStringToTInAddr(AIP, sin_addr, Id_IPv4);
          end;
          sin_port := htons(APort);
        end;
        CheckForSocketError(Libc.bind(ASocket, {$IFDEF LIBCPASS_STRUCT}PSockAddr(@LAddr)^ {$ELSE} Psockaddr(@LAddr) {$ENDIF},SizeOf(sockaddr)));
      end;
    Id_IPv6: begin
        with LAddr do
        begin
          sin6_family := Id_PF_INET6;
          if AIP <> '' then begin
            TranslateStringToTInAddr(AIP, sin6_addr, Id_IPv6);
          end;
          sin6_port := htons(APort);
        end;
        CheckForSocketError(Libc.bind(ASocket, {$IFDEF LIBCPASS_STRUCT}Psockaddr(@LAddr)^ {$ELSE}Psockaddr(@LAddr){$ENDIF}, SizeOf(sockaddr_in6)));
      end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLibc.WSCloseSocket(ASocket: TIdStackSocketHandle): Integer;
begin
  Result := Libc.__close(ASocket);
end;

procedure TIdStackLibc.Connect(const ASocket: TIdStackSocketHandle;
 const AIP: string; const APort: TIdPort;
 const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: sockAddr_in6;
begin
  FillChar(LAddr, SizeOf(LAddr), 0);
  case AIPVersion of
    Id_IPv4: begin
      with Psockaddr(@LAddr)^ do
      begin
        sin_family := Id_PF_INET4;
        TranslateStringToTInAddr(AIP, sin_addr, Id_IPv4);
        sin_port := htons(APort);
      end;
      CheckForSocketError(Libc.connect(
        ASocket,
        {$IFDEF LIBCPASS_STRUCT}PSockAddr(@LAddr)^{$ELSE}Psockaddr(@LAddr){$ENDIF},
        SizeOf(sockaddr)));
    end;
    Id_IPv6: begin
      with LAddr do
      begin
        sin6_family := Id_PF_INET6;
        TranslateStringToTInAddr(AIP, sin6_addr, Id_IPv6);
        sin6_port := htons(APort);
      end;
      CheckForSocketError(Libc.connect(
        ASocket,
        {$IFDEF LIBCPASS_STRUCT}Psockaddr(@LAddr)^{$ELSE}Psockaddr(@LAddr){$ENDIF},
        SizeOf(sockaddr_in6)));
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLibc.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  Lpa: PAnsiChar;
  Lsa: TInAddr;
  LHost: PHostEnt;
// ipv6
  LHints: TAddressInfo;
  {$IFDEF LIBCPASS_STRUCT}
  LAddrInfo: PAddressInfo;
  {$ELSE}
  LAddrInfo: PAddrInfo;
  {$ENDIF}
  LRetVal: Integer;
  {$IFDEF STRING_IS_UNICODE}
  LAStr: AnsiString;
  {$ENDIF}
begin
  case AIPVersion of
    Id_IPv4: begin
      {$IFDEF STRING_IS_UNICODE}
      LAStr := AnsiString(AHostName); // explicit convert to Ansi
      {$ENDIF}
      LHost := Libc.gethostbyname(
        PAnsiChar({$IFDEF STRING_IS_UNICODE}LAStr{$ELSE}AHostName{$ENDIF}));
      if LHost <> nil then begin
        // TODO: gethostbynaame() might return other things besides IPv4
        // addresses, so we should be validating the address type before
        // attempting the conversion...
        Lpa := LHost^.h_addr_list^;
        Lsa.S_un_b.s_b1 := Ord(Lpa[0]);
        Lsa.S_un_b.s_b2 := Ord(Lpa[1]);
        Lsa.S_un_b.s_b3 := Ord(Lpa[2]);
        Lsa.S_un_b.s_b4 := Ord(Lpa[3]);
        Result := TranslateTInAddrToString(Lsa, Id_IPv4);
      end else begin
        //RaiseSocketError(h_errno);
        RaiseLastSocketError;
      end;
    end;
    Id_IPv6: begin
      FillChar(LHints, SizeOf(LHints), 0);
      LHints.ai_family := IdIPFamily[AIPVersion];
      LHints.ai_socktype := Integer(SOCK_STREAM);
      LAddrInfo := nil;

      {$IFDEF STRING_IS_UNICODE}
      LAStr := AnsiString(AHostName); // explicit convert to Ansi
      {$ENDIF}
      LRetVal := getaddrinfo(
        PAnsiChar({$IFDEF STRING_IS_UNICODE}LAStr{$ELSE}AHostName{$ENDIF}),
        nil, @LHints, {$IFDEF LIBCPASS_STRUCT}LAddrInfo{$ELSE}@LAddrInfo{$ENDIF});
      if LRetVal <> 0 then begin
        if LRetVal = EAI_SYSTEM then begin
          IndyRaiseLastError;
        end else begin
          raise EIdResolveError.CreateFmt(RSResolveError, [AHostName, gai_strerror(LRetVal), LRetVal]);
        end;
      end;
      try
        Result := TranslateTInAddrToString(LAddrInfo^.ai_addr^.sin_zero, Id_IPv6);
      finally
        freeaddrinfo(LAddrInfo);
      end;
      end
    else
      Result := ''; // avoid warning
      IPVersionUnsupported;
  end;
end;

function TIdStackLibc.ReadHostName: string;
var
  LStr: AnsiString;
begin
  SetLength(LStr, 250);
  Libc.gethostname(PAnsiChar(LStr), 250);
  Result := String(LStr);
end;

procedure TIdStackLibc.Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);
begin
  CheckForSocketError(Libc.listen(ASocket, ABacklog));
end;

function TIdStackLibc.WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
  const ABufferLength, AFlags: Integer): Integer;
begin
  //IdStackWindows is just: Result := Recv(ASocket, ABuffer, ABufferLength, AFlags);
  Result := Recv(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);
end;

function TIdStackLibc.RecvFrom(const ASocket: TIdStackSocketHandle;
  var VBuffer; const ALength, AFlags: Integer; var VIP: string;
  var VPort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION ): Integer;
var
  LiSize: LongWord;
  LAddr: sockaddr_in6;
begin
  case AIPVersion of
    Id_IPv4,
    Id_IPv6: begin
      if AIPVersion = Id_IPv4 then begin
        LiSize := SizeOf(sockaddr);
      end else begin
        LiSize := SizeOf(sockaddr_in6);
      end;
      Result := Libc.recvfrom(ASocket, VBuffer, ALength, AFlags or Id_MSG_NOSIGNAL, PSockAddr(@LAddr), @LiSize);
      with LAddr do
      begin
        VIP := TranslateTInAddrToString(sin6_addr, AIPVersion);
        VPort := ntohs(sin6_port);
      end;
    end;
    else begin
      Result := 0;
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLibc.ReceiveMsg(ASocket: TIdStackSocketHandle;
  var VBuffer: TIdBytes; APkt: TIdPacketInfo): LongWord;
{var
  LIP : String;
  LPort : TIdPort;
  LSize: Cardinal;
  LAddr: SockAddr_In6;
  LMsg : msghdr;
  LMsgBuf : BUF;
  LControl : TIdBytes;
  LCurCmsg : CMSGHDR;   //for iterating through the control buffer
  LCurPt : Pin_pktinfo;
  LCurPt6 : Pin6_pktinfo;
  LByte : PByte;
  LDummy, LDummy2 : Cardinal;

begin
  //we call the macro twice because we specified two possible structures.
  //Id_IPV6_HOPLIMIT and Id_IPV6_PKTINFO
  LSize := CMSG_LEN(CMSG_LEN(Length(VBuffer)));
  SetLength( LControl,LSize);

  LMsgBuf.len := Length(VBuffer); // Length(VMsgData);
  LMsgBuf.buf := @VBuffer[0]; // @VMsgData[0];

  FillChar(LMsg,SizeOf(LMsg),0);

  LMsg.lpBuffers := @LMsgBuf;
  LMsg.dwBufferCount := 1;

  LMsg.Control.Len := LSize;
  LMsg.Control.buf := @LControl[0];

  LMsg.name := PSOCKADDR(@LAddr);
  LMsg.namelen := SizeOf(LAddr);

  CheckForSocketError(RecvMsg(ASocket, @LMsg, Result, @LDummy, LPwsaoverlapped_COMPLETION_ROUTINE(@LDummy2)));
  APkt.Reset;

  case LAddr.sin6_family of
    Id_PF_INET4: begin
      with PSOCKADDR(@LAddr)^ do
      begin
        APkt.SourceIP :=  TranslateTInAddrToString(sin_addr, Id_IPv4);
        APkt.SourcePort := NToHs(sin_port);
      end;
      APkt.SourceIPVersion := Id_IPv4;
    end;
    Id_PF_INET6: begin
      with LAddr do
      begin
        APkt.SourceIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
        APkt.SourcePort := NToHs(sin6_port);
      end;
      APkt.SourceIPVersion := Id_IPv6;
    end;
    else begin
      Result := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
  LCurCmsg := nil;
  repeat
    LCurCmsg := CMSG_NXTHDR(@LMsg,LCurCmsg);
    if LCurCmsg=nil then
    begin
      break;
    end;
    case LCurCmsg^.cmsg_type of
      IP_PKTINFO :     //done this way because IPV6_PKTINF and  IP_PKTINFO
      //are both 19
      begin
        case LAddr.sin6_family of
          Id_PF_INET4:
          begin
            LCurPt := WSA_CMSG_DATA(LCurCmsg);
            APkt.DestIP := GWindowsStack.TranslateTInAddrToString(LCurPt^.ipi_addr,Id_IPv4);
            APkt.DestIF := LCurPt^.ipi_ifindex;
            APkt.DestIPVersion := Id_IPv4;
          end;
          Id_PF_INET6:
          begin
            LCurPt6 := WSA_CMSG_DATA(LCurCmsg);
            APkt.DestIP := GWindowsStack.TranslateTInAddrToString(LCurPt6^.ipi6_addr,Id_IPv6);
            APkt.DestIF := LCurPt6^.ipi6_ifindex;
            APkt.DestIPVersion := Id_IPv6;
          end;
        end;
      end;
      Id_IPV6_HOPLIMIT :
      begin
        LByte :=  PByte(WSA_CMSG_DATA(LCurCmsg));
        APkt.TTL := LByte^;
      end;
    end;
  until False; }
begin
  APkt.Reset;
  Result := 0; // avoid warning
end;

function TIdStackLibc.WSSend(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer): Integer;
begin
  //CC: Should Id_MSG_NOSIGNAL be included?
  //  Result := Send(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);
  Result := CheckForSocketError(Libc.send(ASocket, ABuffer, ABufferLength, AFlags));
end;

procedure TIdStackLibc.WSSendTo(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer; const AIP: string;
  const APort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: sockaddr_in6;
  LiSize, LBytesOut: Integer;
begin
  case AIPVersion of
    Id_IPv4, Id_IPv6:
      begin
        FillChar(LAddr, SizeOf(LAddr), 0);
        with LAddr do begin
          sin6_family := IdIPFamily[AIPVersion];
          TranslateStringToTInAddr(AIP, sin6_addr, AIPVersion);
          sin6_port := htons(APort);
        end;
        if AIPVersion = Id_IPv4 then begin
          LiSize := SizeOf(sockaddr);
        end else begin
          LiSize := SizeOf(sockaddr_in6);
        end;
        LBytesOut := Libc.sendto(
          ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL,
          {$IFDEF LIBCPASS_STRUCT}Psockaddr(@LAddr)^{$ELSE}Psockaddr(@LAddr){$ENDIF},
          LiSize);
       end;
    else begin
      LBytesOut := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
  if LBytesOut = Id_SOCKET_ERROR then begin
    // TODO: move this into RaiseLastSocketError directly
    if WSGetLastError() = Id_WSAEMSGSIZE then begin
      raise EIdPackageSizeTooBig.Create(RSPackageSizeTooBig);
    end else begin
      RaiseLastSocketError;
    end;
  end else if LBytesOut <> ABufferLength then begin
    raise EIdNotAllBytesSent.Create(RSNotAllBytesSent);
  end;
end;

procedure TIdStackLibc.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  CheckForSocketError(Libc.setsockopt(ASocket, ALevel, AOptName, PAnsiChar(@AOptVal), SizeOf(AOptVal)));
end;

procedure TIdStackLibc.SetSocketOption(const ASocket: TIdStackSocketHandle;
  const Alevel, Aoptname: Integer; Aoptval: PAnsiChar; const Aoptlen: Integer);
begin
  CheckForSocketError(Libc.setsockopt(ASocket, ALevel, Aoptname, Aoptval, Aoptlen));
end;

function TIdStackLibc.WSGetLastError: Integer;
begin
  //IdStackWindows just uses   result := WSAGetLastError;
  Result := GetLastError; //System.GetLastOSError; - FPC doesn't define it in System
  if Result = Id_WSAEPIPE then begin
    Result := Id_WSAECONNRESET;
  end;
end;

function TIdStackLibc.WSSocket(AFamily : Integer; AStruct : TIdSocketType; AProtocol: Integer;
      const AOverlapped: Boolean = False): TIdStackSocketHandle; override;
begin
  Result := Libc.socket(AFamily, AStruct, AProtocol);
end;

function TIdStackLibc.WSGetServByName(const AServiceName: string): TIdPort;
var
  Lps: PServEnt;
  {$IFDEF STRING_IS_UNICODE}
  LAStr: AnsiString;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_UNICODE}
  LAStr := AnsiString(AServiceName); // explicit convert to Ansi
  {$ENDIF}
  Lps := Libc.getservbyname(
    PAnsiChar({$IFDEF STRING_IS_UNICODE}LAStr{$ELSE}AServiceName{$ENDIF}),
    nil);
  if Lps <> nil then begin
    Result := ntohs(Lps^.s_port);
  end else begin
    try
      Result := IndyStrToInt(AServiceName);
    except
      on EConvertError do begin
        raise EIdInvalidServiceName.CreateFmt(RSInvalidServiceName, [AServiceName]);
      end;
    end;
  end;
end;

function TIdStackLibc.WSGetServByPort(const APortNumber: TIdPort): TStrings;
type
  PPAnsiCharArray = ^TPAnsiCharArray;
  TPAnsiCharArray = packed array[0..(MaxLongint div SizeOf(PAnsiChar))-1] of PAnsiChar;
var
  Lps: PServEnt;
  Li: Integer;
  Lp: PPAnsiCharArray;
begin
  Result := TStringList.Create;
  try
    Lps := Libc.getservbyport(htons(APortNumber), nil);
    if Lps <> nil then begin
      Result.Add(String(Lps^.s_name));
      Li := 0;
      Lp := Pointer(Lps^.s_aliases);
      while Lp[Li] <> nil do begin
        Result.Add(String(Lp[Li]));
        Inc(Li);
      end;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdStackLibc.HostToNetwork(AValue: Word): Word;
begin
  Result := htons(AValue);
end;

function TIdStackLibc.NetworkToHost(AValue: Word): Word;
begin
  Result := ntohs(AValue);
end;

function TIdStackLibc.HostToNetwork(AValue: LongWord): LongWord;
begin
  Result := htonl(AValue);
end;

function TIdStackLibc.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := ntohl(AValue);
end;

{ RP - I'm not sure what endian Linux natively uses, thus the
check to see if the bytes need swapping or not ... }
function TIdStackLibc.HostToNetwork(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := htonl(LParts.HighPart);
  if (L <> LParts.HighPart) then begin
    LParts.HighPart := htonl(LParts.LowPart);
    LParts.LowPart := L;
  end;
  Result := LParts.QuadPart;
end;

function TIdStackLibc.NetworkToHost(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := ntohl(LParts.HighPart);
  if (L <> LParts.HighPart) then begin
    LParts.HighPart := ntohl(LParts.LowPart);
    LParts.LowPart := L;
  end;
  Result := LParts.QuadPart;
end;

procedure TIdStackLibc.AddLocalAddressesToList(AAddresses: TStrings);
type
  TaPInAddr = array[0..250] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  Li: Integer;
  LAHost: PHostEnt;
  LPAdrPtr: PaPInAddr;
  LHostName: AnsiString;
begin
  // this won't get IPv6 addresses as I didn't find a way
  // to enumerate IPv6 addresses on a linux machine
  LHostName := AnsiString(HostName);
  LAHost := Libc.gethostbyname(PAnsiChar(LHostName));
  if LAHost = nil then begin
    RaiseLastSocketError;
  end else begin
    LPAdrPtr := PAPInAddr(LAHost^.h_addr_list);
    Li := 0;
    if LPAdrPtr^[Li] <> nil then begin
      AAddresses.BeginUpdate;
      try
        repeat
          // TODO: gethostbynaame() might return other things besides IPv4
          // addresses, so we should be validating the address type before
          // attempting the conversion...
          AAddresses.Add(TranslateTInAddrToString(LPAdrPtr^[Li]^, Id_IPv4));
          Inc(Li);
        until LPAdrPtr^[Li] = nil;
      finally
        AAddresses.EndUpdate;
      end;
    end;
  end;
end;

function TIdStackLibc.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  {$IFDEF LIBCPASS_STRUCT}
  LHints: TAddressInfo;
  LAddrInfo: PAddressInfo;
  {$ELSE}
  LHints: AddrInfo; //The T is no omission - that's what I found in the header
  LAddrInfo: PAddrInfo;
  {$ENDIF}
  LRetVal: integer;
  {$IFDEF STRING_IS_UNICODE}
  LAStr: AnsiString;
  {$ENDIF}
begin
  case AIPVersion of
    Id_IPv6, Id_IPv4: begin
      FillChar(LHints, SizeOf(LHints), 0);
      LHints.ai_family := IdIPFamily[AIPVersion];
      LHints.ai_socktype := Integer(SOCK_STREAM);
      LHints.ai_flags := AI_CANONNAME or AI_NUMERICHOST;
      LAddrInfo := nil;

      {$IFDEF STRING_IS_UNICODE}
      LAStr := AnsiString(AAddress); // explicit convert to Ansi
      {$ENDIF}
      LRetVal := getaddrinfo(
        PAnsiChar({$IFDEF STRING_IS_UNICODE}LAStr{$ELSE}AAddress{$ENDIF}),
        nil, @LHints, {$IFDEF LIBCPASS_STRUCT}LAddrInfo{$ELSE}@LAddrInfo{$ENDIF});
      if LRetVal <> 0 then begin
        if LRetVal = EAI_SYSTEM then begin
          IndyRaiseLastError;
        end else begin
          raise EIdReverseResolveError.CreateFmt(RSReverseResolveError, [AAddress, gai_strerror(LRetVal), LRetVal]);
        end;
      end;
      try
        Result := String(LAddrInfo^.ai_canonname);
      finally
        freeaddrinfo(LAddrInfo);
      end;
    end;
(* JMB: I left this in here just in case someone
        complains, but the other code works on all
        linux systems for all addresses and is thread-safe

variables for it:
  Host: PHostEnt;
  LAddr: u_long;

    Id_IPv4: begin
      // GetHostByAddr is thread-safe in Linux.
      // It might not be safe in Solaris or BSD Unix
      LAddr := inet_addr(PAnsiChar(AAddress));
      Host := GetHostByAddr(@LAddr,SizeOf(LAddr),AF_INET);
      if (Host <> nil) then begin
        Result := Host^.h_name;
      end else begin
        RaiseSocketError(h_errno);
      end;
    end;
*)
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLibc.WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer;
begin
  Result := Libc.shutdown(ASocket, AHow);
end;

procedure TIdStackLibc.Disconnect(ASocket: TIdStackSocketHandle);
begin
  // Windows uses Id_SD_Send, Linux should use Id_SD_Both
  WSShutdown(ASocket, Id_SD_Both);
  // SO_LINGER is false - socket may take a little while to actually close after this
  WSCloseSocket(ASocket);
end;

procedure TIdStackLibc.GetPeerName(ASocket: TIdStackSocketHandle;
 var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  i: LongWord;
  LAddr: sockaddr_in6;
begin
  i := SizeOf(LAddr);
  CheckForSocketError(Libc.getpeername(ASocket, Psockaddr(@LAddr)^, i));
  case LAddr.sin6_family of
    Id_PF_INET4: begin
      with Psockaddr(@LAddr)^ do
      begin
        VIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
        VPort := ntohs(sin_port);
      end;
      VIPVersion := Id_IPV4;
    end;
    Id_PF_INET6: begin
      with LAddr do
      begin
        VIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
        VPort := Ntohs(sin6_port);
      end;
      VIPVersion := Id_IPV6;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackLibc.GetSocketName(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  i: LongWord;
  LAddr: sockaddr_in6;
begin
  i := SizeOf(LAddr);
  CheckForSocketError(Libc.getsockname(ASocket, Psockaddr(@LAddr)^, i));
  case LAddr.sin6_family of
    Id_PF_INET4: begin
      with Psockaddr(@LAddr)^ do
      begin
        VIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
        VPort := ntohs(sin_port);
      end;
      VIPVersion := Id_IPV4;
    end;
    Id_PF_INET6: begin
      with LAddr do
      begin
        VIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
        VPort := ntohs(sin6_port);
      end;
      VIPVersion := Id_IPV6;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackLibc.WSGetSockOpt(ASocket: TIdStackSocketHandle; ALevel,
  AOptname: Integer; AOptval: PAnsiChar; var AOptlen: Integer);
begin
  CheckForSocketError(Libc.getsockopt(ASocket, ALevel, AOptname, AOptval, LongWord(AOptlen)));
end;

procedure TIdStackLibc.GetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption; out AOptVal: Integer);
var
  LLen : Integer;
  LBuf : Integer;
begin
  LLen := SizeOf(Integer);
  WSGetSockOpt(ASocket, ALevel, AOptName, PAnsiChar(@LBuf), LLen);
  AOptVal := LBuf;
end;

function TIdStackLibc.WouldBlock(const AResult: Integer): Boolean;
begin
  //non-blocking does not exist in Linux, always indicate things will block
  Result := True;
end;

function TIdStackLibc.SupportsIPv6: Boolean;
begin
  //In Windows, this does something else.  It checks the LSP's installed.
  Result := CheckIPVersionSupport(Id_IPv6);
end;

function TIdStackLibc.CheckIPVersionSupport(const AIPVersion: TIdIPVersion): Boolean;
var
  LTmpSocket: TIdStackSocketHandle;
begin
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Integer(Id_SOCK_STREAM), Id_IPPROTO_IP );
  Result := LTmpSocket <> Id_INVALID_SOCKET;
  if Result then begin
    WSCloseSocket(LTmpSocket);
  end;
end;

procedure TIdStackLibc.WriteChecksum(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort; const AIPVersion: TIdIPVersion);
begin
  case AIPVersion of
    Id_IPv4 : CopyTIdWord(HostToLittleEndian(CalcCheckSum(VBuffer)), VBuffer, AOffset);
    Id_IPv6 : WriteChecksumIPv6(s, VBuffer, AOffset, AIP, APort);
  else
    IPVersionUnsupported;
  end;
end;

procedure TIdStackLibc.WriteChecksumIPv6(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort);
var
  LOffset : Integer;
begin
//we simply request that the kernal write the checksum when the data
//is sent.  All of the parameters required are because Windows is bonked
//because it doesn't have the IPV6CHECKSUM socket option meaning we have
//to querry the network interface in TIdStackWindows -- yuck!!
  LOffset := AOffset;
  CheckForSocketError(Libc.setsockopt(s, IPPROTO_IPV6, IPV6_CHECKSUM, @LOffset, SizeOf(LOffset)));
end;

function TIdStackLibc.IOControl(const s: TIdStackSocketHandle;
  const cmd: LongWord; var arg: LongWord): Integer;
var
  LArg : PtrUInt;
begin
  LArg := arg;
  Result := ioctl(s, cmd, Pointer(LArg));
end;

{ TIdSocketListLibc }

procedure TIdSocketListLibc.Add(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if not FD_ISSET(AHandle, FFDSet) then begin
      if Count >= __FD_SETSIZE then begin
        raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
      end;
      FD_SET(AHandle, FFDSet);
      Inc(FCount);
    end;
  finally
    Unlock;
  end;
end;//

procedure TIdSocketListLibc.Clear;
begin
  Lock;
  try
    FD_ZERO(FFDSet);
    FCount := 0;
  finally
    Unlock;
  end;
end;

function TIdSocketListLibc.ContainsSocket(
  AHandle: TIdStackSocketHandle): boolean;
begin
  Lock;
  try
    Result := FD_ISSET(AHandle, FFDSet);
  finally
    Unlock;
  end;
end;

function TIdSocketListLibc.Count: Integer;
begin
  Lock;
  try
    Result := FCount;
  finally
    Unlock;
  end;
end;//

class function TIdSocketListLibc.FDSelect(AReadSet, AWriteSet,
  AExceptSet: PFDSet; const ATimeout: Integer): integer;
var
  LTime: TTimeVal;
  LTimePtr: PTimeVal;
begin
  if ATimeout = IdTimeoutInfinite then begin
    LTimePtr := nil;
  end else begin
    LTime.tv_sec := ATimeout div 1000;
    LTime.tv_usec := (ATimeout mod 1000) * 1000;
    LTimePtr := @LTime;
  end;
  Result := Libc.select(MaxLongint, AReadSet, AWriteSet, AExceptSet, LTimePtr);
end;

procedure TIdSocketListLibc.GetFDSet(var VSet: TFDSet);
begin
  Lock;
  try
    VSet := FFDSet;
  finally
    Unlock;
  end;
end;

function TIdSocketListLibc.GetItem(AIndex: Integer): TIdStackSocketHandle;
var
  LIndex, i: Integer;
begin
  Result := 0;
  Lock;
  try
    LIndex := 0;
    //? use FMaxHandle div x
    for i:= 0 to __FD_SETSIZE - 1 do begin
      if FD_ISSET(i, FFDSet) then begin
        if LIndex = AIndex then begin
          Result := i;
          Break;
        end;
        Inc(LIndex);
      end;
    end;
  finally
    Unlock;
  end;
end;//

procedure TIdSocketListLibc.Remove(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if FD_ISSET(AHandle, FFDSet) then begin
      Dec(FCount);
      FD_CLR(AHandle, FFDSet);
    end;
  finally
    Unlock;
  end;
end;//


function TIdStackLibc.WSTranslateSocketErrorMsg(const AErr: Integer): string;
begin
  //we override this function for the herr constants that
  //are returned by the DNS functions
  case AErr of
    Libc.HOST_NOT_FOUND: Result := RSStackHOST_NOT_FOUND;
    Libc.TRY_AGAIN: Result := RSStackTRY_AGAIN;
    Libc.NO_RECOVERY: Result := RSStackNO_RECOVERY;
    Libc.NO_DATA: Result := RSStackNO_DATA;
  else
    Result := inherited WSTranslateSocketErrorMsg(AErr);
  end;
end;

procedure TIdSocketListLibc.SetFDSet(var VSet: TFDSet);
begin
  Lock;
  try
    FFDSet := VSet;
  finally
    Unlock;
  end;
end;

class function TIdSocketListLibc.Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
  AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean;
var
  LReadSet: TFDSet;
  LWriteSet: TFDSet;
  LExceptSet: TFDSet;
  LPReadSet: PFDSet;
  LPWriteSet: PFDSet;
  LPExceptSet: PFDSet;

  procedure ReadSet(AList: TIdSocketList; var ASet: TFDSet; var APSet: PFDSet);
  begin
    if AList <> nil then begin
      TIdSocketListLibc(AList).GetFDSet(ASet);
      APSet := @ASet;
    end else begin
      APSet := nil;
    end;
  end;

begin
  ReadSet(AReadList, LReadSet, LPReadSet);
  ReadSet(AWriteList, LWriteSet, LPWriteSet);
  ReadSet(AExceptList, LExceptSet, LPExceptSet);
  //
  Result := FDSelect(LPReadSet, LPWriteSet, LPExceptSet, ATimeout) >0;
  //
  TIdSocketListLibc(AReadList).SetFDSet(LReadSet);
  TIdSocketListLibc(AWriteList).SetFDSet(LWriteSet);
  TIdSocketListLibc(AExceptList).SetFDSet(LExceptSet);
end;

function TIdSocketListLibc.SelectRead(const ATimeout: Integer): Boolean;
var
  LSet: TFDSet;
begin
  Lock;
  try
    LSet := FFDSet;
    // select() updates this structure on return,
    // so we need to copy it each time we need it
  finally
    Unlock;
  end;
  Result := FDSelect(@LSet, nil, nil, ATimeout) > 0;
end;

function TIdSocketListLibc.SelectReadList(var VSocketList: TIdSocketList;
  const ATimeout: Integer = IdTimeoutInfinite): Boolean;
var
  LSet: TFDSet;
begin
  Lock;
  try
    LSet := FFDSet;
    // select() updates this structure on return,
    // so we need to copy it each time we need it
  finally
    Unlock;
  end;
  Result := FDSelect(@LSet, nil, nil, ATimeout) > 0;
  if Result then begin
    if VSocketList = nil then begin
      VSocketList := TIdSocketList.CreateSocketList;
    end;
    TIdSocketListLibc(VSocketList).SetFDSet(LSet);
  end;
end;

procedure TIdStackLibc.SetBlocking(ASocket: TIdStackSocketHandle;
  const ABlocking: Boolean);
begin
  if not ABlocking then begin
    raise EIdBlockingNotSupported.Create(RSStackNotSupportedOnUnix);
  end;
end;

(*
Why did I remove this again?

 1) it sends SIGPIPE even if the socket is created with the no-sigpipe bit set
    that could be solved by blocking sigpipe within this thread
    This is probably a bug in the Linux kernel, but we could work around it
    by blocking that signal for the time of sending the file (just get the
    sigprocmask, see if pipe bit is set, if not set it and remove again after
    sending the file)

But the more serious reason is another one, which exists in Windows too:
 2) I think that ServeFile is misdesigned:
    ServeFile does not raise an exception if it didn't send all the bytes.
    Now what happens if I have OnExecute assigned like this
      AThread.Connection.ServeFile('...', True); // <-- true to send via kernel
    is that it will return 0, but notice that in this case I didn't ask for the
    result. Net effect is that the thread will loop in OnExecute even if the
    socket is long gone. This doesn't fit Indy semantics at all, exceptions are
    always raised if the remote end disconnects. Even if I would do
      AThread.Connection.ServeFile('...', False);
    then it would raise an exception.
    I think this is a big flaw in the design of the ServeFile function.
    Maybe GServeFile should only return the bytes sent, but then
    TCPConnection.ServeFile() should raise an exception if GServeFile didn't
    send all the bytes.

JM Berg, 2002-09-09

function ServeFile(ASocket: TIdStackSocketHandle; AFileName: string): cardinal;
var
  LFileHandle: integer;
  offset: integer;
  stat: _stat;
begin
  LFileHandle := open(PAnsiChar(AFileName), O_RDONLY);
  try
    offset := 0;
    fstat(LFileHandle, stat);
    Result := sendfile(ASocket, LFileHandle, offset, stat.st_size);
//**    if Result = Cardinal(-1) then RaiseLastOSError;
  finally libc.__close(LFileHandle); end;
end;
*)
function TIdSocketListLibc.Clone: TIdSocketList;
begin
  Result := TIdSocketListLibc.Create;
  try
    Lock;
    try
      TIdSocketListLibc(Result).SetFDSet(FFDSet);
    finally
      Unlock;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

initialization
  GSocketListClass := TIdSocketListLibc;

end.

