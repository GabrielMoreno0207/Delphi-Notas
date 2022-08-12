unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  System.Notification;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Button2: TButton;
    Button1: TButton;
    edNota2: TEdit;
    edNota1: TEdit;
    edAluno: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NotificationCenter1: TNotificationCenter;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure edNota1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure edNota2KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  arq: TextFile;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin

  if ((edAluno.Text <> '') and (edNota1.Text <> '') and (edNota2.Text <> ''))
  then
  begin

    Writeln(arq, edAluno.Text, '|', edNota1.Text, '|', edNota2.Text, '|');
    edAluno.Clear;
    edNota1.Clear;
    edNota2.Clear;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);

var
  linha, nome: string;
  nreg, i: integer;
  nota1, nota2, media: real;

begin

  Memo1.Clear;

  Reset(arq);

  nreg := 0;
  while (not Eof(arq)) do

  begin
    Readln(arq, linha);

    nreg := nreg + 1;

    i := pos('|', linha);
    nome := copy(linha, 1, i - 1);
    delete(linha, 1, i);

    i := pos('|', linha);
    nota1 := StrToFloat(copy(linha, 1, i - 1));
    delete(linha, 1, i);

    i := pos('|', linha);
    nota2 := StrToFloat(copy(linha, 1, i - 1));

    media := (nota1 + nota2) / 2;

    Memo1.Lines.Add('Matéria......: ' + nome);
    Memo1.Lines.Add('1a. nota.....: ' + FloatToStr(nota1));
    Memo1.Lines.Add('2a. nota.....: ' + FloatToStr(nota2));
    Memo1.Lines.Add('Média........: ' + FloatToStr(media));

    if (media >= 7.0) then
      Memo1.Lines.Add('Situação.....: Aprovado')
    else
      Memo1.Lines.Add('Situação.....: Realizar Sub');

    Memo1.Lines.Add('');
  end;

  CloseFile(arq);
  Append(arq);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Rewrite(arq);

end;

procedure TForm2.edNota1KeyPress(Sender: TObject; var Key: Char);
begin

  if (Key in ['.', ',']) then
    if (pos(',', (Sender as TEdit).Text) = 0) then
      Key := ','
    else
      Key := #7
  else if (not(Key in ['0' .. '9', #8])) then
    Key := #7;

end;

procedure TForm2.edNota2KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['.', ',']) then
    if (pos(',', (Sender as TEdit).Text) = 0) then
      Key := ','
    else
      Key := #7
  else if (not(Key in ['0' .. '9', #8])) then
    Key := #7;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  AssignFile(arq, 'c:\Notas.txt');
{$I-}
  Reset(arq);
{$I+}
  if (IOResult <> 0) then
    Rewrite(arq)
  else
  begin
    CloseFile(arq);
    Append(arq);
  end;
end;

end.
