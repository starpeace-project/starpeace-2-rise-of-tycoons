
# ******************************************************************
# *                                                                *
# *     Delphi Runtime Library                                     *
# *     MAKE script                                                *
# *                                                                *
# *     Copyright (C) 1988,2004 Borland Software Corporation       *
# *                                                                *
# ******************************************************************

# This MAKE script requires Borland MAKE Version 3.7 or later (MAKE.EXE).

# The script assumes that DCC32.EXE is present on the current
# search path--if this is not the case, modify the DCC macro
# below to reflect the location of the executable.

# To build the runtime library without debug information (the default),
# simply run MAKE.EXE from the directory containing this MAKEFILE. To
# build a debug version of the runtime library, specify a -DDEBUG command
# line parameter when running MAKE.EXE.

# The BIN and LIB macros define the output directories for binaries and
# compiled units.

DCC = dcc32 -q

BIN = bin
LIB = lib

!if $d(DEBUG)
RTLDEBUG = -$$D+
ASMDEBUG = -zi
!else
RTLDEBUG = -$$D-
ASMDEBUG = -zn
!endif


SYSUTILSOBJ = \
sys\ffmt.obj

default: \
$(LIB)\system.dcu   \
$(LIB)\SysConst.dcu \
$(LIB)\sharemem.dcu \
$(LIB)\comobj.dcu   \
$(LIB)\comserv.dcu  \
$(LIB)\windows.dcu  \
$(LIB)\sysutils.dcu \
$(LIB)\varutils.dcu \
$(LIB)\variants.dcu \
$(LIB)\messages.dcu \
$(LIB)\shellapi.dcu \
$(LIB)\shlobj.dcu   \
$(LIB)\dlgs.dcu     \
$(LIB)\commdlg.dcu  \
$(LIB)\commctrl.dcu \
$(LIB)\ddeml.dcu    \
$(LIB)\flatsb.dcu   \
$(LIB)\mmsystem.dcu \
$(LIB)\nsapi.dcu    \
$(LIB)\isapi.dcu    \
$(LIB)\isapi2.dcu   \
$(LIB)\wininet.dcu  \
$(LIB)\winspool.dcu \
$(LIB)\winsock.dcu  \
$(LIB)\winsvc.dcu   \
$(LIB)\mapi.dcu     \
$(LIB)\multimon.dcu \
$(LIB)\lzexpand.dcu \
$(LIB)\nb30.dcu     \
$(LIB)\ole2.dcu     \
$(LIB)\olectl.dcu   \
$(LIB)\oledlg.dcu   \
$(LIB)\richedit.dcu \
$(LIB)\tlhelp32.dcu \
$(LIB)\math.dcu     \
$(LIB)\dateutils.dcu \
$(LIB)\strutils.dcu \
$(LIB)\imm.dcu      \
$(LIB)\activex.dcu  \
$(LIB)\cpl.dcu      \
$(LIB)\imagehlp.dcu \
$(LIB)\opengl.dcu   \
$(LIB)\penwin.dcu   \
$(LIB)\regstr.dcu   \
$(LIB)\classes.dcu   \
$(LIB)\contnrs.dcu   \
$(LIB)\helpintfs.dcu \
$(LIB)\rtlconsts.dcu \
$(LIB)\comconst.dcu  \
$(LIB)\convutils.dcu \
$(LIB)\inifiles.dcu  \
$(LIB)\masks.dcu     \
$(LIB)\maskutils.dcu \
$(LIB)\registry.dcu  \
$(LIB)\stdconvs.dcu  \
$(LIB)\syncobjs.dcu  \
$(LIB)\typinfo.dcu   \
$(LIB)\varcmplx.dcu  \
$(LIB)\varconv.dcu   \
$(LIB)\vclcom.dcu    \
$(LIB)\urlmon.dcu    \
$(LIB)\Mtsobj.dcu    \
$(LIB)\ObjAuto.dcu   \
$(LIB)\StdVCL.dcu    \
$(LIB)\WideStrings.dcu \
$(LIB)\WideStrUtils.dcu \
$(LIB)\SysInit.dcu   \
$(LIB)\Types.dcu     \
$(LIB)\AccCtrl.dcu   \
$(LIB)\AclAPI.dcu    \
$(LIB)\AspTlb.dcu    \
$(LIB)\COMAdmin.dcu  \
$(LIB)\ComSvcs.dcu   \
$(LIB)\msxml.dcu     \
$(LIB)\Mtx.dcu       \
$(LIB)\Ns30Fix.dcu   \
$(LIB)\Ns35Fix.dcu   \
$(LIB)\Ns36Fix.dcu   \
$(LIB)\ObjComAuto.dcu \
$(LIB)\PsAPI.dcu     \
$(LIB)\SHFolder.dcu  \
$(LIB)\UxTheme.dcu


$(LIB)\system.dcu: sys\system.pas sys\sysinit.pas sys\getmem.inc
 $(DCC) sys\system -m -y -z $(RTLDEBUG) -n$(LIB)

$(LIB)\SysConst.dcu: sys\SysConst.pas $(LIB)\system.dcu
 $(DCC) sys\SysConst -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\comobj.dcu: common\comobj.pas $(LIB)\system.dcu \
$(LIB)\sysutils.dcu $(LIB)\windows.dcu $(LIB)\activex.dcu
 $(DCC) common\comobj -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\comserv.dcu: common\comserv.pas $(LIB)\system.dcu \
$(LIB)\comobj.dcu $(LIB)\sysutils.dcu $(LIB)\windows.dcu
 $(DCC) common\comserv -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\sharemem.dcu: sys\sharemem.pas $(LIB)\system.dcu
 $(DCC) sys\sharemem -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\windows.dcu: win\windows.pas $(LIB)\system.dcu
 $(DCC) win\windows -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\sysutils.dcu: sys\sysutils.pas  \
$(LIB)\system.dcu $(LIB)\windows.dcu
 $(DCC) sys\sysutils -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\varutils.dcu: sys\varutils.pas $(VARUTILSOBJ) \
$(LIB)\system.dcu $(LIB)\sysutils.dcu
 $(DCC) sys\varutils -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\variants.dcu: sys\variants.pas $(VARIANTSSOBJ) \
$(LIB)\system.dcu $(LIB)\sysutils.dcu $(LIB)\varutils.dcu
 $(DCC) sys\variants -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\messages.dcu: win\messages.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\messages -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\shellapi.dcu: win\shellapi.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\shellapi -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\regstr.dcu: win\regstr.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\regstr -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\shlobj.dcu: win\shlobj.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu $(LIB)\ole2.dcu $(LIB)\commctrl.dcu \
$(LIB)\shellapi.dcu $(LIB)\regstr.dcu
 $(DCC) win\shlobj -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\dlgs.dcu: win\dlgs.pas $(LIB)\system.dcu
 $(DCC) win\dlgs -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\commdlg.dcu: win\commdlg.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu $(LIB)\messages.dcu
 $(DCC) win\commdlg -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\commctrl.dcu: win\commctrl.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\commctrl -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\ddeml.dcu: win\ddeml.pas $(LIB)\system.dcu $(LIB)\windows.dcu
 $(DCC) win\ddeml -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\mmsystem.dcu: win\mmsystem.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\mmsystem -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\winspool.dcu: win\winspool.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\winspool -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\isapi.dcu: win\isapi.pas $(LIB)\system.dcu $(LIB)\windows.dcu
 $(DCC) win\isapi -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\isapi2.dcu: win\isapi2.pas $(LIB)\system.dcu $(LIB)\windows.dcu
 $(DCC) win\isapi2 -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\nsapi.dcu: win\nsapi.pas $(LIB)\system.dcu $(LIB)\windows.dcu
 $(DCC) win\nsapi -z $(RTLDEBUG) -u$(LIB);win -n$(LIB)

$(LIB)\wininet.dcu: win\wininet.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\wininet -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\winsock.dcu: win\winsock.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\winsock -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\winsvc.dcu: win\winsvc.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\winsvc -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\mapi.dcu: win\mapi.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\mapi -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\lzexpand.dcu: win\lzexpand.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\lzexpand -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\nb30.dcu: win\nb30.pas $(LIB)\system.dcu $(LIB)\windows.dcu
 $(DCC) win\nb30 -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\ole2.dcu: win\ole2.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\ole2 -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\olectl.dcu: win\olectl.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu $(LIB)\messages.dcu $(LIB)\ole2.dcu
 $(DCC) win\olectl -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\oledlg.dcu: win\oledlg.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu $(LIB)\commctrl.dcu $(LIB)\ole2.dcu
 $(DCC) win\oledlg -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\richedit.dcu: win\richedit.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\richedit -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\tlhelp32.dcu: win\tlhelp32.pas $(LIB)\system.dcu \
$(LIB)\windows.dcu
 $(DCC) win\tlhelp32 -z $(RTLDEBUG) -u$(LIB) -n$(LIB)

$(LIB)\math.dcu: common\math.pas $(LIB)\system.dcu
 $(DCC) common\math -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\dateutils.dcu: common\dateutils.pas $(LIB)\system.dcu \
 $(LIB)\sysutils.dcu $(LIB)\math.dcu
 $(DCC) common\dateutils -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\strutils.dcu: common\strutils.pas $(LIB)\system.dcu \
 $(LIB)\sysutils.dcu
 $(DCC) common\strutils -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\imm.dcu: win\imm.pas $(LIB)\windows.dcu
 $(DCC) win\imm -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\activex.dcu: win\activex.pas $(LIB)\windows.dcu $(LIB)\messages.dcu
 $(DCC) win\activex -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\cpl.dcu: win\cpl.pas $(LIB)\windows.dcu $(LIB)\messages.dcu
 $(DCC) win\cpl -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\imagehlp.dcu: win\imagehlp.pas $(LIB)\windows.dcu
 $(DCC) win\imagehlp -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\opengl.dcu: win\opengl.pas $(LIB)\windows.dcu
 $(DCC) win\opengl -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\penwin.dcu: win\penwin.pas $(LIB)\windows.dcu $(LIB)\messages.dcu \
$(LIB)\mmsystem.dcu
 $(DCC) win\penwin -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\urlmon.dcu: win\urlmon.pas $(LIB)\windows.dcu $(LIB)\activex.dcu
 $(DCC) win\urlmon -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\flatsb.dcu: win\flatsb.pas $(LIB)\windows.dcu
 $(DCC) win\flatsb -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\multimon.dcu: win\multimon.pas $(LIB)\windows.dcu
 $(DCC) win\multimon -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\classes.dcu: common\classes.pas $(LIB)\system.dcu \
$(LIB)\Windows.dcu $(LIB)\Messages.dcu $(LIB)\SysUtils.dcu \
$(LIB)\Variants.dcu $(LIB)\TypInfo.dcu $(LIB)\ActiveX.dcu $(LIB)\RTLConsts.dcu
 $(DCC) common\classes.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\comconst.dcu: common\comconst.pas $(LIB)\system.dcu
 $(DCC) common\comconst.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\contnrs.dcu: common\contnrs.pas $(LIB)\system.dcu $(LIB)\SysUtils.dcu \
$(LIB)\RTLConsts.dcu $(LIB)\Math.dcu
 $(DCC) common\contnrs.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\convutils.dcu: common\convutils.pas $(LIB)\SysUtils.dcu \
$(LIB)\RTLConsts.dcu $(LIB)\Math.dcu
 $(DCC) common\convutils.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\helpintfs.dcu: common\helpintfs.pas $(LIB)\Classes.dcu $(LIB)\Contnrs.dcu
 $(DCC) common\helpintfs.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\rtlconsts.dcu: common\rtlconsts.pas $(LIB)\system.dcu
 $(DCC) common\rtlconsts.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\inifiles.dcu: common\inifiles.pas $(LIB)\Classes.dcu
 $(DCC) common\inifiles.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\masks.dcu: common\masks.pas $(LIB)\SysUtils.dcu $(LIB)\RTLConsts.dcu
 $(DCC) common\masks.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\maskutils.dcu: common\maskutils.pas $(LIB)\SysUtils.dcu
 $(DCC) common\maskutils.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\registry.dcu: common\registry.pas $(LIB)\Classes.dcu $(LIB)\IniFiles.dcu
 $(DCC) common\registry.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\stdconvs.dcu: common\stdconvs.pas $(LIB)\convutils.dcu $(LIB)\dateutils.dcu
 $(DCC) common\stdconvs.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\syncobjs.dcu: common\syncobjs.pas $(LIB)\classes.dcu
 $(DCC) common\syncobjs.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\typinfo.dcu: common\typinfo.pas $(LIB)\variants.dcu $(LIB)\sysutils.dcu \
$(LIB)\rtlconsts.dcu
 $(DCC) common\typinfo.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\varcmplx.dcu: common\varcmplx.pas $(LIB)\variants.dcu $(LIB)\sysutils.dcu \
$(LIB)\VarUtils.dcu $(LIB)\Math.dcu $(LIB)\SysConst.dcu $(LIB)\TypInfo.dcu \
$(LIB)\Classes.dcu
 $(DCC) common\varcmplx.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\varconv.dcu: common\varconv.pas $(LIB)\variants.dcu $(LIB)\convutils.dcu
 $(DCC) common\varconv.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\vclcom.dcu: common\vclcom.pas $(LIB)\Classes.dcu $(LIB)\comobj.dcu
 $(DCC) common\vclcom.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\mtsobj.dcu: common\mtsobj.pas $(LIB)\windows.dcu $(LIB)\comobj.dcu $(LIB)\mtx.dcu
 $(DCC) common\mtsobj.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\ObjAuto.dcu: common\ObjAuto.pas $(LIB)\typinfo.dcu $(LIB)\sysutils.dcu \
$(LIB)\variants.dcu $(LIB)\varutils.dcu $(LIB)\rtlconsts.dcu
 $(DCC) common\ObjAuto.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\StdVCL.dcu: common\StdVCL.pas
 $(DCC) common\StdVCL.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\WideStrings.dcu: common\WideStrings.pas $(LIB)\classes.dcu $(LIB)\sysutils.dcu \
$(LIB)\windows.dcu $(LIB)\rtlconsts.dcu $(LIB)\widestrutils.dcu
 $(DCC) common\WideStrings.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\WideStrUtils.dcu: common\WideStrUtils.pas $(LIB)\classes.dcu $(LIB)\sysutils.dcu \
$(LIB)\windows.dcu
 $(DCC) common\WideStrUtils.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\Types.dcu: sys\Types.pas
 $(DCC) sys\Types.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\AccCtrl.dcu: win\AccCtrl.pas $(LIB)\windows.dcu
 $(DCC) win\AccCtrl.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\AclAPI.dcu: win\AclAPI.pas $(LIB)\windows.dcu $(LIB)\accctrl.dcu
 $(DCC) win\AclAPI.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\AspTlb.dcu: win\AspTlb.pas $(LIB)\activex.dcu $(LIB)\comobj.dcu \
$(LIB)\mtx.dcu
 $(DCC) win\AspTlb.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\COMAdmin.dcu: win\COMAdmin.pas $(LIB)\windows.dcu $(LIB)\activex.dcu
 $(DCC) win\COMAdmin.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\ComSvcs.dcu: win\ComSvcs.pas $(LIB)\windows.dcu $(LIB)\activex.dcu \
$(LIB)\mtx.dcu
 $(DCC) win\ComSvcs.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\msxml.dcu: win\msxml.pas $(LIB)\windows.dcu $(LIB)\activex.dcu \
$(LIB)\comobj.dcu
 $(DCC) win\msxml.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\Mtx.dcu: win\Mtx.pas $(LIB)\windows.dcu $(LIB)\comobj.dcu
 $(DCC) win\Mtx.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\Ns30Fix.dcu: win\Ns30Fix.pas $(LIB)\windows.dcu $(LIB)\nsapi.dcu
 $(DCC) win\Ns30Fix.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\Ns35Fix.dcu: win\Ns35Fix.pas $(LIB)\windows.dcu $(LIB)\nsapi.dcu
 $(DCC) win\Ns35Fix.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\Ns36Fix.dcu: win\Ns36Fix.pas $(LIB)\windows.dcu $(LIB)\nsapi.dcu
 $(DCC) win\Ns36Fix.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\ObjComAuto.dcu: win\ObjComAuto.pas $(LIB)\windows.dcu $(LIB)\activex.dcu \
$(LIB)\objauto.dcu $(LIB)\typinfo.dcu $(LIB)\comobj.dcu $(LIB)\sysutils.dcu \
$(LIB)\classes.dcu
 $(DCC) win\ObjComAuto.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\PsAPI.dcu: win\PsAPI.pas $(LIB)\windows.dcu
 $(DCC) win\PsAPI.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\SHFolder.dcu: win\SHFolder.pas $(LIB)\windows.dcu
 $(DCC) win\SHFolder.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

$(LIB)\UxTheme.dcu: win\UxTheme.pas $(LIB)\windows.dcu $(LIB)\commctrl.dcu \
$(LIB)\syncobjs.dcu
 $(DCC) win\UxTheme.pas -z $(RTLDEBUG) -u$(LIB) -r$(LIB) -n$(LIB)

