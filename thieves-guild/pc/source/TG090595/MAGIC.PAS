unit magic;

interface

uses crt,comunit,io,misc;

Procedure MAGICK(Var OVER:Boolean;Var SUN:longint);
Procedure WIZARDS(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);


implementation


(**  -/* USE A MAGICK ITEM *\- ********************************************)
  Procedure MAGICK(Var OVER:Boolean;Var SUN:longint);
    Var
      ATA,UNI:Boolean;
      CH1,SURE:str80;
      CH2,WHICH,IS,ELE:Integer;
    Begin
      If VT=True then
        begin
          vtModem(#27+'E');
          clrscr;
        end;
      ATA:=False;UNI:=True;
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
      If USERI[NUM,38]>0 then Begin
        If USERI[NUM,38]=1 then Mriteln('#38  A Parchment Map. [Un-Identified]');
        If USERI[NUM,38]=2 then Mriteln('#38  Map of Teleportation.');
        ATA:=True
       End;

      If (USERI[NUM,45]>0) then
        Begin
          if useri[num,45] <> 113 then
            begin
              tcolor(Red);
              Mriteln('#45  You are a hacking piece of crap!');
              tcolor(white);
            end
          else
            begin
              tcolor(yellow);
              Mriteln('#45  Mongo''s Right Hand');
              tcolor(white);
            end;
          ATA:=True
        End;

      If ATA=False then Mriteln('Thou hast no enchanted Items...')
      Else Begin
       Repeat
        Mriteln('');Mrite('Use which Item of magic? (0=none): ');
        Meadln(CH1);
        BUGPROOF(CH1,CH2)
       Until ((CH2>19) and (CH2<=45)) or (CH2=0);
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
         if (ch2=38) and (useri[num,38] > 0) then
           begin
             Mrite('Gaze at the map? ');WHAT(SURE);
             If SURE='Y' then
               Begin
                 Mriteln('');Mriteln('Thou dost invoke map''s powers of teleportation...');
                 USERI[NUM,38]:=2;
                 mriteln('Hmmm, nothing seems to have happened!  Hahahaha!!!');
                 repeat
                   useri[num,14] := drandom mod 25 + 1;
                 until useri[num,14] <> ShadyBrook;
               end;
           end;
         if (ch2=45) and (useri[num,45] = 113) then
           begin
             Mrite('Use Mongo''s Right Hand? ');
             WHAT(SURE);
             If SURE='Y' then
               Begin
                 mriteln('');
                 mriteln('This does not do anything, IDIOT!');
                 mriteln('');
               end;
           end;
         if (ch2=45) and (useri[num,45] > 0) and (useri[num,45] <> 113) then
           begin
             Mrite('Use the Hacker''s Wand? ');
             WHAT(SURE);
             If SURE='Y' then
               Begin
                 mriteln('');
                 mriteln('No hacking allowed!!!');
                 mriteln('');
                 stop;
                 halt(16);
               end;
           end;

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
  Procedure WIZARDS(Var NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      SKILL,RIGHT,WHICH,COND,IS,QUICKIE,UNIFIGURE:Integer;
      GOLD,DUMB,HITSELL:longint;
      WISH,SKILLS,SURE,ME:str80;
      WRONG,UNI,UNICURSE:Boolean;
      townColor : Integer;

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
          vtModem(#27+'b1');
        end;


           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],8]);
           tcolor(white);


      If VT=True then
        begin
          vtModem(#27+'b3');
        end;
      Mriteln(' *=- Wizard''s Guild.');
      Mriteln('');
      Mriteln (TOWNS[USERI[NUM,14],9]);
      Mriteln ('The Wizard approaches thee, "What is thy Wish?"');
      Mriteln('');
      If USERI[NUM,14]=19 then
        begin
          tcolor(magenta);
          Mriteln (' [0] Ship Enchantment <Mystic Winds> ..8000 G.P.');
          tcolor(white);
        end;
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
        tcolor(green);
        Mriteln(' [8] Global Search ....................6500 G.P.');
        Mriteln(' [9] Universal Curse ..................7500 G.P.');
        Mriteln('[10] Universal Mind Read ..............1500 G.P.');
        Mriteln('[11] Teleport Item ....................200 G.P.');
        Mriteln('[12] Kill Assassin ....................5000 G.P.');
        Mriteln('[13] Transport ........................6000 G.P.');
        Mriteln('[14] Location .........................1000 G.P.');
        tcolor(white);
       End;
      End;
      If (USERI[NUM,19]=5) and (TOWNI[USERI[NUM,14],19]<3) then Begin
       EM_SEND(1059);
       If EMULATE=False then Begin
         tcolor(red);
        Mriteln(' [8] Sleep Spell ......................5000 G.P.');
        Mriteln(' [9] Universal Curse  .................7500 G.P.');
        Mriteln('[10] Universal Mind Read ..............1500 G.P.');
        Mriteln('[11] Balorian Gaze of Death!!! ........30000 G.P.');
        Mriteln('[12] Kill Assassin ....................5000 G.P.');
        Mriteln('[13] Mind Crush .......................10000 G.P.');
        Mriteln('[14] Location .........................1000 G.P.');
         tcolor(white);
        End;
       End;
      If (USERI[NUM,19]=21) and (TOWNI[USERI[NUM,14],19]>3) then Begin
       EM_SEND(1060);
       If EMULATE=False then Begin
        tcolor(cyan);
        Mriteln(' [8] Invisibility .....................1000 G.P. per Day');
        Mriteln(' [9] Anti-Theft .......................2000 G.P. per Day');
        Mriteln('[10] Increase Hit Points ..............750 G.P.');
        Mriteln('[11] Teleport Item ....................200 G.P.');
        Mriteln('[12] Enchant Weapon/Armour ............3000 G.P.');
        Mriteln('[13] Transport ........................6000 G.P.');
        Mriteln('[14] Location .........................1000 G.P.');
        tcolor(white);
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
        If VT=True then
          begin
            vtModem(#27+'E');
            clrscr;
          end;
        Mriteln('');Mriteln ('A Sign Says:  ');
        Mriteln('');Mrite ('Sorry, The ');


           townColor := useri[num,14] + 2;
           townColor := townColor mod 6 + 1;
           if townColor = brown then towncolor := yellow;
           tcolor(townColor);
           Mrite (TOWNS[USERI[NUM,14],8]);
           tcolor(white);



        Mriteln(' Guild is not open to Visitors at this Time...');
        DISTIME(TOWNI[USERI[NUM,14],11],RIGHT);
        Mriteln('');
        Mrite ('Our Hours are ');
        tcolor(red);
        Send_Num (RIGHT);
        If TOWNI[USERI[NUM,14],11]>12 then Mrite (' P.M. to ');
        If TOWNI[USERI[NUM,14],11]<13 then Mrite (' A.M. to ');
        DISTIME(TOWNI[USERI[NUM,14],12],RIGHT);
        Send_Num(RIGHT);
        If TOWNI[USERI[NUM,14],12]>12 then Mrite (' P.M.');
        If TOWNI[USERI[NUM,14],12]<13 then Mrite (' A.M.');
        tcolor(white);
        Mriteln('');Mriteln ('Please come again Later...');
        STOP;
        Mriteln('')
      End
    End;


begin
end.