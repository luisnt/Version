## Version Service
>#### Version - Service to read version data of App

### Install
> Boss install luisnt/Version

#### Sample use
```delphi
 
uses
  System.SysUtils,
  ServiceVersion in '..\src\ServiceVersion.pas';

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

```

````code
Read from ParamStr(0)
          Filename: C:\Users\Luis\Projects\Boss\Version\sample\Win32\Release\VersionTest.exe
           Version: 1.0.7723.35592

          Filename: VersionTestNew.exe
           Version: 1.0.7723.33289

          Filename: VersionTestOld.exe
           Version: 1.0.7723.33213

Check isOutdated(New, Old)
               NEW: 1.0.7723.33289
               OLD: 1.0.7723.33213
            Result: True

Check isOutdated(VersionTestNew.exe, VersionTestOld.exe)
VersionTestNew.exe: 1.0.7723.33289
VersionTestOld.exe: 1.0.7723.33213
            Result: True

INVERTER TEST

Check isOutdated(Old, New)
               OLD: 1.0.7723.33213
               NEW: 1.0.7723.33289
            Result: False

Check isOutdated(VersionTestOld.exe, VersionTestNew.exe)
VersionTestOld.exe: 1.0.7723.33213
VersionTestNew.exe: 1.0.7723.33289
            Result: False
````