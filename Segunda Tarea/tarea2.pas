{
   Juan Appoloni
   Laboratorio 2020 Segundo Semestre (Programación I)

   Tarea2.pas
}

{sonCartasIguales}
{%REGION /fold}
  { El resultado es true si y solo si 'a' y 'b' son la misma carta. }
  Function sonCartasIguales (a, b : TCarta) : boolean;
  Var
    iguales : boolean;
  Begin
    iguales := false;
    If (a.comodin = b.comodin) Then
      Begin
        If (a.comodin = true) Then
          Begin
            iguales := true
          End
        Else
          Begin
            If (a.numero = b.numero) And (a.palo = b.palo) Then
              Begin
                iguales := true
              End;
          End;
      End;
    sonCartasIguales := iguales
  End;

{ENDREGION}

{ceil}
{%REGION /fold}
  { C= A/B, si coma de C !=0  => C+1}
  Function ceil (dividendo,divisor: integer): integer;
  Var
    numero: real;
  Begin
    numero := (dividendo/divisor);
    If (numero > (dividendo Div divisor) ) Then
      ceil := (dividendo Div divisor ) + 1
    Else
      ceil := ( dividendo Div divisor )
  End;
{ENDREGION}

{LimpiarTablero}
{%REGION /fold}
  Procedure LimpiarTablero (Var t: TTablero);
  Var
    i, j : integer;
  Begin
    i := 0;
    j := 0;
    //Limpiador.comodin := true;
    for i:= 1 to FILAS  Do
      Begin
        for j:= 1 to COLS  Do
          Begin
            t.columnas[j].cartas[i]:=  Default(TCarta);
            t.columnas[j].tope:=0;
          End;
      End;
      t.tope := 0;
  End;
{ENDREGION}

{armarTablero}
{%REGION /fold}
  { Copia en las primeras 'cantCols' de 't' las caratas de 'mazo' en orden
    creciente de filas y cada fila de izquierda a derecha.
    Se puede asumir que la cantidad de cartas de 'mazo' caben en esas columnas
    de 't'. }
  Procedure armarTablero (mazo: TMazo; cantCols: TRangoCols; Var t: TTablero);
  Var
    iteradorMazo, i, j, tope : integer;
  Begin
    LimpiarTablero(t);
    tope := ceil(mazo.tope , cantCols);
    iteradorMazo := 0;
    i := 0;
    j := 0;
    While ((iteradorMazo < mazo.tope) And (i < tope )) Do
      Begin
        i := i+1;
        While ((iteradorMazo < mazo.tope) And (j < cantCols ))  Do
          Begin
            j := j+1;
            iteradorMazo := iteradorMazo+1;
            t.columnas[j].cartas[i] := mazo.cartas[iteradorMazo];
            t.columnas[j].tope := i;
          End;
        j := 0;
      End;
    t.tope := cantCols;
  End;
{ENDREGION}

{levantarTablero}
{%REGION /fold}
  { Copia las cartas de 't' en 'mazo' en orden creciente de columnas y cada
    columna en orden creciente de filas. }
  Procedure levantarTablero (t: TTablero; Var mazo: TMazo);
  Var
  iteradorMazo, i, j : integer;
  Begin
    iteradorMazo := 0;
    i := 0;
    j := 0;
    for i:= 1 to t.tope  Do
      Begin
        for j:= 1 to t.columnas[i].tope  Do
          Begin
            iteradorMazo := iteradorMazo+1;
            mazo.cartas[iteradorMazo] := t.columnas[i].cartas[j];
          End;
      End;
    mazo.tope := iteradorMazo;
  End;
{ENDsREGION}

{enQueColumna}
{%REGION /fold}
  { Determina en que columna de 't' está 'carta'.
    Se puede asumir que 'carta' está en el tablero 't'.
    Se puede asumir que en t no hay cartas repetidas. }
  Function enQueColumna (carta : TCarta; t: TTablero): TRangoCols;
  Var
    columna, i, j : integer;
    encontro: boolean;
  Begin
    columna:=1;
    i := 0;
    j := 0;
    encontro := false;
    While ( i <  t.tope ) And (encontro = false) Do
      Begin
        i := i+1;
        While (j < t.columnas[i].tope ) AND (encontro = false) Do
          Begin
            j := j+1;
            if sonCartasIguales(t.columnas[i].cartas[j] , carta) Then
              Begin
                encontro := true;
                columna := i;
              End;
          End;
          j := 0;
      End;
    enQueColumna := columna;
  End;
{ENDREGION}

{estanEnAmbos}
{%REGION /fold}
  { Deja en 'mazo' solo las cartas que también están en 'columna'.
    Las cartas quedan en el mismo orden relativo en que estaban. }
  Procedure estanEnAmbos (columna : TColumna; Var mazo : TMazo);
  Var
    i, j, eliminar: integer;
    encontro: boolean;
  Begin
     i := 0;
    While ( i <  mazo.tope ) Do
    Begin
         i := i+1;
        j := 0;
        encontro := false;
        While (j < columna.tope ) And (encontro = false) Do
          Begin
            j := j+1;
            If sonCartasIguales(columna.cartas[j] , mazo.cartas[i]) Then
              Begin
                encontro := true
              End
          End;
        If (Not encontro) AND (mazo.tope > 0) Then
          Begin
            mazo.tope := mazo.tope - 1;
            For eliminar := i To mazo.tope Do
              mazo.cartas[eliminar] := mazo.cartas[eliminar+1];
            i := i -1;
          End;
          { // ! No Funciona con los casos 15 & 16, 15 por diff & 16 porque no elimina un valor (función a -adivinar (mazo2, cantCols, elegida)-)
          If Not encontro Then
            Begin
              mazo.cartas[i] := mazo.cartas[mazo.tope];
              mazo.tope := mazo.tope - 1;
              i := i -1;
            End;
          }
      End;
  End;
{ENDREGION}

{borrarLista}
{%REGION /fold}
  Procedure borrarLista (Var l: TTableroL);
  Var
    p: TColumnaL;
    i: integer;
  Begin
    Begin
      For i :=1 To l.tope Do
        Begin
          While l.columnas[i] <> Nil Do
            Begin
              p := l.columnas[i];
              // l.columnas[i] :=  l^.sig;
              l.columnas[i] := l.columnas[i]^.sig;
              dispose(p);
            End;
        End;
      l.tope := 0;
    End;
  End;
{ENDREGION}

{convertirTablero}
{%REGION /fold}
  { Convierte 't' en 'tl'.
      En la recorrida de una columna de 'tl' desde el inicio hasta el final
      se deben encontrar las mismas cartas en el mismo orden que en la recorrida
      de la columna correspondiente de 't' desde la primera fila hasta la última. }
  Procedure convertirTablero (t : TTablero; Var tl : TTableroL);
  Var
    i, j : integer;
    p,q : TColumnaL;
  Begin
    i := 0;
    j := 0;
    borrarLista(tl);
    for i:= 1 to t.tope  Do
      Begin
        for j:= 1 to t.columnas[i].tope  Do
          Begin
            new(p);
            p^.carta :=  t.columnas[i].cartas[j];
            p^.sig := Nil;
            If tl.columnas[i] = Nil Then
              tl.columnas[i] := p
            Else
              Begin
               (*busco el último de l*)
                new(q);
                q := tl.columnas[i];
                While q^.sig <> Nil Do
                  q := q^.sig;
               (*engancho p a continuacion del último*)
                q^.sig := p;
              End;
          End;
      End;
      tl.tope := i;
  End;
{ENDREGION}
