{ 
  Se muestran dos posibles versiones.
  En ambas se obtienen los dígitos de 'n' usando los operadores MOD y DIV.
  
  En la primera versión esos dígitos se ordenan
  
  En la segunda versión se considera cada uno los 6 posibles casos 
  y se obtiene otro colección de variables que quedan ordenadas.
  
  En ambas versiones la cantidad de comparaciones que se hacen es a lo sumo 3.
}


{ intercambia los valores de los parámetros }
procedure swap (var a,b: integer);
var temp: integer; 
begin
  temp := a;
  a := b;
  b := temp
end;


{ 0 <= n <= 999}
function generadora (n: integer): integer;
var
  d0, d1, d2: integer; { el valor de estas variables estará entre 0 y 9 }
  creciente, decreciente: integer;
begin
  d2 := n div 100;
  d1 := (n div 10) mod 10;  {o también (n mod 100 ) div 10; }
  d0 := n mod 10;
  
  { se ordenarán d0, d1, d2 para que se cumpla d0 <= d1 <= d2 }
 
  { d0 y d1 quedarán en orden correcto entre ellos }
  if (d0 > d1) then 
    swap (d0, d1);
  
  { se inserta d2 }
  if (d1 > d2) then 
  begin
    { d1 y d2 quedarán en orden correcto entre ellos }
    swap(d1, d2);
    { se obtiene el orden requerido }
    if (d0 > d1) then 
      swap (d0, d1) 
  end;

  decreciente := 100 * d2 + 10 * d1 + d0;
  creciente := 100 * d0 + 10 * d1 + d2;
  generadora := decreciente - creciente
end;


{ Aquí se muestra la segunda versión }
(*
function generadora (n: integer): integer;
var
  { el valor de estas variables estará entre 0 y 9 }
  d0, d1, d2: integer; { digitos de n }
  o0, o1, o2: integer; { los mismos dígitos ordenados }
  creciente, decreciente: integer;
begin
  d2 := n div 100;
  d1 := (n div 10) mod 10;
  d0 := n mod 10;

  if d0 <= d1 then
    if d0 <= d2 then
      if d1 <= d2 then 
      begin
        o0 := d0; o1 := d1; o2 := d2
      end
      else
      begin
        o0 := d0; o1 := d2; o2 := d1
      end 
    else
      begin
        o0 := d2; o1 := d0; o2 := d1
      end   
  else 
    if d1 <= d2 then
      if d0 <= d2 then 
      begin
        o0 := d1; o1 := d0; o2 := d2
      end
      else
      begin
        o0 := d1; o1 := d2; o2 := d0
      end 
    else
    begin
        o0 := d2; o1 := d1; o2 := d0
    end;

  decreciente := 100 * o2 + 10 * o1 + o0;
  creciente := 100 * o0 + 10 * o1 + o2;
  generadora := decreciente - creciente

end;
*)



{ Longitud de la secuencia hasta que se encuentran dos seguidos iguales o 
  -1 si no se encuentra en 'limite' iteraciones.
  Ejemplo: 693, 594, 495, 495, .... 
  longitudK( 695, 2) -> -1
  longitudK( 695, 3) -> 3
  longitudK( 695, 4) -> 3
   
  Se asume que limite >= 1 }
  
function longitud (semilla: integer; limite : integer): integer;
var 
  largo: integer; { cantidad de elementos de la secuencia }
  anterior, ultimo: integer; 
begin
  largo := 0; { como limite > 0 se cumple largo < limite}
  ultimo := semilla;
  repeat
    largo := largo + 1; { se cumple largo <= limite}
    anterior := ultimo;  { el valor 'anterior' aparece por primera vez en la 
                              posición 'largo' de la secuencia }
    ultimo := generadora(anterior)
  until (largo = limite) or (ultimo = anterior);

{
  Puede ocurrir
  - (largo < limite) and (ultimo = anterior)
  - (largo = limite) and (ultimo = anterior)
  - (largo = limite) and (ultimo <> anterior)
  En los primeros dos casos el valor 'anterior' aparece en una posición menor o
  igual a 'limite' y es igual al siguiente.
}
  
  if ultimo = anterior then
    longitud := largo
  else
    longitud := -1
end;




(* otra versión
function longitud (semilla: integer; limite : integer): integer;
var 
  largo: integer; { cantidad de elementos de la secuencia }
  anterior, ultimo: integer; 
begin
  largo := 1;
  anterior := semilla;
  ultimo := generadora(anterior);
  while (largo < limite) and (ultimo <> anterior) do
  begin
    largo := largo + 1; 
    anterior := ultimo;
    ultimo := generadora(anterior)
  end;
  if ultimo = anterior then
    longitud := largo
  else
    longitud := -1
end;
*)




