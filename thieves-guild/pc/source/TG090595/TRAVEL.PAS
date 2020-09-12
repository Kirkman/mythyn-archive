unit travel;

interface

uses crt, io,misc,shoppes,shoppes2,magic,comunit;


Procedure SHIPS;
Procedure OCEAN(Var NUM:Integer;Var WIND:Integer;Var C:str80);
Procedure doTravel(Var NUM:Integer;Var WIND:Integer;Var OVER:Boolean;Var SUN:longint);

implementation



  Procedure SHIPS;
    Var
      PICK,PRICE,R:Integer;
      GOLD,PICKS:str80;
    Begin
     EM_SEND(425);EM_SEND(301);
     R:=DRANDOM mod 21+1;
     Repeat
      If VT=True then
        begin
          vtmodem(Chr(27)+'E');
          clrscr;
        end;
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
      If R=21 then
        begin
          mrite (' ['); tcolor(red); mrite('11'); tcolor(white); mriteln('] Buy a Catapult. - 2,000 G.P.');
        end;
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

procedure ocean(var num:integer; var wind:integer; var c:str80);

  var
    junk,sel:str80;
    gold,ran:Integer;
    townColor : integer;

  begin
      If WIND>0 then Begin
        RAN:=DRANDOM Mod 3+1;
        If RAN=3 then WIND:=DRANDOM Mod 12+1
       End;
      If WIND=0 then WIND:=DRANDOM Mod 12+1;
     If OCE=False then EM_SEND(131);OCE:=True;EM_SEND(405);EM_SEND(301);
     Repeat
      If VT=True then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
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
        tcolor(cyan);
        Mriteln ('The Moon glows mystically in the Star-scattered sky as');
        Mriteln ('thou walketh the deserted beach.');
        tcolor(white);
       End;
      If (USERI[NUM,6]<3) or (USERI[NUM,6]>17) then Begin
        tcolor(yellow);
        Mriteln ('The Sun shines bright overhead, warming the sand upon the Beach.  The White,');
        Mriteln ('Puffy clouds float across the sky.');
        tcolor(white);
       End;
      If (USERI[NUM,6]<7) and (USERI[NUM,6]>2) then Begin
        tcolor(red);
        Mriteln ('Dawn.  A seagull heralds the  Sun''s reappearance with');
        Mriteln ('a cry of ecstasy.  The Sun''s light is reflected over the');
        Mriteln ('Ocean...');
        tcolor(white);
       End;
      Mriteln('');
      Mrite('Thou art at the ');

           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],1]);
           tcolor(white);

      Mriteln(' Harbor.');
      Mriteln('');
      Mriteln('What would''st thou like to do?');
      Mriteln('');
      Mriteln('   +=========================+');
      Mrite('   | ['); tcolor(green); mrite('1'); tcolor(white); mriteln('] Prepare to Sail!    |');
      Mrite('   | ['); tcolor(magenta); mrite('2'); tcolor(white); mriteln('] Talk to a Merchant. |');
      Mrite('   | ['); tcolor(yellow); mrite('3'); tcolor(white); mriteln('] Go back to town.    |');
      Mriteln('   +=========================+');
      ABLE:=False;SOFF:=False;
      Mriteln(''); tcolor(cyan); Mrite ('The Blue Waves crash upon the shore: '); tcolor(white);
      Meadln(C);
      Mriteln('');
     Until (C='1') or (C='2') or (C='3')
    End;
(**************************************************************************)
  Procedure doTravel(Var NUM:Integer;Var WIND:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      JUNK,JUNKS,TEMPS,CH,C:str80;
      A,FH,G,GOT,DUMB,SAILORS,EXCEPT,SHA,WHI,STO,COUNT,PLAY1,
      PLAY2,ENC,WGOT,PIR,SEA,SQU,SHK:Integer;
      D,T:Array[1..3] of Integer;
      ENOUGH,CANON,TURN,DIDIT:Boolean;
      PRICE:longint;
    Begin
      CANON:=False;HALF:=True;DIDIT:=False;
      TEMPS:='  ';
      If VT=True then
        begin
          vtmodem(Chr(27)+'E');
          clrscr;
        end;
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


begin
end.