program VersionTest;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils,
  ServiceVersion in '..\src\ServiceVersion.pas';

const
  NEW_VER = '1.0.2.50';
  INS_VER = '1.0.1.100';

var
  LNew: string;
  LOld: string;

begin
  try
    ReportMemoryLeaksOnShutdown := true;
    WriteLn('Read from ParamStr(0)');
    WriteLn('          Filename: ', ParamStr(0));
    WriteLn('           Version: ', ServiceVersion.version.value);
    WriteLn('');
    LNew := VersionFile('.\VersionTestNew.exe');
    WriteLn('          Filename: VersionTestNew.exe');
    WriteLn('           Version: ', LNew);
    WriteLn('');
    LOld := VersionFile('.\VersionTestOld.exe');
    WriteLn('          Filename: VersionTestOld.exe');
    WriteLn('           Version: ', LOld);
    WriteLn('');
    WriteLn('Check isOutdated(New, Old)');
    WriteLn('               NEW: ' + LNew);
    WriteLn('               OLD: ' + LOld);
    WriteLn('            Result: ', BooltoStr(ServiceVersion.isOutdated(LNew, LOld), true));
    WriteLn('');
    WriteLn('Check isOutdated(VersionTestNew.exe, VersionTestOld.exe)');
    WriteLn('VersionTestNew.exe: ' + LNew);
    WriteLn('VersionTestOld.exe: ' + LOld);
    WriteLn('            Result: ', BooltoStr(ServiceVersion.isOutdatedFile('.\VersionTestNew.exe', '.\VersionTestOld.exe'), true));
    WriteLn('');
    WriteLn('INVERTER TEST');
    WriteLn('');
    WriteLn('Check isOutdated(Old, New)');
    WriteLn('               OLD: ' + LOld);
    WriteLn('               NEW: ' + LNew);
    WriteLn('            Result: ', BooltoStr(ServiceVersion.isOutdated(LOld, LNew), true));
    WriteLn('');
    WriteLn('Check isOutdated(VersionTestOld.exe, VersionTestNew.exe)');
    WriteLn('VersionTestOld.exe: ' + LOld);
    WriteLn('VersionTestNew.exe: ' + LNew);
    WriteLn('            Result: ', BooltoStr(ServiceVersion.isOutdatedFile('.\VersionTestOld.exe', '.\VersionTestNew.exe'), true));

    readln;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
