program FIVEVoyager;

uses
  ShareMem,
  Forms,
  VoyagerWindow in 'VoyagerWindow.pas' {VoyagerWin},
  VoyagerInterfaces in 'VoyagerInterfaces.pas',
  URLParser in 'URLParser.pas',
  Frames in 'Frames.pas',
  HTMLHandler in 'URLHandlers\HTMLHandler.pas',
  ServerCnxHandler in 'URLHandlers\ServerCnxHandler.pas',
  VoyagerServerInterfaces in 'VoyagerServerInterfaces.pas',
  Protocol in '..\Protocol\Protocol.pas',
  VoyagerEvents in 'VoyagerEvents.pas',
  LandClassesHandler in 'URLHandlers\LandClassesHandler.pas',
  LandInfo in '..\Land\LandInfo.pas',
  ChatListHandlerViewer in 'URLHandlers\ChatListHandlerViewer.pas' {ChatListHandlerView},
  ChatHandlerViewer in 'URLHandlers\ChatHandlerViewer.pas' {ChatHandlerView},
  ChatHandler in 'URLHandlers\ChatHandler.pas',
  VisualControls in 'Components\VisualControls.pas',
  Land in '..\Land\Land.pas',
  MsgComposerHandlerViewer in 'URLHandlers\MsgComposerHandlerViewer.pas' {MsgComposerHandlerView},
  MsgComposerHandler in 'URLHandlers\MsgComposerHandler.pas',
  MailProtocol in '..\Mail\MailProtocol.pas',
  MailConsts in '..\Mail\MailConsts.pas',
  ConfirmPasswordDialog in 'URLHandlers\ConfirmPasswordDialog.pas' {ConfirmPasswordDlg},
  VoyagerUIEvents in 'VoyagerUIEvents.pas',
  FiveControl in 'Components\MapIsoView\FiveControl.pas',
  GameControl in 'Components\MapIsoView\GameControl.pas',
  GameTypes in 'Components\MapIsoView\GameTypes.pas',
  AxlDebug in '..\Utils\CodeLib\AxlDebug.pas',
  MapTypes in 'Components\MapIsoView\MapTypes.pas',
  Lander in 'Components\MapIsoView\Lander.pas',
  LanderTypes in 'Components\MapIsoView\LanderTypes.pas',
  Map in 'Components\MapIsoView\Map.pas',
  ImageCache in 'Components\MapIsoView\ImageCache.pas',
  IniClasses in '..\Cache\IniClasses.pas',
  MapIsoView in 'Components\MapIsoView\MapIsoView.pas' {MapIsoViewer},
  MapIsoHandler in 'URLHandlers\MapIsoHandler.pas',
  UniversalMapHandler in 'URLHandlers\UniversalMapHandler.pas',
  ConfigHandler in 'URLHandlers\ConfigHandler.pas',
  VisualClassesHandler in 'URLHandlers\VisualClassesHandler.pas',
  ToolbarHandlerViewer in 'URLHandlers\ToolbarHandlerViewer.pas' {ToolbarHandlerView},
  ToolbarHandler in 'URLHandlers\ToolbarHandler.pas',
  ScrollRegions in '..\Utils\CodeLib\ScrollRegions.pas',
  CoreTypes in '..\Utils\CodeLib\CoreTypes.pas',
  Threads in '..\Utils\CodeLib\Threads.pas',
  Circuits in 'Components\MapIsoView\Circuits.pas',
  BuildClasses in 'Components\MapIsoView\BuildClasses.pas',
  TimerTypes in '..\Utils\CodeLib\TimerTypes.pas',
  Concrete in 'Components\MapIsoView\Concrete.pas',
  TimerUtils in '..\Utils\WinUtils\TimerUtils.pas',
  Car in 'Components\MapIsoView\Car.pas',
  WinUtils in '..\Utils\WinUtils\WinUtils.pas',
  Warnings in '..\Utils\CodeLib\Warnings.pas',
  ShutDown in '..\Utils\CodeLib\ShutDown.pas',
  FiveTypes in 'Components\MapIsoView\FiveTypes.pas',
  Animations in '..\Utils\CodeLib\Animations.pas',
  CircuitsHandler in 'Components\MapIsoView\CircuitsHandler.pas',
  ServerCnxEvents in 'ServerCnxEvents.pas',
  BackupInterfaces in '..\Persistence\BackupInterfaces.pas',
  Config in 'Config.pas',
  HintBox in 'URLHandlers\HintBox.pas' {HintBoxWindow},
  VisualClassManager in '..\Class Packer\VisualClassManager.pas',
  ObjectInspectorHandleViewer in 'URLHandlers\ObjectInspectorHandleViewer.pas' {ObjectInspectorHandlerViewer},
  ObjectInspectorHandler in 'URLHandlers\ObjectInspectorHandler.pas',
  SheetHandlerRegistry in 'URLHandlers\SheetHandlerRegistry.pas',
  CacheCommon in '..\Cache\CacheCommon.pas',
  SpecialChars in '..\Cache\SpecialChars.pas',
  IndustryGeneralSheet in 'IndustryGeneralSheet.pas' {IndustryGeneralSheetViewer},
  SupplySheetForm in 'SupplySheetForm.pas' {SupplySheetViewer},
  ObjectInspectorInterfaces in 'URLHandlers\ObjectInspectorInterfaces.pas',
  SheetHandlers in 'SheetHandlers.pas',
  GateInfo in 'GateInfo.pas',
  ProdSheetForm in 'ProdSheetForm.pas' {ProdSheetViewer},
  ResidentialSheet in 'ResidentialSheet.pas' {ResidentialSheetViewer},
  SrvGeneralSheetForm in 'SrvGeneralSheetForm.pas' {ServiceGeneralSheetViewer},
  TownHallSheet in 'TownHallSheet.pas' {PoliticSheetViewer},
  TownParamSheet in 'TownParamSheet.pas' {TownParamSheetViewer},
  CacheBackup in 'Components\MapIsoView\CacheBackup.pas',
  ThreadTimer in '..\Utils\CodeLib\ThreadTimer.pas',
  ImageLoader in 'Components\MapIsoView\ImageLoader.pas',
  Synchro in '..\Utils\Synchro\Synchro.pas',
  CabUtils in '..\Utils\Synchro\CabUtils.pas',
  SyncIndex in '..\Utils\Synchro\SyncIndex.pas',
  UnkFacilitySheet in 'UnkFacilitySheet.pas' {UnknowFacilitySheetViewer},
  PicShopForm in 'PicShopForm.pas' {PictureShopViewer},
  Matrix in '..\Utils\Misc\Matrix.pas',
  MapSprites in 'Components\MapIsoView\MapSprites.pas',
  SoundCache in 'Components\MapIsoView\SoundCache.pas',
  SoundMixer in 'Components\MapIsoView\SoundMixer.pas',
  Sounds in 'Components\MapIsoView\Sounds.pas',
  SoundTypes in 'Components\MapIsoView\SoundTypes.pas',
  LocalCacheManager in 'Components\MapIsoView\LocalCacheManager.pas',
  GlassedBuffers in 'Components\MapIsoView\GlassedBuffers.pas',
  LocalCacheTypes in 'Components\MapIsoView\LocalCacheTypes.pas',
  SoundLib in '..\Utils\SoundLib\SoundLib.pas',
  WaveLow in '..\Utils\SoundLib\WaveLow.pas',
  InventionsSheet in 'InventionsSheet.pas' {InventionsSheetViewer},
  BankGeneralSheet in 'BankGeneralSheet.pas' {BankGeneralSheetViewer},
  WinBtns in 'WinBtns.pas' {WinBtnsView},
  AntennasSheet in 'AntennasSheet.pas' {AntennasSheetViewer},
  TVGeneralSheet in 'TVGeneralSheet.pas' {TVGeneralSheetViewer},
  AdvSheetForm in 'AdvSheetForm.pas' {AdvertismentSheetViewer},
  TownTaxesSheet in 'TownTaxesSheet.pas' {TownTaxesSheetViewer},
  Cover in 'Cover.pas' {CoverForm},
  OptionsHandlerViewer in 'URLHandlers\OptionsHandlerViewer.pas' {OptionsHandlerView},
  OptionsHandler in 'URLHandlers\OptionsHandler.pas',
  Automaton in '..\Actors\Automaton.pas',
  ActorPool in '..\Actors\ActorPool.pas',
  ActorTypes in '..\Actors\ActorTypes.pas',
  DistributedStates in '..\Actors\DistributedStates.pas',
  StateEngine in '..\Actors\StateEngine.pas',
  TransportHandler in 'URLHandlers\TransportHandler.pas',
  Vehicles in 'Vehicles.pas',
  ClassStorageInt in '..\Class Storage\ClassStorageInt.pas',
  StreamToStr in '..\Utils\Misc\StreamToStr.pas',
  voyagertrains in 'URLHandlers\voyagertrains.pas',
  Train in '..\Model Extensions\Trains\Train.pas',
  TrainConst in '..\Model Extensions\Trains\TrainConst.pas',
  ClientTrain in '..\Model Extensions\Trains\ClientTrain.pas',
  Notification in 'Notification.pas',
  URLNotification in 'URLNotification.pas' {URLFrameNotification},
  Roads in 'Components\MapIsoView\Roads.pas',
  Railroads in 'Components\MapIsoView\Railroads.pas',
  WorkforceSheet in 'WorkforceSheet.pas' {WorkforceSheetViewer},
  TownHallJobsSheet in 'TownHallJobsSheet.pas' {TownHallJobsSheetViewer},
  TownHallResSheet in 'TownHallResSheet.pas' {TownHallResSheetViewer},
  JukeBox in 'URLHandlers\JukeBox.pas',
  CompStringsParser in '..\Utils\Misc\CompStringsParser.pas',
  LogFile in '..\RDO\Common\LogFile.pas',
  ManagementSheet in 'ManagementSheet.pas' {ManagementSheetViewer},
  CapitolSheet in 'CapitolSheet.pas' {CapitolSheetViewer},
  MinisteriesSheet in 'MinisteriesSheet.pas' {MinisteriesSheetViewer},
  NewChannelForm in 'URLHandlers\NewChannelForm.pas' {NewChannelFrm},
  PasswordVerifyForm in 'URLHandlers\PasswordVerifyForm.pas' {PasswordVerifyFrm},
  InternetSecurityManager in 'Components\WebBrowser\InternetSecurityManager.pas',
  Mshtmhst in 'Components\WebBrowser\Mshtmhst.pas',
  URLMon2 in 'Components\WebBrowser\URLMon2.pas',
  StarVoice in '..\Utils\Voice\StarVoice\StarVoice.pas',
  CompressIntf in '..\Utils\Voice\Interfaces\CompressIntf.pas',
  FIFOIntf in '..\Utils\Voice\Interfaces\FIFOIntf.pas',
  VoiceTx in '..\Utils\Voice\StarVoice\VoiceTx\VoiceTx.pas',
  WaveIn in '..\Utils\Voice\StarVoice\WaveInOut\WaveIn.pas',
  WaveHdrs in '..\Utils\Voice\StarVoice\WaveInOut\WaveHdrs.pas',
  MMCheck in '..\Utils\Voice\StarVoice\WaveInOut\MMCheck.pas',
  WaveConvert in '..\Utils\Voice\Utils\WaveConvert.pas',
  ACM in '..\Utils\Voice\Utils\ACM.pas',
  DSoundUtils in '..\Utils\Voice\StarVoice\WaveInOut\DSoundUtils.pas',
  VoiceRx in '..\Utils\Voice\StarVoice\VoiceRx\VoiceRx.pas',
  DSoundOut in '..\Utils\Voice\StarVoice\WaveInOut\DSoundOut.pas',
  ExtTimer in '..\Utils\Voice\StarVoice\WaveInOut\ExtTimer.pas',
  FIFOUtils in '..\Utils\Voice\Utils\FIFOUtils.pas',
  FIFO in '..\Utils\Voice\Utils\FIFO.pas',
  CodecIntf in '..\Utils\Voice\Interfaces\CodecIntf.pas',
  VoiceHandler in 'URLHandlers\VoiceHandler.pas',
  VoicePanelViewer in 'URLHandlers\VoicePanelViewer.pas' {VoicePanel},
  CompanyServicesSheetForm in 'CompanyServicesSheetForm.pas' {CompanyInputsSheetViewer},
  TownProdSheet in 'TownProdSheet.pas' {TownProdSheetViewer},
  TimerTicker in '..\Utils\CodeLib\TimerTicker.pas',
  FiveIsometricMap in 'Components\IsometricMap\FiveIsometricMap.pas',
  IsometricMap in 'Components\IsometricMap\IsometricMap.pas',
  IsometricMapTypes in 'Components\IsometricMap\IsometricMapTypes.pas',
  ChatListHandler in 'URLHandlers\ChatListHandler.pas',
  JPGtoBMP in 'Components\JPGtoBMP.pas',
  HistoryDialog in 'HistoryDialog.pas' {HistoryDlg},
  FocusTypes in 'Components\MapIsoView\FocusTypes.pas',
  IsoProfile in 'Components\MapIsoView\IsoProfile.pas',
  CustomWebBrowser in 'Components\WebBrowser\CustomWebBrowser.pas',
  LogonHandlerViewer in 'URLHandlers\LogonHandlerViewer.pas' {LogonHandlerView},
  UniversalMapViewer in 'URLHandlers\UniversalMapViewer.pas' {UniversalMapView},
  ConnectingWindow in 'ConnectingWindow.pas' {ConnectingWin},
  BackgroundHandler in 'URLHandlers\BackgroundHandler.pas',
  BackgroundHandlerViewer in 'URLHandlers\BackgroundHandlerViewer.pas' {BackgroundHandlerView},
  GenIdd in '..\Utils\Serial\GenIdd.pas',
  CapitolTownsSheet in 'CapitolTownsSheet.pas' {CapitolTownsSheetViewer},
  PlotterGrid in 'Components\PlotterGrid.pas' {Plotter},
  ChartSheet in 'ChartSheet.pas' {ChartSheetViewer},
  ChartWindow in 'ChartWindow.pas' {ChartWin},
  GMKernel in '..\GM\GMKernel.pas',
  ChatUtils in 'ChatUtils.pas',
  GMChatViewer in 'URLHandlers\GMChatViewer.pas' {GMChatView},
  GMChatHandler in 'URLHandlers\GMChatHandler.pas',
  ConnectOptionsFrm in '..\Gm\GM Visual\ClientTest\ConnectOptionsFrm.pas' {GMConnOptions},
  GMList in '..\Gm\GM Visual\GMList.pas',
  MessageBox in 'MessageBox.pas' {MsgBoxFrm},
  MP3Player in '..\Utils\MP3Play\MP3Player.pas',
  MP3Reader in '..\Utils\MP3Play\MP3Reader.pas',
  DShow in '..\Utils\DXMedia\DShow.pas',
  Logs in '..\Logs\Logs.pas',
  Literals in 'Literals.pas',
  InternationalizerComponent in 'Components\InternationalizerComponent.pas',
  ClientMLS in 'ClientMLS.pas',
  tabNamesMLS in 'tabNamesMLS.pas',
  SimpleTrainView in 'URLHandlers\SimpleTrainView.pas' {SimpleTrains},
  OutputSearchHandler in 'URLHandlers\OutputSearchHandler.pas',
  OutputSearchHandlerViewer in 'URLHandlers\OutputSearchHandlerViewer.pas' {OutputSearchViewer},
  InputSearchHandler in 'URLHandlers\InputSearchHandler.pas',
  InputSearchHandlerViewer in 'URLHandlers\InputSearchHandlerViewer.pas' {InputSearchViewer},
  Aircraft in 'Components\MapIsoView\Aircraft.pas',
  MausoleumSheet in 'MausoleumSheet.pas' {MausoleumSheetViewer},
  ChangeLog in 'ChangeLog.pas' {ChangeLogView},
  CRC32 in '..\Utils\Serial\CRC32.pas',
  MemMapFile in '..\Utils\Serial\MemMapFile.pas',
  Privacy in 'Privacy.pas',
  ChatRenderer in 'Components\ChatRenderer.pas',
  ChatLogWin in 'ChatLogWin.pas' {ChatLogWindow},
  FilmsSheet in 'FilmsSheet.pas' {FilmsSheetViewer},
  BankLoansSheet in 'BankLoansSheet.pas' {BankLoansSheetViewer},
  VotesSheet in 'VotesSheet.pas' {VotesSheetViewer},
  LowStuff in '..\Utils\SoundLib\LowStuff.pas',
  ExceptHandle in '..\Utils\Debug\ExceptHandle.pas',
  SHDocVw_TLB in 'Components\WebBrowser\SHDocVw_TLB.pas',
  ProxyInit in '..\Utils\Network\ProxyInit.pas',
  Pedestrian in 'Components\MapIsoView\Pedestrian.pas',
  Display in '..\Utils\Graphics\Display.pas',
  DisplayControl in 'DisplayControl.pas',
  CacheAgent in '..\Cache\CacheAgent.pas',
  VCLBackup in '..\Persistence\VCLBackup.pas',
  Collection in '..\Kernel\Collection.pas',
  SmartThreads in '..\Kernel\SmartThreads.pas',
  SmartThreadRegistry in '..\Kernel\SmartThreadRegistry.pas',
  MapCompress in '..\Kernel\MapCompress.pas',
  CoolSB in 'Components\CoolSB.pas',
  FavView in 'FavView.pas' {FavViewer},
  MoveFav in 'MoveFav.pas' {MoveFavDlg},
  WHGeneralSheet in 'WHGeneralSheet.pas' {WHGeneralSheetViewer},
  HqMainSheet in 'HqMainSheet.pas' {HqSheetViewer},
  topinfobar in 'URLHandlers\topinfobar.pas' {tib},
  CrimeHandler in 'URLHandlers\CrimeHandler.pas',
  CrimeMainViewer in 'URLHandlers\CrimeMainViewer.pas' {CrimeMainView},
  CrimeTrainingDialog in 'URLHandlers\CrimeTrainingDialog.pas' {CrimeTrainingDlg},
  CriminalRosterViewer in 'URLHandlers\CriminalRosterViewer.pas' {CriminalRosterView},
  CriminalViewer in 'URLHandlers\CriminalViewer.pas' {CriminalView},
  MissionViewer in 'URLHandlers\MissionViewer.pas' {MisionView},
  NewTeamDialog in 'URLHandlers\NewTeamDialog.pas' {NewTeamDlg},
  music1 in 'music1.pas' {Form2},
  worldlogon in 'URLHandlers\worldlogon.pas' {wlog},
  worldlogonhandler in 'URLHandlers\worldlogonhandler.pas',
  buildhandler in 'URLHandlers\buildhandler.pas',
  builder in 'URLHandlers\builder.pas' {builder},
  tycoonhandler in 'URLHandlers\tycoonhandler.pas',
  tycoonviewer in 'URLHandlers\tycoonviewer.pas' {tycoonview},
  tycoonshowhandler in 'URLHandlers\tycoonshowhandler.pas',
  tycoonshow in 'URLHandlers\tycoonshow.pas' {tycoonshower},
  classload in 'classload.pas',
  loans in 'URLHandlers\frames\loans.pas' {Frame2: TFrame},
  blisttest2 in 'URLHandlers\frames\blisttest2.pas' {Frame1: TFrame},
  searchviewhandler in 'URLHandlers\searchviewhandler.pas',
  searchview in 'URLHandlers\searchview.pas' {searchviewf},
  towns in 'URLHandlers\frames\towns.pas' {Frame3: TFrame},
  cefvcl in '..\dcef\src\cefvcl.pas',
  cefgui in '..\dcef\src\cefgui.pas',
  ceflib in '..\dcef\src\ceflib.pas',
  CrimeProtocol in '..\Illegal\Illegal Kernel\CrimeProtocol.pas',
  BankRobbery in '..\Illegal\Illegal Kernel\BankRobbery.pas',
  Creator in '..\Illegal\Illegal Kernel\Creator.pas',
  GamblingDen in '..\Illegal\Illegal Kernel\GamblingDen.pas',
  IllegalKernel in '..\Illegal\Illegal Kernel\IllegalKernel.pas',
  MetaCrime in '..\Illegal\Illegal Kernel\MetaCrime.pas',
  RoadDestroy in '..\Illegal\Illegal Kernel\RoadDestroy.pas',
  ModelServerCache in '..\Cache\ModelServerCache.pas',
  Surfaces in '..\Surfaces\Surfaces.pas',
  MailServerInterfaces in '..\Mail\MailServerInterfaces.pas',
  TransportInterfaces in '..\Transport\TransportInterfaces.pas',
  RankProtocol in '..\Protocol\RankProtocol.pas',
  Inventions in '..\Inventions\Inventions.pas',
  Tasks in '..\Tasks\Tasks.pas',
  FacIds in '..\Model Extensions\FacIds.pas',
  Tutorial in '..\Tasks\Tutorial.pas',
  BackupObjects in '..\Persistence\BackupObjects.pas',
  BackupConsts in '..\Persistence\BackupConsts.pas',
  BlockLevels in '..\Persistence\BlockLevels.pas',
  ManuallyConnectTask in '..\Tasks\ManuallyConnectTask.pas';

// ,
  //wlogon in 'URLHandlers\wlogon.pas' {twlogon}   

{$R *.RES}
begin
  {$IFDEF LOGS}
  LogFile.SetLogFile(ParamStr(0) + '.log');
  {$ENDIF}
  Application.Initialize;
  Application.Title := 'Starpeace - Rise of the Tycoons';
  Application.CreateForm(TVoyagerWin, VoyagerWin);
  Application.CreateForm(THintBoxWindow, HintBoxWindow);
  Application.CreateForm(TURLFrameNotification, URLFrameNotification);
  Application.CreateForm(TNewChannelFrm, NewChannelFrm);
  Application.CreateForm(TPasswordVerifyFrm, PasswordVerifyFrm);
  Application.CreateForm(TVoicePanel, VoicePanel);
  Application.CreateForm(TConnectingWin, ConnectingWin);
  Application.CreateForm(THistoryDlg, HistoryDlg);
  Application.CreateForm(TChartWin, ChartWin);
  Application.CreateForm(TChangeLogView, ChangeLogView);
  Application.CreateForm(TChatLogWindow, ChatLogWindow);
  Application.CreateForm(TVotesSheetViewer, VotesSheetViewer);
  Application.CreateForm(TMoveFavDlg, MoveFavDlg);
  Application.CreateForm(THqSheetViewer, HqSheetViewer);
  Application.CreateForm(Ttib, tib);
  Application.CreateForm(TCrimeTrainingDlg, CrimeTrainingDlg);
  Application.CreateForm(TCriminalRosterView, CriminalRosterView);
  Application.CreateForm(TCriminalView, CriminalView);
  Application.CreateForm(TMisionView, MisionView);
  Application.CreateForm(TNewTeamDlg, NewTeamDlg);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tsearchviewf, searchviewf);
  //Application.CreateForm(Ttycoonshower, tycoonshower);
  // Application.CreateForm(Ttycoonview, tycoonview);
  //Application.CreateForm(TForm3, Form3);
  //Application.CreateForm(Twlog, wlog);
  //Application.CreateForm(Ttwlogon, twlogon);
         // Application.CreateForm(Tworldlogon, wlog);
  Application.HintHidePause := 10000*10;
  Application.Run;
  DisplayControl.DoneDisplay;
end.
