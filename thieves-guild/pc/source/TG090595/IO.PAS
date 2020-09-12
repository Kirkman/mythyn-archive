unit io;  { registered version }

interface

uses dos,crt,comunit,ddplus;


function bconin(device : integer) : Integer;
function drandom : longint;
function dayz(mo, yr : longint) : longint;
function Since(mo, yr : longint) : longint;
function da_te(yr, mo, dy : longint) : longint;
procedure bugproof(first : str80; var number : integer);

procedure bugProofL(FIRST:str80;Var NUMBER:Longint);
procedure UPCASELN(var LITTLE:str80);
procedure bconout(device,H:Integer);
function bconstat(device:Integer):Boolean;
procedure mapTColor(x:integer);
procedure mapBColor(x:integer);
function clock:longint;
function ENCNUM(KEY:Integer;PER:Integer;DO1:Boolean):Integer;
procedure ENCRYPT(Var INFORM:FIXEDONE;DO2:Boolean);
procedure GETEMGONE(DO3:Boolean);
procedure saveInfo;
procedure CARRIER;
procedure AB_WO;
procedure Mriteln(INFO:FIXEDONE);
procedure Mrite(INFO:str80);
function Pow(Num: longint): longint;
function Fig (Num: longint;Dg: longint): longint;
function Len(Num: longint): longint;
procedure Send_Num(Num: longint);
procedure TWIN;
procedure SOMETHING(Var WELL:str80);
procedure STOP;
procedure EM_SEND(CODES:Integer);
procedure RAND_APPAREL(CPIECE:Integer);
procedure DISPLAY(Var UNI:Boolean);
procedure JAILVIEW(NUM:Integer;Var DOTHEY:Integer);
procedure ASK(Var NUM:Integer;Var WHATSUP:Integer;IS:Integer;UNI:Boolean);
procedure WHAT(Var WELL:str80);
procedure what2(var well:str80);
procedure WHAT3(Var WELL:str80;default : str80);
procedure CH_COL(NCTP:Integer);
procedure MEADLN(Var THEDTUFF:str80);
procedure MRESET(Var SAMPLE:Text;CHKNA:str80);
procedure ESTUFF(ONE:Integer;TWO:Integer;WORDS:str80;COND:Integer);
procedure GOODBYE(NUM:Integer;Var SINGLE:Integer;Var OVER:Boolean);
procedure bcolor(c:integer);
procedure tcolor(c:integer);
procedure mapChar(color:integer; ch : char);
procedure vtModem(st : str80);
procedure SysopMessage;




implementation


(**** MODEM - CHARACTER INPUT *********************************************)
Function bconin(device:Integer):Integer;

  var
    ch : char;

  begin
    case device of
      1: begin sread_char(ch); end;  { mkcisme - accepts both local and com }
      2 : begin ch := readkey; end;
    end;
    bconin := ord(ch);
  end;

procedure bconout(device, h : integer);

  begin
    case(device) of
      1 : begin sendtext(chr(h)); end;
      2 : begin write(chr(h)); end;
    end;
  end;

(**************************************************************************)
function bconstat(device : integer) : boolean;

  var
    f : boolean;

  begin
    f := false;

    case(device) of
      1 : begin if skeypressed then f := true; end; { mkcisme - accepts both local and com }
      2 : if keypressed then f := true;
    end;

    bconstat := f;
  end;


(**** RANDOM GENERATOR ****************************************************)

function drandom : longint;

  begin
    drandom := random(23423);
  end;

(**************************************************************************)
function dayz(mo, yr : longint) : longint;

  begin
    if mo=2 then
      begin
        if (yr mod 4) = 0 then dayz := 29 else dayz := 28 end
      else
        dayz := 30 + ((mo + (mo div 8)) mod 2)
  end;

(**************************************************************************)
function since(mo, yr : longint) : longint;

  begin
    if mo = 1 then
      since := 0
    else
      since := since(mo-1,yr) + dayz(mo-1,yr);
  end;

(**************************************************************************)
function da_te(yr,mo,dy : longint) : longint;

  begin
    da_te := (yr*365) + (yr div 4) + since(mo,yr) + dy;
  end;

(**** CHANGE STRING TO NUMBER *********************************************)
procedure bugproof(first : str80; var number : integer);

  var
    a,b,second : integer;

  begin
    b := 0;
    a := 0;
    number := 0;
    second := 0;
    if not (ord(first[0]) > 5) then
      begin
        for a := ord(first[0]) downto 1 do
          begin
            if first[a] < ':' then
               second := (ord(first[a]) - 48) * round(exp(b * ln(10)));
            b:=b+1;
            number := number + second;
          end
      end; { while }
    if ord(first[1]) = 13 then number := 0
  end;

Procedure bugProofL(FIRST:str80;Var NUMBER:Longint);
    Var
      A,B,SECOND:longInt;
    Begin
      B:=0;
      A:=0;
      NUMBER:=0;
      SECOND:=0;
      if not (ord(FIRST[0]) > 5) then
       Begin
        For A:=ord(FIRST[0]) downto 1 do
          Begin
            if FIRST[A] < ':' then
               SECOND:=(ord(FIRST[A])-48)*round(Exp(B*ln(10)));
            B:=B+1;
          NUMBER:=NUMBER+SECOND
          End
      End;{while}
      If ord(FIRST[1])=13 then NUMBER:=0
  End;

procedure mapTColor(x:integer);

  begin
    case(x) of
      1 : textcolor(red);
      2 : textcolor(green);
      3 : if inTitle then textcolor(black) else textcolor(white);
      4 : if inTitle then textcolor(white) else textcolor(black);
    end;
  end;

procedure mapBColor(x:integer);

  begin
    case(x) of
      1 : textBackground(red);
      2 : textBackground(green);
      3 : if inTitle then textBackground(black) else textBackground(white);
      4 : if inTitle then textBackground(white) else textBackground(black);
    end;
  end;

function clock:longint;

  var
    hour, minute, second, sec100 : word;

  begin
    GetTime(Hour, Minute, Second, Sec100);
    clock := hour * 3600 + minute * 60 + second;
  end;

function encNum(key:integer; per:integer; do1:boolean) : integer;

  begin
    if do1=TRUE then encNum:=per+key;
    if do1=FALSE then encNum:=per-key;
  end;


Procedure ENCRYPT(Var INFORM:FIXEDONE;DO2:Boolean);
  Var
    KEY:String[80];
    COUNT,COUNT1,COUNT3:Integer;
  Begin
    KEY:='Gytwdy6666357t672^%$^&T#HujBDY%7uG@YGX&D^&*STYGHUH@IHDLS(*@++FIOS|';
    COUNT1:=Ord(KEY[0]);
    COUNT:=0;COUNT3:=0;
    Repeat
     COUNT3:=COUNT3+1;
     COUNT:=COUNT+1;
     INFORM[COUNT]:=Chr(ENCNUM(ord(KEY[COUNT3]),ord(INFORM[COUNT]),DO2));
     If COUNT3=COUNT1 then COUNT3:=0
    Until COUNT=Ord(INFORM[0]);
  End;

(**************************************************************************)
  Procedure GETEMGONE(DO3:Boolean);
    Var
      CO1,CO2,CO3:Integer;
      DUM:FIXEDONE;
    Begin
      CO1:=0;CO2:=0;CO3:=0;
     If A_CRYPT=True then Begin
      For CO1:=1 to 26 do
        For CO2:=1 to 9 do Begin
          DUM:=USERS[CO1,CO2];
          ENCRYPT(DUM,DO3);
          USERS[CO1,CO2]:=DUM
         End;
       End;
     If (DO3=False) and (A_CRYPT=False) then Begin
      For CO1:=1 to 30 do Begin
        DUM:=ADJECTIVE[CO1];
        ENCRYPT(DUM,DO3);
        ADJECTIVE[CO1]:=DUM
       End;
      For CO1:=1 to 42 do Begin
        DUM:=MONSTER[CO1];
        ENCRYPT(DUM,DO3);
        MONSTER[CO1]:=DUM
       End;
      For CO1:=1 to 21 do
        For CO2:=1 to 2 do Begin
          DUM:=WEAPON[CO1,CO2];
          ENCRYPT(DUM,DO3);
          WEAPON[CO1,CO2]:=DUM
         End;
      For CO1:=1 to 26 do
        For CO2:=1 to 9 do Begin
          DUM:=USERS[CO1,CO2];
          ENCRYPT(DUM,DO3);
          USERS[CO1,CO2]:=DUM
         End;
      For CO1:=1 to 25 do
        For CO2:=1 to 14 do Begin
          DUM:=TOWNS[CO1,CO2];
          ENCRYPT(DUM,DO3);
          TOWNS[CO1,CO2]:=DUM
         End;
     End;
     If DO3=True then Begin
      For CO1:=1 to 26 do
        For CO2:=1 to 9 do Begin
          DUM:=USERS[CO1,CO2];
          ENCRYPT(DUM,DO3);
          USERS[CO1,CO2]:=DUM
         End;
     End;
    End;
(**************************************************************************)

procedure saveInfo;

  var
    N,SN,D,SD,A,B:Integer;
    TEMP:str80;
    NAME:Text;

  begin
      If WATERS=True then USERI[NUM,28]:=USERI[NUM,28]+10000;
      If MYSTIC then USERI[NUM,30]:=USERI[NUM,30]+10000;
      If HORN=True then USERI[NUM,34]:=USERI[NUM,34]+10000;
      If FAIRY=True then USERI[NUM,31]:=USERI[NUM,31]+10000;
      If NUM>0 then Begin
        USERI[NUM,37]:=USERI[NUM,37]+(PEOPLES*1000)
       End;
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;GETEMGONE(True);
      TEMP:=TPATH;
      INSERT('THIEVES.DAT',TEMP,((Ord(TEMP[0]))+1));

      assign(NAME,TEMP);
      rewrite(name);
       Repeat
          N:=N+1;
          SN:=SN+1;
          D:=1;
          SD:=1;
          Writeln (NAME,USERI[N,D]);
          D:=D+1;
          For A:=1 to 2 do
           Begin
             Writeln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
          Writeln (NAME,USERI[N,D]);
          D:=D+1;
          Writeln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          A:=0;
          For A:=1 to 5 do
           Begin
             Writeln (NAME,USERI[N,D]);
             D:=D+1
           End;
          For A:=1 to 4 do
           Begin
             Writeln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
          Writeln (NAME,USERI[N,D]);
          D:=D+1;
          A:=0;
          For A:=1 to 7 do
           Begin
             Writeln (NAME,USERI[N,D]);
             D:=D+1
           End;
          Writeln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          Writeln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          For A:=1 to 22 do
           Begin
             Writeln (NAME,USERI[N,D]);
             D:=D+1
            End;
          for a:= 38 to 45 do
            writeln(name,useri[n,a]);
       Until N=26;
       Writeln(NAME,DUES);
       Writeln(NAME,DREAM);
       Writeln(NAME,PROG);Writeln(NAME,BSTEAL);Writeln(NAME,BDATE);
       If GMMSG<>'' then Writeln(NAME,GMMSG);
       close(name);
      End;


(***** Check for loss of Carrier - Kill if so *****************************)
procedure carrier;

  var
     ty, kl : integer;
     dumb : str80;

  begin
    carcount := carcount + 1;
    if carcount > 20 then
      begin
        carcount := 0;
        if car = 1 then
          begin
            ty:=100;

            if (clock-comp1=150) and (comptest<>comp1) then
              begin
                comptest := comp1;
                dumb := 'Time-out in 30 seconds if key not pressed.';
                bconout(Car,13);
                bconout(Car,10);
                for kl:=1 to 42 do
                  begin
                    bconout(car,ord(dumb[kl]));
                  end;
                bconout(Car,13);
                bconout(Car,10);
              end;
            if clock-comp1>180 then
              begin
                dumb := '3 Minute timeout!  Thanks for Playing!!';
                bconout(car,13);
                bconout(car,10);
                for kl := 1 to 39 do
                  begin
                    bconout(car,ord(dumb[kl]));
                    tkill := TRUE;
                  end;
                bconout(car,13);
                bconout(car,10)
              end;
            if (tkill) then
              begin
                over := TRUE;
                car:=2;
                mapTColor(3);
                mapBColor(4);
                if (tkill = TRUE) and (emulate) then
                  begin
                    bconout(1,18);
                    bconout(1,51);
                    bconout(1,48);
                    bconout(1,48);
                    bconout(1,20);
                    bconout(1,18);
                    bconout(1,48);
                    bconout(1,20)
                  end;

                if tkill = TRUE then
                  writeln('TIME-OUT LOGOFF')
                else
                  writeln('LOSS OF CARRIER -- PROGRAM TERMINATED!');

                mapTColor(4);
                mapBColor(3);
                if isitok = TRUE then
                  saveInfo;
                {$I-}  { just in case we havn't opened it yet... }
                close(eventsFile);
                {$I+}
                halt(32);
              end;  { loss of carrier or timeout }
          end; { car = 1 }
      end; {carcount > 20 }
  end;  { carrier }

(**************************************************************************)
procedure ab_wo;

  var
    abran : integer;

  begin
    abran := (drandom mod 8) + 1;
    Case abran of
      1 : ab_wor := '*ZAP*';
      2 : ab_wor := '*POW*';
      3 : ab_wor := '*SNIP*';
      4 : ab_wor := '*ZIP*';
      5 : ab_wor := '*BOOM*';
      6 : ab_wor := '*CLIP*';
      7 : ab_wor := '*BLAM*';
      8 : ab_wor := '*POOF*'
    end
  end;


procedure ansixy(x,y:integer);

  var
    s1,s2 : str80;

  begin
    TOFF := TRUE;
    str(x,s1);
    str(y,s2);
    if ansi then
      begin
        mrite(concat(#27,'[',s1,';',s2,'H'));
      end;
    TOFF := FALSE;
    gotoxy(y,x);
  end;

procedure ansig(c:integer);

  begin
    TOFF := TRUE;
    if ansi then
      begin
        case (c) of
          clrhome : begin clrscr; mrite(concat(#27,'[2J')); end;
          home    : begin gotoxy(1,1); mrite(concat(#27,'[1;1H')); end;
        end;
      end;
    TOFF := FALSE;
  end;

procedure ansig2(c,t:integer);

  var
    s1 : str80;

  begin
    TOFF := TRUE;
    str(t,s1);
    if ansi then
      begin
        case (c) of
          flushleft : begin mrite(concat(#27,'[',s1,'D')); end;
        end;
      end;
    TOFF := FALSE;
  end;

procedure mapAnsiG(num1,num2 : integer);

  begin
    if num2 = -1 then
      ansig(clrhome);
    if num2 = -2 then
      ansig2(flushleft,num1);
    if num2 > 0 then
      begin
        ansixy(num1,num2);
      end;
  end;

procedure bcolor(c:integer);

  begin
    TOFF := TRUE;
    if ansi then
      begin
        case (c) of
          black  : mrite(concat(#27,'[40m'));
          red    : mrite(concat(#27,'[41m'));
          green  : mrite(concat(#27,'[42m'));
          yellow : mrite(concat(#27,'[43m'));
          blue   : Mrite(concat(#27,'[44m'));
          magenta: Mrite(concat(#27,'[45m'));
          cyan   : Mrite(concat(#27,'[46m'));
          white  : Mrite(concat(#27,'[47m'));
        end;
      end;
    textbackground(c);
    TOFF := FALSE;
  end;

procedure tcolor(c:integer);

  begin
    TOFF := TRUE;
    if ansi then
      begin
        case (c) of
          black  : mrite(concat(#27,'[30m'));
          red    : mrite(concat(#27,'[31m'));
          green  : mrite(concat(#27,'[32m'));
          yellow : mrite(concat(#27,'[33m'));
          blue   : Mrite(concat(#27,'[34m'));
          magenta: Mrite(concat(#27,'[35m'));
          cyan   : Mrite(concat(#27,'[36m'));
          white  : Mrite(concat(#27,'[37m'));
        end;
      end;
    if bold then
      c := c + 8;
    if flash then c := c + 128;
    textcolor(c);
    TOFF := FALSE;
  end;

procedure mapChar(color:integer; ch : char);

  begin
    tcolor(color);
    mrite(ch);
  end;


procedure mapAnsiC(num1:integer);

  begin
    case(num1) of
      0 : begin bold := FALSE; flash := false; bcolor(black); tcolor(lightgray); end;
      1 : bold := TRUE;
      5 : flash := true;

      40 : bcolor(black);
      41 : bcolor(red);
      42 : bcolor(green);
      43 : bcolor(brown);
      44 : bcolor(blue);
      45 : bcolor(magenta);
      46 : bcolor(cyan);
      47 : bcolor(lightgray);

      30 : tcolor(black);
      31 : tcolor(red);
      32 : tcolor(green);
      33 : tcolor(brown);
      34 : tcolor(blue);
      35 : tcolor(magenta);
      36 : tcolor(cyan);
      37 : tcolor(lightgray);
    end;
  end;

procedure vtModem(st : str80);

  var
    x : integer;

  begin
    if VT then
      for x := 1 to length(st) do
        bconout(1,ord(st[x]));
  end;



procedure sysKeyPress;

  var
    kat  : integer;
    keri : char;

  begin
    If bconstat(2) then
      begin
        kat := bconin(2);
        keri := chr(kat);
        if (keri>'0') and (keri<'9') then
          begin
            bugproof(keri,sysopm);
            { keri }
            textbackground(red);
            textcolor(black);
            write('Registered # ',keri,'!');
            textcolor(white);
            textbackground(black);
          end;
      end;
  end;

procedure checkKeypress;

  var
    ours : integer;
    dones : boolean;

  begin
    ours := bconin(car);
    if ours=19 then
      begin
        dones := FALSE;
        comp1:=clock;
        repeat
          carrier;
          if (bconstat(car)) and (bconin(car)=17) then
            dones := TRUE;
        until ((clock-comp1)>30) or (dones=true);
      end;
    if ours=3 then
      begin
        ab_wo;
        if able=TRUE then
          begin
            mriteln('');
            mriteln(ab_wor);
            soff := TRUE;
          end;
      end;
  end;


procedure ansiMriteln(ansiStr : fixedone);

  var
    cc : integer;
    num1, num2, num3 : integer;
    t : integer;
    st : str80;

 begin
   cc := 1;
   while cc <= length(ansiStr) do
   begin
     st := '';
     while ansiStr[cc] = #27 do
       begin
         st := st + #27; inc(cc);
         if ansiStr[cc] = '[' then
           begin
             st := st + ansiStr[cc]; inc(cc);
             case ansiStr[cc] of
               '0'..'9' : begin
                            num1 := 0; num2 := -1; num3 := -1;
                            repeat
                              num1 := num1 * 10;
                              num1 := num1 + (ord(ansiStr[cc]) - ord('0'));
                              st := st + ansiStr[cc]; inc(cc);
                            until (not (ansiStr[cc] in ['0'..'9']));
                            if ansiStr[cc] = ';' then
                              begin
                                st := st + ansiStr[cc]; inc(cc);
                                num2 := 0;
                                repeat
                                  num2 := num2 * 10;
                                  num2 := num2 + (ord(ansiStr[cc]) - ord('0'));
                                  st := st + ansiStr[cc]; inc(cc);
                                until (not (ansiStr[cc] in ['0'..'9']));
                              end;
                            if ansiStr[cc] = ';' then
                              begin
                                st := st + ';'; inc(cc);
                                num3 := 0;
                                repeat
                                  num3 := num3 * 10;
                                  num3 := num3 + (ord(ansiStr[cc]) - ord('0'));
                                  st := st + ansiStr[cc]; inc(cc);
                                until (not (ansiStr[cc] in ['0'..'9']));
                              end;
                            case(ansiStr[cc]) of
                              'm' : begin
                                       mapAnsiC(num1);
                                      if num2 <> -1 then mapAnsiC(num2);
                                      if num3 <> -1 then mapAnsiC(num3);
                                      st := st + ansiStr[cc]; inc(cc);
                                    end;
                              'J' : begin
                                      if num1 = 2 then mapAnsiG(num1,-1);
                                      st := st + ansiStr[cc]; inc(cc);
                                    end;
                              'H' : begin
                                      mapAnsiG(num1,num2);
                                      st := st + ansiStr[cc]; inc(cc);
                                    end;
                              'C' : begin
                                      for t := 1 to num1 do if soff=FALSE then bconout(2,ord(' '));
                                      st := st + ansiStr[cc]; inc(cc);
                                    end;
                              'D' : begin
                                      gotoxy(1,wherey);
                                      st := st + ansiStr[cc]; inc(cc);
                                      mapAnsiG(num1,-2);
                                    end;
                            end;
                          end;
               's' : begin ansiX := wherex; ansiY := whereY; st := st + ansiStr[cc]; inc(cc); end;
               'u' : begin gotoxy(ansiX, ansiY); st := st + ansiStr[cc]; inc(cc); end;
             end;
           end;  (* if ansiStr[cc] = '[' *)
       end;  (* while ansiStr[cc] = #27 *)
     if ((ansi) and (st <> '') and (car=1) and (soff=FALSE)) then
       for t := 1 to length(st) do
         begin
           comp1:=clock;
           carrier;
           if bconstat(car) then checkKeypress;
           sysKeypress;
           bconout(1,ord(st[t]));
         end;

     if cc <= length(ansiStr) then
       begin
         comp1:=clock;
         carrier;
         if bconstat(car) then
           checkKeypress;
         sysKeypress;
         if (soff = FALSE) then bconout(2,ord(ansiStr[cc]));
         if ((ansi) and (car=1) and (soff=FALSE)) then bconout(1,ord(ansiStr[cc]));
         inc(cc);
       end;
   end; (*  while cc < length(ansiStr) *)
 end;

procedure mriteln(info:fixedone);

  var
    cc : integer;
    ansiStr : fixedone;
    vt52Str : fixedone;
    textStr : fixedone;
    ansicc, vt52cc, textcc : integer;
    code : char;

  begin
    ansicc := 0; vt52cc := 0; textcc := 0;
    ansiStr := ''; vt52Str := ''; textStr := '';
    cc := 1;
    while cc <= length(info) do begin
      if info[cc] <> #27 then begin
        inc(ansicc); inc(vt52cc); inc(textcc);
        ansiStr := ansiStr + info[cc];
        vt52Str := vt52Str + info[cc];
        textStr := textStr + info[cc];
        inc(cc);
      end else begin
        inc(cc);
        case (info[cc]) of
          'c',
          'b',
          'E',
          'K' : begin
                  case (info[cc]) of
                    'c' : begin
                            inc(cc);
                            code := info[cc];
                            vt52Str := vt52Str + #27 + 'c' + code;
                            inc(cc);
                            case code of
                              '1' : ansiStr := ansiStr + #27 + '[41m';
                              '2' : ansiStr := ansiStr + #27 + '[42m';
                              '3' : ansiStr := ansiStr + #27 + '[40m';
                              '4' : ansiStr := ansiStr + #27 + '[47m';
                            end;
                          end;
                    'b' : begin
                            inc(cc);
                            code := info[cc];
                            vt52Str := vt52Str + #27 + 'b' + code;
                            inc(cc);
                            case code of
                              '1' : ansiStr := ansiStr + #27 + '[31m';
                              '2' : ansiStr := ansiStr + #27 + '[32m';
                              '3' : ansiStr := ansiStr + #27 + '[30m';
                              '4' : ansiStr := ansiStr + #27 + '[37m';
                            end;
                          end;
                    'E' : begin
                            inc(cc);
                            vt52Str := vt52Str + #27 + 'E';
                            ansiStr := ansiStr + #27 + '[2J';
                          end;
                    'K' : begin
                            inc(cc);
                            vt52Str := vt52Str + #27 + 'K';
                          end;
                  end;  (* case info[cc] *)
                end; (* if info[cc] = 'c' or 'b' or 'E' or 'K' *)
          '[' : begin
                  inc(cc);
                  ansiStr := ansiStr + #27 + '[';
                  case (info[cc]) of
                    '0'..'9' : begin
                                 repeat
                                   if info[cc] = ';' then inc(cc);
                                   repeat
                                     ansiStr := ansiStr + info[cc];
                                     inc(cc);
                                   until not (info[cc] in ['0'..'9']);
                                   if info[cc] = ';' then
                                     begin
                                       ansiStr := ansiStr + ';';
                                     end;
                                 until info[cc] <> ';';
                                 ansiStr := ansiStr + info[cc];
                                 inc(cc);
                               end;
                    's' : begin ansiStr := ansiStr + 's'; inc(cc); end;
                    'u' : begin ansiStr := ansiStr + 'u'; inc(cc); end;
                  end; (* case info[cc] *)
                end; (* case = '[' *)
        end; (* case of ansi or VT52 *)
      end; (* if info[cc] = #27 *)
    end; (* while statement *)

    if VT then
      begin
        for cc := 1 to length(vt52Str) do
          if (CAR=1) and (SOFF=FALSE) then
            begin
              comp1 := clock;
              carrier;
              if bconstat(car) then
                checkKeypress;
              sysKeypress;
              bconout(1,ord(vt52Str[cc]));
            end;
        ansiMriteln(ansiStr);
      end (* VT = TRUE *)
    else if ANSI then
      begin
        ansiMriteln(ansiStr);
      end (* ANSI = TRUE *)
    else
      begin
        for cc := 1 to length(textStr) do
          if (CAR=1) and (SOFF=FALSE) then
            begin
              comp1 := clock;
              carrier;
              if bconstat(car) then
                checkKeypress;
              sysKeypress;
              bconout(1,ord(textStr[cc]));
            end;
        ansiMriteln(ansiStr);
      end; (* neither ANSI nor VT52 (TEXT) *)

    if (car=1) and (soff=FALSE) then
      begin
        bconout(1,13);
        bconout(1,10);
      end;
    If (toff=FALSE) and (soff=FALSE) then
      begin
        bconout(2,13);
        bconout(2,10);
      end;
  end;

(**************************************************************************)
procedure mrite(info:str80);

  var
    cc, ours : integer;
    dones : boolean;

  begin
    cc:=0;
    for cc:=1 to length(info) do
      begin
        if soff = FALSE then
          begin
            if twisty = FALSE then comp1 := clock;
            carrier;
            if (bconstat(car)) and (twisty=FALSE) then
              begin
                ours:=bconin(car);
                if ours=19 then
                  begin
                    dones := FALSE; comp1 := clock;
                    repeat
                      carrier;
                      If bconstat(car) then
                        If bconin(car) = 17 then dones := TRUE;
                    until ((clock-comp1)>30) or (dones=True);
                  end;
                if ours=3 then
                  begin
                    if (able=TRUE) then
                      begin
                        mriteln('');
                        if (vt=TRUE) then
                          begin
                            bconout(1,27);
                            bconout(1,ord('b'));
                            bconout(1,ord('3'));
                          end;
                        ab_wo;
                        mriteln(ab_wor);
                        soff:=TRUE;
                      end;
                  end;
              end;
            if ((car=1) and (soff=FALSE)) then bconout(1,ord(info[cc]));
            if ((toff=FALSE) and (soff=FALSE)) then bconout(2,ord(info[cc]))
          end;
      end;
  end;  (* procedure mrite(info) *)
(**************************************************************************)
function pow(num : longint) : longint;

  begin
    if num = 0 then
      pow := 1
    else
      pow := 10 * pow(num - 1);
  end;

function fig (num : longint; dg : longint) : longint;

  begin
    fig := (num div pow(dg)) mod 10;
  end;

function len(num : longint) : longint;

  begin
    if num < 10 then len := 0 else len := len(num div 10) + 1;
  end;

procedure send_num(num : longint);

  var
    a : longint;

  begin
    for a := len(num) downto 0 do
      begin
        if (car = 1) and (soff = FALSE) then bconout(1,fig(num,a)+48);
        if (soff = FALSE) and (toff=FALSE) then bconout(2,fig(num,a)+48)
      end;
  end;

(***** Top Window *********************************************************)
procedure print(x,y:integer; s:str80; c:integer);

   var
      r,valu:integer;
      st : str80;

   begin
      valu:=((16*(y-1))*10)+2*(x-1);
      r:=1;
      repeat
         st := copy(s,r,1);
         mem[$b800:valu]:=ord(st[1]);
         mem[$b800:valu+1]:=c;
         r:=r+1; valu:=valu+2;
      until r=length(s)+1;
   end;

procedure twin;

  var
    kount, kout : integer;
    st1 : str80;
    st2 : str80;
    code : word;

  begin
    st1 := '';
    if (num > 0) and (car <> 2) then
      begin
        kout:=1;
        if useri[num,6] > 9 then kout := 2;
        str(useri[num,6],st2);
        st1 := concat('Name: ',users[num,2],' Thief: ',users[num,3],' Time Left: ',st2,' Hour(s).');
        kount := 0;
        for kount := 1 to (80-(35+ord(users[num,2][0])+ord(users[num,3][0])+kout)) do
          st1 := concat(st1,' ');  { pad to end of line }
        print(1,1,st1,red*16+black);
    end;
  end;


(**** GET A CHARACTER *****************************************************)
  Procedure SOMETHING(Var WELL:str80);
   Var
    dummy,event,what_key:integer;
    Key_Wait:str80;
   Begin
     TWIN;Key_wait[0]:=Chr(1);COMP1:=Clock;
     Repeat
       CARRIER;
     Until (Bconstat(CAR)) or (Bconstat(2));
     If Bconstat(CAR) then what_key:=bconin(CAR);
     If Bconstat(2) then what_key:=bconin(2);
     Key_wait[1]:=chr(what_key);
     WELL:=Key_Wait;
     UPCASELN(WELL)
   end;


  Procedure STOP;
    Var
      QUICK:str80;
    Begin
      Mriteln('');TWIN;COMP1:=Clock;If EMULATE then VT:=False;QUICK:='A';
      If (VT=False) or (HALF=True) then
        begin
          tcolor(white); bcolor(black);
          Mrite('Press ');
          bcolor(red); tcolor(black);
          mrite('<RETURN>');
          tcolor(white); bcolor(black);
          mrite(' to Continue.');
        end;
      If (VT=True) and (HALF=False) then
        Begin
          Mrite('Press ');
          vtModem(Chr(27)+'c1');
          bcolor(red); tcolor(black);
          Mrite('<RETURN>');
          bcolor(black); tcolor(white);
          vtModem(Chr(27)+'c4');
          Mrite(' to Continue.')
        End;
      Repeat
        SOMETHING(QUICK)
      Until ord(QUICK[1])=13;If EMULATE then VT:=True;
      Mriteln('')
    End;


(**** Emulator Code Sender ************************************************)
  Procedure EM_SEND(CODES:Integer);
    Var
      CTR:longint;
      KL,HERB:Integer;
      APAUSE,LEAVE:Boolean;
    Begin
     APAUSE:=False;TOFF:=True;
     If EMULATE then Begin
       Case CODES of
         104,107,113,115,130,133,507,505,506,504,503:APAUSE:=True
      End;
      If (CODES=301) and (BOOGIE) then APAUSE:=True;
      If (CODES>400) and (CODES<410) then Begin
        Mrite(Chr(18));Send_Num(USERI[NUM,6]+200);
        Mrite(Chr(20))
       End;
      Mrite(Chr(18));
      Send_Num(WIND+250);
      Mrite(Chr(20));
      Mrite(Chr(18));
      Send_Num(CODES);
      Mrite(Chr(20));LEAVE:=False;HERB:=0;
      If APAUSE then Begin
         CTR:=Clock;
         Repeat
           If bconstat(1) then HERB:=bconin(1);
           If HERB=17 then LEAVE:=True;
           CARRIER;
           If (Clock-CTR)>=8 then LEAVE:=True
         Until LEAVE=True;
        End;
       If (BOOGIE) and (CODES=301) then BOOGIE:=False;
       If CODES=301 then Begin
       HALF:=True;STOP;HALF:=False;
       EM_SEND(300)
      End;
     End;
     TOFF:=False
    End;



(**************************************************************************)
  Procedure RAND_APPAREL(CPIECE:Integer);
    Var
      COLORS:Array[1..9] of String[6];
      APNAME:String[8];
      MAX:Integer;
    Begin
     COLORS[1]:='Black';COLORS[2]:='Brown';COLORS[3]:='Blue';COLORS[4]:='Black';
     COLORS[5]:='Gray';COLORS[6]:='Yellow';COLORS[7]:='Red';COLORS[8]:='Green';
     COLORS[9]:='White';
      RANDCLOTH:='Cheap ';
      If (CPIECE=1) or (CPIECE=2) then MAX:=9; {Bandana, Shirt}
      If CPIECE=3 then MAX:=5; {Pants}
      If CPIECE=4 then MAX:=2; {Sandals}
      INSERT(COLORS[(DRANDOM mod MAX)+1],RANDCLOTH,(ord(RANDCLOTH[0])+1));
      Case CPIECE of
         1:APNAME:=' Bandana';
         2:APNAME:=' Shirt';
         3:APNAME:=' Pants';
         4:APNAME:=' Sandals'
        End; {Case}
      INSERT(APNAME,RANDCLOTH,(ord(RANDCLOTH[0])+1));
     End;

  Procedure DISPLAY(Var UNI:Boolean);
    Var
      A,B:Integer;
    Begin
     ABLE:=True;
     Mriteln('');
     If UNI=True then Mriteln ('          ++ List of Guild Members ++');
     If UNI=False then Begin
       Mrite ('    ++ Thieves Currently in ');
       Mrite (TOWNS[USERI[NUM,14],1]);
       Mriteln(' ++')
      End;
     Mriteln('');
     Mriteln ('#  Name                       Skill  Faith  Score');
     Mriteln ('-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
     A:=0;B:=0;
      Repeat
        A:=A+1;
        If (USERS[A,3] <> 'EMPTY') and ((USERI[NUM,14]=USERI[A,14]) or (UNI=True))
          and ((USERI[A,27]=0) or (UNI=True)) then
         Begin
           Mrite (USERS[A,1]);
           Mrite('  ');
           Mrite(USERS[A,3]);
           For B:=1 to (28-(ord(USERS[A,3][0]))) do
             Mrite (' ');
           Send_Num(USERI[A,3]);
           If USERI[A,3] < 1000 then Mrite (' ');
           If USERI[A,3] < 100 then Mrite (' ');
           If USERI[A,3] < 10 then Mrite (' ');
           Mrite('   ');
           If USERI[A,19]=0 then Mrite('   ');
           If USERI[A,19]=5 then
             begin
               tcolor(red);
               Mrite('[B]');
               tcolor(white);
             end;
           If USERI[A,19]=11 then
             begin
               tcolor(green);
               Mrite('[C]');
               tcolor(white);
             end;
           If USERI[A,19]=21 then
             begin
               tcolor(cyan);
               Mrite('[S]');
               tcolor(white);
             end;
           Mrite('   ');
           Send_Num(USERI[A,5]);Mriteln('')
         End;
      Until A=26;
      ABLE:=False;SOFF:=False;
     Mriteln('')
    End;


  Procedure JAILVIEW(NUM:Integer;Var DOTHEY:Integer);
    Var
      A,B:Integer;
    Begin
     A:=0;B:=0;DOTHEY:=0;
     ABLE:=True;
     Mriteln('');Mrite ('    ++ Thieves Currently in the ');
     Mrite(TOWNS[USERI[NUM,14],1]);
     Mriteln(' Jail ++');
     Mriteln('');
     Mriteln ('#  Name                       Skill  Faith  Score');
     Mriteln ('-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
      Repeat
        A:=A+1;
        If (USERS[A,3] <> 'EMPTY') and (USERI[NUM,14]=USERI[A,14]) and (USERI[A,7]>0) then
         Begin
           DOTHEY:=DOTHEY+1;
           Mrite(USERS[A,1]);
           Mrite('  ');
           Mrite(USERS[A,3]);
           For B:=1 to (28-(ord(USERS[A,3][0]))) do
           Mrite (' ');
           Send_Num(USERI[A,3]);
           If USERI[A,3] < 1000 then Mrite (' ');
           If USERI[A,3] < 100 then Mrite (' ');
           If USERI[A,3] < 10 then Mrite (' ');
           Mrite('   ');
           If USERI[A,19]=0 then Mrite('   ');
           If USERI[A,19]=5 then
             begin
               tcolor(red);
               Mrite('[B]');
               tcolor(white);
             end;
           If USERI[A,19]=11 then
             begin
               tcolor(green);
               Mrite('[C]');
               tcolor(white);
             end;
           If USERI[A,19]=21 then
             begin
               tcolor(cyan);
               Mrite('[S]');
               tcolor(white);
             end;
           Mrite('   ');
           Send_Num(USERI[A,5]);Mriteln('');
         End;
      Until A=26;
     ABLE:=False;SOFF:=False;
     Mriteln('')
    End;


(**************************************************************************)
  Procedure ASK(Var NUM:Integer;Var WHATSUP:Integer;IS:Integer;UNI:Boolean);
    Var
      WHO:str80;
    Begin
      SOMETHING(WHO);
      WHATSUP:=ord(WHO[1])-64;
      If (WHATSUP > 0) and (WHATSUP < 27) and (WHATSUP <> NUM) then
      If (USERS[WHATSUP,3] <> 'EMPTY') and ((USERI[NUM,14]=USERI[WHATSUP,14]) or (UNI=True)) then
           Mriteln (USERS[WHATSUP,3])
      Else Begin
        If ord(WHO[1])=13 then Begin
          WHATSUP:=-1;
          Mriteln ('NOBODY')
       End;
        If (ord(WHO[1]) <> 13) and (WHATSUP <> NUM) and (WHO <> '?') then
          Begin
            tcolor(magenta);
            Mriteln ('Thief does not exist!');
            tcolor(white);
            WHATSUP:=0
          End
      End
     Else Begin
        If ord(WHO[1])=13 then
          begin
            WHATSUP:=-1;
            tcolor(blue);
            Mriteln ('NOBODY');
            tcolor(white);
          end;
        If (ord(WHO[1]) <> 13) and (WHATSUP <> NUM) and (WHO <> '?') then
          Begin
            bcolor(white); tcolor(red);
            Mriteln ('Thief does not exist!');
            bcolor(black); tcolor(white);
            WHATSUP:=0
          End
      End;
    If WHATSUP=NUM then
      Begin
        tcolor(cyan);
        Mriteln ('That''s you!!');
        WHATSUP:=0;
        tcolor(white);
      End;
    If WHO='?' then Begin
      Mriteln ('LIST THIEVES.');
      WHATSUP:=-2;
      If IS=0 then DISPLAY(UNI);
      If IS=1 then JAILVIEW(NUM,IS)
     End
    End;

Procedure upcaseln(var LITTLE:Str80);
    Var
      COUNT,COUNTLA:Integer;
    Begin
      for count := 1 to length(little) do
        little[count] := upcase(little[count]);
    END;

procedure what2(var well:str80);

  var
    dummy,event,what_key:integer;
    Key_Wait:str80;

  begin
    TWIN;COMP1:=Clock;
   Repeat
     Key_wait[0]:=Chr(1);
     Repeat
       CARRIER;
     Until (Bconstat(CAR)) or (Bconstat(2));
     If Bconstat(CAR) then what_key:=bconin(CAR);
     If Bconstat(2) then what_Key:=bconin(2);
     Key_wait[1]:=chr(what_key);
      WELL:=Key_Wait;
      upcaseln(WELL);

      if well=#13 then well := 'A';

      if well='N' then
        begin
          tcolor(red);
          Mriteln('None!');
          tcolor(white);
        end;
      if well='A' then
        begin
          ansi:=TRUE;
          tcolor(red);
          bcolor(black);
          mriteln('Ansi!');
          tcolor(white);
        end;
      if well='V' then
        begin
          if HALF=TRUE then mriteln('VT-52!')
          else
            begin
              vt := TRUE;
              toff := TRUE;
              vtModem (Chr(27) + 'b1');
              toff := FALSE;
              mapTColor(1);
              Mrite('VT-52!');
              mapTColor(4);
              TOFF := TRUE;
              vtModem(#27 + 'b3');
              mriteln('');
              toff := FALSE;
            end;
        end;
    Until (well='V') or (well='A') or (well='N');
    mriteln('');  {* added by myron to fix error for paul *}
   End;


(*****GET KEY**************************************************************)
Procedure WHAT(Var WELL:str80);
   Var
    dummy,event,what_key:integer;
    Key_Wait:str80;
   Begin
    TWIN;COMP1:=Clock;
   Repeat
     Key_wait[0]:=Chr(1);
     Repeat
       CARRIER;
     Until (Bconstat(CAR)) or (Bconstat(2));
     If Bconstat(CAR) then what_key:=bconin(CAR);
     If Bconstat(2) then what_Key:=bconin(2);
     Key_wait[1]:=chr(what_key);
      WELL:=Key_Wait;
      UPCASELN(WELL);
      If (WELL='Y') and ((VT=False) or (HALF=True)) then
        begin
          tcolor(red);
          Mriteln ('Yea!');
          tcolor(white);
        end;
      If (WELL='N') and ((VT=False) or (HALF=True)) then
        begin
          tcolor(yellow);
          Mriteln ('Nay!');
          tcolor(white);
        end;
      If (WELL='Y') and (VT=True) and (HALF=False) then Begin
        vtModem(Chr(27)+'b2');
        Mrite ('Yea!');
        vtModem(chr(27)+'b3');
        Mriteln('')
       End;
      If (WELL='N') and (VT=True) and (HALF=False) then Begin
        vtModem(Chr(27)+'b1');
        Mrite('Nay!');
        vtModem(Chr(27)+'b3');
        Mriteln('')
       End;
    Until(WELL='Y') or (WELL='N')
   End;

Procedure WHAT3(Var WELL:str80;default : str80);
   Var
    dummy,event,what_key:integer;
    Key_Wait:str80;
   Begin
    TWIN;COMP1:=Clock;
   Repeat
     Key_wait[0]:=Chr(1);
     Repeat
       CARRIER;
     Until (Bconstat(CAR)) or (Bconstat(2));
     If Bconstat(CAR) then what_key:=bconin(CAR);
     If Bconstat(2) then what_Key:=bconin(2);
     Key_wait[1]:=chr(what_key);
      WELL:=Key_Wait;
      UPCASELN(WELL);
      if well = #13 then well := default;
      If (WELL='Y') and ((VT=False) or (HALF=True)) then
        begin
          tcolor(red);
          Mriteln ('Yea!');
          tcolor(white);
        end;
      If (WELL='N') and ((VT=False) or (HALF=True)) then
        begin
          tcolor(yellow);
          Mriteln ('Nay!');
          tcolor(white);
        end;
      If (WELL='Y') and (VT=True) and (HALF=False) then Begin
        vtModem(Chr(27)+'b2');
        Mrite ('Yea!');
        vtModem(chr(27)+'b3');
        Mriteln('')
       End;
      If (WELL='N') and (VT=True) and (HALF=False) then Begin
        vtModem(Chr(27)+'b1');
        Mrite('Nay!');
        vtModem(Chr(27)+'b3');
        Mriteln('')
       End;
    Until(WELL='Y') or (WELL='N')
   End;
(**************************************************************************)
  Procedure CH_COL(NCTP:Integer);
    Begin
      If ((vt or ansi) and (MAINP)) then Begin
        If CAR=1 then if vt then bconout(1,27);
{        bconout(2,27);}
        If CAR=1 then if vt then bconout(1,98);
{        bconout(2,98);}
        If NCTP=1 then Begin
          If CAR=1 then if vt then
            begin
              bconout(1,50);
              tcolor(Green);
            end
          else
            tcolor(green);
{          bconout(2,50)}
         End;
        If NCTP=2 then Begin
          If CAR=1 then if vt then
            begin
              textcolor(red);
              bconout(1,49);
            end
          else tcolor(red);
{          bconout(2,49)}
         End;
        If NCTP=3 then Begin
          If CAR=1 then if vt then bconout(1,51) else tcolor(white);
{          bconout(2,51)}
         End;
       End;
     End;


(***** Special Meadln Routine *********************************************)
Procedure MEADLN(Var THEDTUFF:str80);

  var
    SHEDTUFF:str80;
    LAST:Char;
    J,D,T,TY,COUNTY,DUMBBB:Integer;
    COUNTYS:longint;
    DONT,DEL:Boolean;

    curClock : longint;

  begin
    { initialize the variables }
    j:=0; d:=0; t:=1; THEDTUFF:=''; SHEDTUFF:='';
    LAST:=' '; TY:=50; comp1:=Clock; county:=0;

    COUNTYS:=0;DEL:=False;
    TWIN;
    COUNTYS:=Clock;

    Repeat
      DONT:=False;
      CARRIER;

      curClock := clock;  { get current clock count }

      { if twisty cursor is still on AND 1 second has gone by... }
      if (TWISTY=True) and (countys<>curClock) then
        Begin
          If VT=True then
            vtModem(Chr(27)+'f');
          COUNTY:=COUNTY+1;
          If DEL=True then
            Mrite(Chr(8));
          DEL:=True;
          Case COUNTY of
            1 : Begin
                  CH_COL(1);If CAR=1 then bconout(1,124);
                  bconout(2,124)
                End;
            2 : Begin
                  CH_COL(2);If CAR=1 then bconout(1,47);
                  bconout(2,47)
                End;
            3 : Begin
                  CH_COL(1);If CAR=1 then bconout(1,45);
                  bconout(2,45)
                End;
            4 : Begin
                  CH_COL(2);If CAR=1 then bconout(1,92);
                  bconout(2,92)
                End;
          end; (* case county - which twisty shape *)
          if county=4 then
            county:=0;
          countys:=clock;
        end;  (* twisty=true and countys <> clock *)

      If (bconstat(CAR)) or ((bconstat(2)) and (TOFF=False)) then
        Begin
           If (VT=True) and (CAR=1) then
            begin
              bconout(1,27);
              bconout(1,101);
            end;
          TWISTY:=False;
          If bconstat(CAR) then
            LAST:=Chr(bconin(CAR));
          COMP1:=Clock;
          If (bconstat(2)) and (TOFF=False) then
            LAST:=Chr(bconin(2));
          If (bconstat(2)) and (TOFF=True) then
            DUMBBB:=bconin(2);
          If DEL=True then
            Mrite(Chr(8));
          DEL:=False;
          If ((ord(LAST)>31) and (ord(LAST)<127)) or (ord(LAST)=13) or (ord(LAST)=8) then
            Begin
              If ord(LAST)=8 then
                Begin
                  If ord(SHEDTUFF[J])<>0 then
                    Begin
                      If TOFF=False then
                        bconout(2,ord(LAST));
                        If TOFF=False then
                          bconout(2,ord(32));
                        If TOFF=False then
                          bconout(2,ord(LAST));
                        If CAR=1 then
                          bconout(1,ord(LAST));
                        If CAR=1 then
                          bconout(1,ord(32));
                        If CAR=1 then
                          bconout(1,ord(LAST));
                        D:=J;
                        J:=J-1;
                        DELETE(SHEDTUFF,D,T)
                    End
                End;
              If (ord(LAST)<>8) then
                begin
                  if j = 0 then
                    begin
                      if ansi then
                        tcolor(white);
                      if vt then
                        begin
                          vtModem(#27+'b3');
                          textcolor(white);
                        end;
                    end;
                  J:=J+1;
                end;
              If ord(LAST)<>8 then
                INSERT(LAST,SHEDTUFF,J);
              If ord(LAST)=8 then
                DONT:=True;
              If (DONT=False) and (CAR=1) and (ord(LAST)<>13) then
                bconout(1,ord(LAST));
              If (DONT=False) and (TOFF=False) and (ord(LAST)<>13) then
                Write(LAST);
            end;  (* ord(last)  > 31 and < 127 or 8 (backspace or 13 (return) *)
        end; (* bconstat(car) and bconstat(2) and toff = FALSE *)
    Until (ord(LAST)=13) or (J=80);
    DELETE(SHEDTUFF,J,T);
    If MAINP then
      CH_COL(3);
    If CAR=1 then
      bconout(1,13);
    If CAR=1 then
      bconout(1,10);
    If TOFF=False then
      Writeln;
    THEDTUFF:=SHEDTUFF;
  end;
(**************************************************************************)
procedure mReset(var sample:Text;chkna:str80);
  var
    tbckd : integer;

  begin
    assign(sample,chkna);
    {$I-}
    reset(sample);
    {$I+}
    if ioresult <> 0 then
      begin
        mrite('File not found: ');
        mriteln(CHKNA);
        mriteln('Please Notify SysOp.');
        stop;
        halt(0);
      end;
  end; { mReset }

(**** EVENTS UPDATES - CONDITIONS *****************************************)
procedure eStuff(one : integer; two : integer; words : str80; cond : integer);

  var
    random, which, is : integer;
    word, told, junk, temp : str80;
    info : string[160];
    uni, nat : boolean;
    victumEventsFile : text;

  begin
    uni := FALSE;
    nat := FALSE;

    if ((cond=16) or (cond=19) or (cond=20) or (cond=21)) then
      begin
        repeat
          if cond<>21 then
            begin
              mriteln('');
              repeat
                junk:='';
                mrite ('Say something to who? [?=List] [Return Aborts]: ');
                is := 0;
                if words = 'THEPASS' then uni := TRUE;
                ask(NUM,WHICH,IS,UNI);
                uni := FALSE;
                if which > 0 then
                  begin
                    mrite(users[which,3]);
                    mrite(' [Y/N] ');
                    what(junk);
                    one := which;
                  end;
              until (WHICH=-1) or (JUNK='Y');
            end;
          if (which=-1) and (cond=19) and (words<>'THEPASS') then
            begin
              mriteln('He says, "Fine!  But thou gettest no refund!"');
              stop;
            end;
          if which = -1 then cond:=100;
          if (which > 0) or (cond = 21) then
            begin
              repeat
                junk:='N';
                repeat
                  mriteln('');
                  mriteln ('Enter thy Text, up to 80 char. Maximum...');
                  mrite ('>');
                  twisty := TRUE;
                  meadln (told);
                until (length(told) > 1) and (length(told) < 80);
                mriteln('');
                mrite('"');
                mrite(told);
                mriteln('"');
                mrite ('Correct [Y/N] ');
                what(junk);
                mriteln('');
              until junk='Y'
            end;
        until (junk='Y') or (which=-1);
        if which < 0 then cond := 100
      end;

    if (((cond>11) and (cond<16)) or ((cond>26) and (cond<35)) or
        ((cond>40) and (cond<49))) then
      nat := TRUE;

    case cond of
        6,7,17,18,21,24,25: nat := TRUE;
    end; {Case}

    if (cond=12) or (cond=13) or (cond=21) or (cond=28) then
      nat := FALSE;
    if (spcb=FALSE) and (nat=FALSE) then
      mriteln('');
    if ((cond>11) and (cond<16)) or ((cond>26) and (cond<35)) or (cond>40) then
      nat := TRUE;
    if (which<0) and ((cond=16) or (cond=19) or (cond=20) or (cond=21)) then
      one := 1;

    if ((cond<>13) and (cond<>16) and (cond<>20) and (cond<>100) and (cond<>19) and (cond<>21) and
        (cond<>31) and (cond<>12) and (cond<>28) and (nat=FALSE)) then
      mriteln ('One Moment...');

    if (cond=16) or (cond=19) then
      mriteln ('Sending message...');
    if (cond=20) or (cond=21) then
      mriteln ('Talking...');
    if (cond=12) or (cond=28) then
      mriteln ('The guards approach thee...');
    if cond=13 then
      mriteln ('Thou are locked in a dismal cell...');
    if (cond<>100) and (nat=FALSE) then
      begin
        WORD:=DPATH;
        INSERT(' ',WORD,((Ord(WORD[0]))+1));
        WORD[ord(WORD[0])]:=USERS[ONE,1][1];

        assign(victumEventsFile,word);
        {$I-}
        append(victumEventsFile);
        {$I+}
        if ioresult <> 0 then
          begin
            { write out to log that file WORD was not found! }
            rewrite(victumEventsFile);
          end;
      end;

     If COND=1 then Begin
        Writeln(eventsFile);
        RANDOM:=(DRANDOM Div 2) Mod 4+1;
        If RANDOM>2 then Begin
          Write (victumEventsFile,'Someone Wearing some ');
          Write (eventsFile,'Someone Wearing some ');
          If RANDOM=3 then Write (victumEventsFile,USERS[TWO,6]);
          If RANDOM=3 then Write (eventsFile,USERS[TWO,6]);
          If RANDOM=4 then Write (victumEventsFile,USERS[TWO,7]);
          If RANDOM=4 then Write (eventsFile,USERS[TWO,7])
         End;
         If RANDOM<3 then Begin
          If RANDOM=1 then Begin
            If USERS[TWO,4][1]='E' then Write (victumEventsFile,'Someone wearing an ');
            If USERS[TWO,4][1]='E' then Write (eventsFile,'Someone wearing an ');
            If USERS[TWO,4][1]<>'E' then Write (victumEventsFile,'Someone wearing a ');
            If USERS[TWO,4][1]<>'E' then Write (eventsFile,'Someone wearing a ');
            Write (victumEventsFile,USERS[TWO,4]);
            Write (eventsFile,USERS[TWO,4])
           End;
           If RANDOM=2 then Begin
            If USERS[TWO,5][1]='E' then Write (victumEventsFile,'Someone wearing an ');
            If USERS[TWO,5][1]='E' then Write (eventsFile,'Someone wearing an ');
            If USERS[TWO,5][1]<>'E' then Write (victumEventsFile,'Someone wearing a ');
            If USERS[TWO,5][1]<>'E' then Write (eventsFile,'Someone wearing a ');
            Write (victumEventsFile,USERS[TWO,5]);
            Write (eventsFile,USERS[TWO,5])
           End
          End
          End;
          If COND=1 then Begin
            Writeln (victumEventsFile,' stole ',STEALER,' gp(s) from thee!');
            Writeln (eventsFile,' stole ',STEALER,' gp(s) from ',USERS[ONE,3],'!')
           End;
          If COND=2 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' tried to steal from thee!');
            Writeln (eventsFile,USERS[TWO,3],' tried to steal from ',USERS[ONE,3],'!')
           End;
          If COND=3 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' tried to read thy mind!');
            Writeln (eventsFile,USERS[TWO,3],' tried to read ',USERS[ONE,3],'''S Mind.')
           End;
          If COND=4 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' hired a wizard to curse thee!!');
            Writeln (eventsFile,USERS[ONE,3],' hast been cursed by ',USERS[TWO,3],'!!')
           End;
          If COND=5 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' tried to curse thee!');
            Writeln (eventsFile,USERS[TWO,3],' tried to curse ',USERS[ONE,3],'!')
           End;
          If COND=6 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' went broke gambling at the ',WORDS,' Casino!')
           End;
          If COND=7 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' caused ',USERS[ONE,3],' to go broke!!!!')
           End;
          If COND=8 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' examined thee.')
           End;
          If COND=9 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' paid thy bail!');
            Writeln (eventsFile,USERS[TWO,3],' paid ',USERS[ONE,3],'''S bail!')
           End;
          If COND=10 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' tried to help thee escape from jail!!');
            Writeln (eventsFile,USERS[TWO,3],' tried to help ',USERS[ONE,3],' escape from jail!!')
           End;
          If COND=11 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' successfully helped thee escape jail!!');
            Writeln (eventsFile,USERS[TWO,3],' successfully helped ',USERS[ONE,3],' escape from jail!!')
           End;
          If COND=12 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' tried to steal from the ',WORDS,' Inn!')
           End;
          If COND=13 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' went to jail for ',USERI[NUM,7],' day(s)!')
           End;
          If COND=14 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' stole from the ',WORDS,' Inn ',STEALER,' time(s)!')
           End;
          If COND=15 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' escaped from some guards!')
           End;
          If COND=16 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' told thee from jail, "',TOLD,'".')
           End;
          If COND=17 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' tried to escape from some guards!')
           End;
          If COND=18 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' paid bail!')
           End;
          If COND=19 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' told thee telepathically, "',TOLD,'".')
           End;
          If COND=20 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' told thee, "',TOLD,'".')
           End;
          If COND=21 then Begin
            Writeln(eventsFile);
            Writeln (eventsFile,USERS[TWO,3],' said, "',TOLD,'".')
           End;
          If COND=22 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' gave thee ',WORDS,' Gold Piece(s)!')
           End;
          If COND=23 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' bought thee a glass of ',WORDS,'!')
           End;
          If COND=24 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' tried to steal a copy of the Bank Books!')
           End;
          If COND=25 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' stole a copy of the Bank Books!')
           End;
          If COND=26 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' bought thee a ',WORDS,'!')
           End;
          If COND=27 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' stole from the ',WORDS,' Tavern ',STEALER,' time(s)!')
           End;
          If COND=28 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' tried to steal from the ',WORDS,' Tavern!')
           End;
          If COND=29 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' robbed ',STEALER,' gps from the ',WORDS,' bank!!!!!!!!!!!!!!')
           End;
          If COND=30 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' tried to rob the ',WORDS,' Bank!!')
           End;
          If COND=31 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' was kicked out of the Guild - Due to Inactivity!')
           End;
          If COND=32 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' stole from the ',WORDS,' Shoppe!')
           End;
          If COND=33 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' tried to steal from the ',WORDS,' Shoppe!')
           End;
          If COND=34 then Begin
            Writeln(eventsFile);
            Write(eventsFile,USERS[TWO,3],' was killed by ');
            If (C_MONSTER<>0) and (WORDS[1]<>'e') then Write(eventsFile,'a ');
            If WORDS[1]='e' then Write(eventsFile,'the ');
            Writeln(eventsFile,WORDS,'!!!!!!')
           End;
          If COND=35 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' transported locations with thee!!!!!!')
           End;
          If COND=36 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' crushed thy mind protection!!!!!');
            Writeln (eventsFile,USERS[TWO,3],' crushed ',USERS[ONE,3],'''S mind protection!!!')
           End;
          If COND=37 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' casted a sleep spell on thee!!!!')
           End;
          If COND=38 then Begin
            Writeln (victumEventsFile,USERS[TWO,3],' tried to cast a sleep spell on thee!!')
           End;
          If COND=39 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' summoned the gaze of Balor upon thee!!!!!!!!!!!');
            Writeln (victumEventsFile,'1/8 of thy Score, 1/4 of thy Skill, and thy life force -- DRAINED!!');
            Writeln (eventsFile,USERS[TWO,3],' summoned the Gaze of Balor on ',USERS[ONE,3],'!!!!!!!')
           End;
          If COND=40 then Begin
            Writeln(eventsFile);
            Writeln (victumEventsFile,USERS[TWO,3],' tried to summon the gaze of Balor upon thee!!!!');
            Writeln (eventsFile,USERS[TWO,3],' tried to summon the gaze of Balor on ',USERS[ONE,3],'!!!!')
           End;
          If COND=41 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' was lost at sea!!')
           End;
          If COND=42 then Begin
            Writeln(eventsFile);
            Write(eventsFile,USERS[TWO,3],' killed ');
            If WORDS[1]<>'e' then Writeln(eventsFile,'a ',WORDS,'!!!!');
            If WORDS[1]='e'  then Writeln(eventsFile,'the ',WORDS,'!!!!!!!!!!')
           End;
          If COND=43 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],'''S horse, "',WORDS,'", was killed!!!!')
           End;
          If COND=44 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' joined The Guild!')
           End;
          If COND=45 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' enters the Realm.')
           End;
          If COND=46 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' was caught pick-pocketing!!!!')
           End;
          If COND=47 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' stepped through the portal!!!!!!!!!!!!!');
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' wins the game!!!!!  GAME RESET!!!!!!!!!!!');
            Writeln(eventsFile);
            Writeln(eventsFile,'CONGRATULATIONS TO ',USERS[TWO,3],'!!!!!!')
           End;
          If COND=48 then Begin
            Writeln(eventsFile);
            Writeln(eventsFile,USERS[TWO,3],' bought a horse named "',WORDS,'".')
           End;

    if (cond<50) and (nat=False) then
      begin
        close(victumEventsFile);
      end;

  end; { Estuff - write out events to player and events file }





  Procedure GOODBYE(NUM:Integer;Var SINGLE:Integer;Var OVER:Boolean);
    Var
      V,COND,CO,COUNT:Integer;
      SAVED,noDie:Boolean;
      NAMED:str80;
      mongo : integer;

    Begin
      noDie := FALSE;
      SAVED:=False;
      If (DEATH<>'') and (WON=False) then Begin
        EM_SEND(300);
        If CHEAT4<>203 then Repeat Until False;
        Mriteln('');
        flash := TRUE; bcolor(magenta); tcolor(white);
        Mrite('Thou hast been Killed!!!!!!!!!!!!!');
        flash := FALSE; bcolor(black); tcolor(white);
        Mriteln('');
        Mriteln('');
        Mriteln('As thy final breath draws near, thou mayst pray to one God.');
        Mriteln('Only one will save thee...');
        Mriteln('');
        tcolor(cyan); Mriteln('[S]olnar, Keeper of the Flame.'); tcolor(white);
        tcolor(green); Mriteln('[C]athra, Goddess of Light.'); tcolor(white);
        tcolor(red); Mriteln('[B]alor, Lord of Darkness.'); tcolor(white);
        Mriteln('');
        tcolor(yellow); Mrite('Ask which God for salvation? '); tcolor(white);
       Repeat
        SOMETHING(NAMED)
       Until (NAMED='S') or (NAMED='C') or (NAMED='B') or (NAMED='`');
       if named='`' then
         begin
           named := 'S';
           noDie := TRUE;
         end;
       Mriteln(NAMED);CO:=DRANDOM mod 3+1;Mriteln(''); if noDie then CO:=2;
       If NAMED='S' then
         begin
           tcolor(cyan);
           Mrite('Solnar');
           tcolor(white);
         end;
       If NAMED='C' then
         begin
           tcolor(green);
           Mrite('Cathra');
           tcolor(white);
         end;
       If NAMED='B' then
         begin
           tcolor(red);
           Mrite('Balor');
           tcolor(white);
         end;
       If CO=2 then Begin
         Mriteln(' breathes life into thee!!!!!!!!!!!!');
         DEATH:='';OVER:=False;
         SAVED:=True;
         USERI[NUM,20]:=10;
         useri[num,10]:=useri[num,10]+10; { not hungry  }
         useri[num,11]:=useri[num,11]+20; { not thirsty }
         useri[num,12]:=useri[num,12]+10; { not tired   }
         useri[num,26]:=0;  { no longer poisoned }
        End;
       If CO<>2 then
         Begin
           Mriteln(' laughs in thy pitiful Face!!!!!');
           Mriteln('');
           Mriteln('Darkness surrounds, thy journey to the Astral Plane begins...');
           Mriteln('');
           Mriteln('Fare thee well...');
           OVER:=True;COND:=34;ESTUFF(NUM,NUM,DEATH,COND)
         End;
       End;
    If (SAVED=False) and (DEATH='') and (WON=False) then Begin
      V:=NUM;COND:=31;
      If USERI[NUM,4] > 1 then NUM:=SINGLE;
      If USERI[V,4] < 1 then OVER:=True;
        If SPCB then ESTUFF(NUM,NUM,NAMED,COND);
        NAMED:=USERS[NUM,3]
     End;
    If (SAVED=False) or (WON=True) then Begin
        If (WON=True) or (SPCB=True) then USERS[NUM,2]:='EMPTY';
        USERI[NUM,2]:=0;USERI[NUM,22]:=0;USERI[NUM,23]:=0;USERI[NUM,24]:=0;
        USERI[NUM,3]:=25;USERI[NUM,25]:=0;USERI[NUM,26]:=0;USERI[NUM,27]:=0;
        USERI[NUM,4]:=250;USERI[NUM,28]:=0;USERI[NUM,29]:=0;USERI[NUM,30]:=0;
        USERI[NUM,5]:=0;USERI[NUM,31]:=0;USERI[NUM,32]:=0;USERI[NUM,33]:=0;
        USERI[NUM,6]:=24;USERI[NUM,34]:=0;USERI[NUM,35]:=0;USERI[NUM,36]:=0;
        USERI[NUM,7]:=0;USERI[NUM,37]:=0;
        USERI[NUM,8]:=0;
        USERS[NUM,3]:='EMPTY';
        RAND_APPAREL(1);USERS[NUM,4]:=RANDCLOTH;
        RAND_APPAREL(2);USERS[NUM,5]:=RANDCLOTH;
        RAND_APPAREL(3);USERS[NUM,6]:=RANDCLOTH;
        RAND_APPAREL(4);USERS[NUM,7]:=RANDCLOTH;
        USERS[NUM,9]:='NONE';
        USERS[NUM,8]:='NONE';
        USERI[NUM,14]:=1;
        USERI[NUM,15]:=3;
        USERI[NUM,9]:=5;
        USERI[NUM,10]:=25;
        USERI[NUM,11]:=25;
        USERI[NUM,12]:=25;
        USERI[NUM,13]:=0;
        USERI[NUM,16]:=0;USERI[NUM,21]:=15;
        USERI[NUM,17]:=0;USERI[NUM,19]:=0;
        USERI[NUM,18]:=0;USERI[NUM,20]:=15;
        USERI[NUM,37]:=5000;
        for mongo := 38 to 45 do
          useri[num,mongo] := 0;
       End;
      If (OVER=True) and (SPCB=False) and (SAVED=False) and (DEATH='') and (WON=False) then Begin
          Mriteln(''); tcolor(red); Mriteln ('Thou art $$$ BROKE $$$'); tcolor(white);
          Mriteln('');Mriteln ('Thou art not worthy of being a member of the Thieves'' Guild!');
          Mriteln('');Mriteln ('Thou hast been removed from the Scrolls!');
          Mriteln('');Mriteln ('Fare thee well...')
        End;
      If (OVER=False) and (SPCB=False) and (SAVED=False) and (WON=False) then Begin
          Mriteln('');
          Mrite ('Thou hast caused ');
          tcolor(yellow);
          Mrite (NAMED);
          tcolor(white);
          Mriteln(' to go broke!');
          Mriteln('');Mrite (NAMED);
          Mriteln(' hast been removed from the scrolls!');
          USERI[V,5]:=USERI[V,5]+1500;
          Mriteln('');
        End;
      If ((SAVED=True) or (DEATH<>'')) and (WON=False) then STOP
    End;


procedure SysopMessage;

  var
    ff : text;
    st : string[80];

  begin
    assign(ff,'SYSOPMSG.TXT');
    {$I-}
    reset(ff);
    {$I+}
    if ioresult = 0 then
      begin
        while not (eof(ff)) do
          begin
            readln(ff,st);
            mriteln(st);
          end;
        close(ff);
      end;
  end;


begin
end.