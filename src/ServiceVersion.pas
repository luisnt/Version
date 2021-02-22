unit ServiceVersion;

interface

uses ServiceVersion.Interfaces;

type
  TVersion = class(TInterfacedObject, iVersion)
    class function New: iVersion;
    constructor Create;
    destructor Destroy; override;
  strict private
    FFilename   : string;
    FMaintenance: integer;
    FMinor      : integer;
    FMajor      : integer;
    FBuild      : integer;
    function getValue: string;
    function getBuild: integer;
    function getMaintenance: integer;
    function getMajor: integer;
    function getMinor: integer;
    procedure setValue(const aValue: string);
    procedure setBuild(const Value: integer);
    procedure setMaintenance(const Value: integer);
    procedure setMajor(const Value: integer);
    procedure setMinor(const Value: integer);
    function getFilename: string;
    procedure setFilename(const aValue: string);
  public
    { public }
    property Filename   : string read getFilename write setFilename;                  // Formato da Versão ex: 2.4.3.7 separado em array [0]=2, [1]=4, [2]=3, [3]=7
    property Major      : integer read getMajor write setMajor default 0;             // [0]=2  Versão principal       = Mudança do programa   ( Reengenharia                   )
    property Minor      : integer read getMinor write setMinor default 0;             // [1]=4  Versão menor           = Mudança de Formulário ( Adição/Remoção                 )
    property Maintenance: integer read getMaintenance write setMaintenance default 0; // [2]=3  Lançamento/Atualização = Mudança de Componente ( Adição/Remoção                 )
    property Build      : integer read getBuild write setBuild default 0;             // [3]=7  Construção             = Correção              ( Adequações das funcionalidades )
    property Value      : string read getValue write setValue;
  end;

function Version: iVersion;

function VersionFile(const aFilename: string): string;
function isOutdated(const aNewVersion: string): boolean; overload;
function isOutdated(const aNewVersion: string; aOldVersion: string): boolean; overload;
function isOutdatedFile(const aNewFilename: string): boolean; overload;
function isOutdatedFile(const aNewFilename: string; aOldFileName: string): boolean; overload;

implementation

uses
  Winapi.Windows, System.SysUtils, System.Classes;

function Version: iVersion;
begin
  Result := TVersion.New;
end;

function VersionFile(const aFilename: string): string;
begin
  with Version do
    begin
      Filename := aFilename;
      Result := Value;
    end;
end;

function isOutdated(const aNewVersion: string): boolean;
var
  LMajor          : boolean;
  LMinor          : boolean;
  LMaintenance    : boolean;
  LBuild          : boolean;
  LNewVersion     : TVersion;
  LInstaledVersion: TVersion;
begin
  LNewVersion               := TVersion.Create();
  LNewVersion.Value         := aNewVersion;
  LInstaledVersion          := TVersion.Create();
  LInstaledVersion.Filename := ParamStr(0);
  try
    with LInstaledVersion do
    begin
      LMajor       := (Major < LNewVersion.Major);
      LMinor       := ((Major = LNewVersion.Major) and (Minor < LNewVersion.Minor));
      LMaintenance := ((Minor = LNewVersion.Minor) and (Maintenance < LNewVersion.Maintenance));
      LBuild       := ((Maintenance = LNewVersion.Maintenance) and (Build < LNewVersion.Build));
    end;
    Result := (LMajor or LMinor or LMaintenance or LBuild);
  finally
    LNewVersion.free;
    LInstaledVersion.free;
  end;
end;

function isOutdated(const aNewVersion: string; aOldVersion: string): boolean;
var
  LMajor          : boolean;
  LMinor          : boolean;
  LMaintenance    : boolean;
  LBuild          : boolean;
  LNewVersion     : TVersion;
  LInstaledVersion: TVersion;
begin
  LInstaledVersion := TVersion.Create();
  LNewVersion      := TVersion.Create();
  try
    LNewVersion.Value := aNewVersion;
    with LInstaledVersion do
    begin
      Value        := aOldVersion;
      LMajor       := (Major < LNewVersion.Major);
      LMinor       := ((Major = LNewVersion.Major) and (Minor < LNewVersion.Minor));
      LMaintenance := ((Minor = LNewVersion.Minor) and (Maintenance < LNewVersion.Maintenance));
      LBuild       := ((Maintenance = LNewVersion.Maintenance) and (Build < LNewVersion.Build));
    end;
    Result := (LMajor or LMinor or LMaintenance or LBuild);
  finally
    LNewVersion.free;
    LInstaledVersion.free;
  end;
end;

function isOutdatedFile(const aNewFilename: string): boolean;
var
  LMajor          : boolean;
  LMinor          : boolean;
  LMaintenance    : boolean;
  LBuild          : boolean;
  LNewVersion     : TVersion;
  LInstaledVersion: TVersion;
begin
  LInstaledVersion     := TVersion.Create();
  LNewVersion          := TVersion.Create();
  LNewVersion.Filename := aNewFilename;
  try
    with LInstaledVersion do
    begin
      Filename     := ParamStr(0);
      LMajor       := (Major < LNewVersion.Major);
      LMinor       := ((Major = LNewVersion.Major) and (Minor < LNewVersion.Minor));
      LMaintenance := ((Minor = LNewVersion.Minor) and (Maintenance < LNewVersion.Maintenance));
      LBuild       := ((Maintenance = LNewVersion.Maintenance) and (Build < LNewVersion.Build));
    end;
    Result := (LMajor or LMinor or LMaintenance or LBuild);
  finally
    LNewVersion.free;
    LInstaledVersion.free;
  end;
end;

function isOutdatedFile(const aNewFilename: string; aOldFileName: string): boolean;
var
  LMajor          : boolean;
  LMinor          : boolean;
  LMaintenance    : boolean;
  LBuild          : boolean;
  LNewVersion     : TVersion;
  LInstaledVersion: TVersion;
begin
  LInstaledVersion     := TVersion.Create();
  LNewVersion          := TVersion.Create();
  LNewVersion.Filename := aNewFilename;
  try
    with LInstaledVersion do
    begin
      Filename     := aOldFileName;
      LMajor       := (Major < LNewVersion.Major);
      LMinor       := ((Major = LNewVersion.Major) and (Minor < LNewVersion.Minor));
      LMaintenance := ((Minor = LNewVersion.Minor) and (Maintenance < LNewVersion.Maintenance));
      LBuild       := ((Maintenance = LNewVersion.Maintenance) and (Build < LNewVersion.Build));
    end;
    Result := (LMajor or LMinor or LMaintenance or LBuild);
  finally
    LNewVersion.free;
    LInstaledVersion.free;
  end;
end;

{ TVersion }

class function TVersion.New: iVersion;
begin
  Result := Self.Create;
end;

constructor TVersion.Create;
begin
  Filename := ParamStr(0);
end;

destructor TVersion.Destroy;
begin

  inherited;
end;

{ TVersion }

function TVersion.getBuild: integer;
begin
  Result := FBuild;
end;

function TVersion.getFilename: string;
begin
  Result := FFilename;
end;

function TVersion.getMaintenance: integer;
begin
  Result := FMaintenance;
end;

function TVersion.getMajor: integer;
begin
  Result := FMajor;
end;

function TVersion.getMinor: integer;
begin
  Result := FMinor;
end;

function TVersion.getValue: string;
begin
  Result := Format('%d.%d.%d.%d', [FMajor, FMinor, FMaintenance, FBuild]);
end;

procedure TVersion.setValue(const aValue: string);
const
  DOT              = '.';
  MAJOR_PART       = 0;
  MINOR_PART       = 1;
  MAINTENANCE_PART = 2;
  BUILD_PART       = 3;
begin
  with TStringList.Create do
    try
      Clear;
      Delimiter     := DOT;
      DelimitedText := aValue;
      FMajor        := Strings[MAJOR_PART].ToInteger;
      FMinor        := Strings[MINOR_PART].ToInteger;
      FMaintenance  := Strings[MAINTENANCE_PART].ToInteger;
      FBuild        := Strings[BUILD_PART].ToInteger;
    finally
      free;
    end;
end;

procedure TVersion.setBuild(const Value: integer);
begin
  FBuild := Value;
end;

procedure TVersion.setFilename(const aValue: string);
type
  PFFI = ^vs_FixedFileInfo;
var
  F           : PFFI;
  Handle      : Dword;
  Len         : Longint;
  Data        : PChar;
  Buffer      : Pointer;
  Tamanho     : Dword;
  LStrFilename: string;
  LFilename   : PChar;
begin
  FMajor       := 0;
  FMinor       := 0;
  FMaintenance := 0;
  FBuild       := 0;
  if FileExists(aValue) then
    LStrFilename := aValue
  else
    LStrFilename := ParamStr(0);

  LFilename := StrAlloc(Length(LStrFilename) + 1);
  StrPcopy(LFilename, LStrFilename);
  Len := GetFileVersionInfoSize(LFilename, Handle);
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(LFilename, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '\', Buffer, Tamanho);
      F            := PFFI(Buffer);
      FMajor       := HiWord(F^.dwFileVersionMs);
      FMinor       := LoWord(F^.dwFileVersionMs);
      FMaintenance := HiWord(F^.dwFileVersionLs);
      FBuild       := LoWord(F^.dwFileVersionLs);
    end;
    StrDispose(Data);
  end;
  StrDispose(LFilename);
end;

procedure TVersion.setMaintenance(const Value: integer);
begin
  FMaintenance := Value;
end;

procedure TVersion.setMajor(const Value: integer);
begin
  FMajor := Value;
end;

procedure TVersion.setMinor(const Value: integer);
begin
  FMinor := Value;
end;

end.
