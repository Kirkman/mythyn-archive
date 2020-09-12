Program MYTH_MIRROR;
 {$I auxsubs.pas}
  Type
    Str255=String[76];
    FIXEDONE=String[160];
  Var
    BORDERS:Array[1..20] of String[80];
    RESTRICT:Array[1..20] of String[80];
    WRAPPER,TCORRECT,THINGER,PATH,SURE:Str255;
    CALLIT,BBSNAME:String[80];
    AGAIN,CLOCAL:Boolean;
    COMP1:Long_Integer;
    A,CAR,TCBY,LENGTH,HIGHNUM:Integer;
    ONE:Text;
    ABLE,SOFF,TKILL,OVER,ISITOK,TOFF,TWISTY,WWRAP:Boolean;
(**** MODEM - CHARACTER INPUT *********************************************)
  Function bconin(device:Integer):Integer;
    BIOS(2);
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
      CC,KAT,OURS:Integer;
      KERI:Str255;
      DONES:Boolean;
    Begin
     If SOFF=False then Begin
      CC:=0;
      For CC:=1 to ord(INFO[0]) do Begin
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
          If ABLE=True then Mriteln('');
          If ABLE=True then Mriteln('^C');
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
       If ((Clock-COMP1)>10) and (CLOCAL=True) then HALT
     Until (Bconstat(CAR)) or (Bconstat(2));
     CLOCAL:=False;
     If Bconstat(CAR) then what_key:=bconin(CAR);
     If Bconstat(2) then what_Key:=bconin(2);
     Key_wait[1]:=chr(what_key);
      WELL:=Key_Wait;
      UPCASE(WELL);
      If WELL='Y' then Mriteln ('Yes.');
      If WELL='N' then Mriteln ('No.');
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
(**************************************************************************)
  Procedure LOC;
    Begin
      IO_CHECK(False);
      Reset (ONE,'MYTH.SET');
      A:=IO_Result;
      If (A=-33) or (A=-34) then Begin
       Mriteln('');Mriteln('I could''nt find MYTH.SET.  Please notify the SysOp...');
       HALT
      End;
      IO_CHECK(True);
      Readln(ONE,PATH);
      Readln(ONE,LENGTH);
      Readln(ONE,CALLIT);
      Readln(ONE,BBSNAME)
     End;
(**************************************************************************)
  Procedure CHECKIT(TLINE:Str255);
    Var
      C1,C2,C3,C4,CHECKER:Integer;
      MATCH:Boolean;
    Begin
      UPCASE(TLINE);MATCH:=False;
      For C1:=1 to 20 do Begin
         UPCASE(RESTRICT[C1]);
         If RESTRICT[C1]<>'' then Begin
            For C2:=1 to ord(TLINE[0]) do Begin
              C4:=C2;CHECKER:=0;
              For C3:=1 to (ord(RESTRICT[C1][0])) do Begin
                If (ord(RESTRICT[C1][0])<=ord(TLINE[0])) and
                   ((ord(TLINE[0])-C4)>=(ord(RESTRICT[C1][0]))) then Begin
                 If RESTRICT[C1][C3]=TLINE[C4] then CHECKER:=CHECKER+1;
                 C4:=C4+1
                End;
               End;
              If CHECKER=ord(RESTRICT[C1][0]) then MATCH:=True
             End;
      If MATCH then Begin
            Mriteln('');
            Mriteln('Your writing contains some "restricted language".  Aborting...');
            Mriteln('');
            HALT
         End
        End
       End
      End;
(**************************************************************************)
  Procedure VIEW;
    Var
      FNAME:Text;
      STUFF:String[80];
      DUMBTHING:Boolean;
      LCOUNTER,DCOUNT,LOWNUM,STARTAT:Integer;
    Begin
      LOWNUM:=HIGHNUM-(LENGTH-1);DUMBTHING:=False;
      If LOWNUM<1 then LOWNUM:=1;
      Mriteln('');
      Mrite(BBSNAME);
      Mriteln(' brings you:');
      Mriteln('');
      Mriteln('             MythMirror');
      Mriteln('        FoReM Graffiti Wall!');
      Mriteln('           by  Paul Witte');
      Mriteln('      (c) 1991 Mythyn Software');
      SURE:='N';
      If HIGHNUM>0 then Begin
        Mriteln('');Mrite('Quotes now range ');
        Send_Num(LOWNUM);Mrite('-');Send_Num(HIGHNUM);Mriteln('.');
        Mriteln('');Mrite('Would you like to read the ');
        Mrite(CALLIT);
        Mrite('? ');
        WHAT(SURE)
       End;
      If SURE='Y' then Begin
        Repeat
          Mriteln('');
          Mrite('Read beginning at what Quote #? [');
          Send_Num(LOWNUM);Mrite('-');Send_Num(HIGHNUM);
          Mrite('] (RETURN=first): ');
          Meadln(SURE);
          BUGPROOF(SURE,STARTAT)
        Until ((STARTAT>(LOWNUM-1)) and (STARTAT<(HIGHNUM+1))) or (SURE='');
        If SURE='' then STARTAT:=LOWNUM;
      (*If STARTAT=LOWNUM then DUMBTHING:=True;
        If STARTAT=(LOWNUM+1) then DUMBTHING:=True;
        If HIGHNUM>25 then DUMBTHING:=True;*)
        STARTAT:=STARTAT-(LOWNUM+1);
        Mriteln('');Mriteln(' [--> Ctrl-S to Pause  Ctrl-Q to Continue  Ctrl-C to Abort <--]');
        Mriteln('');
        ABLE:=True;
        RNAME('MYTH.DAT');
        Reset(FNAME,TCORRECT);
        LCOUNTER:=0;
        If (STARTAT-1)<1 then Readln(FNAME);
      (*If DUMBTHING=True then STARTAT:=STARTAT-1;*)
        STARTAT:=STARTAT+1;
        If not eof(FNAME) then Begin
            For DCOUNT:=1 to (*(STARTAT-1)*) STARTAT do Begin
              Repeat
                Readln(FNAME,STUFF)
              Until STUFF[1]=Chr(27);
           End
          End;
        Repeat
          Readln(FNAME,STUFF);
          If STUFF[1]<>Chr(27) then Mriteln(STUFF);
          If STUFF[1]<>Chr(27) then LCOUNTER:=LCOUNTER+1;
          If (LCOUNTER=23) and (not eof(FNAME)) then Begin
              Mrite('[Press any key to Continue]');
              SOMETHING(SURE);
              For DCOUNT:=1 to 27 do Begin
                  Mrite(Chr(8));
                  Mrite(' ');
                  Mrite(Chr(8))
                End;
              LCOUNTER:=0
            End
        Until (eof(FNAME)) or (SOFF=True);
        Mriteln('');Mrite('Last read Quote #');
        Send_Num(HIGHNUM);Mriteln('.');
        ABLE:=False;SOFF:=False;
       End;
      End;
(**************************************************************************)
  Procedure M_EDITOR(LINES:Integer);
    Var
      MSG:Array[1..5] of Str255;
      FNAME,SNAME:Text;
      LINEON,COUNT,ISURE,CCOUNT,JJJ,BORDERNUM,MYCOUNT,MYCOUNT2,SURE2,DUMBCOUNT,ACOUNT,ANCOUNT,TTHING:Integer;
      INFO,CHOICE,SURE,JOE,FTD,THEM,MINE,NAME:Str255;
      STUFF,STUFFF:String[80];
      SHORTEN:String[40];
      DONE,DONT,WEIRD:Boolean;
    Begin
      FTD:='';THEM:='';
      DONT:=False;
      For COUNT:=1 to 5 do
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
          Mrite('[A]bort (Clear) message, [E]dit a line, [L]ist, [S]ave, [C]ontinue: ');
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
                  Mrite('Abort Message? ');
                  WHAT(SURE);
                  If SURE='Y' then Begin
                    Mriteln('');HALT
                   End
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
                     Mriteln('');Mriteln('Select a border design:');
                     Mriteln('');
                     MYCOUNT:=0;
                     For MYCOUNT:=1 to 20 do Begin
                       Mrite('  [');Send_Num(MYCOUNT);Mrite(']');If MYCOUNT<10 then Mrite(' ');
                       Mrite(' - ');
                       For MYCOUNT2:=1 to 40 do Mrite(BORDERS[MYCOUNT][MYCOUNT2]);
                       Mriteln('')
                      End;
                       SURE2:=1;
                       Repeat
                         If SURE2<>1 then Mriteln('');
                         If SURE2<>1 then Mriteln('Input Error, enter a number 1-20.');
                         Mriteln('');
                         Mrite('Please enter your selection--> ');
                         Meadln(SURE);
                         BUGPROOF(SURE,SURE2)
                       Until (SURE2>0) and (SURE2<21);
                       Repeat
                        Repeat
                         Mriteln('');Mrite('What''s your Alias [25 Char. Max.]: ');
                         Meadln (NAME);
                         If ord(NAME[0])>25 then Mriteln ('25 Char. Maximum Please...');
                         If ord(NAME[0])<2 then Mriteln ('2 Char. Minimum Please...');
                        Until (ord(NAME[0])<26) and (ord(NAME[0])>1);
                        Mrite (NAME);
                        Mrite(' Correct [Y/N] ');
                        WHAT(SURE);
                       Until (SURE='Y');
                       For ACOUNT:=1 to 5 do
                         If MSG[ACOUNT]<>'' then CHECKIT(MSG[ACOUNT]);
                       CHECKIT(NAME);
                       Mriteln('');Mrite('One moment, now writing this stuff...');
                       RNAME('MYTH.DAT');
                       Reset(FNAME,TCORRECT);
                       RNAME('MYTH.BAK');
                       Rewrite(SNAME,TCORRECT);
                       STUFFF:='';WEIRD:=True;
                       DUMBCOUNT:=0;
                       Repeat
                         DUMBCOUNT:=DUMBCOUNT+1;
                         If not eof(FNAME) then Readln(FNAME,STUFF);
                         If (STUFF[1]=Chr(27)) and (not eof(FNAME)) then Readln(FNAME,STUFFF);
                         If STUFFF[1]=Chr(27) then WEIRD:=False
                       Until eof(FNAME);
                       Close(FNAME);
                       RNAME('MYTH.DAT');
                       Reset(FNAME,TCORRECT);
                       Readln(FNAME,STUFF);
                       Writeln(SNAME,STUFF);
                       MYCOUNT:=0;
                      If DUMBCOUNT<>1 then Begin
                       Repeat
                         MYCOUNT:=MYCOUNT+1;ANCOUNT:=0;
                           Repeat
                             ANCOUNT:=ANCOUNT+1;
                             Readln(FNAME,STUFF);
                             If (ANCOUNT=1) and (STUFF[1]=Chr(27)) then DUMBCOUNT:=DUMBCOUNT
                              Else Begin
                                If (WEIRD=False) and (MYCOUNT=1) then DUMBCOUNT:=DUMBCOUNT
                                Else Writeln(SNAME,STUFF)
                               End
                           Until STUFF[1]=Chr(27);
                       Until (eof(FNAME)) or (DUMBCOUNT=1);
                      End;
                       MYCOUNT2:=0;
                       Repeat
                         MYCOUNT2:=MYCOUNT2+1;
                         If MSG[MYCOUNT2]<>'' then Writeln(SNAME,MSG[MYCOUNT2]);
                       Until (MSG[MYCOUNT2]='') or (MYCOUNT2=5);
                       For MYCOUNT2:=1 to 54 do Write(SNAME,' ');
                       Writeln(SNAME,NAME);
                       Writeln(SNAME,BORDERS[SURE2]);
                       Writeln(SNAME,Chr(27));
                       If MYCOUNT>(LENGTH-2) then Writeln(SNAME,Chr(27));
                       Close(SNAME);Close(FNAME);
                       RNAME('MYTH.BAK');
                       Reset(FNAME,TCORRECT);
                       RNAME('MYTH.DAT');
                       Rewrite(SNAME,TCORRECT);
                       Readln(FNAME,TTHING);
                       TTHING:=TTHING+1;
                       Writeln(SNAME,TTHING);
                       Repeat
                         Readln(FNAME,STUFF);
                         Writeln(SNAME,STUFF)
                       Until eof(FNAME);
                    DONE:=True;LINEON:=100;
                    Mriteln('');
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
(**** Initialize any important variables **********************************)
  Procedure IAIV;
    Var
      A,B:Integer;
    Begin
      B:=0;
      For B:=1 to 20 do
        RESTRICT[B]:='';
      B:=0;
      RNAME('RESTRICT.DAT');
      IO_CHECK(False);
      Reset (ONE,TCORRECT);
      A:=IO_Result;
      IO_CHECK(True);
      If (A<>-33) and (A<>-34) then Begin
        While (not eof(ONE)) and (B<>20) do Begin
          B:=B+1;
          Readln(ONE,RESTRICT[B])
       End;
      End;
      BORDERS[1]:='*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*';
      BORDERS[2]:='<><><><><><><><><><><><><><><><><><><><*><><><><><><><><><><><><><><><><><><><>';
      BORDERS[3]:='//--\\||//--\\||//--\\||//--\\||//--\\|*|//--\\||//--\\||//--\\||//--\\||//--\\';
      BORDERS[4]:='(*))*((*))*((*))*((*))*((*))*((*))*((*<*>*((*))*((*))*((*))*((*))*((*))*((*))*(';
      BORDERS[5]:='()()()()()()()()()()()()()()()()()()()(*)()()()()()()()()()()()()()()()()()()()';
      BORDERS[6]:='][][][][][][][][][][][][][][][][][][][]|[][][][][][][][][][][][][][][][][][][][';
      BORDERS[7]:='*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*';
      BORDERS[8]:='=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=';
      BORDERS[9]:=')-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(-)-(';
      BORDERS[10]:='+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-';
      BORDERS[11]:='---===****************************>>>>>O<<<<<****************************===---';
      BORDERS[12]:='[/][\][/][\][/][\][/][\][/][\][/][\][/]-[\][/][\][/][\][/][\][/][\][/][\][/][\]';
      BORDERS[13]:='.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.ooOoo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.';
      BORDERS[14]:='*/*\*/*\*/*\*/*\*/*\*/*\*/*\*/*\/*\*/*\*/*\*/*\*/*\*/*\*/*\*/*\*/*\*/*\*/*\*/*\';
      BORDERS[15]:='[%][%][%][%][%][%][%][%][%][%][%][%][%]%[%][%][%][%][%][%][%][%][%][%][%][%][%]';
      BORDERS[16]:='[]-[]-[]-[]-[]-[]-[]-[]-[]-[]-[]-[]-[]-*-[]-[]-[]-[]-[]-[]-[]-[]-[]-[]-[]-[]-[]';
      BORDERS[17]:='*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*';
      BORDERS[18]:='-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-';
      BORDERS[19]:=']][[]][[]][[]][[]][[]][[]][[]][[]][[]][[*]][[]][[]][[]][[]][[]][[]][[]][[]][[]]';
      BORDERS[20]:='(/)(/)(/)(/)(/)(/)(/)(/)(/)(/)(/)(/)(/)-(\)(\)(\)(\)(\)(\)(\)(\)(\)(\)(\)(\)(\)';
    End;
(**************************************************************************)
  Procedure GIVESOME;
    Begin
      Mriteln('');
      Mrite('Do you want to write on the ');
      Mrite(CALLIT);
      Mrite('? ');
      WHAT(SURE);
      If SURE='Y' then Begin
        M_EDITOR(5);
       End;
      End;
(**************************************************************************)
  Begin
    CAR:=1;CLOCAL:=False;WWRAP:=True;HIGHNUM:=0;
    Super(True);
    TCBY:=PEEK($FFFA01);
    If TCBY&2<>0 then CAR:=2;
    IF TCBY&2<>0 then CLOCAL:=True;
    LOC;
    IO_CHECK(False);
    RNAME('MYTH.DAT');
    Reset(ONE,TCORRECT);
    A:=IO_Result;
    If (A=-33) or (A=-34) then Rewrite(ONE,TCORRECT);
    If (A=-33) or (A=-34) then Writeln(ONE,'0')
    Else Readln(ONE,HIGHNUM);
    Close(ONE);IO_CHECK(True);
    IAIV;
    VIEW;
    GIVESOME;
    Mriteln('');Mriteln('MythMirror v1.5 (c)1991 by Paul Witte [A Mythyn Software Production]');
    Mriteln('')
    End.

