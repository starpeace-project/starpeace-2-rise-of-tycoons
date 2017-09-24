unit MainWindow;

interface

  uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    D3DXCore, DirectDraw, Direct3D, FullScreenWindowMgr, StdCtrls;

  type
    TMainForm =
      class(TForm)
        OpenDialog: TOpenDialog;
        InvisibleWindow: TEdit;
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      private
        { Private declarations }
        function InitD3DX : HRESULT;
        function ReleaseD3DX : HRESULT;
        function InitRenderer : HRESULT;
        function LoadTexture : HRESULT;
        function RenderTest(Alpha : single) : HRESULT;
        //HandleModeChanges : HRESULT;
      private
        fD3DXContext    : ID3DXContext;
        fDirectDraw     : IDirectDraw7;
        fDirect3D       : IDirect3D7;
        fDirect3DDevice : IDirect3DDevice7;
        fPrimarySurface : IDirectDrawSurface7;
        fBackBuffer     : IDirectDrawSurface7;
        fTexture        : IDirectDrawSurface7;
        fD3DXReady      : boolean;
        fWidth          : integer;
        fHeight         : integer;
        fMessage        : string;
        fFSWindowMgr    : TFullScreenWindowManager;
      public
        { Public declarations }
      end;

  var
    MainForm: TMainForm;

implementation

  {$R *.DFM}

  uses
    D3DXSprite, D3DXErr, SurfaceUtils;

  const
    cScreenWidth  = 1024;
    cScreenHeight =  768;

  procedure TMainForm.FormCreate(Sender: TObject);
    begin
      Left := 0;
      Top := 0;
      Width := cScreenWidth;
      Height := cScreenHeight;
      if Failed(InitD3DX)
        then Application.MessageBox('D3DX Initialization failed!', 'Error', MB_OK);
    end;

  procedure TMainForm.FormDestroy(Sender: TObject);
    begin
      ReleaseD3DX;
      Application.MessageBox(pchar(fMessage), 'Report', MB_OK);
    end;

  function TMainForm.InitD3DX : HRESULT;
    var
      hr            : HRESULT;
      dwDevice      : dword;
      dwDeviceCount : dword;
      dev           : TD3DX_DEVICEDESC;
      d3dDesc       : TD3DDEVICEDESC7;
      devDesc       : TD3DX_DEVICEDESC;
    begin
      hr := D3DXInitialize;
      if Succeeded(hr)
        then
          begin
            // Look for fastest device which supports the desired blending for sprites
            dwDeviceCount := D3DXGetDeviceCount;
            dev.deviceIndex := D3DX_DEFAULT;
            dev.hwLevel     := D3DX_DEFAULT;
            dev.onPrimary   := TRUE;

            for dwDevice := 0 to pred(dwDeviceCount) do
              begin
                if Succeeded(D3DXGetDeviceCaps(dwDevice, nil, @d3dDesc, nil, nil))
                  then
                    if (((d3dDesc.dpcTriCaps.dwSrcBlendCaps and D3DPBLENDCAPS_SRCALPHA) <> 0) and
                        ((d3dDesc.dpcTriCaps.dwDestBlendCaps and D3DPBLENDCAPS_INVSRCALPHA) <> 0) and
                        ((d3dDesc.dpcTriCaps.dwTextureFilterCaps and D3DPTFILTERCAPS_LINEAR) <> 0) and
                        ((d3dDesc.dpcTriCaps.dwTextureBlendCaps and D3DPTBLENDCAPS_MODULATE) <> 0))
                      then
                        if Succeeded(D3DXGetDeviceDescription(dwDevice, devDesc))
                          then
                            if (D3DX_DEFAULT = dev.hwLevel) or
                               (dev.hwLevel > devDesc.hwLevel) or
                               (dev.hwLevel = devDesc.hwLevel) and (devDesc.onPrimary)
                              then dev := devDesc;
              end;

            if D3DX_DEFAULT = dev.hwLevel
              then hr := D3DXERR_NODIRECT3DDEVICEAVAILABLE
              else
                begin
                  hr := D3DXCreateContext(
                          dev.hwLevel,                    // D3DX device
                          D3DX_CONTEXT_FULLSCREEN,        // flags
                          Handle,                         // Main window
                          cScreenWidth,                   // width
                          cScreenHeight,		  // height
                          fD3DXContext);                  // returned D3DX interface
                  if Succeeded(hr)
                    then
                      begin
                        fD3DXReady := true;
                        hr := InitRenderer;
                      end;
                end;
          end;
      Result := hr;
    end;

  function TMainForm.ReleaseD3DX : HRESULT;
    begin
      fTexture        := nil;
      fDirectDraw     := nil;
      fDirect3DDevice := nil;
      fBackBuffer     := nil;
      fPrimarySurface := nil;
      //fDirect3D       := nil;
      fD3DXContext    := nil;
      Result := D3DXUninitialize;
    end;

  function TMainForm.InitRenderer : HRESULT;
    begin
      if fD3DXReady
        then
          begin
            fDirectDraw := IDirectDraw7(fD3DXContext.GetDD); // >>> this a temporary patch
            SurfaceUtils.DirectDrawObj := fDirectDraw;
            fDirect3DDevice := IDirect3DDevice7(fD3DXContext.GetD3DDevice);
            fPrimarySurface := IDirectDrawSurface7(fD3DXContext.GetPrimary);
            fBackBuffer := IDirectDrawSurface7(fD3DXContext.GetBackBuffer(0));
            fFSWindowMgr := TFullScreenWindowManager.Create(Handle, fDirectDraw, fPrimarySurface, fBackBuffer);
            fFSWindowMgr.RegisterWindow(InvisibleWindow.Handle, false, 0);
            fDirect3DDevice.GetCaps(SurfaceUtils.DeviceCaps);
            if fDirect3DDevice <> nil
              then
                begin
                  fDirectDraw := IDirectDraw7(fD3DXContext.GetDD);
                  if fDirectDraw <> nil
                    then
                      begin
                        // Enable dither, specular, lighting and z-buffer usage
                        fDirect3DDevice.SetRenderState(D3DRENDERSTATE_COLORKEYENABLE,    1);
                        fDirect3DDevice.SetRenderState(D3DRENDERSTATE_DITHERENABLE,      0);
                        fDirect3DDevice.SetRenderState(D3DRENDERSTATE_SPECULARENABLE,    0);
                        fDirect3DDevice.SetRenderState(D3DRENDERSTATE_LIGHTING,          0);
                        fDirect3DDevice.SetRenderState(D3DRENDERSTATE_ZENABLE,           0);
                        // Enable vertices to have colors
                        fDirect3DDevice.SetRenderState(D3DRENDERSTATE_COLORVERTEX,       0);
                        fDirect3DDevice.SetRenderState(D3DRENDERSTATE_DIFFUSEMATERIALSOURCE,     0);

                        // Set the background to bright blue (red/green/blue/alpha)
                        fD3DXContext.SetClearColor(TD3DCOLOR(D3DRGBA(0.0, 0.0, 1.0, 1.0)));

                        fD3DXContext.Clear(D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER);

                        Result := S_OK;
                      end
                    else Result := E_FAIL;
                end
              else Result := E_FAIL;
          end
        else Result := E_FAIL;
    end;

  function TMainForm.LoadTexture : HRESULT;
    var
      hr         : HRESULT;
      errstr     : string;
      bmp        : TBitmap;
      hdcTexture : HDC;
      colorkey   : TDDCOLORKEY;
    begin
      bmp := TBitmap.Create;
      bmp.LoadFromFile('C:\Shared\TestImages\mine2.bmp');
      fWidth := bmp.Width;
      fHeight := bmp.Height;
      fTexture := CreateTextureSurface(bmp.Width, bmp.Height, 16, true);
      //fTexture := CreateCompatibleOffscreenSurface(bmp.Width, bmp.Height);
      //fTexture := CreateOffscreenSurface(bmp.Width, bmp.Height, 16);
      if fTexture <> nil
        then
          begin
            hr := fTexture.GetDC(hdcTexture);
            if Succeeded(hr)
              then
                begin
                  if not BitBlt(hdcTexture, 0, 0, bmp.Width, bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY)
                    then MessageBeep(0);
                  fTexture.ReleaseDC(hdcTexture);
                  {
                  colorkey.dwColorSpaceHighValue := word(pchar(bmp.Scanline[0])[0]);
                  colorkey.dwColorSpaceLowValue := word(pchar(bmp.Scanline[0])[0]);
                  hr := fTexture.SetColorKey(DDCKEY_SRCBLT, @colorkey);
                  if Failed(hr)
                    then
                      begin
                        SetLength(errstr, 1000);
                        D3DXGetErrorString(hr, 1000, errstr);
                        Application.MessageBox(pchar(errstr), 'Error', MB_OK);
                      end;
                  }
                end
              else
                begin
                  SetLength(errstr, 1000);
                  D3DXGetErrorString(hr, 1000, pchar(errstr));
                  Application.MessageBox(pchar(errstr), 'Error', MB_OK);
                end;
          end
        else hr := S_FALSE;
      Result := hr;
    end;
    {
    var
      hr         : HRESULT;
      errstr     : string;
      colorkey   : TDDCOLORKEY;
      bmp        : TBitmap;
    begin
      bmp := TBitmap.Create;
      bmp.LoadFromFile('C:\Shared\TestImages\mine2.bmp');
      fWidth := bmp.Width;
      fHeight := bmp.Height;
      hr := D3DXCreateTextureFromFile(
                                       fDirect3DDevice,
				       nil,                  // dwFlags
				       nil,                  // auto-width
				       nil,                  // auto-height
				       nil,                  // auto-surface type
				       nil,                  // pointer to Palette
				       fTexture,              // returned pointer to texture
				       nil,                   // returned number of mip-maps
				       'C:\Shared\TestImages\mine2.bmp',          // file name for texture
				       D3DX_FT_DEFAULT);      // default scaling
      if Succeeded(hr)
        then
          begin
            colorkey.dwColorSpaceHighValue := word(pchar(bmp.Scanline[0])[0]);
            colorkey.dwColorSpaceLowValue := word(pchar(bmp.Scanline[0])[0]);
            hr := fTexture.SetColorKey(DDCKEY_SRCBLT, @colorkey);
            if Failed(hr)
              then
                begin
                  SetLength(errstr, 1000);
                  D3DXGetErrorString(hr, 1000, pchar(errstr));
                  Application.MessageBox(pchar(errstr), 'Error', MB_OK);
                end;
          end
        else
          begin
            SetLength(errstr, 1000);
            D3DXGetErrorString(hr, 1000, pchar(errstr));
            Application.MessageBox(pchar(errstr), 'Error', MB_OK);
          end;
      Result := hr;
    end;
    }

  function TMainForm.RenderTest(Alpha : single) : HRESULT;
    const
      cLoopCount = 1000;
    var
      hr               : HRESULT;
      viewport         : TD3DVIEWPORT7;
      rectViewport     : TRect;
      pointDest        : TD3DXVECTOR3;
      initialtickcount : integer;
      elapsedticks     : integer;
      i                : integer;
      x, y             : integer;
      ClipRect         : TRect;
      DestRect         : TRect;
      errstr           : string;
    begin
      if (fTexture <> nil) and fD3DXReady
        then
          if Succeeded(fDirect3DDevice.BeginScene)
            then
              begin
                fD3DXContext.Clear(D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER);

                // We need to setup the rasterizer for rendering sprites;
                // this only needs to be done once for all the sprites that
                // are rendered; however this function does need to be called
                // again if any render state changes are made outside of the
                // bltsprite call.
                D3DXPrepareDeviceForSprite(fDirect3DDevice, False);

                // Get our current viewport
                hr := fDirect3DDevice.GetViewport(viewport);
                if Succeeded(hr)
                  then
                    begin
                      // Convert the viewport into a proper Rect
                      rectViewport.left   := viewport.dwX;
                      rectViewport.top    := viewport.dwY;
                      rectViewport.right  := viewport.dwX + viewport.dwWidth;
                      rectViewport.bottom := viewport.dwY + viewport.dwHeight;

                      // Our non-rotated render target should be centered in the viewport;
                      pointDest.x := viewport.dwX + viewport.dwWidth/2.0;
                      pointDest.y := viewport.dwY + viewport.dwHeight/2.0;
                      pointDest.z := 0.0;

                      initialtickcount := GetTickCount();
                      // Go ahead and do the render
                      if Alpha = 1.0
                        then
                          begin
                            //fDirect3DDevice.Preload(fTexture);
                            x := cScreenWidth div 2;
                            y := cScreenHeight div 2;
                            DestRect := Rect(x, y, x + fWidth, y + fHeight);
                            IntersectRect(DestRect, DestRect, ClientRect);
                            ClipRect := DestRect;
                            OffsetRect(ClipRect, -x, -y);
                            for i := 0 to pred(cLoopCount) do
                              begin
                                hr := fBackBuffer.Blt(
                                                       @DestRect,       // dst sub rect
                                                       fTexture,        // texture
                                                       @ClipRect,  	// src sub rect
                                                       DDBLT_DONOTWAIT,
                                                       nil
                                                     );
                                if Failed(hr)
                                  then
                                    begin
                                      SetLength(errstr, 1000);
                                      D3DXGetErrorString(hr, 1000, pchar(errstr));
                                      Application.MessageBox(pchar(errstr), 'Error', MB_OK);
                                      break;
                                    end;
                              end
                          end
                        else
                          begin
                            ClipRect := Rect(0, 0, fWidth, fHeight);
                            for i := 0 to pred(cLoopCount) do
                              begin
                                //pointDest.x := random(cScreenWidth);
                                //pointDest.y := random(cScreenHeight);
                                pointDest.x := cScreenWidth/2;
                                pointDest.y := cScreenHeight/2;
                                hr := D3DXDrawSpriteSimple(
                                                            fTexture,           // texture
                                                            fDirect3DDevice,    // 3D device
                                                            @pointDest,         // destination point (center)
                                                            Alpha,		// alpha
                                                            1.0,		// scale
                                                            0.0,		// rotation
                                                            nil,                // offset
                                                            @ClipRect  	        // src sub rect
                                                          );
                                if Failed(hr)
                                  then
                                    begin
                                      SetLength(errstr, 1000);
                                      D3DXGetErrorString(hr, 1000, pchar(errstr));
                                      Application.MessageBox(pchar(errstr), 'Error', MB_OK);
                                      break;
                                    end;
                              end;
                          end;

                      fDirect3DDevice.EndScene;
                      //fFSWindowMgr.UpdateScreen([ClientRect]);
                      fPrimarySurface.Flip(nil, DDFLIP_DONOTWAIT);
                      //hr := fD3DXContext.UpdateFrame(D3DX_DEFAULT);
                      {
                      if (hr = DDERR_SURFACELOST) or (hr = DDERR_SURFACEBUSY)
                        then hr = HandleModeChanges();
                      }
                      elapsedticks := GetTickCount() - initialtickcount;
                      fMessage := IntToStr(i) + ' images rendered in ' + IntToStr(elapsedticks) + ' milliseconds.';
                      //OutputDebugString(pchar(IntToStr(i) + ' images rendered in ' + IntToStr(elapsedticks) + ' milliseconds.'));
                    end;
              end
            else hr := E_FAIL
        else hr := E_FAIL;
      Result := hr;
    end;

  procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    begin
      case key of
        VK_F3:
          LoadTexture;
        VK_F4:
          RenderTest(1.0);
        VK_F5:
          RenderTest(0.5);
      end;
    end;

end.
