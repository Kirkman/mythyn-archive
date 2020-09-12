unit shoppes2;

interface

uses crt,io,misc,comunit,magic;

Procedure JOBS(Var NUM:Integer;Var JOB:Integer;Var LJOB:Integer);
Procedure JAIL(NUM:Integer;Var OVER:Boolean);
Procedure VISITJAIL(NUM:Integer;Var OVER:Boolean;Var SUN:longint);
Procedure READ(Var NUM:Integer;Var SUN:longint;Var OVER:Boolean);
Procedure SLOTS(Var GOLD:longint);
Procedure CASINO(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
Procedure TAVERN(Var OVER:Boolean;Var SUN:longint);
Procedure INN(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
Procedure BANK(Var OVER:Boolean;Var SUN:longint);
Procedure SHOPPE(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
Procedure CYA(Var OVER:Boolean;Var NUM:Integer);
Procedure SFOGM(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
Procedure STATS(NUM:Integer;Var OVER:Boolean;Var SUN:longint);




implementation




(**** JOB GENERATOR 1 - Tavern  2 - Inn  3 - Bank *************************)
  Procedure JOBS(Var NUM:Integer;Var JOB:Integer;Var LJOB:Integer);
    Var
      RANDOM:longint;
      TOTAL,HOURS:Integer;
      GOT:Boolean;
      JUNK,TNAME:str80;
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
      JAILP,JUNK:str80;
      TOTAL,COND:Integer;
      RANDOM:longint;
    Begin
      OVER:=TRUE;
      If UJAILL then USERI[NUM,7]:=USERI[NUM,7]+1;
      USERI[NUM,7]:=USERI[NUM,7]+1;
      Mriteln('');
      Mriteln ('The guards are taking thee to jail!');Mriteln('');
      Mriteln ('Dost thou wish to:');Mriteln('');
      If ((USERI[NUM,21]>54) and (USERI[NUM,21]<101)) then
        begin
          Mrite ('['); tcolor(red); mrite('A');
          tcolor(white); mriteln(']ttack the guards!');
        end;
      Mrite ('['); tcolor(yellow); mrite('T'); tcolor(white); mriteln(']ry to Escape.');
      Mrite ('['); tcolor(green); mrite('P'); tcolor(white); mriteln(']ay Thy Bail.');
      Mrite ('['); tcolor(cyan); mrite('G'); tcolor(white); mriteln(']o to Jail.');Mriteln('');
      Mrite ('Thy Selection: ');
     Repeat
      SOMETHING(JAILP);
      If (JAILP='A') and (USERI[NUM,21]>54) and (USERI[NUM,21]<101) then Begin
        OVER:=False;USERI[NUM,7]:=0;
        EM_SEND(423);
        tcolor(red); Mriteln('Attack...');tcolor(white);Mriteln('');
        C_MONSTER:=21;
        EM_SEND((600+C_MONSTER)-1);
        EM_SEND(303);
        COMBAT(1,OVER,False);
        If OVER=False then EM_SEND((600+C_MONSTER)-1);
        If OVER=False then EM_SEND(303);
        If OVER=False then COMBAT(1,OVER,False);
{        If OVER=False then STOP}
       End;
      If JAILP='T' then Begin
        tcolor(yellow); Mriteln ('Try to Escape!'); tcolor(white); Mriteln('');
        Mriteln ('Thou dost wait until the guards are not looking...');
        Mriteln('');Mrite ('Press '); tcolor(black); bcolor(red); mrite('<RETURN>'); tcolor(white); bcolor(black);
        mrite(' to attempt thy escape!');
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
          tcolor(blue); Send_Num(USERI[NUM,7]); tcolor(white);
          Mriteln(' day(s)!!');
          TOTAL:=1;COND:=13;
          ESTUFF(TOTAL,NUM,JUNK,COND);
          If EMULATE then STOP;EM_SEND(300)
         End
        End;
       If JAILP='P' then Begin
         Mriteln ('Pay Thy Bail.');Mriteln('');
         Mrite ('The Guards tell thee, "Bail will cost ');
         tcolor(green); Send_Num(USERI[NUM,7]*500); tcolor(white);
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
          tcolor(cyan); Mriteln ('Go to Jail.'); tcolor(white);
          EM_SEND(408);EM_SEND(699);EM_SEND(303);
          Mriteln('');
          Mrite ('Thou art in jail for ');
          tcolor(blue); Send_Num(USERI[NUM,7]); tcolor(white);
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
  Procedure VISITJAIL(NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      JAILP,JUNK,SURE:str80;
      C,WHICH,TOTAL,COND,IS:Integer;
      RANDOM:longint;
      UNI:Boolean;
      townColor : integer;

    Begin
      UNI:=False;EM_SEND(408);EM_SEND(301);
      Repeat
        If VT=True then
          begin
            vtModem(#27+'E');
            clrscr;
          end;
        ABLE:=True;
        Mriteln('');
        Mrite ('Thou art at the -=* ');
        If VT=True then
          begin
            vtModem(Chr(27)+'b1');
          end;

           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],1]);
           tcolor(white);


        If VT=True then
          begin
            vtModem(Chr(27)+'b3');
          end;
        Mriteln(' *=- Jail.');
        Mriteln('');
        Mrite (' ['); tcolor(cyan); mrite('1'); tcolor(white); mriteln(']  Look at thieves currently in jail.');
        Mrite (' ['); tcolor(magenta); mrite('2'); tcolor(white); mriteln(']  Pay someone''s bail.');
        Mrite (' ['); tcolor(red); mrite('3'); tcolor(white); mriteln(']  Try to help someone escape from jail.');
        Mrite (' ['); tcolor(yellow); mrite('4'); tcolor(white); mriteln(']  Leave...');
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
                tcolor(blue); Send_Num(USERI[WHICH,7]); tcolor(white);
                Mriteln(' Day(s) left.');
                Mriteln('');Mrite ('Bail would cost thee ');
                tcolor(green); Send_Num(USERI[WHICH,7]*500); tcolor(white);
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
                Mriteln('');Mrite ('Press '); tcolor(black); bcolor(red); mrite('<RETURN>'); tcolor(white);
                bcolor(black); mrite(' to help ');
                Mrite(USERS[WHICH,3]);
                Mrite(' Escape!');
                QSTOP;
                TOTAL:=100+USERI[NUM,3];
                RANDOM:=DRANDOM mod TOTAL+1;
                If RANDOM>100 then Begin
                  USERI[WHICH,7]:=0;
                  Mriteln('');Mrite ('SUCCESSFUL!! ');
                  tcolor(magenta); Mrite(USERS[WHICH,3]); tcolor(white);
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


(**************************************************************************)
(**************************************************************************)
  Procedure READ(Var NUM:Integer;Var SUN:longint;Var OVER:Boolean);
    Var
      JUNK:str80;
      A:Integer;
      townColor : integer;

    Begin
      If VT=True then
        begin
          vtModem(#27+'E');
          clrscr;
        end;
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
       If VT=True then
         begin
           vtModem(Chr(27)+'b1');
         end;



           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],1]);
           tcolor(white);


       If VT=True then
         begin
           vtModem(Chr(27)+'b3');
         end;
       Mriteln('|');
       Mrite ('          ');
       For A:=1 to ord(TOWNS[USERI[NUM,14],1][0])+2 do
         Mrite ('*');
       Mriteln('');
       Mriteln('');
       A:=TOWNI[USERI[NUM,14],7];
       Mrite ('Population:  ');
       tcolor(yellow);
       Send_Num(A);
       tcolor(blue);
       If A<1000 then Mrite (' (Village)');
       If (A>999) and (A<5000) then Mrite (' (Small Town)');
       If (A>4999) and (A<15000) then Mrite (' (Large Town)');
       If A>14999 then Mrite (' (City)');
       tcolor(white);
       If (USERI[NUM,14]=8) or (USERI[NUM,14]=13) or (USERI[NUM,14]=19) then
        begin
          tcolor(magenta);
          Mrite (' -=> Magi Rule <=-');
          tcolor(white);
        end;
       Mriteln('');Mrite ('Alignment :  ');
       Case TOWNI[USERI[NUM,14],19] of
         1:begin tcolor(red); Mriteln ('Chaotic! [Balorian Rule]'); tcolor(white); end;
         2:begin tcolor(red); Mriteln ('Evil. [Balorian Dominate]'); tcolor(white); end;
         3:begin tcolor(green); Mriteln ('Neutral. [Catharian Dominate]'); tcolor(white); end;
         4:begin tcolor(cyan); Mriteln ('Good. [Solnarian Dominate]'); tcolor(white); end;
         5:begin tcolor(cyan); Mriteln ('Lawful! [Solnarian Rule]'); tcolor(white); end;
        End; {Case}
       Mrite ('Guards    :  ');
       tcolor(magenta); Send_Num(TOWNI[USERI[NUM,14],8]); tcolor(white); Mriteln('');
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
procedure mapFruits(fruit : integer);

  begin
    case fruit of
      1 : tcolor(Red);
      2 : tcolor(green);
      3 : tcolor(magenta);
      4 : tcolor(cyan);
      5 : tcolor(yellow);
    end;
  end;


Procedure SLOTS(Var GOLD:longint);
  Var
    FRUIT:Array[1..3] of Integer;
    FRUITS:Array[1..5] of String[6];
    FRUIT1,FRUIT2,FRUIT3,ROLLS,JCO,AMCOUNT,AONE,GOLDSS:Integer;
    FIRST,TIME,GOLDS:longint;
    AMOUNT,SURE:str80;
    DOUBLE,TRIPLE:Boolean;
    townColor : integer;

  Begin
    FRUITS[1]:='Cherry';FRUITS[2]:='Lime';FRUITS[3]:='Plum';
    FRUITS[4]:='Star';FRUITS[5]:='Bar';
    Repeat
      If VT then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
      DEATH:='';
      MAKESURE(NUM,SUN,OVER);
    If OVER=False then Begin
    ABLE:=True;
    Mriteln('');Mrite ('Thou art at the -=* ');
    If VT=True then
      begin
        vtModem(Chr(27)+'b1');
      end;

           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],1]);
           tcolor(white);



    If VT=True then
      begin
        vtModem(Chr(27)+'b3');
      end;
    Mriteln(' *=- Casino.');
    Mriteln('');
    Mriteln('2 of Kind (Orange & Up) 2 to 1');
    Mriteln('Cherry Cherry Cherry    3 to 1');
    Mriteln('Lime   Lime   Lime      4 to 1');
    Mriteln('Plum   Plum   Plum      5 to 1');
    Mriteln('Star   Star   Star     10 to 1');
    Mrite  ('Bar    Bar    Bar      JACKPOT!!! (');
    tcolor(magenta); Send_Num(PROG); tcolor(white);
    Mriteln(')');
    ABLE:=False;SOFF:=False;
     Repeat
      Mriteln('');
      Mrite('Thou hast ');tcolor(green); Send_Num(GOLD);tcolor(white);
      Mriteln(' gold piece(s).');
      Mriteln('');Mrite('Bet how much (0=cancel): ');
      Meadln(AMOUNT);BUGPROOF(AMOUNT,GOLDSS);
      GOLDS:=GOLDSS;
      If GOLDS>GOLD then Mriteln('Not enough gold!');
      If GOLDS>20000 then Mriteln('There is a 20,000 gp house limit...');
     Until ((GOLDS<=GOLD) or (GOLDS=0)) and (GOLDS<20001) and (GOLDS>-1);
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
                mapFruits(ROLLS);
                Mrite(FRUITS[ROLLS]);
                tcolor(white);
                For JCO:=1 to ord(FRUITS[ROLLS][0]) do Begin
                  Mrite(Chr(8));Mrite(Chr(32));Mrite(Chr(8));
                 End;
                If ROLLS=5 then ROLLS:=0;
              End;
           mapFruits(fruit[amcount]);
           Mrite(FRUITS[FRUIT[AMCOUNT]]);
           tcolor(white);
           Mrite(' ');
         Until AMCOUNT=3;
         LUCK:=False;
         Mriteln('');Mriteln('');
         DOUBLE:=False;TRIPLE:=False;
         If (FRUIT[1]=FRUIT[2]) or (FRUIT[1]=FRUIT[3]) or (FRUIT[2]=FRUIT[3]) then DOUBLE:=True;
         If ((FRUIT[1]=1) and (FRUIT[2]=1)) or ((FRUIT[1]=1) and (FRUIT[3]=1)) or
            ((FRUIT[2]=1) and (FRUIT[3]=1)) then DOUBLE:=False;
         If (FRUIT[1]=FRUIT[2]) and (FRUIT[1]=FRUIT[3]) then
           begin
             TRIPLE:=True;
             DOUBLE:=False;
           end;
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
           If FRUIT[1]=5 then
             begin
               tcolor(yellow); Mriteln(' J A C K P O T !!!!!!');
               tcolor(white);
             end;
           If FRUIT[1]=5 then Mriteln('');
          End;
          EM_SEND(133);
          Mrite('Thou won ');tcolor(green); Send_Num(GOLDS);tcolor(white); Mriteln(' Gold Piece(s)!!!');
          GOLD:=GOLD+GOLDS;
         End;
       End;
      End;
      If (GOLDS<>0) and (OVER=False) then STOP;
     End;
    Until (GOLDS=0) or (OVER=True);
   End;
(**************************************************************************)
  Procedure CASINO(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      GOLD,LAST,COND:Integer;
      RANDOM,GIN:longint;
      TELL,WORDS,WHICH,JUNK:str80;
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
procedure tavern(var over : boolean; var sun : longint);

  var
    me, choice, golds, sure, junk, drink, temp, react, jjjunk : str80;
    temp2 : str80;
    AHINT:String[160];
    FNAME,SNAME:Text;
    ANAME:Text;
    TOTAL,JOB,LJOB,COND,RIGHT,IS,GOLD,WHICH,D,J,RANDOM,TI,SCOUNT,SCCOUNT,
    LOCATION,CNTRS,RANNUM:Integer;
    WRONG,UNI,PLAY : boolean;
    townColor:integer;
    timer:longint;

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
          If (VT=True) and (OVER=False) then
            begin
              vtModem(Chr(27)+'E');
            end;
          If OVER=FALSE Then MAKESURE(NUM,SUN,OVER);
          If OVER=False then Begin
           EM_SEND(1054);
           If EMULATE=False then
             Begin
               ABLE:=True;
               Mriteln('');Mrite ('Thou art at the -=* ');
               If VT=True then
                 begin
                   vtModem(Chr(27)+'b1');
                 end;
               townColor := useri[num,14] + 2;
               townColor := townColor mod 6 + 1;
               if townColor = brown then towncolor := yellow;
               tcolor(townColor);
               Mrite(TOWNS[USERI[NUM,14],2]);
               tcolor(white);
               If VT=True then
                 begin
                   vtModem(Chr(27)+'b3');
                 end;
               Mriteln(' *=- Tavern.');
               Mriteln ('Music of Olde springs from the minstrels'' instruments...');
               Mriteln('');
               Mrite (' ['); tcolor(magenta); mrite('1'); tcolor(white); mriteln(']  Order some food.');
               Mrite (' ['); tcolor(magenta); mrite('2'); tcolor(white); mriteln(']  Buy a Drink.');
               Mrite (' ['); tcolor(cyan); mrite('3'); tcolor(white); mriteln(']  Apply for a Job.');
               Mrite (' ['); tcolor(green); mrite('4'); tcolor(white); mriteln(']  Talk to a Patron.');
               Mrite (' ['); tcolor(green); mrite('5'); tcolor(white); mriteln(']  Talk to the Bartender.');
               Mrite (' ['); tcolor(blue); mrite('6'); tcolor(white); mriteln(']  Say something to a Guild Member.');
               Mrite (' ['); tcolor(blue); mrite('7'); tcolor(white); mriteln(']  Say something to Everyone!');
               Mrite (' ['); tcolor(magenta); mrite('8'); tcolor(white); mriteln(']  Give someone some Gold.');
               Mrite (' ['); tcolor(blue); mrite('9'); tcolor(white); mriteln(']  Listen to a Guild Rumour.');
               Mrite (' ['); tcolor(cyan); mrite('10'); tcolor(white); mriteln('] Tell a Guild Rumour.');
               Mrite (' ['); tcolor(red); mrite('11'); tcolor(white); mriteln('] Try to steal Something.');
               Mriteln('');
               Mrite (' ['); tcolor(yellow); mrite('12'); tcolor(white); mriteln(']  Leave the Tavern...');
               ABLE:=False; SOFF:=False;
             End;
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
                   If SCCOUNT>20 then SCCOUNT:=11;
                   if sccount > 11 then
                     begin
                       Mrite('The Bartender says, "');
                       case (sccount) of
                         12 : begin
                                Mriteln('With such a tip I can tell you are very wise!"');
                              end;
                         14 : begin
                                Mrite('Chant '''); tcolor(yellow); mrite('OGNOM');
                                tcolor(white); mriteln(''' at the appearance of the mystic portal."');
                              end;
                         16 : begin
                                Mrite(''''); tcolor(magenta); mrite('Excavate');
                                tcolor(white); mriteln(''' upon discovery of mines."');
                              end;
                         18 : begin
                                Mrite('Great riches may be found in Erelas."');
                              end;
                         else
                           Mriteln('Thanks a bundle, sucker!!!"');
                       end;  (* case *)
                     end
                   else
                     begin
                       For SCOUNT:=1 to SCCOUNT do Readln(ANAME,AHINT);
                         ENCRYPT(AHINT,False);
                       close(aname);
                       Mrite('The Bartender says, "');Mrite(AHINT); mriteln('"');
                     end;
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
    clrscr;Writeln;Writeln;
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
        Upcaseln(JUNK);If JUNK='BYE' then Play:=False;
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
         Readln(SURE);UPCASEln(SURE);
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
          Upcaseln(JUNK);If JUNK='BYE' then PLAY:=False
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
          if choice = '10' then begin
            repeat
              junk := 'N';
             repeat
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
            temp2 := tpath;
            insert('RUMOURS.DAT',temp2,((ord(temp2[0]))+1));
            mReset(fname,temp2);
            readln(fname,location);  { get count of # lines in rumour file }
            if location=60 then
              readln(fname)   { if you have 60 rumors, delete first one }
            else
              inc(location);  { else add 1 }
            temp := tpath;
            insert('JUNK.DAT',temp,((ord(temp[0]))+1));  { open temp file }
            assign(sname,temp);
            rewrite(sname);
            writeln(sname,location);              { write rumour count }
            while not eof(fname) do               { now copy file to temp }
              begin
                readln(fname,jjjunk);
                writeln(sname,jjjunk);
              end;
            writeln(sname,sure);
            close(sname);         { close junk.dat file }
            close(fname);         { close the rumours.dat file }
            erase(fname);         { erase the rumours.dat file }
            rename(sname,temp2);  { rename junk.dat to rumours.dat }
          end;
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
  Procedure INN(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      OP,FIRST,JUNK,JUNKS:str80;
      THE,PRICE,HOURS,ROOM,JOB,LJOB,HAS,QUICKIE,TI,HEAL:Integer;
      RANDOM:longint;
      townColor : integer;

    Begin
      HAS:=0;
      LJOB:=0;
      If OVER=False then EM_SEND(403);
      If OVER=False then EM_SEND(511);
      If OVER=False then EM_SEND(301);
      Repeat
        If (VT=True) and (OVER=False) then
          begin
            vtModem(Chr(27)+'E');
          end;
        If OVER=FALSE Then MAKESURE(NUM,SUN,OVER);
        If OVER=TRUE Then OP:='6';
        If OVER=FALSE Then Begin
          ABLE:=True;
          Mriteln('');
          Mrite ('Thou art at The -=* ');
          If VT=True then
            begin
              vtModem(Chr(27)+'b1');
            end;

           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],7]);
           tcolor(white);

          If VT=True then
            begin
              vtModem(Chr(27)+'b3');
            end;
          Mriteln(' *=- Inn.');
          Mriteln('');
          If HAS=0 then Mriteln ('The Inn Keeper welcomes thee!');
          If HAS=1 then begin  tcolor(red); Mrite('The Inn Keeper seems upset...'); tcolor(white); mriteln(''); end;
         EM_SEND(1061);
         If EMULATE=False then Begin
          Mriteln ('Dost thou wish to:');
          Mriteln('');
          Mrite ('['); tcolor(magenta); mrite('1'); tcolor(white); mriteln('] Ask for a Room.');
          Mrite ('['); tcolor(green); mrite('2'); tcolor(white); mriteln('] Look at the Clock.');
          Mrite ('['); tcolor(cyan); mrite('3'); tcolor(white); mriteln('] Ask for a Job.');
          Mrite ('['); tcolor(blue); mrite('4'); tcolor(white); mriteln('] Ask the Innkeeper about Maps.');
          Mrite ('['); tcolor(red); mrite('5'); tcolor(white); mriteln('] Try to steal some gold!');
          Mriteln('');
          Mrite ('['); tcolor(yellow); mrite('6'); tcolor(white); mriteln('] Go outside...');
         End;
          ABLE:=False;SOFF:=False;
          Mriteln('');
          If (DRANDOM mod 16+1)=3 then Begin
            Mriteln('An old man with a strange amulet about his neck meets thee...');
            Mriteln('');Mrite('He says, "'); tcolor(magenta); mriteln('I hold the power of dreamspeech!!  For 200 gold I');
            Mrite('will create a dream to send to those who sleep here.'); tcolor(white); mriteln('"');
            Mriteln('');Mrite('Do it? ');WHAT(JUNKS);Mriteln('');
            If (JUNKS='Y') and (USERI[NUM,4]<=200) then Mriteln('Not enough gold!');
            If (JUNKS='Y') and (USERI[NUM,4]>200) then Begin
              Mrite('Thou had a dream of ___'); tcolor(Red); mrite('(80 Char. Max.)'); tcolor(white);
              mriteln('___. (Fill in the blank)');
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
              Mrite ('['); tcolor(white); mrite('1'); tcolor(white); mrite('] Floor............');
              Send_Num(6*QUICKIE);Mriteln(' G.P.');
              Mrite ('['); tcolor(red); mrite('2'); tcolor(white); mrite('] Premium Room.....');
              Send_Num(20*QUICKIE);Mriteln(' G.P.');
              Mrite ('['); tcolor(blue); mrite('3'); tcolor(white); mrite('] Deluxe Room......');
              Send_Num(60*QUICKIE);Mriteln(' G.P.');
              Mrite ('['); tcolor(cyan); mrite('4'); tcolor(white); mrite('] Small Suite......');
              Send_Num(80*QUICKIE);Mriteln(' G.P.');
              Mrite ('['); tcolor(magenta); mrite('5'); tcolor(white); mrite('] Large Suite......');
              Send_Num(160*QUICKIE);Mriteln(' G.P.');
              Mrite ('['); tcolor(green); mrite('6'); tcolor(white); mrite('] The Best Suite...');
              Send_Num(320*QUICKIE);Mriteln(' G.P.');
              Mrite ('['); tcolor(yellow); mrite('7'); tcolor(white); mriteln('] None.');
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
              If VT=True then
                begin
                  vtModem(Chr(27)+'E');
                end;
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
           If USERI[NUM,33]>21000 then Begin
             Mriteln('');Mriteln('There''s no gold to steal!');STOP
            End;
            If (JUNK='Y') and (TI<>8) and (TI<>13) and (TI<>19) and (USERI[NUM,33]<21001) then Begin
                EM_SEND(510);EM_SEND(699);EM_SEND(303);
                Mriteln('');Mriteln ('Thou dost wait until the Inn Keeper is not looking...');
                Mriteln('');Mrite ('Press '); tcolor(black); bcolor(red); mrite('<RETURN>'); tcolor(white); bcolor(black);
                mrite(' to grab a bag of gold!');
                If EMULATE then VT:=False;
                QSTOP;
                If EMULATE then VT:=True;
                Mriteln('');
                EM_SEND(300);
                RANDOM:=DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+25)+1;
                If RANDOM<=USERI[NUM,3]+25 then Begin
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
                  JAIL(NUM,OVER);
                  STOP;
                 End
                End
               End;
            If OP='2' Then Begin
              DISTIME(USERI[NUM,6],THE);
              Mriteln('');
              tcolor(green);
              If (USERI[NUM,6]>7) and (USERI[NUM,6]<19) then Begin
                tcolor(white);
                Mriteln(' .     .          .      .     .');
                Mrite('   '); tcolor(white); mrite('.'); tcolor(green);
                mrite(' /\  '); tcolor(white); mrite('.'); tcolor(red);
                mrite(' ('); tcolor(Green); mrite(' /\'); tcolor(white);
                mrite('.'); tcolor(green); mrite('     /\ '); tcolor(white); mrite('.');
                tcolor(green); mriteln('  /\/\/\');
                tcolor(white); Mrite('.'); tcolor(green); mrite('   /  \/\  /  \/\ '); tcolor(white); mrite('.');
                tcolor(green); mriteln('/  \/\/  \/  \');
               End
              Else Begin
                Mriteln('     /\      /\      /\    /\/\/\');
                Mriteln('    /  \/\  /  \/\  /  \/\/  \/  \');
               End;
             Mriteln(' /\/   /  \/   /  \/   /  \   \   \');
             Mriteln('/  \  /    \  /    \  /    \   \   \');
             Mriteln('####################################');
             Mriteln('');
             tcolor(white);
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
  Procedure BANK(Var OVER:Boolean;Var SUN:longint);
    Var
      FN:Text;
      OPTI,GOLD:str80;
      ANINT,LJOB,JOB,AMT,T,ABC,CIVIL,TI,GOLDI:Integer;
      GOTIT,ANY:Boolean;
      TOTAL:longint;
      townColor : integer;

    Begin
      LJOB:=0;JOB:=3;TI:=USERI[NUM,14];
      EM_SEND(406);EM_SEND(301);
      Repeat
        If VT=True then
          begin
            vtModem(Chr(27)+'E');
          end;
        MAKESURE(NUM,SUN,OVER);
        If OVER=False then Begin
          ABLE:=True;EM_SEND(1055);
         If EMULATE=False then Begin
          Mriteln('');Mrite ('Thou art at the -=* ');
          If VT=True then
            begin
              vtModem(Chr(27)+'b1');
            end;

           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],10]);
           tcolor(white);

          If VT=True then
            begin
              vtModem(Chr(27)+'b3');
            end;
          Mriteln(' *=- Bank.');
          End;
          Mriteln('');Mrite ('    Bank''s Daily Interest - ');
          tcolor(blue); Send_Num(TOWNI[USERI[NUM,14],14]);Mriteln('%'); tcolor(white);
          If USERI[NUM,17]>0 then
            begin
              Mrite ('      Thy Current Balance - ');
              tcolor(Green); Send_Num(USERI[NUM,18]); tcolor(white);
              Mriteln(' G.P.');
            end;
          EM_SEND(1056);
         If EMULATE=False then Begin
          Mriteln('');
          Mrite (' ['); tcolor(green); mrite('1'); tcolor(white); mriteln(']  Open an Account.');
          Mrite (' ['); tcolor(magenta); mrite('2'); tcolor(white); mriteln(']  Close an Account.');
          Mrite (' ['); tcolor(magenta); mrite('3'); tcolor(white); mriteln(']  Withdraw from an Account.');
          Mrite (' ['); tcolor(green); mrite('4'); tcolor(white); mriteln(']  Make a Deposit.');
          Mrite (' ['); tcolor(cyan); mrite('5'); tcolor(white); mriteln(']  Apply for a Job.');
          Mrite (' ['); tcolor(red); mrite('6'); tcolor(white); mriteln(']  Try to steal a copy of the Bankbooks.');
          Mrite (' ['); tcolor(red); mrite('7'); tcolor(white);
          mriteln(']  Try to steal ALL Gold from Guild Member''s Accounts!');
          Mriteln('');
          Mrite (' ['); tcolor(yellow); mrite('8'); tcolor(white); mriteln(']  Leave the Bank.');
          End;
          ABLE:=False;SOFF:=False;
          If BSTEAL<>'' then Begin
             Mriteln('');
             tcolor(black); bcolor(red); Mrite('WANTED: ');
             Mrite(BSTEAL);Mrite(' robbed the bank on ');Mrite(BDATE);
             mrite('!!!!');
             bcolor(black); tcolor(white);
             Mriteln('');
            End;
          Mriteln('');Mrite ('Guards stand at every corner of the room watching thee: ');
          Meadln (OPTI);
       End;
       If OPTI='1' then Begin
         Mriteln('');
        If USERI[NUM,17]>0 then Begin
         Mrite ('Thou hast already opened an account at the ');
           townColor := useri[num,17] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,17],10]);
           tcolor(white);
         Mrite(' Bank - ');
         tcolor(green);
         Send_Num(TOWNI[USERI[NUM,17],14]);Mriteln('%'); tcolor(white);
        End
         Else Begin
          Repeat
          Repeat
           Mriteln('BANK NOTICE: Interest is only paid if account has less than 250,000 gps!');
           Mriteln('');Mrite('Thou hast ');
           tcolor(green); Send_Num(USERI[NUM,4]); tcolor(white);
           Mriteln(' Gold Pieces.');
           Mriteln('30000 Max. per Transaction.');
           Mriteln('');Mrite ('Deposit how much? ');
           Meadln(GOLD);
           BUGPROOF(GOLD,GOLDI);
          Until (GOLDI<30001) and (GOLDI>-1);
           If GOLDI<>0 then Begin
             Mrite ('Deposit ');
             tcolor(green); Send_Num(GOLDI); tcolor(white);
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
         Mrite ('Thou hast '); tcolor(green);
         Send_Num(USERI[NUM,18]); tcolor(white); Mriteln(' gold in thy account.');
         Mriteln('30000 Max. per Transaction.');
         Mriteln('');
         Mrite ('Withdraw how much? ');
         Meadln(GOLD);
         BUGPROOF(GOLD,GOLDI);
        Until (GOLDI<30001) and (GOLDI>-1);
         If GOLDI<>0 then Begin
           Mrite ('Withdraw ');
           tcolor(green); Send_Num(GOLDI); tcolor(white);
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
          tcolor(green); Send_Num(GOLDI); tcolor(white);
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
            tcolor(green);
            Send_Num(USERI[NUM,4]); tcolor(white);
            Mriteln(' Gold Pieces.');
            Mriteln('');Mriteln('30000 max. per transaction.');
            Mrite ('Deposit how much? ');
            Meadln(GOLD);
            BUGPROOF(GOLD,GOLDI)
           Until (GOLDI>-1) and (GOLDI<30001);
           If GOLDI<>0 then Begin
             Mrite ('Deposit '); tcolor(green);
             Send_Num(GOLDI); tcolor(white);
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
              tcolor(cyan);
              Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
              tcolor(white);
              STOP
            End;
            If (GOLD='Y') and (TI<>8) and (TI<>13) and (TI<>19) then Begin
             Mriteln('');Mrite ('Press '); tcolor(black); bcolor(red); mrite('<RETURN>'); tcolor(white); bcolor(black);
             mrite(' to steal the Bank Books!');
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
            begin
              tcolor(cyan); Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
              tcolor(white);
            end;
            If (GOLD='Y') and (TI<>8) and (TI<>13) and (TI<>19) then Begin
            Mriteln('');Mriteln('Thou waitest until what seems like a good time...');
            Mriteln('');Mrite('Press '); tcolor(black); bcolor(Red); mrite('<Return>'); tcolor(white);
            bcolor(black); mrite(' to start the robbery!');
            QSTOP;
            GOLDI:=DRANDOM Mod (TOWNI[USERI[NUM,14],8]+USERI[NUM,3]+8888)+1;
            If GOLDI<USERI[NUM,3] then Begin
              Mriteln('');tcolor(yellow); Mriteln('Thou managed to get away with the gold!!!!!!!!'); tcolor(white);
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
              tcolor(green); Send_Num(TOTAL); tcolor(white);
              Mriteln(' gold pieces from guild members!!!');
              CIVIL:=1500 + Drandom mod 5000 + Drandom mod 7000 + 1;
              Mriteln('');
              Mrite('    -- Plus ');
              tcolor(green);
              Send_Num(CIVIL);
              tcolor(white);
              Mriteln(' gold pieces from civilian accounts!!');
              USERI[NUM,4]:=USERI[NUM,4]+(TOTAL+CIVIL);STEALER:=TOTAL+CIVIL;
              CIVIL:=Drandom mod 10+1;
              Mriteln('');Mrite('         -- Skill Plus ');
              tcolor(magenta); Send_Num(CIVIL); tcolor(white);
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
  Procedure SHOPPE(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      RIGHT,GOLD,DPRICE,ONE,J,OVERALL,QUICKIE,HOURS,TI,RANDOM:Integer;
      DIFF:longint;
      ME,C,D,E,HM,TWO,THREE,THINGS,F,S,T,DONE,SURE,JUNKS,WIT:str80;
      JUNK:Text;
      BYE,WRONG,ITS,GOTIT,TRIED:Boolean;
      townColor : integer;

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
      If VT=True then
        begin
          vtModem(Chr(27)+'E');
        end;
      WRONG:=FALSE;ITS:=False;
      ABLE:=True;GOTIT:=False;TRIED:=False;
      EM_SEND(1057);
     If EMULATE=False then Begin
      Mriteln('');Mrite ('Thou art at The -=* ');
      If VT=True then
        begin
          vtModem(Chr(27)+'b1');
        end;


           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],11]);
           tcolor(white);

      If VT=True then Mrite(Chr(27));
      If VT=True then Mrite('b3');
      Mriteln(' *=- Shoppe.');
      Mriteln('');
      Mriteln ('What would''st thou like?');
      Mriteln('');
      Mrite ('  ['); tcolor(red); mrite('0'); tcolor(white); mriteln('] Try to Steal something!!');
      Mriteln('');
      Mrite ('    ['); tcolor(magenta); mrite('1'); tcolor(white); mrite('] Hat      [');
      tcolor(magenta); mrite('2'); tcolor(white); mriteln('] Bandana');
      Mrite ('    ['); tcolor(magenta); mrite('3'); tcolor(white); mrite('] Shirt    [');
      tcolor(magenta); mrite('4'); tcolor(white); mriteln('] Cloak');
      Mrite ('    ['); tcolor(magenta); mrite('5'); tcolor(white); mrite('] Jacket   [');
      tcolor(magenta); mrite('6'); tcolor(white); mriteln('] Pants');
      Mrite ('    ['); tcolor(magenta); mrite('7'); tcolor(white); mrite('] Boots    [');
      tcolor(magenta); mrite('8'); tcolor(white); mriteln('] Sandals');
      Mriteln('');
      Mrite('       ['); tcolor(yellow); mrite('9'); tcolor(white); mriteln('] Leave the Shop');
     End;
      TI:=USERI[NUM,14];
      If (TI=8) or (TI=13) or (TI=19) then
        begin
          Mrite('  ['); tcolor(green); mrite('10'); tcolor(white); mriteln('] Robes (Our Specialty!!)');
        end;
      If USERI[NUM,14]=17 then
        begin
          Mrite (' ['); tcolor(green); mrite('10'); tcolor(white); mriteln('] Turbine (Our Specialty!)');
        end;
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
            begin
              tcolor(cyan);
              Mriteln('A jolt of electricity is sent through thy body!  A wizard laughs...');
              tcolor(white);
            end;
           If (TI=8) or (TI=13) or (TI=19) then TRIED:=True;
            If (TI<>8) and (TI<>13) and (TI<>19) then Begin
                Mriteln('');Mriteln ('Thou carefully planeth thy steal...');
                Mriteln('');Mrite ('Press '); tcolor(black); bcolor(red); mrite('<RETURN>'); tcolor(white); bcolor(black);
                mrite(' to grab some clothing!');
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
       T:='Turbine';
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
      tcolor(green); Send_Num(DPRICE); tcolor(white);
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
        tcolor(green); Send_Num(DIFF); tcolor(white);
        Mriteln(' Gold Pieces.');
        DONE:='NO'
      End
      End;
      Until DONE='YES';
    If HM='B' then Begin
      Mriteln ('Buy');
      If USERI[NUM,4] < DPRICE then Begin
        Mrite ('The Mechant Yells, "Thou hast not ');
        tcolor(green); Send_Num(DPRICE); tcolor(white);
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
    If HM <> 'B' then begin tcolor(red); Mriteln ('The merchant growls with anger!'); tcolor(white); end;
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

           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],11]);
           tcolor(white);

        Mriteln(' Shoppe is currently -* CLOSED *-.');
        DISTIME(TOWNI[USERI[NUM,14],17],RIGHT);
        Mriteln('');
        Mrite ('Our Hours are ');
        tcolor(Red);
        Send_Num(RIGHT);
        If TOWNI[USERI[NUM,14],17]>12 then Mrite (' P.M. to ');
        If TOWNI[USERI[NUM,14],17]<13 then Mrite (' A.M. to ');
        DISTIME(TOWNI[USERI[NUM,14],18],RIGHT);
        Send_Num(RIGHT);
        If TOWNI[USERI[NUM,14],18]>12 then Mrite (' P.M.');
        If TOWNI[USERI[NUM,14],18]<13 then Mrite (' A.M.');
        tcolor(white);
        Mriteln('');Mriteln ('Please come again when we are open...');
        STOP;
        Mriteln('')
      End
   End;
(**************************************************************************)
  Procedure CYA(Var OVER:Boolean;Var NUM:Integer);
    Var
      JUNK:str80;
    Begin
      Mriteln('');Mrite ('Dost thou really wish to leave? ');
      WHAT(JUNK);
      If JUNK='Y' then Begin
      Mriteln('');Mrite ('Thou hast ');
      tcolor(yellow);
      Send_Num(USERI[NUM,6]);
      tcolor(white);
      Mriteln(' Minute(s) left should thee decide to play again today.');
      OVER:=True
      End
    End;
(** STEAL FROM OTHER GUILD MEMBERS ****************************************)
  Procedure SFOGM(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      WHICH,TOTAL,SEP,COND,IS:Integer;
      DIFF:longint;
      SURE,OTHER,WORD,TEMP:str80;
      SFMSG:Text;
      UNI:Boolean;
    Begin
     UNI:=False;DEATH:='';
     Repeat
      Mriteln('');
      If USERI[NUM,9]=0 then
        begin
          tcolor(red); Mriteln ('No More Steals Allowed For Today!');
          tcolor(white);
        end;
      If USERI[NUM,9]>0 then Begin
       Repeat
         Mrite ('Thou Hast ');
         tcolor(cyan); Send_Num(USERI[NUM,9]); tcolor(white);
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
           Mriteln('');tcolor(red); Mriteln('It is against guild ethics to steal from a member whose skill thou doth triple!');
           tcolor(white);
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
             Writeln('');
             Write(USERS[WHICH,3]);
             Write(' says, "');
             Write(SURE);
             Writeln('"');
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




  Procedure STATS(NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      JUNK:str80;
      CANON:Boolean;
      TEMP:longint;
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
      If VT=True then
        begin
          vtModem(#27+'E');
          clrscr;
        end;
      Mriteln('');
      Mriteln ('      Thy  Status');
      Mriteln ('      +-+-+-+-+-+');
      Mriteln('');
      ABLE:=True;
      Mrite ('User Number: ');
      Send_Num(USERI[NUM,1]);Mrite('                      ');
      If USERI[NUM,1]<10 then Mrite(' ');Mrite('Armour: ');
      tcolor(blue); AWVIEW(2,NUM); tcolor(white);
      If (USERI[NUM,23]=2) or (USERI[NUM,23]=3) then
        begin
          tcolor(red);
          Mrite(' -\* Enchanted */-');
          tcolor(white);
        end;
      Mriteln('');
      Mrite ('User Letter: ');
      Mrite(USERS[NUM,1]);Mrite('                       Weapon: ');
      tcolor(green); AWVIEW(1,NUM);tcolor(white);
      If (USERI[NUM,23]=1) or (USERI[NUM,23]=3) then
        begin
          tcolor(red);
          Mrite(' -\* Enchanted */-');
          tcolor(white);
        end;
      Mriteln('');
      Mrite ('Name       : ');
      tcolor(magenta);
      Mrite(USERS[NUM,3]);
      tcolor(white);
      Mriteln('');
      Mrite ('Skill      : ');
      tcolor(yellow); Send_Num(USERI[NUM,3]); tcolor(white);
      Mrite(' [Hit Points: ');
      if ((useri[num,20]) < (useri[num,21] div 80)) then
        tcolor(red)
      else if useri[num,20] = useri[num,21] then
        tcolor(green)
      else tcolor(cyan);
      Send_Num(USERI[NUM,20]); tcolor(white);
      Mrite('/');
      if (useri[num,20] = useri[num,21]) then
        tcolor(green)
      else
        tcolor(white);
      Send_Num(USERI[NUM,21]); tcolor(white);
      Mriteln(']');
      Mrite   ('Exp. Level : ');
      If USERI[NUM,3]<85 then Mriteln ('Apprentice.');
      If (USERI[NUM,3]<105) and (USERI[NUM,3]>84) then
        begin
          tcolor(green);
          Mriteln ('Footpad.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<125) and (USERI[NUM,3]>104) then
        begin
          tcolor(green);
          Mriteln ('Robber.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<145) and (USERI[NUM,3]>124) then
        begin
          tcolor(green);
          Mriteln ('Burglar.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<165) and (USERI[NUM,3]>144) then
        begin
          tcolor(yellow);
          Mriteln ('Cutpurse.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<185) and (USERI[NUM,3]>164) then
        begin
          tcolor(yellow);
          Mriteln ('Sharper.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<205) and (USERI[NUM,3]>184) then
        begin
          tcolor(magenta);
          Mriteln ('Pilferer.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<225) and (USERI[NUM,3]>204) then
        begin
          tcolor(magenta);
          Mriteln ('Thief.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<265) and (USERI[NUM,3]>224) then
        begin
          tcolor(cyan);
          Mriteln ('Master Thief.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<305) and (USERI[NUM,3]>264) then
        begin
          tcolor(cyan);
          Mriteln ('10th Level Master Thief.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<345) and (USERI[NUM,3]>304) then
        begin
          tcolor(blue);
          Mriteln ('11th Level Master Thief.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<385) and (USERI[NUM,3]>344) then
        begin
          tcolor(blue);
          Mriteln ('12th Level Master Thief.');
          tcolor(white);
        end;
      If (USERI[NUM,3]<455) and (USERI[NUM,3]>384) then
        begin
          tcolor(blue);
          Mriteln ('13th Level Master Thief.');
          tcolor(white);
        end;
      If USERI[NUM,3]>=455 then
        begin
          tcolor(red);
          Mriteln ('14th Level Master Thief.');
          tcolor(white);
        end;
      Mrite ('Gold       : ');
      tcolor(green); Send_Num(USERI[NUM,4]); tcolor(white);
      Mriteln('');
      Mrite ('Score      : ');
      Send_Num(USERI[NUM,5]);Mriteln('');
      Mrite ('Religion   : ');
      If USERI[NUM,19]=0 then Mriteln('None.');
      If USERI[NUM,19]=5 then
        begin
          tcolor(red);
          Mriteln('Balorian.');
          tcolor(white);
        end;
      If USERI[NUM,19]=11 then
        begin
          tcolor(Green);
          Mriteln('Catharian.');
          tcolor(white);
        end;
      If USERI[NUM,19]=21 then
        begin
          tcolor(cyan);
          Mriteln('Solnarian.');
          tcolor(white);
        end;
      Mrite   ('Water Tran.: '); tcolor(blue);
      AWVIEW(3,TEMP); tcolor(white);
      If TEMP>0 then Mrite ('. [');
      If TEMP>0 then Send_Num(TEMP*10);
      If TEMP>0 then Mrite(' Hull Pts.]');
      If CANON=True then Mrite (' (Catapult)');
      If MYSTIC then
        begin
          tcolor(yellow);
          Mrite(' -=/* Mystic Winds *\=-');
          tcolor(white);
        end;
      Mriteln('');
      Mrite ('Land Tran. : ');
      If USERI[NUM,16]=0 then Mriteln ('None.');
      If USERI[NUM,16]>0 then Begin
        Mrite (USERS[NUM,8]);
        Mrite(', -* ');
        tcolor(cyan);
        Mrite(USERS[NUM,9]);
        tcolor(white);
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



begin
end.