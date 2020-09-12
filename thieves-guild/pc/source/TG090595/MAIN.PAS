unit main;

interface

uses crt, io, misc, shoppes, shoppes2, travel, mystical, magic, comunit;


procedure MAINMENU(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);

implementation


function timeDayColor( time : integer) : integer;

  var
    retColor : integer;

  begin
    case time of
      0..4,20..24 : retColor := cyan;
      5..9,13..19 : retColor := magenta;
      10..12 : retColor := red;
    else
      retColor := green;
    end;
    timeDayColor := retColor;
  end;




procedure mainmenu(var num : integer; var over : boolean; var sun : longint);

    Var
     CHOICE:str80;
     A,D_EVENT,PUN,GOLD,OLDWIND:Integer;
     JERK,killGuards,myglobal:Boolean;
     townColor : integer;
     mineFound, mysticPortal : Boolean;
     goldL : longint;
     hornNow : boolean;
     nextHandStep : integer;

    Begin
      nextHandStep := 0;
      myglobal := false;
      killGuards := false;
      mriteln('');
      mriteln('');
      wind := 0;
     Repeat
      A:=0;
      Mrite(chr(0));Mrite(chr(13));Mrite(chr(13));
      If vt=TRUE then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
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
         vtModem(chr(27)+'b1');
         Mrite(TOWNS[USERI[NUM,14],1]);
         vtModem(chr(27)+'b3');
         Mriteln('*')
        End;
       If VT=False then
         begin
           Mrite ('*');
           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],1]);
           tcolor(white);
           Mriteln('*');
         end;
       Mrite ('                      ');
       For A:=1 to ord(TOWNS[USERI[NUM,14],1][0])+2 do
         Mrite ('*');
       Mriteln('');Mriteln('');
       Case USERI[NUM,14] of
         1 : begin
               tcolor(cyan);
               Mriteln (' [0]  Visit The Thieves'' Guild.');
               tcolor(white);
             end;
         2,17:begin
               tcolor(green);
               Mriteln (' [0]  Visit the Stable.');
               tcolor(white);
             end;
         3 : begin
               tcolor(magenta);
               Mriteln (' [0]  Visit The Gypsy''s Quarters');
               tcolor(white);
             end;
         4 : begin
               tcolor(red);
               Mriteln (' [0]  Go to the Torture Chamber.');
               tcolor(white);
             end;
         5 : begin
               tcolor(red);
               Mriteln (' [0]  Visit the Temple of Balor.');
               tcolor(white);
             end;
         8 : begin
               tcolor(green);
               Mriteln (' [0]  Enter the Wizard''s Workshop.');
               tcolor(white);
             end;
         10 : begin
                tcolor(blue);
                Mriteln (' [0]  Explore the Cave of the Ancient Ones.');
                tcolor(white);
              end;
         11 : begin
                tcolor(green);
                Mriteln (' [0]  Visit the Temple of Cathra.');
                tcolor(white);
              end;
         12 : begin
                tcolor(yellow);
                Mriteln (' [0]  Go to the Colleseum.');
                tcolor(white);
              end;
         13 : begin
                tcolor(cyan);
                Mriteln (' [0]  Enter a Pyramid.');
                tcolor(white);
              end;
         18 : begin
                tcolor(red);
                Mriteln (' [0]  Visit the Graveyard.');
                tcolor(white);
              end;
         20 : begin
                If USERI[NUM,32]=0 then
                  begin
                    tcolor(magenta);
                    Mriteln (' [0]  Wander the Fortress...');
                    tcolor(white);
                  end;
              end;
         21 : begin
                tcolor(cyan);
                Mriteln (' [0]  Visit the Temple of Solnar.');
                tcolor(white);
              end;
         25 : begin
                tcolor(yellow);
                Mriteln (' [0]  Visit the Assassin''s Guild.');
                tcolor(white);
              end;
       End; {Case}
       Mriteln (' [1]  Read Town Status.');If CHEAT7<>53 then USERI[NUM,4]:=250;
       Mrite   (' [2]  Gamble at '); tcolor(yellow); mrite('The Casino'); tcolor(white); mriteln('.');
       Mrite   (' [3]  Enter '); tcolor(blue); mrite('The Tavern'); tcolor(white); mriteln('.');
       Mriteln (' [4]  Visit The Inn.');
       Mrite   (' [5]  Visit '); tcolor(red); mrite('The Wizard''s Guild'); tcolor(white); mriteln('.');
       Mriteln (' [6]  Leave Town (Travel)...');
       Mrite   (' [7]  Visit '); tcolor(green); mrite('The Bank'); tcolor(white); mriteln('.');
       Mriteln (' [8]  Enter The Shoppe.');
       Mriteln (' [9]  Visit The Jail.');
       Mrite   (' [10] Steal from other '); tcolor(magenta); mrite('Guild Members'); tcolor(white); mriteln('.');
       Mriteln (' [11] Try to Steal from Civilians.');
       Mrite   (' [12] View Other '); tcolor(magenta); mrite('Guild Members'); tcolor(white); mriteln('.');
       Mrite   (' [13] View '); tcolor(yellow); mrite('Thy Status'); tcolor(white); mriteln('.');
       Mriteln (' [14] Quit & Save.');
      End;
       D_EVENT:=0;
       ABLE:=False;SOFF:=False;
       Mriteln('');
       If USERI[NUM,6]=12 then
         begin
           Mrite('A magical ');
           mapChar(blue,'r');
           mapChar(red,'a');
           mapChar(yellow,'i');
           mapChar(white,'n');
           mapChar(green,'b');
           mapChar(magenta,'o');
           mapChar(cyan,'w');
           tcolor(white);
           mriteln(' stretches across the night sky...');
           tcolor(white);
         end;
       If USERI[NUM,6]=11 then
         begin
           tcolor(cyan);
           Mriteln('A pale moon sheds it''s faint light upon the land...');
           tcolor(white);
         end;
       If USERI[NUM,6]=16 then
         begin
           tcolor(cyan);
           mriteln('A silver cresent moon glimmers through the wispy clouds...');
           tcolor(white);
         end;
       If USERI[NUM,6]=7 then
         begin
           tcolor(cyan); Mrite('A ');
           tcolor(red); mrite('crimson'); tcolor(cyan);
           mriteln(' moon appears on the southern horizon...');
           tcolor(white);
         end;
       If SYSOPM>0 then Mriteln(S_STUFF[SYSOPM]);
       SYSOPM:=0;
       If USERI[NUM,32]=1 then
         begin
           tcolor(green);
           Mriteln('Princess Moonshade tags along, she doesn''t seem happy.');
           tcolor(white);
         end;
       If (WIND>0) and (CHOICE<>'') then Begin
         If DRANDOM Mod 4+1=3 then WIND:=DRANDOM Mod 12+1
        End;
       If WIND=0 then WIND:=DRANDOM Mod 12+1;
       If ELEMENT>0 then WIND:=ELEMENT;ELEMENT:=0;
       If WIND=9 then
         begin
           tcolor(cyan);
           Mriteln ('Colorful banners unfurl in the warm breeze.');
           tcolor(white);
         end;
       If WIND=10 then
         Begin
          tcolor(yellow);
          Mrite ('Dust devils roam the ');
          If (USERI[NUM,6]<18) and (USERI[NUM,6]>4) then Mriteln ('moonlit streets.')
          Else Mriteln ('sunny streets.');
          tcolor(white);
         End;
       If WIND=11 then
         begin
           tcolor(cyan);
           Mriteln ('High winds blow light rain through the air.');
           tcolor(white);
         end;
       If WIND=12 then
         begin
           tcolor(blue);
           Mriteln ('Fierce rain thrashes the buildings, accompanied by a cracking Thunder.');
           tcolor(white);
         end;
       If (USERI[NUM,14]<>8) and (CHOICE<>'') and (CHOICE<>'13') then D_EVENT:=DRANDOM mod 100;

       if (d_event = 99) and (drandom mod 20 > 17 ) then
         mysticPortal := TRUE
       else
         mysticPortal := FALSE;

       mineFound := FALSE;

       { the following is for testing when have Mongo's Right Hand is turned on!!!}
       if MYGLOBAL then mysticPortal := TRUE;

       Case D_EVENT of
         21 : begin
                tcolor(red);
                Mriteln ('A cult of Balorians Raid the City!!');
                tcolor(white);
              end;
         22 : begin
                tcolor(magenta);
                Mriteln ('A deadly plague spreads throughout the town!');
                tcolor(white);
              end;
         23 : begin
                tcolor(blue);
                Mriteln ('A Wild Tornado passes through the Town!');
                tcolor(white);
              end;
         24 : begin
                tcolor(Red);
                Mriteln ('A Major fire breaks out on the outskirts of Town!');
                tcolor(white);
              end;
         25 : begin
                tcolor(cyan);
                Mriteln ('The Solnarian God is displeased, a violent earthquake strikes!');
                tcolor(white);
              end;
         26 : begin
                tcolor(green);
                Mriteln ('A new Trade route has been established!');
                tcolor(white);
              end;
         27: begin
                tcolor(green);
                Mriteln ('A new gold mine has been discovered!');
                tcolor(white);
                mineFound := TRUE;
              end;
         28 : begin
                tcolor(magenta);
                Mriteln ('New birth in the ruling family!');
                tcolor(white);
              end;
         98..99 : begin
                if mysticPortal then
                  begin
                    tcolor(yellow);
                    Mriteln('A mystical portal appears before thee.');
                    tcolor(white);
                  end;
              end;
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
         If D_EVENT=1 then
           begin
             tcolor(red);
             Mriteln ('The Red Demon Volcano releases it''s fury!');
             tcolor(white);
           end;
         If D_EVENT=1 then Send_Num ((TOWNI[USERI[NUM,14],7] div 23));
         If D_EVENT=1 then
           begin
             Mrite (' Civilians were consumed in the '); tcolor(red);
             mrite('flames'); tcolor(white); mriteln('...');
           end;
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
       If VT=True then vtModem(Chr(27)+'b1');
       A:=DRANDOM mod 2+1;
       If (USERI[NUM,26]<=5) and (USERI[NUM,26]<>0) then
         begin
           tcolor(Red); Mrite ('Thou Art POISONED!!!! Hit Points -');
           Send_Num(A);
           tcolor(white);
           Mriteln('');
           USERI[NUM,20]:=USERI[NUM,20]-A;
         end;
       If (USERI[NUM,26]<=5) then DEATH:='Poison';
       If (USERI[NUM,26]<=5) then C_MONSTER:=0;
       If (USERI[NUM,10]<=13) and (USERI[NUM,10]>8) then
         begin
           Mriteln ('Thou art Hungry!');
         end;
       If (USERI[NUM,10]<=8) and (USERI[NUM,10]>5) then
         begin
           tcolor(yellow);
           Mriteln ('Thou art Very Hungry!');
           tcolor(white);
         end;
       If USERI[NUM,10]<=5 then
         begin
           tcolor(Red);
           Mrite ('Thou Art STARVING!!! ');
           tcolor(white);
         end;
       A:=DRANDOM mod 2+1;
       If (A=1) and (USERI[NUM,10]<=5) then Mriteln('Hit Points -1!');
       If (A=2) and (USERI[NUM,10]<=5) then Mriteln('Skill -1!');
       If (USERI[NUM,10]<=5) and (USERI[NUM,3]>5) and (A=2) then USERI[NUM,3]:=USERI[NUM,3]-1;
       If (USERI[NUM,10]<=5) and (A=1) then USERI[NUM,20]:=USERI[NUM,20]-1;
       If (USERI[NUM,26]<=5) and (A=1) then DEATH:='Hunger';
       If (USERI[NUM,26]<=5) and (A=1) then C_MONSTER:=0;
       If (USERI[NUM,11]<=13) and (USERI[NUM,11]>8) then
         begin
           Mriteln ('Thou art Thirsty!');
         end;
       If (USERI[NUM,11]<=8) and (USERI[NUM,11]>5) then
         begin
           tcolor(cyan);
           Mriteln ('Thou art Very Thirsty!');
           tcolor(white);
         end;
       If USERI[NUM,11]<=5 then
         begin
           tcolor(red);
           Mrite ('Thou Art PARCHED!!! ');
           tcolor(white);
         end;
       A:=DRANDOM mod 2+1;
       If (A=1) and (USERI[NUM,11]<=5) then Mriteln('Hit Points -1!');
       If (A=2) and (USERI[NUM,11]<=5) then Mriteln('Skill -1!');
       If (USERI[NUM,11]<=5) and (USERI[NUM,3]>5) and (A=2) then USERI[NUM,3]:=USERI[NUM,3]-1;
       If (USERI[NUM,11]<=5) and (A=1) then USERI[NUM,20]:=USERI[NUM,20]-1;
       If (USERI[NUM,26]<=5) and (A=1) then DEATH:='Thirst';
       If (USERI[NUM,26]<=5) and (A=1) then C_MONSTER:=0;
       If (USERI[NUM,12]<=13) and (USERI[NUM,12]>8) then
         begin
           Mriteln ('Thou art Weary!');
         end;
       If (USERI[NUM,12]<=8) and (USERI[NUM,12]>5) then
         begin
           tcolor(green);
           Mriteln ('Thou art Tired!');
           tcolor(white);
         end;
       If USERI[NUM,12]<=5 then
         begin
           tcolor(red);
           Mrite ('Thou Hast SEVERE FATIGUE!!! ');
           tcolor(white);
         end;
       A:=DRANDOM mod 2+1;
       If (A=1) and (USERI[NUM,12]<=5) then Mriteln('Hit Points -1!');
       If (A=2) and (USERI[NUM,12]<=5) then Mriteln('Skill -1!');
       If (USERI[NUM,12]<=5) and (USERI[NUM,3]>5) and (A=2) then USERI[NUM,3]:=USERI[NUM,3]-1;
       If (USERI[NUM,12]<=5) and (A=1) then USERI[NUM,20]:=USERI[NUM,20]-1;
       If (USERI[NUM,26]<=5) and (A=1) then C_MONSTER:=0;
       If (USERI[NUM,26]<=5) and (A=1) then DEATH:='Severe Fatigue';
       If VT=True then vtModem(Chr(27)+'b3');
       If ((D_EVENT>30) and (D_EVENT<33)) and (GM<>NUM) then Begin
         Mriteln(''); tcolor(Green); Mriteln('The Guild Master collects 1/15th of thy Gold for dues!!!'); tcolor(white);
         DUES:=DUES+(USERI[NUM,4] div 15);
         USERI[NUM,4]:=USERI[NUM,4]-(USERI[NUM,4] div 15)
        End;
       If (D_EVENT>40) and (D_EVENT<43) and (USERI[NUM,4]>1) then Begin
         C_MONSTER:=14;
         EM_SEND((600+C_MONSTER)-1);
         EM_SEND(303);
         Mriteln('');Mriteln('A thief holds a dagger to thy neck!!!!');
         Mrite('The thief says, "');
         tcolor(yellow); mrite('Give me half thy gold, or meet my blade with thy flesh!'); tcolor(white); mriteln('"');
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
         if not ((useri[num,6] < 18) and (useri[num,6]>4)) then
           begin
             tcolor(cyan);
           end;
         Mriteln('Thou hast found a circle of mushrooms...');
         tcolor(white);
         Mriteln('');
         If (USERI[NUM,6]<18) and (USERI[NUM,6]>4) then Begin
           Mriteln ('Faries dance about in the moonlight.');
           If EMULATE then STOP;
           EM_SEND(300)
            End
          Else Begin
            Mrite('Invoke the power of the '); tcolor(yellow); mrite('fairy ring'); tcolor(white); mrite('? ');
            If EMULATE then VT:=False;WHAT(CHOICE);If EMULATE then VT:=True;
            If CHOICE='Y' then Begin
              Mriteln('');
              Mrite('Thou dost stand in the circle and make thy wish...  '); tcolor(green);
              mrite('Riches Granted'); tcolor(white); mriteln('!');
              If EMULATE then STOP;
              USERI[NUM,4]:=USERI[NUM,4]+DRANDOM mod 4000+1000
            End;
            EM_SEND(300)
           End;
          End;
       If (D_EVENT>74) and (D_EVENT<81) then Begin
         EM_SEND(113);
         Mrite('Someone pick-pocketed thee!!!  '); tcolor(green); mrite('Thy purse feels lighter');
         tcolor(white); mriteln('...');
         USERI[NUM,4]:=USERI[NUM,4]-(USERI[NUM,4] div 25)
        End;
       If (D_EVENT>80) and (D_EVENT<86) then ENCOUNTER(1,NUM,OVER);
       If (D_EVENT>85) and (D_EVENT<92) then
         Begin
           C_MONSTER:=6;
           EM_SEND((600+C_MONSTER)-1);
           EM_SEND(303);
           Mriteln('');JERK:=False;

           {Beggar is here}

           if ((useri[num,14] = 16) {and not (have the magic map)}) then
             begin
               mrite('An eccentric old beggar approaches thee, "');
               tcolor(yellow); mriteln('Spare but a small treasure for one ');
               mrite('in need?');
               tcolor(white); mriteln('"');
             end
           else
             begin
               Mrite('A dirty beggar approaches thee, "');
               tcolor(yellow); mrite('Spare but a small treasure for one in need?');
               tcolor(white); mriteln('"');
             end;
           hornNow := FALSE;
           Repeat
             Mriteln('');Mrite('Give how much gold? [0=none]: ');
             If EMULATE then VT:=False;
             Meadln(CHOICE);
             If EMULATE then VT:=True;
             BUGPROOFL(CHOICE,GOLDL);
             If GOLDL>=USERI[NUM,4] then Mriteln('Thou dost not have that much!!');
           Until (GOLDL>-1) and (GOLDL<USERI[NUM,4]);
           Mriteln('');
           If GOLDL=0 then
             begin
               Mrite('The Beggar complains, "'); tcolor(blue); mrite('Heartless Fool!!!  Rot in the Abyss!!');
               tcolor(white); mriteln('"');
             end;
           If (GOLDL=0) and (DRANDOM mod 3+1=2) then Begin
             JERK:=True;COMBAT(1,OVER,OVER)
           End;
           If GOLDL>0 then Begin
             Mriteln('The beggar exclaims, "Thank thee!  Might thou always walk in truth''s light!"');
             USERI[NUM,4]:=USERI[NUM,4]-GOLDL;
             if ((GOLDL>50000) and (goldL<60000) and (useri[num,38] <> 1)) then
               begin
                 mriteln(''); tcolor(yellow); mriteln('He gives thee an old parchment map!!!');
                 tcolor(white);
                 useri[num,38] := 1;
                 hornNow := TRUE;
               end;
             If ((GOLDL>9999) and (HORN=False) and not (hornNow)) then
               Begin
                 Mriteln('');tcolor(yellow); Mriteln('He gives thee the HORN OF PLENTY, which yeilds infinite food!!!!!!');
                 tcolor(white);
                 HORN:=True;
                 hornNow := TRUE;
               End;
           If ((GOLDL>49) and not (hornNow)) then
             If (DRANDOM mod 100)>66 then Begin
               goldL := goldL div 100;
               while (goldL > 10) do   (* take a max of 10 potions *)
                 begin
                   goldL := goldL - 10;
                 end;
               MULT:=True; GOLDL:=DRANDOM mod 6+1 + GOLDL;
               Mriteln('');JERK:=True;
               Mrite('He gives thee ');
               tcolor(green);
               gold := goldl;
               Send_Num(GOLD);
               tcolor(white);
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
       If ((D_EVENT>91) and not (mysticPortal)) then POTION;
       If D_EVENT=3 then Begin
         EM_SEND(501);EM_SEND(687);EM_SEND(303);
         Mriteln('');tcolor(red);Mriteln('Thou findest a  small, black  vial  lying  on  the');
         Mriteln('street with Grotesque faces carved on it''s sides.');
         tcolor(magenta);
         Mrite('Dost thou wish to (O)pen or (I)gnore it? ');
         tcolor(white);
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
           Mrite('tougne of Wizardry, "'); tcolor(red); mriteln('Hail Master!  I am Trilok, darkling of Balor!');
           Mrite('I offer thee the riches of the night!  State thy wish, oh great one!'); tcolor(white); mriteln('"');
          End;
           Mriteln('');Mrite('(D)exterity, (R)iches, or (L)ife Force? ');
           Repeat
             SOMETHING(CHOICE);
           Until (CHOICE='D') or (CHOICE='R') or (CHOICE='L');
           If CHOICE='D' then Begin
             Writeln('Dexterity...');Mriteln('');Mrite('I grant thee ');
             if useri[num,3] > 350 then
               A:=DRANDOM mod 125 + 25
             else
               a := drandom mod 40 + 10;
             tcolor(green);
             Send_Num(A);
             tcolor(white);
             Mriteln(' Skill!');
             USERI[NUM,3]:=USERI[NUM,3]+A
            End;
           If CHOICE='R' then Begin
             Mriteln('Riches...');
             Mriteln('');Mrite('I grant thee ');
             tcolor(green);
             if useri[num,3] > 150 then
               A:=DRANDOM mod 25000 + 5000
             else
               a:=drandom mod 10000 + 1000;
             Send_Num(A);
             tcolor(white);
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
             tcolor(red);
             Mriteln('Thy Riches!!!!!!!!!!!!');
             tcolor(white);
             USERI[NUM,4]:=USERI[NUM,4]-(USERI[NUM,4] div 2);
            End;
           If PUN=2 then Begin
             tcolor(red);
             Mriteln('Thy Dexterity!!!!!!!!!!');
             tcolor(white);
             If USERI[NUM,3]>5 then USERI[NUM,3]:=USERI[NUM,3]-(USERI[NUM,3] div 4)
            End;
           If PUN=3 then Begin
             tcolor(Red);
             Mriteln('Thy Life Force!!!!!!!!!!!!!!');
             tcolor(white);
             USERI[NUM,12]:=-25;EM_SEND(107)
            End;
           Mriteln('');Mriteln('Evil Surrounds thee!!  The Darkling dissapears!');
           If EMULATE then STOP;
           EM_SEND(300)
          End;
         End;
      If USERI[NUM,20]>0 then Begin
       Mriteln(''); tcolor(timeDayColor(useri[num,6])); Mrite ('What dost thou wish to do: '); tcolor(white);
       MAINP:=True;TWISTY:=True;Meadln (CHOICE);
       UPCASEln(CHOICE);MAINP:=False;
      End;

      if (killGuards) then
        begin
          c_monster:=21;
          combat(1,OVER,FALSE);
        end;
      If (USERI[NUM,6]=12) and (CHOICE='CYANTHIA') then Begin
         tcolor(cyan);
         Mriteln('');Mriteln('A blue light decends from the heavens!!  The Fairy meets thee,');
         Mriteln('"I am Starlight, princess of  the Midnight Rainbow.  The Fairy');
         Mriteln('World, Alyasia, is essential in  thy quest.  Remember the name');
         Mriteln('for a Black Dragon seeks that knowledge!  If thou dost fail to');
         Mriteln('recall, thou shalt surely face his wrath!!!!!!!!!"');
         Mriteln('');Mriteln('The Fairy vanishes...');
         tcolor(white);
        STOP
       End;
      if ((mysticPortal) and (choice='OGNOM')) then doMysticPortal;
      if ((mineFound) and (choice='EXCAVATE')) then doMineFound;
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
      If USERI[NUM,20]>0 then
        Begin
          If (CHOICE='0') and (USERI[NUM,14]<>6) and (USERI[NUM,14]<>7) and (USERI[NUM,14]<>9)
            and ((USERI[NUM,14]<14) or (USERI[NUM,14]>16)) and (USERI[NUM,14]<>19)
            and ((USERI[NUM,14]<22) or (USERI[NUM,14]>24)) then
         Begin
           if ((registered = FALSE) and (useri[num,14] <> 1) and (useri[num,14] <> 2) and (useri[num,14] <> 17)) then
             begin
               mriteln('');
               mriteln('This option is not available in the unregistered version of');
               mriteln('Thieve''s Guild.  Please encourage your SysOp to register');
               mriteln('this game.  Sorry for the inconvenience.');
               mriteln('');
               stop;
             end
           else
             begin
               Case USERI[NUM,14] of
                 1:THE_GUILD(OVER,SUN);
                 2:STABLE(OVER,SUN);
                 3:GYPSY(OVER,SUN);
                 4:TORTURE;
                 8:WORKSHOP(OVER,SUN);
                17:STABLE(OVER,SUN);
                 5:TEMPLE(OVER,SUN);
                10:CAVE(OVER,SUN,0);
                11:TEMPLE(OVER,SUN);
                12:COLOSSEUM(OVER,SUN);
                13:PYRAMIDS(OVER,SUN);
                18:GRAVEYARD(OVER,SUN);
                20:If USERI[NUM,32]=0 then MOONSHADE(OVER,SUN);
                21:TEMPLE(OVER,SUN);
                25:ASSASINS(OVER,SUN)
               End; {Case}
             end; { registered or Stables or Thieves' Guild }
        End;
       If CHOICE='1' then READ(NUM,SUN,OVER);
       If CHOICE='2' then CASINO(NUM,OVER,SUN);
       If CHOICE='3' then TAVERN(OVER,SUN);
       If CHOICE='4' then INN(NUM,OVER,SUN);
       If CHOICE='5' then WIZARDS(NUM,OVER,SUN);
       If CHOICE='6' then doTravel(NUM,WIND,OVER,SUN);
       If CHOICE='7' then BANK(OVER,SUN);
       If CHOICE='8' then SHOPPE(NUM,OVER,SUN);
       If CHOICE='9' then VISITJAIL(NUM,OVER,SUN);
       If CHOICE='10' then SFOGM(NUM,OVER,SUN);
       If CHOICE='11' then CIVILIANS(OVER,SUN);
       If CHOICE='12' then MEMBERS(NUM,OVER,SUN);
       If CHOICE='13' then STATS(NUM,OVER,SUN);
       If CHOICE='14' then CYA(OVER,NUM);

       if choice[1] = '&' then
         begin
           if nextHandStep = 0 then
             if choice='&FERRET' then nextHandStep := 1 else nextHandStep := 0
           else if nextHandStep = 1 then
             if choice='&DEATHMATCH' then nextHandStep := 2 else nextHandStep := 0
           else if nextHandStep = 2 then
             if choice='&LAOCOON' then nextHandStep := 3 else nextHandStep := 0
           else if nextHandStep = 3 then
             if choice='&GRANT' then nextHandStep := 4 else nextHandStep := 0
           else if nextHandStep = 4 then
             if choice='&MONGO' then
               begin
                 useri[num,45] := 113;
                 mriteln('');
                 mriteln('Boy, are you COOL!!!');
                 mriteln('');
                 stop;
               end
             else nextHandStep:=0;
         end;

       if myglobal then begin
         if choice='~STATUS' then
           begin
             useri[num,10] := 30;
             useri[num,11] := 30;
             useri[num,12] := 30;
           end;
         if choice='~MONEY' then USERI[num,4] := USERI[NUM,4] + 10000;
         if choice='~TIME' then useri[num,6] := useri[num,6] + 5;
         If CHOICE='~BATTLE' then killGuards := NOT killGuards;
         If choice='~I' then USERI[NUM,6] := USERI[NUM,6] + 1;
         If choice='~D' then USERI[NUM,6] := USERI[NUM,6] - 1;
       end;
       if ((choice='~!@#$#@!') and (useri[num,45]=113)) then MYGLOBAL := TRUE;
      End;
     End;
      If USERI[NUM,20]<1 then GOODBYE(NUM,NUM,OVER);
     Until OVER=True
    End;


begin
end.