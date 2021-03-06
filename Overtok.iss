; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Overtok"
#define MyAppVersion "1.0"
#define MyAppPublisher "WitherTech"
#define MyAppURL "http://www.withertech.com/"
#define MyAppExeName "overtok.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F2C4EB3B-9DB8-4FC4-A083-67C3D50AC96C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=C:\Users\Aaron\Documents\Overtok\target
OutputBaseFilename=OvertokSetup
Compression=lzma
SolidCompression=yes
DisableWelcomePage=False

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Aaron\Documents\Overtok\target\overtok.exe"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "{tmp}\overtok.ini"; DestDir: "{app}"; DestName: "overtok.ini"; Flags: external

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
var
  ApiKeyPage: TInputQueryWizardPage;

function ApiKey(): string;
begin
  Result := ApiKeyPage.Values[0];
end;

procedure OpenBrowser(Url: string);
var
  ErrorCode: Integer;
begin
  ShellExec('open', Url, '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure LinkClick(Sender: TObject);
begin
  OpenBrowser('https://rapidapi.com/logicbuilder/api/tiktok/pricing');
end;

procedure PrepareIniFileForCopy(section, key, value, iniFileTemp, iniFileTarget:String);
begin
    if FileExists(iniFileTarget) then 
      FileCopy(iniFileTarget, iniFileTemp, False);

    SetIniString(section, key, value,  iniFileTemp);
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  iniFile, iniFileTemp:String;
begin
  if CurStep=ssInstall then begin
    PrepareIniFileForCopy('Keys', 'ApiKey', ApiKey(), ExpandConstant('{tmp}\overtok.ini'), ExpandConstant('{app}\overtok.ini'));

  end;
end;

procedure InitializeWizard();
var
  Link: TLabel;
begin
  ApiKeyPage :=
    CreateInputQueryPage(wpWelcome,
    'Tik Tok Api Key',
    '',
    'Please Enter Your Tik Tok Api Key That Can Be Purchased At: ');
  Link := TLabel.Create(WizardForm);
  Link.Parent := ApiKeyPage.Surface;
  Link.Left := 0
  Link.Top := 11
  Link.Caption := 'https://rapidapi.com/logicbuilder/api/tiktok/pricing';
  Link.OnClick := @LinkClick;
  Link.ParentFont := True;
  Link.Font.Style := Link.Font.Style + [fsUnderline, fsBold];
  Link.Font.Color := clBlue;
  Link.Cursor := crHand;
  ApiKeyPage.Add('Tik Tok Api Key:', true);
end;
