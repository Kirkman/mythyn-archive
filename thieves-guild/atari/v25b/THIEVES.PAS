Program THIEVES_GUILD;
 {$I auxsubs.pas}
  TYPE
    Str255=String[80];
    ENCTYPE=String[185];
    FIXEDONE=String[160];
    I=Array[1..26,1..37] of Long_Integer;
    S=Array[1..26,1..9] of String[40];
    TI=Array[1..25,1..19] of Integer;
    TS=Array[1..25,1..14] of Str255;
    AD=Array[1..30] of String[10];
    MO=Array[1..42] of String[12];
    WE=Array[1..21,1..2] of String[13];
    SY=Array[1..8] of String[80];
  VAR
    USERI:I;
    USERS:S;
    TOWNI:TI;
    TOWNS:TS;
    ADJECTIVE:AD;
    MONSTER:MO;
    WEAPON:WE;
    S_STUFF:SY;
    CHEAT1:Byte;
    GMMSG,DEATH,TELLME,DAYS,DAYSS,LOP,LOS,DPATH,TPATH,MASTERS,MONTH,CMONTH,BBS,BBSNAME,BN2,DREAM,RIDDLES,
    LOY,FORST,RANDCLOTH,AB_WOR:Str255;
    CHEAT5:Byte;
    BSTEAL:String[40];
    CHEAT2:Byte;
    NUMTOT,NUMTOTO,LN1,LN1O,LN2,LN2O,LN3,LN3O:ENCTYPE;
    BDATE:String[10];
    CHEAT3:Byte;
    F_FIRST,F_SECOND,F_THIRD,F_FOURTH:Text;
    CHEAT6,CHEAT7:Byte;
    NUM,DAY,CAR,GM,RCOUNT,JDFH,NUNUM,C_MONSTER,C_ADJECTIVE,ELEMENT,HULL,WIND,SYSOPM,TAVSTEAL,XXX:Integer;
    SUN,LDATE,COMP1,COMP2,PEOPLES,PROG,COMPTEST,DUES,PIRCHECK,STEALER:Long_Integer;
    GT,GTT,OVER,VT,UJAILL,SPCB,TOFF,SOFF,ABLE,TKILL,ISITOK,EMULATE,VIEWOK,MULT,TWISTY,LOCK,KEY,WATERS,
    HORN,FAIRY,LUCK,JOINED,MYSTIC,HALF,WON,PYRA,A_CRYPT,BOOGIE,DTREAS,OCE,WIZPOT,MAINP,MITCH,DOUBCHECK:Boolean;
    CHEAT4:Byte;
(**** DATE GET ************************************************************)
  Function GETDATE:Integer;
    GEMDOS($2a);
(**** TIME GET ************************************************************)
  Function Gettime:Long_Integer;
    GEMDOS($2c);
(**** MODEM - CHARACTER INPUT *********************************************)
  Function bconin(device:Integer):Integer;
    BIOS(2);
(**** RANDOM GENERATOR ****************************************************)
  Function DRANDOM:Long_Integer;
    XBIOS(17);
(**************************************************************************)
Function Dayz(Mo, Yr: Long_Integer): Long_Integer;
Begin
	If Mo=2 Then Begin
		If (Yr Mod 4) = 0 Then Dayz := 29 Else Dayz := 28 End
	Else
		Dayz := 30 + ((Mo + (Mo Div 8)) Mod 2)
End;
(**************************************************************************)
Function Since(Mo,Yr: Long_Integer): Long_Integer;
Begin
	If Mo=1 Then Since := 0 Else Since:=Since(Mo-1,Yr)+Dayz(Mo-1,Yr)
End;
(**************************************************************************)
Function Da_te(Yr,Mo,Dy: Long_Integer): Long_Integer;
Begin
	Da_te := (Yr*365) + (Yr Div 4) + Since(Mo,Yr) + Dy
End;
(**** CHANGE STRING TO NUMBER *********************************************)
  Procedure BUGPROOF(FIRST:Str255;Var NUMBER:Integer);
    Var
      A,B,SECOND:Integer;
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
(******MAKE UPPER CASE*****************************************************)
  Procedure UPCASE(var LITTLE:Str255);
    Var
      COUNT,COUNTLA:Integer;
    Begin
      COUNTLA:=ord(LITTLE[0]);
      If COUNTLA>80 then COUNTLA:=80;
      For COUNT:=1 to COUNTLA do
        If (ord(LITTLE[COUNT]) > 96) and (ord(LITTLE[COUNT]) < 123) then
           LITTLE[COUNT]:=chr(ord(LITTLE[COUNT])-32)
    END;
(**************************************************************************)
 Procedure bconout(device,H:Integer);
   BIOS(3);
(**************************************************************************)
 Function bconstat(device:Integer):Boolean;
   BIOS(1);
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
(**************************************************************************)
  Function ENCNUM(KEY:Integer;PER:Integer;DO1:Boolean):Integer;
    Begin
     If DO1=True then ENCNUM:=PER+KEY;
     If DO1=False then ENCNUM:=PER-KEY;
     End;
(**************************************************************************)
 Procedure DECRYPT(Var TIKIHEAD:ENCTYPE;TIKITOES:ENCTYPE;MONGO:Byte);
  Var
    VCOUNT,SWING,COUNT,CGH:Integer;
  Begin
   If MONGO=87 then CHEAT1:=47;
   If ord(TIKIHEAD[0])>8 then Begin
      CGH:=0;
      For CGH:=1 to ord(TIKIHEAD[0]) do
        PIRCHECK:=PIRCHECK+ord(TIKIHEAD[CGH]);
      CGH:=0;
      For CGH:=1 to ord(TIKITOES[0]) do
        PIRCHECK:=PIRCHECK+ord(TIKITOES[CGH]);
    End;
   If MONGO=47 then CHEAT2:=97;
    COUNT:=1;VCOUNT:=0;SWING:=1;
   If MONGO=101 then CHEAT4:=203;
    For VCOUNT:=1 to ord(TIKIHEAD[0]) do Begin
       If COUNT=XXX then Begin
         COUNT:=1;SWING:=SWING*(-1);
        End;
       COUNT:=COUNT+1;
       If (TIKIHEAD[VCOUNT]<>'|') and (TIKITOES[VCOUNT]<>'~') and
          (TIKITOES[VCOUNT]<>'`') then Begin
          If (TIKITOES[VCOUNT]=' ') and (MITCH) then
            TIKIHEAD[VCOUNT]:=Chr(ord(TIKIHEAD[VCOUNT])-(COUNT*SWING))
           Else if MITCH then TIKIHEAD[VCOUNT]:=TIKITOES[VCOUNT]
         End
       Else Begin
         If (TIKIHEAD[VCOUNT]='|') and (MITCH) then TIKIHEAD[VCOUNT]:=' ';
         If (TIKITOES[VCOUNT]='~') and (MITCH) then TIKIHEAD[VCOUNT]:=Chr(13);
         If (TIKITOES[VCOUNT]='`') and (MITCH) then TIKIHEAD[VCOUNT]:=Chr(10)
        End;
      End;
    If MONGO=97 then CHEAT3:=101
   End;
(**************************************************************************)
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
  Procedure SAVEINFO(OVER:Boolean);
    Var
      N,SN,D,SD,A,B:Integer;
      TEMP:Str255;
      NAME:Text;
    Begin
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
      Rewrite (NAME,TEMP);
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
       Until N=26;
       Writeln(NAME,DUES);
       Writeln(NAME,DREAM);
       Writeln(NAME,PROG);Writeln(NAME,BSTEAL);Writeln(NAME,BDATE);
       If GMMSG<>'' then Writeln(NAME,GMMSG)
      End;
(**************************************************************************)
  Procedure RE;
    Begin
      Rename(F_FOURTH,F_THIRD);
      Close(F_THIRD);
    End;
(***** Check for loss of Carrier - Kill if so *****************************)
 Procedure CARRIER;
   Var
     T,TY,KL:Integer;
     TEMPO:Text;
     DUMB:Str255;
   Begin
    If CAR=1 then Begin
     TY:=100;
     Super(True);
     T:=PEEK($FFFA01);
     If (Clock-COMP1=150) and (COMPTEST<>COMP1) then begin
       COMPTEST:=COMP1;DUMB:='Time-out in 30 seconds if key not pressed.';
       bconout(Car,13);bconout(Car,10);
       For KL:=1 to 42 do Begin
         bconout(Car,ord(DUMB[KL]));
        End;
       bconout(Car,13);bconout(Car,10)
      End;
     If Clock-COMP1>180 then begin
       DUMB:='3 Minute timeout!  Thanks for Playing!!';
       bconout(Car,13);bconout(Car,10);
       For KL:=1 to 39 do Begin
         bconout(Car,ord(DUMB[KL]));
         TKILL:=True
        End;
       bconout(Car,13);bconout(Car,10)
      End;
     If (T&2<>0) or (TKILL) then Begin
       OVER:=True;CAR:=2;
       Write(Chr(27),'b3',Chr(27),'c4');
       If (TKILL=True) and (EMULATE) then Begin
          bconout(1,18);bconout(1,51);bconout(1,48);bconout(1,48);bconout(1,20);
          bconout(1,18);bconout(1,48);bconout(1,20)
         End;
       If TKILL=True then Writeln('TIME-OUT LOGOFF');
       If TKILL=False then Writeln('LOSS OF CARRIER -- PROGRAM TERMINATED!');
     If ISITOK=True then Begin
       SAVEINFO(OVER);
       RE
      End;
        HALT;
      End
    End
   End;
(**************************************************************************)
Function CONVERT(AMON:Integer):Integer;
  Begin
    If AMON<6 then CONVERT:=AMON;
    If (AMON=6) or (AMON=7) then CONVERT:=6;
    If (AMON>7) and (AMON<11) then CONVERT:=7;
    If (AMON>10) and (AMON<16) then CONVERT:=8;
    If (AMON>15) and (AMON<19) then CONVERT:=9;
    If (AMON=19) then CONVERT:=10;
    If (AMON=20) or (AMON=21) then CONVERT:=11;
    If (AMON>21) and (AMON<25) then CONVERT:=12;
    If (AMON=25) or (AMON=26) then CONVERT:=13;
    If (AMON>26) and (AMON<31) then CONVERT:=14;
    If (AMON>30) and (AMON<37) then CONVERT:=15;
    Case AMON of
      37:CONVERT:=16;
      38:CONVERT:=17;
      39:CONVERT:=18;
      40:CONVERT:=19;
      41:CONVERT:=20;
      42:CONVERT:=21
     End; {Case}
  End;
(**************************************************************************)
Function Pow(Num: Long_Integer): Long_Integer;
  Begin
	If Num = 0 Then Pow := 1 Else Pow := 10 * Pow(Num - 1)
  End;
Function Fig (Num: Long_Integer;Dg: Long_Integer): Long_Integer;
  Begin
       Fig:=(Num Div Pow(Dg)) mod 10
  End;
Function Len(Num: Long_Integer): Long_Integer;
  Begin
        If Num < 10 Then Len := 0 Else Len := Len(Num Div 10) + 1;
  End;
Procedure Send_Num(Num: Long_Integer);
Var A: Long_Integer;
Begin
        For A := Len(Num) Downto 0 do Begin
                If (CAR=1) and (SOFF=False) then Bconout(1,Fig(Num,A)+48);
                If (SOFF=False) and (TOFF=False) then Bconout(2,Fig(Num,A)+48)
              End
End;
(**************************************************************************)
  Procedure AB_WO;
    Var
      ABRAN:Integer;
    Begin
      ABRAN:=(DRANDOM mod 8)+1;
      Case ABRAN of
        1:AB_WOR:='*ZAP*';2:AB_WOR:='*POW*';3:AB_WOR:='*SNIP*';4:AB_WOR:='*ZIP*';
        5:AB_WOR:='*BOOM*';6:AB_WOR:='*CLIP*';7:AB_WOR:='*BLAM*';8:AB_WOR:='*POOF*'
       End
     End;
(**************************************************************************)
  Procedure Mriteln(INFO:FIXEDONE);
    Var
      CC,KAT,OURS:Integer;
      KERI:Str255;
      DONES:Boolean;
    Begin
     If SOFF=False then Begin
      CC:=0;
    (* VT52 Filter *)
      For CC:=1 to ord(INFO[0]) do Begin
      If VT=False then Begin
       Repeat
        If ord(INFO[CC])=27 then Begin
           CC:=CC+1;
           If (INFO[CC]='b') or (INFO[CC]='c') then CC:=CC+1;
           CC:=CC+1
          End;
       Until ord(INFO[CC])<>27;
      End;
    (* End *)
       If SOFF=False then Begin
        COMP1:=Clock;
        CARRIER;
        If bconstat(CAR) then Begin
          OURS:=bconin(CAR);
          If OURS=19 then Begin
            DONES:=False;COMP1:=Clock;
            Repeat
              CARRIER;
              If bconstat(CAR) then
                If bconin(CAR)=17 then DONES:=True
            Until ((Clock-COMP1)>30) or (DONES=True);
           End;
          If OURS=3 then Begin
          If ABLE=True then Mriteln('');AB_WO;
          If ABLE=True then Mriteln(AB_WOR);
          If ABLE=True then SOFF:=True;
         End
        End;
        If bconstat(2) then Begin
         KAT:=bconin(2);KERI:=' ';
          KERI[1]:=Chr(KAT);
          If (KERI[1]>'0') and (KERI[1]<'9') then Begin
          BUGPROOF(KERI,SYSOPM);
          Writeln(Chr(27),'b2 ',KERI,Chr(27),'b1 Registered!',Chr(27),'b3');
          End;
         End;
        If CC<=ord(INFO[0]) then Begin
          If (CAR=1) and (SOFF=False) then bconout(1,ord(INFO[CC]));
          If (TOFF=False) and (SOFF=False) then bconout(2,ord(INFO[CC]))
        End;
       End
      End;
      If (CAR=1) and (SOFF=False) then bconout(1,13);If (CAR=1) and (SOFF=False)
        then bconout(1,10);
      If (TOFF=False) and (SOFF=False) then bconout(2,13);If (TOFF=False) and (SOFF=False)
        then bconout(2,10);
     End;
    End;
(**************************************************************************)
  Procedure Mrite(INFO:Str255);
    Var
      CC,OURS:Integer;
      DONES:Boolean;
    Begin
      CC:=0;
      For CC:=1 to ord(INFO[0]) do Begin
       If SOFF=False then Begin
        If TWISTY=False then COMP1:=Clock;
        CARRIER;
        If (bconstat(CAR)) and (TWISTY=False) then Begin
          OURS:=bconin(CAR);
          If OURS=19 then Begin
            DONES:=False;COMP1:=Clock;
            Repeat
              CARRIER;
              If bconstat(CAR) then
                If bconin(CAR)=17 then DONES:=True
            Until ((Clock-COMP1)>30) or (DONES=True);
           End;
         If OURS=3 then Begin
          If (ABLE=True) then Mriteln('');
          If (ABLE=True) and (VT=True) then bconout(1,27);
          If (ABLE=True) and (VT=True) then bconout(2,27);
          If (ABLE=True) and (VT=True) then Mrite('b3');
          AB_WO;
          If ABLE then Mriteln(AB_WOR);
          If ABLE=True then SOFF:=True;
         End
        End;
        If (CAR=1) and (SOFF=False) then bconout(1,ord(INFO[CC]));
        If (TOFF=False) and (SOFF=False) then bconout(2,ord(INFO[CC]))
       End
      End;
    End;
(***** Top Window *********************************************************)
  Procedure TWIN;
    Var
      KOUNT,KOUT:Integer;
    Begin
      If (NUM>0) and (CAR<>2) then Begin
        KOUT:=1;
        If USERI[NUM,6]>9 then KOUT:=2;
        Write(Chr(27),'b4',Chr(27),'c1');
        Write(Chr(27),'j',Chr(27),'H');
        Write('Name: ',USERS[NUM,2],' Thief: ');
        Write(USERS[NUM,3],' Time Left: ',USERI[NUM,6],' Hour(s).');
        KOUNT:=0;
        For KOUNT:=1 to (80-(35+ord(USERS[NUM,2][0])+ord(USERS[NUM,3][0])+KOUT)) do Write(' ');
        Write(Chr(27),'k',Chr(27),'b3',Chr(27),'c4');
      End;
    End;
(**************************************************************************)
  Procedure CH_COL(NCTP:Integer);
    Begin
      If (VT) and (MAINP) then Begin
        If CAR=1 then bconout(1,27);
        bconout(2,27);
        If CAR=1 then bconout(1,98);
        bconout(2,98);
        If NCTP=1 then Begin
          If CAR=1 then bconout(1,50);
          bconout(2,50)
         End;
        If NCTP=2 then Begin
          If CAR=1 then bconout(1,49);
          bconout(2,49)
         End;
        If NCTP=3 then Begin
          If CAR=1 then bconout(1,51);
          bconout(2,51)
         End;
       End;
     End;
(***** Special Meadln Routine *********************************************)
  Procedure MEADLN(Var THEDTUFF:Str255);
    Var
      SHEDTUFF:Str255;
      LAST:Char;
      J,D,T,TY,COUNTY,DUMBBB:Integer;
      COUNTYS:Long_Integer;
      DONT,DEL:Boolean;
    Begin
      J:=0;D:=0;T:=1;THEDTUFF:='';SHEDTUFF:='';LAST:=' ';TY:=50;COMP1:=Clock;COUNTY:=0;COUNTYS:=0;DEL:=False;
      TWIN;COUNTYS:=Clock;
      Repeat
        DONT:=False;
        CARRIER;
          If (TWISTY=True) and (COUNTYS<>Clock) then Begin
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('f');
          COUNTY:=COUNTY+1;
          If DEL=True then Mrite(Chr(8));
          DEL:=True;
          Case COUNTY of
           1:Begin
             CH_COL(1);If CAR=1 then bconout(1,124);
             bconout(2,124)
            End;
           2:Begin
             CH_COL(2);If CAR=1 then bconout(1,47);
             bconout(2,47)
            End;
           3:Begin
             CH_COL(1);If CAR=1 then bconout(1,45);
             bconout(2,45)
            End;
           4:Begin
             CH_COL(2);If CAR=1 then bconout(1,92);
             bconout(2,92)
            End;
          End;
          If COUNTY=4 then COUNTY:=0;COUNTYS:=Clock;
         End;
        If (bconstat(CAR)) or ((bconstat(2)) and (TOFF=False)) then Begin
          If (VT=True) and (CAR=1) then bconout(1,27);
          If (VT=True) and (CAR=1) then bconout(1,101);
          bconout(2,27);bconout(2,101);
          TWISTY:=False;
          If bconstat(CAR) then LAST:=Chr(bconin(CAR));COMP1:=Clock;
          If (bconstat(2)) and (TOFF=False) then LAST:=Chr(bconin(2));
          If (bconstat(2)) and (TOFF=True) then DUMBBB:=bconin(2);
          If DEL=True then Mrite(Chr(8));DEL:=False;
         If ((ord(LAST)>31) and (ord(LAST)<127)) or (ord(LAST)=13) or (ord(LAST)=8) then Begin
          If ord(LAST)=8 then Begin
            If ord(SHEDTUFF[J])<>0 then Begin
            If TOFF=False then bconout(2,ord(LAST));
            If TOFF=False then bconout(2,ord(32));
            If TOFF=False then bconout(2,ord(LAST));
            If CAR=1 then bconout(1,ord(LAST));
            If CAR=1 then bconout(1,ord(32));
            If CAR=1 then bconout(1,ord(LAST));
              D:=J;
              J:=J-1;
              DELETE(SHEDTUFF,D,T)
             End
           End;
          If (ord(LAST)<>8) then J:=J+1;
          If ord(LAST)<>8 then INSERT(LAST,SHEDTUFF,J);
          If ord(LAST)=8 then DONT:=True;
          If (DONT=False) and (CAR=1) and (ord(LAST)<>13) then bconout(1,ord(LAST));
          If (DONT=False) and (TOFF=False) and (ord(LAST)<>13) then Write(LAST)
         End;(*This is the new one*)
        End
      Until (ord(LAST)=13) or (J=80);
      DELETE(SHEDTUFF,J,T);If MAINP then CH_COL(3);
      If CAR=1 then bconout(1,13);If CAR=1 then bconout(1,10);
      If TOFF=False then Writeln;
      THEDTUFF:=SHEDTUFF;
    End;
(*****GET KEY**************************************************************)
  Procedure WHAT(Var WELL:Str255);
   Var
    dummy,event,what_key:integer;
    Key_Wait:Str255;
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
      UPCASE(WELL);
      If (WELL='Y') and ((VT=False) or (HALF=True)) then Mriteln ('Yea!');
      If (WELL='N') and ((VT=False) or (HALF=True)) then Mriteln ('Nay!');
      If (WELL='Y') and (VT=True) and (HALF=False) then Begin
        Mrite (Chr(27));
        Mrite ('b2Yea!');
        Mrite (Chr(27));
        Mriteln('b3')
       End;
      If (WELL='N') and (VT=True) and (HALF=False) then Begin
        Mrite(Chr(27));
        Mrite('b1Nay!');
        Mrite(Chr(27));
        Mriteln('b3')
       End;
    Until(WELL='Y') or (WELL='N')
   End;
(*****GET KEY**************************************************************)
  Procedure BLA(Var PASSW:Str255);
   Var
    dummy,event,what_key,A,B,C,W,DONE:integer;
    Key_Wait,PART,DUMB:Str255;
   Begin
    A:=0;B:=0;W:=1;DONE:=0;COMP1:=Clock;
   Repeat
    If (W=1) and (DONE=1) then Begin
      DONE:=0;
      W:=2
     End;
    If (W=2) and (DONE=1) then Begin
      DONE:=0;
      W:=1
     End;
    DUMB:='';
    A:=A+1;
    dummy:=0;event:=0;what_key:=0;
     Key_wait[0]:=Chr(1);
     Repeat
       CARRIER;
     Until (Bconstat(CAR)) or (Bconstat(2));
     COMP1:=Clock;
     If Bconstat(CAR) then what_key:=bconin(CAR);
     If Bconstat(2) then what_key:=bconin(2);
     Key_wait[1]:=chr(what_key);
      UPCASE(Key_wait);
      If (ord(Key_wait[1])<>13) and (ord(Key_wait[1])<>8) then PASSW[A]:=Key_wait[1];
      If (VT=True) then Begin
        Mrite (Chr(27));
        Mrite ('b');
        Send_Num(W)
       End;
      DONE:=1;
      If (ord(Key_wait[1])<>13) and (ord(Key_wait[1])<>8) then Mrite ('*');
   Until ord(Key_wait[1])=13;
   If (VT=True) then Begin
     Mrite (Chr(27));
     Mrite ('b3')
    End;
   C:=0;
   PASSW[A]:='|';
   PART:=chr(ord(0));
   B:=ord(PASSW[0]);
   B:=B+1;
   Repeat
     B:=B-1;
     If PASSW[B]='|' then C:=1001;
     PASSW[B]:=PART[1];
   Until C=1001;
   end;
(**** GET A CHARACTER *****************************************************)
  Procedure SOMETHING(Var WELL:Str255);
   Var
    dummy,event,what_key:integer;
    Key_Wait:Str255;
   Begin
     TWIN;Key_wait[0]:=Chr(1);COMP1:=Clock;
     Repeat
       CARRIER;
     Until (Bconstat(CAR)) or (Bconstat(2));
     If Bconstat(CAR) then what_key:=bconin(CAR);
     If Bconstat(2) then what_key:=bconin(2);
     Key_wait[1]:=chr(what_key);
     WELL:=Key_Wait;
     UPCASE(WELL)
   end;
(****** GETS A RETURN FROM THE PLAYER - PAUSE *****************************)
  Procedure STOP;
    Var
      QUICK:Str255;
    Begin
      Mriteln('');TWIN;COMP1:=Clock;If EMULATE then VT:=False;QUICK:='A';
      If (VT=False) or (HALF=True) then Mrite ('Press <RETURN> to Continue.');
      If (VT=True) and (HALF=False) then Begin
        Mrite('Press ');
        Mrite(Chr(27));
        Mrite('c1<RETURN>');
        Mrite(Chr(27));
        Mrite('c4 to Continue.')
       End;
      Repeat
        SOMETHING(QUICK)
      Until ord(QUICK[1])=13;If EMULATE then VT:=True;
      Mriteln('')
    End;
(**************************************************************************)
  Procedure MRESET(Var SAMPLE:Text;CHKNA:Str255);
    Var
      TBCKD:Integer;
    Begin
      IO_CHECK(False);
      Reset(SAMPLE,CHKNA);
      TBCKD:=IO_Result;
      If (TBCKD=-33) or (TBCKD=-34) then Begin
        Mrite('File not found: ');
        Mriteln(CHKNA);
        Mriteln('Please Notify SysOp.');
        STOP;HALT
       End;
      IO_CHECK(True)
      End;
(*****GET FILE LOCATIONS REAL QUICK****************************************)
  Procedure LOC;
    Var
      ION:Integer;
      TITLE:Text;
    Begin
      CHEAT5:=237;
      IO_CHECK(False);
      Reset(TITLE,'THIEVES.SET');
      ION:=IO_Result;
      If (ION=-33) or (ION=-34) then Begin
        Mriteln('I could not find the THIEVES.SET file, it should');
        Mriteln('in the same directory the BBS is run from.  Please inform Sysop.');
        STOP;HALT
       End;
      IO_CHECK(True);
      Readln(TITLE,DPATH);
      Readln(TITLE,TPATH);
      Readln(TITLE,LOS);
      Readln(TITLE,LOY);
      Readln(TITLE,LOP);
      Readln(TITLE,MASTERS);
      Readln(TITLE,RIDDLES);
      Readln(TITLE,BBS);
      Readln(TITLE,FORST);
      UPCASE(BBS);
      Close(TITLE);
      (*PASTE HERE*)
XXX:=2;
NUMTOT:='7535:';NUMTOTO:='     ';
CHEAT7:=53;
ln1:='Tcigurgpgb|(QLNW,|vm<|Cgt qppc|@DQ|||Njmpc<|*127+4;0/4445  Pgekqvpcrkmp|%/2';
insert('17|||UwuMr8|Qjchd',ln1,76);

ln1o:='                         b                               ~`                ';
insert('                 ',ln1o,76);

ln2:='Kd|@DQ|lckg|qp|Njmpc|!|gu|pmv|vfg|D@U|{mw|cpg|ql|lqu.|pmvghw|su|cr|YD@U[  *';
insert('62/+043//:2;,||Rjg_uc|rj_pi|wqst|UwuMr|hmt|tcigurgpkli|vfkq|ow_ngvw  ufcpgu',ln2,76);
insert('cpg|rpqbwav |+/|Owvf{l|Qqdvucpg,',ln2,151);

ln2o:='                                                                        ~` ';
insert('                                                                   ~`      ',ln2o,76);
insert('           !                    ',ln2o,151);

ln3:='||||||||||||||||||||||||||||/;1(|K{rjwp|Umhry_tc|(^;/  ||||||||||||||||||||';
insert('|||||||||||||R,Q,|@qv|/374  |||||||||||||||||||||||||||||||||Qpgk.|WR||:223',ln3,76);
insert(';',ln3,151);

ln3o:='                                                     ~`                    ';
insert('                          ~`                                               ',ln3o,76);
insert(' ',ln3o,151);

    End;
(**** No Display STOP *****************************************************)
  Procedure QSTOP;
    Var
      QUICK:Str255;
    Begin
      TWIN;COMP1:=Clock;QUICK:='A';
      Repeat
        SOMETHING(QUICK)
      Until ord(QUICK[1])=13;
      Mriteln('')
    End;
(**** CHECK FOR TIME-OUT AND UPDATE TIME ON-LINE **************************)
  Procedure MAKESURE(Var NUM:Integer;Var SUN:Long_Integer;Var OVER:Boolean);
    Var
      SINGLE:Long_Integer;
      P,Z:Integer;
    Begin
      P:=0;
      Z:=0;
      If NUM<100 then Begin
        If (USERI[NUM,6]<6) then Begin
          Mriteln('');Mriteln ('Dusk Approaches...');
          Mriteln('')
         End
      End;
      If NUM>100 then NUM:=NUM-100;
      SINGLE:=Clock;
      If SINGLE-SUN > 59 then Begin
        Repeat
        While SINGLE-SUN > 59 do Begin
          P:=P+1;
          SUN:=SUN+59
         End;
        Until SINGLE-SUN <= 59;
        SUN:=Clock;
        For Z:=1 to P do USERI[NUM,6]:=USERI[NUM,6]-1
       End;
      {If (USERI[NUM,6]<1) and (NUM=8) then USERI[NUM,6]:=24;}
      If USERI[NUM,6]<=0 then Begin
        USERI[NUM,6]:=0;
        Mriteln('');Mriteln('The Sands of Time have Run Dry!');
        OVER:=True
       End;
    End;
(**************************************************************************)
  Procedure DDISPLAY;
    Var
      A,B,C:Integer;
      D:Long_Integer;
      FNAME,ZNAME:Text;
      TEMP,JUNK:Str255;
      TQO:String[10];
    Begin
     If NUM>0 then
     If USERI[GM,5]<USERI[NUM,5] then GM:=NUM;
     Rewrite (FNAME,LOP);
     Writeln (FNAME);
     Writeln (FNAME,'        ++ List of Guild Members as of ++');
     Writeln(FNAME,'            -> ',DAYSS,' <-');
     Writeln(FNAME);
     Writeln (FNAME,'#  Name                       Skill  Faith  Score');
     Writeln (FNAME,'-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
     A:=0;B:=0;C:=0;D:=-1;
      Repeat
        A:=A+1;
        If (USERS[A,3] <> 'EMPTY') then
         Begin
           Write (FNAME,USERS[A,1],'  ',USERS[A,3]);
           For B:=1 to (28-(ord(USERS[A,3][0]))) do
             Write (FNAME,' ');
           Write (FNAME,USERI[A,3]);
           If USERI[A,3] < 1000 then Write (FNAME,' ');
           If USERI[A,3] < 100 then Write (FNAME,' ');
           If USERI[A,3] < 10 then Write (FNAME,' ');
           Write(FNAME,'   ');
           If USERI[A,19]=0 then Write(FNAME,'   ');
           If USERI[A,19]=5 then Write(FNAME,'[B]');
           If USERI[A,19]=11 then Write(FNAME,'[C]');
           If USERI[A,19]=21 then Write(FNAME,'[S]');
           Write(FNAME,'   ');
           Writeln (FNAME,USERI[A,5])
         End;
      Until A=26;
     Writeln(FNAME);
     Writeln(FNAME,'The Current Guild Master is -->> ',USERS[GM,3],' <<--.');
     If (MONTH<>CMONTH) and (MONTH<>'0') then Begin
       TEMP:=DPATH;
       INSERT('JUNK.DAT',TEMP,((Ord(TEMP[0]))+1));
       Rewrite (FNAME,TEMP);
       MReset(ZNAME,MASTERS);
       While not EOF(ZNAME) do Begin
         Readln(ZNAME,JUNK);
         Writeln(FNAME,JUNK)
        End;
       Write(FNAME,DAYSS,'   ',USERS[GM,3]);
       For B:=1 to (30-(ord(USERS[GM,3][0]))) do
         Write (FNAME,' ');
       Write(FNAME,USERI[GM,5]);
       MReset (FNAME,TEMP);
       Rewrite(ZNAME,MASTERS);
       While not EOF(FNAME) do Begin
         Readln(FNAME,JUNK);
         Writeln(ZNAME,JUNK)
        End
      End
    End;
(**************************************************************************)
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
           If USERI[A,19]=5 then Mrite('[B]');
           If USERI[A,19]=11 then Mrite('[C]');
           If USERI[A,19]=21 then Mrite('[S]');
           Mrite('   ');
           Send_Num(USERI[A,5]);Mriteln('')
         End;
      Until A=26;
      ABLE:=False;SOFF:=False;
     Mriteln('')
    End;
(**************************************************************************)
  Procedure CHSTMSG;
    Var
      OLDNAME,NEWNAME:Text;
      JUNK,TOLD,TEMP:String[80];
      PLACE:Integer;
    Begin
      PLACE:=0;
      Repeat
        JUNK:='N';
       Repeat
        Mriteln('');Mriteln ('What dost thou wish to say to someone when they fail in an');
        Mriteln ('attempt to steal from thee? (80 Char. Maximum)');
        Mrite ('>');
        TWISTY:=True;Meadln (TOLD);
       Until (ord(TOLD[0])>1) and (ord(TOLD[0])<80);
        Mriteln('');Mrite('"');
        Mrite(TOLD);
        Mriteln('"');
        Mrite ('Correct [Y/N] ');
        WHAT(JUNK)
      Until JUNK='Y';
      TEMP:=TPATH;
      INSERT('STEALMSG.DAT',TEMP,((Ord(TEMP[0]))+1));
      MReset(OLDNAME,TEMP);
      TEMP:=TPATH;
      INSERT('NEWMSG.DAT',TEMP,((Ord(TEMP[0]))+1));
      Rewrite(NEWNAME,TEMP);
      For PLACE:=1 to 26 do Begin
         Readln(OLDNAME,JUNK);
         If NUM<>PLACE then Writeln(NEWNAME,JUNK);
         If NUM=PLACE then Writeln(NEWNAME,TOLD)
        End;
      Rename(NEWNAME,OLDNAME)
     End;

(**************************************************************************)
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
           If USERI[A,19]=5 then Mrite('[B]');
           If USERI[A,19]=11 then Mrite('[C]');
           If USERI[A,19]=21 then Mrite('[S]');
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
      WHO:Str255;
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
        If (ord(WHO[1]) <> 13) and (WHATSUP <> NUM) and (WHO <> '?') then Begin
          Mriteln ('Thief does not exist!');
          WHATSUP:=0
        End
      End
     Else Begin
        If ord(WHO[1])=13 then Begin
          WHATSUP:=-1;
          Mriteln ('NOBODY')
       End;
        If (ord(WHO[1]) <> 13) and (WHATSUP <> NUM) and (WHO <> '?') then Begin
          Mriteln ('Thief does not exist!');
          WHATSUP:=0
         End
      End;
    If WHATSUP=NUM then Begin
      Mriteln ('That''s you!!');
      WHATSUP:=0
     End;
    If WHO='?' then Begin
      Mriteln ('LIST THIEVES.');
      WHATSUP:=-2;
      If IS=0 then DISPLAY(UNI);
      If IS=1 then JAILVIEW(NUM,IS)
     End
    End;
(**** EVENTS UPDATES - CONDITIONS *****************************************)
  Procedure ESTUFF(ONE:Integer;TWO:Integer;WORDS:Str255;COND:Integer);
    Var
      RANDOM,WHICH,IS:Integer;
      WORD,TOLD,JUNK,TEMP:Str255;
      INFO:String[160];
      UNI,NAT:Boolean;
    Begin
      UNI:=False;NAT:=False;
      If (COND=16) or (COND=19) or (COND=20) or (COND=21) then Begin
       Repeat
        If COND<>21 then Begin
        Mriteln('');
        Repeat
          JUNK:='';
          Mrite ('Say something to who? [?=List] [Return Aborts]: ');
          IS:=0;
          If WORDS='THEPASS' then UNI:=True;
          ASK(NUM,WHICH,IS,UNI);
          UNI:=False;
          If WHICH > 0 then Begin
            Mrite(USERS[WHICH,3]);
            Mrite(' [Y/N] ');
            WHAT(JUNK);
            ONE:=WHICH
           End;
        Until (WHICH=-1) or (JUNK='Y');
        End;
       If (WHICH=-1) and (COND=19) and (WORDS<>'THEPASS') then Begin
         Mriteln('He says, "Fine!  But thou gettest no refund!"');
         STOP
        End;
       If WHICH=-1 then COND:=100;
       If (WHICH>0) or (COND=21) then Begin
        Repeat
          JUNK:='N';
         Repeat
          Mriteln('');Mriteln ('Enter thy Text, up to 80 char. Maximum...');
          Mrite ('>');
          TWISTY:=True;Meadln (TOLD);
         Until (ord(TOLD[0])>1) and (ord(TOLD[0])<80);
          Mriteln('');Mrite('"');
          Mrite(TOLD);
          Mriteln('"');
          Mrite ('Correct [Y/N] ');
          WHAT(JUNK);
          Mriteln('');
        Until JUNK='Y'
       End;
       Until (JUNK='Y') or (WHICH=-1);
       If WHICH<0 then COND:=100
      End;
       If ((COND>11) and (COND<16)) or ((COND>26) and (COND<35)) or
          ((COND>40) and (COND<49)) then NAT:=True;
      Case COND of
        6,7,17,18,21,24,25:NAT:=True
       End; {Case}
      If (COND=12) or (COND=13) or (COND=21) or (COND=28) then NAT:=False;
      If (SPCB=False) and (NAT=False) then Mriteln('');
      If ((COND>11) and (COND<16)) or ((COND>26) and (COND<35)) or (COND>40) then NAT:=True;
      If (WHICH<0) and ((COND=16) or (COND=19) or (COND=20) or (COND=21)) then ONE:=1;
      If (COND<>13) and (COND<>16) and (COND<>20) and (COND<>100) and (COND<>19) and (COND<>21)
         and (COND<>31) and (COND<>12) and (COND<>28) and (NAT=False) then
         Mriteln ('One Moment...');
      If (COND=16) or (COND=19) then Mriteln ('Sending message...');
      If (COND=20) or (COND=21) then Mriteln ('Talking...');
      If (COND=12) or (COND=28) then Mriteln ('The guards approach thee...');
      If COND=13 then Mriteln ('Thou are locked in a dismal cell...');
     If (COND<>100) and (NAT=False) then Begin
      WORD:='';
      WORD:=DPATH;
      INSERT(' ',WORD,((Ord(WORD[0]))+1));
      WORD[ord(WORD[0])]:=USERS[ONE,1][1];
      MReset (F_FIRST,WORD);
      TEMP:=DPATH;
      INSERT('THIEVES.BAK',TEMP,((Ord(TEMP[0]))+1));
      Rewrite (F_SECOND,TEMP);
      While not EOF(F_FIRST) do Begin
        Readln (F_FIRST,INFO);
        Writeln (F_SECOND,INFO)
       End
     End;
      If COND=1 then Begin
        Writeln(F_FOURTH);
        RANDOM:=(DRANDOM Div 2) Mod 4+1;
        If RANDOM>2 then Begin
          Write (F_SECOND,'Someone Wearing some ');
          Write (F_FOURTH,'Someone Wearing some ');
          If RANDOM=3 then Write (F_SECOND,USERS[TWO,6]);
          If RANDOM=3 then Write (F_FOURTH,USERS[TWO,6]);
          If RANDOM=4 then Write (F_SECOND,USERS[TWO,7]);
          If RANDOM=4 then Write (F_FOURTH,USERS[TWO,7])
         End;
         If RANDOM<3 then Begin
          If RANDOM=1 then Begin
            If USERS[TWO,4][1]='E' then Write (F_SECOND,'Someone wearing an ');
            If USERS[TWO,4][1]='E' then Write (F_FOURTH,'Someone wearing an ');
            If USERS[TWO,4][1]<>'E' then Write (F_SECOND,'Someone wearing a ');
            If USERS[TWO,4][1]<>'E' then Write (F_FOURTH,'Someone wearing a ');
            Write (F_SECOND,USERS[TWO,4]);
            Write (F_FOURTH,USERS[TWO,4])
           End;
           If RANDOM=2 then Begin
            If USERS[TWO,5][1]='E' then Write (F_SECOND,'Someone wearing an ');
            If USERS[TWO,5][1]='E' then Write (F_FOURTH,'Someone wearing an ');
            If USERS[TWO,5][1]<>'E' then Write (F_SECOND,'Someone wearing a ');
            If USERS[TWO,5][1]<>'E' then Write (F_FOURTH,'Someone wearing a ');
            Write (F_SECOND,USERS[TWO,5]);
            Write (F_FOURTH,USERS[TWO,5])
           End
          End
          End;
          If COND=1 then Begin
            Writeln (F_SECOND,' stole ',STEALER,' gp(s) from thee!');
            Writeln (F_FOURTH,' stole ',STEALER,' gp(s) from ',USERS[ONE,3],'!')
           End;
          If COND=2 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' tried to steal from thee!');
            Writeln (F_FOURTH,USERS[TWO,3],' tried to steal from ',USERS[ONE,3],'!')
           End;
          If COND=3 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' tried to read thy mind!');
            Writeln (F_FOURTH,USERS[TWO,3],' tried to read ',USERS[ONE,3],'''S Mind.')
           End;
          If COND=4 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' hired a wizard to curse thee!!');
            Writeln (F_FOURTH,USERS[ONE,3],' hast been cursed by ',USERS[TWO,3],'!!')
           End;
          If COND=5 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' tried to curse thee!');
            Writeln (F_FOURTH,USERS[TWO,3],' tried to curse ',USERS[ONE,3],'!')
           End;
          If COND=6 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' went broke gambling at the ',WORDS,' Casino!')
           End;
          If COND=7 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' caused ',USERS[ONE,3],' to go broke!!!!')
           End;
          If COND=8 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' examined thee.')
           End;
          If COND=9 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' paid thy bail!');
            Writeln (F_FOURTH,USERS[TWO,3],' paid ',USERS[ONE,3],'''S bail!')
           End;
          If COND=10 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' tried to help thee escape from jail!!');
            Writeln (F_FOURTH,USERS[TWO,3],' tried to help ',USERS[ONE,3],' escape from jail!!')
           End;
          If COND=11 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' successfully helped thee escape jail!!');
            Writeln (F_FOURTH,USERS[TWO,3],' successfully helped ',USERS[ONE,3],' escape from jail!!')
           End;
          If COND=12 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' tried to steal from the ',WORDS,' Inn!')
           End;
          If COND=13 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' went to jail for ',USERI[NUM,7],' day(s)!')
           End;
          If COND=14 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' stole from the ',WORDS,' Inn ',STEALER,' time(s)!')
           End;
          If COND=15 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' escaped from some guards!')
           End;
          If COND=16 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' told thee from jail, "',TOLD,'".')
           End;
          If COND=17 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' tried to escape from some guards!')
           End;
          If COND=18 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' paid bail!')
           End;
          If COND=19 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' told thee telepathically, "',TOLD,'".')
           End;
          If COND=20 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' told thee, "',TOLD,'".')
           End;
          If COND=21 then Begin
            Writeln(F_FOURTH);
            Writeln (F_FOURTH,USERS[TWO,3],' said, "',TOLD,'".')
           End;
          If COND=22 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' gave thee ',WORDS,' Gold Piece(s)!')
           End;
          If COND=23 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' bought thee a glass of ',WORDS,'!')
           End;
          If COND=24 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' tried to steal a copy of the Bank Books!')
           End;
          If COND=25 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' stole a copy of the Bank Books!')
           End;
          If COND=26 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' bought thee a ',WORDS,'!')
           End;
          If COND=27 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' stole from the ',WORDS,' Tavern ',STEALER,' time(s)!')
           End;
          If COND=28 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' tried to steal from the ',WORDS,' Tavern!')
           End;
          If COND=29 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' robbed ',STEALER,' gps from the ',WORDS,' bank!!!!!!!!!!!!!!')
           End;
          If COND=30 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' tried to rob the ',WORDS,' Bank!!')
           End;
          If COND=31 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' was kicked out of the Guild - Due to Inactivity!')
           End;
          If COND=32 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' stole from the ',WORDS,' Shoppe!')
           End;
          If COND=33 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' tried to steal from the ',WORDS,' Shoppe!')
           End;
          If COND=34 then Begin
            Writeln(F_FOURTH);
            Write(F_FOURTH,USERS[TWO,3],' was killed by ');
            If (C_MONSTER<>0) and (WORDS[1]<>'e') then Write(F_FOURTH,'a ');
            If WORDS[1]='e' then Write(F_FOURTH,'the ');
            Writeln(F_FOURTH,WORDS,'!!!!!!')
           End;
          If COND=35 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' transported locations with thee!!!!!!')
           End;
          If COND=36 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' crushed thy mind protection!!!!!');
            Writeln (F_FOURTH,USERS[TWO,3],' crushed ',USERS[ONE,3],'''S mind protection!!!')
           End;
          If COND=37 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' casted a sleep spell on thee!!!!')
           End;
          If COND=38 then Begin
            Writeln (F_SECOND,USERS[TWO,3],' tried to cast a sleep spell on thee!!')
           End;
          If COND=39 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' summoned the gaze of Balor upon thee!!!!!!!!!!!');
            Writeln (F_SECOND,'1/8 of thy Score, 1/4 of thy Skill, and thy life force -- DRAINED!!');
            Writeln (F_FOURTH,USERS[TWO,3],' summoned the Gaze of Balor on ',USERS[ONE,3],'!!!!!!!')
           End;
          If COND=40 then Begin
            Writeln(F_FOURTH);
            Writeln (F_SECOND,USERS[TWO,3],' tried to summon the gaze of Balor upon thee!!!!');
            Writeln (F_FOURTH,USERS[TWO,3],' tried to summon the gaze of Balor on ',USERS[ONE,3],'!!!!')
           End;
          If COND=41 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' was lost at sea!!')
           End;
          If COND=42 then Begin
            Writeln(F_FOURTH);
            Write(F_FOURTH,USERS[TWO,3],' killed ');
            If WORDS[1]<>'e' then Writeln(F_FOURTH,'a ',WORDS,'!!!!');
            If WORDS[1]='e'  then Writeln(F_FOURTH,'the ',WORDS,'!!!!!!!!!!')
           End;
          If COND=43 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],'''S horse, "',WORDS,'", was killed!!!!')
           End;
          If COND=44 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' joined The Guild!')
           End;
          If COND=45 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' enters the Realm.')
           End;
          If COND=46 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' was caught pick-pocketing!!!!')
           End;
          If COND=47 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' stepped through the portal!!!!!!!!!!!!!');
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' wins the game!!!!!  GAME RESET!!!!!!!!!!!');
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,'CONGRATULATIONS TO ',USERS[TWO,3],'!!!!!!')
           End;
          If COND=48 then Begin
            Writeln(F_FOURTH);
            Writeln(F_FOURTH,USERS[TWO,3],' bought a horse named "',WORDS,'".')
           End;
    If (COND<50) and (NAT=False) then Begin
   (****** Now Re-Write the Stuff! ******)
          Rename(F_SECOND,F_FIRST);
          Close(F_FIRST);
      End
    End;
(**** Emulator Code Sender ************************************************)
  Procedure EM_SEND(CODES:Integer);
    Var
      CTR:Long_Integer;
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
(**** Procedure to view a text file ***************************************)
  Procedure VIEWATEXT(Var VIFILE:Text;LenLim:Boolean);
    Var
      HUH:Str255;
      THINGS:FIXEDONE;
      WHERE,LOCCOUNT,LIMCOUNT:Integer;
      CONTIN:Boolean;
    Begin
      CONTIN:=False;ABLE:=True;LIMCOUNT:=0;
      Mriteln('');
      If VT then Mrite(Chr(27));If VT then Mrite('E');WHERE:=0;
      While (not eof(VIFILE)) and (WHERE<100) and (SOFF=False) do
        Begin
          WHERE:=WHERE+1;LIMCOUNT:=LIMCOUNT+1;
          If CONTIN then WHERE:=1;
          Readln (VIFILE,THINGS);
          Mriteln (THINGS);If (LIMCOUNT=136) and (LENLIM) then WHERE:=101;
          If WHERE=23 then Begin
            Mrite('[');If VT=True then Begin
              Mrite(Chr(27));
              Mrite('c1')
             End;
            Mrite('<RETURN>');
            If VT=True then Begin
              Mrite(Chr(27));
              Mrite('c4')
             End;
            Mrite(' to continue, <S>top Reading, <C>ontinuous]');
           If SOFF=False then Begin
            Repeat
              SOMETHING(HUH);
            Until (ord(HUH[1])=13) or (HUH='S') or (HUH='C');
            LOCCOUNT:=0;
            For LOCCOUNT:=1 to 52 do Begin
              Mrite(Chr(8));Mrite(' ');Mrite(Chr(8))
             End;
           End;
            If SOFF then WHERE:=101;
            If HUH='S' then WHERE:=101;
            If HUH='C' then CONTIN:=True;
            If ord(HUH[1])=13 then WHERE:=0
           End;
        End;
        ABLE:=False;SOFF:=False;
        Mriteln('');Mriteln('The Scroll closes...');
     End;
(**** STARING TEXT - VT-52 DISPLAY ****************************************)
  Procedure START;
  Var
    HUH,HUH2,TEMP,MOPTION:Str255;
    THINGS:FIXEDONE;
    PICTURE:Text;
    WHERE,ION,LOCCOUNT,SSTRING,IMOPTION:Integer;
    TATEST,TST:Long_Integer;
  Begin
    VT:=False;HUH2:='';
    If EMULATE then Begin
      Mriteln('');
      VT:=True;
      Mriteln('Thieves'' Guild Emulator Acknowledged...');
      EM_SEND(101);
      STOP;
      EM_SEND(100);
     End;
    If EMULATE then HUH:='Y';
    DECRYPT(ln1,ln1o,CHEAT3);
    If EMULATE=False then Begin
      Mriteln('');
      Mriteln('[All text/menus are abortable via Ctrl-C]');
      Mriteln('');Mrite ('Are you using VT-52 Emulation [Y/N]? ');
      WHAT(HUH)
    End;
      If HUH='Y' then VT:=True;
      TEMP:=TPATH;
      INSERT('THIEVES.SCR',TEMP,((Ord(TEMP[0]))+1));
      EM_SEND(1051);
      MReset (PICTURE,TEMP);If EMULATE then Begin
        Mrite(Chr(27));Mrite('b4');
        Mrite(Chr(27));Mrite('c3')
       End;
      ABLE:=True;
      While not eof(PICTURE) do
        Begin
          Readln(PICTURE,THINGS);
          Mriteln(THINGS)
         End;
     ABLE:=False;SOFF:=False;
     If VT then Mrite(Chr(27));
     If VT then Mrite('b3');
     If VT then Mrite(Chr(27));
     If VT then Mrite('c4');
    Mriteln('');
    Mriteln('A world of untold treasures and arcane secrets of old awaits!');
    Mriteln('');Mrite ('Would you like to read Instructions [Y/N]? ');
    WHAT(HUH);
    If HUH='Y' then Begin
      If VT then Begin
        Mrite(Chr(27));
        Mrite('E')
       End;
      TEMP:=TPATH;
      INSERT('THIEVES.DOC',TEMP,((Ord(TEMP[0]))+1));
      IO_CHECK(False);
      Reset (PICTURE,TEMP);
      ION:=IO_Result;
      If (ION=-33) or (ION=-34) then Mriteln('I could not find THIEVES.DOC, please inform SysOp.');
      IO_CHECK(True);
   If (ION<>-33) and (ION<>-34) then Begin
     LOCCOUNT:=0;If VT then Mrite(Chr(27));If VT then Mrite('E');
     For LOCCOUNT:=1 to 22 do Begin
        Readln(PICTURE,THINGS);Mriteln(THINGS)
       End;STOP;
     Repeat {MENU}
      If VT then Mrite(Chr(27));If VT then Mrite('E');LOCCOUNT:=0;SSTRING:=0;
      For LOCCOUNT:=1 to 25 do Begin
        Readln(PICTURE,THINGS);Mriteln(THINGS);
       End;
      Repeat
          Mrite('Start where?  Chapter #, or Appendix letter [RETURN=Beginning]: ');
          Meadln(MOPTION);
          UPCASE(MOPTION);BUGPROOF(MOPTION,IMOPTION);
          Case IMOPTION of
             1:SSTRING:=256;
             2:SSTRING:=291;
             3:SSTRING:=359;
             4:SSTRING:=367;
             5:SSTRING:=413;
             6:SSTRING:=433;
             7:SSTRING:=479;
             8:SSTRING:=524;
             9:SSTRING:=707;
            10:SSTRING:=764;
            11:SSTRING:=780;
            12:SSTRING:=789;
            13:SSTRING:=842;
            14:SSTRING:=860;
            15:SSTRING:=891
           End; {Case}
          (*Use If's for I,II,II & A,B, 42*)
           If MOPTION='I' then MOPTION:='';If MOPTION='II' then SSTRING:=78;
           If MOPTION='III' then SSTRING:=186;If MOPTION='A' then SSTRING:=967;
           If MOPTION='B' then SSTRING:=1015;If MOPTION='IV' then SSTRING:=1053
        Until (SSTRING<>0) or (MOPTION='');
        If MOPTION<>'' then SSTRING:=SSTRING-49;
        Mriteln('');Mrite('Fumbling through the parchament...');
      If MOPTION<>'' then Begin
        LOCCOUNT:=0;
        For LOCCOUNT:=1 to SSTRING do Readln(PICTURE)
       End;
       Mriteln('');
        VIEWATEXT(PICTURE,False);
        Mriteln('');Mrite('Would''st thou like to read more? ');
        WHAT(HUH2);
        If HUH2='Y' then Begin
          LOCCOUNT:=0;MReset(PICTURE,TEMP);
          For LOCCOUNT:=1 to 22 do Begin
            Readln(PICTURE,THINGS);
           End;
         End;
       Until HUH2='N';
      End;
     End;
     MITCH:=True;PIRCHECK:=0;
      DECRYPT(ln1,ln1o,CHEAT3);
      DECRYPT(ln2,ln2o,11);
      DECRYPT(ln3,ln3o,17);
      DECRYPT(NUMTOT,NUMTOTO,201);
      TATEST:=0;TST:=10000;
      TATEST:=(ord(NUMTOT[1])-48)*TST;
      TATEST:=TATEST+((ord(NUMTOT[2])-48)*1000);
      TATEST:=TATEST+((ord(NUMTOT[3])-48)*100);
      TATEST:=TATEST+((ord(NUMTOT[4])-48)*10);
      TATEST:=TATEST+(ord(NUMTOT[5])-48);
      If (PIRCHECK<>TATEST) and (CAR=1) then HALT;
     Repeat
        Mriteln('');Mriteln('Read [T]oday''s Events, [Y]esterday''s Events, [S]core List,');
        Mrite('[G]uild Masters, [R]iddle Masters, or [RETURN=None]: ');
      Repeat
        SOMETHING(HUH2);
        Case HUH2[1] of
          'T':Mriteln('Today...');
          'Y':Mriteln('Yesterday...');
          'S':Mriteln('Scores...');
          'G':Mriteln('Guild Masters!');
          'R':Mriteln('Riddle Masters!');
         End; {Case}
          If ord(HUH2[1])=13 then Mriteln('Exit')
       Until (HUH2='T') or (HUH2='Y') or (HUH2='S') or (HUH2='G') or
             (HUH2='R') or (ord(HUH2[1])=13);
       IO_CHECK(False);
       If HUH2='Y' then Reset(PICTURE,LOY);
       If HUH2='T' then Reset(PICTURE,LOS);
       If HUH2='S' then Reset(PICTURE,LOP);
       If HUH2='G' then Reset(PICTURE,MASTERS);
       If HUH2='R' then Reset(PICTURE,RIDDLES);
       If ord(HUH2[1])<>13 then Begin
           ION:=IO_Result;
           If (ION=-33) or (ION=-34) then Begin
             Mriteln('');
             Mriteln('Sorry, that Scroll could not be found in the library...');
            End
         End;
       IO_CHECK(True);
       If (ord(HUH2[1])<>13) and (ION<>-33) and (ION<>-34) then VIEWATEXT(PICTURE,False)
     Until ord(HUH2[1])=13;
       If VT then Mrite(Chr(27));If VT then Mrite('v');
       Mriteln('');LOCCOUNT:=0;
       For LOCCOUNT:=1 to ord(LN1[0]) do Begin
         DOUBCHECK:=True;
         Mrite(LN1[LOCCOUNT])
        End;
       Mriteln('');
       Mriteln('');LOCCOUNT:=0;CHEAT6:=0;
       For LOCCOUNT:=1 to ord(LN2[0]) do
         Mrite(LN2[LOCCOUNT]);Mriteln('');
       STOP
  End;
(*****NEW USER ROUTINE*****************************************************)
  Procedure PNEW(Var NUM:Integer;Var OVER:Boolean);
    Var
      NAME,PASSWORD,WELL,STUFF,EVENT,TEMP:Str255;
      FNAME,RNAME,AFILE:Text;
      MAGIC:Boolean;
      A,C,LASTIME,LADYHAWK,ION:Integer;
    Begin
      NUM:=0;C:=0;A:=0;
      MAGIC:=FALSE;
      Repeat
        A:=A+1;
        If USERS[A,3]='EMPTY' then MAGIC:=TRUE;
      Until (A=26) or (MAGIC=TRUE);LADYHAWK:=0;
      If (BBS='FOREM') or (BBS='EXPRESS') then Begin
       Repeat
         LADYHAWK:=LADYHAWK+1;
         If (USERS[LADYHAWK,3]='EMPTY') and (USERS[LADYHAWK,2]<>'EMPTY') then Begin
           If USERS[LADYHAWK,2]=BBSNAME then Begin
             Mriteln('');Mriteln('Thou must wait until tommorrow to create a new character...');
             Mriteln('');EM_SEND(0);HALT
          End;
         End;
       Until LADYHAWK=26;
        End;
      If MAGIC=FALSE then Begin
        Mriteln('');Mriteln ('Sorry, no apprentices are needed at this time...');
        Mriteln ('Please try again later...');
        Mriteln('');EM_SEND(0);
        OVER:=TRUE;HALT
       End;
      If MAGIC=True then Begin
        Repeat
         Repeat
        Mriteln('');
        Mriteln('Thou must be new to these realms!!!!!');
        Mriteln('');JOINED:=True;
          Mriteln ('The Master Thief''s dark eyes seem to pierce thy soul.');
          Mriteln('');Mrite ('By what name woulds''t thou be known by in this Realm: ');
          Meadln (NAME);
          If ord(NAME[0])>25 then Mriteln ('25 Char. Maximum Please...');
          If NAME[ord(NAME[0])]=' ' then Mriteln ('A blank space at the end of thy name is not allowed.');
          If NAME[1]=' ' then Mriteln ('A blank space at the beginning of thy name is not allowed.');
          If ord(NAME[0])<4 then Mriteln ('4 Char. Minimum Please...');
          UPCASE(NAME);
         Until (NAME[1]<>' ') and (NAME[ord(NAME[0])]<>' ') and (ord(NAME[0])<26) and (ord(NAME[0])>3) and
               (NAME<>'EMPTY');
          Mrite (NAME);
          Mrite(' Correct [Y/N] ');
          WHAT(WELL);
        Until (WELL='Y');
      If (BBS<>'FOREM') and (BBS<>'EXPRESS') then Begin
        Repeat
         Repeat
          Mriteln('');Mrite ('Enter a Password to use: ');     
          Meadln (PASSWORD);
          If ord(PASSWORD[0])>25 then Mriteln ('25 Char. Maximum Please...');
          If ord(PASSWORD[0])<4 then Mriteln ('4 Char. Minimum Please...');
         Until (ord(PASSWORD[0])<26) and (ord(PASSWORD[0])>3);
          Upcase(PASSWORD);
          Mrite (PASSWORD);
          Mrite(' Correct [Y/N] ');
          WHAT(WELL);
        Until (WELL='Y')
       End;
        NUM:=A;NUNUM:=A;
        If (BBS<>'FOREM') and (BBS<>'EXPRESS') then USERS[NUM,2]:=PASSWORD
         Else USERS[NUM,2]:=BBSNAME;
        USERS[NUM,3]:=NAME;
        EVENT:=DPATH;
        INSERT(' ',EVENT,((Ord(EVENT[0]))+1));
        EVENT[ord(EVENT[0])]:=USERS[NUM,1][1];
        Rewrite (AFILE,EVENT);
        CHSTMSG;
        Mriteln('');
        Mrite('Would''st thou like to read the story-line? ');
        WHAT(WELL);
        If WELL='Y' then Begin
          TEMP:=TPATH;
          INSERT('THIEVES.DOC',TEMP,((Ord(TEMP[0]))+1));
          IO_CHECK(False);
          Reset(AFILE,TEMP);
          ION:=IO_Result;
          If (ION=-33) or (ION=-34) then Mriteln('I could not find THIEVES.DOC, please inform SysOp.');
          IO_CHECK(True);
          If (ION<>-33) and (ION<>-34) then Begin
            For C:=1 to 47 do Readln(AFILE);
            VIEWATEXT(AFILE,True);
            STOP
           End
          End;
        Mriteln('');
        Mriteln('NOTE: If you are inactive for 10 days you will be deleted!');
        Mriteln('');Mrite ('Welcome to The Guild ');
        Mrite(USERS[NUM,3]);
        Mriteln('!');
        Mriteln('');
        Mriteln (' "By the light of your torch, you have seen');
        Mriteln ('the sparkle of coins  and  gems.  You  have');
        Mriteln ('pried  magical swords  from  their  age-old');
        Mriteln ('resting  places.  Strange beasts  have been');
        Mriteln ('met   and  overcome;  odd  and   unexpected');
        Mriteln ('friendships  have  come  to light.  You are');
        Mriteln ('an Adventurer..."');
        Mriteln('');Mriteln ('The Guild wizards cast an Anti-Theft spell on thee!');
        Mriteln('It will last for 3 days.')
      End
    End;
(**************************************************************************)
  Procedure LOADSTUFF(Var TOWNI:TI;Var TOWNS:TS);
    Var
      N,SN,SD,A,B,ION:Integer;
      D,TST:Long_Integer;
      NAME,FNAME,GARBAGE,NEWNAME:Text;
      CHOICE,TEMP,FIRST:Str255;
      INFO:String[160];
      DONE,FIN:Boolean;
    Begin
      LOC;
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;
      Mriteln('');Mriteln ('Reading the Scrolls...');
      TEMP:=TPATH;
      INSERT('STEALMSG.DAT',TEMP,((Ord(TEMP[0]))+1));
      IO_CHECK(False);
      Reset (NEWNAME,TEMP);
      ION:=IO_Result;
      If (ION=-33) or (ION=-34) then Begin
        Rewrite(NEWNAME,TEMP);
        For N:=1 to 26 do Writeln(NEWNAME,'');
        N:=0
       End;
      IO_CHECK(True);
      Close(NEWNAME);
      TEMP:=TPATH;
      INSERT('TG_MSGS.DAT',TEMP,((Ord(TEMP[0]))+1));
      MReset(NAME,TEMP);
      For N:=1 to 8 do Readln(NAME,S_STUFF[N]);
      Close(NAME);N:=0;
      TEMP:=TPATH;
      INSERT('THIEVES.DAT',TEMP,((Ord(TEMP[0]))+1));
      MReset (NAME,TEMP);
       Repeat
          N:=N+1;
          SN:=SN+1;
          D:=1;
          SD:=1;
          Readln (NAME,USERI[N,D]);
          D:=D+1;
          For A:=1 to 2 do
           Begin
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
          Readln (NAME,USERI[N,D]);
          D:=D+1;
          Readln (NAME,USERS[SN,SD]);
          SD:=SD+1;
          A:=0;
          For A:=1 to 5 do
           Begin
             Readln (NAME,USERI[N,D]);
             D:=D+1
           End;
          For A:=1 to 4 do
           Begin
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1
           End;
             Readln (NAME,USERI[N,D]);
             D:=D+1;
          A:=0;
          For A:=1 to 7 do
           Begin
             Readln (NAME,USERI[N,D]);
             D:=D+1
           End;
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1;
             Readln (NAME,USERS[SN,SD]);
             SD:=SD+1;
          A:=0;
          For A:=1 to 22 do
            Begin
             Readln (NAME,USERI[N,D]);
             D:=D+1
            End;
        Until N=26;
      Readln(NAME,DUES);
      Readln(NAME,DREAM);
      Readln(NAME,PROG);Readln(NAME,BSTEAL);Readln(NAME,BDATE);
      If not eof(NAME) then Readln(NAME,GMMSG);
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;
      If bconstat(CAR) then
       If bconin(CAR)=18 then EMULATE:=True;
      TEMP:=TPATH;
      INSERT('TOWNS.DAT',TEMP,((Ord(TEMP[0]))+1));
      MReset (NAME,TEMP);
      For N:=1 to 30 do
        Readln(NAME,ADJECTIVE[N]);
      For N:=1 to 42 do
        Readln(NAME,MONSTER[N]);
      For N:=1 to 21 do Begin
        Readln(NAME,WEAPON[N,1]);
        Readln(NAME,WEAPON[N,2])
       End;
      N:=0;
        Repeat
          N:=N+1;
          SN:=SN+1;
          D:=1;
          SD:=1;
          Readln(NAME,TOWNI[N,D]);
          D:=D+1;
          Readln(NAME,TOWNS[SN,SD]);
          SD:=SD+1;
          Readln(NAME,TOWNI[N,D]);
          D:=D+1;
          Readln(NAME,TOWNS[SN,SD]);
          SD:=SD+1;
          For A:=1 to 6 do Begin
            Readln(NAME,TOWNI[N,D]);
            D:=D+1
           End;
          For A:=1 to 5 do Begin
            Readln(NAME,TOWNS[SN,SD]);
            SD:=SD+1
           End;
          Readln (NAME,TOWNI[N,D]);
          D:=D+1;
          For A:=1 to 2 do Begin
            Readln(NAME,TOWNS[SN,SD]);
            SD:=SD+1
           End;
          For A:=1 to 4 do Begin
            Readln(NAME,TOWNI[N,D]);
            D:=D+1
           End;
          Readln(NAME,TOWNS[SN,SD]);
          SD:=SD+1;
          Readln(NAME,TOWNI[N,D]);
          D:=D+1;
          Readln(NAME,TOWNS[SN,SD]);
          SD:=SD+1;
          For A:=1 to 5 do Begin
            Readln(NAME,TOWNI[N,D]);
            D:=D+1
           End;
          For A:=1 to 3 do Begin
            Readln(NAME,TOWNS[SN,SD]);
            SD:=SD+1
           End;
        Until N=25;
      IO_CHECK(False);
      Reset (F_THIRD,LOS);
      A:=IO_Result;
      If (A=-33) or (A=-34) then Rewrite(F_THIRD,LOS);
      Reset (F_THIRD,LOS);
      IO_CHECK(True);
      TEMP:=DPATH;
      INSERT('EVENTS.BAK',TEMP,((Ord(TEMP[0]))+1));
      Rewrite (F_FOURTH,TEMP);
      While not EOF(F_THIRD) do Begin
        Readln (F_THIRD,INFO);
        Writeln (F_FOURTH,INFO)
       End;
     A:=0;D:=-1;GM:=-1;
      Repeat
        A:=A+1;
        If (USERS[A,3] <> 'EMPTY') then
         Begin
           If USERI[A,5] > D then Begin
             GM:=A;
             D:=USERI[A,5]
            End
         End;
      Until A=26;
    If BBS='FOREM' then Begin
      MReset(GARBAGE,FORST);
      For A:=1 to 6 do Readln(GARBAGE,FIRST);
      Readln(GARBAGE,BBSNAME);FIRST:='';
      Readln(GARBAGE,FIRST);
      If FIRST<>'' then INSERT(' ',BBSNAME,(ord(BBSNAME[0])+1));
      INSERT(FIRST,BBSNAME,(ord(BBSNAME[0])+1));
      UPCASE(BBSNAME)
     End;
     GETEMGONE(False)
    End;
(**************************************************************************)
  Procedure LOGON(Var OVER:Boolean;Var NUM:Integer;Var DAY:Integer;
                  Var SUN:Long_Integer);
    Var
     CHECK,A,B,S,J,TOTAL,COND,COUNT,LINE,NOP,RANK,S_RANK,PLAYS:Integer;
     G_WEALTH,A_SKILL:Long_Integer;
     PASSWORD,FIRST,EVENT,JUNK:Str255;
     WORDS:String[160];
     EVENTS:Text;
    Begin
     CHECK:=1;COUNT:=0;
     NUM:=100;
     S:=0;
    If (BBS<>'FOREM') and (BBS<>'EXPRESS') then Begin
     Repeat
      Repeat
        If (NUM=0) and (ord(FIRST[1])=48) and (S=0) then Begin
          PNEW(NUM,OVER);
          S:=1
         End;
       If OVER=False then Begin
        If S=1 then Begin
          Mriteln('');
          Mrite('Thy Arcane Rune of entry is --==*> ');
          Send_Num(NUNUM);
          Mriteln(' <*==--')
         End;
        COUNT:=COUNT+1;
        Mriteln('');Mrite ('What ist thy Arcane Rune of Entry? [0=New]: ');
        Meadln (FIRST);
        BUGPROOF(FIRST,NUM);
        If COUNT=6 then Begin
          Mriteln('');Mriteln('Too many tries!!!!!');
          EM_SEND(0);HALT
         End;
       End;
      Until (NUM<27) and (NUM>0) or (OVER=True);
     If OVER=False then Begin
      Mriteln('');Mrite ('And thy Password: ');
      PASSWORD:='                                                           ';
      BLA(PASSWORD);
      Mriteln('');
      If PASSWORD=USERS[NUM,2] then CHECK:=2;
      If CHECK=1 then Mriteln ('Dost thou takest me for a Dolt!??!');
     End;
     Until (CHECK=2) or (OVER=True);
    End;
     If (BBS='FOREM') or (BBS='EXPRESS') then Begin
       For COUNT:=1 to 26 do
         If (USERS[COUNT,2]=BBSNAME) and (USERS[COUNT,3]<>'EMPTY') then NUM:=COUNT;
       If NUM=100 then PNEW(NUM,OVER);
      End;
     If OVER=False then Begin
     Mriteln('');
     If GMMSG<>'' then Begin
       Mrite('The Guild Master says, "');
       Mrite(GMMSG);
       Mriteln('".');
       Mriteln('')
      End;PEOPLES:=0;COUNT:=0;G_WEALTH:=0;NOP:=0;RANK:=1;A_SKILL:=0;S_RANK:=1;
      PLAYS:=0;
      For COUNT:=1 to 26 do Begin
         If USERS[COUNT,2]<>'EMPTY' then Begin
           NOP:=NOP+1;A_SKILL:=A_SKILL+USERI[COUNT,3];
           If USERI[COUNT,3]>USERI[NUM,3] then RANK:=RANK+1;
           If USERI[COUNT,5]>USERI[NUM,5] then S_RANK:=S_RANK+1;
           If LDATE=USERI[COUNT,2] then PLAYS:=PLAYS+1;
           G_WEALTH:=G_WEALTH+USERI[COUNT,4];
           G_WEALTH:=G_WEALTH+USERI[COUNT,18];
          End;
       End;
      Mrite ('The total wealth of Guild Members is currently ');
      Send_Num(G_WEALTH);Mriteln(' Gold Pieces.');
      Mriteln('');COUNT:=0;
      Mrite('There are currently ');
      Send_Num(NOP);Mrite(' Guild Member(s) with an Average skill of ');
      Send_Num(A_SKILL div NOP);Mriteln(' points.');
      Mrite('You are now ranked #');Send_Num(RANK);Mrite(' in Skill, and #');
      Send_Num(S_RANK);Mriteln(' in Score...');
      Send_Num(PLAYS);If PLAYS=1 then Mrite(' thief has')
      Else Mrite(' thieves have');
      Mriteln(' entered the realm today...');
     STOP;Mriteln('');
     If USERI[NUM,37]>999 then PEOPLES:=USERI[NUM,37] div 1000;
     USERI[NUM,37]:=USERI[NUM,37]-(PEOPLES*1000);
     If USERI[NUM,28]>9999 then Begin
       WATERS:=True;USERI[NUM,28]:=USERI[NUM,28]-10000
      End;
     If USERI[NUM,30]>9999 then Begin
       MYSTIC:=True;USERI[NUM,30]:=USERI[NUM,30]-10000
      End;
     If USERI[NUM,34]>9999 then Begin
       HORN:=True;USERI[NUM,34]:=USERI[NUM,34]-10000
      End;
     If USERI[NUM,31]>9999 then Begin
       FAIRY:=True;USERI[NUM,31]:=USERI[NUM,31]-10000
      End;
     Mrite ('Greetings');
     If GM=-1 then GM:=NUM;
     If GM<>NUM then Mrite (' ');
     If GM<>NUM then Mrite(USERS[NUM,3]);
     If GM<>NUM then Mriteln('!');
     If GM=NUM then Mriteln (', Guild Master!!');
     EM_SEND(115);
     If USERI[NUM,7] > 0 then Begin
       Mriteln('');
       Mrite ('Thou art still in Jail for ');
       Send_Num(USERI[NUM,7]);
       Mriteln(' more Day(s)!');
       Mrite ('Bail would Cost thee ');
       Send_Num(USERI[NUM,7]*500);
       Mriteln(' Gold Pieces.');
       Mrite ('Pay it? ');
       WHAT(JUNK);
       If JUNK='N' then OVER:=TRUE;
       If JUNK='Y' then Begin
         If USERI[NUM,4]<USERI[NUM,7]*500 then Begin
           Mriteln('');
           Mriteln
           ('The Guards say angrily, "Thou dost not have enough Gold!"')
          End;
         If USERI[NUM,4]=USERI[NUM,7]*500 then Mriteln ('That would leave thee broke!');
         If (USERI[NUM,4]<USERI[NUM,7]*500) or (USERI[NUM,4]=USERI[NUM,7]*500) then OVER:=TRUE;
         If USERI[NUM,4]>USERI[NUM,7]*500 then Begin
           Mriteln('');
           Mriteln ('Thou hast paid thy bail!  The guards reluctantly let thee go...');
           TOTAL:=1;COND:=18;
           ESTUFF(TOTAL,NUM,JUNK,COND);
           USERI[NUM,4]:=USERI[NUM,4]-USERI[NUM,7]*500;
           USERI[NUM,7]:=0
          End
         End
        End;
     If (USERI[NUM,6]=0) and (USERI[NUM,7]=0) then Begin
       Mriteln('');
       Mriteln ('Thou must wait until the moon once again reaches');
       Mriteln ('it''s peak before thou may enter this Realm again!')
      End;
     If USERI[NUM,6]=0 then OVER:=True;
     If OVER=False then Begin
       USERI[NUM,2]:=LDATE;
       SUN:=Clock;
       Mriteln('');
     If GM=NUM then Begin
      If DUES>0 then Begin
       Mrite('Thou received ');
       Send_Num(DUES);
       Mriteln(' gold piece(s) in dues!!!!!');
       USERI[NUM,4]:=USERI[NUM,4]+DUES;
       DUES:=0;Mriteln('')
      End;
       Mriteln('The Guild Scribe approaches thee, "Dost thou have a new message, master?"');
       Mrite('Leave a new guild message? ');
       WHAT(JUNK);
       If JUNK='N' then Mriteln('');
       If JUNK='Y' then Begin
         Repeat
           JUNK:='N';
          Repeat
           Mriteln('');Mriteln ('Enter thy text, up to 80 char. Maximum...');
           Mrite ('>');
           TWISTY:=True;Meadln (GMMSG);
          Until (ord(GMMSG[0])>1) and (ord(GMMSG[0])<80);
           Mriteln('');Mrite ('"');
           Mrite(GMMSG);Mriteln('"');
           Mrite ('Correct [Y/N] ');
           WHAT(JUNK);
           Mriteln('');
          Until JUNK='Y';
        End
       End;
       EM_SEND(USERI[NUM,14]);EM_SEND(200+USERI[NUM,6]);
       Mriteln ('Events While Gone!');LINE:=0;
       EVENT:=DPATH;
       INSERT(' ',EVENT,((Ord(EVENT[0]))+1));
       EVENT[ord(EVENT[0])]:=USERS[NUM,1][1];
       MReset (EVENTS,EVENT);
       ABLE:=True;
       While not eof(EVENTS) do
         Begin
           LINE:=LINE+1;
           Readln (EVENTS,WORDS);
           Mriteln (WORDS);
           If LINE=12 then STOP;
           If LINE=12 then Mriteln('');
           If LINE=12 then LINE:=0
         End;
       ABLE:=False;SOFF:=False;
       STOP;If JOINED then ESTUFF(1,NUM,'',44);
       Mriteln('');If JOINED=False then ESTUFF(1,NUM,'',45);
       Rewrite (EVENTS,EVENT);EM_SEND(1052)
      End
     End
    End;
(**************************************************************************)
  Procedure DISTIME(NUMBER:Integer;Var NNUMBER:Integer);
    Var
      A:Integer;
    Begin
      Case NUMBER of
        24:NNUMBER:=12;23:NNUMBER:=1;22:NNUMBER:=2;21:NNUMBER:=3;
        20:NNUMBER:=4;19:NNUMBER:=5;18:NNUMBER:=6;17:NNUMBER:=7;
        16:NNUMBER:=8;15:NNUMBER:=9;14:NNUMBER:=10;13:NNUMBER:=11;
        12:NNUMBER:=12;11:NNUMBER:=1;10:NNUMBER:=2;9:NNUMBER:=3;
        8:NNUMBER:=4;7:NNUMBER:=5;6:NNUMBER:=6;5:NNUMBER:=7;
        4:NNUMBER:=8;3:NNUMBER:=9;2:NNUMBER:=10;1:NNUMBER:=11
       End {Case}
    End;
(**************************************************************************)
  Procedure AWVIEW(AORW:Integer;SO:Integer);
    Var
      OTHER:Integer;
    Begin
      If AORW=1 then Begin
        Case USERI[SO,22] of
          0:Mrite('Dagger');
          1:Mrite('Club');
          2:Mrite('Mace');
          3:Mrite('Warhammer');
          4:Mrite('Axe');
          5:Mrite('Spear');
          6:Mrite('Pole Arm');
          7:Mrite('Battle Axe');
          8:Mrite('Vorpal Sword');
          9:Mrite('Short Sword');
         10:Mrite('Long Sword');
         11:Mrite('Great Sword');
         12:Mrite('Quick Sword');
         13:Mrite('Flaming Sword');
        End; {Case}
       End;
     If AORW=5 then Begin
       Case USERI[NUM,24] of
          0:Mrite('None.');
          1:Mrite('Leather');
          2:Mrite('Banded');
          3:Mrite('Ring Mail');
          4:Mrite('Scale Mail');
          5:Mrite('Chain Mail');
          6:Mrite('Crystal');
          7:Mrite('Crystal +1');
          8:Mrite('Crystal +2')
         End; {Case}
       End;
     If AORW=2 then Begin
       Case USERI[SO,22] of
          0:Mrite('Clothing');
          1:Mrite('Leather');
          2:Mrite('Chain Mail');
          3:Mrite('Ring Mail');
          4:Mrite('Banded');
          5:Mrite('Scale Mail');
          6:Mrite('Plate Mail');
          7:Mrite('Crystal Mail');
          8:Mrite('Crystal Plate');
          9:Mrite('Crystal Plate +1');
         10:Mrite('Crystal Plate +2');
         11:Mrite('Crystal Plate +3');
         12:Mrite('Crystal Plate +4');
         13:Mrite('Crystal Plate +5');
        End; {Case}
       End;
      If AORW=3 then Begin
       Case SO of
        0:Mrite ('None.');
        1:Mrite ('Raft');
        2:Mrite ('Canoe');
        3:Mrite ('Lifeboat');
        4:Mrite ('Sail Boat');
        5:Mrite ('Sm. Sail Ship');
        6:Mrite ('Longship');
        7:Mrite ('Lg. Sail Ship');
        8:Mrite ('Galley')
       End; {Case}
      End;
      If AORW=4 then Begin
       OTHER:=DRANDOM mod 6+1;
       If (C_MONSTER>36) and (C_MONSTER<41) then OTHER:=2;
       If OTHER=7 then OTHER:=6;
       If (OTHER<3) and (SO=1) then Mrite('Thou');
       If (OTHER>2) and (SO=1) then Mrite('The ');
       If (OTHER>2) and (SO=1) then Mrite(MONSTER[C_MONSTER]);
       If (OTHER>2) and (SO=2) then Mrite('Thou');
       If (OTHER<3) and (SO=2) then Mrite('The ');
       If (OTHER<3) and (SO=2) then Mrite(MONSTER[C_MONSTER]);
       Case OTHER of
         1:Mriteln (' aimed poorly!');
         2:Mriteln (' missed!!!');
         3:Mriteln (' dodged the attack!');
         4:Mriteln (' stepped aside!');
         5:Mriteln (' evaded the blow!');
         6:Mriteln (' blocked the attack!')
        End; {Case}
     If C_ADJECTIVE>0 then Begin
      If (ADJECTIVE[C_ADJECTIVE]='Drunk') and (SO=2) and (C_MONSTER>4) then Begin
         Mriteln('');Mrite('The ');Mrite(MONSTER[C_MONSTER]);
         Mriteln(' says, "I shouldn''t have drank so much!!!!"')
        End;
        End;
       End;
    End;
(**************************************************************************)
  Procedure MEMBERS(NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      WHICH,COND,IS:Integer;
      JUNK:Str255;
      UNI:Boolean;
    Begin
     UNI:=False;Mriteln('');
     Repeat
      Mrite ('Look at Which Thief? [?=List] [Return Aborts]: ');
      IS:=0;
      ASK(NUM,WHICH,IS,UNI);
      If WHICH > 0 then Begin
        Mriteln('');
        Mrite (USERS[WHICH,3]);
        Mriteln('''S Appearance:');
        Mriteln('');Mrite('Weapon: ');AWVIEW(1,WHICH);Mriteln('');
        Mrite('Armour: ');AWVIEW(2,WHICH);Mriteln('');
        Mrite('Hit Points: ');
        Send_Num(USERI[WHICH,20]);Mrite('/');Send_Num(USERI[WHICH,21]);
        Mriteln('');
        Mriteln('');Mrite ('Head:  ');
        Mriteln(USERS[WHICH,4]);
        Mrite ('Chest: ');
        Mriteln(USERS[WHICH,5]);
        Mrite ('Legs:  ');
        Mriteln(USERS[WHICH,6]);
        Mrite ('Feet:  ');
        Mriteln(USERS[WHICH,7]);
        Mriteln('');
      If USERI[WHICH,16]>0 then Begin
        Mrite (USERS[WHICH,3]);
        Mrite(' rides a ');
        Mrite (USERS[WHICH,8]);
        Mrite(', named "');
        Mrite(USERS[WHICH,9]);
        Mriteln('".')
       End;
        COND:=8;
        ESTUFF(WHICH,NUM,JUNK,COND)
      End;
      If WHICH > 0 then Begin
        Mriteln('');Mrite ('Anyone else? ');
        WHAT(JUNK);
        If JUNK='Y' then Mriteln('')
      End;
     MAKESURE(NUM,SUN,OVER);
     Until (JUNK='N') or (WHICH=-1) or (OVER=TRUE);
     If OVER=FALSE then STOP;
    End;
(**************************************************************************)
  Procedure GOODBYE(NUM:Integer;Var SINGLE:Integer;Var OVER:Boolean);
    Var
      V,COND,CO,COUNT:Integer;
      SAVED:Boolean;
      NAMED:Str255;
    Begin
      SAVED:=False;
      If (DEATH<>'') and (WON=False) then Begin
        EM_SEND(300);
        If CHEAT4<>203 then Repeat Until False;
        Mriteln('');Mriteln('Thou hast been Killed!!!!!!!!!!!!!');
        Mriteln('');
        Mriteln('As thy final breath draws near, thou mayst pray to one God.');
        Mriteln('Only one will save thee...');
        Mriteln('');
        Mriteln('[S]olnar, Keeper of the Flame.');
        Mriteln('[C]athra, Goddess of Light.');
        Mriteln('[B]alor, Lord of Darkness.');
        Mriteln('');
        Mrite('Ask which God for salvation? ');
       Repeat
        SOMETHING(NAMED)
       Until (NAMED='S') or (NAMED='C') or (NAMED='B');
       Mriteln(NAMED);CO:=DRANDOM mod 3+1;Mriteln('');
       If NAMED='S' then Mrite('Solnar');
       If NAMED='C' then Mrite('Cathra');
       If NAMED='B' then Mrite('Balor');
       If CO=2 then Begin
         Mriteln(' breathes life into thee!!!!!!!!!!!!');
         DEATH:='';OVER:=False;
         SAVED:=True;
         USERI[NUM,20]:=10
        End;
       If CO<>2 then Begin
         Mriteln(' laughs in thy Face!!!!!');
         Mriteln('');Mriteln
         ('Darkness surrounds, thy journey to the Astral Plane begins...');
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
        USERI[NUM,37]:=5000
       End;
      If (OVER=True) and (SPCB=False) and (SAVED=False) and (DEATH='') and (WON=False) then Begin
          Mriteln('');Mriteln ('Thou art $$$ BROKE $$$');
          Mriteln('');Mriteln ('Thou art not worthy of being a member of the Thieves'' Guild!');
          Mriteln('');Mriteln ('Thou hast been removed from the Scrolls!');
          Mriteln('');Mriteln ('Fare thee well...')
        End;
      If (OVER=False) and (SPCB=False) and (SAVED=False) and (WON=False) then Begin
          Mriteln('');
          Mrite ('Thou hast caused ');
          Mrite (NAMED);
          Mriteln(' to go broke!');
          Mriteln('');Mrite (NAMED);
          Mriteln(' hast been removed from the scrolls!');
          USERI[V,5]:=USERI[V,5]+1500;
          Mriteln('');
        End;
      If ((SAVED=True) or (DEATH<>'')) and (WON=False) then STOP
    End;
(**** AFTER MIDNIGHT MAINTANANCE ******************************************)
  Procedure MIDNIGHT(Var DAY:Integer;Var DAYSS:Str255;Var OVER:Boolean);
    Var
      A,B,THIS,D,O,G,X,Y,Z,Tm:Long_Integer;
      DR:Real;
      TEMP:Str255;
      Neg: Boolean;
      ONE:Text;
    Begin
      TEMP:=DPATH;
      INSERT('JUNK.DAT',TEMP,((Ord(TEMP[0]))+1));
      Rewrite (ONE,TEMP);
      O:=Getdate mod 32;
      D:=(Getdate mod 512) div 32;
      G:=(Getdate div 512)+1980;
      Tm:=Gettime;
      Neg:=Tm<0;
      Tm:=Tm+(32768*ord(neg));
      Z:=Tm mod 32;
      Y:=(Tm mod 2048) div 32;
      X:=(Tm div 2048)+(16*ord(neg));
      Z:=Z*2;
      LDATE:=DA_TE(G-1900,D,O);
      Write (One,D div 10,D mod 10,'/',O div 10,O mod 10,'/',G,' ',X div 10);
      Writeln (One,X mod 10,':',Y div 10,Y mod 10,':',Z div 10,Z mod 10); 
      MReset (ONE,TEMP);
      Readln (ONE,DAYSS);
      TEMP:=TPATH;
      DECRYPT(ln1,ln1o,CHEAT1);
      INSERT('THIEVES.CLK',TEMP,((Ord(TEMP[0]))+1));
      MReset (ONE,TEMP);
      Readln (ONE,THIS);
      Readln (ONE,MONTH);
      CMONTH:='  ';CMONTH[1]:=DAYSS[1];CMONTH[2]:=DAYSS[2];
      If LDATE<THIS then Begin
        Mriteln('');Mriteln('The date has been altered, game will not run until changed.');
        Mriteln('');Mriteln('Please notify the SysOp...');EM_SEND(0);
        HALT
       End;
      If (THIS < LDATE) or (MONTH <> CMONTH) then Begin
        Mriteln('');Mrite ('''The Moon has Risen!'' - Please Wait...');
        IO_CHECK(False);
        Reset (ONE,MASTERS);
        A:=IO_Result;
        If (A=-33) or (A=-34) then Begin
          Rewrite(ONE,MASTERS);
          Writeln (ONE);
          Writeln (ONE,'       *__--__* The Masters of the Guild!! *__--__*');
          Writeln(ONE);
          Writeln (ONE,'Date                 Name                            Score');
          Writeln (ONE,'*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*')
         End;
        Reset (ONE,RIDDLES);
        A:=IO_Result;
        If (A=-33) or (A=-34) then Begin
          Rewrite(ONE,RIDDLES);
          Writeln(ONE);
          Writeln(ONE,'     *-)----<<<<*>>>>/\/\<<<<*>>>>/\/\<<<<*>>>>----(-*');
          Writeln(ONE,'  *(/\/\__  --* The Masters of the Riddles! *--  __/\/\)*');
          Writeln(ONE,'     *-)----<<<<*>>>>\/\/<<<<*>>>>\/\/<<<<*>>>>----(-*');
          Writeln(ONE);
          Writeln(ONE,'   Date      Time     Name                          Score');
          Writeln(ONE,'-----------------------------------------------------------');
          Writeln(ONE,'12/07/1990 11:37:46   LUVAN LIGHTFINGERS            2767627');
          Writeln(ONE,'===========================================================');
          Writeln(ONE,' "And there were some whose name would be known throughout');
          Writeln(ONE,'    all time, known as legends, and shining examples of');
          Writeln(ONE,'        great valor and bravery, against all odds."')
         End;
        IO_CHECK(True);
        Rewrite (ONE,TEMP);
        Writeln (ONE,LDATE);
        Writeln (ONE,CMONTH);
        A:=0;
        CLOSE(ONE);
            Rewrite(ONE,LOY);
            RENAME(F_THIRD,ONE);
            Rewrite(F_THIRD,LOS);
            TEMP:=DPATH;
            INSERT('EVENTS.BAK',TEMP,((Ord(TEMP[0]))+1));
          For A:=1 to 2 do Begin
            Rewrite (F_FOURTH,TEMP);
            Writeln (F_FOURTH);
            Writeln (F_FOURTH,'      #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#');
            Writeln (F_FOURTH,'#*#*#* The Thieves'' Guild Current Events as of *#*#*#');
            Writeln (F_FOURTH,'      #*#*#*#*#*# ',DAYSS,' #*#*#*#*#');
            If A=1 then RE;
           End;
        A:=0;
        For A:=1 to 26 do
          Begin
            If (USERI[A,17]>0) and (USERI[A,18]<=100000) then
             USERI[A,18]:=USERI[A,18]+(round(USERI[A,18]*(TOWNI[USERI[A,17],14]*0.01)));
            USERI[A,6]:=24;
            USERI[A,33]:=0;
            PEOPLES:=USERI[A,37] div 1000;
            USERI[A,37]:=USERI[A,37]-(PEOPLES*1000);
            If USERI[A,37]>20 then USERI[A,37]:=20;
            USERI[A,37]:=USERI[A,37]+5000;
            PEOPLES:=0;
            USERI[A,9]:=5;
            If USERI[A,36]=2 then USERI[A,6]:=USERI[A,6]+(DRANDOM mod 6+1);
            If (USERS[A,3]='EMPTY') and (USERS[A,2]<>'EMPTY') then USERS[A,2]:='EMPTY';
            If (USERI[A,15]>0) and (USERS[A,3]<>'EMPTY') then USERI[A,15]:=USERI[A,15]-1;
            If USERI[A,13] > 0 then USERI[A,13]:=USERI[A,13]-1;
            If USERI[A,25] > 100 then USERI[A,25]:=USERI[A,25]-100;
            If USERI[A,27] > 0 then USERI[A,27]:=USERI[A,27]-1;
            If USERI[A,7] > 0 then USERI[A,7]:=USERI[A,7]-1
          End;
        A:=0;
        For A:=1 to 26 do Begin
          If (LDATE-USERI[A,2] > 10) and (USERS[A,3]<>'EMPTY') then Begin
            NUM:=A;SPCB:=True;
            GOODBYE(NUM,NUM,OVER);
            SPCB:=False
           End
          End;
        NUM:=0;
        Mriteln ('Done!');
        SAVEINFO(OVER);
        A_CRYPT:=True;GETEMGONE(False);A_CRYPT:=False;
        End
    End;
(**************************************************************************)
  Procedure POTION;
    Var
      SURE,RUN,HEAL:Integer;
      COLOR,WHICH,SSURE:Str255;
      MULTI:Boolean;
    Begin
      MULTI:=False;If EMULATE then VT:=False;
      If USERI[NUM,20]=USERI[NUM,21] then HEAL:=0
        Else HEAL:=DRANDOM mod 10+1;
      If (HEAL+USERI[NUM,20])>(USERI[NUM,21]) then HEAL:=USERI[NUM,21]-USERI[NUM,20];
      SURE:=DRANDOM mod 22+1;
      If (SURE=21) and (WIZPOT) then SURE:=5;
      If SURE=22 then Begin
        MULTI:=True;
        SURE:=DRANDOM mod 21+1
       End;
      Case SURE of
       1:Begin COLOR:='White';WHICH:='Heal Wounds' End;
       2:Begin COLOR:='Yellow';WHICH:='Restore Life' End;
       3:Begin COLOR:='Red';WHICH:='Poison' End;
       4:Begin COLOR:='Blue';WHICH:='Poison Antidote' End;
       5:Begin COLOR:='Green';WHICH:='Skill' End;
       6:Begin COLOR:='Orange';WHICH:='Clumsiness' End;
       7:Begin COLOR:='Clear';WHICH:='Life Water' End;
       8:Begin COLOR:='Violet';WHICH:='Anti-Theft' End;
       9:Begin COLOR:='Pale';WHICH:='Life!!!  Hit points increased!' End;
      10:Begin COLOR:='Black';WHICH:='Invisibility!  Thou art invisible to Guild Members' End;
      11:Begin COLOR:='Amber';WHICH:='Dryness!!' End;
      12:Begin COLOR:='Crimson';WHICH:='Energy!!' End;
      13:Begin COLOR:='Light Blue';WHICH:='Drowsiness!!' End;
      14:Begin COLOR:='Brown';WHICH:='Hunger!!' End;
      15:Begin COLOR:='Gray';WHICH:='Mind Protection!!' End;
      16:Begin COLOR:='Scarlet';WHICH:='Mind Crush!!  Mind Protection -- Destroyed!' End;
      17:Begin COLOR:='Bronze';WHICH:='Time Warp!!  Hours pass' End;
      18:Begin COLOR:='Gold';WHICH:='Time Stop!  The day grows longer!!' End;
      19:Begin COLOR:='Clear Yellow';WHICH:='Castor oil!!!!  YECH!!!!  Thou dost feel sick' End;
      20:Begin COLOR:='Pink';WHICH:='something...  Hmmmm...  No apparent effect' End;
      21:Begin COLOR:='Deep Green';WHICH:='Luck!!!' End;
     End; {Case}
      If MULTI=True then COLOR:='multi';
      If MULTI then EM_SEND(664);
      If MULTI=False then EM_SEND(642+SURE);EM_SEND(303);
      Mriteln('');
      If MULT=False then Mrite('Thou hast found a ');
      If MULT=True then Mrite('Thou hast a ');
      Mrite(COLOR);
      Mrite(' coloured Potion!  Drink it? ');
      WHAT(SSURE);
      If SSURE='Y' then Begin
        Case SURE of
          1:USERI[NUM,20]:=USERI[NUM,20]+HEAL;
          2:USERI[NUM,20]:=USERI[NUM,21];
          3:USERI[NUM,26]:=7;
          4:USERI[NUM,26]:=0;
          5:USERI[NUM,3]:=USERI[NUM,3]+(DRANDOM mod 10+1);
          6:If USERI[NUM,3]>14 then USERI[NUM,3]:=USERI[NUM,3]-(DRANDOM mod 10+1);
          7:USERI[NUM,11]:=USERI[NUM,11]+20;
          8:USERI[NUM,15]:=USERI[NUM,15]+DRANDOM mod 2+1;
          9:USERI[NUM,21]:=USERI[NUM,21]+DRANDOM mod 5+1;
         10:USERI[NUM,27]:=USERI[NUM,27]+DRANDOM mod 2+1;
         11:USERI[NUM,11]:=USERI[NUM,11]-11;
         12:USERI[NUM,12]:=USERI[NUM,12]+11;
         13:USERI[NUM,12]:=USERI[NUM,12]-11;
         14:USERI[NUM,10]:=USERI[NUM,10]-11;
         15:USERI[NUM,13]:=USERI[NUM,13]+DRANDOM mod 2+1;
         16:USERI[NUM,13]:=0;
         17:USERI[NUM,6]:=USERI[NUM,6]-DRANDOM mod 5+2;
         18:USERI[NUM,6]:=USERI[NUM,6]+DRANDOM mod 5+1;
         21:LUCK:=True
        End; {Case}
        If USERI[NUM,6]<0 then USERI[NUM,6]:=0;
        If USERI[NUM,6]>24 then USERI[NUM,6]:=24;
        Mriteln('');
        Mrite('Thou drinketh a potion of ');
        Mrite(WHICH);Mriteln('!!!');
        If (SURE=3) or (SURE=6) or (SURE=11) or (SURE=13) or (SURE=14) then EM_SEND(107);
        If (EMULATE) and (MULT=False) and (SSURE='Y') then STOP
      End;
      If EMULATE then VT:=True;If (MULT=False) and (DTREAS=False) then EM_SEND(300)
    End;
(**** ~*~ TREASURE CHEST/EXPERIENCE ~*~ -- Given after Combat! ************)
  Procedure TREASURE(HITS:Integer;MODE:Integer);
    Var
      OLD,COUNT:Integer;
    Begin
      If MODE=4 then EM_SEND(302);If (MODE=2) or (MODE=4) or (MODE=0) then DTREAS:=True;
      If (MODE<>2) and (MODE<>3) and (MODE<>4) and (MODE<>5) then EM_SEND(300);
      Mriteln('');
      Mriteln('      xX*Xx  Experience  xX*Xx');
      Mriteln('');
      If (HITS div 5)>0 then  Mrite('          Thy Skill +');
      If (HITS div 5)>0 then Send_Num(HITS div 3);
      If (HITS div 5)>0 then Mriteln('');
      USERI[NUM,3]:=USERI[NUM,3]+(HITS div 3);
      Mrite('          Thy Score +');
      OLD:=DRANDOM mod (300*CONVERT(C_MONSTER))+1;
      Send_Num(OLD);USERI[NUM,5]:=USERI[NUM,5]+OLD;
      Mriteln('');
      If (HITS div 7)>0 then Mrite('     Thy Hit Points +');
      If (HITS div 7)>0 then Send_Num(HITS div 7);
      If (HITS div 7)>0 then Mriteln('');
      USERI[NUM,21]:=USERI[NUM,21]+(HITS div 7);
      STOP;
    If C_MONSTER=41 then Begin
      Mriteln('');USERI[NUM,29]:=2;
      Mriteln('Thou removest the magical Medallion of Wisdom from Zolar''s neck...');
      Mriteln('It contains an eye in a gem that seems to gaze into eternity.')
     End;
    If (C_MONSTER>4) and (C_MONSTER<37) then Begin
      Mriteln('');
      Mriteln('Thou dost open an old treasure chest...');
      Mriteln('');
      Mriteln('     $$$  Treasure & Magic Items  $$$');
      Mriteln('');
      Mriteln('The Chest contains:');
      Mriteln('');
      If (DRANDOM mod (30+CONVERT(C_MONSTER))+1)<(CONVERT(C_MONSTER)) then Begin
        OLD:=DRANDOM mod 10+1;
        Send_Num(OLD);
        Mriteln(' Potion(s).');
        For COUNT:=1 to OLD do Begin
          If COUNT<>OLD then MULT:=True;
          If COUNT=OLD then MULT:=False;
          POTION
         End;
        If (MODE=2) or (MODE=4) then EM_SEND(302);
        Mriteln('');
        MULT:=False;
       End;
      OLD:=DRANDOM mod (C_MONSTER*100)+1;
      Send_Num(OLD);
      Mriteln(' Gold Piece(s).');
      USERI[NUM,4]:=USERI[NUM,4]+OLD;
      If (DRANDOM mod (45+CONVERT(C_MONSTER))+1)<(CONVERT(C_MONSTER)) then Begin
        OLD:=DRANDOM mod 5+1;
        Send_Num(OLD);
        Mriteln(' food packet(s).');
        USERI[NUM,10]:=USERI[NUM,10]+(OLD*4)
       End;
      If (DRANDOM mod (45+CONVERT(C_MONSTER))+1)<(CONVERT(C_MONSTER)) then Begin
        OLD:=DRANDOM mod 5+1;
        Send_Num(OLD);
        Mriteln(' bottle(s) of Wine.');
        USERI[NUM,11]:=USERI[NUM,11]+(OLD*4)
       End;
      If (DRANDOM mod (60+CONVERT(C_MONSTER))+1)<(CONVERT(C_MONSTER)) then Begin
        OLD:=DRANDOM mod 5+1;
        Send_Num(OLD);
        Mriteln(' magical dart(s).');
        USERI[NUM,28]:=USERI[NUM,28]+OLD
       End;
      If ((DRANDOM mod (80+CONVERT(C_MONSTER))+1)<(CONVERT(C_MONSTER))) and (FAIRY=False) then Begin
        Mriteln('A piece of magical Fairy Wood!!!!!!');
        FAIRY:=True
       End;
      If (DRANDOM mod (285+CONVERT(C_MONSTER))+1)<(CONVERT(C_MONSTER)) then Begin
        OLD:=DRANDOM mod 2+1;
        Send_Num(OLD);
        Mriteln(' Magic Crystal(s) of Power!!!!');
        USERI[NUM,37]:=USERI[NUM,37]+OLD
       End;
      For COUNT:=1 to 20 do Begin
      If (DRANDOM mod (45+CONVERT(C_MONSTER))+1)<(CONVERT(C_MONSTER)) then Begin
        Case COUNT of
          1:Mriteln('A tinder box.');
          2:Mriteln('A mirror.');
          3:Mriteln('Some torn maps.');
          4:Mriteln('Spell reagents.');
          5:Mriteln('Some Spices.');
          6:Mriteln('Some Herbs.');
          7:Mriteln('Some Bones.');
          8:Mriteln('A compass.');
          9:Mriteln('Rusty Dishes.');
         10:Mriteln('Tattered Books.');
         11:Mriteln('Miscellaneous garbage.');
         12:Mriteln('Weathered Scrolls.');
         13:Mriteln('Firewood.');
         14:Mriteln('Some candles.');
         15:Mriteln('Rope.');
         16:Mriteln('Some torches.');
         17:Mriteln('Dirty rags.');
         18:Mriteln('Some mice.');
         19:Mriteln('Some dead rats.');
         20:Mriteln('A deck of cards.')
        End; {Case}
       End;
      End;
      If (EMULATE) and (MODE<>0) and (MODE<>2) then STOP
     End;
     DTREAS:=False;
   End;
(**** COMBAT Routines, 0=Tavern 1=Normal 2=Land 3=Ocean *******************)
  Procedure COMBAT(MODE:Integer;Var OVER:Boolean;SEX:Boolean);
      Var
        PHASE,C_WEAPON,C_STAT,STUN,M_STUN,C_HIT,DAMAGE,MHP,M_DOWN,MANU,RANDOM,WEAP,WHERE,HITS,HHP,
        RANDOM2,ASSA,SAIL,SHP,SHPM,HRANDOM:Integer;
        WHICH,TARGET:Str255;
        FIGHT,CANON:Boolean;
      Begin
        If CHEAT3<>101 then Repeat STOP Until False;
        SHP:=USERI[NUM,8];HALF:=True;
        CANON:=False;If SHP>10 then CANON:=True;
        If SHP>10 then SHP:=SHP-10;SHP:=SHP*10;SHPM:=SHP;
        If (C_MONSTER>36) and (C_MONSTER<41) then Begin
          SAIL:=MODE;MODE:=3;
         End;
        PHASE:=0;STUN:=0;C_WEAPON:=USERI[NUM,22];FIGHT:=True;MHP:=(CONVERT(C_MONSTER)*10);DAMAGE:=0;HITS:=0;
        Mriteln('');HHP:=USERI[NUM,16];If C_MONSTER=41 then MHP:=MHP+150;
        If C_MONSTER=42 then MHP:=MHP+400;
        C_STAT:=0;M_STUN:=0;M_DOWN:=0;If MODE=3 then MHP:=MHP-80;
      If (C_MONSTER<>41) then Begin
        Mrite('Thou art confronted by a ');
        Mrite(MONSTER[C_MONSTER]);
        Mriteln('!!!');
        If ((USERI[NUM,21] div 5)<CONVERT(C_MONSTER)) and (MODE<>3) then Begin
          If EMULATE then STOP;Mriteln('');
        If (C_MONSTER>4) and (C_MONSTER<38) then Begin
         If (MODE<>2) and (MODE<>3) and (MODE<>5) then EM_SEND(300);
          Mrite('The ');
          Mrite(MONSTER[C_MONSTER]);
          Mriteln(' says, "Waste my time on one as weak as thee!?  Depart, Knave!"');
          If (MODE=2) or (MODE=4) or (MODE=5) then EM_SEND(302);
         End
        Else Begin
         If (MODE<>2) and (MODE<>3) and (MODE<>5) then EM_SEND(300);
          Mriteln('Thy Foe leaves...');
          If (MODE=2) or (MODE=4) or (MODE=5) then EM_SEND(302)
         End;
          FIGHT:=False;
         End;
       End;
      If C_MONSTER=41 then Begin
        Mriteln('Zolar approaches thee!!!!  "How I miss the joy of destruction!", he chants.');
        Mriteln('');
        Mriteln('He walks with a limp.  It would be easy to escape, keep that in mind...')
       End;
      If FIGHT then STOP;
      If FIGHT then Begin
       Repeat
        If (VT=True) and (EMULATE=False) then Mrite(Chr(27));
        If (VT=True) and (EMULATE=False) then Mrite('E');
        PHASE:=PHASE+1;
        If (VT=False) or (EMULATE=True) then Mriteln('');
        Mrite('         !!! BATTLE PHASE #');
        Send_Num(PHASE);
        Mriteln(' !!!');
        Mriteln('');
        If STUN>0 then STUN:=STUN-1;
        If C_STAT>0 then C_STAT:=C_STAT-1;
        If STUN>0 then Mriteln('Thou art still stunned, and unable to attack...');
        If C_STAT>0 then Mriteln('Thou art unable to get back on thy feet...');
        If (STUN>0) or (C_STAT>0) then STOP;
       If (STUN=0) and (C_STAT=0) then Begin
        ABLE:=True;
        If (C_WEAPON>7) or (C_WEAPON=0) or (C_WEAPON=5) or (C_WEAPON=6) then Begin
         EM_SEND(1062);
         If EMULATE=False then Begin
          Mriteln('          [1] Defensive Strike');
          Mriteln('');
          Mriteln('    [2] Slash     *-*-*-*   [3] Stab');
          Mriteln('    [4] Thrust!    *-*-*    [5] Lunge!');
          Mriteln('');
          Mriteln('         [6] Two-Handed Attack!!!');
          Mriteln('          >> [T]ry to Escape! <<')
         End;
        End;
        If (C_WEAPON=4) or (C_WEAPON=7) then Begin
         EM_SEND(1063);
         If EMULATE=False then Begin
          Mriteln('               [1] Swipe');
          Mriteln('');
          Mriteln('    [2] Slash    /\/\/\   [3] Slice');
          Mriteln('    [4] Swing!   \/\/\/   [5] Chop!');
          Mriteln('');
          Mriteln('        [6] Two-Handed Attack!!!');
          Mriteln('         >> [T]ry to Escape! <<')
          End;
         End;
        If (C_WEAPON>0) and (C_WEAPON<4) then Begin
         EM_SEND(1064);
         If EMULATE=False then Begin
          Mriteln('              [1] Swing');
          Mriteln('');
          Mriteln('    [2] Slam    ><<>><   [3] Bash');
          Mriteln('    [4] Pound!  <>><<>   [5] Smash!');
          Mriteln('');
          Mriteln('        [6] Two-Handed Smash!!!');
          Mriteln('         >> [T]ry to Escape <<')
          End;
         End;
        If C_WEAPON=-1 then Begin
         EM_SEND(1065);
         If EMULATE=False then Begin
          Mriteln('            [1] Defensive');
          Mriteln('');
          Mriteln('    [2] Jab   <<*>><<*>> [3] Punch');
          Mriteln('    [4] Kick! >>*<<>>*<< [5] Strangle!');
          Mriteln('');
          Mriteln('            [6] Grapple!!');
          Mriteln('       [7] Recover thy Weapon!');
          Mriteln('        >> [T]ry to Escape <<')
          End;
         End;
        If (MODE=3) and (CANON) then Mriteln('       ]=> [F]ire thy Catapult <=[');
        ABLE:=False;SOFF:=False;
        Mriteln('');
        If MODE=0 then Begin
          Mrite('The patrons of the tavern cheer for ');
          If DRANDOM mod 2+1=1 then Mriteln('thee!!!')
          Else Begin
            Mrite('the ');
            Mrite(MONSTER[C_MONSTER]);Mriteln('!!!!!')
          End;
         Mriteln('')
        End;
        Mrite('Attacking with thy ');
        If C_WEAPON<>-1 then AWVIEW(1,NUM);
        If C_WEAPON=-1 then Mrite('Bare Hands');
        Mrite(': ');
        Repeat
          SOMETHING(WHICH);
        Until ((WHICH>'0') and (WHICH<'7')) or ((WHICH='7') and (C_WEAPON=-1)) or (WHICH='T')
              or ((WHICH='F') and (CANON) and (MODE=3));
        If WHICH<>'T' then Mriteln(WHICH);
        If ((WHICH>'0') and (WHICH<'7')) or (WHICH='F') then Begin
         If MODE<>3 then Begin
          EM_SEND(1066);
         If EMULATE=False then Begin
          Mriteln('');
          Mriteln('   [H]ead    [C]hest');
          Mriteln('   [A]rms    [L]egs');
          Mriteln('');
         End;
          Mrite('Thy Primary Target? ');
         Repeat
          SOMETHING(TARGET);
         Until (TARGET='H') or (TARGET='C') or (TARGET='A') or (TARGET='L');
         Mriteln(TARGET);
        End;
         If MODE=3 then TARGET:='C';
         Mriteln('');
         BUGPROOF(WHICH,MANU);
         C_HIT:=(C_MONSTER*10)+USERI[NUM,3]+(MANU*10);
         RANDOM:=DRANDOM mod C_HIT+1;
         If ((USERI[NUM,23]=1) or (USERI[NUM,23]=3)) and (C_WEAPON<>-1) and (WHICH<>'F') then Begin
          If DRANDOM mod 2+1=1 then Begin
           Mrite('Thy ');
           AWVIEW(1,NUM);
           Mriteln(' screams, "Meet my wrath!!!!!!"');
           Mriteln('')
          End;
         End;
         Begin
          If (WHICH<>'F') and (RANDOM<USERI[NUM,3]) then Begin
           If USERI[NUM,22]>0 then DAMAGE:=DRANDOM mod (USERI[NUM,22]*5)+1;
           If DAMAGE=0 then DAMAGE:=DRANDOM mod 5+1;If TARGET='C' then DAMAGE:=DAMAGE+2;
           DAMAGE:=DAMAGE+MANU;
           If (USERI[NUM,23]=1) or (USERI[NUM,23]=3) then DAMAGE:=DAMAGE+(DRANDOM mod 10+1);
           MHP:=MHP-DAMAGE;HITS:=HITS+1;
           If DAMAGE<26 then EM_SEND(505);
           If DAMAGE>25 then EM_SEND(506);
           If M_STUN>0 then EM_SEND(502);
           Mrite('Thou hit doing ');
           Send_Num(DAMAGE);
           Mriteln(' point(s) damage!!!!')
          End;
           If (USERI[NUM,16]>0) and (MODE=2) then Begin
             If RANDOM<USERI[NUM,3] then Mriteln('');
             Mrite('Thy horse tries to kick thy foe, and ');
             HRANDOM:=DRANDOM mod (6+(USERI[NUM,16] div 2));
             If HRANDOM<(USERI[NUM,16] div 2) then Begin
               Mrite('hit doing ');
               DAMAGE:=DRANDOM mod (USERI[NUM,16] div 2)+1;
               Send_Num(DAMAGE);
               Mriteln(' point(s) of damage!!');
               EM_SEND(505);If M_STUN>0 then EM_SEND(502);
               MHP:=MHP-DAMAGE
              End
             Else Mriteln('missed!');
             If RANDOM>USERI[NUM,3] then Mriteln('');
            End;
           If (MODE=3) and (SAIL>1) then Begin
             Mrite('Thy Sailors attack and hit doing ');
             DAMAGE:=DRANDOM mod (SAIL*5)+1;
             Send_Num(DAMAGE);
             Mriteln(' point(s) of damage!!');
             MHP:=MHP-DAMAGE;If (RANDOM>USERI[NUM,3]) and (MODE=3) then Mriteln('');
             EM_SEND(505);If M_STUN>0 then EM_SEND(502)
           End;
        If WHICH='F' then Begin
          DAMAGE:=DRANDOM mod 20+1;
          Mrite('Thou dost fire thy catapult and hit doing ');
          Send_Num(DAMAGE);
          Mriteln(' point(s) of damage!!');
          EM_SEND(505);If M_STUN>0 then EM_SEND(502);
          MHP:=MHP-DAMAGE
         End;
           If MHP<1 then Begin
             EM_SEND(507);
             Mriteln('');
             Mrite('The ');
             Mrite(MONSTER[C_MONSTER]);If C_MONSTER=42 then WON:=True;
             Mriteln(' hast been slain!!!!');
             If MODE=0 then Begin
               Mriteln('');Mriteln('The patrons applaud thy valor!!!!!')
              End;
             ESTUFF(1,NUM,MONSTER[C_MONSTER],42);
             If (MODE=2) or (MODE=4) then EM_SEND(302);
             TREASURE(HITS,MODE);
             FIGHT:=False
            End
           Else Begin
          If (WHICH<>'F') and (RANDOM<USERI[NUM,3]) then Begin
             If (TARGET='H') and (DRANDOM mod 5+1=2) then Begin
                 Mriteln('');Mriteln('Thy foe is stunned from thy blow!');
                 EM_SEND(502);
                 M_STUN:=Drandom mod 4+1
                End;
             If (TARGET='L') and (DRANDOM mod 5+1=2) then Begin
                 Mriteln('');Mriteln('Thy foe hast been knocked down!!!');
                 EM_SEND(502);
                 M_DOWN:=Drandom mod 4+1
                End
              End
            End;
           If (FIGHT=True) and (RANDOM<USERI[NUM,3]) and (WHICH<>'F') then STOP;
          End;
       If (RANDOM>USERI[NUM,3]) and (WHICH<>'F') then Begin
         If (MODE=3) and (SAIL<2) then Mriteln('');
         AWVIEW(4,1);
         STOP;
        End;
      End;
        If WHICH='7' then Begin
          Mriteln('');
          If (DRANDOM mod 3+1)=2 then Begin
            Mrite('Thou hast recovered thy ');
            AWVIEW(1,NUM);
            Mriteln('!!!');
            C_WEAPON:=USERI[NUM,22];
           End
          Else Begin
           If (C_MONSTER>4) and (C_MONSTER<38) and (MODE<>3) then Begin
            Mrite('The ');
            Mrite(MONSTER[C_MONSTER]);
            Mriteln(' kicks it out of thy reach!!')
           End
          Else Mriteln('Thou hast failed to recover thy weapon!');
         End;
        End;
        If WHICH='T' then Begin
          Mriteln('Try to Escape...');
          Mriteln('');
          If ((DRANDOM mod 5+1)=3) or (C_MONSTER=41) or (C_MONSTER=42) then Begin
            Mrite('Escape successful!!!');
            FIGHT:=False;
            If (MODE=2) or (MODE=4) then EM_SEND(302);
            If (MODE<>2) and (MODE<>3) and (MODE<>5) then EM_SEND(300);
           If (C_MONSTER>4) and (C_MONSTER<38) and (MODE<>3) then Begin
            Mrite('  The ');
            Mrite(MONSTER[C_MONSTER]);
            Mriteln(' screams, "COWARD!!!!!"');
           End
           Else Mriteln('');
          End;
          If FIGHT then Begin
            If (C_MONSTER>4) and (C_MONSTER<38) and (MODE<>3) then Begin
             Mrite('The ');
             Mrite(MONSTER[C_MONSTER]);
             Mriteln(' laughs, "Oh no, thou art not going anywhere!!!!"')
            End
            Else Mriteln('Thou did not escape!!')
           End;
         If FIGHT=True then STOP;
        End;
       End;
     If FIGHT then Begin
       TARGET:='';
       If (MHP<40) and (C_MONSTER<>41) then Begin
         If (DRANDOM mod 4+1=2) and (C_MONSTER>4) and (C_MONSTER<38) and (MODE<>3) then Begin
           Mriteln('');
           Mrite('The ');
           Mrite(MONSTER[C_MONSTER]);
           Mriteln(' begs for mercy!!');
           Mriteln('');
           Mrite('Dost thou Yield? ');
           EM_SEND(503);
           WHAT(TARGET);
           If TARGET='Y' then FIGHT:=False;
           If (TARGET='Y') and ((MODE=2) or (MODE=4)) then EM_SEND(302);
           If (TARGET='Y') and (USERI[NUM,19]=5) then Begin
             Mriteln('');Mriteln('That was a real Balorian like thing to do!');
             STOP
            End;
           If (TARGET='N') and (USERI[NUM,19]=21) then Begin
             Mriteln('');Mriteln('That was a real Solnarian like thing to do!');
             STOP
            End;
           TARGET:='NO'
          End;
         If (DRANDOM mod 7+1=3) and (TARGET<>'NO') then FIGHT:=False;
         If FIGHT=False then Mriteln('');
         If (FIGHT=False) and (MODE<>2) and (MODE<>3) and (MODE<>5) then EM_SEND(300);
         If FIGHT=False then Mriteln('Thy foe flees the battle!!!!!')
       End;
      End;
      If (FIGHT=True) and (DRANDOM mod 17+1=5) and (MODE=0) then Begin
        Mriteln('');EM_SEND(300);
        Mriteln('The bartender breaks up the fight!  The patrons grumble with dissapointment.');
        FIGHT:=False
       End;
     If (FIGHT) and (TARGET<>'NO') then Begin
      If M_STUN>0 then M_STUN:=M_STUN-1;
      If M_DOWN>0 then M_DOWN:=M_DOWN-1;
      If (M_STUN>0) or (M_DOWN>0) then Mriteln('');
      If M_STUN>0 then Mriteln('Thy foe is still stunned!!!!');
      If M_DOWN>0 then Mriteln('Thy foe is unable to get up!!');
      If (M_STUN>0) or (M_DOWN>0) then STOP
     End;
     If (FIGHT=True) and (M_STUN=0) and (M_DOWN=0) and (TARGET<>'NO') then Begin
      EM_SEND(504);
      RANDOM:=0;
      If MODE=2 then RANDOM:=DRANDOM mod 3+1;
      If USERI[NUM,16]=0 then RANDOM:=1;
      If (RANDOM=2) and (MODE=2) then Begin
        Mriteln('');
        Mrite('Thy foe attacks thy horse, and ');
        RANDOM2:=DRANDOM mod 3+1;
        If RANDOM2=2 then Begin
         If ((DRANDOM mod (5+USERI[NUM,16]))<=USERI[NUM,16]) and (USERI[NUM,24]>0) then
          Mriteln('is protected by it''s armour!!!!')
         Else Begin
          DAMAGE:=DRANDOM mod 8+1;
          Mrite('hit doing ');
          Send_Num(DAMAGE);
          Mriteln(' point(s) of damage!!!!');
          HHP:=HHP-DAMAGE;
          If HHP<1 then Begin
           Mriteln('');
           Mriteln('Thy horse hast been slain!');
           ESTUFF(1,NUM,USERS[NUM,9],43);
           USERS[NUM,8]:='NONE';USERS[NUM,9]:='NONE';USERI[NUM,16]:=0
          End
          Else Begin
           Mriteln('');
           Mrite('Thy horse has ');
           Send_Num(HHP);Mriteln(' hit point(s) left...')
          End;
         End;
       End;
        If RANDOM2<>2 then Mriteln('misses!');
        STOP
      End;
     If RANDOM<>2 then Begin
       Mriteln('');
       Mrite('The ');
       Mrite(MONSTER[C_MONSTER]);
       Mrite(' attacks thee with ');
       If (C_MONSTER>4) and (C_MONSTER<38) and (MODE<>3) then Begin
         If SEX=False then Mrite('his ');
         If SEX=True then Mrite('her ')
        End
       Else Mrite('it''s ');
       WEAP:=DRANDOM mod 2+1;
       Mrite(WEAPON[CONVERT(C_MONSTER),WEAP]);
       Mriteln('!!!');Mriteln('');
       ASSA:=C_MONSTER*10;If C_MONSTER=13 then ASSA:=ASSA+200;
       If USERI[NUM,3]>400 then ASSA:=ASSA+(USERI[NUM,3]-400);
       RANDOM:=DRANDOM mod (ASSA+USERI[NUM,3])+1;
       If RANDOM<ASSA then Begin
         Mrite('It hits thy ');
         WHERE:=DRANDOM mod 4+1;
         If MODE=3 then WHERE:=5;
         Case WHERE of
           1:Mrite('head');
           2:Mrite('arms');
           3:Mrite('chest');
           4:Mrite('legs');
           5:AWVIEW(3,(SHPM div 10))
          End;
         Mrite(' doing ');
         DAMAGE:=DRANDOM mod CONVERT(C_MONSTER)+1;
         If WEAP=1 then DAMAGE:=DAMAGE+(DRANDOM mod 2+1);
         If WHERE=3 then DAMAGE:=DAMAGE+2;
         If MODE=3 then DAMAGE:=DRANDOM mod 6+1;
         Send_Num(DAMAGE);
         Mriteln(' point(s) of damage!!!!!');
         If (C_MONSTER=3) and (WEAP=2) then Begin
            If DRANDOM mod 2+1=2 then Begin
              Mriteln('');Mriteln('Thou art poisoned by the sting!');
              USERI[NUM,26]:=3
            End
           End;
         If ((USERI[NUM,23]=2) or (USERI[NUM,23]=3)) and (MODE<>3) then Begin
           Mrite('Thy ');
           AWVIEW(2,NUM);
           If USERI[NUM,22]<>0 then Mrite(' armour');
           Mriteln(' complains, "That one hurt!!!"')
          End;
         If MODE<>3 then USERI[NUM,20]:=USERI[NUM,20]-DAMAGE;
         If MODE=3 then HULL:=HULL-DAMAGE;
         If USERI[NUM,20]<0 then USERI[NUM,20]:=0;
         If HULL<0 then HULL:=0;
         If (WHERE=1) and (DRANDOM mod 6+1=3) then begin
           Mriteln('');
           Mriteln('Thou art stunned by the blow!!!');
           STUN:=DRANDOM mod 3+1
          End;
         If (WHERE=4) and (DRANDOM mod 6+1=3) then begin
           Mriteln('');
           Mriteln('Thou art knocked down by the attack!!!!');
           C_STAT:=DRANDOM mod 3+1
          End;
         If (WHERE=2) and (DRANDOM mod 3+1=2) and (C_WEAPON<>-1) then begin
           Mriteln('');
           Mrite('Thy ');
           AWVIEW(1,NUM);
           Mriteln(' is hurled from thy grasp!!!!!!');
           C_WEAPON:=-1
          End;
          Mriteln('');
         If MODE=3 then Begin
          Mrite('Thy Ship''s Hull: ');
          Send_Num(HULL);
          Mrite('/');
          Send_NUM(SHPM);
          Mriteln('');
         End;
         If MODE<>3 then Begin
          Mrite('Thy Health: ');
          Send_Num(USERI[NUM,20]);
          Mrite('/');
          Send_NUM(USERI[NUM,21]);
          Mriteln('');
         End;
         STOP;
         If (HULL=0) and (MODE=3) then FIGHT:=False;
         If (HULL=0) and (MODE=3) then USERI[NUM,8]:=0;
         If USERI[NUM,20]=0 then FIGHT:=False;
         If USERI[NUM,20]=0 then OVER:=True;
         If USERI[NUM,20]=0 then DEATH:=MONSTER[C_MONSTER]
       End;
       If RANDOM>=ASSA then Begin
         AWVIEW(4,2);
         STOP;
        End;
      End;
     End; {Monster}
    Until FIGHT=False;
   End;
   If (HULL=0) and (MODE=3) then GTT:=True;HALF:=False;
  End;
(**** ENCOUNTER -*- Previous to BattlePhase (Usually) *********************)
  Procedure ENCOUNTER(MODE:Integer;Var NUM:Integer;Var OVER:Boolean);
      Var
        SEX,FOUGHT:Boolean;
        GUESSER,COUNT,GUESSER2:Integer;
        REACT,SURE:Str255;
        AHINT:String[160];
        ANAME:Text;
    Begin
      If MODE=0 then EM_SEND(402);
      If MODE=1 then EM_SEND(423);
      GUESSER:=(DRANDOM mod 100)+1;HALF:=True;
      REACT:=TPATH;
      INSERT('RUMOURS',REACT,((Ord(REACT[0]))+1));
      MReset(ANAME,REACT);
      For COUNT:=1 to 11 do Readln(ANAME,AHINT);
      For COUNT:=1 to GUESSER do 
        Readln(ANAME,AHINT);
      ENCRYPT(AHINT,False);
      If (VT=True) and (MODE<>1) and (EMULATE=False) then Mrite(Chr(27));SEX:=False;
      If (VT=True) and (MODE<>1) and (EMULATE=False) then Mrite('E');
      If MODE<>1 then Mriteln('');If DRANDOM mod 5+1=3 then SEX:=True;
      If (EMULATE) or (C_MONSTER=12) or (C_MONSTER=20) or (C_MONSTER=23) or (C_MONSTER=24)
         or (C_MONSTER=26) or (C_MONSTER=29) then SEX:=False;
      C_ADJECTIVE:=DRANDOM mod 30+1;FOUGHT:=False;
      C_MONSTER:=DRANDOM mod 36+1;
      If C_MONSTER<5 then C_MONSTER:=9;
      EM_SEND((600+C_MONSTER)-1);
      EM_SEND(303);
      Mrite('Thou dost meet a ');
      Mrite(ADJECTIVE[C_ADJECTIVE]);
      Mrite(' ');
      Mrite(MONSTER[C_MONSTER]);
      Mriteln('!');
      GUESSER:=DRANDOM mod 5+1;If MODE=2 then GUESSER:=2;
      If (MODE=1) and (GUESSER=3) then Begin
        Mriteln('');If SEX then Mrite('She ');
        If SEX=False then Mrite('He ');
        Mriteln('says, "Hey Thief!  Come over here, I''ve got something to show thee!"');
        Mriteln('');Mrite('Dost thou go? ');
        WHAT(SURE);Mriteln('');
        If SURE='N' then Mriteln('"So be it..."');
        If (SURE='N') and (EMULATE) then STOP;
        If SURE='Y' then Begin
          Mriteln('"Now Meet My Friends!!!!!!!!!"  Six Skeletons step out of the shadows...');
          EM_SEND(107);GUESSER2:=C_MONSTER;C_MONSTER:=4;FOUGHT:=True;
          For COUNT:=1 to 6 do Begin
           If OVER=False then EM_SEND((600+C_MONSTER)-1);
           If OVER=False then COMBAT(5,OVER,SEX)
           End;
          C_MONSTER:=GUESSER2;
          If OVER=False then EM_SEND((600+C_MONSTER)-1);
          If OVER=False then COMBAT(MODE,OVER,SEX)
        End;
       End;
      If (MODE=0) and (GUESSER=3) then Begin
        GUESSER2:=DRANDOM mod 2+1;Mriteln('');
        Begin
          If SEX then Mrite('She ');
          If SEX=False then Mrite('He ');
          If GUESSER2=1 then Mriteln
           ('says, "Would''st thou be so kind to buy me a meal?  I''m low on gold."');
          If GUESSER2=2 then Mriteln('says, "Buy me some food NOW, FOOL!!!!!"');
          Mriteln('');
          Mrite('It would cost 80 gold, do it? ');
          If EMULATE then VT:=False;WHAT(SURE);If EMULATE then VT:=True;Mriteln('');
          If (SURE='N') and (GUESSER2=1) then Mriteln('"Thank thee anyway..."');
          If (SURE='N') and (GUESSER2=1) and (EMULATE) then STOP;
          If (SURE='N') and (GUESSER2=2) then FOUGHT:=True;
          If (SURE='N') and (GUESSER2=2) then COMBAT(MODE,OVER,SEX);
          If SURE='Y' then Begin
            If USERI[NUM,4]<=80 then Mriteln('Thou hast not the gold...')
             Else Begin
             If GUESSER2=2 then Mriteln('"Now get out of my face!"');
             If GUESSER2=1 then Begin
               If DRANDOM mod 2+1=2 then Mriteln('"Thank thee!  I''ve been starving!"')
                 Else Begin
                   If SEX then Mrite('She whispers, "');
                   If SEX=False then Mrite('He mentions, "');
                   Mriteln(AHINT)
             End
            End
           End;
            IF EMULATE then STOP
          End;
         End;
       End;
      If GUESSER<>3 then Begin
       GUESSER2:=DRANDOM mod 6+1;
      If GUESSER2=1 then Begin
        Mriteln('');
        If SEX then Mrite('She ');
        If SEX=False then Mrite('He ');
        Mrite('says, "Art thou a friend?" ');
        WHAT(SURE);Mriteln('');
        If SURE='N' then FOUGHT:=True;
        If SURE='N' then COMBAT(MODE,OVER,SEX);
        If SURE='Y' then Begin
        If DRANDOM mod 2+1=2 then Mriteln('"Might peace fill thy soul!"')
          Else Begin
            If SEX then Mrite('She sighs, "');
            If SEX=False then Mrite('He murmurs, "');
            Mriteln(AHINT);
           End;
          If EMULATE then STOP
        End;
       End;
      If GUESSER2=2 then Begin
        Mriteln('');
        If SEX then Mrite('She ');
        If SEX=False then Mrite('He ');
        Mrite('says, "I don''t like thy looks!  Perish by my wrath!"');
        Mriteln('');
        COMBAT(MODE,OVER,SEX);FOUGHT:=True
       End;
      If GUESSER2>2 then Begin
        Mriteln('');
        If SEX then Mrite('She ');
        If SEX=False then Mrite('He ');
        Mrite('says, "');
        If (USERI[NUM,19]=5) and (C_MONSTER=11) then Mriteln('Hail Brother!"')
        Else If DRANDOM mod 3+1=2 then Mriteln('What dost thou want?"')
          Else Mriteln('Greetings..."');Mriteln('');
        Mrite('Thy Reaction? ');
        If (C_MONSTER=27) or (C_MONSTER=29) then Mrite('[R]equest Healing, ');
        If C_MONSTER=14 then Mrite('[R]equest Advice, ');
        Mrite('[C]hallenge, [A]sk for guidance, [L]eave: ');
        Repeat
          SOMETHING(REACT);
        Until (REACT='C') or (REACT='A') or (REACT='L') or
              ((REACT='R') and ((C_MONSTER=27) or (C_MONSTER=29) or (C_MONSTER=14)));
        Mriteln(REACT);Mriteln('');
        If REACT='C' then Begin
          If DRANDOM mod 6+1=3 then Mriteln('Thy foe refuses thy challenge and leaves!')
            Else Begin
              Mriteln('Thy foe says, "Die, oh vile Knave!!!"');FOUGHT:=True;
              COMBAT(MODE,OVER,SEX)
             End;
           End;
        If (REACT='R') and (C_MONSTER=14) then Begin
            Mriteln('Thou dost trade cunning methods of trickery...');
            Mriteln('Enlightening indeed!!  Thy Skill +4!');
            If EMULATE then STOP;
            USERI[NUM,3]:=USERI[NUM,3]+4
          End;
        If (REACT='R') and ((C_MONSTER=27) or (C_MONSTER=29)) then Begin
           If SEX then Mrite('She whispers, "');
           If SEX=False then Mrite('He says, "');
           If USERI[NUM,19]=5 then Mriteln('I''ll not help a soul so dark!!!"')
            Else Begin
               Mriteln('Walk now into the light of Solnar!  Thou art healed by his grace!"');
               USERI[NUM,20]:=USERI[NUM,21]
              End;
           If EMULATE then STOP
          End;
        If REACT='L' then Mriteln('Thou dost ignore the interaction...');
        If (REACT='L') and (EMULATE) then STOP;
        If REACT='A' then Begin
          Mrite('The ');Mrite(MONSTER[C_MONSTER]);Mrite(' says, "');
          If DRANDOM mod 4+1=3 then Begin
            Mriteln('I''ve none to give..."');
            If EMULATE then STOP
           End
            Else Begin
              Mriteln(AHINT);
              If EMULATE then STOP;
              End;          
          End;
        End;
       End;
      If OVER=False then Begin
        If FOUGHT=False then Begin
          If (MODE<>2) and (MODE<>3) then EM_SEND(300);
          Mriteln('');Mrite('The ');Mrite(MONSTER[C_MONSTER]);Mriteln(' leaves...');
          If MODE=2 then EM_SEND(302)
       End;
      End;
      If (MODE<>2) and (MODE<>3) then EM_SEND(300);C_ADJECTIVE:=0;HALF:=False
    End;
(**** JOB GENERATOR 1 - Tavern  2 - Inn  3 - Bank *************************)
  Procedure JOBS(Var NUM:Integer;Var JOB:Integer;Var LJOB:Integer);
    Var
      RANDOM:Long_Integer;
      TOTAL,HOURS:Integer;
      GOT:Boolean;
      JUNK,TNAME:Str255;
    Begin
      GOT:=TRUE;
      Mriteln('');
      If LJOB>0 then Begin
        RANDOM:=DRANDOM Mod 3+1;
        If RANDOM=3 then LJOB:=DRANDOM Mod 5+1
       End;
      If LJOB=0 then LJOB:=DRANDOM Mod 5+1;
     If JOB=2 then Begin
      Case LJOB of
        2:TNAME:='Bellhop';
        3:TNAME:='Desk Clerk';
        4:TNAME:='Janitor';
        5:TNAME:='Host'
       End {Case}
      End;
     If JOB=3 then Begin
      Case LJOB of
        2:TNAME:='Clerk';
        3:TNAME:='Manager';
        4:TNAME:='Janitor';
        5:TNAME:='Guard'
       End {Case}
      End;
      If (JOB=2) or (JOB=3) then Begin
        If LJOB=1 then Mriteln ('Sorry, but we have no jobs available at this time...');
        If LJOB=1 then GOT:=FALSE;
        If LJOB<>1 then Begin
          If LJOB=2 then Begin
            TOTAL:=20;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a ');
            Mrite(TNAME);
            Mrite(' for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an hour.')
           End;
          If LJOB=3 then Begin
            TOTAL:=30;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a ');
            Mrite(TNAME);
            Mrite(' for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an hour.')
           End;
          If LJOB=4 then Begin
            If JOB=2 then TOTAL:=18;
            If JOB=3 then TOTAL:=25;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a ');
            Mrite(TNAME);
            Mrite(' for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an hour.')
           End;
          If LJOB=5 then Begin
            If JOB=2 then TOTAL:=35;
            If JOB=3 then TOTAL:=50;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a ');
            Mrite(TNAME);
            Mrite(' for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an hour.')
           End
          End
         End;
     If JOB=1 then Begin
        If LJOB=2 then Mriteln ('Try later, we don''t need anyone now...');
        If LJOB=2 then GOT:=FALSE;
        If LJOB<>2 then Begin
          If LJOB=1 then Begin
            TOTAL:=18;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a Dishwasher for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an Hour.')
           End;
          If LJOB=3 then Begin
            TOTAL:=40;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a Bouncer for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an Hour.')
           End;
          If LJOB=4 then Begin
            TOTAL:=35;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a Bartender for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an Hour.')
           End;
          If LJOB=5 then Begin
            TOTAL:=29;
            TOTAL:=TOTAL+(DRANDOM Mod 10+1);
            HOURS:=DRANDOM Mod 10+2;
            Mrite ('We need someone to be a Waiter for ');
            Send_Num(HOURS);
            Mrite(' hours for ');
            Send_Num(TOTAL);
            Mriteln(' Gold Pieces an Hour.')
           End
          End
         End;
        If GOT=TRUE then Begin
          Mriteln('');
          Mrite ('Take it? ');
          WHAT(JUNK);
          If JUNK='Y' then Begin
            Mriteln('');
            If USERI[NUM,6]<HOURS then Mriteln ('Not enough time left today!');
            If (JOB=2) and (USERI[NUM,6]>=HOURS) then Begin
              If (LJOB=3) or (LJOB=5) then Begin
                If (USERS[NUM,4][1]='C') or (USERS[NUM,5][1]='C') or (USERS[NUM,6][1]='C') then Begin
                  Mrite ('Sorry, but finer clothes are required for this job...');
                  Mriteln('');
                  HOURS:=100
                 End
               End
              End;
            If (JOB=1) and (USERI[NUM,6]>=HOURS) then Begin
              If (LJOB=3) or (LJOB=4) or (LJOB=5) then Begin
                If (USERS[NUM,4][1]<>'E') or (USERS[NUM,5][1]<>'E') or (USERS[NUM,6][1]<>'E') then Begin
                  Mrite ('Sorry, but thy apparel is inappropriate for this job...');
                  Mriteln('');
                  HOURS:=100
                 End
               End
              End;
            If USERI[NUM,6]>=HOURS then Begin
              USERI[NUM,4]:=USERI[NUM,4]+(TOTAL*HOURS);
              USERI[NUM,6]:=USERI[NUM,6]-HOURS;
              Mrite ('After ');
              Send_Num(HOURS);
              Mrite(' hours, thou made ');
              Send_Num(TOTAL*HOURS);
              Mriteln(' Gold Pieces!');
              LJOB:=0
             End
           End
         End;
        STOP
      End;
(**************************************************************************)
  Procedure JAIL(NUM:Integer;Var OVER:Boolean);
    Var
      JAILP,JUNK:Str255;
      TOTAL,COND:Integer;
      RANDOM:Long_Integer;
    Begin
      OVER:=TRUE;
      If UJAILL then USERI[NUM,7]:=USERI[NUM,7]+1;
      USERI[NUM,7]:=USERI[NUM,7]+1;
      Mriteln('');
      Mriteln ('The guards are taking thee to jail!');Mriteln('');
      Mriteln ('Dost thou wish to:');Mriteln('');
      If ((USERI[NUM,21]>54) and (USERI[NUM,21]<101)) then Mriteln ('[A]ttack the guards!');
      Mriteln ('[T]ry to Escape.');
      Mriteln ('[P]ay Thy Bail.');
      Mriteln ('[G]o to Jail.');Mriteln('');
      Mrite ('Thy Selection: ');
     Repeat
      SOMETHING(JAILP);
      If (JAILP='A') and (USERI[NUM,21]>54) and (USERI[NUM,21]<101) then Begin
        OVER:=False;USERI[NUM,7]:=0;
        EM_SEND(423);
        Mriteln('Attack...');Mriteln('');
        C_MONSTER:=21;
        EM_SEND((600+C_MONSTER)-1);
        EM_SEND(303);
        COMBAT(1,OVER,False);
        If OVER=False then EM_SEND((600+C_MONSTER)-1);
        If OVER=False then EM_SEND(303);
        If OVER=False then COMBAT(1,OVER,False);
        If OVER=False then STOP
       End;
      If JAILP='T' then Begin
        Mriteln ('Try to Escape!');Mriteln('');
        Mriteln ('Thou dost wait until the guards are not looking...');
        Mriteln('');Mrite ('Press [RETURN] to attempt thy escape!');
        QSTOP;
        TOTAL:=TOWNI[USERI[NUM,14],8]+USERI[NUM,3];
        RANDOM:=DRANDOM mod TOTAL+1;
        If RANDOM<USERI[NUM,3] then Begin
          Mriteln('');Mriteln ('Thou hast gotten away!');
          TOTAL:=1;COND:=15;
          ESTUFF(TOTAL,NUM,JUNK,COND);
          USERI[NUM,7]:=0;
          USERI[NUM,5]:=USERI[NUM,5]+513;
          OVER:=FALSE
         End;
        If RANDOM>USERI[NUM,3] then Begin
          EM_SEND(408);EM_SEND(699);EM_SEND(303);
          Mriteln('');Mriteln ('The guards caught thee!');
          TOTAL:=1;COND:=17;
          ESTUFF(TOTAL,NUM,JUNK,COND);
          USERI[NUM,7]:=USERI[NUM,7]+1;
          Mriteln('');Mrite ('Thou art in jail for ');
          Send_Num(USERI[NUM,7]);
          Mriteln(' day(s)!!');
          TOTAL:=1;COND:=13;
          ESTUFF(TOTAL,NUM,JUNK,COND);
          If EMULATE then STOP;EM_SEND(300)
         End
        End;
       If JAILP='P' then Begin
         Mriteln ('Pay Thy Bail.');Mriteln('');
         Mrite ('The Guards tell thee, "Bail will cost ');
         Send_Num(USERI[NUM,7]*500);
         Mriteln(' Gold Pieces."');
         Mrite ('Still pay? ');
         WHAT(JUNK);
         If JUNK='Y' then Begin
           If USERI[NUM,4]<USERI[NUM,7]*500 then Mriteln
           ('The Guards say angrily, "Thou Dost not have the Gold!!"');
           If USERI[NUM,4]=USERI[NUM,7]*500 then Mriteln ('That would leave thee broke!');
           If USERI[NUM,4]>USERI[NUM,7]*500 then Begin
             Mriteln('');
             Mriteln ('Thou hast paid thy bail!  The Guards reluctantly let thee go...');
             TOTAL:=1;COND:=18;
             ESTUFF(TOTAL,NUM,JUNK,COND);
             OVER:=FALSE;
             USERI[NUM,4]:=USERI[NUM,4]-USERI[NUM,7]*500;
             USERI[NUM,7]:=0
            End
          End
         End;
        If JAILP='G' then Begin
          Mriteln ('Go to Jail.');
          EM_SEND(408);EM_SEND(699);EM_SEND(303);
          Mriteln('');
          Mrite ('Thou art in jail for ');
          Send_Num(USERI[NUM,7]);
          Mriteln(' Day(s)!!');
          TOTAL:=1;COND:=13;
          ESTUFF(TOTAL,NUM,JUNK,COND);
          If EMULATE then STOP;EM_SEND(300)
         End;
     Until (JAILP='T') or (JAILP='P') or (JAILP='G') or
      ((JAILP='A') and (USERI[NUM,21]>54) and (USERI[NUM,21]<101));
     If (OVER=True) and (USERI[NUM,20]>0) then Begin
       Mriteln('');
       Mrite ('Dost thou wish to send a message to someone? ');
       WHAT(JUNK);
       TOTAL:=1;COND:=16;
       If JUNK='Y' then ESTUFF(TOTAL,NUM,JUNK,COND)
      End
     End;
(**************************************************************************)
  Procedure VISITJAIL(NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      JAILP,JUNK,SURE:Str255;
      C,WHICH,TOTAL,COND,IS:Integer;
      RANDOM:Long_Integer;
      UNI:Boolean;
    Begin
      UNI:=False;EM_SEND(408);EM_SEND(301);
      Repeat
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('E');
        ABLE:=True;
        Mriteln('');
        Mrite ('Thou art at the -=* ');
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('b1');
        Mrite(TOWNS[USERI[NUM,14],1]);
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('b3');
        Mriteln(' *=- Jail.');
        Mriteln('');
        Mriteln ('1 - Look at thieves currently in jail.');
        Mriteln ('2 - Pay someone''s bail.');
        Mriteln ('3 - Try to help someone escape from jail.');
        Mriteln ('4 - Leave...');
        ABLE:=False;SOFF:=False;
        Mriteln('');Mrite ('The Guards watch thee closely: ');
        Meadln (JAILP);
        If JAILP='1' then Begin
          JAILVIEW(NUM,C);
          If C=0 then Mriteln ('No Guild Members are currently in this jail!');
          STOP
         End;
        If JAILP='2' then Begin
          JAILVIEW(NUM,C);
          If C=0 then Begin
            Mriteln ('This jail is currently empty.');
            STOP
          End;
          If C>0 then Begin
           Repeat
            Mrite ('Pay which thief''s bail? [?=List] [Return Aborts]: ');
            IS:=1;
            ASK(NUM,WHICH,IS,UNI);
           Until (WHICH>0) or (WHICH=-1);
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
             End;
            If (WHICH>0) and (SURE='Y') then Begin
              If USERI[WHICH,7]=0 then Mrite (USERS[WHICH,3]);
              If USERI[WHICH,7]=0 then Mriteln (' is not in jail!');
              If USERI[WHICH,7]>0 then Begin
                Mriteln('');Mrite (USERS[WHICH,3]);
                Mrite(' has ');
                Send_Num(USERI[WHICH,7]);
                Mriteln(' Day(s) left.');
                Mriteln('');Mrite ('Bail would cost thee ');
                Send_Num(USERI[WHICH,7]*500);
                Mriteln(' Gold Pieces.');
                Mrite ('Dost thou still wish to pay? ');
                WHAT(JUNK);
                If JUNK='Y' then Begin
                  If USERI[NUM,4]<USERI[WHICH,7]*500 then Mriteln ('Thou dost not have Enough Gold!');
                  If USERI[NUM,4]=USERI[WHICH,7]*500 then Mriteln ('That Would Leave Thee Broke!');
                  If USERI[NUM,4]>USERI[WHICH,7]*500 then Begin
                    USERI[NUM,4]:=USERI[NUM,4]-USERI[WHICH,7]*500;
                    USERI[WHICH,7]:=0;
                    Mriteln('');Mriteln ('Paid!');
                    Mriteln('');Mrite(USERS[WHICH,3]);
                    Mriteln(' is now out of Jail!');
                    COND:=9;
                    ESTUFF(WHICH,NUM,JUNK,COND)
                   End
                  End
                 End
                End;
                STOP
               End
           End;
        If JAILP='3' then Begin
          JAILVIEW(NUM,C);
          If C=0 then Begin
            Mriteln ('There are no thieves in this jail!');
            STOP
          End;
          If C>0 then Begin
           Repeat
            Mrite ('Help which thief to escape? [?=List] [Return Aborts]: ');
            IS:=1;
            ASK(NUM,WHICH,IS,UNI);
           Until (WHICH>0) or (WHICH=-1);
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
             End;
            If (WHICH>0) and (SURE='Y') then Begin
              If USERI[WHICH,7]=0 then Mrite (USERS[WHICH,3]);
              If USERI[WHICH,7]=0 then Mriteln(' is not in jail!');
              If USERI[WHICH,7]>0 then Begin
                Mriteln('');Mrite ('Press [RETURN] to help ');
                Mrite(USERS[WHICH,3]);
                Mrite(' Escape!');
                QSTOP;
                TOTAL:=100+USERI[NUM,3];
                RANDOM:=DRANDOM mod TOTAL+1;
                If RANDOM>100 then Begin
                  USERI[WHICH,7]:=0;
                  Mriteln('');Mrite ('SUCCESSFUL!! ');
                  Mrite(USERS[WHICH,3]);
                  Mriteln(' is now free!');
                  USERI[NUM,5]:=USERI[NUM,5]+300;
                  COND:=11;
                  ESTUFF(WHICH,NUM,JUNK,COND)
                 End;
                If RANDOM<100 then Begin
                  Mriteln('');Mriteln ('Thou Hast FAILED!');
                  Mriteln('');Mriteln ('The Guards hold a sword to thy neck!');
                  Mriteln ('A Guard Says, "Ye two going somewhere?"');
                  COND:=10;
                  ESTUFF(WHICH,NUM,JUNK,COND);
                  JAIL(NUM,OVER)
                 End
                End
              End
            End
         End;
        MAKESURE(NUM,SUN,OVER);
        Until (JAILP='4') or (OVER=TRUE);
        If OVER=FALSE then STOP;
        If OVER=False then Mriteln('')
    End;
(**  -/* USE A MAGICK ITEM *\- ********************************************)
  Procedure MAGICK(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      ATA,UNI:Boolean;
      CH1,SURE:Str255;
      CH2,WHICH,IS,ELE:Integer;
    Begin
      If VT=True then Mrite(Chr(27));ATA:=False;UNI:=True;
      If VT=True then Mrite('E');
      Mriteln('');Mriteln('        -==*/  Thy Enchanted Items  \*==-');
      Mriteln('');
      If WATERS=True then Begin
        Mriteln('#20  Vial of Waters.');
        ATA:=True
       End;
      If HORN=True then Begin
        Mriteln('#21  Horn of Plenty.');
        ATA:=True
       End;
      If FAIRY=True then Begin
        Mriteln('#22  Fairy Wood.');
        ATA:=True
       End;
      If USERI[NUM,28]>0 then Begin
        Mrite('#28  ');
        Send_Num(USERI[NUM,28]);
        Mriteln(' Poison Dart(s).');
        ATA:=True
       End;
      If USERI[NUM,29]=2 then Begin
        Mriteln('#29  Medallion of Wisdom.');
        ATA:=True
       End;
      If USERI[NUM,30]>0 then Begin
        If USERI[NUM,30]=1 then Mriteln('#30  A magical ring. [Un-Identified]');
        If USERI[NUM,30]=2 then Mriteln('#30  Ring of Telepathy.');
        ATA:=True
       End;
      If USERI[NUM,31]>0 then Begin
        If USERI[NUM,31]=1 then Mriteln('#31  A magic wand. [Un-Identified]');
        If USERI[NUM,31]=2 then Mriteln('#31  Wand of the Elements!');
        ATA:=True
       End;
      If USERI[NUM,32]=2 then Begin
        Mriteln('#32  Key of the Ancient Ones.');
        ATA:=True
       End;
      If (USERI[NUM,34]=1) or (USERI[NUM,34]=2) then Begin
        Mriteln('#34  Amulet of Insight.');
        ATA:=True
       End;
      If USERI[NUM,34]=3 then Begin
        Mriteln('#34  Elvin Whistle.');
        ATA:=True
       End;
      If USERI[NUM,35]>0 then Begin
        If USERI[NUM,35]=1 then Mriteln('#35  A magical ring. [Un-Identified]');
        If USERI[NUM,35]=2 then Mriteln('#35  Ring of the Skull.');
        ATA:=True
       End;
      If USERI[NUM,36]>0 then Begin
        If USERI[NUM,36]=1 then Mriteln('#36  A magical ring. [Un-Identified]');
        If USERI[NUM,36]=2 then Mriteln('#36  Ring of Time.');
        ATA:=True
       End;
      If USERI[NUM,37]>0 then Begin
        Mrite('#37  ');
        Send_Num(USERI[NUM,37]);
        Mriteln(' Magic Crystal(s).');
        ATA:=True
       End;
      If ATA=False then Mriteln('Thou hast no enchanted Items...')
      Else Begin
       Repeat
        Mriteln('');Mrite('Use which Item of magic? (0=none): ');
        Meadln(CH1);
        BUGPROOF(CH1,CH2)
       Until ((CH2>19) and (CH2<38)) or (CH2=0);
       Mriteln('');
      If CH2<>0 then Begin
       If ((CH2=33) or (USERI[NUM,CH2]=0)) and (CH2>26) then Mriteln('Item doesn''t Exist!');
       If CH2<27 then Begin
         If (CH2=20) and (WATERS=False) then Mriteln('Item doesn''t Exist!');
         If (CH2=20) and (WATERS=True) then Begin
           Mrite('Use the Vial? ');
           WHAT(SURE);If SURE='Y' then Begin
           Mriteln('');Mriteln('Thou dost drink until thy thirst hast been relieved...');
           USERI[NUM,11]:=45
           End;
          End;
         If (CH2=21) and (HORN=False) then Mriteln('Item doesn''t Exist!');
         If (CH2=21) and (HORN=True) then Begin
           Mrite('Use the Horn? ');WHAT(SURE);
           If SURE='Y' then Begin
           Mriteln('');Mriteln('Thou dost eat to thy fill...');
           USERI[NUM,10]:=45
           End;
          End;
         If (CH2=22) and (FAIRY=False) then Mriteln('Item doesn''t Exist!');
         If (CH2=22) and (FAIRY=True) then Begin
           Mrite('Use the Fairy Wood? ');
           WHAT(SURE);If SURE='Y' then Begin
           Mriteln('');Mriteln('No apparent effect...');
          End;
          End;
         End
        Else Begin
         If (CH2=29) and (USERI[NUM,29]>1) then Begin
           Mrite('Use the Medallion? ');WHAT(SURE);
           If SURE='Y' then Begin
           Mriteln('');Mriteln('Thou art wearing the Medallion, but there seems to be no effect...');
           End;
          End;
         If (CH2=30) and (USERI[NUM,30]>0) then Begin
           Mrite('Use the ring? ');WHAT(SURE);
           If SURE='Y' then Begin
           Mriteln('');Mriteln('Thou dost invoke ring''s powers of telepathy...');
           USERI[NUM,30]:=2;
           ESTUFF(WHICH,NUM,'THEPASS',19)
           End;
          End;
         If (CH2=31) and (USERI[NUM,31]>0) then Begin
           Mrite('Use the Wand? ');WHAT(SURE);
           If SURE='Y' then Begin
           USERI[NUM,31]:=2;
           Mriteln('');Mriteln('As soon as thou dost pick up the wand there is a clap of thunder!!!');
          Repeat
           Mriteln('');
           Mriteln('The brisk winds flow through thy hair...');
           Mriteln('');
           Mriteln ('2  - Becalmed.');
           Mriteln ('3  - Extreme Light Breeze.');
           Mriteln ('4  - Light Breeze.');
           Mriteln ('5  - Moderate Breeze.');
           Mriteln ('7  - Normal Winds.');
           Mriteln ('9  - Strong Breeze.');
           Mriteln ('10 - High Winds.');
           Mriteln ('11 - Extreme High Winds (Light Rain).');
           Mriteln ('12 - Gale! (Dangerous).');
           Mriteln('');Mrite('Summon Which? ');
           Meadln(SURE);
           BUGPROOF(SURE,ELE);
          Until (ELE>1) and (ELE<13);
          ELEMENT:=ELE;Mriteln('');Mriteln('The Elements obey!!!!!')
          End;
         End;
         If (CH2=32) and (USERI[NUM,32]=2) then Begin
           Mrite('Use the Key? ');WHAT(SURE);
           If SURE='Y' then Begin
           Mriteln('');
           If (LOCK=False) or (USERI[NUM,14]<>13) then Mriteln('Thou cannot find a lock!!');
           If (LOCK=True) and (USERI[NUM,14]=13) then Begin
             Mriteln('The Silver Pyramid reveals it''s entrance!!!!!!!!!!!!');
             KEY:=True
            End;
           End;
          End;
         If (CH2=35) and (USERI[NUM,35]>0) then Begin
           Mrite('Use the Ring? ');WHAT(SURE);
           If SURE='Y' then Begin
           Mriteln('');
           If USERI[NUM,35]=2 then Mriteln('The ring is clamped on thy finger''s stub.');
           If USERI[NUM,35]=1 then Begin
             Mriteln('Thou dost put the ring on thy finger, the skull''s eyes glow brightly!!!');
             EM_SEND(107);
             Mriteln('');Mriteln('The mouth closes and the ring tightens!  Thy finger hast been amputated!');
             USERI[NUM,35]:=2;
             USERI[NUM,3]:=USERI[NUM,3]-(USERI[NUM,3] div 5);
             Mriteln('1/5th of thy skill hast been DESTROYED!!!!!!!!!!!!!!!');
           End;
           End;
          End;
         If (CH2=34) and (USERI[NUM,34]>0) then Begin
           Mrite('Use it, art thou sure? ');WHAT(SURE);
           If SURE='Y' then Begin
           Mriteln('');
           If USERI[NUM,34]=2 then Mriteln('Thou art already wearing the amulet...');
           If USERI[NUM,34]=1 then Begin
             Mriteln('Thou dost put the amulet about thy neck, with no apparent effect.');
             USERI[NUM,34]:=2
            End;
           If USERI[NUM,34]=3 then Begin
             Mriteln('The whistle spews forth an eerie tune.............');
             EM_SEND(130);
             If USERI[NUM,14]=13 then Begin
               Mriteln('');Mriteln
                ('A keyhole traced by flickering blue light appears on the Northern Pyramid!!!');
               LOCK:=True
              End
            End;
           End;
          End;
         If (CH2=36) and (USERI[NUM,36]>0) then Begin
           Mrite('Use the ring? ');WHAT(SURE);
           If SURE='Y' then Begin
           Mriteln('');
           If USERI[NUM,36]=1 then Mriteln('Thou dost place the Ring of Time on thy finger...');
           If USERI[NUM,36]=2 then Mriteln('Thou art already wearing it.  Thy day''s time will increase daily.');
           USERI[NUM,36]:=2;
          End;
         End;
         If (CH2=37) and (USERI[NUM,37]>0) then Begin
           Mrite('Use a Magic Crystal? ');
           WHAT(SURE);
           If SURE='Y' then Begin
             USERI[NUM,37]:=USERI[NUM,37]-1;
             Mriteln('');
             Repeat
               IS:=DRANDOM mod 25+1
             Until (IS<>8) and (IS<>USERI[NUM,14]);
           USERI[NUM,14]:=IS;
           Mriteln('Thou art teleported to a different town!!!');
           EM_SEND(IS)
          End;
         End;
         If (CH2=28) and (USERI[NUM,28]>0) then Begin
           Mrite('Use a dart? ');WHAT(SURE);If SURE='Y' then Begin
           Mriteln('');
           Repeat
             Mrite ('Poison who? [?=List] [Return Aborts]: ');
             IS:=0;
             SURE:='';
             ASK(NUM,WHICH,IS,UNI);
             If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
             End;
           Until (SURE='Y') or (WHICH=-1);
           If WHICH>0 then Begin
             Mriteln('');
             If USERI[NUM,14]<>USERI[WHICH,14] then Begin
               Mriteln('Since they are not in this town, there is a high chance it will miss.');
               Mrite('Still do it? ');
               WHAT(SURE)
              End;
            If SURE='Y' then Begin
             USERI[NUM,28]:=USERI[NUM,28]-1;
             Mrite('The dart soars into the sky!  ');
             IS:=DRANDOM mod 5+1;
             If (IS=1) and (USERI[NUM,14]=USERI[WHICH,14]) then Mriteln('It misses!!!');
             If (IS<>1) and (USERI[NUM,14]<>USERI[WHICH,14]) then Mriteln('It misses!!!');
             If ((IS<>1) and (USERI[NUM,14]=USERI[WHICH,14])) or
                ((IS=1) and (USERI[NUM,14]<>USERI[WHICH,14])) then Begin
               Mrite(USERS[WHICH,3]);
               Mriteln(' has been poisoned!!!');
               EM_SEND(113);
               IS:=DRANDOM mod 20+5;
               Mrite('It will take effect in ');
               Send_Num(IS-5);
               Mriteln(' hour(s)!!!');
               USERI[WHICH,26]:=IS
               End;
              End;
             End;
            End;
           End;
          End;
         End;
        End;
        STOP;
       End;
(**************************************************************************)
  Procedure STATS(NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      JUNK:Str255;
      CANON:Boolean;
      TEMP:Long_Integer;
    Begin
     CANON:=False;JUNK:='N';
     TEMP:=USERI[NUM,8];
     If TEMP>10 then CANON:=True;
     If TEMP>10 then TEMP:=TEMP-10;
     If (OVER=FALSE) or (VIEWOK=True) then Begin
      If VIEWOK=False then Begin
       Mriteln('');Mrite ('Dost thou wish to use one of thy Magic Items? ');
       WHAT(JUNK);
       If JUNK='Y' then MAGICK(OVER,SUN);
      End;
      If JUNK='N' then Begin
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      Mriteln('');
      Mriteln ('      Thy  Status');
      Mriteln ('      +-+-+-+-+-+');
      Mriteln('');
      ABLE:=True;
      Mrite ('User Number: ');
      Send_Num(USERI[NUM,1]);Mrite('                      ');
      If USERI[NUM,1]<10 then Mrite(' ');Mrite('Armour: ');
      AWVIEW(2,NUM);If (USERI[NUM,23]=2) or (USERI[NUM,23]=3) then Mrite(' -\* Enchanted */-');
      Mriteln('');
      Mrite ('User Letter: ');
      Mrite(USERS[NUM,1]);Mrite('                       Weapon: ');
      AWVIEW(1,NUM);If (USERI[NUM,23]=1) or (USERI[NUM,23]=3) then Mrite(' -\* Enchanted */-');
      Mriteln('');
      Mrite ('Name       : ');
      Mrite(USERS[NUM,3]);Mriteln('');
      Mrite ('Skill      : ');
      Send_Num(USERI[NUM,3]);
      Mrite(' [Hit Points: ');
      Send_Num(USERI[NUM,20]);Mrite('/');Send_Num(USERI[NUM,21]);
      Mriteln(']');
      Mrite   ('Exp. Level : ');
      If USERI[NUM,3]<85 then Mriteln ('Apprentice.');
      If (USERI[NUM,3]<105) and (USERI[NUM,3]>84) then Mriteln ('Footpad.');
      If (USERI[NUM,3]<125) and (USERI[NUM,3]>104) then Mriteln ('Robber.');
      If (USERI[NUM,3]<145) and (USERI[NUM,3]>124) then Mriteln ('Burglar.');
      If (USERI[NUM,3]<165) and (USERI[NUM,3]>144) then Mriteln ('Cutpurse.');
      If (USERI[NUM,3]<185) and (USERI[NUM,3]>164) then Mriteln ('Sharper.');
      If (USERI[NUM,3]<205) and (USERI[NUM,3]>184) then Mriteln ('Pilferer.');
      If (USERI[NUM,3]<225) and (USERI[NUM,3]>204) then Mriteln ('Thief.');
      If (USERI[NUM,3]<265) and (USERI[NUM,3]>224) then Mriteln ('Master Thief.');
      If (USERI[NUM,3]<305) and (USERI[NUM,3]>264) then Mriteln ('10th Level Master Thief.');
      If (USERI[NUM,3]<345) and (USERI[NUM,3]>304) then Mriteln ('11th Level Master Thief.');
      If (USERI[NUM,3]<385) and (USERI[NUM,3]>344) then Mriteln ('12th Level Master Thief.'); 
      If (USERI[NUM,3]<455) and (USERI[NUM,3]>384) then Mriteln ('13th Level Master Thief.');
      If USERI[NUM,3]>455 then Mriteln ('14th Level Master Thief.');
      Mrite ('Gold       : ');
      Send_Num(USERI[NUM,4]);Mriteln('');
      Mrite ('Score      : ');
      Send_Num(USERI[NUM,5]);Mriteln('');
      Mrite ('Religion   : ');
      If USERI[NUM,19]=0 then Mriteln('None.');
      If USERI[NUM,19]=5 then Mriteln('Balorian.');
      If USERI[NUM,19]=11 then Mriteln('Catharian.');
      If USERI[NUM,19]=21 then Mriteln('Solnarian.');
      Mrite   ('Water Tran.: ');
      AWVIEW(3,TEMP);
      If TEMP>0 then Mrite ('. [');
      If TEMP>0 then Send_Num(TEMP*10);
      If TEMP>0 then Mrite(' Hull Pts.]');
      If CANON=True then Mrite (' (Catapult)');
      If MYSTIC then Mrite(' -=/* Mystic Winds *\=-');
      Mriteln('');
      Mrite ('Land Tran. : ');
      If USERI[NUM,16]=0 then Mriteln ('None.');
      If USERI[NUM,16]>0 then Begin
        Mrite (USERS[NUM,8]);
        Mrite(', -* ');
        Mrite(USERS[NUM,9]);
        Mrite(' *- (');
        Send_Num(USERI[NUM,16]);
        Mriteln(' H.P.)');
        Mrite('Barding    : ');
        AWVIEW(5,NUM);
        Mriteln('')
       End;
      Mrite  ('Mind Pro.  : ');
      Send_Num(USERI[NUM,13]);
      Mrite(' Day(s)');
      If USERI[NUM,27]>0 then Mrite('  Invisibility: ');
      If USERI[NUM,27]>0 then Send_Num(USERI[NUM,27]);
      If USERI[NUM,27]>0 then Mrite(' Day(s)');
      Mriteln('');
      Mrite ('Theft Pro. : ');
      Send_Num(USERI[NUM,15]);
      Mriteln(' Day(s)');
      Mriteln('');
      Mriteln ('     + Clothing +');
      Mriteln('');
      Mrite ('Head : ');
      Mriteln(USERS[NUM,4]);
      Mrite ('Chest: ');
      Mriteln(USERS[NUM,5]);
      Mrite ('Legs : ');
      Mriteln(USERS[NUM,6]);
      Mrite ('Feet : ');
      Mriteln(USERS[NUM,7]);
      ABLE:=False;SOFF:=False;
      STOP;
      Mriteln('')
     End
     End;
    End;
(**************************************************************************)
  Procedure READ(Var NUM:Integer;Var SUN:Long_Integer;Var OVER:Boolean);
    Var
      JUNK:Str255;
      A:Integer;
    Begin
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      MAKESURE(NUM,SUN,OVER);
      Mriteln('');
      If OVER=False then Begin
       ABLE:=True;
       Mriteln('');
       Mrite ('          ');
       For A:=1 to ord(TOWNS[USERI[NUM,14],1][0])+2 do
         Mrite ('*');
       Mriteln('');Mrite ('          ');
       Mrite ('|');
       If VT=True then Mrite(Chr(27));
       If VT=True then Mrite('b1');
       Mrite(TOWNS[USERI[NUM,14],1]);
       If VT=True then Mrite(Chr(27));
       If VT=True then Mrite('b3');
       Mriteln('|');
       Mrite ('          ');
       For A:=1 to ord(TOWNS[USERI[NUM,14],1][0])+2 do
         Mrite ('*');
       Mriteln('');
       Mriteln('');
       A:=TOWNI[USERI[NUM,14],7];
       Mrite ('Population:  ');
       Send_Num(A);
       If A<1000 then Mrite (' (Village)');
       If (A>999) and (A<5000) then Mrite (' (Small Town)');
       If (A>4999) and (A<15000) then Mrite (' (Large Town)');
       If A>14999 then Mrite (' (City)');
       If (USERI[NUM,14]=8) or (USERI[NUM,14]=13) or (USERI[NUM,14]=19) then
        Mrite (' -=> Magi Rule <=-');
       Mriteln('');Mrite ('Alignment :  ');
       Case TOWNI[USERI[NUM,14],19] of
         1:Mriteln ('Chaotic! [Balorian Rule]');
         2:Mriteln ('Evil. [Balorian Dominate]');
         3:Mriteln ('Neutral. [Catharian Dominate]');
         4:Mriteln ('Good. [Solnarian Dominate]');
         5:Mriteln ('Lawful! [Solnarian Rule]')
        End; {Case}
       Mrite ('Guards    :  ');
       Send_Num(TOWNI[USERI[NUM,14],8]);Mriteln('');
       Mriteln('');
       Mriteln ('  += Other Information =+');
       Mriteln('');
       Mriteln (TOWNS[USERI[NUM,14],3]);
       Mriteln (TOWNS[USERI[NUM,14],4]);
       Mriteln (TOWNS[USERI[NUM,14],5]);
       Mriteln (TOWNS[USERI[NUM,14],6]);
       ABLE:=False;SOFF:=False;
       STOP;
       Mriteln('')
     End
    End;
(**************************************************************************)
Procedure SLOTS(Var GOLD:Long_Integer);
  Var
    FRUIT:Array[1..3] of Integer;
    FRUITS:Array[1..5] of String[6];
    FRUIT1,FRUIT2,FRUIT3,ROLLS,JCO,AMCOUNT,AONE,GOLDSS:Integer;
    FIRST,TIME,GOLDS:Long_Integer;
    AMOUNT,SURE:Str255;
    DOUBLE,TRIPLE:Boolean;
  Begin
    FRUITS[1]:='Cherry';FRUITS[2]:='Orange';FRUITS[3]:='Plum';
    FRUITS[4]:='Star';FRUITS[5]:='Bar';
    Repeat
      If VT then Mrite(Chr(27));DEATH:='';
      If VT then Mrite('E');
      MAKESURE(NUM,SUN,OVER);
    If OVER=False then Begin
    ABLE:=True;
    Mriteln('');Mrite ('Thou art at the -=* ');
    If VT=True then Mrite(Chr(27));
    If VT=True then Mrite('b1');
    Mrite(TOWNS[USERI[NUM,14],1]);
    If VT=True then Mrite(Chr(27));
    If VT=True then Mrite('b3');
    Mriteln(' *=- Casino.');
    Mriteln('');
    Mriteln('2 of Kind (Orange & Up) 2 to 1');
    Mriteln('Cherry Cherry Cherry    3 to 1');
    Mriteln('Orange Orange Orange    4 to 1');
    Mriteln('Plum   Plum   Plum      5 to 1');
    Mriteln('Star   Star   Star     10 to 1');
    Mrite('Bar    Bar    Bar      JACKPOT!!! (');
    Send_Num(PROG);
    Mriteln(')');
    ABLE:=False;SOFF:=False;
     Repeat
      Mriteln('');
      Mrite('Thou hast ');Send_Num(GOLD);Mriteln(' gold piece(s).');
      Mriteln('');Mrite('Bet how much (0=cancel): ');
      Meadln(AMOUNT);BUGPROOF(AMOUNT,GOLDSS);
      GOLDS:=GOLDSS;
      If GOLDS>GOLD then Mriteln('Not enough gold!');
      If GOLDS>10000 then Mriteln('There is a 10,000 gp house limit...');
     Until ((GOLDS<=GOLD) or (GOLDS=0)) and (GOLDS<10001) and (GOLDS>-1);
     If GOLDS<>0 then Begin
       Mriteln('');
       Mrite('Bet ');Send_Num(GOLDS);Mrite(' Gold piece(s)? ');
       WHAT(SURE);
       If (SURE='Y') and (GOLDS=GOLD) then Begin
         Mrite ('That would leave thee broke!  Dost thou want to risk it? ');
         WHAT(SURE)
        End;
       If SURE='Y' then Begin
         GOLD:=GOLD-GOLDS;
         Mriteln('');
         Mriteln('Thou pullest the handle!');
         Mriteln('');TWIN;AMCOUNT:=0;
         Repeat
           AMCOUNT:=AMCOUNT+1;
           AONE:=DRANDOM mod 15+1;
           If AONE=15 then FRUIT[AMCOUNT]:=5;
           If (AONE<15) and (AONE>12) then FRUIT[AMCOUNT]:=4;
           If (AONE<13) and (AONE>9) then FRUIT[AMCOUNT]:=3;
           If (AONE<10) and (AONE>5) then FRUIT[AMCOUNT]:=2;
           If AONE<6 then FRUIT[AMCOUNT]:=1;
           If (LUCK) and (AMCOUNT=1) then FRUIT[1]:=2;
           If (LUCK) and (AMCOUNT=2) then FRUIT[2]:=2;
           If (LUCK) and (AMCOUNT=3) then FRUIT[3]:=5;
           FIRST:=Clock;
           TIME:=DRANDOM mod 4;
           If (TIME=1) or (TIME=0) then TIME:=2;
           ROLLS:=0;
             While ((Clock-FIRST)<TIME) do Begin
                ROLLS:=ROLLS+1;
                Mrite(FRUITS[ROLLS]);
                For JCO:=1 to ord(FRUITS[ROLLS][0]) do Begin
                  Mrite(Chr(8));Mrite(Chr(32));Mrite(Chr(8));
                 End;
                If ROLLS=5 then ROLLS:=0;
              End;
           Mrite(FRUITS[FRUIT[AMCOUNT]]);
           Mrite(' ');
         Until AMCOUNT=3;
         LUCK:=False;
         Mriteln('');Mriteln('');
         DOUBLE:=False;TRIPLE:=False;
         If (FRUIT[1]=FRUIT[2]) or (FRUIT[1]=FRUIT[3]) or (FRUIT[2]=FRUIT[3]) then DOUBLE:=True;
         If ((FRUIT[1]=1) and (FRUIT[2]=1)) or ((FRUIT[1]=1) and (FRUIT[3]=1)) or
            ((FRUIT[2]=1) and (FRUIT[3]=1)) then DOUBLE:=False;
         If (FRUIT[1]=FRUIT[2]) and (FRUIT[1]=FRUIT[3]) then TRIPLE:=True;
         If (TRIPLE=False) and (DOUBLE=False) then Begin
            Mrite('Thou lost ');Send_Num(GOLDS);Mriteln(' Gold Piece(s)!!!');
            PROG:=PROG+GOLDS;
            If GOLD < 1 then ESTUFF(1,NUM,TOWNS[USERI[NUM,14],1],6);
            GOLDSS:=GOLDS;
            If GOLD < 1 then GOODBYE(NUM,GOLDSS,OVER);
           End
         Else Begin
          If DOUBLE then GOLDS:=GOLDS*2;
          If TRIPLE then Begin
           If FRUIT[1]=1 then GOLDS:=GOLDS*3;
           If FRUIT[1]=2 then GOLDS:=GOLDS*4;
           If FRUIT[1]=3 then GOLDS:=GOLDS*5;
           If FRUIT[1]=4 then GOLDS:=GOLDS*10;
           If FRUIT[1]=5 then GOLDS:=PROG;
           If FRUIT[1]=5 then PROG:=0;
           If FRUIT[1]=5 then Mriteln(' J A C K P O T !!!!!!');
           If FRUIT[1]=5 then Mriteln('');
          End;
          EM_SEND(133);
          Mrite('Thou won ');Send_Num(GOLDS);Mriteln(' Gold Piece(s)!!!');
          GOLD:=GOLD+GOLDS;
         End;
       End;
      End;
      If (GOLDS<>0) and (OVER=False) then STOP;
     End;
    Until (GOLDS=0) or (OVER=True);
   End;
(**************************************************************************)
  Procedure CASINO(Var NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      GOLD,LAST,COND:Integer;
      RANDOM,GIN:Long_Integer;
      TELL,WORDS,WHICH,JUNK:Str255;
    Begin
      GIN:=USERI[NUM,4];
      LAST:=0;
      SLOTS(USERI[NUM,4]);
    If OVER=False then Begin
      Mriteln('');Mrite('The pit boss exclaims, "');
      If USERI[NUM,4]<GIN then Mriteln('So long, Knave!  Thanks for thy Gold!!  HaHa!"');
      If USERI[NUM,4]>GIN then Mriteln('Watch it, fool!  Thou might not always be so lucky."');
      If USERI[NUM,4]=GIN then Mriteln('Please come again soon, stranger..."');
      STOP
     End;
    End;
(**************************************************************************)
  Procedure TAVERN(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      ME,CHOICE,GOLDS,SURE,JUNK,DRINK,TEMP,REACT,JJJUNK:Str255;
      AHINT:String[160];
      FNAME,SNAME:Text;
      ANAME:Text;
      TOTAL,JOB,LJOB,COND,RIGHT,IS,GOLD,WHICH,D,J,RANDOM,TI,SCOUNT,SCCOUNT,
      LOCATION,CNTRS,RANNUM:Integer;
      WRONG,UNI,PLAY:Boolean;
      TIMER:Long_Integer;
    Begin
      WRONG:=True;PLAY:=False;
      LJOB:=0;JOB:=1;TOTAL:=0;
      ME:='';
      If TOWNI[USERI[NUM,14],3]>TOWNI[USERI[NUM,14],4] then
       If (USERI[NUM,6]<=TOWNI[USERI[NUM,14],3]) and (USERI[NUM,6]>=TOWNI[USERI[NUM,14],4]) then ME:='ONE';
      If TOWNI[USERI[NUM,14],3]<TOWNI[USERI[NUM,14],4] then
       If (USERI[NUM,6]>TOWNI[USERI[NUM,14],3]) or (USERI[NUM,6]<=TOWNI[USERI[NUM,14],4]) then ME:='TWO';
      If (ME='ONE') or (ME='TWO') then Begin
        If OVER=False then EM_SEND(402);
        If OVER=False then EM_SEND(301);
        Repeat
          WRONG:=False;
          If (VT=True) and (OVER=False) then Mrite(Chr(27));
          If (VT=True) and (OVER=False) then Mrite('E');
          If OVER=FALSE Then MAKESURE(NUM,SUN,OVER);
          If OVER=False then Begin
           EM_SEND(1054);
           If EMULATE=False then Begin
            ABLE:=True;
            Mriteln('');Mrite ('Thou art at the -=* ');
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('b1');
            Mrite(TOWNS[USERI[NUM,14],2]);
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('b3');
            Mriteln(' *=- Tavern.');
            Mriteln ('Music of Olde springs from the minstrels'' instruments...');
            Mriteln('');Mriteln (' [1]  Order some food.');
            Mriteln (' [2]  Buy a Drink.');
            Mriteln (' [3]  Apply for a Job.');
            Mriteln (' [4]  Talk to a Patron.');
            Mriteln (' [5]  Talk to the Bartender.');
            Mriteln (' [6]  Say something to a Guild Member.');
            Mriteln (' [7]  Say something to Everyone!');
            Mriteln (' [8]  Give someone some Gold.');
            Mriteln (' [9]  Listen to a Guild Rumour.');
            Mriteln (' [10] Tell a Guild Rumour.');
            Mriteln (' [11] Try to steal Something.');
            Mriteln('');Mriteln (' [12]  Leave the Tavern...');
            ABLE:=False;SOFF:=False;End;
            Mriteln('');Mrite ('The Fireplace crackles, dimly illuminating the Tavern: ');
            Meadln (CHOICE);
           End;
         If OVER=False then Begin
          If (CHOICE='2') or (CHOICE='1') then Begin
            If EMULATE=False then ABLE:=True;
            If CHEAT2<>97 then Repeat
              C_MONSTER:=21;
              EM_SEND((600+C_MONSTER)-1);
              EM_SEND(303);
              COMBAT(1,OVER,False);
              If USERI[NUM,20]<1 then HALT
             Until False;
            Mriteln('');Mriteln ('The Bartender walks over to thee, "What will it be, Adventurer?"');
           Repeat
           If CHOICE='2' then Begin
            EM_SEND(1071);
           If EMULATE=False then Begin
            Mriteln('');Mriteln ('1 - Water.');
            Mriteln ('2 - Fruit Juice.');
            Mriteln ('3 - Beer.');
            Mriteln ('4 - Ale.');
            Mriteln ('5 - Wine.');
            Mriteln ('6 - Brandy.');
            Mriteln ('7 - Sasperilla.')
           End;
            ABLE:=False;SOFF:=False;
           End;
           If CHOICE='1' then Begin
             If EMULATE=False then ABLE:=True;
             EM_SEND(1070);
            If EMULATE=False then Begin
             Mriteln('');Mriteln ('1 - Tossed Salad.');
             Mriteln ('2 - Spiced Potato.');
             Mriteln ('3 - Crayfish.');
             Mriteln ('4 - Roast Chicken.');
             Mriteln ('5 - Bowl of Fruit.');
             Mriteln ('6 - Griffin Rib.');
             Mriteln ('7 - Dragon Steak.');
            End;
             ABLE:=False;SOFF:=False;
            End;
            Mriteln('');Mrite ('The Bartender studies thee: ');
            Meadln(GOLDS);
            BUGPROOF(GOLDS,GOLD);
           Until (GOLD>0) and (GOLD<8);
            If CHOICE='1' then Begin
            Case GOLD of
              1:DRINK:='Tossed Salad';
              2:DRINK:='Spiced Potato';
              3:DRINK:='Crayfish';
              4:DRINK:='Roast Chicken';
              5:DRINK:='Bowl of Fruit';
              6:DRINK:='Griffin Rib';
              7:DRINK:='Dragon Steak'
             End; {Case}
            End;
            If CHOICE='2' then Begin
            Case GOLD of
              1:DRINK:='Water';
              2:DRINK:='Fruit Juice';
              3:DRINK:='Beer';
              4:DRINK:='Ale';
              5:DRINK:='Wine';
              6:DRINK:='Brandy';
              7:DRINK:='Sasperilla'
             End; {Case}
            End;
             D:=GOLD*TOWNI[USERI[NUM,14],6];
             If CHOICE='1' then D:=D+21;
            Mriteln('');
            If CHOICE='2' then Mrite ('A Glass of ');
            If CHOICE='2' then Mrite(DRINK);
            If CHOICE='2' then Mrite(' will cost ');
            If CHOICE='2' then Send_Num(D);
            If CHOICE='2' then Mrite(' Gold, Want it? ');
            If CHOICE='1' then Begin
              Mrite('A ');
              Mrite(DRINK);
              Mrite(' will cost thee ');
              Send_Num(D);
              Mrite(' Gold, Want it? ')
             End;
            WHAT(SURE);
            If SURE='Y' then Begin
              If D>USERI[NUM,4] then Mriteln ('Check thy Funds..');
              If D=USERI[NUM,4] then Mriteln ('That would leave thee Broke!!');
              If D<USERI[NUM,4] then Begin
                USERI[NUM,4]:=USERI[NUM,4]-D;
                Mriteln('');Mrite ('Is this for [T]hee, or [S]omeone else? ');
                Repeat
                  SOMETHING(SURE);
                Until (SURE='T') or (SURE='S');
              If GOLD<5 then GOLD:=5;
              If SURE='S' then Begin
               Mriteln ('Someone Else...');
              Mriteln('');
              Repeat
               If CHOICE='2' then Mrite ('Buy drink for Who? [?=List] [Return Aborts]: ');
               If CHOICE='1' then Mrite ('Give food to Who? [?=List] [Return Aborts]: ');
               IS:=0;UNI:=False;
               ASK(NUM,WHICH,IS,UNI);
              Until (WHICH>0) or (WHICH=-1);
               If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
                 WHAT(JUNK)
                End;
              If (WHICH>0) and (JUNK='Y') then Begin
                Mriteln('');
                If CHOICE='2' then Begin
                  Mrite('Thou gave a glass of ');
                  Mrite(DRINK);
                  Mrite(' to ');
                  Mrite(USERS[WHICH,3]);
                  Mriteln('!')
                 End;
                If CHOICE='1' then Begin
                  Mrite('Thou gave a ');
                  Mrite(DRINK);
                  Mrite(' to ');
                  Mrite(USERS[WHICH,3]);
                  Mriteln('!')
                 End;
                If CHOICE='2' then COND:=23;
                If CHOICE='1' then COND:=26;
                ESTUFF(WHICH,NUM,DRINK,COND);
                If CHOICE='2' then USERI[WHICH,11]:=USERI[WHICH,11]+GOLD;
                If CHOICE='1' then USERI[WHICH,10]:=USERI[WHICH,10]+(GOLD+4)
               End
              End;
             If SURE='T' then Begin
               Mriteln('Thyself...');
               Mriteln('');
               If CHOICE='2' then Begin
                Repeat
                 Mrite('Tip the Bartender how much? ');
                 Meadln(JUNK);
                 BUGPROOF(JUNK,SCOUNT);
                Until SCOUNT>-1;
                If SCOUNT<>0 then Mriteln('');
                If SCOUNT>=USERI[NUM,4] then Mriteln('Thou dost not have that much!');
                 If (SCOUNT>0) and (USERI[NUM,4]>SCOUNT) then Begin
                   REACT:=TPATH;USERI[NUM,4]:=USERI[NUM,4]-SCOUNT;
                   INSERT('RUMOURS',REACT,((Ord(REACT[0]))+1));
                   MReset(ANAME,REACT);
                   SCCOUNT:=SCOUNT div 100;
                   If SCCOUNT=0 then SCCOUNT:=1;
                   If SCCOUNT>10 then SCCOUNT:=11;
                   For SCOUNT:=1 to SCCOUNT do Readln(ANAME,AHINT);
                   ENCRYPT(AHINT,False);
                   Mrite('The Bartender says, "');Mriteln(AHINT)
                  End;
                 Mriteln('')
                End;
               If CHOICE='2' then Mrite ('Ahhh...  Refreshing... The ');
               If CHOICE='2' then Mrite (DRINK);
               If CHOICE='2' then Mriteln(' Tasted wonderful!');
               RANDOM:=(DRANDOM mod 20)+1;
               If CHOICE='1' then Mrite ('The ');
               If CHOICE='1' then Mrite(DRINK);
               If (CHOICE='1') and (RANDOM<20) then Mriteln(' was Delicious!!!!');
               If (CHOICE='1') and (RANDOM>19) then
               Mriteln(' tasted terrible!!!  THOU HAST FOOD POISONING!!!!!');
               If CHOICE='2' then USERI[NUM,11]:=USERI[NUM,11]+GOLD;
               If (CHOICE='1') and (RANDOM>19) then USERI[NUM,26]:=7;
               If (CHOICE='1') and (RANDOM<20) then USERI[NUM,10]:=USERI[NUM,10]+(GOLD+4)
              End
             End
            End
           End;
          If CHOICE='3' then JOBS(NUM,JOB,LJOB);
          If CHOICE='4' then Begin
            If PEOPLES>0 then Begin
              PEOPLES:=PEOPLES-1;
              ENCOUNTER(0,NUM,OVER)
             End
            Else Begin
              Mriteln('');Mriteln('Nobody seems to be in the mood for chatting...')
             End;
           End;
          COND:=20;
          If (CHOICE='5') and (CAR=2) then Writeln('Option not available Locally.');
          If (CHOICE='5') and (CAR=1) then Begin
    TOFF:=True;
    Mriteln('');Mriteln('Trying to get the Bartender''s attention!');
    Mrite('30 Seconds (Ctrl-X Aborts)');
    Writeln(Chr(27),'E');Writeln;Writeln;
    Writeln(USERS[NUM,3],' would like to speak with the Bartender (That''s you!),');
    Writeln('Try using Olde English language and play the role of a wise, yet sly');
    Write('Bartender!  Press [SPACE] to Begin');TWIN;
    TIMER:=Clock;
    Repeat
      If ((Clock-TIMER)-TOTAL)>=2 then Begin
        TOTAL:=Clock-TIMER;
        Mrite('.');
        Sure:=Chr(7);
        Write('.');
        Write(Chr(7))
       End;
      If bconstat(1) then
        If bconin(1)=24 then TIMER:=0;
      If bconstat(2) then
       If bconin(2)=32 then Play:=True;
    Until (Play=True) or ((CLOCK-TIMER)>=30);
    Mriteln('');Mriteln('');Writeln;
    If PLAY=False then Mriteln('The Bartender tells thee, "I am busy, don''t have time to talk!"');
    If PLAY=True then Begin
      Repeat
        If bconstat(2) then TIMER:=bconin(2)
      Until bconstat(2)=False;
      Mrite('The Bartender walks over to thee, "Greetings Stranger!  ');
      Mrite('What may I do for thee?"');Mriteln('');
      Repeat
       Writeln;Writeln('Awaiting Response...');
       Repeat
        Mriteln('');Mriteln('Thy Response? (80 Char. max.) "Bye" to leave.');
        Mrite('>');
        Meadln(JUNK);
       Until JUNK<>'';
        Writeln;Writeln(USERS[NUM,3],' says, "',JUNK,'".');
        Upcase(JUNK);If JUNK='BYE' then Play:=False;
        If Play then Begin
          Mriteln('');Mriteln('Awaiting Response...');
         Writeln('');
         Writeln('ACTIVITY MENU');
         Writeln('*-----------*');
         Writeln('[S]mile.');
         Writeln('[F]rown.');
         Writeln('[L]augh.');
         Writeln('[I]gnite pipe.');
         Writeln('[H]eavy Sigh.');
         Writeln('[N]othing.');
         Writeln;Write('Choose: ');
         Readln(SURE);UPCASE(SURE);
         Repeat
          Writeln('');Writeln('Thy Response? (80 Char. max.) "Bye" to leave.');
          Write('>');
          Readln(JUNK);
         Until JUNK<>'';
          If SURE[1]<>'N' then Mriteln('');
          Case SURE[1] of
            'S':Mriteln('The bartender smiles...');
            'F':Mriteln('The bartender frowns...');
            'L':Mriteln('The bartender breaks into strange laughter.');
            'I':Mriteln('The bartender lights his pipe...');
            'H':Mriteln('The bartender sighs heavily...')
           End;
          Mriteln('');Mrite('The Bartender says, "');
          Mrite(JUNK);Mriteln('".');
          Upcase(JUNK);If JUNK='BYE' then PLAY:=False
         End;
      Until PLAY=False;
      Mriteln('');Mriteln('The Bartender leaves to attend to a group of adventurers...');
      Writeln;Writeln(USERS[NUM,3],' walks away...')
     End;
     TOTAL:=0;TOFF:=False;
    End;
          If CHOICE='6' then ESTUFF(JOB,NUM,CHOICE,COND);
          COND:=21;
          If CHOICE='7' then ESTUFF(JOB,NUM,CHOICE,COND);
          If CHOICE='8' then Begin
           Mriteln('');
           Repeat
            Mrite ('Give Gold to Who? [?=List] [Return Aborts]: ');
            IS:=0;UNI:=False;
            ASK(NUM,WHICH,IS,UNI);
           Until (WHICH>0) or (WHICH=-1);
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
             End;
            If (WHICH>0) and (SURE='Y') then Begin
            Mriteln('');Mrite ('Thou hast ');
            Send_Num(USERI[NUM,4]);
            Mriteln(' Gold Piece(s).');
            Repeat
              Mriteln('');Mrite ('Give how much Gold? ');
              Meadln(GOLDS);
              BUGPROOF(GOLDS,GOLD);
            Until (GOLD>-1);
            If GOLD=USERI[NUM,4] then Mriteln ('That would leave thee Broke!!');
            If GOLD>USERI[NUM,4] then Mriteln ('Thou dost not have that much!!');
            If (GOLD<USERI[NUM,4]) and (GOLD<>0) then Begin
              Mriteln('');Send_Num(GOLD);
              Mrite(' Gold? ');
              WHAT(SURE);
              If SURE='Y' then Begin
                Mriteln('');Mrite ('Thou gave ');
                Send_Num(GOLD);Mrite(' Gold Piece(s) to ');
                Mrite(USERS[WHICH,3]);Mriteln('!');
                COND:=22;
                ESTUFF(WHICH,NUM,GOLDS,COND);
                USERI[NUM,4]:=USERI[NUM,4]-GOLD;
                USERI[WHICH,4]:=USERI[WHICH,4]+GOLD
               End
              End
             End
           End;
          If CHOICE='9' then Begin
            TEMP:=TPATH;
            INSERT('RUMOURS.DAT',TEMP,((Ord(TEMP[0]))+1));
            MReset(FNAME,TEMP);
            Readln(FNAME,RANNUM);
            LOCATION:=(DRANDOM mod RANNUM)+1;
            For CNTRS:=1 to LOCATION do Readln(FNAME,SURE);
            Mriteln('');Mrite('A Guild Member says, "');
            Mrite(SURE);Mriteln('".');
            Close(FNAME)
           End;
          If CHOICE='10' then Begin
            Repeat
              JUNK:='N';
             Repeat
              Mriteln('');Mriteln ('Enter thy Text, up to 80 char. Maximum...');
              Mrite ('>');
              TWISTY:=True;Meadln (SURE);
             Until (ord(SURE[0])>1) and (ord(SURE[0])<80);
              Mriteln('');Mrite ('"');
              Mrite(SURE);Mriteln('"');
              Mrite ('Correct [Y/N] ');
              WHAT(JUNK);
              Mriteln('');
             Until JUNK='Y';
             Mriteln ('Telling Rumour...');
            TEMP:=TPATH;
            INSERT('RUMOURS.DAT',TEMP,((Ord(TEMP[0]))+1));
            MReset(FNAME,TEMP);
            Readln(FNAME,LOCATION);
            If LOCATION=60 then Readln(FNAME)
              Else LOCATION:=LOCATION+1;
            TEMP:=TPATH;
            INSERT('JUNK.DAT',TEMP,((Ord(TEMP[0]))+1));
            Rewrite(SNAME,TEMP);
            Writeln(SNAME,LOCATION);
            While not eof(FNAME) do Begin
              Readln(FNAME,JJJUNK);
              Writeln(SNAME,JJJUNK)
             End;
            Writeln(SNAME,SURE);
            Rename(SNAME,FNAME)
          End;
        If CHOICE='11' then Begin
          Mriteln('');Mrite ('Steal from the Tavern, Art thou Sure? ');
          TI:=USERI[NUM,14];
          WHAT(JUNK);
           If JUNK='Y' then Mriteln('');
           If TAVSTEAL>19 then Begin
             Mriteln('There is nothing left to steal!');
             STOP
            End;
           If (JUNK='Y') and ((TI=8) or (TI=13) or (TI=19)) and (TAVSTEAL<20) then
            Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
            If (JUNK='Y') and (TI<>8) and (TI<>13) and (TI<>19) then Begin
            WHICH:=1;
            Mriteln('Thou waitest until the Bartender goes to the back rooms...');
            Mriteln('');Mrite('Press [Return] to try to Steal Something!');
            QSTOP;
            RANDOM:=DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+25)+1;
            If RANDOM<USERI[NUM,3]+25 then Begin
              USERI[NUM,5]:=USERI[NUM,5]+819;
              GOLD:=DRANDOM mod 3+1;
              Mriteln('');TAVSTEAL:=TAVSTEAL+1;
              If GOLD=1 then Begin
                Mriteln('Thou stole a bottle of wine un-noticed!!');
                USERI[NUM,11]:=USERI[NUM,11]+20
               End;
              If GOLD=2 then Begin
                Mriteln('Thou hast stolen a food packet!');
                USERI[NUM,10]:=USERI[NUM,10]+20
               End;
              If (GOLD<>1) and (GOLD<>2) then Begin
                GOLD:=(DRANDOM mod USERI[NUM,3])+11;
                Mrite('Thou stole ');
                Send_Num(GOLD);Mriteln(' gold pieces!');
                USERI[NUM,4]:=USERI[NUM,4]+GOLD;
                USERI[NUM,5]:=USERI[NUM,5]+GOLD
               End;
              STEALER:=STEALER+1;
              End;
            If RANDOM>USERI[NUM,3]+25 then Begin
              EM_SEND(107);
              Mriteln('');Mriteln('The Bartender catches thee!!  A couple of bouncers grab thee!');
              EM_SEND(104);
              Mriteln('Soon, a couple of guards arrive.  Several patrons look at');
              Mriteln('thee, disgusted...');
              COND:=27;WHICH:=1;
              If STEALER>0 then ESTUFF(WHICH,NUM,TOWNS[USERI[NUM,14],2],COND);
              STEALER:=0;
              COND:=28;
              ESTUFF(WHICH,NUM,TOWNS[USERI[NUM,14],2],COND);
              JAIL(NUM,OVER)
             End
          End;
         End;
         If (OVER=False) and (CHOICE<>'3') and (CHOICE<>'') then STOP;
         End;
        Until (CHOICE='12') or (OVER=True);
        COND:=27;WHICH:=1;
        If STEALER>0 then ESTUFF(WHICH,NUM,TOWNS[USERI[NUM,14],2],COND);
        STEALER:=0;
      End;
      If (OVER=FALSE) and (WRONG=TRUE) then Begin
        Mriteln('');Mriteln ('A Sign Says:  ');
        Mriteln('');Mrite('The ');
        Mrite(TOWNS[USERI[NUM,14],2]);
        Mriteln(' Tavern is currently =+-* CLOSED *-+=.');
        DISTIME(TOWNI[USERI[NUM,14],3],RIGHT);
        Mriteln('');
        Mrite ('Our Hours are ');
        Send_Num (RIGHT);
        If TOWNI[USERI[NUM,14],3]>12 then Mrite (' P.M. to ');
        If TOWNI[USERI[NUM,14],3]<13 then Mrite (' A.M. to ');
        DISTIME(TOWNI[USERI[NUM,14],4],RIGHT);
        Send_Num(RIGHT);
        If TOWNI[USERI[NUM,14],4]>12 then Mrite (' P.M.');
        If TOWNI[USERI[NUM,14],4]<13 then Mrite (' A.M.');
        Mriteln('');Mriteln ('Please come again later...  Thank thee...');
        If (OVER=False) then STOP;
        Mriteln('')
      End
    End;
(**************************************************************************)
  Procedure INN(Var NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      OP,FIRST,JUNK,JUNKS:Str255;
      THE,PRICE,HOURS,ROOM,JOB,LJOB,HAS,QUICKIE,TI,HEAL:Integer;
      RANDOM:Long_Integer;
    Begin
      HAS:=0;
      LJOB:=0;
      If OVER=False then EM_SEND(403);
      If OVER=False then EM_SEND(511);
      If OVER=False then EM_SEND(301);
      Repeat
        If (VT=True) and (OVER=False) then Mrite(Chr(27));
        If (VT=True) and (OVER=False) then Mrite('E');
        If OVER=FALSE Then MAKESURE(NUM,SUN,OVER);
        If OVER=TRUE Then OP:='6';
        If OVER=FALSE Then Begin
          ABLE:=True;
          Mriteln('');
          Mrite ('Thou art at The -=* ');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b1');
          Mrite (TOWNS[USERI[NUM,14],7]);
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b3');
          Mriteln(' *=- Inn.');
          Mriteln('');
          If HAS=0 then Mriteln ('The Inn Keeper welcomes thee!');
          If HAS=1 then Mriteln ('The Inn Keeper seems upset...');
         EM_SEND(1061);
         If EMULATE=False then Begin
          Mriteln ('Dost thou wish to:');
          Mriteln('');
          Mriteln ('1 - Ask for a Room.');
          Mriteln ('2 - Look at the Clock.');
          Mriteln ('3 - Ask for a Job.');
          Mriteln ('4 - Ask the Innkeeper about Maps.');
          Mriteln ('5 - Try to steal some gold!');
          Mriteln('');
          Mriteln ('6 - Go outside...');
         End;
          ABLE:=False;SOFF:=False;
          Mriteln('');
          If (DRANDOM mod 16+1)=3 then Begin
            Mriteln('An old man with a strange amulet about his neck meets thee...');
            Mriteln('');Mriteln('He says, "I hold the power of dreamspeech!!  For 200 gold I');
            Mriteln('will create a dream to send to those who sleep here."');
            Mriteln('');Mrite('Do it? ');WHAT(JUNKS);Mriteln('');
            If (JUNKS='Y') and (USERI[NUM,4]<=200) then Mriteln('Not enough gold!');
            If (JUNKS='Y') and (USERI[NUM,4]>200) then Begin
              Mriteln('Thou had a dream of ___(80 Char. Max.)___. (Fill in the blank)');
            Repeat
             Repeat
              Mriteln('');Mriteln ('Enter thy text, up to 80 char. maximum...');
              Mrite ('>');
              TWISTY:=True;Meadln (DREAM);
             Until (ord(DREAM[0])>1) and (ord(DREAM[0])<80);
              Mriteln('');Mrite ('"');
              Mrite(DREAM);Mriteln('"');
              Mrite ('Correct [Y/N] ');
              WHAT(JUNKS);
              Mriteln('');
             Until JUNKS='Y';
              Mriteln('It is done!!!!!!');Mriteln('')
           End;
          End;
          Mrite ('Thy Selection: ');
          Meadln (OP);
          NUM:=NUM+100;
          If OVER=FALSE then MAKESURE(NUM,SUN,OVER);
          If OVER=FALSE Then Begin
            If OP='1' Then Begin
             Repeat
              ABLE:=True;
              Mriteln('');
              Mriteln ('Where dost thou wish to sleep?');
              Mriteln('');
              QUICKIE:=TOWNI[USERI[NUM,14],9];
              Mrite ('<1> Floor............');
              Send_Num(6*QUICKIE);Mriteln(' G.P.');
              Mrite ('<2> Premium Room.....');Send_Num(20*QUICKIE);Mriteln(' G.P.');
              Mrite ('<3> Deluxe Room......');Send_Num(60*QUICKIE);Mriteln(' G.P.');
              Mrite ('<4> Small Suite......');Send_Num(80*QUICKIE);Mriteln(' G.P.');
              Mrite ('<5> Large Suite......');Send_Num(160*QUICKIE);Mriteln(' G.P.');
              Mrite ('<6> The Best Suite...');Send_Num(320*QUICKIE);Mriteln(' G.P.');
              Mriteln ('<7> None.');
              ABLE:=False;SOFF:=False;
              Mriteln('');
              Mrite ('Thy Selection: ');
              Meadln (FIRST);
              BUGPROOF(FIRST,ROOM);
             Until (ROOM=1) or (ROOM=2) or (ROOM=3) or (ROOM=4)
              or (ROOM=5) or (ROOM=6) or (ROOM=7);
              Case ROOM Of
                1:PRICE:=6*QUICKIE;2:PRICE:=20*QUICKIE;3:PRICE:=60*QUICKIE;
                4:PRICE:=80*QUICKIE;5:PRICE:=160*QUICKIE;6:PRICE:=320*QUICKIE;
                7:PRICE:=0;
               End; {Case}
              If USERI[NUM,4]=PRICE then Mriteln ('That would leave thee broke!');
              If (USERI[NUM,4]<PRICE) and (PRICE>0) then Mriteln
              ('The Innkeeper yells, "Thou dost not have enough gold!!"');
              If (USERI[NUM,4]>PRICE) and (PRICE>0) Then Begin
                Mriteln('');Mrite ('That will be ');
                Send_Num(PRICE);Mriteln(' gold.');
                Mrite ('Still Want it? ');
                WHAT(JUNK);
                If JUNK='Y' Then Begin
                 USERI[NUM,4]:=USERI[NUM,4]-PRICE;
                 Mriteln('');
                 Repeat
                  Mrite('Sleep for how many hours? (12 Max.): ');
                  Meadln (JUNK);
                  BUGPROOF (JUNK,HOURS);
                  Mriteln('');
                  If (HOURS>USERI[NUM,6]) and (HOURS<13) then Begin
                    Mrite ('Thou only hast ');
                    Send_Num(USERI[NUM,6]);
                    Mriteln(' hour(s) left today!')
                   End;
                 Until (HOURS<13) and (HOURS>0) and (HOURS<=USERI[NUM,6]);
                 Mriteln ('The Inn Keeper tells thee to sleep well!');
                 Mriteln('');
                 If (USERI[NUM,6]>7) and (USERI[NUM,6]<19) then Begin
                    Mriteln('The pale moonlight pours through thy window...');
                    Mriteln('');
                  End;
                 Mrite ('Press [RETURN] to Sleep ');
                 USERI[NUM,6]:=USERI[NUM,6]-HOURS;
                 Case ROOM Of
                   1:Mrite ('on The Floor!');
                   2:Mrite ('in a Premium Room!');
                   3:Mrite ('in a Deluxe Room!');
                   4:Mrite ('in a Small Suite!');
                   5:Mrite ('in a Large Suite!');
                   6:Mrite ('in The Best Suite!');
                  End; {Case}
              If CHEAT1=47 then Begin
                 Case ROOM Of
                   1:USERI[NUM,12]:=USERI[NUM,12]+5;
                   2:USERI[NUM,12]:=USERI[NUM,12]+10;
                   3:USERI[NUM,12]:=USERI[NUM,12]+15;
                   4:USERI[NUM,12]:=USERI[NUM,12]+20;
                   5:USERI[NUM,12]:=USERI[NUM,12]+25;
                   6:USERI[NUM,12]:=USERI[NUM,12]+30
                  End; {Case}
                 End;
                 QSTOP;
                 Mriteln('');
                 Mrite ('After ');
                 Send_Num(HOURS);
                 Mriteln(' Hour(s) The Inn Keeper wakes thee.');
                 If (FAIRY=True) and ((USERI[NUM,20])<(USERI[NUM,21])) then Begin
                   Mriteln('');Mriteln('The Fairy Wood is surrounded in Golden Light!!!');
                   HEAL:=DRANDOM mod (HOURS*2)+1;
                   If (USERI[NUM,20]+HEAL)>USERI[NUM,21] then HEAL:=USERI[NUM,21]-USERI[NUM,20];
                   Mriteln('');Send_Num(HEAL);Mriteln(' of thy Hit point(s) hast been restored!');
                   USERI[NUM,20]:=USERI[NUM,20]+HEAL
                  End;
                 RANDOM:=DRANDOM mod 4+1;
                 Mriteln('');
                 If RANDOM=1 then Begin
                   Mriteln ('Thy dreams were plagued with nightmares!');
                   Mriteln ('Thou did not sleep well...');
                   USERI[NUM,12]:=USERI[NUM,12]+HOURS-3
                  End;
                 If RANDOM=2 then Begin
                   Mriteln ('Thou Hast Slept Well.');
                   USERI[NUM,12]:=USERI[NUM,12]+HOURS
                  End;
                 If RANDOM=3 then Begin
                   Mriteln ('Thou had a dream of a terrifying world called "Earth", where');
                   Mriteln ('Magic did not exist!');
                   Mriteln ('Thou did not sleep well...');
                   USERI[NUM,12]:=USERI[NUM,12]+HOURS-1
                  End;
                 If RANDOM=4 then Begin
                   Mrite('Thou had a dream of ');Mriteln(DREAM);
                   USERI[NUM,12]:=USERI[NUM,12]+HOURS
                 End
               End;
              End;
             End;
            JOB:=2;
            If OP='3' Then JOBS(NUM,JOB,LJOB);
            If OP='4' Then Begin
              If VT=True then Mrite(Chr(27));
              If VT=True then Mrite('E');
              ABLE:=True;
              Mriteln('');
              Mriteln('The Innkeeper takes thee to the back room...');
              Mriteln('');;
              Mriteln(' He lowers his voice and whispers,');
              Mriteln('');
              Mriteln('    "To obtain a map of the world featuring Towns and Travel Routes,');
              Mriteln('');
              Mriteln('Send a check or money order for $3.00 (US dollars) written to:');
              Mriteln('');
              RANDOM:=0;
              For RANDOM:=1 to ord(LN3[0]) do
              Mrite(LN3[RANDOM]);Mriteln('');
              Mriteln('');
              Mriteln('  All maps are printed on parchment paper with hints to solving quests');
              Mriteln('embedded in the artwork!  All maps have been individually airbrushed');
              Mriteln('by hand.  A must for serious Thieves'' Guild players!"');
              Mriteln('');
              Mriteln(' -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
              Mriteln('  Can''t get enough???   A ''Stand-Alone'' version of TG to play on your own');
              Mriteln('     computer as much as you like available for both Atari ST & IBM! A');
              Mriteln(' great way to practice and discover secrets -- ALL Registered features are');
              Mriteln('   included. Send $8 to address above, be sure to specify computer type.');
              Mriteln('');
              Mriteln('            Please allow approximately 1 week delivery time...');
              ABLE:=False;SOFF:=False;
              STOP
            End;
            If OP='5' Then Begin
              Mriteln('');Mrite ('Steal from the Inn, Art thou Sure? ');
              WHAT(JUNK);
            TI:=USERI[NUM,14];
           If (JUNK='Y') and ((TI=8) or (TI=13) or (TI=19)) then
            Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
           If USERI[NUM,33]>18000 then Begin
             Mriteln('');Mriteln('There''s no gold to steal!');STOP
            End;
            If (JUNK='Y') and (TI<>8) and (TI<>13) and (TI<>19) and (USERI[NUM,33]<18001) then Begin
                EM_SEND(510);EM_SEND(699);EM_SEND(303);
                Mriteln('');Mriteln ('Thou dost wait until the Inn Keeper is not looking...');
                Mriteln('');Mrite ('Press [RETURN] to grab a bag of gold!');
                If EMULATE then VT:=False;QSTOP;If EMULATE then VT:=True;Mriteln('');
                EM_SEND(300);
                RANDOM:=DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+25)+1;
                If RANDOM<USERI[NUM,3]+25 then Begin
                  Mriteln ('Thou hast stolen a bag of gold!');
                  Mriteln('');Mrite ('The Bag contains ');
                  PRICE:=DRANDOM Mod 350+1;
                  PRICE:=PRICE+30;
                  Send_Num(PRICE);
                  Mriteln (' Gold Pieces!');
                  USERI[NUM,4]:=USERI[NUM,4]+PRICE;
                  USERI[NUM,33]:=USERI[NUM,33]+PRICE;
                  USERI[NUM,5]:=USERI[NUM,5]+717;
                  STEALER:=STEALER+1;
                  STOP
                 End;
                If RANDOM>USERI[NUM,3]+25 then Begin
                  EM_SEND(512);EM_SEND(303);
                  Mriteln ('The Inn Keeper sees thee & Yells for the Guards!!!');
                  EM_SEND(104);
                  HAS:=DRANDOM mod 5+1;
                  If HAS=1 then Mriteln ('The Inn Keeper tells thee, "Never come back, Scum!!"');
                  If HAS=2 then Mriteln ('The Inn Keeper looks at thee with Anger!!');
                  If HAS=3 then Mriteln ('The Inn Keeper Says, "What is happening to this World?"');
                  If HAS=4 then Mriteln ('The Inn Keeper Says, "What thou dost Sow, So shall Ye Reap!"');
                  If HAS=5 then Mriteln ('The Inn Keeper says to Himself, "Damned Thieves!!"');
                  If EMULATE then STOP;
                  EM_SEND(300);
                  HAS:=1;
                  PRICE:=1;HOURS:=14;
                  If STEALER>0 then ESTUFF(PRICE,NUM,TOWNS[USERI[NUM,14],7],HOURS);
                  STEALER:=0;
                  PRICE:=1;HOURS:=12;
                  ESTUFF(PRICE,NUM,TOWNS[USERI[NUM,14],7],HOURS);
                  STOP;
                  JAIL(NUM,OVER)
                 End
                End
               End;
            If OP='2' Then Begin
              DISTIME(USERI[NUM,6],THE);
              Mriteln('');
              If (USERI[NUM,6]>7) and (USERI[NUM,6]<19) then Begin
                Mriteln(' .     .          .      .     .');
                Mriteln('   . /\  . ( /\.     /\ .  /\/\/\');
                Mriteln('.   /  \/\  /  \/\ ./  \/\/  \/  \');
               End
              Else Begin
                Mriteln('     /\      /\      /\    /\/\/\');
                Mriteln('    /  \/\  /  \/\  /  \/\/  \/  \');
               End;
             Mriteln(' /\/   /  \/   /  \/   /  \   \   \');
             Mriteln('/  \  /    \  /    \  /    \   \   \');
             Mriteln('####################################');
             Mriteln('');
             If USERI[NUM,6]>24 then Mriteln('Time has been frozen...');
             If USERI[NUM,6]<25 then Begin
              Mrite ('The Inn Keeper tells Thee that it is ');
              Send_Num(THE);
              Mrite(':');
              If Clock-SUN<10 then Mrite ('0');
              Send_Num(Clock-SUN);
              If USERI[NUM,6]>12 then Mriteln (' P.M.');
              If USERI[NUM,6]<13 then Mriteln (' A.M.');
             End;
              Mriteln('');Mrite ('Thou Hast ');
              Send_Num(USERI[NUM,6]);
              Mriteln(' Hour(s) Left in this Realm.');
              STOP;
              Mriteln('')
          End
         End
        End;
     If OP='1' then Begin
       STOP
      End;
     Until OP='6';
     PRICE:=1;HOURS:=14;
     If STEALER>0 then ESTUFF(PRICE,NUM,TOWNS[USERI[NUM,14],7],HOURS);
     STEALER:=0;
     If OVER=FALSE then Begin
       Mriteln('');Mriteln('Thou dost re-enter the streets...');
       STOP
      End;
     If OVER=False then Mriteln('')
    End;
(**** BANK ****************************************************************)
  Procedure BANK(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      FN:Text;
      OPTI,GOLD:Str255;
      ANINT,LJOB,JOB,AMT,T,ABC,CIVIL,TI,GOLDI:Integer;
      GOTIT,ANY:Boolean;
      TOTAL:Long_Integer;
    Begin
      LJOB:=0;JOB:=3;TI:=USERI[NUM,14];
      EM_SEND(406);EM_SEND(301);
      Repeat
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('E');
        MAKESURE(NUM,SUN,OVER);
        If OVER=False then Begin
          ABLE:=True;EM_SEND(1055);
         If EMULATE=False then Begin
          Mriteln('');Mrite ('Thou art at the -=* ');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b1');
          Mrite(TOWNS[USERI[NUM,14],10]);
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b3');
          Mriteln(' *=- Bank.');
          End;
          Mriteln('');Mrite ('    Bank''s Daily Interest - ');
          Send_Num(TOWNI[USERI[NUM,14],14]);Mriteln('%');
          If USERI[NUM,17]>0 then Mrite ('      Thy Current Balance - ');
          If USERI[NUM,17]>0 then Send_Num(USERI[NUM,18]);
          If USERI[NUM,17]>0 then Mriteln(' G.P.');
          EM_SEND(1056);
         If EMULATE=False then Begin
          Mriteln('');Mriteln (' [1]  Open an Account.');
          Mriteln (' [2]  Close an Account.');
          Mriteln (' [3]  Withdraw from an Account.');
          Mriteln (' [4]  Make a Deposit.');
          Mriteln (' [5]  Apply for a Job.');
          Mriteln (' [6]  Try to steal a copy of the Bankbooks.');
          Mriteln (' [7]  Try to steal ALL Gold from Guild Member''s Accounts!');
          Mriteln('');Mriteln (' [8]  Leave the Bank.');
          End;
          ABLE:=False;SOFF:=False;
          If BSTEAL<>'' then Begin
             Mriteln('');Mrite('WANTED: ');
             Mrite(BSTEAL);Mrite(' robbed the bank on ');Mrite(BDATE);
             Mriteln('!!!!');
            End;
          Mriteln('');Mrite ('Guards stand at every corner of the room watching thee: ');
          Meadln (OPTI);
       End;
       If OPTI='1' then Begin
         Mriteln('');
        If USERI[NUM,17]>0 then Begin
         Mrite ('Thou hast already opened an account at the ');
         Mrite(TOWNS[USERI[NUM,17],10]);
         Mrite(' Bank - ');
         Send_Num(TOWNI[USERI[NUM,17],14]);Mriteln('%')
        End
         Else Begin
          Repeat
          Repeat
           Mriteln('BANK NOTICE: Interest is only paid if account has less than 100,000 gps!');
           Mriteln('');Mrite('Thou hast ');
           Send_Num(USERI[NUM,4]);
           Mriteln(' Gold Pieces.');
           Mriteln('30000 Max. per Transaction.');
           Mriteln('');Mrite ('Deposit how much? ');
           Meadln(GOLD);
           BUGPROOF(GOLD,GOLDI);
          Until (GOLDI<30001) and (GOLDI>-1);
           If GOLDI<>0 then Begin
             Mrite ('Deposit ');
             Send_Num(GOLDI);
             Mrite(' Gold Pieces? ');
             WHAT(GOLD)
            End
           Else GOLD:='Y';
           Mriteln('');
           If GOLDI=USERI[NUM,4] then Mriteln ('That would leave thee broke!');
           If GOLDI>USERI[NUM,4] then Mriteln ('Thou dost not have that much!');
          Until ((GOLDI=0) or (GOLDI<USERI[NUM,4])) and (GOLD='Y');
          If GOLDI<>0 then Begin
            USERI[NUM,4]:=USERI[NUM,4]-GOLDI;
            USERI[NUM,17]:=USERI[NUM,14];
            USERI[NUM,18]:=GOLDI;
            Mriteln ('Done!')
           End
         End
        End;
       If OPTI='2' then Begin
        Mriteln('');
        If USERI[NUM,17]=0 then Mriteln ('Thou dost not have an account opened!');
        If USERI[NUM,17]>0 then Begin
         Mrite ('Close Thy Current Account? ');
         WHAT(GOLD);
         If GOLD='Y' then Begin
           USERI[NUM,4]:=USERI[NUM,4]+USERI[NUM,18];
           USERI[NUM,17]:=0;USERI[NUM,18]:=0;
           Mriteln ('Account Closed! - All Gold Withdrawn.')
          End
         End
        End;
       If OPTI='3' then Begin
        Mriteln('');
       If USERI[NUM,17]=0 then Mriteln ('Thou dost not have an account open!');
       If USERI[NUM,17]>0 then Begin
        Repeat
         Repeat
         Mrite ('Thou hast ');
         Send_Num(USERI[NUM,18]);Mriteln(' gold in thy account.');
         Mriteln('30000 Max. per Transaction.');
         Mriteln('');;Mrite ('Withdraw how much? ');
         Meadln(GOLD);
         BUGPROOF(GOLD,GOLDI);
        Until (GOLDI<30001) and (GOLDI>-1);
         If GOLDI<>0 then Begin
           Mrite ('Withdraw ');
           Send_Num(GOLDI);
           Mrite(' Gold Pieces? ');
           WHAT(GOLD)
          End
         Else GOLD:='Y';
         Mriteln('');
         If GOLDI=USERI[NUM,18] then Mriteln
            ('To withdraw ALL gold, thou must close thy account!');
         If GOLDI>USERI[NUM,18] then Mriteln ('Not that much in thy account!');
        Until ((GOLDI=0) or (GOLDI<USERI[NUM,18])) and (GOLD='Y');
        If GOLDI>0 then Begin
          USERI[NUM,4]:=USERI[NUM,4]+GOLDI;
          USERI[NUM,18]:=USERI[NUM,18]-GOLDI;
          Mrite ('Done! ');
          Send_Num(GOLDI);
          Mriteln(' gold pieces withdrawn!')
          End
         End
        End;
       If OPTI='4' then Begin
         If USERI[NUM,17]=0 then Mriteln('');
         If USERI[NUM,17]=0 then Mriteln ('Thou dost not have an account opened!');
         If USERI[NUM,17]>0 then Begin
          Repeat
           Repeat
            Mriteln('');Mrite('Thou hast ');
            Send_Num(USERI[NUM,4]);
            Mriteln(' Gold Pieces.');
            Mriteln('');Mriteln('30000 max. per transaction.');
            Mrite ('Deposit how much? ');
            Meadln(GOLD);
            BUGPROOF(GOLD,GOLDI)
           Until (GOLDI>-1) and (GOLDI<30001);
           If GOLDI<>0 then Begin
             Mrite ('Deposit ');
             Send_Num(GOLDI);
             Mrite(' Gold Pieces? ');
             WHAT(GOLD)
            End
           Else GOLD:='Y';
           Mriteln('');
           If GOLDI=USERI[NUM,4] then Mriteln ('That would leave thee Broke!');
           If GOLDI>USERI[NUM,4] then Mriteln ('Thou dost not have that Much!');
          Until ((GOLDI=0) or (GOLDI<USERI[NUM,4])) and (GOLD='Y');
          If GOLDI<>0 then Begin
            USERI[NUM,4]:=USERI[NUM,4]-GOLDI;
            USERI[NUM,18]:=USERI[NUM,18]+GOLDI;
            Mriteln ('Done!')
           End
          End;
         End;
         If OPTI='5' then JOBS(NUM,JOB,LJOB);
         If OPTI='6' then Begin
           TOTAL:=0;GOTIT:=False;ANY:=False;
           Mriteln('');Mrite ('Try to Steal a copy of the Bank Books? ');
           WHAT(GOLD);
           If (GOLD='Y') and ((TI=8) or (TI=13) or (TI=19)) then Begin
              Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
              STOP
            End;
            If (GOLD='Y') and (TI<>8) and (TI<>13) and (TI<>19) then Begin
             Mriteln('');Mrite ('Press [RETURN] to steal the Bank Books!');
             QSTOP;
             If (DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+25)+1)
                <USERI[NUM,3]+25 then Begin
               USERI[NUM,5]:=USERI[NUM,5]+1023;GOTIT:=True;
               Mriteln('');Mriteln ('SUCCESSFUL!!  The Scrolls Read...');
               Mriteln('');Mriteln (' Name                    Amt. Gold       Where Opened');
               Mriteln ('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*');
               GOLDI:=0;
               For GOLDI:=1 to 26 do Begin
                 If USERI[GOLDI,17]>0 then Begin
                   ANY:=True;
                   TOTAL:=TOTAL+USERI[GOLDI,18];
                   Mrite (USERS[GOLDI,3]);
                   AMT:=26-(ord(USERS[GOLDI,3][0]));
                   For T:=1 to AMT do Mrite (' ');
                   Send_Num(USERI[GOLDI,18]);
                   Mrite('          ');
                   If USERI[GOLDI,18]<10 then Mrite(' ');
                   If USERI[GOLDI,18]<100 then Mrite(' ');
                   If USERI[GOLDI,18]<1000 then Mrite(' ');
                   If USERI[GOLDI,18]<10000 then Mrite(' ');
                   If USERI[GOLDI,18]<100000 then Mrite(' ');
                   Mriteln(TOWNS[USERI[GOLDI,17],10])
                  End;
                 End;
                 Mriteln('');
                 If ANY=True then Mrite('    ');
                 If ANY=True then Send_Num(TOTAL);
                 If ANY=True then Mriteln(' Gold Pieces Total.');
                 If ANY=False then Mriteln('           No Accounts Opened.');
                   ESTUFF(1,NUM,'',25);
                End;
                If GOTIT=False then Begin
                   Mriteln('');Mriteln('Thou Hast FAILED....');
                   EM_SEND(104);
                   ESTUFF(1,NUM,'',24);
                   STOP;
                   JAIL(NUM,OVER);
                  End;
               End;
              End;
        If OPTI='7' then Begin
          Mriteln('');Mrite ('Try to rob ALL gold from bank!!!, Art thou SURE? ');
          WHAT(GOLD);
           If (GOLD='Y') and ((TI=8) or (TI=13) or (TI=19)) then
            Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
            If (GOLD='Y') and (TI<>8) and (TI<>13) and (TI<>19) then Begin
            Mriteln('');Mriteln('Thou waitest until what seems like a good time...');
            Mriteln('');Mrite('Press [Return] to start the robbery!');
            QSTOP;
            GOLDI:=DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+8888)+1;
            If GOLDI<USERI[NUM,3] then Begin
              Mriteln('');Mriteln('Thou managed to get away with the gold!!!!!!!!');
              Mriteln('');Mriteln('           -=* ROBBERY SUCCESSFUL!! *=-');
              TOTAL:=0;EM_SEND(113);
              For ABC:=1 to 26 Do Begin
                 If (USERI[ABC,17]>0) and (ABC<>NUM) then Begin
                   TOTAL:=TOTAL+USERI[ABC,18];
                   USERI[ABC,17]:=0;
                   USERI[ABC,18]:=0
                  End;
               End;
              Mriteln('');Mrite('Thou stole ');
              Send_Num(TOTAL);
              Mriteln(' gold pieces from guild members!!!');
              CIVIL:=Drandom mod 10000+1;
              Mriteln('');
              Mrite('    -- Plus ');
              Send_Num(CIVIL);
              Mriteln(' gold pieces from civilian accounts!!');
              USERI[NUM,4]:=USERI[NUM,4]+(TOTAL+CIVIL);STEALER:=TOTAL+CIVIL;
              CIVIL:=Drandom mod 10+1;
              Mriteln('');Mrite('         -- Skill Plus ');
              Send_Num(CIVIL);
              USERI[NUM,3]:=USERI[NUM,3]+CIVIL;
              Mriteln('!');BSTEAL:=USERS[NUM,3];
              CIVIL:=0;BDATE:='          ';
              For CIVIL:=1 to 10 do BDATE[CIVIL]:=DAYSS[CIVIL];
              ABC:=29;
              ESTUFF(NUM,NUM,TOWNS[USERI[NUM,14],10],ABC);STEALER:=0;
              Mriteln('');Mriteln('Thou had best get out of town - FAST!');
           End;
            If GOLDI>USERI[NUM,3] then Begin
              Mriteln('');Mriteln('Thou hast FAILED!!');
              EM_SEND(107);
              Mriteln('');Mriteln('At least 10 guards aim their spears at thee!');
              Mriteln('A couple knights draw their swords...  One yells, "Death to the thieves!"');
              GOLDI:=30;EM_SEND(104);
              ESTUFF(NUM,NUM,TOWNS[USERI[NUM,14],10],GOLDI);
              STOP;
              UJAILL:=True;
              JAIL(NUM,OVER);
              UJAILL:=False
             End
          End
        End;
     If OPTI='8' then Mriteln('');
     If OPTI='8' then Mriteln ('Thou leavest the Bank...');
     If (OVER=False) and (OPTI<>'') and (OPTI<>'5') then STOP;
     If OPTI<>'8' then OPTI:='';
     Until (OVER=True) or (OPTI='8');
    End;
(**************************************************************************)
  Procedure SHOPPE(Var NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      RIGHT,GOLD,DPRICE,ONE,J,OVERALL,QUICKIE,HOURS,TI,RANDOM:Integer;
      DIFF:Long_Integer;
      ME,C,D,E,HM,TWO,THREE,THINGS,F,S,T,DONE,SURE,JUNKS,WIT:Str255;
      JUNK:Text;
      BYE,WRONG,ITS,GOTIT,TRIED:Boolean;
    Begin
     QUICKIE:=TOWNI[USERI[NUM,14],15];
     BYE:=False;
     OVERALL:=0;
     WRONG:=TRUE;
     ME:='';
    If TOWNI[USERI[NUM,14],17]>TOWNI[USERI[NUM,14],18] then
     If (USERI[NUM,6]<=TOWNI[USERI[NUM,14],17]) and (USERI[NUM,6]>=TOWNI[USERI[NUM,14],18]) then ME:='ONE';
    If TOWNI[USERI[NUM,14],17]<TOWNI[USERI[NUM,14],18] then
     If (USERI[NUM,6]>TOWNI[USERI[NUM,14],17]) or (USERI[NUM,6]<=TOWNI[USERI[NUM,14],18]) then ME:='TWO';
     If (ME='ONE') or (ME='TWO') then Begin
     EM_SEND(407);EM_SEND(301);
    Repeat
     Repeat
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      WRONG:=FALSE;ITS:=False;
      ABLE:=True;GOTIT:=False;TRIED:=False;
      EM_SEND(1057);
     If EMULATE=False then Begin
      Mriteln('');Mrite ('Thou art at The -=* ');
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('b1');
      Mrite(TOWNS[USERI[NUM,14],11]);
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('b3');
      Mriteln(' *=- Shoppe.');
      Mriteln('');
      Mriteln ('What would''st thou like?');
      Mriteln('');
      Mriteln ('  [0] Try to Steal something!!');
      Mriteln('');
      Mriteln ('    [1] Hat      [2] Bandana');
      Mriteln ('    [3] Shirt    [4] Cloak');
      Mriteln ('    [5] Jacket   [6] Pants');
      Mriteln ('    [7] Boots    [8] Sandals');
      Mriteln('');
      Mriteln ('       [9] Leave the Shop');
     End;
      TI:=USERI[NUM,14];
      If (TI=8) or (TI=13) or (TI=19) then
        Mriteln('  [10] Robes (Our Specialty!!)');
      If USERI[NUM,14]=17 then
        Mriteln (' [10] Turban (Our Specialty!)');
      ABLE:=False;SOFF:=False;
      Mriteln('');Mrite ('The Merchant awaits thy decision: ');
      Meadln (C);
      BUGPROOF(C,ONE);
      Mriteln('');SURE:='';
      If (ONE=0) and (C<>'0') then ONE:=-100;
     Until ((ONE > -1) and (ONE < 11) and (USERI[NUM,14]=17)) or
           ((ONE > -1) and (ONE < 10)) or
           ((ONE > -1) and (ONE < 11) and ((TI=8) or (TI=13) or (TI=19)));
     If C='0' then Begin
       Mrite('Try to steal some clothes, art thou sure? ');
       WHAT(SURE);
       If SURE='N' then TRIED:=True;
       If SURE='Y' then Begin
         TI:=USERI[NUM,14];
           If (TI=8) or (TI=13) or (TI=19) then
            Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
           If (TI=8) or (TI=13) or (TI=19) then TRIED:=True;
            If (TI<>8) and (TI<>13) and (TI<>19) then Begin
                Mriteln('');Mriteln ('Thou carefully planeth thy steal...');
                Mriteln('');Mrite ('Press [RETURN] to grab some clothing!');
                QSTOP;
                Mriteln('');
                RANDOM:=DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+25)+1;
                If RANDOM<USERI[NUM,3]+25 then Begin
                  Mrite ('SUCCESSFUL!!! ');
                  USERI[NUM,5]:=USERI[NUM,5]+800;
                  GOTIT:=True;
                 End;
                If RANDOM>USERI[NUM,3]+25 then Begin
                  Mriteln ('The Merchant Catches thee!!!!!!');
                  EM_SEND(104);
                  GOLD:=1;HOURS:=33;TRIED:=True;THINGS:='Y';
                  ESTUFF(GOLD,NUM,TOWNS[USERI[NUM,14],11],HOURS);
                  STOP;
                  JAIL(NUM,OVER)
                 End;
              End;
            End;
        End;
     If Tried=False then Begin
     If GOTIT=True then ONE:=DRANDOM mod 8+1;
   End;
    If TRIED=False then Begin
     If ONE=1 then Begin
       DPRICE:=10*QUICKIE;
       T:='Hat';
       J:=4
     End;
     If (C='10') and ((TI=8) or (TI=13) or (TI=19)) then Begin
       DPRICE:=24*QUICKIE;
       T:='Robe';
       J:=24
      End;
     If (C='10') and (USERI[NUM,14]=17) then Begin
       DPRICE:=8*QUICKIE;
       T:='Turban';
       J:=4
     End;
     If ONE=2 then Begin
       DPRICE:=5*QUICKIE;
       T:='Bandana';
       J:=4
     End;
     If ONE=3 then Begin
       DPRICE:=10*QUICKIE;
       T:='Shirt';
       J:=5
     End;
     If ONE=4 then Begin
       DPRICE:=12*QUICKIE;
       T:='Cloak';
       J:=5
     End;
     If ONE=5 then Begin
       DPRICE:=11*QUICKIE;
       T:='Jacket';
       J:=5
     End;
     If ONE=6 then Begin
       DPRICE:=12*QUICKIE;
       ITS:=True;
       T:='Pants';
       J:=6
     End;
     If ONE=7 then Begin
       DPRICE:=10*QUICKIE;
       ITS:=True;
       T:='Boots';
       J:=7
     End;
     If ONE=8 then Begin
       DPRICE:=6*QUICKIE;
       ITS:=True;
       T:='Sandals';
       J:=7
     End;
     If C='9' then BYE:=True;
     If (BYE=False) then Begin
     If GOTIT=False then Begin
     Repeat
      ABLE:=True;
      Mriteln ('How fine would''st thou like thy wears?');
      Mriteln('');
      Mriteln ('[1] Cheap.  [2] Simple.');
      Mriteln ('[3] Fine.   [4] Expensive!');
      ABLE:=False;SOFF:=False;
      Mriteln('');Mrite ('The Merchant tries to hurry thee into a decision: ');
      Meadln (D);
      BUGPROOF(D,ONE);
     Until (ONE > 0) and (ONE < 5);
     End;
     If GOTIT=True then ONE:=DRANDOM mod 4+1;
     If ONE=1 then Begin
       DPRICE:=DPRICE+(5*QUICKIE);
       F:='Cheap '
     End;
     If ONE=2 then Begin
       DPRICE:=DPRICE+(10*QUICKIE);
       F:='Simple '
     End;
     If ONE=3 then Begin
       DPRICE:=DPRICE+(20*QUICKIE);
       F:='Fine '
     End;
     If ONE=4 then Begin
       DPRICE:=DPRICE+(40*QUICKIE);
       F:='Expensive '
     End;
     If GOTIT=False then Begin
     Repeat
       ABLE:=True;
       Mriteln('');Mriteln ('What color would''st thou prefer that in?');
       Mriteln('');
       Mriteln ('[1]  Red    [2]  Orange  [3]  Yellow');
       Mriteln ('[4]  Green  [5]  Blue    [6]  Violet');
       Mriteln ('[7]  Brown  [8]  Silver  [9]  Gold');
       Mriteln ('[10] White  [11] Black   [12] Gray');
       ABLE:=False;SOFF:=False;
       Mriteln('');Mrite ('The merchant eyes thy gold with a hint of greed: ');
       Meadln(E);
       BUGPROOF(E,ONE);
     Until (ONE > 0) and (ONE < 13);
    End;
    If GOTIT=True then ONE:=DRANDOM mod 12+1;
    Case ONE of
      11:S:='Black ';
      1:S:='Red ';
      2:S:='Orange ';
      3:S:='Yellow ';
      4:S:='Green ';
      5:S:='Blue ';
      6:S:='Violet ';
      7:S:='Brown ';
      8:S:='Silver ';
      9:S:='Gold ';
      10:S:='White ';
      12:S:='Gray '
    End; {Case}
    THINGS:=F;
    INSERT(S,THINGS,(ord(THINGS[0])+1));
    INSERT(T,THINGS,(ord(THINGS[0])+1));
    If GOTIT=True then Begin
      Mrite(THINGS);Mrite(', wear? ');
      WHAT(WIT);
      If WIT='Y' then USERS[NUM,J]:=THINGS;
      GOLD:=1;HOURS:=32;
      ESTUFF(GOLD,NUM,TOWNS[USERI[NUM,14],11],HOURS);
     End;
    If GOTIT=False then Begin
    Repeat
      Mriteln('');Mrite ('The merchant says, "That would total ');
      Send_Num(DPRICE);
      Mriteln(' Gold Pieces!"');
      If (THINGS[1]<>'E') and (ITS=False) then Mrite ('He brings out a ');
      If ITS=True then Mrite ('He brings out some ');
      If (THINGS[1]='E') and (ITS=False) then Mrite ('He brings out an ');
      Mrite(THINGS);
      Mriteln('.');
      Mriteln('');Mriteln ('Dost thou wish to: ');
      Mriteln('');Mriteln ('[B]uy');
      Mriteln ('[H]aggle');
      Mriteln ('[F]orget it!');
      Mriteln('');Mrite ('Thy decision: ');
    Repeat
      SOMETHING(HM);
    Until (HM='B') or (HM='F') or (HM='H');
    If HM='F' then Mriteln ('Forget it!');
    If HM='F' then DONE:='YES';
    If HM='B' then DONE:='YES';
    If HM='H' then Begin
      Mriteln ('Haggle');
      Mriteln('');
      DIFF:=DRANDOM mod 3+1;
      If (DIFF=1) or (DIFF=2) then Begin
        Mriteln ('The merchant bluntly refuses to lower his price!');
        HM:='F';STOP;
        DONE:='YES'
      End;
      If (DIFF=3) then Begin
        DIFF:=(Clock div 2) mod 10;
        DIFF:=DIFF+2;
        DPRICE:=DPRICE-DIFF;
        USERI[NUM,5]:=USERI[NUM,5]+2;
        Mrite ('The merchant lowers his price by ');
        Send_Num(DIFF);
        Mriteln(' Gold Pieces.');
        DONE:='NO'
      End
      End;
      Until DONE='YES';
    If HM='B' then Begin
      Mriteln ('Buy');
      If USERI[NUM,4] < DPRICE then Begin
        Mrite ('The Mechant Yells, "Thou hast not ');
        Send_Num(DPRICE);
        Mriteln(' Gold Pieces!!"');
        HM:='NO'
      End;
      If USERI[NUM,4]=DPRICE then Begin
        Mriteln ('That would leave thee broke!');
        HM:='NO'
      End;
      If HM <> 'NO' then Begin
        USERI[NUM,4]:=USERI[NUM,4]-DPRICE;
        OVERALL:=OVERALL+DPRICE;
        Mriteln('');Mriteln ('Very well!');
        DPRICE:=0
      End;
    End;
    Mriteln('');
    If HM <> 'B' then Mriteln ('The merchant growls with anger!');
    If HM='B' then Begin
      If J<24 then USERS[NUM,J]:=THINGS;
      If J=24 then Begin
        USERS[NUM,5]:=THINGS;
        USERS[NUM,6]:=THINGS
    End;
    Mriteln('');Mrite ('Would''st thou care for anything else? [Y/N] ');
    WHAT(THINGS);
    Mriteln('')
   End;
   End;
   End;
   End;
   MAKESURE(NUM,SUN,OVER);
   If OVER=TRUE then BYE:=TRUE;
   Until (BYE=TRUE) or (THINGS='N');
   If OVER=FALSE then Begin
     If OVERALL=0 then Mriteln ('The Merchant gives thee a disgusted look!');
     If OVERALL>1 then Mriteln ('The Merchant tells thee to come again soon!');
     STOP
    End
   End;
      If (OVER=FALSE) and (WRONG=TRUE) then Begin
        Mriteln('');Mriteln ('A Sign Says:  ');
        Mriteln('');Mrite('The ');
        Mrite(TOWNS[USERI[NUM,14],11]);
        Mriteln(' Shoppe is currently -* CLOSED *-.');
        DISTIME(TOWNI[USERI[NUM,14],17],RIGHT);
        Mriteln('');
        Mrite ('Our Hours are ');
        Send_Num(RIGHT);
        If TOWNI[USERI[NUM,14],17]>12 then Mrite (' P.M. to ');
        If TOWNI[USERI[NUM,14],17]<13 then Mrite (' A.M. to ');
        DISTIME(TOWNI[USERI[NUM,14],18],RIGHT);
        Send_Num(RIGHT);
        If TOWNI[USERI[NUM,14],18]>12 then Mrite (' P.M.');
        If TOWNI[USERI[NUM,14],18]<13 then Mrite (' A.M.');
        Mriteln('');Mriteln ('Please come again when we are open...');
        STOP;
        Mriteln('')
      End
   End;
(**************************************************************************)
  Procedure CYA(Var OVER:Boolean;Var NUM:Integer);
    Var
      JUNK:Str255;
    Begin
      Mriteln('');Mrite ('Dost thou really wish to leave? ');
      WHAT(JUNK);
      If JUNK='Y' then Begin
      Mriteln('');Mrite ('Thou hast ');
      Send_Num(USERI[NUM,6]);
      Mriteln(' Minute(s) left should thee decide to play again today.');
      OVER:=True
      End
    End;
(** STEAL FROM OTHER GUILD MEMBERS ****************************************)
  Procedure SFOGM(Var NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      WHICH,TOTAL,SEP,COND,IS:Integer;
      DIFF:Long_Integer;
      SURE,OTHER,WORD,TEMP:Str255;
      SFMSG:Text;
      UNI:Boolean;
    Begin
     UNI:=False;DEATH:='';
     Repeat
      Mriteln('');
      If USERI[NUM,9]=0 then Mriteln ('No More Steals Allowed For Today!');
      If USERI[NUM,9]>0 then Begin
       Repeat
         Mrite ('Thou Hast ');
         Send_Num(USERI[NUM,9]);
         Mriteln(' More Steal(s) For Today.');
         Mrite ('Steal from which Thief? [?=List] [Return Aborts]: ');
         IS:=0;
         SURE:='';
         ASK(NUM,WHICH,IS,UNI);
         If WHICH > 0 then Begin
         Mrite (USERS[WHICH,3]);
         Mrite(' [Y/N] ');
         WHAT(SURE)
         End;
       Until (SURE='Y') or (WHICH=-1);
       If WHICH > 0 then Begin
         If USERI[WHICH,15]>0 then Begin
           Mriteln('');Mrite (USERS[WHICH,3]);
           Mriteln(' is protected by an Anti-Theft Spell!');
           SURE:='CANT';
           WHICH:=0
          End;
        If WHICH>0 then Begin
         If ((USERI[WHICH,3]*3)<USERI[NUM,3]) and (SURE<>'CANT') then Begin
           Mriteln('');Mriteln('It is against guild ethics to steal from a member whose skill thou doth triple!');
           SURE:='CANT';WHICH:=0
          End;
         End;
         If (USERI[NUM,15]>0) and (SURE<>'CANT') then Begin
           Mriteln('');Mriteln ('If thou dost steal, thou will lose thy Anti-Theft protection!');
           Mrite('Continue? ');
           WHAT(SURE);
           If SURE='N' then WHICH:=0;
           If SURE='Y' then USERI[NUM,15]:=0
          End;
        If WHICH>0 then
         If USERI[WHICH,7]>0 then Begin
           Mriteln('');Mrite (USERS[WHICH,3]);
           Mriteln(' is in jail, If thou art caught, thou wilt also');
           Mrite ('be thrown in jail.  Dost thou still wish to steal? ');
           WHAT(SURE)
          End
         End;
         If SURE='N' then WHICH:=0;
       If WHICH > 0 then Begin
         Mriteln('');Mrite ('Press [RETURN] to try and Steal from ');
         Mrite(USERS[WHICH,3]);Mrite('!');
         QSTOP;
         TOTAL:=USERI[NUM,3]+USERI[WHICH,3];
         DIFF:=DRANDOM mod TOTAL+1;
         If (DIFF < USERI[NUM,3]) or (DIFF=USERI[NUM,3]) then Begin
         EM_SEND(102);
           Mriteln('');Mriteln ('Attempt was a SUCCESS!');
           USERI[NUM,9]:=USERI[NUM,9]-1;EM_SEND(113);
           SEP:=(Clock div 2) mod 100+USERI[WHICH,3];
           If USERI[WHICH,3]<USERI[NUM,3] Then USERI[NUM,5]:=USERI[NUM,5]+100;
           If USERI[WHICH,3]>USERI[NUM,3] Then USERI[NUM,5]:=USERI[NUM,5]+500;
           If DIFF>USERI[WHICH,4] then DIFF:=USERI[WHICH,4];
           USERI[WHICH,4]:=USERI[WHICH,4]-DIFF;
           USERI[NUM,4]:=USERI[NUM,4]+DIFF;
           USERI[NUM,3]:=USERI[NUM,3]+1;
           If USERI[WHICH,3]>5 then USERI[WHICH,3]:=USERI[WHICH,3]-1;
           Mriteln('');Mrite ('Thou hast stolen ');
           Send_Num(DIFF);Mriteln(' Gold Pieces!');
           Mriteln ('Thou hast Gained 1 Skill Point!');
           If USERI[WHICH,4] < 1 then COND:=7;
           If USERI[WHICH,4] < 1 then ESTUFF(WHICH,NUM,SURE,COND);
           If USERI[WHICH,4] < 1 then GOODBYE(NUM,WHICH,OVER);
           If COND<>7 then Begin
             COND:=1;STEALER:=DIFF;
             ESTUFF(WHICH,NUM,SURE,COND);
             COND:=0;STEALER:=0
            End;
           If USERI[NUM,9]=0 then Mriteln('');
           If USERI[NUM,9]=0 then Mriteln ('That was thy last steal for today!')
        End;
         If DIFF > USERI[NUM,3] then Begin
           Mriteln('');Mriteln ('Attempt was a FAILURE!');
           USERI[NUM,9]:=USERI[NUM,9]-1;EM_SEND(107);
           USERI[NUM,5]:=USERI[NUM,5]+13;
           Mriteln('');Mriteln ('Thou hast lost 1 Skill Point!');
           TEMP:=TPATH;
           INSERT('STEALMSG.DAT',TEMP,((Ord(TEMP[0]))+1));
           MReset(SFMSG,TEMP);COND:=0;
           For COND:=1 to WHICH do Readln(SFMSG,SURE);
           Close(SFMSG);
           If SURE<>'' then Begin
             Mriteln('');
             Mrite(USERS[WHICH,3]);
             Mrite(' says, "');
             Mrite(SURE);
             Mriteln('"');
            End;
           COND:=2;
           ESTUFF(WHICH,NUM,SURE,COND);
           If USERI[WHICH,7]>0 then JAIL(NUM,OVER);
           If USERI[NUM,9]=0 then Mriteln('');
           If USERI[NUM,9]=0 then Mriteln ('That was thy last steal for today!');
           If USERI[NUM,3]>5 then USERI[NUM,3]:=USERI[NUM,3]-1;
           USERI[WHICH,3]:=USERI[WHICH,3]+1
          End
         End;
         If (WHICH <> -1) and (USERI[NUM,9] > 0) and (OVER=False) then Begin
         Mriteln('');Mrite ('Dost thou wish to try to steal from someone else? ');
         WHAT(SURE)
         End
         End;
       MAKESURE(NUM,SUN,OVER);
       Until (SURE='N') or (WHICH=-1) or (USERI[NUM,9]=0) or (OVER=TRUE);
       STOP;
       Mriteln('')
       End;
(**************************************************************************)
  Procedure CIVILIANS(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      POPS,HOWLONG,COUNT,COUNT1,GUA,RANDOM,GOLD,OTHER,BACK,POUCH,SACK,RAN,POT:Integer;
      SURE,OUTFIT,WILL:Str255;
      CONT,TEMPEM:Boolean;
    Begin
      POPS:=TOWNI[USERI[NUM,14],7];CONT:=True;
      MAKESURE(NUM,SUN,OVER);
      If OVER=False then Begin
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('E');
        Mriteln('');Mriteln('Thou dost roam the streets looking for unsuspecting civilians...');
        Mriteln('');Mrite('      Street Condition: ');
        If POPS<=4000 then Mriteln('Almost Empty!');
        If (POPS>4000) and (POPS<=7500) then Mriteln('Moderately Crowded...');
        If (POPS>7500) and (POPS<=10000) then Mriteln('Crowded.');
        If POPS>10000 then Mriteln('VERY Crowded!');
        Repeat
          Mriteln('');
          Mrite('Go pick-pocketing for how many hours? (0=Cancel): ');
          Meadln(SURE);BUGPROOF(SURE,HOWLONG);
          If HOWLONG>USERI[NUM,6] then Begin
            Mriteln('');Mrite('Thou only hast ');Send_Num(USERI[NUM,6]);
            Mriteln(' Hour(s) left today.');
           End;
        Until (HOWLONG>-1) and (HOWLONG<=USERI[NUM,6]);
        If HOWLONG>0 then Begin
          GUA:=DRANDOM mod (USERI[NUM,3] div 2)+1;
          For COUNT:=1 to HOWLONG do Begin
            If (OVER=False) and (CONT=True) then Begin
              Mriteln('');Mrite('Press ANY key to steal for hour #');
              Send_Num(COUNT);Mrite(' [S]top...');
              SOMETHING(SURE);If SURE='S' then CONT:=False;If SURE='S' then Mriteln('Stop...');
              If SURE<>'S' then Mriteln('');
              If CONT=True then Begin
                GUA:=GUA-1;USERI[NUM,6]:=USERI[NUM,6]-1;Mriteln('');
                Case GUA of
                  0:Mriteln('Some guards grab thy shoulder, "Thou art under arrest!"');
                  2:Mriteln('A couple guards gain on thee!');
                  4:Mriteln('Some guards are following thee!');
                  6:Mriteln('The guards look at thee suspiciously...')
                 End;
                 If GUA=0 then ESTUFF(NUM,NUM,'',46);
                 If GUA=0 then JAIL(NUM,OVER);
                 If (GUA=0) and (OVER=False) then Mriteln('');
                 If GUA=0 then GUA:=DRANDOM mod 24+1;
                 If OVER=False then Begin
                   If (DRANDOM mod (POPS+8000))>8000 then Begin
                     OTHER:=DRANDOM mod 5+1;
                     For COUNT1:=1 to OTHER do Begin
                      If OVER=False then Begin
                       GOLD:=DRANDOM mod 35+1;
                       If GOLD<5 then GOLD:=9;
                       Mrite('Thou stole from a ');USERI[NUM,5]:=USERI[NUM,5]+350;
                       Mrite(MONSTER[GOLD]);Mriteln('!');C_MONSTER:=GOLD;
                       If DRANDOM mod 8+1=3 then Begin
                         Mrite('The ');Mrite(MONSTER[GOLD]);
                         Mriteln(' catches thee!');
                         If DRANDOM mod 3+1=3 then Begin
                           Mriteln('');Mriteln('He calls for the Guards!');
                           EM_SEND(104);
                           ESTUFF(NUM,NUM,'',46);
                           JAIL(NUM,OVER)
                          End
                         Else Begin
                           If EMULATE then STOP;EM_SEND((600+C_MONSTER)-1);
                           EM_SEND(303);
                           COMBAT(1,OVER,False);
                         End;
                        End;
                       End;
                      End;
                    If OVER=False then Begin
                     Mriteln('');
                     Mrite('Thou stole a total of ');
                     GOLD:=DRANDOM mod (USERI[NUM,3]*2);GOLD:=GOLD+10;
                     Send_Num(GOLD);
                     Mriteln(' gold pieces!');
                     USERI[NUM,4]:=USERI[NUM,4]+GOLD;
                     GOLD:=DRANDOM mod 7+1;
                     If GOLD=4 then Begin
                       Mriteln('');
                       GOLD:=DRANDOM mod 35+1;
                       If GOLD<5 then GOLD:=9;
                       Mrite('Thou dost notice a ');
                       Mrite(MONSTER[GOLD]);Mriteln(' carrying a heavy load...');
                       Mriteln('');Mrite('Steal from his [B]ackpack, [P]ouch, [S]ack, or [N]one? ');
                       Repeat
                         SOMETHING(SURE);
                       Until (SURE='B') or (SURE='P') or (SURE='S') or (SURE='N');
                       Case SURE[1] of
                         'B':Mriteln('Backpack...');
                         'P':Mriteln('Pouch...');
                         'S':Mriteln('Sack...');
                         'N':Mriteln('None.')
                        End; {Case}
                       RAN:=DRANDOM mod 4+1;
                       If (RAN=3) and (SURE<>'N') then Begin
                         EM_SEND(107);
                         Mriteln('');Mriteln('He catches thee and yells for the guards!');
                         EM_SEND(104);
                         ESTUFF(NUM,NUM,'',46);
                         JAIL(NUM,OVER)
                        End;
                       If (RAN<>3) and (SURE<>'N') then Begin
                         Mriteln('');Mriteln('Attempt was successful!');Mriteln('');
                         USERI[NUM,5]:=USERI[NUM,5]+1000;EM_SEND(113);
                         If SURE='S' then Begin
                           SACK:=DRANDOM mod 3000+2;
                           Mrite('The sack contains ');Send_Num(SACK);
                           Mriteln(' Gold pieces!!!');
                           USERI[NUM,4]:=USERI[NUM,4]+SACK
                          End;
                         If SURE='P' then Begin
                           POUCH:=DRANDOM mod 10+1;
                           If POUCH<5 then Begin
                             Mriteln('The pouch contains 3 magical poison darts!');
                             USERI[NUM,28]:=USERI[NUM,28]+3;
                            End;
                           If (POUCH>4) and (POUCH<10) then Begin
                             TEMPEM:=EMULATE;EMULATE:=False;
                             Mriteln('The pouch contains 6 potions!!');
                             For POT:=1 to 6 do POTION;
                             EMULATE:=TEMPEM
                            End;
                           If POUCH>9 then Begin
                             Mriteln('The pouch contains a magic crystal!!!');
                             USERI[NUM,37]:=USERI[NUM,37]+1
                            End;
                           End;
                          If SURE='B' then Begin
                            BACK:=DRANDOM mod 9+1;
                            OUTFIT:='Cheap Brown Sandals';
                            Case BACK of
                             1:OUTFIT:='Expensive Elvin Boots';
                             2:OUTFIT:='Expensive Dragonskin Boots';
                             3:OUTFIT:='Expensive Magical Sandals';
                             4:OUTFIT:='Expensive Green Tunic';
                             5:OUTFIT:='Expensive Silver Breastplate';
                             6:OUTFIT:='Awesome Thieves'' Guild T-Shirt';
                             7:OUTFIT:='Expensive Wizard''s hat';
                             8:OUTFIT:='EXPENSIVE Gold Crown';
                             9:OUTFIT:='Expensive Silk Hood'
                            End; {Case}
                            Mrite('Thou stole ');
                            If BACK<4 then Mrite('some ');
                            If BACK>3 then Mrite('an ');
                            Mrite(OUTFIT);Mrite(', wear? ');
                            WHAT(WILL);
                            If WILL='Y' then Begin
                              If BACK>6 then USERS[NUM,4]:=OUTFIT;
                              If (BACK>3) and (BACK<7) then USERS[NUM,5]:=OUTFIT;
                              If BACK<4 then USERS[NUM,7]:=OUTFIT;
                            End;
                           End;
                       End;
                      End;
                     End;
                    End
                   Else Mriteln('Thou found no good opportunity...');
           End;
          End;
         End;
        End;
       End;
      End;
      If OVER=False then STOP;
     End;
(**************************************************************************)
  Procedure WIZARDS(Var NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      SKILL,RIGHT,WHICH,COND,IS,QUICKIE,UNIFIGURE:Integer;
      GOLD,DUMB,HITSELL:Long_Integer;
      WISH,SKILLS,SURE,ME:Str255;
      WRONG,UNI,UNICURSE:Boolean;
    Begin
     UNI:=False;UNICURSE:=False;
     WRONG:=TRUE;ME:='';
    If TOWNI[USERI[NUM,14],11]>TOWNI[USERI[NUM,14],12] then
     If (USERI[NUM,6]<=TOWNI[USERI[NUM,14],11]) and (USERI[NUM,6]>TOWNI[USERI[NUM,14],12]) then ME:='ONE';
    If TOWNI[USERI[NUM,14],11]<TOWNI[USERI[NUM,14],12] then
     If (USERI[NUM,6]<=TOWNI[USERI[NUM,14],11]) or (USERI[NUM,6]>=TOWNI[USERI[NUM,14],12]) then ME:='TWO';
     If (ME='ONE') or (ME='TWO') or (GT=True) then Begin
     BOOGIE:=True;EM_SEND(404);EM_SEND(301);
     Repeat
      WRONG:=FALSE;
      DUMB:=0;GOLD:=0;
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      ABLE:=True;
      Mriteln('');
      Mrite ('Thou art at the -=* ');
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('b1');
      Mrite (TOWNS[USERI[NUM,14],8]);
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('b3');
      Mriteln(' *=- Wizard''s Guild.');
      Mriteln('');
      Mriteln (TOWNS[USERI[NUM,14],9]);
      Mriteln ('The Wizard approaches thee, "What is thy Wish?"');
      Mriteln('');
      If USERI[NUM,14]=19 then
      Mriteln (' [0] Ship Enchantment <Mystic Winds> ..8000 G.P.');
      Mrite (' [1] Raise Thy Skill ..................');
      Send_Num(((USERI[NUM,3]*3)div 5)*TOWNI[USERI[NUM,14],10]);
      Mriteln(' G.P.');
      Mrite (' [2] Read Someone''s Mind ..............');
      Send_Num((((USERI[NUM,3]*3)div 5)*TOWNI[USERI[NUM,14],10]));
      Mriteln(' G.P.');
      Mrite (' [3] Protect Thy Mind .................');
      Send_Num((USERI[NUM,3] div 2)*TOWNI[USERI[NUM,14],10]);
      Mriteln(' G.P. per Day');
      Mrite (' [4] Curse Thy Foe ....................');
      Send_Num(400*TOWNI[USERI[NUM,14],10]);
      Mriteln(' G.P.');
      Mrite (' [5] Send a Telepathic Message ........');
      Send_Num(20*TOWNI[USERI[NUM,14],10]);
      Mriteln(' G.P.');
      Mriteln(' [6] Cure ALL of thy Ailments .........400 G.P.');
      Mriteln(' [7] Heal .............................50 G.P. per HP');
      If (USERI[NUM,19]=11) and (TOWNI[USERI[NUM,14],19]=3) then Begin
       EM_SEND(1058);
       If EMULATE=False then Begin
        Mriteln(' [8] Global Search ....................6500 G.P.');
        Mriteln(' [9] Universal Curse ..................7500 G.P.');
        Mriteln('[10] Universal Mind Read ..............1500 G.P.');
        Mriteln('[11] Teleport Item ....................200 G.P.');
        Mriteln('[12] Kill Assassin ....................5000 G.P.');
        Mriteln('[13] Transport ........................6000 G.P.');
        Mriteln('[14] Location .........................1000 G.P.')
       End;
      End;
      If (USERI[NUM,19]=5) and (TOWNI[USERI[NUM,14],19]<3) then Begin
       EM_SEND(1059);
       If EMULATE=False then Begin
        Mriteln(' [8] Sleep Spell ......................5000 G.P.');
        Mriteln(' [9] Universal Curse  .................7500 G.P.');
        Mriteln('[10] Universal Mind Read ..............1500 G.P.');
        Mriteln('[11] Balorian Gaze of Death!!! ........30000 G.P.');
        Mriteln('[12] Kill Assassin ....................5000 G.P.');
        Mriteln('[13] Mind Crush .......................10000 G.P.');
        Mriteln('[14] Location .........................1000 G.P.')
        End;
       End;
      If (USERI[NUM,19]=21) and (TOWNI[USERI[NUM,14],19]>3) then Begin
       EM_SEND(1060);
       If EMULATE=False then Begin
        Mriteln(' [8] Invisibility .....................1000 G.P. per Day');
        Mriteln(' [9] Anti-Theft .......................2000 G.P. per Day');
        Mriteln('[10] Increase Hit Points ..............750 G.P.');
        Mriteln('[11] Teleport Item ....................200 G.P.');
        Mriteln('[12] Enchant Weapon/Armour ............3000 G.P.');
        Mriteln('[13] Transport ........................6000 G.P.');
        Mriteln('[14] Location .........................1000 G.P.')
       End;
      End;
      Mriteln('');
      Mriteln ('[15] Leave the Guild.');
      ABLE:=False;SOFF:=False;
      Mriteln('');Mrite ('Thou dost Feel intense powers about thee: ');
      Meadln (WISH);
      If ((USERI[NUM,19]=21) and (TOWNI[USERI[NUM,14],19]>3)) or
         ((USERI[NUM,19]=11) and (TOWNI[USERI[NUM,14],19]=3)) or
         ((USERI[NUM,19]=5) and (TOWNI[USERI[NUM,14],19]<3)) then Begin
        If (WISH='11') and (USERI[NUM,19]=5) then Begin
          Mriteln('');
          Mriteln('Thy foe will lose 1/8th score, 1/4th skill, and have their energy drained!');
          Mriteln('They must reside in an Evil town...');
          Mriteln('');
          Repeat
            Mrite ('GAZE AT WHOM???? [?=List] [Return Aborts]: ');
            IS:=0;UNI:=True;
            ASK(NUM,WHICH,IS,UNI);SURE:='N';
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
              End;
          Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
          UNI:=False;
          If WHICH>0 then Begin
          Mriteln('');
          Mrite('That will be 30000 Gold, do it? ');
          WHAT(SURE);Mriteln('');
          If SURE='Y' then Begin
            If USERI[NUM,4]<=30000 then Mriteln('Thou hast not the Gold...')
            Else Begin
              USERI[NUM,4]:=USERI[NUM,4]-30000;
              If (USERI[WHICH,13]=0) and ((TOWNI[USERI[WHICH,14],19]=1) or
                 (TOWNI[USERI[WHICH,14],19]=2)) then Begin
               Mriteln('The Wizards gather & summon Balor from the depths of the Abyss!!!!!');
               EM_SEND(113);
               USERI[WHICH,3]:=USERI[WHICH,3]-(USERI[WHICH,3] div 4);
               USERI[WHICH,5]:=USERI[WHICH,5]-(USERI[WHICH,5] div 8);
               USERI[WHICH,10]:=-25;
               USERI[WHICH,11]:=-25;
               USERI[WHICH,12]:=-25;
               ESTUFF(WHICH,NUM,'',39);
              End
              Else Begin
                Mriteln('The spell goes Foul!!!!!!!!!!!!!!');
                ESTUFF(WHICH,NUM,'',40);
             End;
           STOP
          End;
         End;
        End;
        End;
        If (WISH='8') and (USERI[NUM,19]=5) then Begin
          Mriteln('');
          Mriteln('Thy enemy must have 24 hours left, or the spell will fail!');
          Mriteln('');
          Repeat
            Mrite ('Cause who to sleep? [?=List] [Return Aborts]: ');
            IS:=0;UNI:=True;
            ASK(NUM,WHICH,IS,UNI);SURE:='N';
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
              End;
          Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
          UNI:=False;
          If WHICH>0 then Begin
          Mriteln('');
          Mrite('That will be 5000 Gold, do it? ');
          WHAT(SURE);Mriteln('');
          If SURE='Y' then Begin
            If USERI[NUM,4]<=5000 then Mriteln('Thou hast not the Gold...')
            Else Begin
              USERI[NUM,4]:=USERI[NUM,4]-5000;
              If (USERI[WHICH,13]=0) and (USERI[WHICH,6]=24) then Begin
               SKILL:=DRANDOM mod 10+1;
               Mrite('The Wizard summons Morpheus, the spell lasts ');
               Send_Num(SKILL);
               Mriteln(' hour(s)!!!!');EM_SEND(113);
               USERI[WHICH,6]:=USERI[WHICH,6]-SKILL;
               ESTUFF(WHICH,NUM,'',37);
              End
              Else Begin
                If USERI[WHICH,13]>0 then Mriteln('The wizard says, "Their mind is protected!"');
                If USERI[WHICH,6]<24 then Mriteln('The spell goes foul!!');
                ESTUFF(WHICH,NUM,'',38);
             End;
           STOP
          End;
         End;
        End;
        End;
        If (WISH='13') and (USERI[NUM,19]=5) then Begin
          Mriteln('');
          Mriteln('We can penetrate thy foes mind protection, they must be in an evil town.');
          Mriteln('');
          Repeat
            Mrite ('Crush who''s mind protection? [?=List] [Return Aborts]: ');
            IS:=0;UNI:=True;
            ASK(NUM,WHICH,IS,UNI);SURE:='N';
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
              End;
          Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
          UNI:=False;
          If WHICH>0 then Begin
          Mriteln('');
          Mrite('That will be 10000 Gold, do it? ');
          WHAT(SURE);Mriteln('');
          If SURE='Y' then Begin
            If USERI[NUM,4]<=10000 then Mriteln('Thou hast not the Gold...')
            Else Begin
              If (TOWNI[USERI[WHICH,14],19]=1) or (TOWNI[USERI[WHICH,14],19]=2) then Begin
              USERI[NUM,4]:=USERI[NUM,4]-10000;
              Mriteln('The Wizard summons demons to help, It is done!!!');
              USERI[WHICH,13]:=0;
              ESTUFF(WHICH,NUM,'',36);
               End
              Else Mriteln('They are not in an Evil town!!');
             End;
           STOP
          End;
         End;
        End;
        If (WISH='10') and ((USERI[NUM,19]=11) or (USERI[NUM,19]=5)) then Begin
          UNICURSE:=True;
          WISH:='2'
         End;
        If (WISH='9') and ((USERI[NUM,19]=11) or (USERI[NUM,19]=5)) then Begin
          UNICURSE:=True;
          WISH:='4'
         End;
        If (WISH='12') and ((USERI[NUM,19]=11) or (USERI[NUM,19]=5)) then Begin
          Mriteln('');Mriteln('We will kill any assassins that may be coming for thee!');
          Mriteln('');Mrite('That is 5000 gold, shall we proceed? ');
          WHAT(SKILLS);Mriteln('');
          If SKILLS='Y' then Begin
            If USERI[NUM,4]<=5000 then Mriteln('Not enough Gold!')
            Else Begin
              Mriteln('');
              USERI[NUM,4]:=USERI[NUM,4]-5000;
              If USERI[NUM,25]=0 then Mriteln('No Assassins killed...');
              If USERI[NUM,25]>0 then Begin
                Repeat
                  USERI[NUM,25]:=USERI[NUM,25]-100
                Until USERI[NUM,25]<100;
                Mrite('Some Assassins have been Killed!!!!');
                If USERS[USERI[NUM,25],3] <> 'EMPTY' then Begin
                  Mrite('  Sent by ');
                  Mrite(USERS[USERI[NUM,25],3]);
                  Mrite('!!')
                 End;
                Mriteln('');USERI[NUM,25]:=0;
              End;
             End;
            End;
            STOP;
           End;
        If (WISH='8') and (USERI[NUM,19]=11) then Begin
          Mriteln('');Mriteln('The location of all guild members shall be revealed to thee!');
          Mriteln('');Mrite('The price is but 6500 gold, do it? ');
          WHAT(SKILLS);Mriteln('');
          If SKILLS='Y' then Begin
            If USERI[NUM,4]<=6500 then Mriteln('Not enough Gold!')
            Else Begin
              USERI[NUM,4]:=USERI[NUM,4]-6500;
              Mriteln('');Mriteln('The Wizard peers into a brilliant Crystal...');
              Mriteln('');
              For SKILL:=1 to 26 do Begin
               If USERS[SKILL,3]<>'EMPTY' then Begin
                Mrite (USERS[SKILL,1]);
                Mrite('  ');
                Mrite(USERS[SKILL,3]);
                For COND:=1 to (28-(ord(USERS[SKILL,3][0]))) do
                Mrite (' ');
                Mriteln(TOWNS[USERI[SKILL,14],1]);
              End;
             End;
            End;
           End;
           STOP;
          End;
        If (WISH='8') and (USERI[NUM,19]=21) then Begin
          Mriteln('');Mriteln('Thou shall be invisible to other Guild Memebers.');
          Mriteln('');Mrite('Buy how many days worth: ');
          Meadln(SKILLS);
          BUGPROOF(SKILLS,SKILL);
          If SKILL>0 then Begin
            Mriteln('');Mrite('That would cost ');
            Send_Num(SKILL*1000);
            Mrite(' Gold, do it? ');
            WHAT(SKILLS);Mriteln('');
            If SKILLS='Y' then Begin
              If USERI[NUM,4]<=(SKILL*1000) then Mriteln('Not enough Gold!')
              Else Begin
                Mriteln('It is done!  Thou now hast invisibility!');
                USERI[NUM,27]:=USERI[NUM,27]+SKILL;
                USERI[NUM,4]:=USERI[NUM,4]-(SKILL*1000);
               End;
              STOP
             End;
            End;
           End;
        If (WISH='9') and (USERI[NUM,19]=21) then Begin
          Mriteln('');Mrite('Buy how many days of Theft Protection: ');
          Meadln(SKILLS);
          BUGPROOF(SKILLS,SKILL);
          If SKILL>0 then Begin
            Mriteln('');Mrite('That would cost ');
            Send_Num(SKILL*2000);
            Mrite(' Gold, do it? ');
            WHAT(SKILLS);Mriteln('');
            If SKILLS='Y' then Begin
              If USERI[NUM,4]<=(SKILL*2000) then Mriteln('Not enough Gold!')
              Else Begin
                Mriteln('Thou now hast Theft Protection!');
                USERI[NUM,15]:=USERI[NUM,15]+SKILL;
                USERI[NUM,4]:=USERI[NUM,4]-(SKILL*2000);
               End;
              STOP
             End;
            End;
           End;
        If (WISH='10') and (USERI[NUM,19]=21) then Begin
          Mriteln('');Mrite('Increase how many Hit points: ');
          Meadln(SKILLS);
          BUGPROOF(SKILLS,SKILL);HITSELL:=SKILL;
          If HITSELL>0 then Begin
            Mriteln('');Mrite('That would cost ');
            Send_Num(HITSELL*750);
            Mrite(' Gold, do it? ');
            WHAT(SKILLS);Mriteln('');
            If SKILLS='Y' then Begin
              If USERI[NUM,4]<=(HITSELL*750) then Mriteln('Not enough Gold!')
              Else Begin
                Mriteln('Thy Life Force increases!!!!!!');
                USERI[NUM,21]:=USERI[NUM,21]+HITSELL;
                USERI[NUM,4]:=USERI[NUM,4]-(HITSELL*750);
               End;
              STOP
             End;
            End;
           End;
        If (WISH='11') and ((USERI[NUM,19]=21) or (USERI[NUM,19]=11)) then Begin
          Mriteln('');
          Repeat
            Mrite ('Send Gold to who? [?=List] [Return Aborts]: ');
            IS:=0;UNI:=True;
            ASK(NUM,WHICH,IS,UNI);SURE:='N';
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
              End;
          Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
          UNI:=False;
          If WHICH>0 then Begin
            If USERI[NUM,4]<=200 then Mriteln('Not enough Gold!')
           Else Begin
            Repeat
              Mriteln('');Mrite ('Give how much Gold? ');
              Meadln(SKILLS);
              BUGPROOF(SKILLS,SKILL);
            Until (SKILL>-1);
            If SKILL>=USERI[NUM,4] then Mriteln ('Thou dost not have that much!!')
            Else Begin
              If SKILL>0 then Begin
              Mriteln('');Send_Num(SKILL);
              Mrite(' Gold? ');
              WHAT(SURE);
              If SURE='Y' then Begin
                Mriteln('');Mrite ('Thou gave ');
                Send_Num(SKILL);Mrite(' Gold Piece(s) to ');
                Mrite(USERS[WHICH,3]);Mriteln('!');
                COND:=22;
                ESTUFF(WHICH,NUM,SKILLS,COND);
                USERI[NUM,4]:=USERI[NUM,4]-SKILL;
                USERI[WHICH,4]:=USERI[WHICH,4]+SKILL
               End
              End;
             End;
            End;
           End;
          End;
        If (WISH='12') and (USERI[NUM,19]=21) then Begin
          Mriteln('');
          Mrite('Enchant thy [W]eapon, or [A]rmour? ');
          Repeat
           SOMETHING(SKILLS)
          Until (SKILLS='W') or (SKILLS='A');
          If SKILLS='W' then Mriteln('Weapon...');
          If SKILLS='A' then Mriteln('Armour...');
          Mriteln('');
          Mrite('That will be 3000 Gold, shall we do it? ');
          WHAT(SURE);Mriteln('');
          If SURE='Y' then Begin
            If USERI[NUM,4]<=3000 then Mriteln('Thou hast not the Gold...')
            Else Begin
              USERI[NUM,4]:=USERI[NUM,4]-3000;
              If (SKILLS='W') and (USERI[NUM,23]=2) then USERI[NUM,23]:=3;
              If (SKILLS='A') and (USERI[NUM,23]=1) then USERI[NUM,23]:=3;
              If (SKILLS='W') and (USERI[NUM,23]=0) then USERI[NUM,23]:=1;
              If (SKILLS='A') and (USERI[NUM,23]=0) then USERI[NUM,23]:=2;
              Mriteln('It glows a faint blue...  The Wizard says, "It is now Enchanted!"');
             End;
            STOP
           End;
         End;
        If (WISH='13') and ((USERI[NUM,19]=21) or (USERI[NUM,19]=11)) then Begin
          Mriteln('');
          Repeat
            Mrite ('Transport with who? [?=List] [Return Aborts]: ');
            IS:=0;UNI:=True;
            ASK(NUM,WHICH,IS,UNI);SURE:='N';
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
              End;
          Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
          UNI:=False;
          If WHICH>0 then Begin
          Mriteln('');
          Mrite('That will be 6000 Gold, do it? ');
          WHAT(SURE);
          If SURE='Y' then Begin
            If USERI[NUM,4]<=6000 then Mriteln('Thou hast not the Gold...')
            Else Begin
              USERI[NUM,4]:=USERI[NUM,4]-6000;
             If USERI[WHICH,14]=8 then Mriteln('The Spell goes foul!!!!');
             If USERI[WHICH,14]<>8 then Begin
              COND:=35;
              ESTUFF(WHICH,NUM,WISH,COND);
              Mriteln('');Mrite('Thou art suddenly in ');
              Mrite(TOWNS[USERI[WHICH,14],1]);
              Mriteln('!!!!');EM_SEND(USERI[WHICH,14]);
              SKILL:=USERI[NUM,14];
              USERI[NUM,14]:=USERI[WHICH,14];
              USERI[WHICH,14]:=SKILL;
             End;
            End;
            STOP
           End;
          End;
         End;
      If WISH='14' then Begin
          Mriteln('');
          Repeat
            Mrite ('Search for who? [?=List] [Return Aborts]: ');
            IS:=0;UNI:=True;
            ASK(NUM,WHICH,IS,UNI);SURE:='N';
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
              End;
          Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
          UNI:=False;
          If WHICH>0 then Begin
          Mriteln('');
          Mrite('That will be 1000 Gold, do it? ');
          WHAT(SURE);Mriteln('');
          If SURE='Y' then Begin
            If USERI[NUM,4]<=1000 then Mriteln('Thou hast not the Gold...')
            Else Begin
              USERI[NUM,4]:=USERI[NUM,4]-1000;
              Mrite(USERS[WHICH,3]);
              Mrite(' currently resides in ');
              Mrite(TOWNS[USERI[WHICH,14],1]);
              Mriteln('!!')
             End;
           STOP
          End;
         End;
        End;
       End;
      If (WISH='0') and (USERI[NUM,14]=19) then Begin
        Mriteln('');
        If MYSTIC=False then Begin
          Mriteln('The Wizards sighs, "Ah... The Magical wind of the Ancient ones..."');
          Mriteln('Thy Ship''s speed shall increase immensly!')
         End;
        If MYSTIC then Mriteln('Thy ship is already Enchanted.');
        If MYSTIC then STOP
       Else Begin
        Mriteln('');Mrite('It will cost 8,000 Gold Pieces, do it? ');
        WHAT(SKILLS);
        If SKILLS='Y' then Begin
          Mriteln('');
          If USERI[NUM,4]<=8000 then Mriteln('Thou hast not the funds...')
          Else Begin
            USERI[NUM,4]:=USERI[NUM,4]-8000;
            MYSTIC:=True;
            Mriteln('The Wizard''s surround thy Ship and recite the familiar ritual of wind!');
            Mriteln('');Mriteln('So mote it be...');
            STOP
           End
         End
        End
       End;
      If WISH='1' then Begin
       Repeat
        Mriteln('');Mrite ('How many Skill Points dost thou want raised: ');
        Meadln (SKILLS);
        BUGPROOF(SKILLS,SKILL);
        If SKILL>50 then Mriteln ('The Wizard shakes his head, "Sorry, we will raise only 50 Max. at a time."');
       Until (SKILLS<>'') and (SKILL<51);
        If (SKILL > 0) then Begin
          GOLD:=(((USERI[NUM,3]*3)div 5)*TOWNI[USERI[NUM,14],10])*SKILL;
          If GOLD > 1 then Begin
          Mriteln('');Send_Num(SKILL);
          Mrite(' Skill Point(s) would cost thee ');
          Send_Num(GOLD);
          Mriteln(' Gold Pieces.');
          Mrite ('Still want them? ');
          WHAT(SKILLS);
          If SKILLS='Y' then Begin
            Mriteln('');
            If GOLD < USERI[NUM,4] then Begin
              Mriteln ('The Wizard utters powerful words of magic!');
              Mriteln ('Suddenly thou hast more skill!');
              USERI[NUM,3]:=USERI[NUM,3]+SKILL;
              DUMB:=1;
              USERI[NUM,4]:=USERI[NUM,4]-GOLD
             End;
            If (GOLD > USERI[NUM,4]) AND (DUMB=0) then Mriteln
            ('The Wizard says, "Thou dost not have enough gold!"');
            If (GOLD=USERI[NUM,4]) AND (DUMB=0) then Mriteln ('That would leave thee broke!!');
            STOP
             End
           End
          End
         End;
      If WISH='2' then Begin
         Mriteln('');
         GOLD:=USERI[NUM,4];
         If UNICURSE=False then UNIFIGURE:=(((USERI[NUM,3]*3)div 5)*TOWNI[USERI[NUM,14],10]);
         If UNICURSE=True then UNIFIGURE:=1500;
         If USERI[NUM,4]>UNIFIGURE then Begin
          Repeat
            Mrite ('Pry into the mind of who? [?=List] [Return Aborts]: ');
            IS:=0;
            ASK(NUM,WHICH,IS,UNICURSE);SURE:='N';
            If WHICH > 0 then Begin
              Mrite (USERS[WHICH,3]);
              Mrite(' [Y/N] ');
              WHAT(SURE)
              End;
          Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
          UNICURSE:=False;
         If WHICH > 0 then Begin
            GOLD:=USERI[NUM,4];
            USERI[NUM,4]:=USERI[NUM,4]-UNIFIGURE;
           If USERI[WHICH,13] > 0 Then Begin
            Mriteln('');Mrite('The Wizard says, "');
            Mrite(USERS[WHICH,3]);
            Mriteln('''S soul is guarded by powerful magic!"');
            COND:=3;
            ESTUFF(WHICH,NUM,WISH,COND)
            End;
           If USERI[WHICH,13]=0 then Begin
            Mriteln('');Mrite('The Wizard peers into the depths of ');
            Mrite(USERS[WHICH,3]);
            Mriteln('''S Soul.');
            Mriteln('');Mrite('The Wizard says, "');
            Mrite(USERS[WHICH,3]);
            Mrite(' is carrying ');
            Send_Num(USERI[WHICH,4]);
            Mriteln(' Gold Pieces."')
            End
            End
            End;
         If GOLD=UNIFIGURE then
           Mriteln ('That would leave thee Broke!');
         If GOLD<UNIFIGURE then
           Mriteln ('The Wizard says, "Not Enough Gold!"');
         STOP
      End;
      If WISH='3' then Begin
         Repeat
          Mriteln('');
          Mriteln('Our powers may only extend to 5 Days at a time...');
          Mriteln('');
          Mrite ('Protect thy mind for how many days: ');
          Meadln (SKILLS);
          BUGPROOF(SKILLS,SKILL);
         Until (SKILLS<>'') and (SKILL<6);
         If (USERI[NUM,13]+SKILL)>5 then Begin
           Mriteln('Only 5 days allowed at a time...');
           SKILL:=0
          End;
         If SKILL>0 then Begin
          GOLD:=((USERI[NUM,3] div 2)*TOWNI[USERI[NUM,14],10])*SKILL;
          Mriteln('');Send_Num(SKILL);
          Mrite(' Day(s) would cost thee ');
          Send_Num(GOLD);
          Mriteln(' Gold Pieces.');
          Mrite ('Still want them? ');
          WHAT(SKILLS);
          DUMB:=USERI[NUM,4];
          If SKILLS='Y' then Begin
            If USERI[NUM,4] > GOLD then Begin
              Mriteln('');Mriteln ('The wizard casts a powerful spell of protection.');
              Mrite ('Thy Mind is protected for ');
              Send_Num(SKILL);
              Mriteln(' Day(s)!');
              USERI[NUM,4]:=USERI[NUM,4]-GOLD;
              USERI[NUM,13]:=USERI[NUM,13]+SKILL
             End;
            If DUMB=GOLD then Mriteln ('That would leave thee broke!');
            If DUMB<GOLD then Mriteln ('The Wizard says, "Not enough gold!"')
           End;
          STOP
       End
      End;
      If WISH='4' then Begin
        Mriteln('');
        GOLD:=USERI[NUM,4];
        If UNICURSE=False then UNIFIGURE:=400*TOWNI[USERI[NUM,14],10];
        If UNICURSE=True then UNIFIGURE:=7500;
        If USERI[NUM,4]>UNIFIGURE then Begin
        If UNICURSE=True then Begin
          Mriteln('');Mriteln('Thou mayst curse anyone, anywhere!');Mriteln('');
         End;
         Repeat
           Mrite ('Send the Powers of Evil to who? [?=List] [Return Aborts]: ');
           IS:=0;
           ASK(NUM,WHICH,IS,UNICURSE);SURE:='N';
           If WHICH > 0 then Begin
             Mrite (USERS[WHICH,3]);
             Mrite(' [Y/N] ');
             WHAT(SURE)
             End;
         Until (SURE='Y') or (WHICH=0) or (WHICH=-1);
         UNICURSE:=False;
         If WHICH > 0 then Begin
            GOLD:=USERI[NUM,4];
            USERI[NUM,4]:=USERI[NUM,4]-UNIFIGURE;
           If USERI[WHICH,13] > 0 Then Begin
            Mriteln('');Mrite ('The Wizard says, "');
            Mrite(USERS[WHICH,3]);
            Mriteln('''S Soul is Guarded by Powerful Magick!"');
            COND:=5;
            ESTUFF(WHICH,NUM,WISH,COND)
            End;
           If USERI[WHICH,13]=0 then Begin
            Mriteln('');Mrite('The Wizard Sends Demons from the Firery Depths of Hell to ');
            Mrite(USERS[WHICH,3]);
            Mriteln('''S Soul.');EM_SEND(113);
            USERI[WHICH,3]:=USERI[WHICH,3]-10;
            If USERI[WHICH,3]<5 then USERI[WHICH,3]:=5;
            USERI[WHICH,10]:=0;
            USERI[WHICH,11]:=0;
            USERI[WHICH,12]:=0;
            Mriteln('');Mrite('The Wizard says, "');
            Mrite(USERS[WHICH,3]);
            Mriteln(' Has Been Cursed!"');
            COND:=4;
            ESTUFF(WHICH,NUM,WISH,COND)
            End
            End
            End;
         If GOLD=UNIFIGURE then
           Mriteln ('That would leave thee Broke!');
         If GOLD<UNIFIGURE then Mriteln ('The Wizard is tempted to Curse THEE! Not Enough Gold!!');
         STOP
         End;
      If WISH='6' then Begin
        Mriteln('');Mriteln('A Cleric approaches thee, That will be 400 Gold...');
        Mrite('Do it? ');
        WHAT(SURE);
        If SURE='Y' then Begin
          If USERI[NUM,4]<400 then Mriteln ('Thou cannot afford it!');
          If USERI[NUM,4]=400 then Mriteln ('That Would leave thee Broke!');
          If USERI[NUM,4]>400 then Begin
            Mriteln('');Mriteln('The Cleric mumbles several words of magic...');
            Mriteln('Thou art free from any Illness!!!!');
            USERI[NUM,4]:=USERI[NUM,4]-400;
            USERI[NUM,26]:=0
           End;
         End;
         STOP
        End;
      If WISH='7' then Begin
        Mriteln('');
        If USERI[NUM,20]=USERI[NUM,21] then Mriteln('Thou art not in need of Healing!')
        Else Begin
         QUICKIE:=USERI[NUM,21]-USERI[NUM,20];
         Repeat
          Mrite('Heal how many hit points? (Max. ');
          Send_Num(QUICKIE);
          Mrite('): ');
          Meadln(SKILLS);
          BUGPROOF(SKILLS,SKILL);
         Until (SKILL=0) or ((SKILL<=QUICKIE) and (SKILL>-1));
         QUICKIE:=SKILL*50;
         If SKILL>0 then Begin
           Mrite('A Cleric approaches thee, That will be ');
           Send_Num(QUICKIE);
           Mriteln(' Gold Pieces.');
        Mrite('Do it? ');
        WHAT(SURE);
        If SURE='Y' then Begin
          If USERI[NUM,4]<QUICKIE then Mriteln ('Thou cannot afford it!');
          If USERI[NUM,4]=QUICKIE then Mriteln ('That Would leave thee Broke!');
          If USERI[NUM,4]>QUICKIE then Begin
            Mriteln('');Mriteln('The Cleric speaks, "Receive now Life''s Light..."');
            Mriteln('Thou art Healed!');
            USERI[NUM,4]:=USERI[NUM,4]-QUICKIE;
            USERI[NUM,20]:=USERI[NUM,20]+(QUICKIE div 50);
           End;
         End;
        End;
       End;
       STOP
      End;
      If WISH='5' then Begin
        Mriteln('');Mriteln ('Thou May''st send a message to anyone, Anywhere!');
        QUICKIE:=20*TOWNI[USERI[NUM,14],10];
        Mriteln('');Mrite ('It will cost thee ');
        Send_Num(QUICKIE);
        Mrite(' G.P., Do it? ');
        WHAT(SURE);
        If SURE='Y' then Begin
          If USERI[NUM,4]<QUICKIE then Mriteln ('Thou cannot afford it!');
          If USERI[NUM,4]=QUICKIE then Mriteln ('That would leave thee broke!');
          If USERI[NUM,4]>QUICKIE then Begin
            USERI[NUM,4]:=USERI[NUM,4]-QUICKIE;
            COND:=19;
            WISH:='THEPASS';
            ESTUFF(WHICH,NUM,WISH,COND)
         End
        End
       End;
      MAKESURE(NUM,SUN,OVER);
      Until (WISH='15') or (OVER=TRUE)
       End;
      If (OVER=FALSE) and (WRONG=FALSE) then Begin
        Mriteln('');Mriteln ('The Wizard bids thee to come again soon...');
        STOP
       End;
      If (OVER=FALSE) and (WRONG=TRUE) then Begin
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('E');
        Mriteln('');Mriteln ('A Sign Says:  ');
        Mriteln('');Mrite ('Sorry, The ');
        Mrite(TOWNS[USERI[NUM,14],8]);
        Mriteln(' Guild is not open to Visitors at this Time...');
        DISTIME(TOWNI[USERI[NUM,14],11],RIGHT);
        Mriteln('');
        Mrite ('Our Hours are ');
        Send_Num (RIGHT);
        If TOWNI[USERI[NUM,14],11]>12 then Mrite (' P.M. to ');
        If TOWNI[USERI[NUM,14],11]<13 then Mrite (' A.M. to ');
        DISTIME(TOWNI[USERI[NUM,14],12],RIGHT);
        Send_Num(RIGHT);
        If TOWNI[USERI[NUM,14],12]>12 then Mrite (' P.M.');
        If TOWNI[USERI[NUM,14],12]<13 then Mrite (' A.M.');
        Mriteln('');Mriteln ('Please come again Later...');
        STOP;
        Mriteln('')
      End
    End;
(***** ---====++++**** THE *FINAL* QUEST!!!!!!!!!!! ****++++====--- *******)
  Procedure FINAL(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      CD,B:Integer;
      DWORD,TEMP,JUNK:Str255;
      FNAME,ZNAME:Text;
    Begin
      If (VT=True) and (OVER=False) then Mrite(Chr(27));
      If (VT=True) and (OVER=False) then Mrite('E');
      MAKESURE(NUM,SUN,OVER);
      If OVER=False then Begin
          EM_SEND(641);EM_SEND(501);EM_SEND(428);EM_SEND(303);
          If EMULATE then STOP;
          EM_SEND(300);
          Mriteln('');
          Mriteln('Thou standeth before a sky of swirling purple  mists!!!!  Pieces  of  loose');
          Mriteln('rock are hurled through the mystic portal.  An enormous Black Dragon glares');
          Mriteln('at thee from a craggy cliff.  He  speaks  with  a  voice  that  shakes  the');
          Mriteln('very rock, "Well done, wanderer, now we meet at last.  It would be a  shame');
          Mriteln('for you to have come this far and fail at last.  I ask but a  simple  name,');
          Mriteln('a name that will allow thee to pass in peace.  If thou cannot  provide this');
          Mriteln('name I will kill thee!  The name I require is the name of the Fairy  World,');
          Mriteln('the very world that brought thee into this realm.  Answer  now,  and  speak');
          Mriteln('clearly, I''ll only give thee but one chance...');
          Mriteln('');
          Mrite('Thy legs tremble before this great beast: ');
          Meadln(DWORD);UPCASE(DWORD);
          Mriteln('');
          If DWORD='ALYASIA' then Mriteln('The Dragon says, "That is correct, thou may pass..."');
          If DWORD='ALYASIA' then WON:=True;
          If DWORD<>'ALYASIA' then Begin
            Mriteln('The Dragon roars, "THOU SPEAKETH NONSENSE FOOL!!!! DIE!!!!!"');
            Mriteln('');Mriteln('The Dragon flies from the cliff towards thee!!!');
            Mriteln('');Mriteln('The Dragon yells, "I''ll let thee flee, but NOT through the portal!"');
            If EMULATE then STOP;C_MONSTER:=42;
            EM_SEND((600+C_MONSTER)-1);
            EM_SEND(303);
            COMBAT(1,OVER,False)
           End;
          If WON then Begin
            Mriteln('');
            Mriteln('Thou dost jump through the portal!!!!!!!!!!!!!!  Your mind spins for hours...');
            STOP;EM_SEND(694);EM_SEND(303);STOP;EM_SEND(300);
            Mriteln('');Mriteln('You wake up in your computer room, wondering for  a second  if  it  was');
            Mriteln('all a dream.  Just then you look  into your monitor  to see  several of');
            Mriteln('your fellow guild members wandering  aimlessly, trapped  forever in the');
            Mriteln('world of the Thieves'' Guild.  You know  that  from this day forward you');
            Mriteln('may always come back and watch this world, to reflect upon the memories');
            Mriteln('it holds for you.');
            STOP;
            Mriteln('');Mrite('CONGRATULATIONS ');
            Mrite(USERS[NUM,3]);
            Mriteln('!!!!!!!!!!!!!!!!!!!!!!');
            Mriteln('');
            Mriteln('I hope you had as much fun playing this game as I did creating it!');
            Mriteln('');
            Mriteln('...And who knows what the future holds?');
            Mriteln('');CD:=0;
            Mriteln('Resetting game, and adding thee to the "Masters of the Riddles" list!');
            ESTUFF(NUM,NUM,'',47);
            (*ADD ADD TO MASTER OF RIDDLES LIST HERE*)
            TEMP:=DPATH;
            INSERT('JUNK.DAT',TEMP,((Ord(TEMP[0]))+1));
            Rewrite (FNAME,TEMP);
            MReset(ZNAME,RIDDLES);
            While JUNK[2]<>'"' do Begin
              Readln(ZNAME,JUNK);
              If JUNK[2]<>'"' then Writeln(FNAME,JUNK)
             End;
            Write(FNAME,DAYSS,'   ',USERS[NUM,3]);
            For B:=1 to (30-(ord(USERS[NUM,3][0]))) do
              Write (FNAME,' ');
            Write(FNAME,USERI[NUM,5]);
            MReset (FNAME,TEMP);
            Rewrite(ZNAME,RIDDLES);
            While not EOF(FNAME) do Begin
              Readln(FNAME,JUNK);
              Writeln(ZNAME,JUNK)
             End;
            Writeln(ZNAME,'===========================================================');
            Writeln(ZNAME,' "And there were some whose name would be known throughout');
            Writeln(ZNAME,'    all time, known as legends, and shining examples of');
            Writeln(ZNAME,'        great valor and bravery, against all odds."');
            STOP;
            For CD:=1 to 26 do GOODBYE(CD,CD,OVER);
            DUES:=0;GMMSG:='';BSTEAL:='';BDATE:='';
            OVER:=True;
       End;
      End;
     End;
(***** The Cave of the Ancient Ones - 4 Magic Items, 25x25 grid ***********)
  Procedure CAVE(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      MAP:Array[1..25,1..25] of Boolean;
      ANAME:Text;
      NOR,SOU,EAS,WES:Boolean;
      SPOT:Char;
      COUNTX,COUNTY,EFFECT:Integer;
      DTR,JUNKS:Str255;
    Begin
      If EMULATE then VT:=False;
      If PYRA=False then Mriteln('');
      DTR:=TPATH;
      INSERT('TOWNS.DAT',DTR,((Ord(DTR[0]))+1));
      If PYRA=False then Mriteln('Thou art looking for the cave entrance...');
      If PYRA=True then Mriteln('Thou art looking for the Pyramid entrance...');
      MReset(ANAME,DTR);
      For COUNTX:=1 to 939 do Readln(ANAME,JUNKS);COUNTX:=0;
      If PYRA=True then Begin
        For COUNTX:=1 to 625 do Readln(ANAME,JUNKS);COUNTX:=0;
       End;
      For COUNTX:=1 to 25 do Begin
        For COUNTY:=1 to 25 do Begin
          Readln(ANAME,SPOT);
          If SPOT='1' then MAP[COUNTX,COUNTY]:=True;
          If SPOT='0' then MAP[COUNTX,COUNTY]:=False;
         End;
       End;
      If PYRA=False then Begin
        EM_SEND(411);EM_SEND(699);EM_SEND(303);
       End;
      Mriteln('');
      If PYRA=False then Mrite('Thou dost find a cave entrance by scattered bones...  Enter? ');
      If PYRA=True then Mrite('The triangular pyramid entrance pulsates with green light.  Enter? ');
      WHAT(DTR);
      If DTR='N' then EM_SEND(300);
      If DTR='Y' then Begin
       If PYRA=True then Begin
         EM_SEND(427);EM_SEND(302);
        End;
       If PYRA=False then Begin
         EM_SEND(426);EM_SEND(302);
         Mriteln('');Mriteln('Scribbled on the entrance it reads, "Chant SANCTAR to flee..."');
         Mriteln('');Mriteln('Thou lighteth a torch and plunge into the dense field of darkness...');
         STOP;
         EM_SEND(426);EM_SEND(302);
        End;
      COUNTX:=24;COUNTY:=13;
      Repeat
       If OVER=False then MAKESURE(NUM,SUN,OVER);
       If OVER=False then Begin
        If PYRA=False then Begin
         Mriteln('');
         Mrite('Thou art at Coordinate (');
         Send_Num(COUNTX);Mrite(',');
         Send_Num(COUNTY);Mriteln(').');
        End;
         EFFECT:=DRANDOM mod 20+1;
         If (EFFECT<8) and (EMULATE=False) then Mriteln('');
        If (PYRA=False) and (EMULATE=False) then Begin
         Case EFFECT of
           1:Mriteln('The dull images of lizards dart about the untouched sandy floor...');
           2:Mriteln('Crisp, icy drafts rush through the dismal chambers...');
           3:Mriteln('Shadowy ghost-like figures haunt the walls...');
           4:Mriteln('Thy footsteps echo for an eternity...');
           5:Mriteln('Thy torch flickers in the blackness...');
           6:Mriteln('The lingering scent of damp stone fills the dusky air...');
           7:Mriteln('The walls sweat like frosty window panes...')
          End;
         End;
        If (PYRA=True) and (EMULATE=False) then Begin
         Case EFFECT of
           1:Mriteln('Strange hieroglyphics line the walls...');
           2:Mriteln('A mysterious sense of power fills the air...');
           3:Mriteln('Thy mind spins with confusion and disorientation...');
           4:Mriteln('The long corridors seem to have no end...');
           5:Mriteln('A strange humming noise shakes the walls...');
           6:Mriteln('A sense of desperation and clastrophobia fills thy soul...');
           7:Mriteln('With every turn the walls look exactly the same...')
          End;
         End;
         If ((COUNTX=4) and (COUNTY=13)) and (PYRA=True) then FINAL(OVER,SUN);
         If (((COUNTX=22) and (COUNTY=11)) and (USERI[NUM,35]=0)) and (PYRA=False) then Begin
           EM_SEND(690);EM_SEND(303);
           Mriteln('');Mriteln('Thou found a small ring fashioned of a tiny skull...');
           USERI[NUM,35]:=1;
           STOP;EM_SEND(302)
          End;
         If (((COUNTX=8) and (COUNTY=9)) and (USERI[NUM,36]=0)) and (PYRA=False) then Begin
           EM_SEND(693);EM_SEND(303);
           Mriteln('');Mriteln('Thou found a ring with a small sundial attached to it...');
           USERI[NUM,36]:=1;
           STOP;EM_SEND(302)
          End;
         If (((COUNTX=18) and (COUNTY=17)) and (USERI[NUM,30]=0)) and (PYRA=False) then Begin
           EM_SEND(691);EM_SEND(303);
           Mriteln('');Mriteln('Thou hast found a ring with a triangle and eye on it...');
           USERI[NUM,30]:=1;
           STOP;EM_SEND(302)
          End;
         If (((COUNTX=7) and (COUNTY=16)) and (USERI[NUM,31]=0)) and (PYRA=False) then Begin
           EM_SEND(692);EM_SEND(303);
           Mriteln('');Mriteln('Thou hast found a small wand in the shape of lightning...');
           USERI[NUM,31]:=1;
           STOP;EM_SEND(302)
          End;
         If MAP[(COUNTX-1),COUNTY]=False then NOR:=True
           Else NOR:=False;
         If MAP[(COUNTX+1),COUNTY]=False then SOU:=True
           Else SOU:=False;
         If MAP[COUNTX,(COUNTY-1)]=False then WES:=True
           Else WES:=False;
         If MAP[COUNTX,(COUNTY+1)]=False then EAS:=True
           Else EAS:=False;
        If OVER=False then Begin
         Mriteln('');
         Mriteln('Paths lead:');
         Mriteln('');
         If NOR then Mrite('[N]orth.  ');
         If SOU then Mrite('[S]outh.  ');
         If EAS then Mrite('[E]ast.  ');
         If WES then Mrite('[W]est.');
         Mriteln('');
         If PYRA=False then Mriteln('');
         If PYRA=False then Mriteln('[Y]ell "SANCTAR"!');
         Mriteln('');
         If PYRA=True then Mrite('Thy torch seems to burn with more energy: ');
         If PYRA=False then Mrite('Thy torch smokes heavily: ');
         Repeat
          SOMETHING(DTR);
         Until ((DTR='N') and (NOR=True)) or ((DTR='S') and (SOU=True))
            or ((DTR='W') and (WES=True)) or ((DTR='E') and (EAS=True)) or
            ((DTR='Y') and (PYRA=False));
         If DTR='N' then Mriteln('Navigate North...');
         If DTR='S' then Mriteln('Step South...');
         If DTR='E' then Mriteln('Explore East...');
         If DTR='W' then Mriteln('Walk West...');
         If DTR='Y' then Mriteln('Yell "Sanctar"!!');
         If DTR='N' then COUNTX:=COUNTX-1;
         If DTR='S' then COUNTX:=COUNTX+1;
         If DTR='W' then COUNTY:=COUNTY-1;
         If DTR='E' then COUNTY:=COUNTY+1;
        If PYRA=False then Begin
         C_MONSTER:=DRANDOM mod 4+1;
         If DRANDOM mod 8+1=2 then Begin
           EM_SEND((600+C_MONSTER)-1);
           EM_SEND(303);
           COMBAT(4,OVER,OVER);
           EM_SEND(302)
          End;
         End;
         If PYRA=True then Begin
           C_MONSTER:=32;
           If DRANDOM mod 16+1=10 then Begin
             EM_SEND((600+C_MONSTER)-1);
             EM_SEND(303);
             COMBAT(4,OVER,OVER);
             EM_SEND(302)
            End;
        End;
       End;
       End;
      Until (OVER=True) or (DTR='Y') or ((COUNTX=25) and (COUNTY=13));
     End;
     If OVER=False then Mriteln('');
     EM_SEND(300);
     If (OVER=False) and (PYRA=False) then Mriteln('Thou findest thyself outside the cave...');
     If (OVER=False) and (PYRA=True) then Mriteln('Thou dost exit the pyramid, and thy mind relaxes...');
     If OVER=False then STOP;
     If EMULATE then VT:=True
    End;
(***** The 2 Silver Pyramids in Silver Moon ~ FINAL solution to Quest! ****)
  Procedure PYRAMIDS(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      PYR:Str255;
      DOOBE:Boolean;
      IS:Integer;
    Begin
      EM_SEND(412);EM_SEND(699);EM_SEND(303);DOOBE:=False;
      If (VT=True) and (OVER=False) then Mrite(Chr(27));
      If (VT=True) and (OVER=False) then Mrite('E');
      Mriteln('');Mriteln('Thou art standing before two glistening silver pyramids, somehow');
      Mriteln('they just seem out of place in this realm, almost futuristic...');
      Mriteln('');Mrite('Enter then [S]outhern or [N]orthern pyramid? ');
      Repeat
        SOMETHING(PYR);
      Until (PYR='S') or (PYR='N');
      If PYR='S' then Mriteln('Southern...');
      If PYR='N' then Mriteln('Northern...');
      EM_SEND(300);
      Mriteln('');
      If (PYR='N') and (KEY=False) then Mriteln('Thou cannot find an entrance...');
      If (PYR='N') and (KEY=True) then Begin
        PYRA:=True;DOOBE:=True;
        CAVE(OVER,SUN);
        PYRA:=False;
       End;
      If PYR='S' then Begin
        Mriteln('Thou dost enter the tiny doorway...');
        Mriteln('');
        If USERI[NUM,29]>1 then Begin
          Mriteln('The Medallion of Wisdom flares into bright blue fire!!!!!');
          Mriteln('');Mriteln('Thou art unconcious...');
          STOP;
          Mriteln('');Mriteln('Thou wakest  beside  a  gentle  stream...  A wizard  in a shimmering blue');
          Mriteln('robe sees  thee...  His  voice  is  echoed  with  great  knowledge, "I am');
          Mriteln('Metar, one of the last of the Ancient Ones.  I know thy heart and desires,');
          Mriteln('might thou find what thou seeketh here..."');
          Mriteln('');
          Mriteln('He leads thee to the legendary village of Shady Brook!!');
          USERI[NUM,14]:=8;EM_SEND(8)
         End;
        If (USERI[NUM,29]=0) or (USERI[NUM,29]=1) then Begin
        Mriteln('A surge of electricity sears through thy body!!!!!!');
         Repeat
           IS:=DRANDOM mod 25+1
         Until (IS<>8) and (IS<>USERI[NUM,14]);
         USERI[NUM,14]:=IS;
         Mriteln('Thou hast been teleported!!!');EM_SEND(IS)
        End;
       End;
     If (OVER=False) and (DOOBE=False) then STOP;
    End;
(***** The WIZARD'S WORKSHOP ~ In the humble village of ShadyBrook ********)
  Procedure WORKSHOP(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      DEC,SAMT,SURE:Str255;
      AMT,PUN:Integer;
      GOLD:Long_Integer;
      JUSSO:Boolean;
    Begin
     JUSSO:=EMULATE;
     Repeat
       If (VT=True) and (OVER=False) then Mrite(Chr(27));
       If (VT=True) and (OVER=False) then Mrite('E');
       If OVER=False then MAKESURE(NUM,SUN,OVER);
       If (OVER=False) and (USERI[NUM,29]<>1) then Begin
         Mriteln('');Mrite ('         Thou art at -=* ');
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('b1');
         Mrite('The Wizard''s Workshop');
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('b3');
         Mriteln(' *=-.');
         Mriteln('');
         Mriteln('The wizard seems surprised, "It''s about time thou got here!!"');
         Mriteln('');
         Mriteln('Here''s all I''ve got left:');
         Mriteln('');
         Mriteln('[E]nchanted Potions . . . . . . . . . . 750 gps each');
         If WATERS=False then Mriteln('[V]ial of Waters! . . . . . . . . . . . 10,000 gps');
         Mriteln('[M]agic Crystals! . . . . . . . . . . . 7,000 gps each');
         If USERI[NUM,34]=0 then Mriteln('[A]mulet of Insight . . . . . . . . . . 5,000 gps');
         Mriteln('');
         Mriteln('[L]eave the workshop...');
         Mriteln('');
         Mrite('The wizard reminds thee, what thou breaketh, thou buyest!: ');
         Repeat
           SOMETHING(DEC)
         Until (DEC='E') or ((DEC='V') and (WATERS=False)) or (DEC='M') or ((DEC='A') and (USERI[NUM,34]=0)) or (DEC='L');
         Mriteln(DEC);
         If DEC='A' then Begin
           Mriteln('');Mriteln('The Wizard says, "I don''t know what thou would do with it..."');
           Mriteln('');Mrite('It would be 5,000 gps, buy it? ');
           WHAT(SURE);Mriteln('');
           If (SURE='Y') and (USERI[NUM,4]<=5000) then Mriteln('Not enough Gold!!!');
           If (SURE='Y') and (USERI[NUM,4]>5000) then Begin
             Mriteln('He gives thee an amulet with a cross on it...');
             USERI[NUM,4]:=USERI[NUM,4]-5000;
             USERI[NUM,34]:=1
            End
           End;
         If DEC='V' then Begin
           Mriteln('');Mriteln('The Wizard says, "Ahh...  Infinite waters to quench thy thirst!!"');
           Mriteln('');Mrite('I could not part with it for less than 10,000 gps, buy it? ');
           WHAT(SURE);Mriteln('');
           If (SURE='Y') and (USERI[NUM,4]<=10000) then Mriteln('Not enough Gold!!!');
           If (SURE='Y') and (USERI[NUM,4]>10000) then Begin
             Mriteln('He gives thee an odd looking vial...');
             USERI[NUM,4]:=USERI[NUM,4]-10000;
             WATERS:=True
            End
           End;
         If DEC='M' then Begin
          Repeat
           Mriteln('');Mriteln
       ('The Wizard says, "Powerful items!  One may not carry more than 20 for long..."');
           Mriteln('');Mrite('Buy how many Crystals? (max 4): ');
           Meadln(SAMT);
           BUGPROOF(SAMT,AMT);
          Until (AMT>0) and (AMT<5);
          GOLD:=AMT*7000;
          Mrite('That would be ');
          Send_Num(GOLD);Mrite(' gps, want them? ');
          WHAT(SURE);
          Mriteln('');
          If (SURE='Y') and (USERI[NUM,4]<=GOLD) then Mriteln('Thou hast not the Gold!!');
          If (SURE='Y') and (USERI[NUM,4]>GOLD) then Begin
            Mriteln('He takes thy gold...  So be it!');
            USERI[NUM,4]:=USERI[NUM,4]-GOLD;
            USERI[NUM,37]:=USERI[NUM,37]+AMT
           End
         End;
         If DEC='E' then Begin
          Repeat
           Mriteln('');Mrite('How many would thou like at 750 gps each? (40 max): ');
           Meadln(SAMT);
           BUGPROOF(SAMT,AMT);
          Until (AMT>0) and (AMT<41);
          GOLD:=AMT*750;
          Mriteln('');Mrite('That would be ');
          Send_Num(GOLD);Mrite(' gps, want them? ');
          WHAT(SURE);
          Mriteln('');
          If (SURE='Y') and (USERI[NUM,4]<=GOLD) then Mriteln('Thou hast not the Gold!!');
          If (SURE='Y') and (USERI[NUM,4]>GOLD) then Begin
            Mriteln('Very Well!!!!');
            USERI[NUM,4]:=USERI[NUM,4]-GOLD;
            MULT:=True;EMULATE:=False;WIZPOT:=True;
            For PUN:=1 to AMT do POTION;
            EMULATE:=JUSSO;
            MULT:=False;WIZPOT:=False;
           End
         End;
       End;
       If DEC='L' then Mriteln('');
       If (DEC='L') and (OVER=False) then Mriteln('Thou leavest the Wizard''s Workshop...');
       If OVER=False then STOP
     Until (DEC='L') or (OVER=True);
   End;
(***** The GraveYard in Durnin ~~ Zolar Lurks in a grave! *****************)
  Procedure GRAVEYARD(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      GRAVE,BODY:Integer;
      DEC,SURE:Str255;
    Begin
      EM_SEND(421);EM_SEND(301);
       If USERI[NUM,29]=1 then Begin
         C_MONSTER:=41;
         EM_SEND((600+C_MONSTER)-1);
         EM_SEND(303);
         COMBAT(1,OVER,False);
         STOP
        End;
      Repeat
       If (VT=True) and (OVER=False) then Mrite(Chr(27));
       If (VT=True) and (OVER=False) then Mrite('E');
       If OVER=False then MAKESURE(NUM,SUN,OVER);
       If (OVER=False) and (USERI[NUM,29]<>1) then Begin
         Mriteln('');Mrite ('             Thou art at -=* ');
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('b1');
         Mrite('The Durnin Graveyard');
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('b3');
         Mriteln(' *=-.');
         Mriteln('');
         Mriteln('    A low mist covers the ground, eerie shadows move through the');
         Mriteln('knotted trees.  A hint of evil lurks in the air, a raven watches');
         Mriteln('thy every move from an oak tree...');
         Mriteln('');
         Mriteln('[E]xamine the grave stones.');
         Mriteln('[L]eave the grave yard.');
         Mriteln('');
         Mrite('Thou hearest pounding underground: ');
         Repeat
           SOMETHING(DEC);
         Until (DEC='E') or (DEC='L');
         If DEC='E' then Mriteln('Examine...');
         If DEC='L' then Mriteln('Leave...');
         If DEC='E' then Begin
           GRAVE:=DRANDOM mod 12+1;
           If (USERI[NUM,29]<>0) and (GRAVE=2) then GRAVE:=3;
           Case GRAVE of
             1:DEC:='the figure of an Ankh';
             2:DEC:='strange runes etched on it';
             3:DEC:='crumbling edges';
             4:DEC:='thick dust on it';
             5:DEC:='the symbol of a moon';
             6:DEC:='a picture of a ship'
            End; {Case}
           If GRAVE>=7 then DEC:='a name written on it';
           Mriteln('');
           Mrite('Thou hast found a grave stone with ');
           Mrite(DEC);
           Mrite('.  Dig it up? ');
           WHAT(SURE);Mriteln('');
           If SURE='Y' then Begin
             If USERI[NUM,6]<7 then Mriteln('Thou dost not have enough time...');
             If USERI[NUM,6]<7 then STOP
             Else Begin
               Mriteln('It took thee 7 hours.  Thou dost open the wooden coffin...');
               USERI[NUM,6]:=USERI[NUM,6]-7;
               STOP;Mriteln('');
               If GRAVE>=7 then Begin
                 Mrite('The coffin contains the bones of a ');
                 BODY:=DRANDOM mod 15+1;
                 If BODY<5 then BODY:=5;
                 Mrite(MONSTER[BODY]);
                 Mriteln('...')
                End;
               If GRAVE=6 then Mriteln('The skull of old pirate glares at thee with a morbid stare...');
               If GRAVE=5 then Begin
                 Mriteln('Thou has found a gold ring on a skeleton''s finger.  It is worth 750 gps!');
                 USERI[NUM,4]:=USERI[NUM,4]+750
                End;
               If GRAVE=4 then Mriteln('The coffin is empty..');
               If GRAVE=3 then Begin
                 Mriteln('A skeleton leaps from the coffin!!!!!!!!');
                 If EMULATE then STOP;
                 C_MONSTER:=4;
                 EM_SEND((600+C_MONSTER)-1);
                 EM_SEND(303);
                 COMBAT(1,OVER,False)
                End;
               If GRAVE=2 then Begin
                 EM_SEND(107);
                 Mriteln('There is a flash of lightning, thunder echoes through the  sky.');
                 Mriteln('Zolar, the evil magi of old, breaks into laughter as  he climbs');
                 Mriteln('out of the coffin.  Mounds of flesh fall from his zombie  body.');
                 Mriteln('There is a flash of blue  from  the  medallion about  his neck!');
                 Mriteln('He laughs  hideously , "A  lowly  thief  frees  me!!!!!!!!  Now');
                 Mriteln('meet thy doom, fool!!!!!!!!!!!!!!"');
                 If EMULATE then STOP;
                 C_MONSTER:=41;USERI[NUM,29]:=1;
                 EM_SEND((600+C_MONSTER)-1);
                 EM_SEND(303);
                 COMBAT(1,OVER,False);
                 If USERI[NUM,29]=1 then DEC:='L'
                End;
               If GRAVE=1 then Begin
                 Mriteln('Thou hast found 1,000 gold pieces among bloodstained bones...');
                 USERI[NUM,4]:=USERI[NUM,4]+1000
                End;
            If OVER=False then STOP
           End;
          End;
         End;
        End;
       IF USERI[NUM,29]=1 then DEC:='L'
      Until (OVER=True) or (DEC='L');
     If OVER=False then Mriteln('');
     If OVER=False then Mriteln('Thou findest thy way back to town...');
     If OVER=False then STOP;EM_SEND(300);
    End;
(***** The ASSASSINS GUILD!!! -- In Fort Demise... ************************)
  Procedure ASSASINS(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      SURE:Str255;
      HLONG,GOLD,WHICH:Integer;
    Begin
       EM_SEND(413);EM_SEND(301);
       If VT=True then Mrite(Chr(27));
       If VT=True then Mrite('E');
       MAKESURE(NUM,SUN,OVER);
       If OVER=False then Begin
          Mriteln('');Mrite ('                Thou art at -=* ');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b1');
          Mrite('The Assassins'' Guild');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b3');
          Mriteln(' *=-.');
          Mriteln('');
          Mriteln('  An ugly assassin approaches thee, "We charge 5,000 gps to send a team');
          Mriteln('out to kill thy foe.  It will take them 14 days to  reach  thine  enemy.');
          Mriteln('We charge an additional 1,000 gps for every day sooner than 14..."');
          Mriteln('');
          Mrite('Dost thou desire our services? ');
          WHAT(SURE);Mriteln('');
          If SURE='N' then Mriteln('Then begone fool, lest we kill thee!!!!!!!');
          If SURE='Y' then Begin
            Mriteln('He says, "Very well!"');
           Repeat
            Mriteln('');Mrite('How many days until we reach thy foe? (14 max.): ');
            Meadln(SURE);
            BUGPROOF(SURE,HLONG)
           Until (HLONG>0) and (HLONG<15);
           Mriteln('');
           Mrite('He says, "For ');
           Send_Num(HLONG);
           Mrite(' day(s) that would be ');
           GOLD:=5000+((14-HLONG)*1000);
           Send_Num(GOLD);
           Mriteln(' gps."');
           Mrite('Dost thou agree? ');
           WHAT(SURE);
           If SURE='N' then Mriteln('Don''t waste my time, or thou wilt pay dearly!!');
           If SURE='Y' then Begin
             If USERI[NUM,4]<=GOLD then Mriteln('He yells, "Thou cannot afford it!!!!!!!!!!!"')
             Else Begin
               Mriteln('');
               Repeat
                 Mrite ('Assassinate who? [?=List] [Return Aborts]: ');
                 SURE:='';
                 ASK(NUM,WHICH,0,True);
                 If WHICH > 0 then Begin
                  Mrite (USERS[WHICH,3]);
                  Mrite(' [Y/N] ');
                  WHAT(SURE)
                 End;
               Until (SURE='Y') or (WHICH=-1);Mriteln('');
               If (WHICH>0) and (SURE='Y') then Begin
                 If USERI[WHICH,25]>0 then Mriteln('He says, "We are already after that theif."')
                 Else Begin
                   If USERI[WHICH,21]<50 then
                     Mriteln('That thief would be too easy to kill.  It''s against guild ethics.')
                  Else Begin
                   USERI[NUM,4]:=USERI[NUM,4]-GOLD;
                   USERI[WHICH,25]:=(HLONG*100)+NUM;
                   Mriteln('He says, "It shall be done...  Assassins have been sent!"');
                  End;
                End;
               End;
            End;
          End;
        End;
      End;
     STOP
    End;
(***** TEMPLES - In Airion, Pineville, and Balor **************************)
  Procedure TEMPLE(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      GOLD:Integer;
      SURE:Str255;
    Begin
        If CHEAT1<>47 then HALT;
        MAKESURE(NUM,SUN,OVER);
        If OVER=False then Begin
             If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('E');
            Mriteln('');
            If USERI[NUM,14]=5 then Begin
              BOOGIE:=True;EM_SEND(414);EM_SEND(301);
              Mriteln('               Thou dost enter the Temple of Balor.');
              Mriteln('');
              Mriteln('     A Statue of Balor, the Wretched God of Evil, towers above thee.');
              Mriteln('The air is heavy, dense with Evil.  The single  eye of Balor glares');
              Mriteln('upon thee.  The High Priest approches thee, his soul as dark as his');
              Mriteln('robes.')
             End;
            If USERI[NUM,14]=11 then Begin
              BOOGIE:=True;EM_SEND(415);EM_SEND(301);
              Mriteln('               Thou dost enter the Temple of Cathra.');
              Mriteln('');
              Mriteln('     A brilliant Ankh Hovers before thee, surrounded by pale light.');
              Mriteln('Thy soul attunes itself with  the high vibrations  of light.  Soon,');
              Mriteln('the High Priest approaches thee.')
             End;
            If USERI[NUM,14]=21 then Begin
              BOOGIE:=True;EM_SEND(416);EM_SEND(301);
              Mriteln('                 Thou dost enter the Temple of Solnar.');
              Mriteln('');
              Mriteln('     Thousands of small rainbows  dance upon  the crystal  walls.  The');
              Mriteln('Crystal chimes emit a music that is absorbed by thy soul.  Thy spirits');
              Mriteln('are lifted into the highest spheres.  A Priest in  the purest of white');
              Mriteln('robes approaches thee.')
             End;
            If USERI[NUM,19]=USERI[NUM,14] then Begin
              USERI[NUM,12]:=USERI[NUM,12]+2;
              USERI[NUM,6]:=USERI[NUM,6]-1;
              USERI[NUM,20]:=USERI[NUM,21];
              Mriteln('');
              Mrite('The Priest Greets thee, "Welcome back ');
              Mrite(USERS[NUM,3]);
              Mriteln('!!".');
              Mriteln('');
              Mriteln('Thou dost praise thy God for one hour.  Thy Life Force increases!')
             End;
            If (USERI[NUM,19]>0) and (USERI[NUM,19]<>USERI[NUM,14]) then Begin
              Mriteln('');Mriteln('Feelings of intense discomfort surround thee!!!');
              Mriteln('');
              Mriteln('The Priest Screams, "Depart thee hence, oh hideous soul!!! Or join');
              Mriteln('our pact!"')
             End;
            If USERI[NUM,19]<>USERI[NUM,14] then Begin
              Mriteln('');Mriteln('The Priest speaks to thy spirit, "Wilt thou join our cult?"');
              GOLD:=15000;If USERI[NUM,19]>0 then GOLD:=30000;
              Mrite('The Ceremonial fees are but ');
              Send_Num(GOLD);
              Mrite(' gold pieces.  Do it? ');
              WHAT(SURE);
              Mriteln('');
              If SURE='N' then Mriteln('The Priest yells, "Then thou Shalt Perish!!!!!!"');
              If SURE='N' then Mriteln('Thou findest thyself outside of the Temple!');
              If SURE='Y' then Begin
                If USERI[NUM,4]<=GOLD then 
              Mriteln('The Priest says, "Come back when thou hast the funds."')
              Else Begin
                USERI[NUM,4]:=USERI[NUM,4]-GOLD;
                USERI[NUM,19]:=USERI[NUM,14];
                Mriteln('He cheers, "So be it!!!  Let the Rites Begin!!!!!!!!!!!!!"');
                Mriteln('');
                Mriteln('The Baptism proceeds...');Mriteln('');
                If USERI[NUM,14]=5 then Begin
                  Mriteln('    The fire from the bottomless pit of the abyss bellows outward!');
                  Mriteln('The Thunderous roar of Balor Laughs, "Thy Soul is scarred by my name!"')
                 End;
                If USERI[NUM,14]=11 then Begin
                  Mriteln('    Thy Soul is united with the power of Cathra, a flame burns');
                  Mriteln('in thy heart like never before.')
                 End;
                If USERI[NUM,14]=21 then Begin
                  Mriteln('    Thy mind shimmers with with the powers of Law & Order!');
                  Mriteln('Solnar whispers to thy soul, "Evil is thine only enemy."')
                 End;
                Mriteln('');Mriteln('Our Guild wizards will gladly work powerful magic for thee!');
               End
              End
            End
           End;
         STOP
        End;
(***** KIDNAP PRINCESS MOONSHADE IN ZENON *********************************)
  Procedure MOONSHADE(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      SURE:Str255;
      RANDOM:Integer;
    Begin
       EM_SEND(430);EM_SEND(699);EM_SEND(303);If EMULATE then VT:=False;
       If VT=True then Mrite(Chr(27));
       If VT=True then Mrite('E');
       MAKESURE(NUM,SUN,OVER);
       If OVER=False then Begin
        Mriteln('');If not EMULATE then Mrite('            ');Mrite('-=* ');
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('b1');
        Mrite('Thou art at Moonshade''s Quarters ');
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('b3');
        Mriteln('*=-');
         Mriteln('');
         Mriteln('Thou climbest the winding staircases, and explore the various rooms.');
         Mrite('Thou hast found Princess Moonshade!!  Try to Kidnap her? ');
         WHAT(SURE);
         If SURE='Y' then Begin
           Mriteln('');Mrite('Press [RETURN] to kidnap Princess Moonshade!!');
           QSTOP;Mriteln('');
           RANDOM:=DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+25)+1;
            If RANDOM<USERI[NUM,3]+25 then Begin
              Mriteln ('Successful!! Thou hast Kidnapped Moonshade!!!!');
              Mriteln ('When thou asketh about the key, she refuses to answer.');
              USERI[NUM,32]:=1;
              USERI[NUM,5]:=USERI[NUM,5]+7000;
             End;
            If RANDOM>USERI[NUM,3]+25 then Begin
              Mriteln ('She Screams!!!  The Guards catch thee!!!');
              UJAILL:=True;
              JAIL(NUM,OVER);
              UJAILL:=False
             End;
         End;
        End;
        If OVER=False then Begin
          Mriteln('');Mriteln('Thou leavest the Fortress...');
          STOP;EM_SEND(300)
         End;
        If EMULATE then VT:=True
       End;
(***** --==** THE THIEVES' GUILD **==-- ***********************************)
  Procedure THE_GUILD(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      KIND,CURR,HIT,COUNT:Integer;
      CHOICE,DARTS:Str255;
      TRAIN,SEP:Long_Integer;
    Begin
      Mriteln('');
      Mriteln('Thou followest the winding  path into the Northern Mountains.');
      Mriteln('Finally thou arriveth at the Guild, Smoke billows out of the');
      Mriteln('chimney, dense aspen forests surround the area.');
      If USERI[NUM,16]=0 then Begin
        Mriteln('');Mriteln('It took thee 1 hour to walk.');
        USERI[NUM,6]:=USERI[NUM,6]-1
       End;
      STOP;
      BOOGIE:=True;EM_SEND(401);EM_SEND(301);
      Repeat
       If VT=True then Mrite(Chr(27));
       If VT=True then Mrite('E');
       MAKESURE(NUM,SUN,OVER);
       If OVER=False then Begin
       Repeat
        KIND:=0;HIT:=0;
          Mriteln('');Mrite ('Thou art at -=* ');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b1');
          Mrite('The Thieves'' Guild');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b3');
          Mriteln(' *=-.');
          Mriteln('');
          Mrite('Greetings ');Mrite(USERS[NUM,3]);Mriteln('!');
          Mriteln('');Mriteln('Why hast thou come?');
          Mriteln('');
          Mriteln(' [0]  Change thy steal message.');
          Mriteln(' [1]  Level Advancement!');
          Mriteln(' [2]  Training!');
          Mriteln(' [3]  Buy some Poison Darts!');
          Mriteln('');Mriteln(' [4]  Leave the guild.');
          Mriteln('');
          Mrite('Shadowy thieves glare at thee: ');
          Meadln(CHOICE);UPCASE(CHOICE)
        Until ((CHOICE>'0') and (CHOICE<'5')) or (CHOICE='MYTHYN') or (CHOICE='0');
     If CHOICE='MYTHYN' then Begin
       Mriteln('');Mriteln('The master theif says, "Yea, we''ve got a shortcut to Mythyn but it''s not free."');
       Mriteln('');Mrite('It would cost 4,000 gold, do it? ');
       WHAT(CHOICE);Mriteln('');
       If (CHOICE='Y') and (USERI[NUM,4]<=4000) then Mriteln('Not enough gold.');
       If (CHOICE='Y') and (USERI[NUM,4]>4000) then Begin
         Mriteln('The path takes 12 hours...');Mriteln('');
         If USERI[NUM,6]<12 then Mriteln('Thou dost not have enough time!')
         Else Begin
          USERI[NUM,4]:=USERI[NUM,4]-4000;USERI[NUM,6]:=USERI[NUM,6]-12;USERI[NUM,14]:=7;
          Mriteln('The guildmaster  opens  a trap door, thou walkest down the steps...');
          Mriteln('Thou findest  thyself  in a wine cellar, thine eyes adjust  to  the');
          Mriteln('darkness and thou  dost follow a moist underground tunnel...  After');
          Mriteln('12 hours thou dost step into the sunlight, in the town of Mythyn!');
          CHOICE:='4';EM_SEND(7);STOP
        End;
       End;
      End;
     If CHOICE='0' then CHSTMSG;
     If CHOICE='1' then Begin
      Mriteln('');
      Mriteln('The Guild Masters examine thee and whisper amongst themselves...');
      CURR:=USERI[NUM,22];Mriteln('');
      If (USERI[NUM,3]<105) and (USERI[NUM,3]>84) and (CURR<1) then KIND:=1;
      If (USERI[NUM,3]<125) and (USERI[NUM,3]>104) and (CURR<2) then KIND:=2;
      If (USERI[NUM,3]<145) and (USERI[NUM,3]>124) and (CURR<3) then KIND:=3;
      If (USERI[NUM,3]<165) and (USERI[NUM,3]>144) and (CURR<4) then KIND:=4;
      If (USERI[NUM,3]<185) and (USERI[NUM,3]>164) and (CURR<5) then KIND:=5;
      If (USERI[NUM,3]<205) and (USERI[NUM,3]>184) and (CURR<6) then KIND:=6;
      If (USERI[NUM,3]<225) and (USERI[NUM,3]>204) and (CURR<7) then KIND:=7;
      If (USERI[NUM,3]<265) and (USERI[NUM,3]>224) and (CURR<8) then KIND:=8;
      If (USERI[NUM,3]<305) and (USERI[NUM,3]>264) and (CURR<9) then KIND:=9;
      If (USERI[NUM,3]<345) and (USERI[NUM,3]>304) and (CURR<10) then KIND:=10;
      If (USERI[NUM,3]<385) and (USERI[NUM,3]>344) and (CURR<11) then KIND:=11; 
      If (USERI[NUM,3]<455) and (USERI[NUM,3]>384) and (CURR<12) then KIND:=12;
      If (USERI[NUM,3]>455) and (CURR<13) then KIND:=13;
      If KIND=0 then Mriteln
       ('They tell thee, "Thou hast not gained in thy Experience, come back later."');
      If KIND>0 then Begin
        HIT:=KIND-USERI[NUM,22];
        HIT:=HIT*10;
        HIT:=DRANDOM mod HIT+1;
        Mriteln('Congratulations!!  Thou hast Gained in experience since thy last visit!');
        Mriteln('');
        Mriteln('The Master says, "Here ist thy new weapon & armour!"');
        Mrite('He hands thee a ');
        USERI[NUM,22]:=KIND;USERI[NUM,23]:=0;
        AWVIEW(1,NUM);Mrite(', and ');AWVIEW(2,NUM);Mriteln(' Armour!');
        Mriteln('');
        Mrite('Thou hast gained ');Send_Num(HIT);Mriteln(' Hit point(s)!!');
        USERI[NUM,21]:=USERI[NUM,21]+HIT;
        USERI[NUM,20]:=USERI[NUM,21]
        End;
        STOP
       End;
       If CHOICE='2' then Begin
         Mriteln('');Mrite('The training sessions last 5 hours, participate? ');
         WHAT(CHOICE);
         Mriteln('');
         If CHOICE='N' then Mriteln('Next time, perhaps...');
         If CHOICE='Y' then Begin
           If USERI[NUM,6]<5 then Mriteln('Thou dost not have enough time...')
           Else Begin
             TWIN;Mrite('Fellow thieves share their secrets of pilferage with thee for 5 hours');
             COUNT:=0;TRAIN:=CLOCK;
             Repeat
              SEP:=CLOCK-TRAIN;
              If SEP=2 then Begin
                Mrite('.');
                TRAIN:=Clock;
                Count:=Count+1
               End
             Until COUNT=5;
             USERI[NUM,6]:=USERI[NUM,6]-5;
             Mriteln('');Mriteln('');
             Mrite('Thy knowledge increases by ');
             COUNT:=(DRANDOM mod 5)+1;
             USERI[NUM,3]:=USERI[NUM,3]+COUNT;
             Send_Num(COUNT);
             Mriteln(' Skill point(s).');
             Mriteln('');Mriteln('The Guildmasters wish thee luck!');
           STOP;
           End;
          End;
         End;
        If CHOICE='3' then Begin
          Mriteln('');Mriteln('A Guild Wizard meets thee, "Our Magical Poison Darts');
          Mriteln('will seek out thine enemy.  They are but 300 Gold each!"');
         Repeat
          Mriteln('');Mrite('Buy how many? (5 max.): ');
          Meadln(DARTS);
          BUGPROOF(DARTS,HIT);
         Until (HIT>-1) and (HIT<6);
        If HIT>0 then Begin
         Mrite('That would be ');
         HIT:=HIT*300;
         Send_Num(HIT);
         Mrite(' Gold pieces, want them? ');
         WHAT(CHOICE);
         Mriteln('');
         If CHOICE='Y' then Begin
           If USERI[NUM,4]<=HIT then Mriteln('Not enough Gold.')
           Else Begin
             Mriteln('The wizard takes thy gold, and dissapears into the darkness...');
             USERI[NUM,4]:=USERI[NUM,4]-HIT;
             USERI[NUM,28]:=USERI[NUM,28]+(HIT div 300)
            End;
          End;
         STOP;
        End;
       End;
      End;
      If (VT=True) and (OVER=False) then Mrite(Chr(27));
      If (VT=True) and (OVER=False) then Mrite('E');
     Until (CHOICE='4') or (OVER=True);
    If OVER=False then Begin
    Mriteln('');
    If USERI[NUM,16]=0 then Begin
     Mriteln('It took thee an hour to walk back into town.');
     USERI[NUM,6]:=USERI[NUM,6]-1
    End
   Else If USERI[NUM,14]=1 then Mriteln('Thou ridest back to town...');
    STOP;
   End;
    End;
(***** THE STABLE - In Jarsoloth & Morgai *********************************)
  Procedure STABLE(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      GOLD,HP:Integer;
      OUT:Boolean;
      GOLDS,HORSETYPE,NAME,KIND:Str255;
    Begin
      EM_SEND(409);EM_SEND(301);
      Repeat
        MAKESURE(NUM,SUN,OVER);
        OUT:=False;
        If OVER=False then Begin
         Repeat
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('E');
            ABLE:=True;
            Mriteln('');Mrite ('Thou art at the ');
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('b1');
            Mrite(TOWNS[USERI[NUM,14],1]);
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('b3');
            Mriteln(' Stable.');
            Mriteln('');Mriteln ('A tall man in dirty clothing approaches thee...');
            Mriteln ('He says, "Greetings Stranger, We have a wide variety of fine Steeds!"');
            Mriteln('');Mriteln ('What colour dost thou prefer? ');
            Mriteln('');Mriteln ('1 - Midnight Black.');
            Mriteln ('2 - Pure White.');
            Mriteln ('3 - Dapple Gray.');
            Mriteln ('4 - Dark Chestnut.');
            Mriteln('');Mriteln ('5 - Leave the Stable.');
            Mriteln('6 - Sell thy Horse.');
            ABLE:=False;SOFF:=False;
            Mriteln('');Mrite ('The smell of Hay fills the air: ');
            Meadln (GOLDS);
            If GOLDS='5' then OUT:=True;
          Until (GOLDS>'0') and (GOLDS<'7');
          If GOLDS='1' then HORSETYPE:='Black ';
          If GOLDS='2' then HORSETYPE:='White ';
          If GOLDS='3' then HORSETYPE:='Gray ';
          If GOLDS='4' then HORSETYPE:='Brown ';
         If (GOLDS<>'5') and (GOLDS<>'6') then Begin
          Mriteln('');Mrite ('Would''st thou like a horse for [W]ar, or [T]raveling? ');
          Repeat
            SOMETHING(GOLDS);
            If GOLDS='W' then Mriteln ('War!!!');
            If GOLDS='T' then Mriteln ('Travel...');
          Until (GOLDS='W') or (GOLDS='T');
          If GOLDS='W' then INSERT('Warhorse',HORSETYPE,(ord(HORSETYPE[0])+1));
          If GOLDS='T' then INSERT('Riding Horse',HORSETYPE,(ord(HORSETYPE[0])+1));
          Mriteln('');Mrite('The Stableman brings out a fine, long-haired, ');
          Mriteln(HORSETYPE);
          If GOLDS='W' then HP:=20;
          If GOLDS='T' then HP:=10;
          HP:=HP+(DRANDOM mod 5);
          Mrite ('with ');
          Send_Num(HP);
          Mriteln(' Hit Points.  He says, "A finer Stallion thou shall not find!"');
          If GOLDS='W' then GOLD:=4000;
          If GOLDS='T' then GOLD:=2000;
          GOLD:=GOLD+(HP*10);
          Mriteln('');Mrite ('I ask of thee but ');
          Send_Num(GOLD);
          Mrite(' Gold!  Wilt thou Pay? ');
          WHAT(GOLDS);
          Mriteln('');
          If GOLDS='Y' then Begin
            If USERI[NUM,4]=GOLD then Mriteln ('That would leave thee Broke!');
            If USERI[NUM,4]<GOLD then Mriteln ('Come back when thou hast sufficient Funds...');
            If USERI[NUM,4]>GOLD then Begin
              Mriteln ('"So it Is!!!", He exclaims, taking thy gold...');
              Repeat
               GOLDS:='';
               Mriteln('');Mrite ('By what name shall thy new friend be known? ');
               Meadln (NAME);
               If ord(NAME[0])>20 then Mriteln ('20 Char. Maximum Please...');
               If ord(NAME[0])<4 then Mriteln ('4 Char. Minimum Please...');
               If (ord(NAME[0])<21) and (ord(NAME[0])>3) then Begin
                 Mrite(NAME);
                 Mrite(', Correct? ');
                 WHAT(GOLDS)
                End;
              Until (ord(NAME[0])<21) and (ord(NAME[0])>3) and (GOLDS='Y');
            ESTUFF(1,NUM,NAME,48);
            USERI[NUM,4]:=USERI[NUM,4]-GOLD;
            USERI[NUM,16]:=HP;
            USERS[NUM,9]:=NAME;USERS[NUM,8]:=HORSETYPE
           End;
          End;
         End;
        If GOLDS='6' then Begin
          Mriteln('');
          If USERI[NUM,16]<1 then Mriteln ('Thou dost not have a Horse!');
          If USERI[NUM,16]>0 then Begin
            GOLD:=USERI[NUM,16]*100;
            Mrite ('I will give thee ');
            Send_Num(GOLD);
            Mrite(' Gold Pieces, Deal? ');
            WHAT(GOLDS);
            If GOLDS='Y' then Begin
              Mrite ('Very Well! Here''s thy ');
              Send_Num(GOLD);
              Mriteln(' Gold Pieces...');
              USERI[NUM,4]:=USERI[NUM,4]+GOLD;
              USERS[NUM,8]:='NONE';USERS[NUM,9]:='NONE';USERI[NUM,16]:=0;
             End;
           End;
          End;
        If OUT=True then  Mriteln('');
        If OUT=True then Mriteln ('He says, "Please come again soon!"');
        If OVER=False then STOP
       End
      Until (OVER=True) or (OUT=True)
     End;
(***** THE GYPSY'S QUARTERS IN SENARIA ************************************)
  Procedure GYPSY(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      SURE:Str255;
    Begin
      EM_SEND(424);EM_SEND(301);
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      MAKESURE(NUM,SUN,OVER);
      If OVER=False then Begin
        Mriteln('');Mrite('            -=* ');
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('b1');
        Mrite('Thou art at the Gypsy''s Quarters ');
        If VT=True then Mrite(Chr(27));
        If VT=True then Mrite('b3');
        Mriteln('*=-');
        Mriteln('');
        Mriteln('   The air is dense  with  smoke, candles  dimly  illuminate  the');
        Mriteln('area.  An  old,  mysterious  Gypsy  approaches thee...  Greetings');
        Mriteln('oh lost one, for 200 Gold Pieces, I will gaze into thy future...');
        Mriteln('');
        Mrite('Her green eyes sparkle in the candle-light.  Agree? ');
        WHAT(SURE);Mriteln('');
        If SURE='Y' then Begin
          If USERI[NUM,4]<=200 then Mriteln('Thou hast not enough gold...')
          Else Begin
            If USERI[NUM,26]>5 then Mriteln('I see pain in thine eyes...');
            If USERI[NUM,25]>0 then Mriteln('I see one who seeks thy life!!');
            If (USERI[NUM,26]<6) and (USERI[NUM,25]=0) then Mriteln
              ('I see thee surrounded by pale light...');
            Mriteln('');Mriteln('She takes 200 Gold Pieces...');
            USERI[NUM,4]:=USERI[NUM,4]-200
           End;
         End;
        If SURE='Y' then Mriteln('');
        If USERI[NUM,34]=0 then Mriteln
         ('Bring to me the Amulet of Insight!!  It shall be worth thy time!')
        Else Begin
          If (USERI[NUM,34]=1) or (USERI[NUM,34]=2) then Begin
            Mriteln('I see thou hast the Amulet of Insight!!  Give it to me!!');
            Mrite('Do it? ');
            WHAT(SURE);
            If SURE='Y' then Begin
              Mriteln('');Mriteln('Thou givest the amulet to the Gypsy...');
              Mriteln('');Mriteln('"Take this, it will help thee in thy quest!"');
              Mriteln('');Mriteln
               ('She gives thee a small whistle of a Gremlin with a wicked grin...');
              USERI[NUM,34]:=3
             End;
          End;
         End;
         STOP
        End;
      End;
(***** THE COLOSSEUM ~ At Evil Shore ~ Horse HPs & Armour *****************)
  Procedure COLOSSEUM(Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      PRICE,ISEL:Integer;
      SEL,ASEL,CSEL:Str255;
    Begin
      EM_SEND(429);EM_SEND(301);
      Mriteln('');
      If USERI[NUM,19]=5 then Mriteln('A man says, "Welcome to the Colosseum, brother!"')
      Else Begin
        Mrite('A balorian says, "Get lost ');
        If USERI[NUM,19]=11 then Mrite('catharian ');
        If USERI[NUM,19]=21 then Mrite('solnarian ');
        Mriteln('scum!!!!"');
       End;
       If USERI[NUM,16]<1 then Mriteln('');
       If USERI[NUM,16]<1 then Mriteln('Begone fool!  Thou hast no horse!!!');
      STOP;
      Repeat
        MAKESURE(NUM,SUN,OVER);
        If (OVER=False) and (USERI[NUM,16]>0) then Begin
         Repeat
           If VT=True then Mrite(Chr(27));
           If VT=True then Mrite('E');
           Mriteln('');Mriteln('Thou art at Evil Shore''s Colosseum!');
           Mriteln('');
           Mriteln('Why art thou here?');
           Mriteln('');
           Mriteln('[1] Buy thy horse barding...');
           Mriteln('[2] Train thy horse...');
           Mriteln('');
           Mriteln('[3] Leave...');
           Mriteln('');
           Mrite('Thy Selection: ');
           Meadln(SEL)
          Until (SEL='1') or (SEL='2') or (SEL='3');
       If SEL='2' then Begin
         Mriteln('');
         Mrite('A training session will last 4 hours, for 1000 Gold Pieces.  Do it? ');
         WHAT(ASEL);
         If ASEL='Y' then Begin
          Mriteln('');
          If USERI[NUM,6]<4 then Mriteln('Thou dost not have enough time left in this realm!')
          Else Begin
           If USERI[NUM,4]<=1000 then Mriteln('The trainer yells, "Thou dost not have enough gold!!"')
          Else Begin
            USERI[NUM,4]:=USERI[NUM,4]-1000;
            USERI[NUM,6]:=USERI[NUM,6]-4;
            USERI[NUM,16]:=USERI[NUM,16]+1;
            Mriteln('Thy horse trains for 4 hours...');
            Mriteln('');
            Mriteln('Thy horse gained 1 hit point, it''s speed increases!');
           End;
          End;
         End;
         STOP
        End;
       If SEL='1' then Begin
        Repeat
         Mriteln('');Mriteln('We have the following barding:');
         Mriteln('');Mriteln('[1]  Leather    --  2000 G.P.');
         Mriteln('[2]  Banded     --  4000 G.P.');
         Mriteln('[3]  Ring Mail  --  6000 G.P.');
         Mriteln('[4]  Scale Mail --  8000 G.P.');
         Mriteln('[5]  Chain Mail -- 10000 G.P.');
         Mriteln('[6]  Crystal    -- 12000 G.P.');
         Mriteln('[7]  Crystal +1 -- 14000 G.P.');
         Mriteln('[8]  Crystal +2 -- 16000 G.P.');
         Mriteln('');
         Mriteln('[9]  None.');
         Mriteln('');Mrite('Thy Selection? ');
         Meadln(CSEL);BUGPROOF(CSEL,ISEL);
        Until (ISEL>0) and (ISEL<10);
        If ISEL<>9 then Begin
          Mriteln('');Mrite('That would be ');
          Send_Num(ISEL*2000);Mrite(' gold pieces.  Want it? ');
          WHAT(ASEL);
          If ASEL='Y' then Begin
            If (ISEL*2000)>=USERI[NUM,4] then Mriteln('Not enough Gold!!')
            Else Begin
              Mriteln('');Mriteln('So it is...');
              USERI[NUM,4]:=USERI[NUM,4]-(ISEL*2000);
              USERI[NUM,24]:=ISEL
             End;
          End;
         End;
         STOP
        End;
      End;
     Until (OVER=True) or (SEL='3') or (USERI[NUM,16]<1);
    If OVER=False then Begin
      Mriteln('');Mriteln('Thou dost leave the colosseum...');
      STOP
     End;
   End;
(***** THE TORTURE CHAMBER IN BRYNTHIA - PRINCESS FOR KEY *****************)
  Procedure TORTURE;
    Begin
      EM_SEND(410);EM_SEND(301);
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      Mriteln('');Mrite('            -=* ');
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('b1');
      Mrite('Thou art at the Brynthia Torture Chamber ');
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('b3');
      Mriteln('*=-');
      Mriteln('');
      Mriteln('    Rusty devices of Torture lie strewn about the dusty room.');
      Mriteln('');
      If (USERI[NUM,32]=0) or (USERI[NUM,32]=2) then Mriteln
        ('There doesn''t seem to be anything special to do here...');
      If USERI[NUM,32]=1 then Begin
        Mriteln('The Princess screams, "Ok!!!  I will give thee the Key!!!  Take it!!"');
        Mriteln('She throws the key at thee and runs off into Mountains of Balor...');
        USERI[NUM,32]:=2
       End;
     STOP;
    End;
(***** SHIPS FOR SALE - FAT MERCHANT **************************************)
  Procedure SHIPS;
    Var
      PICK,PRICE,R:Integer;
      GOLD,PICKS:Str255;
    Begin
     EM_SEND(425);EM_SEND(301);
     R:=DRANDOM mod 21+1;
     Repeat
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      If (R<=10) then Mriteln ('A Fat Merchant approaches thee.');
      If (R<=20) and (R>10) then Mriteln ('An Ugly Merchant approaches thee.');
      If R=21 then Mriteln ('A Sly Merchant approaches thee.');
      ABLE:=True;
      Mriteln('');Mriteln ('He says, "And what might I interest thee in?"');
      Mriteln('');Mriteln ('     Type          Hull       Price');
      Mriteln ('     ----          ----       -----');
      Mrite (' [1] Raft           10        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*200);Mriteln('');
      Mrite (' [2] Canoe          20        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*400);Mriteln('');
      Mrite (' [3] Lifeboat       30        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*600);Mriteln('');
      Mrite (' [4] Sail Boat      40        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*800);Mriteln('');
      Mrite (' [5] Sail Ship, Sm. 50        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*1000);Mriteln('');
      Mrite (' [6] Longship       60        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*1200);Mriteln('');
      Mrite (' [7] Sail Ship, Lg. 70        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*1400);Mriteln('');
      Mrite (' [8] Galley         80        ');
      Send_Num(TOWNI[USERI[NUM,14],13]*1600);Mriteln('');
      Mriteln('');Mriteln (' [9] Nothing.');
      Mriteln (' [10] Sell what thou hast now.');
      If R=21 then Mriteln (' [11] Buy a Catapult. - 2,000 G.P.');
      ABLE:=False;SOFF:=False;
      Mriteln('');Mrite ('The Merchant waits patiently: ');
      Meadln(PICKS);
      BUGPROOF(PICKS,PICK);
     Until (PICK>0) and (PICK<12);
     Mriteln('');
     If PICK=9 then Mriteln ('"Perhaps some other time.", he walks off into the distance.');
     If (PICK<>9) and (PICK<10) then Begin
       PRICE:=(PICK*200)*TOWNI[USERI[NUM,14],13];
       If (USERI[NUM,4]=PRICE) and (USERI[NUM,8]=0) then Mriteln ('That would leave thee Broke!');
       If (USERI[NUM,4]<PRICE) and (USERI[NUM,8]=0) then Mriteln ('The Merchant says, "Thy Purse is too small..."');
       If USERI[NUM,8]>0 then Mrite ('But thou Already hast a ');
       If USERI[NUM,8]>0 then AWVIEW(3,USERI[NUM,8]);
       If USERI[NUM,8]>0 then  Mriteln('  Dost thou not wish to sell it first?');
       If (USERI[NUM,4]>PRICE) and (USERI[NUM,8]=0) then Begin
         Mrite ('Buy a ');
         AWVIEW(3,PICK);
         Mrite('.  Art thou sure? ');
         WHAT(GOLD);
         If GOLD='Y' then Begin
           Mriteln ('Thou payest the Merchant.  "Nice doing buisness with thee!", he exclaims.');
           USERI[NUM,4]:=USERI[NUM,4]-PRICE;
           USERI[NUM,8]:=PICK
         End
        End
       End;
     If PICK=10 then Begin
       Mriteln('');
       If USERI[NUM,8]=0 then Mriteln ('Thou dost not have anything to Sell!');
       If USERI[NUM,8]>0 then Begin
         PRICE:=(USERI[NUM,8]*100)*TOWNI[USERI[NUM,14],13];
         If USERI[NUM,8]>10 then PRICE:=PRICE+800;
         If MYSTIC then PRICE:=PRICE+3300;
         PRICE:=PRICE+(DRANDOM mod 100);
         Mrite ('He says, "I will give thee ');
         Send_Num(PRICE);
         Mrite(' G.P. for thy ');
         AWVIEW(3,USERI[NUM,8]);
         Mrite('."  Deal? ');
         WHAT(GOLD);
         Mriteln('');
         If GOLD='N' then Mriteln ('So it is...');
         If GOLD='Y' then Begin
           Mrite ('"Very Well!", he gives thee ');
           Send_Num(PRICE);
           Mriteln(' Gold Pieces.');
           USERI[NUM,4]:=USERI[NUM,4]+PRICE;
           USERI[NUM,8]:=0;MYSTIC:=False
          End
         End
        End;
     If (PICK=11) and (R=21) then Begin
       Mriteln('');
       If USERI[NUM,8]<4 then Mriteln ('The Merchant breaks into a strange, uncontrollable laugh.');
       If USERI[NUM,8]=0 then Mriteln ('"Thou dost not have a Ship!"');
       If (USERI[NUM,8]<4) and (USERI[NUM,8]>0) then Begin
         Mrite ('"A catapult, on a ');
         If USERI[NUM,8]=1 then Mrite ('Raft');
         If USERI[NUM,8]=2 then Mrite ('Canoe');
         If USERI[NUM,8]=3 then Mrite ('Lifeboat');
         Mriteln ('!?!?!"')
        End;
       If USERI[NUM,8]>10 then Mriteln ('Thou already havest one!!');
       If (USERI[NUM,8]>3) and (USERI[NUM,8]<10) then Begin
         If USERI[NUM,4]<2000 then Mriteln ('The Merchant says, "No Gold, Not Sold!"  He walks away laughing.');
         If USERI[NUM,4]=2000 then Mriteln ('That would leave thee Broke!');
         If USERI[NUM,4]>2000 then Begin
           Mriteln ('The Merchant gives thee brief instructions on how to use it and walks away.');
           USERI[NUM,4]:=USERI[NUM,4]-2000;
           USERI[NUM,8]:=USERI[NUM,8]+10
          End
         End
        End;
      STOP;
      Mriteln('')
    End;
(**************************************************************************)
  Procedure OCEAN(Var NUM:Integer;Var WIND:Integer;Var C:Str255);
    Var
      JUNK,SEL:Str255;
      GOLD,RAN:Integer;
    Begin
      If WIND>0 then Begin
        RAN:=DRANDOM Mod 3+1;
        If RAN=3 then WIND:=DRANDOM Mod 12+1
       End;
      If WIND=0 then WIND:=DRANDOM Mod 12+1;
     If OCE=False then EM_SEND(131);OCE:=True;EM_SEND(405);EM_SEND(301);
     Repeat
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      ABLE:=True;
      If GTT=True then Begin
        ESTUFF(1,NUM,C,41);
        Mriteln('');Mrite('Thou wakest on the shores of ');
        Mrite(TOWNS[USERI[NUM,14],1]);
        USERI[NUM,8]:=0;GTT:=False;MYSTIC:=False;
        Mriteln('!');
        STOP;
        Mriteln('')
       End;
      If (USERI[NUM,6]<18) and (USERI[NUM,6]>6) then Begin
        Mriteln ('The Moon glows mystically in the Star-scattered sky as');
        Mriteln ('thou walketh the deserted beach.')
       End;
      If (USERI[NUM,6]<3) or (USERI[NUM,6]>17) then Begin
        Mriteln ('The Sun shines bright overhead, warming the sand upon the Beach.  The White,');
        Mriteln ('Puffy clouds float across the sky.')
       End;
      If (USERI[NUM,6]<7) and (USERI[NUM,6]>2) then Begin
        Mriteln ('Dawn.  A seagull heralds the  Sun''s reappearance with');
        Mriteln ('a cry of ecstasy.  The Sun''s light is reflected over the');
        Mriteln ('Ocean...')
       End;
      Mriteln('');
      Mrite('Thou art at the ');
      Mrite(TOWNS[USERI[NUM,14],1]);
      Mriteln(' Harbor.');
      Mriteln('');
      Mriteln('What would''st thou like to do?');
      Mriteln('');
      Mriteln('   +=========================+');
      Mriteln('   | [1] Prepare to Sail!    |');
      Mriteln('   | [2] Talk to a Merchant. |');
      Mriteln('   | [3] Go back to town.    |');
      Mriteln('   +=========================+');
      ABLE:=False;SOFF:=False;
      Mriteln('');Mrite ('The Blue Waves crash upon the shore: ');
      Meadln(C);
      Mriteln('');
     Until (C='1') or (C='2') or (C='3')
    End;
(**************************************************************************)
  Procedure TRAVEL(Var NUM:Integer;Var WIND:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
      JUNK,JUNKS,TEMPS,CH,C:Str255;
      A,FH,G,GOT,DUMB,SAILORS,EXCEPT,SHA,WHI,STO,COUNT,PLAY1,
      PLAY2,ENC,WGOT,PIR,SEA,SQU,SHK:Integer;
      D,T:Array[1..3] of Integer;
      ENOUGH,CANON,TURN,DIDIT:Boolean;
      PRICE:Long_Integer;
    Begin
      CANON:=False;HALF:=True;DIDIT:=False;
      TEMPS:='  ';
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
     If USERI[NUM,14]<>8 then Begin
      Mriteln('');Mriteln ('By which method dost thou wish to Travel?');
      Mriteln('');Mriteln ('[L]and.');
      Mriteln ('[O]cean.');
      {If NUM=8 then Mriteln ('[I]nsta-Travel (CompuServe Demo Only)');}
      Mriteln('');Mriteln('[A]bort Journey.');
      Mriteln('');Mrite ('Thy Selection: ');
     Repeat
      SOMETHING(JUNK);
     Until (JUNK='L') or (JUNK='O') or (JUNK='A'){ or ((JUNK='I') and (NUM=8))};
    End;
    {If (JUNK='I') and (NUM=8) then Begin
        Mriteln('Insta-Travel!');
        Mriteln('');
        Mriteln(' [1] Arisilon [Thieves'' Guild]     [2] Jarsoloth [Stable]');
        Mriteln(' [3] Senaria [Gypsy''s Quarters]    [4] Brynthia [Torture Chamber]');
        Mriteln(' [5] Balor [Balorian Temple]       [6] Irata');
        Mriteln(' [7] Mythyn                        [8] Shady Brook [Wizard''s Workshop]');
        Mriteln(' [9] Castelon                     [10] Shiron [Cave of the Ancient Ones]');
        Mriteln('[11] Airion [Catharian Temple]    [12] Evil Shore [Colleseum]');
        Mriteln('[13] SilverMoon [Pyramids]        [14] Arnach');
        Mriteln('[15] Tirion                       [16] Erelas');
        Mriteln('[17] Morgai [Stable]              [18] Durnin [Graveyard]');
        Mriteln('[19] ShamnorWood                  [20] Zenon [The Fortress]');
        Mriteln('[21] PineVille [Temple of Solnar] [22] Zilar');
        Mriteln('[23] BlackWood                    [24] Glantria');
        Mriteln('[25] Fort Demise [Assassin''s Guild]');
       Repeat
        Mriteln('');Mrite('Zap yourself to which town? ');
        Meadln(CH);
        BUGPROOF(CH,FH);
       Until (FH>0) and (FH<26);
       Mriteln('');Mriteln('It is done!');EM_SEND(FH);
       STOP;
       USERI[NUM,14]:=FH;
        JUNK:='A';
      End;}
     If USERI[NUM,14]=8 then Begin
       Mriteln('');Mriteln('Thou findest thyself back in Silver Moon!');
       USERI[NUM,14]:=13;JUNK:='A';EM_SEND(13);
       STOP;
      End;
     If (JUNK='L') or (JUNK='O') then Begin
      If JUNK='L' then Mriteln ('Land...');
      If JUNK='O' then Mriteln ('Go to the Ocean...');
      Mriteln('');
      If JUNK='L' then A:=13;
      If JUNK='O' then A:=12;
      If (TOWNS[USERI[NUM,14],A]='0') and (A=12) then Mriteln
        ('This town is not by the Sea, there is no harbor!!');
      If (TOWNS[USERI[NUM,14],A]='0') and (A=12) then STOP
       Else Begin
      If A=12 then Begin
          If USERI[NUM,16]=0 then USERI[NUM,6]:=USERI[NUM,6]-1;
          If USERI[NUM,16]=0 then Mriteln ('Thou walkest to the Ocean, It took thee an Hour.')
          Else Mriteln ('Thou ridest to the Ocean on thy horse...');
          Mrite ('Thou can see ');
          Mrite(TOWNS[USERI[NUM,14],1]);
          Mriteln(' in the Misty Distance.');
          STOP;
          Mriteln('')
        End;
     Repeat
      If OVER=False then MAKESURE(NUM,SUN,OVER);
      If OVER=True then C:='3';
      If OVER=False then Begin
      C:='';
      ENOUGH:=True;
      If JUNK='L' then A:=13;
      If JUNK='O' then A:=12;
      If JUNK='O' then OCEAN(NUM,WIND,C);
      If C='2' then SHIPS;
      If (JUNK='O') and (USERI[NUM,8]=0) and (C<>'3') and (C<>'2') then Begin
        Mriteln ('Dost thou expect to swim!?  Talk to a Merchant!');
        STOP
       End;
      If (JUNK='O') and (USERI[NUM,8]=0) and (C<>'3') then Mriteln('');
      If (JUNK='O') and (USERI[NUM,8]=0) then A:=0;
      If (C='2') or (C='3') then A:=0;
      If A<>0 then Begin
      If (JUNK='L') or (JUNK='O') then Begin
       Repeat
        If (TOWNS[USERI[NUM,14],A]='0') and (A=13) then Mriteln
           ('Sorry, But no Townes are Available by Land...');
        If (TOWNS[USERI[NUM,14],A]='0') and (A=12) then Mriteln
           ('Sorry, But no Townes are Available by Ocean...');
        If (TOWNS[USERI[NUM,14],A]='0') then Begin
           JUNKS:='CANCEL';
           CH:='CANCEL';
           C:='3'
          End;
        If (TOWNS[USERI[NUM,14],A]<>'0') and (A=13) then Begin
          Mriteln('');
          Mriteln ('     *-=======--<<*>>--=======-*');
          Mriteln ('  *-= Townes Available by Land! =-*');
          Mriteln ('     *-///////////|\\\\\\\\\\\-*')
         End;
        If (TOWNS[USERI[NUM,14],A]<>'0') and (A=12) then Begin
          Mriteln('');
          Mriteln ('     */\/\/\/\/\/\/\/\/\/\/\/\*');
          Mriteln ('   *- Townes Available by Sea! -*');
          Mriteln ('     */\/\/\/\/\/\/\/\/\/\/\/\*');
          Mriteln('');
      Mrite ('    Wind/Weather Stats:  ');
      If WIND<=2 then Mriteln ('Becalmed.');
      If WIND=3 then Mriteln ('Extreme Light Breeze.');
      If WIND=4 then Mriteln ('Light Breeze.');
      If WIND=5 then Mriteln ('Moderate Breeze.');
      If (WIND>5) and (WIND<9) then Mriteln ('Normal Winds.');
      If WIND=9 then Mriteln ('Strong Breeze.');
      If WIND=10 then Mriteln ('High Winds.');
      If WIND=11 then Mriteln ('Extreme High Winds (Light Rain).');
      If WIND=12 then Mriteln ('Gale! (Dangerous).')
     End;
      T[1]:=0;T[2]:=0;T[3]:=0;D[1]:=0;D[2]:=0;D[3]:=0;
      Mriteln('');
         If TOWNS[USERI[NUM,14],A]<>'0' then Begin
            TEMPS[1]:=TOWNS[USERI[NUM,14],A][1];
            TEMPS[2]:=TOWNS[USERI[NUM,14],A][2];
            If TEMPS[1]='0' then TEMPS:=TEMPS[2];
            BUGPROOF(TEMPS,T[1]);
            TEMPS:='  ';
            TEMPS[1]:=TOWNS[USERI[NUM,14],A][3];
            TEMPS[2]:=TOWNS[USERI[NUM,14],A][4];
            BUGPROOF(TEMPS,D[1])
           End;
          If (ORD(TOWNS[USERI[NUM,14],A][0]))>4 then Begin
            TEMPS[1]:=TOWNS[USERI[NUM,14],A][5];
            TEMPS[2]:=TOWNS[USERI[NUM,14],A][6];
            If TEMPS[1]='0' then TEMPS:=TEMPS[2];
            BUGPROOF(TEMPS,T[2]);
            TEMPS:='  ';
            TEMPS[1]:=TOWNS[USERI[NUM,14],A][7];
            TEMPS[2]:=TOWNS[USERI[NUM,14],A][8];
            BUGPROOF(TEMPS,D[2])
           End;
          If (ORD(TOWNS[USERI[NUM,14],A][0]))>8 then Begin
            TEMPS[1]:=TOWNS[USERI[NUM,14],A][9];
            TEMPS[2]:=TOWNS[USERI[NUM,14],A][10];
            If TEMPS[1]='0' then TEMPS:=TEMPS[2];
            BUGPROOF(TEMPS,T[3]);
            TEMPS:='  ';
            TEMPS[1]:=TOWNS[USERI[NUM,14],A][11];
            TEMPS[2]:=TOWNS[USERI[NUM,14],A][12];
            BUGPROOF(TEMPS,D[3])
           End;
         If T[1]<>0 then Begin
          Mrite ('  ');
          Send_Num(TOWNI[T[1],1]);
          Mrite('. ');
          If T[1]<10 then Mrite (' ');
          Mriteln (TOWNS[T[1],1]);
          If T[2]>0 then Begin
            Mrite ('  ');
            Send_Num(TOWNI[T[2],1]);
            Mrite('. ');
            If T[2]<10 then Mrite (' ');
            Mriteln (TOWNS[T[2],1])
           End;
          If T[3]>0 then Begin
            Mrite ('  ');
            Send_Num(TOWNI[T[3],1]);
            Mrite('. ');
            If T[3]<10 then Mrite (' ');
            Mriteln (TOWNS[T[3],1])
           End;
          End;
     If TOWNS[USERI[NUM,14],A]<>'0' then Begin
      Repeat
       Mriteln('');Mrite ('Travel to which Town? [0=Cancel] ');
       Meadln(CH)
      Until CH<>'';
       BUGPROOF(CH,FH)
      End
      Until (CH='0') or (FH=T[1]) or (FH=T[2]) or (FH=T[3]) or (JUNKS='CANCEL');
     If FH=0 then Mriteln('');
     (*If FH=0 then C:='3';*)
     If (A<>0) and (TOWNS[USERI[NUM,14],A]<>'0') then Begin
       If (FH<>0) then Begin
         If FH=T[1] then G:=1;
         If FH=T[2] then G:=2;
         If FH=T[3] then G:=3;
         Mriteln('');Mrite ('Travel to ');
         Mrite(TOWNS[FH,1]);Mrite('? ');
         WHAT(JUNKS);
         Mriteln('');
       If (USERI[NUM,8]>3) and (WIND<3) and (A=12) and (MYSTIC=False) then Begin
         Mriteln ('The winds are not high enough at this time!');
         STOP;
         JUNKS:='N';
         Mriteln('')
        End;
        If (JUNKS='Y') and (A=12) then Begin
         EXCEPT:=USERI[NUM,8];
         If EXCEPT>10 then EXCEPT:=EXCEPT-10;
         If USERI[NUM,8]>1 then D[G]:=D[G]-EXCEPT;
         If MYSTIC then D[G]:=D[G]-3;
         If WIND=4 then D[G]:=D[G]-1;
         If WIND=5 then D[G]:=D[G]-2;
         If (WIND>5) and (WIND<9) then D[G]:=D[G]-3;
         If WIND=9 then D[G]:=D[G]-4;
         If WIND=10 then D[G]:=D[G]-5;
         If WIND=11 then D[G]:=D[G]-6;
         If WIND=12 then D[G]:=D[G]-7;
         Mrite ('It will take thee ');
         Send_Num(D[G]);
         Mrite(' Hours to Sail to ');
         Mrite(TOWNS[T[G],1]);
         Mriteln('.');
         If (USERI[NUM,6]<D[G]) then Begin
           Mriteln('Thou dost not have enough time left in this realm!');
           If EMULATE then STOP;
           Mriteln('');
           ENOUGH:=False
          End;
        If ENOUGH=True then Begin
        GOT:=0;
        If USERI[NUM,8]>2 then Begin
         Mriteln('');Mrite ('A Merchant says, "Would''st thou like to hire any Sailors?" ');
         WHAT(JUNKS);
         If JUNKS='Y' then Begin
          Repeat
          PRICE:=TOWNI[USERI[NUM,14],13]*10;          
           Mrite ('How many at ');
           Send_Num(PRICE);
           Mrite(' Gold pieces each? ');
           Meadln(JUNKS);
           BUGPROOF(JUNKS,SAILORS);
          Until SAILORS>0;
          PRICE:=PRICE*SAILORS;
          Mriteln('');Mrite ('That will be ');
          Send_Num(PRICE);Mriteln(' Gold Pieces.');
          Mriteln('');
          If USERI[NUM,4]<PRICE then Mrite ('He says, "Thou dost not have enough gold for ');
          If USERI[NUM,4]<PRICE then Mrite(JUNK);
          If USERI[NUM,4]<PRICE then Mriteln(' Sailors!!"');
          If USERI[NUM,4]=PRICE then Mriteln ('That Would leave thee Broke!');
          If USERI[NUM,4]>PRICE then Begin
            Mriteln ('"Very Well!", The Merchant says, taking thy Gold.');
            Send_Num(SAILORS);
            USERI[NUM,4]:=USERI[NUM,4]-PRICE;
            Mriteln(' Sailors climb aboard!  "Travel Safely", He Says.');
            If EMULATE then STOP;
            GOT:=SAILORS
            End
           End
          End;
          EXCEPT:=USERI[NUM,8];
          If EXCEPT>10 then EXCEPT:=EXCEPT-10;
          HULL:=EXCEPT*10;TURN:=False;COUNT:=0;
          If MYSTIC then Mriteln('');
          If MYSTIC then Mriteln('A strange wind wisps through the air!!!');
          If (MYSTIC=True) and (EMULATE=True) then STOP;
          SHA:=DRANDOM mod 225+1;WHI:=DRANDOM mod 110+1;STO:=DRANDOM mod 110+1;
          PIR:=DRANDOM mod 180+1;SEA:=DRANDOM mod 180+1;SQU:=DRANDOM mod 180+1;
          SHK:=DRANDOM mod 150+1;If STO=1 then EM_SEND(262);
          If WIND=12 then STO:=100;
           If C<>'3' then Begin
            EM_SEND(1000+T[G]);
            EM_SEND(302);
           End;
          For DUMB:=1 to D[G] do Begin
           If C<>'3' then Begin
            COUNT:=COUNT+1;
            Mriteln('');Mrite('Press any key for hour #');
            Send_Num(COUNT);Mrite(' [T]urn back...');
            SOMETHING(JUNKS);
            If (HULL<10) and (HULL>6) then Mrite('Hull is Weak!! ');
            If HULL<7 then Mrite('Hull Damage Critical!! ');
            If JUNKS='T' then Begin
              Mrite('Head back? ');
              If EMULATE then VT:=False;WHAT(JUNKS);If EMULATE then VT:=True;
              If JUNKS='Y' then Begin
                If TURN=True then Mriteln('');
                If TURN=True then Mriteln('Thou already did!')
                Else Begin
                  TURN:=True;
                  DUMB:=DUMB+((D[G]+2)-DUMB-DUMB)
                 End;
                End;
               End;
            If JUNKS<>'T' then Mriteln('');If JUNKS<>'T' then Mriteln('');
            USERI[NUM,6]:=USERI[NUM,6]-1;SHA:=SHA-1;WHI:=WHI-1;STO:=STO-1;
            PIR:=PIR-1;SEA:=SEA-1;SQU:=SQU-1;SHK:=SHK-1;EM_SEND(200+USERI[NUM,6]);
            If TURN=True then Mriteln('Heading back to town!');
            Case STO of
              1:Mriteln('The wind spits it''s fury!');
              2:Mriteln('Lightning streaks across the Horizon...');
              3:Mriteln('Murky clouds drift across the sky...');
              5:Mriteln('Thou hearest thunder in the distance...')
             End;
            Case SHK of
              1:Mriteln('A creature approaches thee!!');
              3:Mriteln('Thou seest a fin in the water.');
              5:Mriteln('Thou seest rippling waters...')
             End;
            Case PIR of
              1:Mriteln('A pirate ship meets thee!!!');
              3:Mriteln('Thou seest a ship in the misty horizon!');
              5:Mriteln('Thou seest a black spot in the distance...')
             End;
            Case WHI of
              1:Mriteln('A Whirlpool gains in speed towards thee!!!!');
              3:Mriteln('Thou seest a whirlpool in the distance!');
              5:Mriteln('Thou seest rough waves...')
             End;
            Case SHA of
              1:Mriteln('The blackness grows larger, accompanied by a low roar!!!!!');
              2:Mriteln('Thou seest a black mark among the gray clouds...');
              4:Mriteln('Lightning strikes on the watery horizon...');
              6:Mriteln('Gray clouds fill the sky almost instantly...')
             End;
            If STO=1 then WIND:=12;
            If (PIR=2) or (PIR=3) then EM_SEND(1069);
            If ((STO=3) or (STO=2)) and (WIND<12) then WIND:=11;
            If (SHA<=6) and (WIND<10) then WIND:=10;
            If (SHA<3) and (DIDIT=False) then EM_SEND(689);
            If (SHA<3) and (DIDIT=False) then EM_SEND(303);
            If SHA<3 then DIDIT:=True;
            If (WHI=0) then Begin
              EM_SEND(688);EM_SEND(303);If EMULATE then VT:=False;
              Mriteln('Thou art trapped by a whirlpool''s grasp!!!!!!!');
              WGOT:=GOT;If GOT=0 then WGOT:=1;
              Repeat
                Mriteln('');Mrite('Press <<>>RETURN<<>> to try and escape the whirlpool.');
                QSTOP;
                If WGOT>1 then Begin
                  Mriteln('');Mriteln('The sailors help thee...')
                 End;
                If DRANDOM mod (6+WGOT)<=WGOT then Begin
                  Mriteln('');Mriteln('Thou escaped the pool''s clutches!!!');
                  WHI:=DRANDOM mod 110+1;
                  WGOT:=10000
                 End
                Else Begin
                  PLAY2:=DRANDOM mod 6+1;
                  Mriteln('');Mrite('The pool churns thy ship...  Hull Damage = ');
                  Send_Num(PLAY2);
                  Mriteln('!!');
                  HULL:=HULL-PLAY2
                 End;
               Until (WGOT=10000) or (HULL<1);
               EM_SEND(302);If EMULATE then VT:=True;
               If HULL<1 then GTT:=True
              End;
            If ((STO<1) or (WIND=12)) and (HULL>0) then Begin
              If DRANDOM mod 2+1=1 then Mrite('Rough Seas!!! ')
              Else Mrite('Fierce weather! ');
              EXCEPT:=5+GOT;
              PLAY1:=DRANDOM mod EXCEPT;
              If PLAY1<=GOT then Begin
                If GOT=0 then Mriteln(' Damage Evaded!');
                If GOT>0 then Mriteln(' Damage Evaded by sailors!!')
               End;
              If PLAY1>GOT then Begin
                Mrite('Hull Damage = ');
                PLAY2:=DRANDOM mod 3+1;
                Send_Num(PLAY2);
                HULL:=HULL-PLAY2;
                Mriteln('');
                If HULL<1 then GTT:=True
               End;
             End;
            If PIR=0 then C_MONSTER:=37;
            If (PIR=0) and (GTT=False) then Begin
              EM_SEND((600+C_MONSTER)-1);
              EM_SEND(303);
              COMBAT(GOT,OVER,False);
              EM_SEND(302)
             End;
            If SEA=0 then C_MONSTER:=38;
            If (SEA=0) and (GTT=False) then Begin
              EM_SEND((600+C_MONSTER)-1);
              EM_SEND(303);
              COMBAT(GOT,OVER,False);
              EM_SEND(302)
             End;
            If SQU=0 then C_MONSTER:=39;
            If (SQU=0) and (GTT=False) then Begin
              EM_SEND((600+C_MONSTER)-1);
              EM_SEND(303);
              COMBAT(GOT,OVER,False);
              EM_SEND(302)
             End;
            If SHK=0 then C_MONSTER:=40;
            If (SHK=0) and (GTT=False) then Begin
              EM_SEND((600+C_MONSTER)-1);
              EM_SEND(303);
              COMBAT(GOT,OVER,False);
              EM_SEND(302)
             End;
            If PIR=0 then PIR:=DRANDOM mod 110+1;
            If SEA=0 then SEA:=DRANDOM mod 110+1;
            If SQU=0 then SQU:=DRANDOM mod 110+1;
            If SHK=0 then SHK:=DRANDOM mod 110+1;
            If (SHA=0) and (GTT=False) then Begin
              EM_SEND(212);
              If DIDIT=False then EM_SEND(689);If DIDIT=False then EM_SEND(303);
              Mriteln('Thou art engulfed by The Shadow!!!!!!!!  Thou dost become part');
              Mriteln('of the wizards'' twisted dimension...');
              HALF:=True;STOP;HALF:=False;EM_SEND(300);EM_SEND(132);OCE:=False;
              GT:=True;
              USERI[NUM,14]:=17;C:='3';EM_SEND(17);
              WIZARDS(NUM,OVER,SUN)
            End;
            If GTT=True then DUMB:=D[G];
           End;
          End;
         If GTT=True then Begin
           EM_SEND(107);Mriteln('');
           Mrite('Thy ');
           If USERI[NUM,8]>0 then AWVIEW(3,USERI[NUM,8]);
           If USERI[NUM,8]=0 then Mrite('vessel');
           Mriteln(' sinks into the bowels of the Ocean!!!');
           Mriteln('The crisis spell hath been invoked, thy life is spared...');
           STOP;EM_SEND(300)
          End;
         If (GT=False) and (GTT=False) then Begin
          EM_SEND(300);
          Mriteln('');Mrite ('Thou successfully arriveth at ');
          If TURN=False then USERI[NUM,14]:=T[G];EM_SEND(USERI[NUM,14]);
          Mrite(TOWNS[USERI[NUM,14],1]);Mriteln('!');USERI[NUM,5]:=USERI[NUM,5]+3745;
          Mriteln('');Mriteln(TOWNS[USERI[NUM,14],14]);
          STOP;
          Mriteln('')
          End
          End
         End
        End
       End
      End;
    If FH=0 then C:='3';
     If (TOWNS[USERI[NUM,14],A]<>'0') and (A=13) and (FH<>0) and (JUNKS='Y') then Begin
         Mriteln('');
         D[G]:=D[G]-(USERI[NUM,16] div 2);If D[G]<2 then D[G]:=2;
         Mrite ('It will take thee ');
         Send_Num(D[G]);
         Mrite(' Hours to get to ');
         Mrite(TOWNS[T[G],1]);Mriteln('.');
         If (USERI[NUM,6]<D[G]) then Begin
           Mriteln('Thou dost not have enough time left in this realm!');
           Mriteln('');
           ENOUGH:=False
          End;
        If ENOUGH=True then Begin
          C:='3';
          If USERI[NUM,16]>0 then Begin
            Mriteln('');Mrite ('Thou preparest ');
            Mrite(USERS[NUM,9]);
            Mriteln(' for the trip!');If EMULATE then STOP
          End;
          WHI:=DRANDOM mod 70+1;SHA:=DRANDOM mod 70+1;
          ENC:=DRANDOM mod 50+1;
          EM_SEND(1000+T[G]);
          EM_SEND(302);
          For DUMB:=1 to D[G] do Begin
            WHI:=WHI-1;SHA:=SHA-1;ENC:=ENC-1;
            Mriteln('');Mrite('Press any key to travel for hour #');
            Send_Num(DUMB);Mrite('...');
            SOMETHING(JUNKS);
            USERI[NUM,6]:=USERI[NUM,6]-1;EM_SEND(200+USERI[NUM,6]);
            Mriteln('');Mriteln('');
            If WHI=3 then Mriteln('A voice booms from the heavens, "I send one to challenge thee!!"');
            If SHA=2 then Mriteln('Thou dost hear footsteps in the dry leaves...');
            If ENC=4 then Mriteln('Thou hearest someone talking in the distance.');
            If ENC=2 then Mriteln('Thou seest a black figure approaching thee...');
            C_MONSTER:=DRANDOM mod 36+1;
            If WHI=1 then Begin
              EM_SEND((600+C_MONSTER)-1);
              EM_SEND(303);
              COMBAT(2,OVER,OVER);
             End;
            If ENC=1 then Mriteln('');
            If (ENC=1) and (OVER=False) then ENCOUNTER(2,NUM,OVER);
            If (SHA=1) and (OVER=False) then Begin
              EM_SEND((600+C_MONSTER)-1);
              EM_SEND(303);
              COMBAT(2,OVER,OVER);
             End;
            If WHI=1 then WHI:=DRANDOM mod 30+1;
            If SHA=1 then SHA:=DRANDOM mod 30+1;
            If ENC=1 then ENC:=DRANDOM mod 30+1;
           End;
        If OVER=False then Begin
          EM_SEND(300);
          Mriteln('');Mrite ('Thou successfully arriveth at ');
          Mrite(TOWNS[T[G],1]);Mriteln('!');USERI[NUM,5]:=USERI[NUM,5]+3467;
          Mriteln('');Mriteln(TOWNS[T[G],14]);
          USERI[NUM,14]:=T[G];EM_SEND(USERI[NUM,14]);
         End
        End
       End
     End
    End
    Until C='3';
    If GT=False then Begin
     If (JUNK='O') and (OVER=False) and (USERI[NUM,16]=0) then Mriteln ('It took thee an Hour to walk into Town.');
     If (JUNK='O') and (OVER=False) and (USERI[NUM,16]=0) then USERI[NUM,6]:=USERI[NUM,6]-1;
     If (JUNK='O') and (OVER=False) and (USERI[NUM,16]>0) then Mriteln ('Thou ridest back to Town.');
     If (OVER=False) and (FH<>0) then STOP;
     If OVER=False then Mriteln('')
     End;
     If GT=True then GT:=False
     End;
    End;
     HALF:=False;If OCE then EM_SEND(132);OCE:=False;If CHEAT6<>0 then USERI[NUM,14]:=2;
    End;
(**************************************************************************)
  Procedure MAINMENU(Var NUM:Integer;Var OVER:Boolean;Var SUN:Long_Integer);
    Var
     CHOICE:Str255;
     A,D_EVENT,PUN,GOLD,OLDWIND:Integer;
     JERK:Boolean;
    Begin
      Mriteln('');Mriteln('');
      WIND:=0;
     Repeat
      A:=0;
      Mrite(chr(0));Mrite(chr(13));Mrite(chr(13));
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      EM_SEND(423);
      Mriteln('');
      If (USERI[NUM,25]>0) and (USERI[NUM,25]<100) then Begin
        Mrite('Thou art confronted by a team of ');
        WIND:=USERI[NUM,21] div 12;
        If WIND=0 then WIND:=2;
        Send_Num(WIND);
        Mriteln(' assassins!!!!');EM_SEND(107);
        If USERS[USERI[NUM,25],3]<>'EMPTY' then Begin
          Mriteln('');Mrite('The leader says, "');
          Mrite(USERS[USERI[NUM,25],3]);
          Mriteln(' sent us to kill thee!  DIE KNAVE!!!"');
         End;
        For D_EVENT:=1 to WIND do Begin
         C_MONSTER:=13;
         If OVER=False then Begin
           EM_SEND((600+C_MONSTER)-1);
           EM_SEND(303);
           COMBAT(1,OVER,False);
          End;
        End;
        If OVER=False then STOP;
        WIND:=0;D_EVENT:=0;Mriteln('');USERI[NUM,25]:=0
       End;
      If OVER=False then MAKESURE(NUM,SUN,OVER);
      If OVER=False then EM_SEND(1053);
      If OVER=False then Begin
       If EMULATE=False then Begin
       ABLE:=True;Mrite ('                      ');
       For A:=1 to ord(TOWNS[USERI[NUM,14],1][0])+2 do
         Mrite ('*');
       Mriteln('');Mrite (' Town you are now in: ');
       If VT=True then Begin
         Mrite ('*');
         Mrite (CHR(27));
         Mrite ('b1');
         Mrite(TOWNS[USERI[NUM,14],1]);
         Mrite(CHR(27));
         Mriteln('b3*')
        End;
       If VT=False then Mrite ('*');
       If VT=False then Mrite (TOWNS[USERI[NUM,14],1]);
       If VT=False then Mriteln('*');
       Mrite ('                      ');
       For A:=1 to ord(TOWNS[USERI[NUM,14],1][0])+2 do
         Mrite ('*');
       Mriteln('');Mriteln('');
       Case USERI[NUM,14] of
         1:Mriteln (' [0]  Visit The Thieves'' Guild.');
         2,17:Mriteln (' [0]  Visit the Stable.');
         3:Mriteln (' [0]  Visit The Gypsy''s Quarters');
         4:Mriteln (' [0]  Go to the Torture Chamber.');
         5:Mriteln (' [0]  Visit the Temple of Balor.');
         8:Mriteln (' [0]  Enter the Wizard''s Workshop.');
         10:Mriteln (' [0]  Explore the Cave of the Ancient Ones.');
         11:Mriteln (' [0]  Visit the Temple of Cathra.');
         12:Mriteln (' [0]  Go to the Colleseum.');
         13:Mriteln (' [0]  Enter a Pyramid.');
         18:Mriteln (' [0]  Visit the Graveyard.');
         20:If USERI[NUM,32]=0 then Mriteln (' [0]  Wander the Fortress...');
         21:Mriteln (' [0]  Visit the Temple of Solnar.');
         25:Mriteln (' [0]  Visit the Assassin''s Guild.')
       End; {Case}
       Mriteln (' [1]  Read Town Status.');If CHEAT7<>53 then USERI[NUM,4]:=250;
       Mriteln (' [2]  Gamble at The Casino.');
       Mriteln (' [3]  Enter The Tavern.');
       Mriteln (' [4]  Visit The Inn.');
       Mriteln (' [5]  Visit The Wizard''s Guild.');
       Mriteln (' [6]  Leave Town (Travel)...');
       Mriteln (' [7]  Visit The Bank.');
       Mriteln (' [8]  Enter The Shoppe.');
       Mriteln (' [9]  Visit The Jail.');
       Mriteln (' [10] Steal from other Guild Members.');
       Mriteln (' [11] Try to Steal from Civilians.');
       Mriteln (' [12] View Other Guild Members.');
       Mriteln (' [13] View Thy Status.');
       Mriteln (' [14] Quit & Save.');
      End;
       D_EVENT:=0;
       ABLE:=False;SOFF:=False;
       Mriteln('');
       If USERI[NUM,6]=12 then
         Mriteln('A magical rainbow stretches across the night sky...');
       If USERI[NUM,6]=11 then
         Mriteln('A pale moon sheds it''s faint light upon the land...');
       If USERI[NUM,6]=16 then
         Mriteln('A silver cresent moon glimmers through the wispy clouds...');
       If USERI[NUM,6]=7 then
         Mriteln('A crimson moon appears on the southern horizon...');
       If SYSOPM>0 then Mriteln(S_STUFF[SYSOPM]);
       SYSOPM:=0;
       If USERI[NUM,32]=1 then
         Mriteln('Princess Moonshade tags along, she doesn''t seem happy.');
       If (WIND>0) and (CHOICE<>'') then Begin
         If DRANDOM Mod 4+1=3 then WIND:=DRANDOM Mod 12+1
        End;
       If WIND=0 then WIND:=DRANDOM Mod 12+1;
       If ELEMENT>0 then WIND:=ELEMENT;ELEMENT:=0;
       If WIND=9 then Mriteln ('Colorful banners unfurl in the warm breeze.');
       If WIND=10 then Begin
          Mrite ('Dust devils roam the ');
          If (USERI[NUM,6]<18) and (USERI[NUM,6]>4) then Mriteln ('moonlit streets.')
          Else Mriteln ('sunny streets.')
         End;
       If WIND=11 then Mriteln ('High winds blow light rain through the air.');
       If WIND=12 then Mriteln ('Fierce rain thrashes the buildings, accompanied by a cracking Thunder.');
       If (USERI[NUM,14]<>8) and (CHOICE<>'') and (CHOICE<>'13') then D_EVENT:=DRANDOM mod 100;
       Case D_EVENT of
         21:Mriteln ('A cult of Balorians Raid the City!!');
         22:Mriteln ('A deadly plague spreads throughout the town!');
         23:Mriteln ('A Wild Tornado passes through the Town!');
         24:Mriteln ('A Major fire breaks out on the outskirts of Town!');
         25:Mriteln ('The Solnarian God is displeased, a violent earthquake strikes!');
         26:Mriteln ('A new Trade route has been established!');
         27:Mriteln ('A new gold mine has been discovered!');
         28:Mriteln ('New birth in the ruling family!')
        End; {Case}
       If (D_EVENT>20) and (D_EVENT<26) then Begin
         Send_Num((TOWNI[USERI[NUM,14],7] div D_EVENT));
         Mriteln(' Civilians were Killed!');
         TOWNI[USERI[NUM,14],7]:=TOWNI[USERI[NUM,14],7]-(TOWNI[USERI[NUM,14],7] div D_EVENT)
        End;
       If (D_EVENT>25) and (D_EVENT<29) then Begin
         Send_Num((TOWNI[USERI[NUM,14],7] div D_EVENT));
         Mriteln(' Civilians emigrate to the town!');
         TOWNI[USERI[NUM,14],7]:=TOWNI[USERI[NUM,14],7]+(TOWNI[USERI[NUM,14],7] div D_EVENT)
        End;
       If (USERI[NUM,14]=2) or (USERI[NUM,14]=3) or (USERI[NUM,14]=14) then Begin
         D_EVENT:=DRANDOM mod 20;
         If D_EVENT=1 then Mriteln ('The Red Demon Volcano releases it''s fury!');
         If D_EVENT=1 then Send_Num ((TOWNI[USERI[NUM,14],7] div 23));
         If D_EVENT=1 then Mriteln (' Civilians were consumed in the flames...');
         If D_EVENT=1 then
           TOWNI[USERI[NUM,14],7]:=TOWNI[USERI[NUM,14],7]-(TOWNI[USERI[NUM,14],7] div 23);
         If (CHOICE<>'') and (CHOICE<>'13') then D_EVENT:=DRANDOM mod 100
         Else D_EVENT:=0
        End;
      If (CHOICE<>'') and (CHOICE<>'13') then Begin
       If USERI[NUM,10]>0 then USERI[NUM,10]:=USERI[NUM,10]-1;
       If USERI[NUM,11]>0 then USERI[NUM,11]:=USERI[NUM,11]-1;
       If USERI[NUM,12]>0 then USERI[NUM,12]:=USERI[NUM,12]-1;
       If USERI[NUM,26]>0 then USERI[NUM,26]:=USERI[NUM,26]-1
      End;
       If VT=True then Mrite(Chr(27));
       If VT=True then Mrite('b1');
       A:=DRANDOM mod 2+1;
       If (USERI[NUM,26]<=5) and (USERI[NUM,26]<>0) then Mrite ('Thou Art POISONED!!!! Hit Points -');
       If (USERI[NUM,26]<=5) and (USERI[NUM,26]<>0) then Send_Num(A);
       If (USERI[NUM,26]<=5) and (USERI[NUM,26]<>0) then Mriteln('');
       If (USERI[NUM,26]<=5) and (USERI[NUM,26]<>0) then USERI[NUM,20]:=USERI[NUM,20]-A;
       If (USERI[NUM,26]<=5) then DEATH:='Poison';
       If (USERI[NUM,26]<=5) then C_MONSTER:=0;
       If (USERI[NUM,10]<=13) and (USERI[NUM,10]>8) then Mriteln ('Thou art Hungry!');
       If (USERI[NUM,10]<=8) and (USERI[NUM,10]>5) then Mriteln ('Thou art Very Hungry!');
       If USERI[NUM,10]<=5 then Mrite ('Thou Art STARVING!!! ');
       A:=DRANDOM mod 2+1;
       If (A=1) and (USERI[NUM,10]<=5) then Mriteln('Hit Points -1!');
       If (A=2) and (USERI[NUM,10]<=5) then Mriteln('Skill -1!');
       If (USERI[NUM,10]<=5) and (USERI[NUM,3]>5) and (A=2) then USERI[NUM,3]:=USERI[NUM,3]-1;
       If (USERI[NUM,10]<=5) and (A=1) then USERI[NUM,20]:=USERI[NUM,20]-1;
       If (USERI[NUM,26]<=5) and (A=1) then DEATH:='Hunger';
       If (USERI[NUM,26]<=5) and (A=1) then C_MONSTER:=0;
       If (USERI[NUM,11]<=13) and (USERI[NUM,11]>8) then Mriteln ('Thou art Thirsty!');
       If (USERI[NUM,11]<=8) and (USERI[NUM,11]>5) then Mriteln ('Thou art Very Thirsty!');
       If USERI[NUM,11]<=5 then Mrite ('Thou Art PARCHED!!! ');
       A:=DRANDOM mod 2+1;
       If (A=1) and (USERI[NUM,11]<=5) then Mriteln('Hit Points -1!');
       If (A=2) and (USERI[NUM,11]<=5) then Mriteln('Skill -1!');
       If (USERI[NUM,11]<=5) and (USERI[NUM,3]>5) and (A=2) then USERI[NUM,3]:=USERI[NUM,3]-1;
       If (USERI[NUM,11]<=5) and (A=1) then USERI[NUM,20]:=USERI[NUM,20]-1;
       If (USERI[NUM,26]<=5) and (A=1) then DEATH:='Thirst';
       If (USERI[NUM,26]<=5) and (A=1) then C_MONSTER:=0;
       If (USERI[NUM,12]<=13) and (USERI[NUM,12]>8) then Mriteln ('Thou art Weary!');
       If (USERI[NUM,12]<=8) and (USERI[NUM,12]>5) then Mriteln ('Thou art Tired!');
       If USERI[NUM,12]<=5 then Mrite ('Thou Hast SEVERE FATIGUE!!! ');
       A:=DRANDOM mod 2+1;
       If (A=1) and (USERI[NUM,12]<=5) then Mriteln('Hit Points -1!');
       If (A=2) and (USERI[NUM,12]<=5) then Mriteln('Skill -1!');
       If (USERI[NUM,12]<=5) and (USERI[NUM,3]>5) and (A=2) then USERI[NUM,3]:=USERI[NUM,3]-1;
       If (USERI[NUM,12]<=5) and (A=1) then USERI[NUM,20]:=USERI[NUM,20]-1;
       If (USERI[NUM,26]<=5) and (A=1) then C_MONSTER:=0;
       If (USERI[NUM,26]<=5) and (A=1) then DEATH:='Severe Fatigue';
       If VT=True then Mrite(Chr(27));
       If VT=True then Mrite('b3');
       If ((D_EVENT>30) and (D_EVENT<33)) and (GM<>NUM) then Begin
         Mriteln('');Mriteln('The Guild Master collects 1/15th of thy Gold for dues!!!');
         DUES:=DUES+(USERI[NUM,4] div 15);
         USERI[NUM,4]:=USERI[NUM,4]-(USERI[NUM,4] div 15)
        End;
       If (D_EVENT>40) and (D_EVENT<43) and (USERI[NUM,4]>1) then Begin
         C_MONSTER:=14;
         EM_SEND((600+C_MONSTER)-1);
         EM_SEND(303);
         Mriteln('');Mriteln('A thief holds a dagger to thy neck!!!!');
         Mriteln('The thief says, "Give me half thy gold, or meet my blade with thy flesh!"');
         Mrite('Dost thou give thy gold? ');
         If EMULATE then VT:=False;WHAT(CHOICE);If EMULATE then VT:=True;
         If CHOICE='Y' then Begin
           Mriteln('');Mriteln('The theif takes thy gold and flees...');
           If EMULATE then STOP;EM_SEND(300);
           USERI[NUM,4]:=USERI[NUM,4]-(USERI[NUM,4] div 2)
          End;
         If CHOICE='N' then Begin
           COMBAT(1,OVER,UJAILL)
          End;
        End;
       If (D_EVENT>50) and (D_EVENT<56) then C_MONSTER:=DRANDOM mod 4+1;
       If (D_EVENT>50) and (D_EVENT<56) then Begin
         EM_SEND((600+C_MONSTER)-1);
         EM_SEND(303);
         COMBAT(1,OVER,OVER);
        End;
       If (D_EVENT>69) and (D_EVENT<74) then Begin
         If (USERI[NUM,6]<18) and (USERI[NUM,6]>4) then EM_SEND(502)
         Else EM_SEND(501);
         EM_SEND(686);EM_SEND(423);EM_SEND(303);
         Mriteln('Thou hast found a circle of mushrooms...');
         Mriteln('');
         If (USERI[NUM,6]<18) and (USERI[NUM,6]>4) then Begin
           Mriteln ('Faries dance about in the moonlight.');
           If EMULATE then STOP;
           EM_SEND(300)
            End
          Else Begin
            Mrite('Invoke the power of the fairy ring? ');
            If EMULATE then VT:=False;WHAT(CHOICE);If EMULATE then VT:=True;
            If CHOICE='Y' then Begin
              Mriteln('');
              Mriteln('Thou dost stand in the circle and make thy wish...  Riches Granted!');
              If EMULATE then STOP;
              USERI[NUM,4]:=USERI[NUM,4]+DRANDOM mod 5000+1
            End;
            EM_SEND(300)
           End;
          End;
       If (D_EVENT>74) and (D_EVENT<81) then Begin
         EM_SEND(113);
         Mriteln('Someone pick-pocketed thee!!!  Thy purse feels lighter...');
         USERI[NUM,4]:=USERI[NUM,4]-(USERI[NUM,4] div 25)
        End;
       If (D_EVENT>80) and (D_EVENT<86) then ENCOUNTER(1,NUM,OVER);
       If (D_EVENT>85) and (D_EVENT<92) then Begin
         C_MONSTER:=6;
         EM_SEND((600+C_MONSTER)-1);
         EM_SEND(303);
         Mriteln('');JERK:=False;
         Mriteln('A dirty beggar approaches thee, "Spare but a small treasure for one in need?"');
         Repeat
           Mriteln('');Mrite('Give how much gold? [0=none]: ');
           If EMULATE then VT:=False;Meadln(CHOICE);If EMULATE then VT:=True;
           BUGPROOF(CHOICE,GOLD);
           If GOLD>=USERI[NUM,4] then Mriteln('Thou dost not have that much!!');
         Until (GOLD>-1) and (GOLD<USERI[NUM,4]);
         Mriteln('');
         If GOLD=0 then Mriteln('The Beggar complains, "Heartless Fool!!!  Rot in the Abyss!!"');
         If (GOLD=0) and (DRANDOM mod 3+1=2) then Begin
           JERK:=True;COMBAT(1,OVER,OVER)
          End;
         If GOLD>0 then Begin
           Mriteln('The beggar exclaims, "Thank thee!  Might thou always walk in truth''s light!"');
           USERI[NUM,4]:=USERI[NUM,4]-GOLD;
           If (GOLD>9999) and (HORN=False) then Begin
             Mriteln('');Mriteln('He gives thee the HORN OF PLENTY, which yeilds infinite food!!!!!!');
             HORN:=True
            End;
           If GOLD>49 then
             If (DRANDOM mod 3+1)=2 then Begin
               MULT:=True;GOLD:=DRANDOM mod 6+1;
               Mriteln('');JERK:=True;
               Mrite('He gives thee ');
               Send_Num(GOLD);
               Mriteln(' Potion(s)!!');
               For PUN:=1 to GOLD do Begin
                 If PUN<>GOLD then MULT:=True;
                 If PUN=GOLD then MULT:=False;
                 POTION
                End;
               MULT:=False
             End
           End;
           If (EMULATE) and (JERK=False) then STOP;EM_SEND(300)
          End;
       If D_EVENT>91 then POTION;
       If D_EVENT=3 then Begin
         EM_SEND(501);EM_SEND(687);EM_SEND(303);
         Mriteln('');Mriteln('Thou findest a  small, black  vial  lying  on  the');
         Mriteln('street with Grotesque faces carved on it''s sides.');
         Mrite('Dost thou wish to (O)pen or (I)gnore it? ');
         Repeat
           SOMETHING(CHOICE);
         Until (CHOICE='O') or (CHOICE='I');
         If CHOICE='I' then Mriteln('Ignore...');
         If CHOICE='I' then EM_SEND(300);
         If CHOICE='O' then Begin
           Mriteln('Open...');Mriteln('');
           EM_SEND(502);EM_SEND(1067);
          If EMULATE=False then Begin
           Mriteln('A black smoke engulfs the light.  A darkness surrounds thee!');
           Mriteln('A small black creature stands before thee.  He speaks with the');
           Mriteln('tougne of Wizardry, "Hail Master!  I am Trilok, darkling of Balor!');
           Mriteln('I offer thee the riches of the night!  State thy wish, oh great one!"');
          End;
           Mriteln('');Mrite('(D)exterity, (R)iches, or (L)ife Force? ');
           Repeat
             SOMETHING(CHOICE);
           Until (CHOICE='D') or (CHOICE='R') or (CHOICE='L');
           If CHOICE='D' then Begin
             Writeln('Dexterity...');Mriteln('');Mrite('I grant thee ');
             A:=DRANDOM mod 50;
             Send_Num(A);
             Mriteln(' Skill!');
             USERI[NUM,3]:=USERI[NUM,3]+A
            End;
           If CHOICE='R' then Begin
             Mriteln('Riches...');
             Mriteln('');Mrite('I grant thee ');
             A:=DRANDOM mod 10000;
             Send_Num(A);
             Mriteln(' Gold!');
             USERI[NUM,4]:=USERI[NUM,4]+A
            End;
           If CHOICE='L' then Begin
             Mriteln('Life Force...');
             Mriteln('');Mrite('I grant thee physical power - Thou art more than satisfyed!');
             USERI[NUM,10]:=USERI[NUM,10]+25;
             USERI[NUM,11]:=USERI[NUM,11]+25;
             USERI[NUM,12]:=USERI[NUM,12]+25;
            End;
           Mriteln('');Mrite('I take my payment in ');
           A:=DRANDOM mod 20;
           If A<=10 then Begin
             If CHOICE='D' then PUN:=1;
             If CHOICE='R' then PUN:=2;
             If CHOICE='L' then PUN:=2
            End;
           If (A>10) and (A<=20) then Begin
             If CHOICE='D' then PUN:=3;
             If CHOICE='R' then PUN:=3;
             If CHOICE='L' then PUN:=1
            End;
           If PUN=1 then Begin
             Mriteln('Thy Riches!!!!!!!!!!!!');
             USERI[NUM,4]:=USERI[NUM,4]-(USERI[NUM,4] div 2);
            End;
           If PUN=2 then Begin
             Mriteln('Thy Dexterity!!!!!!!!!!');
             If USERI[NUM,3]>5 then USERI[NUM,3]:=USERI[NUM,3]-(USERI[NUM,3] div 4)
            End;
           If PUN=3 then Begin
             Mriteln('Thy Life Force!!!!!!!!!!!!!!');
             USERI[NUM,12]:=-25;EM_SEND(107)
            End;
           Mriteln('');Mriteln('Evil Surrounds thee!!  The Darkling dissapears!');
           If EMULATE then STOP;
           EM_SEND(300)
          End;
         End;
      If USERI[NUM,20]>0 then Begin
       Mriteln('');Mrite ('What dost thou wish to do: ');
       MAINP:=True;TWISTY:=True;Meadln (CHOICE);
       UPCASE(CHOICE);MAINP:=False;
      End;
      If (USERI[NUM,6]=12) and (CHOICE='CYANTHIA') then Begin
         Mriteln('');Mriteln('A blue light decends from the heavens!!  The Fairy meets thee,');
         Mriteln('"I am Starlight, princess of  the Midnight Rainbow.  The Fairy');
         Mriteln('World, Alyasia, is essential in  thy quest.  Remember the name');
         Mriteln('for a Black Dragon seeks that knowledge!  If thou dost fail to');
         Mriteln('recall, thou shalt surely face his wrath!!!!!!!!!"');
         Mriteln('');Mriteln('The Fairy vanishes...');
        STOP
       End;
      If CHOICE='LOHMIR' then Begin
        Mriteln('');
        Mriteln('Thou dost chant, "Lohmir" unto the winds...');
        Mriteln('');
        Mriteln('The Elements heed thy command for change!!!!');
        OLDWIND:=WIND;
        Repeat
          WIND:=DRANDOM Mod 12+1;
        Until OLDWIND<>WIND;
        STOP
       End;
      If USERI[NUM,20]>0 then Begin
       If (CHOICE='0') and (USERI[NUM,14]<>6) and (USERI[NUM,14]<>7) and (USERI[NUM,14]<>9)
          and ((USERI[NUM,14]<14) or (USERI[NUM,14]>16)) and (USERI[NUM,14]<>19)
          and ((USERI[NUM,14]<22) or (USERI[NUM,14]>24)) then Begin
         Case USERI[NUM,14] of
           1:THE_GUILD(OVER,SUN);
           2:STABLE(OVER,SUN);
           3:GYPSY(OVER,SUN);
           4:TORTURE;
           8:WORKSHOP(OVER,SUN);
          17:STABLE(OVER,SUN);
           5:TEMPLE(OVER,SUN);
          10:CAVE(OVER,SUN);
          11:TEMPLE(OVER,SUN);
          12:COLOSSEUM(OVER,SUN);
          13:PYRAMIDS(OVER,SUN);
          18:GRAVEYARD(OVER,SUN);
          20:If USERI[NUM,32]=0 then MOONSHADE(OVER,SUN);
          21:TEMPLE(OVER,SUN);
          25:ASSASINS(OVER,SUN)
         End; {Case}
        End;
       If CHOICE='1' then READ(NUM,SUN,OVER);
       If CHOICE='2' then CASINO(NUM,OVER,SUN);
       If CHOICE='3' then TAVERN(OVER,SUN);
       If CHOICE='4' then INN(NUM,OVER,SUN);
       If CHOICE='5' then WIZARDS(NUM,OVER,SUN);
       If CHOICE='6' then TRAVEL(NUM,WIND,OVER,SUN);
       If CHOICE='7' then BANK(OVER,SUN);
       If CHOICE='8' then SHOPPE(NUM,OVER,SUN);
       If CHOICE='9' then VISITJAIL(NUM,OVER,SUN);
       If CHOICE='10' then SFOGM(NUM,OVER,SUN);
       If CHOICE='11' then CIVILIANS(OVER,SUN);
       If CHOICE='12' then MEMBERS(NUM,OVER,SUN);
       If CHOICE='13' then STATS(NUM,OVER,SUN);
       If CHOICE='14' then CYA(OVER,NUM)
      End
     End;
      If USERI[NUM,20]<1 then GOODBYE(NUM,NUM,OVER);
     Until OVER=True
    End;
(**************************************************************************)
    Begin
      SPCB:=False;TOFF:=False;SOFF:=False;ABLE:=False;TKILL:=False;ISITOK:=False;WATERS:=False;
      BBSNAME:='';BN2:='';PIRCHECK:=0;MAINP:=False;CHEAT1:=21;CHEAT2:=254;CHEAT3:=55;CHEAT4:=76;
      EMULATE:=False;DEATH:='';Cmd_GetArg(1,TELLME);Cmd_GetArg(2,BN2);C_ADJECTIVE:=0;A_CRYPT:=False;
      Cmd_GetArg(3,BBSNAME);BOOGIE:=False;DTREAS:=False;COMPTEST:=0;WIZPOT:=False;CHEAT5:=92;
      STEALER:=0;VIEWOK:=False;MULT:=False;GMMSG:='';GT:=False;GTT:=False;LOCK:=False;ELEMENT:=0;
      UPCASE(TELLME);TWISTY:=False;KEY:=False;OCE:=False;MITCH:=False;CHEAT6:=100;
      HORN:=False;FAIRY:=False;LUCK:=False;JOINED:=False;TAVSTEAL:=0;DOUBCHECK:=False;
      PYRA:=False;SYSOPM:=0;MYSTIC:=False;HALF:=False;WIND:=2;WON:=False;
      If TELLME='LOCAL' then CAR:=2;
      If (TELLME='LOCAL') and (BBSNAME<>'') then INSERT(' ',BN2,(ord(BN2[0])+1));
      If TELLME='LOCAL' then INSERT(BBSNAME,BN2,(ord(BN2[0])+1))
      Else Car:=1;
      DAY:=GETDATE Mod 32;
      OVER:=FALSE;UJAILL:=False;Write(Chr(27),'v');
      LOADSTUFF(TOWNI,TOWNS);
      DECRYPT(ln1,ln1o,87);
      If (BBS='EXPRESS') and (CAR=1) then Begin
       BN2:=BBSNAME;
       If TELLME<>'LOCAL' then BN2:=TELLME;
       If BBSNAME<>'' then INSERT(' ',BN2,(ord(BN2[0])+1));
       INSERT(BBSNAME,BN2,(ord(BN2[0])+1))
      End;
      ISITOK:=True;
      MIDNIGHT(DAY,DAYSS,OVER);
      DECRYPT(ln1,ln1o,CHEAT2);
      START;
      LOGON(OVER,NUM,DAY,SUN);
      If (OVER=FALSE) then MAINMENU(NUM,OVER,SUN);
      VIEWOK:=True;
      If USERS[NUM,3]<>'EMPTY' then Begin
        Mriteln('');
        Mrite('Review thy Stats? [Y/N] ');
        WHAT(DEATH);
        If DEATH='Y' then STATS(NUM,OVER,SUN)
      End;
      DDISPLAY;
      Mriteln('');
      Mriteln ('One Moment...');
      If CHEAT5<>237 then
        If (DRANDOM mod 107)>77 then DOUBCHECK:=False;
      If DOUBCHECK then SAVEINFO(OVER);
      ISITOK:=False;
      If (OVER=TRUE) then Begin
        EM_SEND(0);
        Mriteln('');Mriteln ('       ---===**  Thank you for playing The Thieves'' Guild! v2.5b **===---');
        Mriteln('');Mriteln ('      "The Thieves'' Guild", All Rights Reserved (C) 1988-93 by Paul Witte');
        Mriteln('');Mriteln ('               -=/*     A Mythyn Software Production     *\=-');
        Mriteln('')
       End;
      RE;
    END.

