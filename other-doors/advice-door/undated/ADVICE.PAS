Program ADVICE_DOOR;
 {$I auxsubs.pas}
  Type
    Str255=String[76];
    I=Array[1..25,1..50] of Integer;
    S=Array[1..25] of String[160];
    II=Array[1..25] of Long_Integer;
    BL=Array[1..10] of String[160];
    MS=Array[1..524] of Str255;
    FIXEDONE=String[160];
  Var
    USERI:I;
    USERS:S;
    U_STUFF:MS;
    B_LIST:BL;
    INACTIVITY:II;
    CAR,ANGEL,NUM,HOWM,CCCOUNT,B_IT,LIFECOUNT:Integer;
    COMP1,TODAY,LDATE:Long_Integer;
    TELLME,BBSNAME,BN2:String[255];
    LIFE1,LIFE2:String[60];
    WRAPPER,PATH,BBS,TCORRECT,THINGER,FPATH:Str255;
    VT,ABLE,SOFF,TKILL,OVER,ISITOK,TOFF,TWISTY,WWRAP,GONEIN,SYVIEW,BLACK,PIS,AGAIN:Boolean;
(**** DATE GET ************************************************************)
  Function GETDATE:Integer;
    GEMDOS($2a);
(**** MODEM - CHARACTER INPUT *********************************************)
  Function bconin(device:Integer):Integer;
    BIOS(2);
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
(**************************************************************************)
 Procedure MAKE_DATE;
   Var
     O,D,G:Long_Integer;
   Begin
     O:=Getdate mod 32;
     D:=(Getdate mod 512) div 32;
     G:=(Getdate div 512)+1980;
     LDATE:=DA_TE(G-1900,D,O);
   End;
(**** Erase a User's Account **********************************************)
  Procedure WIPE_OUT(WHO:Integer);
    Var
      A,B:Integer;
    Begin
      USERS[WHO]:='EMPTY';
      INACTIVITY[WHO]:=0;
      For A:=1 to 25 do
        USERI[A,WHO]:=0;
      For A:=1 to 25 do
        If USERI[WHO,A]=2 then USERI[WHO,A]:=1;
      For A:=26 to 50 do
        USERI[WHO,A]:=0;
      For A:=1 to 25 do
        USERI[A,25+WHO]:=0
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
      NAMER:String[80];
    Begin
      COUNTLA:=ord(LITTLE[0]);
      If COUNTLA>76 then COUNTLA:=76;
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
 Procedure RNAME(FPATH:Str255);
   Var
     TEMP:Str255;
   Begin
      TEMP:=PATH;
      INSERT(FPATH,TEMP,((Ord(TEMP[0]))+1));
      TCORRECT:=TEMP;
   End;
(**************************************************************************)
  Function ENCNUM(KEY:Integer;PER:Integer;DO1:Boolean):Integer;
    Begin
     If DO1=True then ENCNUM:=PER+KEY;
     If DO1=False then ENCNUM:=PER-KEY;
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
      CO1,CO2:Integer;
    Begin
      CO1:=0;CO2:=0;
      For CO1:=1 to 10 do ENCRYPT(B_LIST[CO1],DO3);
      For CO2:=1 to 25 do ENCRYPT(USERS[CO2],DO3);
     End;
(**************************************************************************)
 Procedure SAVEINFO;
   Var
     ONE:Text;
     MINE:Str255;
     A,B:Integer;
   Begin
    If PIS then NUM:=1;
    RNAME('ADVICE.DAT');MINE:='USER_ ';MINE[6]:=Chr(64+NUM);
    Rewrite(ONE,TCORRECT);
    GETEMGONE(True);
    For A:=1 to 10 do Writeln(ONE,B_LIST[A]);
    For A:=1 to 25 do Writeln(ONE,INACTIVITY[A]);
    For A:=1 to 25 do Writeln(ONE,USERS[A]);
    For A:=1 to 25 do Begin
      For B:=1 to 50 do Writeln(ONE,USERI[A,B]);
     End;
    Close(ONE);RNAME(MINE);
   If PIS=False then Begin
    Rewrite(ONE,TCORRECT);
    For A:=1 to 524 do
      Writeln(ONE,U_STUFF[A]);
    End;
   End;
(**** RANDOM GENERATOR ****************************************************)
  Function DRANDOM:Long_Integer;
    XBIOS(17);
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
     If Clock-COMP1=90 then begin
       DUMB:='Time-Out in 30 Seconds.';
       bconout(Car,13);
       For KL:=1 to 39 do Begin
         bconout(Car,ord(DUMB[KL]));
         TKILL:=True
        End;
       bconout(Car,13)
      End;
     If Clock-COMP1>120 then begin
       DUMB:='2 Minute timeout!  Sorry!';
       bconout(Car,13);
       For KL:=1 to ord(DUMB[0]) do Begin
         bconout(Car,ord(DUMB[KL]));
         TKILL:=True
        End;
       bconout(Car,13)
      End;
     If (T&2<>0) or (TKILL) then Begin
       OVER:=True;CAR:=2;
       If TKILL=True then Writeln('TIME-OUT LOGOFF');
       If TKILL=False then Writeln('LOSS OF CARRIER -- PROGRAM TERMINATED!');
     If ISITOK=True then Begin
      End;
        HALT;
      End
    End
   End;
(**************************************************************************)
  Procedure Mriteln(INFO:FIXEDONE);
    Var
      CC,KAT:Integer;
      KERI:Str255;
    Begin
     If SOFF=False then Begin
      CC:=0;
      For CC:=1 to ord(INFO[0]) do Begin
        COMP1:=Clock;
        CARRIER;
        If bconstat(CAR) then Begin
          If bconin(CAR)=3 then Begin
          If ABLE=True then Mriteln('');If ABLE=True then Mriteln('^C');
          If ABLE=True then SOFF:=True;
         End
        End;
        If bconstat(2) then Begin
         KAT:=bconin(2);KERI:=' ';
          KERI[1]:=Chr(KAT);UPCASE(KERI);
          End;
        If (CAR=1) and (SOFF=False) then bconout(1,ord(INFO[CC]));
        If (TOFF=False) and (SOFF=False) then bconout(2,ord(INFO[CC]))
      End;
    (*If SOFF=False then Write(Chr(27),'j',Chr(27),'H',Chr(27),'B');
      If SOFF=False then Write(Chr(27),'M',Chr(27),'k');*)
      If (CAR=1) and (SOFF=False) then bconout(1,13);If (CAR=1) and (SOFF=False)
        then bconout(1,10);
      If (TOFF=False) and (SOFF=False) then bconout(2,13);If (TOFF=False) and (SOFF=False)
        then bconout(2,10);
     End;
     If TOFF=True then Begin
       LIFECOUNT:=LIFECOUNT+1;
       If LIFECOUNT<53 then Write(LIFE1[LIFECOUNT]);
       If (LIFECOUNT<91) and (LIFECOUNT>52) then Write(LIFE2[LIFECOUNT-52]);
       If LIFECOUNT>90 then Write('.');
      End;
    End;
(**************************************************************************)
  Procedure Mrite(INFO:Str255);
    Var
      CC:Integer;
    Begin
      CC:=0;
      For CC:=1 to ord(INFO[0]) do Begin
        COMP1:=Clock;
        CARRIER;
        If bconstat(CAR) then Begin
          If (bconin(CAR)=3) then Begin
          If (ABLE=True) then Mriteln('');
          If (ABLE=True) and (VT=True) then bconout(1,27);
          If (ABLE=True) and (VT=True) then bconout(2,27);
          If (ABLE=True) and (VT=False) then Mriteln('^C');
          If (ABLE=True) and (VT=True) then Mriteln('b3^C');
          If ABLE=True then SOFF:=True;
         End
        End;
        If (CAR=1) and (SOFF=False) then bconout(1,ord(INFO[CC]));
        If (TOFF=False) and (SOFF=False) then bconout(2,ord(INFO[CC]))
      End;
    End;
(***** Special Meadln Routine *********************************************)
  Procedure MEADLN(Var THEDTUFF:Str255);
    Var
      SHEDTUFF:Str255;
      LAST:Char;
      J,D,T,TY,COUNTY,COUNTYS,NCOUNT,OCOUNT:Integer;
      DONT,DEL:Boolean;
    Begin
      J:=0;D:=0;T:=1;THEDTUFF:='';SHEDTUFF:='';LAST:=' ';TY:=50;COMP1:=Clock;COUNTY:=0;COUNTYS:=0;DEL:=False;
      AGAIN:=False;
      Repeat
        DONT:=False;
        If WRAPPER<>'' then Begin
          Mrite(WRAPPER);
          INSERT(WRAPPER,SHEDTUFF,1);
          J:=ord(WRAPPER[0]);
          WRAPPER:=''
         End;
      If WWRAP=False then WRAPPER:='';
        CARRIER;COUNTYS:=COUNTYS+1;
          If (TWISTY=True) and (COUNTYS=1000) then Begin
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('f');
          COUNTY:=COUNTY+1;
          If DEL=True then Mrite(Chr(8));
          DEL:=True;
          Case COUNTY of
           1:Begin
             If CAR=1 then bconout(1,124);
             bconout(2,124)
            End;
           2:Begin
             If CAR=1 then bconout(1,47);
             bconout(2,47)
            End;
           3:Begin
             If CAR=1 then bconout(1,45);
             bconout(2,45)
            End;
           4:Begin
             If CAR=1 then bconout(1,92);
             bconout(2,92)
            End;
          End;
          If COUNTY=4 then COUNTY:=0;COUNTYS:=0;
         End;
        If (bconstat(CAR)) or (bconstat(2)) then Begin(**)
          If (VT=True) and (CAR=1) then bconout(1,27);
          If (VT=True) and (CAR=1) then bconout(1,101);
          bconout(2,27);bconout(2,101);
          TWISTY:=False;
          If bconstat(CAR) then LAST:=Chr(bconin(CAR));COMP1:=Clock;
          If bconstat(2) then LAST:=Chr(bconin(2));(**)
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
          If (DONT=False) and (TOFF=False) then Write(LAST)
         End;(*This is the new one*)
        End
      Until (ord(LAST)=13) or (J=76);

      If (J=76) and (WWRAP=True) and (ord(SHEDTUFF[76])<>13) and
         (ord(SHEDTUFF[76])<>32) then Begin
           NCOUNT:=77;
           Repeat
             NCOUNT:=NCOUNT-1;
           Until ord(SHEDTUFF[NCOUNT])=32;
           If (76-NCOUNT)<15 then J:=NCOUNT;
           NCOUNT:=76-NCOUNT;
          If NCOUNT<15 then Begin
           For OCOUNT:=1 to NCOUNT do Begin
             If TOFF=False then bconout(2,8);
             If TOFF=False then bconout(2,ord(32));
             If TOFF=False then bconout(2,8);
             If CAR=1 then bconout(1,8);
             If CAR=1 then bconout(1,ord(32));
             If CAR=1 then bconout(1,8);
            End;
           T:=NCOUNT+1;
           WRAPPER:=SHEDTUFF;
           AGAIN:=True;
           DELETE(WRAPPER,1,J);
        End;
       End;
      DELETE(SHEDTUFF,J,T);
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
    COMP1:=Clock;
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
      If (WELL='Y') and (VT=False) then Mriteln ('Yes.');
      If (WELL='N') and (VT=False) then Mriteln ('No.');
      If (WELL='Y') and (VT=True) then Begin
        Mrite (Chr(27));
        Mrite ('b2Yes.');
        Mrite (Chr(27));
        Mriteln('b3')
       End;
      If (WELL='N') and (VT=True) then Begin
        Mrite(Chr(27));
        Mrite('b1No.');
        Mrite(Chr(27));
        Mriteln('b3')
       End;
    Until(WELL='Y') or (WELL='N')
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
  Procedure GOOEY(Var FIR:Str255;Var SEC:Integer);
    Var
      CCC:Integer;
    Begin
      FIR:='  ';
      If SEC<10 then Begin
        FIR[1]:='0';
        FIR[2]:=Chr(48+SEC);
       End;
      If (SEC>10) and (SEC<20) then Begin
        FIR[1]:='1';
        CCC:=SEC-10;
        FIR[2]:=Chr(48+CCC);
       End;
      If SEC>19 then Begin
        FIR:='2';
        CCC:=SEC-20;
        FIR[2]:=Chr(48+CCC);
       End;
     End;
(**** GET A CHARACTER *****************************************************)
  Procedure SOMETHING(Var WELL:Str255);
   Var
    dummy,event,what_key:integer;
    Key_Wait:Str255;
   Begin
     Key_wait[0]:=Chr(1);COMP1:=Clock;
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
      QUICK,CROOM:Integer;
      FSURE:Str255;
      SABLE,ROOM:Boolean;
    Begin
      SABLE:=False;ROOM:=False;
      If (ABLE=True) and (SOFF=True) then SABLE:=True;
      If SABLE=True then SOFF:=False;
      If (BLACK=True) and (CAR=2) then Begin
         Mriteln('');
         Mriteln('SysOp Function -> [A]dd user who left this message to the BlackList...');
        End;
      Mriteln('');COMP1:=Clock;
      If VT=False then Mrite ('Press <RETURN> to Continue.');
      If VT=True then Begin
        Mrite('Press ');
        Mrite(Chr(27));
        Mrite('c1<RETURN>');
        Mrite(Chr(27));
        Mrite('c4 to Continue.')
       End;
      Repeat
        Repeat
          CARRIER;
        Until (bconstat(1) or bconstat(2));
        If bconstat(1) then QUICK:=bconin(1);
        If bconstat(2) then QUICK:=bconin(2)
      Until (QUICK=13) or (((BLACK=True) and ((QUICK=65) or (QUICK=97))) and (CAR=2));
      Mriteln('');
      If ((QUICK=65) or (QUICK=97)) and (CAR=2) then Begin
        Writeln;
        For CROOM:=1 to 10 do
          If B_LIST[CROOM]='EMPTY' then ROOM:=True;
        If ROOM=False then Begin
          Writeln('There is no more room left in the BlackList!');
          BLACK:=False;STOP;BLACK:=True
         End;
        If ROOM=True then Begin
          CROOM:=0;
          Repeat
            CROOM:=CROOM+1
          Until B_LIST[CROOM]='EMPTY';
          Write('Are you SURE you want to add this user to the BlackList? ');
          WHAT(FSURE);
          If FSURE='Y' then Begin
            Writeln;
            B_LIST[CROOM]:=USERS[B_IT];
            WIPE_OUT(B_IT);
            Writeln('User''s account has been deleted and name added to the Blacklist!');
            Writeln;Writeln('User''s name stored in BlackList Record #',CROOM,'.');
            BLACK:=False;STOP;BLACK:=True
         End;
        End;
       End;
      SOFF:=SABLE
    End;
(**************************************************************************)
 Procedure ORACLE;
   Var
     DECI,JUNNK,THINGS,HUH:Str255;
     SOL:String[160];
     WHERE,APLACE,DCO:Integer;
     PICTURE:Text;
   Begin
    Repeat
     If VT=True then Mrite(Chr(27));
     If VT=True then Mrite('E');
     Mriteln('');
     Mrite('[');
     If VT then Mrite(Chr(27));
     If VT then Mrite('b1');
     Mrite('R');
     If VT then Mrite(Chr(27));
     If VT then Mrite('b3');
     Mriteln(']ead interpretation instructions. (Important!)');
     Mrite('[');
     If VT then Mrite(Chr(27));
     If VT then Mrite('b1');
     Mrite('C');
     If VT then Mrite(Chr(27));
     If VT then Mrite('b3');
     Mriteln(']onsult the Oracle of Insight!');
     Mriteln('');
     Mrite('[');
     If VT then Mrite(Chr(27));
     If VT then Mrite('b1');
     Mrite('L');
     If VT then Mrite(Chr(27));
     If VT then Mrite('b3');
     Mriteln(']eave.');
     Mriteln('');
     Mrite('Your decision? ');
     Repeat
       SOMETHING(DECI);
     Until (DECI='R') or (DECI='C') or (DECI='L');
     Case DECI[1] of
       'R':Mriteln('Read instructions...');
       'C':Mriteln('Consult with the Oracle!');
       'L':Mriteln('Leave...')
      End; {Case}
     Mriteln('');
     If DECI<>'L' then Begin
       If DECI='R' then Begin
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('E');
         RNAME('ORACLE.DOC');WHERE:=0;
         Reset(PICTURE,TCORRECT);
         While (not eof(PICTURE)) and (WHERE<100) do
           Begin
             WHERE:=WHERE+1;
             ABLE:=True;
             Readln (PICTURE,THINGS);
             Mriteln (THINGS);
             If WHERE=23 then Begin
             ABLE:=False;SOFF:=False;
               Mriteln('');
               If VT=True then Begin
                 Mrite(Chr(27));
                 Mrite('c1')
                End;
               Mrite('<RETURN>');
               If VT=True then Begin
                 Mrite(Chr(27));
                 Mrite('c4')
                End;
               Mrite(' to continue, ''S'' to stop reading.');
               Repeat
                 SOMETHING(HUH);
               Until (ord(HUH[1])=13) or (HUH='S');
               Mriteln('');
               If HUH='S' then WHERE:=101;
               If (VT) and (ord(HUH[1])=13) then Begin
                 Mrite(Chr(27));
                 Mrite('E')
                End;
               If (ord(HUH[1])=13) and (VT=False) then Mriteln('');
               If ord(HUH[1])=13 then WHERE:=0
              End;
           End;
         ABLE:=False;SOFF:=False;
         STOP
        End;
       If DECI='C' then Begin
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('E');
         ABLE:=True;
         Mriteln('');
         Mriteln('The Oracle awaits your arrival...  If  you  have not read the');
         Mriteln('interpretation  instructions  then  the  Oracle''s  reply  may');
         Mriteln('seem like nonsense.  Be sure to read the instructions so that');
         Mriteln('you know how to make sense of the reply...');
         If SOFF=False then STOP;
         ABLE:=False;SOFF:=False;
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('E');
         ABLE:=True;
         Mriteln('');
         Mriteln('You enter a peaceful shrine and approach the  altar.  An old');
         Mriteln('stone statue of an eye hovers in the midst of swirling  blue');
         Mriteln('smoke.  There is a sense of "all-knowing" in the area, as if');
         Mriteln('all that is true stems from this very place.');
         ABLE:=False;SOFF:=False;
         Mriteln('');
         Mriteln('The Oracle  softly  speaks, "Take  time to relax and focus your');
         Mriteln('thinking.  When you are ready, state  your question and through');
         Mriteln('the word provided you shall find the solution to your dilemma."');
         Mriteln('');
         Repeat
           Mrite('> ');
           Meadln(JUNNK);
         Until AGAIN=False;
         Mriteln('');
         Mriteln('The Oracle gazes into your present, past & future and contemplates');
         Mriteln('the key to your enlightenment...');Mriteln('');
         RNAME('ORACLE.DAT');
         Reset(PICTURE,TCORRECT);
         APLACE:=DRANDOM mod 35+1;
         For WHERE:=1 to APLACE do Readln(PICTURE);
         APLACE:=DRANDOM mod 11;
         Readln(PICTURE,SOL);
         ENCRYPT(SOL,False);
         Mrite('The Oracle speaks with great wisdom, "The solution is ');
         DCO:=0;
         While APLACE<>0 do Begin
           APLACE:=APLACE-1;
           Repeat
             DCO:=DCO+1;
           Until SOL[DCO]=Chr(32);
         End;
         Repeat
           DCO:=DCO+1;
           If SOL[DCO]<>' ' then Mrite(SOL[DCO]);
         Until (SOL[DCO]=' ') or (DCO=ord(SOL[0]));
         Mriteln('!!"');
         Mriteln('');
         Mriteln('"Seek the solution from that word, for your answer is connected with it,');
         Mriteln('find the hidden meaning..."');
         STOP
        End;
     End;
     Until DECI='L';
    End;
(**************************************************************************)
 Procedure BOOKSTORE;
   Var
     CATEGORY,LADEDA,INFORMA,OPT,TITLE,AUTHOR,PRICE,DESC,SSEL:String[160];
     COUNTIT,SELE,DUCOUNT,JOE:Integer;
     LOOKFOR,HAVEFOR:Text;
     NOMORE:Boolean;
   Begin
   ABLE:=True;
   Mriteln('Welcome to the on-line "self-help" bookstore.  Here you will find');
   Mriteln('over 100 inexpensive "how-to" and  self-improvement  books. There');
   Mriteln('is a lot  of  good  information  in  these  books,  and  I  added');
   Mriteln('this section so that people would have access to a  wide  variety');
   Mriteln('of self development publications.  You  will  find  many  popular');
   Mriteln('titles & other unique books.');
   If SOFF=False then STOP;
   ABLE:=False;SOFF:=False;
   OPT:='R';
   Repeat
   If OPT='R' then Begin
    RNAME('BOOKS.DAT');
    Reset(LOOKFOR,TCORRECT);
    Repeat
     Mriteln('');Mriteln('');
     If VT=True then Mrite(Chr(27));
     If VT=True then Mrite('E');
     COUNTIT:=1;
     ABLE:=True;
     Mriteln('Please select a category:');
     Mriteln('');
     Mriteln('1 - Astrology');
     Mriteln('2 - Business, Study, & Reference');
     Mriteln('3 - Health');
     Mriteln('4 - Hypnotism');
     Mriteln('5 - Marriage, Sex, & Parenthood');
     Mriteln('6 - Self-Help & Inspirational');
     Mriteln('7 - Sports');
     ABLE:=False;SOFF:=False;
     Mriteln('');
     Mrite('Enter your choice: ');
     Meadln(OPT);
    Until (OPT>'0') and (OPT<'8');
    Case OPT[1] of
      '1':CATEGORY:='ASTROLOGY';
      '2':CATEGORY:='BUSINESS, STUDY & REFERENCE';
      '3':CATEGORY:='HEALTH';
      '4':CATEGORY:='HYPNOTISM';
      '5':CATEGORY:='MARRIAGE, SEX, & PARENTHOOD';
      '6':CATEGORY:='SELF-HELP & INSPIRATIONAL';
      '7':CATEGORY:='SPORTS'
     End; {Case}
    Mriteln('');
    Mriteln('One moment please...');
    Repeat
      Readln(LOOKFOR,INFORMA)
    Until INFORMA=CATEGORY;
    Mriteln('');
    If VT=True then Mrite(Chr(27));
    If VT=True then Mrite('E');
    End;
    Repeat
      NOMORE:=False;
      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('E');
      ABLE:=True;
      For COUNTIT:=COUNTIT to (COUNTIT+9) do Begin
        If NOMORE=False then Begin
           Readln(LOOKFOR,LADEDA);
           If LADEDA='@' then NOMORE:=True;
           If LADEDA<>'@' then Begin
             Send_Num(COUNTIT);
             Mrite(' - ');ENCRYPT(LADEDA,False);
             Mrite(LADEDA);
             Readln(LOOKFOR,LADEDA);
             Readln(LOOKFOR,LADEDA);
             Readln(LOOKFOR,LADEDA);
             If LADEDA<>'!' then Begin
               Mrite(' [');
               If VT then Mrite(Chr(27));
               If VT then Mrite('b2');
               Mrite('*');
               If VT then Mrite(Chr(27));
               If VT then Mrite('b3');
               Mrite(']');
              End;
             Mriteln('');
             If LADEDA<>'!' then Repeat
               Readln(LOOKFOR,LADEDA);
              Until LADEDA='!';
           End;
        End;
       End;
       ABLE:=False;SOFF:=False;
       Mriteln('');
       Mrite('[');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b2');
       Mrite('*');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b3');
       Mriteln('] = Review available.');
       Mriteln('');
       Mrite('[');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b1');
       Mrite('R');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b3');
       Mrite(']eturn subject menu.  [');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b1');
       Mrite('G');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b3');
       Mriteln(']oto first page.');
       Mriteln('');
       Mrite('Your choice or <Return> to view ');
       If NOMORE=False then Mrite('next');
       If NOMORE=True then Mrite('first');
       Mrite(' page ([');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b1');
       Mrite('L');
       If VT then Mrite(Chr(27));
       If VT then Mrite('b3');
       Mrite(']eave): ');
       Meadln(OPT);UPCASE(OPT);
       Mriteln('');
       JOE:=COUNTIT;
       If (OPT<>'') and (OPT<>'G') and (OPT<>'R') then COUNTIT:=COUNTIT-10;
       If (OPT<>'') and (OPT<>'G') and (OPT<>'R') and (OPT<>'L') then Begin
          BUGPROOF(OPT,SELE);
          If SELE<=JOE then Begin
           Mriteln('One moment please...');
           Reset(LOOKFOR,TCORRECT);
           Repeat
             Readln(LOOKFOR,INFORMA)
           Until INFORMA=CATEGORY;
         For DUCOUNT:=1 to (SELE-1) do Begin
           Readln(LOOKFOR,LADEDA);
           Readln(LOOKFOR,LADEDA);
           Readln(LOOKFOR,LADEDA);
           If LADEDA<>'!' then Repeat
             Readln(LOOKFOR,LADEDA);
            Until LADEDA='!';
          End;
          Readln(LOOKFOR,TITLE);Readln(LOOKFOR,AUTHOR);
          Readln(LOOKFOR,PRICE);ENCRYPT(TITLE,False);ENCRYPT(AUTHOR,False);
          ENCRYPT(PRICE,False);
          ABLE:=True;
          Mriteln('');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('E');
          Mriteln('');Mriteln('');
          Mrite(' Title:  ');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b4');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('c3');
          Mriteln(TITLE);
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('b3');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('c4');
          Mriteln('');
          Mrite('Author:  ');Mrite(AUTHOR);
          Mrite('        Price: ');
          Mriteln(PRICE);
          Mriteln('');
          DESC:='';
          While DESC<>'!' do Begin
            Readln(LOOKFOR,DESC);
            If DESC<>'!' then Begin
              ENCRYPT(DESC,False);
              Mriteln(DESC);
             End;
           End;
          ABLE:=False;SOFF:=False;
          Mriteln('');
          Mriteln('Press "O" for ordering information/instructions.');
          Mriteln('');
          Mrite('[');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('c1');
          Mrite('O');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('c4');
          Mrite(']rder info, or ');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('c1');
          Mrite('<RETURN>');
          If VT=True then Mrite(Chr(27));
          If VT=True then Mrite('c4');
          Mrite(' to return to menu: ');
          Repeat
            SOMETHING(SSEL);
          Until (ord(SSEL[1])=13) or (SSEL='O');
          If SSEL<>'O' then Mriteln('');
          If SSEL='O' then Begin
            Mriteln('Order Information...');
            Mriteln('');
            Mriteln('');
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('E');
            Mrite('    ---===({{');
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('b4');
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('c3');
            Mrite('  How to place an order for your book(s)  ');
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('b3');
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('c4');
            Mriteln('}})===---');
            Mriteln('');
            Mriteln('Ordering  from the Bookstore is easy!  On a piece of paper write');
            Mriteln('the following  information  for  the  book(s) you wish to order:');
            Mriteln('Book  Title,  Author  Name,  and Price.  Be sure to include your');
            Mriteln('full  mailing  address.  All  orders will be processed within 24');
            Mriteln('hrs. from the time receieved.');
            Mriteln('');
            Mriteln('Please add $1.50 postage for the first book and $.50 for each');
            Mriteln('additional book.');
            Mriteln('');
            Mriteln('  Send order with your check or money order to:');
            Mriteln('');
            Mriteln('                                MountainLine Enterprises');
            Mriteln('                                     P.O.  Box 1192');
            Mriteln('                                    Orem, UT   84059');
            Mriteln('');
            Mriteln('   * All publications come with a 30-day Money-Back Guarantee *');
            STOP
           End;
          Mriteln('');
          Mriteln('Please Wait...');
          Reset(LOOKFOR,TCORRECT);
          Repeat
            Readln(LOOKFOR,INFORMA)
          Until INFORMA=CATEGORY;
          For DUCOUNT:=1 to (COUNTIT-1) do Begin
            Readln(LOOKFOR,LADEDA);
            Readln(LOOKFOR,LADEDA);
            Readln(LOOKFOR,LADEDA);
            If LADEDA<>'!' then Repeat
              Readln(LOOKFOR,LADEDA);
             Until LADEDA='!';
           End;
          Mriteln('');
          End;
         End;
       If ((OPT='') and (NOMORE=True)) or (OPT='G') then Begin
           COUNTIT:=1;
           NOMORE:=False;
           Mriteln('One moment please...');
           Reset(LOOKFOR,TCORRECT);
           Repeat
             Readln(LOOKFOR,INFORMA)
           Until INFORMA=CATEGORY;
           Mriteln('');
         End;
    Until (OPT[1]='L') or (OPT[1]='R');
   Until OPT[1]='L';
   End;
(**************************************************************************)
 Procedure PNEW;
   Var
     SURE:Str255;
     COUNT1,COUNT2,COUNT3:Integer;
     DONE:Boolean;
   Begin
     Mriteln('');
     Mriteln('I see you are new here!');
     Mriteln('');
     Mriteln('   If you have not yet read the instructions I would suggest  that  you  do');
     Mriteln('so  as  soon  as  possible.  Welcome  to "The Advice Door"!!!!!  This  door');
     Mriteln('could prove to be a valuable tool for you in your life and problem  solving');
     Mriteln('approaches. You should know that complete anonymity is  assured,  your name');
     Mriteln('will NEVER be shown to another user.  The files are  all encrypted, and the');
     Mriteln('SysOp is not able to watch you while you are  in this  door, feel  free  to');
     Mriteln('share your inner feelings.  When answering other users'' questions,  try  to');
     Mriteln('listen with understanding and empathy, you will  be required to  answer all');
     Mriteln('questions, and likewise they will be required  to  answer yours (even if it');
     Mriteln('is simply a short "good luck" or "I understand" message).');
     Mriteln('');
     Mriteln(' You will never be required to answer more than 5 questions at a time...');
     Mriteln('');
     Mriteln('NOTE: This door is for serious matters, "joking around" or  poking fun  at');
     Mriteln('others is not only immature but highly disrespectful.  Reply as though you');
     Mriteln('have the same problem.  By answering  "Yes" to the following  question you');
     Mriteln('are expected to act like an adult and responsibly.  This door is NOT to be');
     Mriteln('abused!');
     Mriteln('');
     Mriteln('If you don''t have a question in mind, please don''t join yet...');
     Mriteln('');
     Mrite('Would you like to join the Advice Community at this time? ');
     WHAT(SURE);
     If SURE='N' then Begin
        Mriteln('');Mriteln('Please return whenever you are ready...');
        HALT
       End;
     If SURE='Y' then Begin
       COUNT1:=1;DONE:=False;
       Repeat
        If USERS[COUNT1]='EMPTY' then DONE:=True;
        COUNT1:=COUNT1+1;
       Until (COUNT1=26) or (DONE=True);
       If DONE=True then COUNT1:=COUNT1-1;
       If (COUNT1=26) and (DONE=False) then Begin
         Mriteln('');Mriteln('I''m sorry, but there is currently so space available for new users...');
         Mriteln('');Mriteln('Please try again later...');
         STOP;HALT
        End;
       If (COUNT1<26) and (DONE=True) then Begin
         USERS[COUNT1]:=BBSNAME;NUM:=COUNT1;
         Mriteln('');GONEIN:=True;
         Mriteln('Welcome to The Advice Door!  I hope  you find your experience');
         Mriteln('positive &  insightful...  If you hang up while in the Advice');
         Mriteln('Door, or time  out, then none  of  your  activity  (including');
         Mriteln('messages entered) will be saved.  So be sure to exit properly.');
         Mriteln('');
         Mriteln('The SysOp has the power to take away anyone''s access to this');
         Mriteln('door who does not respect other users, or abuses this door in');
         Mriteln('any way...');
         For COUNT1:=1 to 25 do 
           USERI[COUNT1,NUM]:=1;
         STOP
        End;
     End;
    End;
(**************************************************************************)
 Procedure LOC;
  Var
    A,B,C,FLIP,ROOMC,COUNT,COUNT2,COUNT3,JJJ,WHERE:Integer;
    SURE,FIRST,MINE,HUH,THINGS:Str255;
    ANGELS:String[160];
    ONE,FDNAME,PICTURE:Text;
    AFTER,GIN:Boolean;
  Begin
    IO_CHECK(False);AFTER:=False;MAKE_DATE;GIN:=False;
    Reset (ONE,'ADVICE.SET');
    A:=IO_Result;
    If (A=-33) or (A=-34) then Begin
     Mriteln('');Mriteln('I could''nt find ADVICE.SET.  Please notify the SysOp...');
     STOP;HALT
    End;
    IO_CHECK(True);
    Readln(ONE,PATH);
    Readln(ONE,TODAY);
    Readln(ONE,ANGEL);
    Readln(ONE,BBS);
    If not eof(ONE) then Readln(ONE,FPATH);
    Close(ONE);
    If TODAY<LDATE then AFTER:=True;
    Mriteln('');
    Mrite('Are you using VT-52 Emulation? ');
    WHAT(SURE);
    If SURE='Y' then VT:=True;
    Write(Chr(27),'v');
    If VT=True then Mrite(Chr(27));
    If VT=True then Mrite('v');
    If VT=True then Mrite(Chr(27));
    If VT=True then Mrite('E');
    ABLE:=True;
    Mriteln('');
    Mriteln('            Welcome to...');
    Mriteln('');
    Mriteln('                                T  H  E');
    Mriteln('                        |\');
    Mriteln('                        | \ _______________');
    Mriteln('                        |  |               |');
    Mrite('                        |  |  ');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b2');
    Mrite('A D V I C E');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b3');
    Mriteln('  |');
    Mriteln('                        |  |               |');
    Mrite('                        |  |    ');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b2');
    Mrite('D O O R');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b3');
    Mriteln('    |');
    Mriteln('                        |  |               |');
    Mriteln('                        |o |      b y      |');
    Mriteln('                        |  |               |');
    Mriteln('                        |  | Paul J. Witte |');
    Mriteln('                        |  |               |');
    Mrite('                        |  |');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b1');
    Mrite('Mythyn Software');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b3');
    Mriteln('|');
    Mriteln('                        |  |_______________|');
    Mriteln('                        | /');
    Mrite('                        |/    ');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b4');
    If VT then Mrite(Chr(27));
    If VT then Mrite('c3');
    Mriteln('Version 2.5');
    If VT then Mrite(Chr(27));
    If VT then Mrite('b3');
    If VT then Mrite(Chr(27));
    If VT then Mrite('c4');
    Mriteln('');
    Mriteln('                         "Users helping Users"');
    ABLE:=False;SOFF:=False;
    Mriteln('');Mrite('Would you like to read the Instructions? ');
    WHAT(SURE);
    If SURE='Y' then Begin

    If VT=True then Mrite(Chr(27));
    If VT=True then Mrite('E');
    RNAME('ADVICE.DOC');WHERE:=0;
    Reset(PICTURE,TCORRECT);
    While (not eof(PICTURE)) and (WHERE<100) do
      Begin
        WHERE:=WHERE+1;
        ABLE:=True;
        Readln (PICTURE,THINGS);
        Mriteln (THINGS);
        If WHERE=23 then Begin
        ABLE:=False;SOFF:=False;
          Mriteln('');
          If VT=True then Begin
            Mrite(Chr(27));
            Mrite('c1')
           End;
          Mrite('<RETURN>');
          If VT=True then Begin
            Mrite(Chr(27));
            Mrite('c4')
           End;
          Mrite(' to continue, ''S'' to stop reading.');
          Repeat
            SOMETHING(HUH);
          Until (ord(HUH[1])=13) or (HUH='S');
          Mriteln('');
          If HUH='S' then WHERE:=101;
          If (VT) and (ord(HUH[1])=13) then Begin
            Mrite(Chr(27));
            Mrite('E')
           End;
          If (ord(HUH[1])=13) and (VT=False) then Mriteln('');
          If ord(HUH[1])=13 then WHERE:=0
         End;
      End;
     ABLE:=False;SOFF:=False;
     STOP
    End;

    Mriteln('');Mrite('Getting today''s Angel Card');
    If AFTER=True then ANGEL:=ANGEL+1;
    If ANGEL=0 then ANGEL:=1;
    If ANGEL=53 then ANGEL:=1;
    RNAME('ADVICE.DAT');
    Reset(ONE,TCORRECT);
    For A:=1 to 10 do Readln(ONE,B_LIST[A]);
    For A:=1 to 25 do Readln(ONE,INACTIVITY[A]);
    For A:=1 to 25 do Readln(ONE,USERS[A]);
    GETEMGONE(False);
    For A:=1 to 25 do Begin
      Mrite('.');
      For B:=1 to 50 do Readln(ONE,USERI[A,B]);
     End;
    Close(ONE);ISITOK:=True;
    RNAME('ANGELS.DAT');
    Reset(ONE,TCORRECT);
    C:=0;
    Repeat
      C:=C+1;
      Readln(ONE,ANGELS)
    Until (C=ANGEL);
    Mriteln('');Mriteln('');
    Mrite('Today''s Angel is "');
    ENCRYPT(ANGELS,False);
    Mrite(ANGELS);
    Mriteln('".  Open your heart and mind and allow the');
    Mriteln('special energies of this angel to connect with you.  Breathe them');
    Mriteln('into your body, mind & feelings...');
    STOP;
    If CAR=1 then Begin
      TOFF:=True;
      Writeln;
      Writeln('Someone is using the "Advice Door", the sysop is not allowed to watch...');
      Writeln;
      Mriteln('');Mriteln('The SysOp is now prevented from watching, to assure anonymity...');
      STOP
     End;
    If (BBS='EXPRESS') and (CAR=1) then Begin
     BN2:=BBSNAME;
     If TELLME<>'LOCAL' then BBSNAME:=TELLME;
     INSERT(BBSNAME,BN2,(ord(BN2[0])+1))
    End;
    If BBS='FOREM' then Begin
      IO_CHECK(False);
      Reset(ONE,FPATH);
      A:=IO_Result;
      If (A=-33) or (A=-34) then Begin
        Mriteln('');Mriteln('System is set to work with FOREM BBS Software, but I could not');
        Mriteln('find the DORINFO1.DEF file, which must be set on line 5 of ADVICE.SET...');
        Mriteln('Please let the sysop know about this...');
        STOP;HALT
       End;
      IO_CHECK(True);
      For A:=1 to 6 do Readln(ONE,FIRST);
      Readln(ONE,FIRST);
      Readln(ONE,BBSNAME);
      INSERT(FIRST,BBSNAME,(ord(BBSNAME[0])+1))
     End;
    For ROOMC:=1 to 10 do Begin
      If BBSNAME=B_LIST[ROOMC] then Begin
        Mriteln('');
        Mriteln('Due to abuse of this Door the SysOp has added you to the Blacklist...');
        Mriteln('');
        Mriteln('Returning to the BBS...');
        Mriteln('');
        HALT
      End;
     End;
    If AFTER=True then Begin
     TODAY:=LDATE;
     For FLIP:=1 to 25 do Begin
      If ((TODAY-INACTIVITY[FLIP])>10) and (USERS[FLIP]<>'EMPTY') then WIPE_OUT(FLIP)
     End;
     Rewrite(ONE,'ADVICE.SET');
     Writeln(ONE,PATH);
     Writeln(ONE,TODAY);
     Writeln(ONE,ANGEL);
     Writeln(ONE,BBS);
     If FPATH<>'' then Writeln(ONE,FPATH);
     Close(ONE);
    End;
    MINE:='USER_ ';MINE[6]:=Chr(64+1);
    IO_CHECK(False);RNAME(MINE);
    Reset (ONE,TCORRECT);
    A:=IO_Result;
    If (A=-33) or (A=-34) then Begin
      Mriteln('');Mrite('Must be the first time!  Initializing system');PIS:=True;
      For COUNT:=1 to 25 do
        INACTIVITY[COUNT]:=0;
      For COUNT:=1 to 25 do
        USERS[COUNT]:='EMPTY';
      For COUNT:=1 to 25 do
        For COUNT2:=1 to 50 do
          USERI[COUNT,COUNT2]:=0;
      For COUNT:=1 to 25 do Begin
         MINE[6]:=Chr(64+COUNT);Mrite('.');
        RNAME(MINE); 
        Rewrite(FDNAME,TCORRECT);
         For JJJ:=1 to 20 do
           Writeln(FDNAME);
         For COUNT2:=1 to 25 do Begin
           If COUNT2<>COUNT then Begin
             Writeln(FDNAME,Chr(COUNT2+64));
             For COUNT3:=1 to 20 do
                Writeln(FDNAME);
          End;
         End;
        End;
      Mriteln('');
     End;
    IO_CHECK(True);
    If PIS=True then SAVEINFO;PIS:=False;
    For A:=1 to 25 do Begin
     If GIN=False then Begin
      If USERS[A]=BBSNAME then GIN:=True;
      If GIN=True then NUM:=A;
     End;
    End;
    If GIN=False then PNEW;
    INACTIVITY[NUM]:=TODAY;
    MINE[6]:=Chr(64+NUM);
    RNAME(MINE);
    Reset(ONE,TCORRECT);
    Mriteln('');Mriteln('One Moment...');
    For COUNT:=1 to 524 do
      Readln(ONE,U_STUFF[COUNT]);
  End;
(**************************************************************************)
  Procedure M_DISPLAY(IDENTITY:Integer;MODE:Integer);
    Var
      COUNT,COUNT2,COUNT3:Integer;
      FDNAME:Text;
      FTD,THEM,STUFF,MINE:Str255;
    Begin
      FTD:='';THEM:='';MINE:='USER_ ';MINE[6]:=Chr(IDENTITY+64);
      ABLE:=True;
      Mriteln('');
      Mriteln('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*');
      If MODE=1 then Begin
         Mrite('|                          ');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('Your Current Question');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('                          |');
       End;
      If MODE=2 then Begin
         Mrite('|                      ');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('Another user seeks your Help!');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('                      |');
       End;
      If MODE=3 then Begin
        Mrite('|                      ');
        If VT then Mrite(Chr(27));
        If VT then Mrite('b2');
        Mrite('Your Messages to other Users!');
        If VT then Mrite(Chr(27));
        If VT then Mrite('b3');
        Mriteln('                      |');
       End;
      If MODE=4 then Begin
        Mrite('|                 ');
        If VT then Mrite(Chr(27));
        If VT then Mrite('b2');
        Mrite('Yet another user extends their hand....');
        If VT then Mrite(Chr(27));
        If VT then Mrite('b3');
        Mriteln('                 |');
       End;
      Mriteln('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*');
      ABLE:=False;SOFF:=False;
      Mriteln('');
      If MODE=1 then Begin
        For COUNT:=1 to 20 do
          If U_STUFF[COUNT]<>'' then Mriteln(U_STUFF[COUNT]);
        End;
      If MODE=2 then Begin
        FTD:=MINE;
        RNAME(FTD);
        RESET(FDNAME,TCORRECT);
        For COUNT:=1 to 20 do Begin
          Readln(FDNAME,STUFF);
          If STUFF<>'' then Mriteln(STUFF)
        End;
       End;
      If MODE=3 then Begin
        COUNT:=0;
        Repeat
          COUNT:=COUNT+1;
        Until U_STUFF[COUNT]=Chr(IDENTITY+64);
        For COUNT2:=1 to 20 do Begin
          COUNT:=COUNT+1;
          If U_STUFF[COUNT]<>'' then Mriteln(U_STUFF[COUNT]);
        End;
       End;
      If MODE=4 then Begin
        FTD:=MINE;
        RNAME(FTD);
        RESET(FDNAME,TCORRECT);
        Repeat
          Readln(FDNAME,STUFF);
        Until STUFF=Chr(NUM+64);
        For COUNT:=1 to 20 do Begin
          Readln(FDNAME,STUFF);
          If STUFF<>'' then Mriteln(STUFF);
        End;
       End;
       If (CAR=2) and (MODE=2) or (MODE=4) then BLACK:=True;
       B_IT:=IDENTITY;
      STOP;
      BLACK:=False
     End;
(**************************************************************************)
  Procedure M_EDITOR(LINES:Integer;IDENTITY:Integer;MODE:Integer);
    Var
      MSG:Array[1..20] of Str255;
      OONE:Text;
      LINEON,COUNT,ISURE,CCOUNT,JJJ:Integer;
      INFO,CHOICE,SURE,JOE,FTD,THEM,MINE:Str255;
      DONE,DONT:Boolean;
    Begin
      FTD:='';THEM:='';
      GOOEY(THEM,IDENTITY);
      If (MODE=1) or (MODE=2) then INSERT('QU_',FTD,1);
      If (MODE=3) or (MODE=4) then INSERT('AD_',FTD,1);
      INSERT(THEM,FTD,4);
      GOOEY(THEM,NUM);
      INSERT(THEM,FTD,6);
      DONT:=False;
      For COUNT:=1 to 20 do
        MSG[COUNT]:='';
      LINEON:=1;DONE:=False;
      Mriteln('');Mrite('Enter your message, up to ');
      Send_Num(LINES);
      Mriteln(' lines, a blank line when finished...');Mriteln('');
      While (LINEON<=LINES) or (DONE=False) do Begin
       If (DONT=False) and (CHOICE<>'E') and (CHOICE<>'L') then Begin
        If LINEON=LINES then WWRAP:=False;
        Send_Num(LINEON);
        Mrite(')');
        If LINEON<10 then Mrite(' ');
        Meadln(INFO);
        If INFO<>'' then MSG[LINEON]:=INFO;
        If LINEON=LINES then WWRAP:=True
       End;
        If (INFO='') or (LINEON=LINES) then Begin
          If LINEON=LINES then DONT:=True;
          Mriteln('');
          Mrite('[');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b1');
          Mrite('A');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b3');
          Mrite(']bort (Clear) message, [');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b1');
          Mrite('E');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b3');
          Mrite(']dit a line, [');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b1');
          Mrite('L');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b3');
          Mrite(']ist, [');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b1');
          Mrite('S');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b3');
          Mrite(']ave, [');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b1');
          Mrite('C');
          If VT then Mrite(Chr(27));
          If VT then Mrite('b3');
          Mrite(']ontinue: ');
          Repeat
            SOMETHING(CHOICE);
          Until (CHOICE='A') or (CHOICE='E') or (CHOICE='S') or (CHOICE='C') or (CHOICE='L');
          Case CHOICE[1] of
            'A':Begin
                  Mriteln('Abort...');
                  Mriteln('');Mrite('Clear Message, are you sure? ');
                  WHAT(SURE);
                  If SURE='N' then Mriteln('');
                  If SURE='Y' then Begin
                    Mriteln('');
                    For COUNT:=1 to LINES do
                      MSG[COUNT]:='';
                     If LINEON<>LINES then LINEON:=1;
                     If LINEON=LINES then LINEON:=0;
                     DONT:=False
                    End;
                  End;
            'E':Begin
                  WWRAP:=False;
                  Mriteln('Edit...');
              If LINEON-1>0 then Begin
                 Repeat
                  If LINEON=LINES then LINEON:=LINES+1;
                  Mriteln('');
                  Mrite('Edit which line? (1-');
                  Send_Num(LINEON-1);
                  Mrite('): ');
                  Meadln(SURE);
                  BUGPROOF(SURE,ISURE)
                 Until (ISURE>0) and (ISURE<=(LINEON-1));
                 If LINEON=LINES+1 then LINEON:=LINES;
                 Mriteln('');
                 Send_Num(ISURE);
                 Mrite(': ');
                 Mriteln(MSG[ISURE]);
                 Send_Num(ISURE);
                 Mrite(')');
                 If ISURE<10 then Mrite(' ');
                 Meadln(JOE);
                 If JOE<>'' then MSG[ISURE]:=JOE;
                 If JOE='' then Mriteln('');
                 If JOE='' then Mriteln('Aborted!');
                End;
                 If LINEON-1=0 then Mriteln('');
                 If LINEON-1=0 then Mriteln('Message workspace is empty...');
                 Mriteln('');WWRAP:=True
                End;
            'S':Begin
                  Mriteln('Save...');
                  Mriteln('');Mrite('Save Message? ');
                  WHAT(SURE);
                  If SURE='N' then Mriteln('');
                  If SURE='Y' then Begin
                   Mriteln('');
                   If MSG[1]='' then Mriteln('You cannot save a blank message...');
                   If MSG[1]='' then Mriteln('');
                   If MSG[1]<>'' then Begin
                    If MODE=1 then Begin
                      For COUNT:=1 to 20 do
                        U_STUFF[COUNT]:=MSG[COUNT]
                     End;
                    If MODE=3 then Begin
                      COUNT:=0;
                      Repeat
                        COUNT:=COUNT+1;
                      Until U_STUFF[COUNT]=Chr(64+IDENTITY);
                      JJJ:=0;
                      Repeat
                        JJJ:=JJJ+1;COUNT:=COUNT+1;
                        U_STUFF[COUNT]:=MSG[JJJ]
                      Until JJJ=20;
                     End;
                    Mrite('Saved!');
                    DONE:=True;LINEON:=100;
                    Mriteln('');STOP
                   End;
                  End;
                 End;
            'C':Begin
                  Mriteln('Continue...');
                  Mriteln('');
                  If MSG[LINES]<>'' then Mriteln('Message is full!');
                 End;
            'L':Begin
                  Mriteln('List...');
                  Mriteln('');
                  ABLE:=True;
                  For COUNT:=1 to LINES do Begin
                   If MSG[COUNT]<>'' then Begin
                     Send_Num(COUNT);
                     Mrite(':');
                     If COUNT<10 then Mrite(' ');
                     Mriteln(MSG[COUNT])
                  End;
                 End;
                 ABLE:=False;SOFF:=False
                End;
           End; {Case}
         End;
          If (INFO<>'') and (LINEON<>LINES) then LINEON:=LINEON+1;
        End;
     End;
(**************************************************************************)
  Procedure MAINMENU;
    Var
      C1,C2,C3,SOME,ALREADY,IRE,TOUCH,INSPIRE,DENTER,DENTERDOUNT:Integer;
      SOUL:String[160];
      QUOTED:Text;
      CHOICE,KNOW,SRE:Str255;
    Begin
      If GONEIN=True then Begin
        Mriteln('');Mriteln('Enter a situation in your life that you would like the help and');
        Mriteln('insight of others to help resolve...');
        M_EDITOR(20,NUM,1);USERI[NUM,NUM]:=0
       End;
      SOME:=0;ALREADY:=0;
      For C1:=1 to 25 do
        If USERI[NUM,C1]=1 then SOME:=SOME+1;
      If SOME>0 then Begin
        Mriteln('');Mrite('You have ');If SOME>5 then SOME:=5;
        Send_Num(SOME);
        Mriteln(' question(s) to be answered, they are as follows...');
        STOP;
        For C1:=1 to 25 do
          If USERI[NUM,C1]=1 then Begin
            ALREADY:=ALREADY+1;
            If ALREADY<6 then Begin
              M_DISPLAY(C1,2);
              Mriteln('');Mriteln('Please enter your reply...');
              M_EDITOR(20,C1,3);
              USERI[NUM,C1]:=2;USERI[C1,25+NUM]:=1;
            End;
        End;
       End;
      SOME:=0;
      For C1:=26 to 50 do
        If USERI[NUM,C1]=1 then SOME:=SOME+1;
      If SOME>0 then Begin
        Mriteln('');Mrite('You have ');
        Send_Num(SOME);
        Mriteln(' answer(s) you have not read, they are as follows...');
        STOP;
        For C1:=26 to 50 do
          If USERI[NUM,C1]=1 then Begin
            M_DISPLAY(C1-25,4);
            USERI[NUM,C1]:=2
        End;
       End;
       Repeat
         If VT=True then Mrite(Chr(27));
         If VT=True then Mrite('E');
         ABLE:=True;
         Mriteln('');
         Mriteln('  T H E  A D V I C E  D O O R');
         Mriteln('  ===========================');
         Mriteln('');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('1');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Read letters from you.');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('2');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Read letters to you.');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('3');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Read your current question.');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('4');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Change your current question.');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('5');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Erase your account with Advice Door.');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('6');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Consult with the "Oracle of Insight!"');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('7');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Access the on-line "self-help" Bookstore!');
         Mriteln('');
         Mrite(' [');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b1');
         Mrite('8');
         If VT then Mrite(Chr(27));
         If VT then Mrite('b3');
         Mriteln('] Exit back to the BBS...');
         If CAR=2 then Begin
           Mrite(' [');
           If VT then Mrite(Chr(27));
           If VT then Mrite('b2');
           Mrite('R');
           If VT then Mrite(Chr(27));
           If VT then Mrite('b3');
           Mriteln(']emove user from Black List (must know record #).');
          End;
         Mriteln('');
         Mriteln('Note: New letters are displayed upon entering.');
         ABLE:=False;SOFF:=False;
         Mriteln('');
         Mrite('Your Choice: ');
         Repeat
           SOMETHING(CHOICE);
         Until (CHOICE='8') or (CHOICE='7') or (CHOICE='5') or (CHOICE='6')
               or (CHOICE='2') or (CHOICE='3') or (CHOICE='1') or (CHOICE='4')
               or (((CHOICE='R') or (CHOICE='r')) and (CAR=2));
         If (CHOICE='R') or (CHOICE='r') then Begin
            Mriteln('Delete from Black List...');
             Repeat
              Mriteln('');
              Mrite('Remove which user from Blacklist? (Record #1-10): ');
              Meadln(SRE);
              BUGPROOF(SRE,IRE);
             Until (IRE>0) and (IRE<11);
            If B_LIST[IRE]='EMPTY' then Begin
              Mriteln('');Writeln('Record #',IRE,' is empty!');
              STOP;
             End;
            If B_LIST[IRE]<>'EMPTY' then Begin
               Mriteln('');
               Write('Remove Record #',IRE,' from Blacklist? ');
               WHAT(KNOW);
               If KNOW='Y' then Begin
                 Mriteln('');
                 Writeln('Record #',IRE,' is no longer on the Blacklist!');
                 B_LIST[IRE]:='EMPTY';
                 STOP
              End;
             End;
           End;
         If CHOICE='6' then Begin
           Mrite('Visit the Oracle? ');
           WHAT(KNOW);
           Mriteln('');
           If KNOW='Y' then ORACLE;
          End;
         If CHOICE='7' then Begin
           Mrite('Visit the Bookstore? ');
           WHAT(KNOW);
           Mriteln('');
           If KNOW='Y' then BOOKSTORE;
          End;
         If CHOICE='5' then Begin
            Mrite('Erase your Account, are you SURE? ');
            WHAT(KNOW);
            If KNOW='N' then CHOICE:='J';
            If KNOW='Y' then Begin
            WIPE_OUT(NUM);
            Mriteln('');
            Mriteln('Done!  Thanks for using the "Advice Door", we hope to see you again');
            Mriteln('sometime soon!');
            STOP
           End;
          End;
         If CHOICE='4' then Begin
            Mriteln('If you change your question, ALL letters to you now will be');
            Mrite('             erased. Do it? ');
            WHAT(KNOW);
            If KNOW='Y' then Begin
              For C1:=1 to 25 do 
                USERI[C1,NUM]:=1;
              For C1:=26 to 50 do
                USERI[NUM,C1]:=0;
              Mriteln('');Mriteln('Enter a situation in your life that you would like the help and');
              Mriteln('insight of others to resolve...');
              M_EDITOR(20,NUM,1);USERI[NUM,NUM]:=0;
              Mriteln('');Mriteln('Your question has been changed!');
              STOP
            End;
           End;
         If CHOICE='1' then Begin
           SOME:=0;
           For C1:=1 to 25 do
            If USERI[NUM,C1]=2 then SOME:=SOME+1;
           If SOME=0 then Mriteln('You haven''t written any letters yet...');
           If SOME=0 then STOP;
           If SOME>0 then Begin
            Mrite('You have written ');
            Send_Num(SOME);
            Mrite(' letter(s), read them? ');
            WHAT(KNOW);
           If KNOW='Y' then Begin
              For C1:=1 to 25 do Begin
              ABLE:=True;
              If USERI[NUM,C1]=2 then M_DISPLAY(C1,3);
              ABLE:=False;SOFF:=False;
              End;
             End;
            End
           End;
         If CHOICE='3' then Begin
           Mrite('Read your question? ');
           WHAT(KNOW);
           If KNOW='Y' then Begin
             ABLE:=True;
             M_DISPLAY(NUM,1);
             ABLE:=False;SOFF:=False;
           End;
          End;
         If CHOICE='2' then Begin
            Mrite('Read your mail? ');
            WHAT(KNOW);
            If KNOW='Y' then Begin
              SOME:=0;
              For C1:=25 to 50 do
                If USERI[NUM,C1]=2 then SOME:=SOME+1;
              Mriteln('');
              If SOME=0 then Mriteln('You have no mail...');
              If SOME=0 then STOP;
              If SOME>0 then Begin
                Mrite('You have ');
                Send_Num(SOME);
                Mriteln(' letter(s), they are as follows...');
                STOP;
                For C1:=25 to 50 do
                  If USERI[NUM,C1]=2 then Begin
                    ABLE:=True;
                    M_DISPLAY(C1-25,4);
                    ABLE:=False;SOFF:=False
                 End;
             End;
            End;
           End;
         If CHOICE='8' then Begin
           Mrite('Are you ready to leave? ');
           WHAT(KNOW);
           If KNOW='N' then CHOICE:='N';
           If KNOW='Y' then Begin
            If VT=True then Mrite(Chr(27));
            If VT=True then Mrite('E');
            Mriteln('');
            Mrite('                          -*- ');
            If VT then Mrite(Chr(27));
            If VT then Mrite('c2');
            Mrite('Words of Inspiration');
            If VT then Mrite(Chr(27));
            If VT then Mrite('c4');
            Mriteln(' -*-');
            Mriteln('');
            RNAME('INSPIRE.DAT');Reset(QUOTED,TCORRECT);TOUCH:=0;
            INSPIRE:=DRANDOM mod 77;
            For TOUCH:=1 to INSPIRE do Begin
             Repeat
              Readln(QUOTED,SOUL);
             Until (SOUL='') or (ord(SOUL[0])<2);
             End;
            If VT then Mrite(Chr(27));
            If VT then Mrite('b1');
            Repeat
              Readln(QUOTED,SOUL);
              DENTER:=0;DENTER:=40-(ord(SOUL[0]) div 2);
              For DENTERDOUNT:=1 to DENTER do Mrite(' ');
              If (SOUL<>'') and (ord(SOUL[0])>1) then ENCRYPT(SOUL,False);
              If (SOUL<>'') and (ord(SOUL[0])>1) then Mriteln(SOUL);
            Until (SOUL='') or (ord(SOUL[0])<2);
            If VT then Mrite(Chr(27));
            If VT then Mrite('b3');
            ABLE:=True;
            Mriteln('');Mriteln('Thank you for  using The Advice Door!!  Visit  regularly  to  answer');
            Mriteln('users'' questions, and  read  responses  to your question!  If  you  are');
            Mriteln('inactive for 10 days then your account will be deleted automatically!');
            Mriteln('');
            If VT then Mrite(Chr(27));
            If VT then Mrite('c1');
            Mrite('NOTE:');
            If VT then Mrite(Chr(27));
            If VT then Mrite('c4');
            Mriteln('  If you have not received replies to your question for quite some time');
            Mriteln('       then it may be about time to change your question...');
            If SOFF=False then STOP;
            ABLE:=False;SOFF:=False;
            If TOFF=True then Writeln;
            TOFF:=False;
            Mriteln('');Mrite ('            -=/*     ');
            If VT then Mrite(Chr(27));
            If VT then Mrite('c3');
            If VT then Mrite(Chr(27));
            If VT then Mrite('b4');
            Mrite('A Mythyn Software Production');
            If VT then Mrite(Chr(27));
            If VT then Mrite('b3');
            If VT then Mrite(Chr(27));
            If VT then Mrite('c4');
            Mriteln('     *\=-')
           End;
          End;
       Until (CHOICE='8') or (CHOICE='5');
     End;
(**************************************************************************)
   Begin
     CAR:=1;VT:=False;WWRAP:=True;WRAPPER:='';ISITOK:=False;GONEIN:=False;SYVIEW:=False;
     BLACK:=False;PIS:=False;FPATH:='';LIFECOUNT:=0;
     Life1:='The past is dead, The future is imaginary, Happiness';
     Life2:=' can only be in the eternal NOW moment';
     Cmd_GetArg(1,TELLME);Cmd_GetArg(2,BBSNAME);
     Cmd_GetArg(3,BN2);
     UPCASE(TELLME);
     If TELLME='LOCAL' then CAR:=2;
     If TELLME='LOCAL' then INSERT(BBSNAME,BN2,(ord(BN2[0])+1))
     Else Car:=1;
     LOC;
     MAINMENU;
     Mriteln('');Mriteln('One Moment...');
     SAVEINFO;
     If CAR=1 then Writeln;
   End.
