unit MainFrm;

{$WARN UNIT_PLATFORM OFF}

interface
uses
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  Forms,
  Mask,
  StdCtrls,
  XMLDOM,
  XMLIntf,

  cxButtonEdit,
  cxContainer,
  cxControls,
  cxEdit,
  cxLookAndFeels,
  cxMaskEdit,
  cxTextEdit,

  DataBindingHintsXML,
  XMLDataBindingGenerator;


type
  TMainForm = class(TForm)
    btnClose:                                   TButton;
    btnGenerate:                                TButton;
    DefaultEditStyle:                           TcxDefaultEditStyleController;
    deFolder:                                   TcxButtonEdit;
    dlgOutputFile:                              TSaveDialog;
    dlgSchema:                                  TOpenDialog;
    edtFolderPostfix:                           TcxTextEdit;
    edtFolderPrefix:                            TcxTextEdit;
    feFile:                                     TcxButtonEdit;
    feSchema:                                   TcxButtonEdit;
    gbOutput:                                   TGroupBox;
    lblFile:                                    TLabel;
    lblFolder:                                  TLabel;
    lblFolderPostfix:                           TLabel;
    lblFolderPrefix:                            TLabel;
    lblSchema:                                  TLabel;
    LookAndFeel:                                TcxLookAndFeelController;
    plOutput:                                   TPageControl;
    rbFile:                                     TRadioButton;
    rbFolder:                                   TRadioButton;
    spFile:                                     TTabSheet;
    spFolder:                                   TTabSheet;

    procedure btnCloseClick(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OutputTypeClick(Sender: TObject);
    procedure feFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure deFolderPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure feSchemaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure feSchemaPropertiesChange(Sender: TObject);
  private
    FHints: IXMLDataBindingHints;
    FHintsXPath: IDOMNodeSelect;

    procedure PostProcessItem(Sender: TObject; Item: TXMLDataBindingItem);
    procedure GetFileName(Sender: TObject; const SchemaName: String; var Path, FileName: String);

    function GetSettingsFileName(const AFileName: String): String;
    procedure LoadSettings(const AFileName: String);
    procedure SaveSettings(const AFileName: String);
  end;


implementation
uses
  FileCtrl,
  SysUtils,
  Windows,

  X2UtNamedFormat,
  X2UtTempFile,

  DataBindingSettingsXML,
  DelphiXMLDataBindingGenerator;


const
  XPathHintEnumerationMember  = '//Enumerations' +
                                '/Enumeration[@Name=''%<Enumeration>:s'']' +
                                '/Member[@Name=''%<Member>:s'']/text()';


{$R *.dfm}


{ TMainForm }
procedure TMainForm.FormCreate(Sender: TObject);
var
  schemaFile:   String;

begin
  plOutput.ActivePageIndex := 0;

  if ParamCount() > 0 then
  begin
    schemaFile  := ParamStr(1);

    if FileExists(schemaFile) then
    begin
      feFile.Text     := ChangeFileExt(schemaFile, '.pas');
      deFolder.Text   := ExtractFilePath(schemaFile);

      { Set schema last, the Change event will attempt to load the
        settings file and overwrite the file / folder. }
      feSchema.Text   := schemaFile;
    end;
  end;
end;


procedure TMainForm.OutputTypeClick(Sender: TObject);
begin
  if Sender = rbFile then
    plOutput.ActivePage := spFile
  else if Sender = rbFolder then
    plOutput.ActivePage := spFolder;
end;


procedure TMainForm.btnGenerateClick(Sender: TObject);
var
  hintsFile:  String;

begin
  if not FileExists(feSchema.Text) then
  begin
    MessageBox(Self.Handle, 'Please specify a valid schema file.',
               'Schema file does not exist', MB_OK or MB_ICONERROR);

    ActiveControl := feFile;
    Exit;
  end;

  hintsFile := ChangeFileExt(feSchema.Text, '.hints.xml');
  if FileExists(hintsFile) then
  begin
    FHints      := LoadDataBindingHints(hintsFile);
    FHintsXPath := (FHints.OwnerDocument.DocumentElement.DOMNode as IDOMNodeSelect);
  end;

  try
    with TDelphiXMLDataBindingGenerator.Create() do
    try
      if rbFile.Checked then
      begin
        OutputType  := otSingle;
        OutputPath  := feFile.Text;
      end else if rbFolder.Checked then
      begin
        OutputType  := otMultiple;
        OutputPath  := deFolder.Text;
      end;

      OnPostProcessItem := PostProcessItem;
      OnGetFileName := GetFileName;
      Execute(feSchema.Text);

      SaveSettings(feSchema.Text);

      ShowMessage('The data binding has been generated.');
    finally
      Free();
    end;
  finally
    FHints      := nil;
    FHintsXPath := nil;
  end;
end;


procedure TMainForm.btnCloseClick(Sender: TObject);
begin
  Close();
end;


procedure TMainForm.PostProcessItem(Sender: TObject; Item: TXMLDataBindingItem);
var
  member: TXMLDataBindingEnumerationMember;
  hint: IDOMNode;

begin
  if not Assigned(FHintsXPath) then
    Exit;

  if Item.ItemType = itEnumerationMember then
  begin
    { Check if a hint for a new name is available }
    member  := TXMLDataBindingEnumerationMember(Item);
    hint    := FHintsXPath.selectNode(NamedFormat(XPathHintEnumerationMember,
                                                  ['Enumeration',  member.Enumeration.Name,
                                                   'Member',       member.Name]));

    if Assigned(hint) and (Length(hint.nodeValue) > 0) then
      Item.TranslatedName := hint.nodeValue;
  end;
end;


procedure TMainForm.GetFileName(Sender: TObject; const SchemaName: String; var Path, FileName: String);
begin
  FileName  := ChangeFileExt(edtFolderPrefix.Text + FileName,
                             edtFolderPostfix.Text + ExtractFileExt(FileName));
  CheckValidFileName(FileName);
end;


procedure TMainForm.feFilePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if dlgOutputFile.Execute() then
    feFile.Text := dlgOutputFile.FileName;
end;


procedure TMainForm.deFolderPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  directory:  String;

begin
  if SelectDirectory('Select output folder', '', directory) then
    deFolder.Text := directory;
end;


procedure TMainForm.feSchemaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if dlgSchema.Execute() then
    feSchema.Text := dlgSchema.FileName;
end;


procedure TMainForm.feSchemaPropertiesChange(Sender: TObject);
begin
  if FileExists(feSchema.Text) then
    LoadSettings(feSchema.Text);
end;


function TMainForm.GetSettingsFileName(const AFileName: String): String;
begin
  Result := ChangeFileExt(AFileName, '.settings.xml');
end;


procedure TMainForm.LoadSettings(const AFileName: String);
var
  fileName:       String;
  settings:       IXMLDataBindingSettings;
  outputSingle:   IXMLOutputSingle;
  outputMultiple: IXMLOutputMultiple;

begin
  fileName  := GetSettingsFileName(AFileName);
  if FileExists(fileName) then
  begin
    settings  := LoadDataBindingSettings(fileName);

    if settings.HasOutput then
    begin
      case settings.Output.OutputType of
        OutputType_Single:
          begin
            outputSingle    := settings.Output.OutputSingle;
            rbFile.Checked  := True;
            feFile.Text     := outputSingle.FileName;
          end;

        OutputType_Multiple:
          begin
            outputMultiple        := settings.Output.OutputMultiple;
            rbFolder.Checked      := True;
            deFolder.Text         := outputMultiple.Path;
            edtFolderPrefix.Text  := outputMultiple.Prefix;
            edtFolderPostfix.Text := outputMultiple.Postfix;
          end;
      end;
    end;
  end;
end;


procedure TMainForm.SaveSettings(const AFileName: String);
var
  fileName:       String;
  settings:       IXMLDataBindingSettings;
  outputSingle:   IXMLOutputSingle;
  outputMultiple: IXMLOutputMultiple;

begin
  fileName  := GetSettingsFileName(AFileName);
  if FileExists(fileName) then
    settings  := LoadDataBindingSettings(fileName)
  else
    settings  := NewDataBindingSettings();

  settings.Output.ChildNodes.Clear;

  if rbFile.Checked then
  begin
    settings.Output.OutputType  := OutputType_Single;
    outputSingle                := settings.Output.OutputSingle;
    outputSingle.FileName       := feFile.Text;
  end else
  begin
    settings.Output.OutputType  := OutputType_Multiple;
    outputMultiple              := settings.Output.OutputMultiple;
    outputMultiple.Path         := deFolder.Text;
    outputMultiple.Prefix       := edtFolderPrefix.Text;
    outputMultiple.Postfix      := edtFolderPostfix.Text;
  end;

  settings.OwnerDocument.SaveToFile(fileName);
end;

end.


