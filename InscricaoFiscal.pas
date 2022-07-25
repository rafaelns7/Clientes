unit InscricaoFiscal;

interface
 uses
   System.Math,  System.SysUtils;
type

  TInscricaoFiscal = class abstract(TObject)
  public
    function CPFDocumentoValido(const pDocumento: string): Boolean;
    function CNPJDocumentoValido(const pDocumento: string): Boolean;
  end;

implementation

function TInscricaoFiscal.CNPJDocumentoValido(
  const pDocumento: string): Boolean;
var
  dig13, dig14: string;
  sm, i, r, peso: integer;
begin

  if ((pDocumento = '00000000000000') or (pDocumento = '11111111111111') or
    (pDocumento = '22222222222222') or (pDocumento = '33333333333333') or
    (pDocumento = '44444444444444') or (pDocumento = '55555555555555') or
    (pDocumento = '66666666666666') or (pDocumento = '77777777777777') or
    (pDocumento = '88888888888888') or (pDocumento = '99999999999999') or
    (length(pDocumento) <> 14)) then
  begin
    Result := false;
    exit;
  end;

  try
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
      sm := sm + (StrToInt(pDocumento[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;

    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig13 := '0'
    else str((11-r):1, dig13);

    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(pDocumento[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig14 := '0'
    else str((11-r):1, dig14);

    if ((dig13 = pDocumento[13]) and (dig14 = pDocumento[14]))then
      Result := true
    else
      Result := false;
  except
    Result := false
  end;

end;

function TInscricaoFiscal.CPFDocumentoValido(const pDocumento: string): Boolean;
var
  lv: array [0 .. 1] of Word;
  lCpf: array [0 .. 10] of Byte;
  I: Byte;
begin
  Result:= False;
  if Length(pDocumento) <> 11 then begin
    exit;
  end;

  if (pDocumento = StringOfChar('0', 11)) or (pDocumento = StringOfChar('1', 11)) or
     (pDocumento = StringOfChar('2', 11)) or (pDocumento = StringOfChar('3', 11)) or
     (pDocumento = StringOfChar('4', 11)) or (pDocumento = StringOfChar('5', 11)) or
     (pDocumento = StringOfChar('6', 11)) or (pDocumento = StringOfChar('7', 11)) or
     (pDocumento = StringOfChar('8', 11)) or (pDocumento = StringOfChar('9', 11)) then
  begin
    Result:= False;
    Exit;
  end;

  try
    for I := 1 to 11 do
      lCpf[I - 1] := StrToInt(pDocumento[I]);

    lv[0] := 10 * lCpf[0] + 9 * lCpf[1] + 8 * lCpf[2];
    lv[0] := lv[0] + 7 * lCpf[3] + 6 * lCpf[4] + 5 * lCpf[5];
    lv[0] := lv[0] + 4 * lCpf[6] + 3 * lCpf[7] + 2 * lCpf[8];
    lv[0] := 11 - lv[0] mod 11;
    lv[0] := IfThen(lv[0] >= 10, 0, lv[0]);

    lv[1] := 11 * lCpf[0] + 10 * lCpf[1] + 9 * lCpf[2];
    lv[1] := lv[1] + 8 * lCpf[3] + 7 * lCpf[4] + 6 * lCpf[5];
    lv[1] := lv[1] + 5 * lCpf[6] + 4 * lCpf[7] + 3 * lCpf[8];
    lv[1] := lv[1] + 2 * lv[0];
    lv[1] := 11 - lv[1] mod 11;
    lv[1] := IfThen(lv[1] >= 10, 0, lv[1]);

    Result := ((lv[0] = lCpf[9]) and (lv[1] = lCpf[10]));
  except
    on E: Exception do
      Result := False;
  end;
end;

end.
