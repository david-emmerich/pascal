{$R+} 
{$B+} 

program kiste(input, output);
{baut eine Liste von Stapeln}
  type	
  tRefKiste = ^tKiste;
  tKiste = record
             zahl:integer;
             name:String; 
             up:tRefKiste;             
             next:tRefKiste
           end;

  {---------------- hier beginnt Ihre Prozedur! ----------------}
  procedure add(inZahl:integer; inName:String; var ioKiste:tRefKiste);
  var
    aktuelleKiste: tRefKiste;
    neueKiste: tRefkiste;
  
  begin

    neueKiste := new(tRefKiste);
    neueKiste^.name := inName;
    neueKiste^.zahl := inZahl;
    neueKiste^.next := nil;
    neueKiste^.up := nil;

    if ioKiste = nil then
      ioKiste := neueKiste
    else
      if ioKiste^.name = inName then
        if ioKiste^.up = nil then
          ioKiste^.up := neueKiste
        else
          add(inZahl, inName, ioKiste^.up)
      else
        if ioKiste^.next <> nil then
          add(inZahl, inName, ioKiste^.next)
        else
          ioKiste^.next := neueKiste;

  end;
  {---------------- hier endet Ihre Prozedur  ----------------}

  
  procedure print(inKiste:tRefKiste);
  {schreibt alle Kisten auf die Standardausgabe} 
      
  begin
    if (inKiste <> nil) then
    begin
      write('[');
      write(inKiste^.zahl);
      write(',');
      write(inKiste^.name);
      write(']');
      if (inKiste^.up <> nil) then 
        write('');
      print(inKiste^.up);
      if (inKiste^.up = nil) then 
        write(' ');
      print(inKiste^.next);
    end
  end;
  
  function stringToStapelliste(inS:string):tRefKiste;
  {baut eine Stapelliste aus einem String}
    var
    stapelliste,lauf1,lauf2:tRefKiste;
    r,i:integer;
    c,c2:char;
    s:String;
 
  begin
    stapelliste := nil;
    i := 1;
    r := 0;
    c := 'a';
    s := '';
    while (i <= Length(inS)) do
    begin
      c2 := c;
      c := inS[i];
      if (c <> ']') then s := s + c;
      if (c = '0') then r := r * 10;
      if (c = '1') then r := r * 10 + 1;
      if (c = '2') then r := r * 10 + 2;
      if (c = '3') then r := r * 10 + 3;
      if (c = '4') then r := r * 10 + 4;
      if (c = '5') then r := r * 10 + 5;
      if (c = '6') then r := r * 10 + 6;
      if (c = '7') then r := r * 10 + 7;
      if (c = '8') then r := r * 10 + 8;
      if (c = '9') then r := r * 10 + 9;
      if (c = ',') then s := '';
      if ((c = '[') and (stapelliste = nil)) then 
      begin
        new(stapelliste);
        lauf1 := stapelliste;
        lauf2 := stapelliste;
        stapelliste^.up := nil;
        stapelliste^.next := nil
      end;
      if (c = '[') and (c2 = ']') then 
      begin
        new(lauf2^.up);
        lauf2 := lauf2^.up;
        lauf2^.up := nil;
        lauf2^.next := nil
      end;
      if (c = ' ') then 
      begin
        new(lauf1^.next);
        lauf1 := lauf1^.next;
        lauf2 := lauf1;
        lauf2^.up := nil;
        lauf2^.next := nil
      end; 
      if (c = ']') then
      begin
        lauf2^.zahl := r;
        lauf2^.name := s; 
        r := 0 
      end; 
      i := i + 1;
    end;
    stringToStapelliste := stapelliste;
  end;
  
  procedure printTestDatum(inKiste:string; inZahl:integer; inName:String; inErwartet:string);
  {testet ein Testdatum und schreibt zuerst das erwartete Ergebnis und dann das Ergebnis}
    var
    kisteA:tRefKiste;
  
  begin
    kisteA := stringToStapelliste(inKiste);
    add(inZahl,inName,kisteA);
    writeln;
    writeln(inErwartet);
    print(kisteA);
    writeln;
  end;
  
begin
  writeln('**** testen ****');
  printTestDatum('',1,'Ingwer','[1,Ingwer]');
  printTestDatum('[3,Ingwer] [2,Minze][7,Minze][3,Minze] [3,Salbei][2,Salbei]',5,'Ingwer','[3,Ingwer][5,Ingwer] [2,Minze][7,Minze][3,Minze] [3,Salbei][2,Salbei]');
  printTestDatum('[3,Ingwer] [2,Minze][7,Minze][3,Minze] [3,Salbei][2,Salbei]',2,'Minze','[3,Ingwer] [2,Minze][7,Minze][3,Minze][2,Minze] [3,Salbei][2,Salbei]');
  printTestDatum('[3,Ingwer] [2,Minze][7,Minze][3,Minze] [3,Salbei][2,Salbei]',6,'Salbei','[3,Ingwer] [2,Minze][7,Minze][3,Minze] [3,Salbei][2,Salbei][6,Salbei]');
  printTestDatum('[3,Ingwer] [2,Minze][7,Minze][3,Minze] [3,Salbei][2,Salbei]',4,'Toast','[3,Ingwer] [2,Minze][7,Minze][3,Minze] [3,Salbei][2,Salbei] [4,Toast]');
  writeln;
end.
