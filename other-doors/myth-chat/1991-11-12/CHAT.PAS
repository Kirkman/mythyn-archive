Program CHAT;
 {$I auxsubs.pas}
  Type
    Str255=String[80];
    FIXEDONE=String[160];
  Var
    CAR,HOWM,CCCOUNT,COLOR:Integer;
    COMP1,TODAY,LDATE,TIC:Long_Integer;
    TELLME,INFORM:String[255];
    WRAPPER,PATH,BBS,BBSNAME,TCORRECT,THINGER,JUNKED:Str255;
    VT,ABLE,SOFF,TKILL,OVER,ISITOK,TOFF,TWISTY,WWRAP,GONEIN:Boolean;
    F1,F2:Text;
(**** TIME GET ************************************************************)
  Function Gettime:Long_Integer;
    GEMDOS($2c);
(**** MODEM - CHARACTER INPUT *********************************************)
  Function bconin(device:Integer):Integer;
    BIOS(2);
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
       DUMB:='2 Minute timeout!  Thanks for Playing!!';
       bconout(Car,13);
       For KL:=1 to 39 do Begin
         bconout(Car,ord(DUMB[KL]));
         TKILL:=True
        End;
       bconout(Car,13)
      End;
     If (T&2<>0) or (TKILL) then Begin
       OVER:=True;CAR:=2;
       If TKILL=True then Writeln('TIME-OUT LOGOFF');
       If TKILL=False then Writeln('LOSS OF CARRIER -- PROGRAM TERMINATED!');
       Rewrite(TEMPO,'ERROR.DAT');
       Writeln(TEMPO,T);
     If ISITOK=True then Begin
      (* SAVEINFO; *)
      End;
        HALT;
      End
    End
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
(*** TIME SET *************************************************************)
  Procedure TIME_SET(WHICH:Integer);
    Var
      X,Y,Z,Tm:Long_Integer;
      Neg:Boolean;
    Begin
      Tm:=Gettime;
      Neg:=Tm<0;
      Tm:=Tm+(32768*ord(neg));
      Z:=Tm mod 32;
      Y:=(Tm mod 2048) div 32;
      X:=(Tm div 2048)+(16*ord(neg));
      Z:=Z*2;
      If WHICH=2 then Begin
        Write(Chr(27),'c3',Chr(27),'b4 ');
        Write(X div 10,X mod 10,':',Y div 10,Y mod 10);
        Write(' ',Chr(27),'c4',Chr(27),'b',COLOR)
       End;
      If WHICH=1 then Begin
        Mrite(' ');Send_Num(X div 10);Send_Num(X mod 10);Mrite(':');Send_Num(Y div 10);
        Send_Num(Y mod 10);Mrite(' ')
        End;
     End;
(***** Special Meadln Routine *********************************************)
  Procedure MEADLN(Var THEDTUFF:Str255);
    Var
      SHEDTUFF:Str255;
      LAST:Char;
      J,D,T,TY,COUNTY,COUNTYS,NCOUNT,OCOUNT,SIDE:Integer;
      DONT,DEL,DID:Boolean;
    Begin
      J:=0;D:=0;T:=1;THEDTUFF:='';SHEDTUFF:='';LAST:=' ';TY:=50;COMP1:=Clock;COUNTY:=0;COUNTYS:=0;DEL:=False;
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
          TWISTY:=False;DID:=False;
          If (bconstat(CAR)) and (COLOR=1) then Begin
            SIDE:=1;
            DID:=True;
            LAST:=Chr(bconin(CAR));
          (*Write(Chr(27),'b2'); MONOCHROME*)
            COLOR:=2
           End;
          If (bconstat(2)) and (COLOR=2) then Begin
            SIDE:=2;
            DID:=True;
            LAST:=Chr(bconin(2));
          (*Write(Chr(27),'b1'); MONOCHROME*)
            COLOR:=1
           End;
          If (bconstat(CAR)) and (DID=False) then Begin
            SIDE:=1;
            LAST:=Chr(bconin(CAR));
           End;
          COMP1:=Clock;
          If (bconstat(2)) and (DID=False) then Begin
            SIDE:=2;
            LAST:=Chr(bconin(2));(**)
           End;
          If ord(LAST)=20 then Begin
             TOFF:=True;
             TIME_SET(SIDE);
             TOFF:=False
            End;
          If ord(LAST)=3 then Begin
            TOFF:=True;
            If SIDE=2 then Begin
               Write(Chr(27),'b4',Chr(27),'c3 ',((Clock-TIC) div 60),' Mins. ',Chr(27),'b',COLOR,Chr(27),'c4');
              End;
            If SIDE=1 then Begin
              Mrite(' ');
              Send_Num((Clock-TIC)div 60);
              Mrite(' Mins. ');
             End;
            TOFF:=False
           End;
          If ord(LAST)=27 then OVER:=True;
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
          If (DONT=False) and (CAR=1) then bconout(1,ord(LAST));
          If (DONT=False) and (TOFF=False) then Write(LAST)
         End;(*This is the new one*)
        End
      Until (ord(LAST)=13) or (J=79) or (OVER=True);

      If (J=79) and (WWRAP=True) and (ord(SHEDTUFF[79])<>13) and
         (ord(SHEDTUFF[79])<>32) then Begin
           NCOUNT:=80;
           Repeat
             NCOUNT:=NCOUNT-1;
           Until (ord(SHEDTUFF[NCOUNT])=32) or (NCOUNT<15);
           If (79-NCOUNT)<15 then J:=NCOUNT;
           NCOUNT:=79-NCOUNT;
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
           DELETE(WRAPPER,1,J);
        End;
       End;
      If OVER=False then DELETE(SHEDTUFF,J,T);
      If (ord(SHEDTUFF[1])=13) and (OVER=False) then Begin
       Write(Chr(27),'b3');
       Mrite('------------------------------------------------------------------------------');
       (*Writeln(F2,'------------------------------------------------------------------------------');*)
     (*Write(Chr(27),'b',COLOR); MONOCHROME*)
      End;
      Mriteln('');
     (* If CAR=1 then bconout(1,13);If CAR=1 then bconout(1,10);
      If TOFF=False then Writeln; *)
      THEDTUFF:=SHEDTUFF;
    End;
(**************************************************************************)
  Begin
  (*Mriteln('');
    Mrite('One moment...');
    Reset(F1,'C:\FOREM\TXT\CHATINFO');
    Rewrite(F2,'C:\FOREM\TXT\CHATSTUF');
    Repeat
      Readln(F1,JUNKED);
      Writeln(F2,JUNKED);
    Until eof(F1); *)
    CAR:=1;OVER:=False;WWRAP:=True;TOFF:=False;COLOR:=1;
    TIC:=Clock;
    Mriteln('');Mriteln('');
    Write(Chr(27),'E');Write(Chr(27),'v');
    Mriteln('');
    Mrite('        ');
    Write(Chr(27),'b4',Chr(27),'c3');
    Mriteln('[MYTH-CHAT Engaged! (by Paul Witte)]');
    Write(Chr(27),'b3',Chr(27),'c4');
    Mrite(' ');
    Write(Chr(27),'b4',Chr(27),'c3');
    Mriteln('(Ctrl-C Display time in Chat, Ctrl-T Current Time)');
    Write(Chr(27),'b3',Chr(27),'c4');
    Mriteln('');
    Mriteln('[ESC] to Exit...');
    Mriteln('');
  (*Write(Chr(27),'b1'); MONOCHROME*)
    Repeat
      Meadln(INFORM);
      (*If ord(INFORM[1])<>13 then Writeln(F2,INFORM);*)
    Until OVER=True;
    Write(Chr(27),'b3');
    Mriteln('');
    Mriteln('[Returning Control... (1990 Mythyn Software)]');
    Mriteln('');
    Mrite('One Moment...');
  (*Reset(F1,'C:\FOREM\TXT\CHATSTUF');
    Rewrite(F2,'C:\FOREM\TXT\CHATINFO');
    Repeat
      Readln(F1,JUNKED);
      Writeln(F2,JUNKED);
    Until eof(F1);
    Close(F1);Close(F2); *)
    Mriteln('');Mriteln('');
   End.

