unit VisualClassesData;

interface


  function  GetVisualRootPath : string;
  procedure SetVisualRootPath(const aPath : string);


implementation

  uses
    Windows, Registry;

  var
    VisualRoot : string = '';

  const
    tidVisualRoot = '\Software\Wow6432Node\Starpeace2\Five\ModelServer';

  function ReadVisualClassRoot : string;
    var
      Reg  : TRegistry;
    begin
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      try
        if Reg.OpenKey(tidVisualRoot, false)
          then result := Reg.ReadString('BaseDir')
          else result := '';
      finally
        Reg.Free;
      end;
    end;

  procedure WriteVisualClassRoot(aRootPath : string);
    var
      Reg  : TRegistry;
    begin
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      try
        if Reg.OpenKey(tidVisualRoot, true)
          then Reg.WriteString('RootPath', aRootPath)
      finally
        Reg.Free;
      end;
    end;

  function GetVisualRootPath : string;
    begin
      if VisualRoot = ''
        then VisualRoot := 'C:\five\cache\';    //  ReadVisualClassRoot
      result := VisualRoot;
    end;

  procedure SetVisualRootPath(const aPath : string);
    begin
      if aPath[length(aPath)] = '\'
        then VisualRoot := aPath
        else VisualRoot := aPath + '\';
      WriteVisualClassRoot(VisualRoot);
    end;

end.
