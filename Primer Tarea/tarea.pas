Const centinela_Max = 1000;
Const centinela_min = 0;

{  Creado por Juan Appoloni
// ? Procedure:
//*****      generardor_arr: Genera la lista arrNumOrd una vez introducido el numero 'n' (semilla).
// ? Funciones:
//*****    generadora: Retorna la imagen de la función -f(n) = a - b -.
//*****    longitud: Retorna la longitud de la secuencia que se produce mediante la aplicación de la función generadora (incluye ref. a fun. generadora).

$ bash test.sh; fpc -Co -Cr -Miso -gl principal.pas;
}

Var
{  // ! Array de Numeros Ordenados [a,b,c] con a>= b >= c  }
  arrNumOrd : array [1..3] Of integer;

Procedure generardor_arr (n : Integer);
Var
  numeroaux, i, j : Integer;
Begin
  arrNumOrd[1] := n Div 100;
  arrNumOrd[2] := (n-arrNumOrd[1]*100) Div 10;
  arrNumOrd[3] := (n-(arrNumOrd[1]*100+arrNumOrd[2]*10));
  For i := 1 To 2 Do
    Begin
      For j := 1 To 2 Do
        Begin
          If (arrNumOrd[j]<arrNumOrd[j+1]) Then
            Begin
              numeroaux := arrNumOrd[j];
              arrNumOrd[j] := arrNumOrd[j+1];
              arrNumOrd[j+1] := numeroaux
            End;
        End;
    End;
End;

Function generadora (n: integer): integer;
Var
  MaxNum, minNum : integer;
Begin
  If ( (n<centinela_Max) And (n>=centinela_min)) Then
    Begin
      generardor_arr(n);
      MaxNum := arrNumOrd[1]*100 + arrNumOrd[2]*10 + arrNumOrd[3];
      minNum := arrNumOrd[3]*100 + arrNumOrd[2]*10 + arrNumOrd[1];
      generadora := (MaxNum-minNum);
    End;
End;

Function longitud (semilla: integer; limite: integer): integer;
Var
  iterador, numActual, numAnterior : integer;
Begin
  longitud := -1;
  iterador := 1;
  If ( ( (semilla<centinela_Max) And (semilla >= centinela_min ) ) And ( limite > centinela_min) ) Then
    Begin
      numActual := generadora(semilla);
      numAnterior := semilla;
      While ((iterador<>limite) AND (numActual<>numAnterior)) Do
        Begin
          numAnterior := numActual;
          numActual := generadora(numAnterior);
          iterador := iterador+1;
        End;
      If (numActual=numAnterior) Then
        longitud := iterador
    End;
End;
