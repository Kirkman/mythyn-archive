unit shoppes;

interface

uses crt,comunit,io,misc,shoppes2;

Procedure CIVILIANS(Var OVER:Boolean;Var SUN:longint);
Procedure FINAL(Var OVER:Boolean;Var SUN:longint);
Procedure CAVE(Var OVER:Boolean;Var SUN:longint; whichCave : integer);
Procedure PYRAMIDS(Var OVER:Boolean;Var SUN:longint);
Procedure WORKSHOP(Var OVER:Boolean;Var SUN:longint);
Procedure GRAVEYARD(Var OVER:Boolean;Var SUN:longint);
Procedure ASSASINS(Var OVER:Boolean;Var SUN:longint);
Procedure TEMPLE(Var OVER:Boolean;Var SUN:longint);
Procedure MOONSHADE(Var OVER:Boolean;Var SUN:longint);
Procedure THE_GUILD(Var OVER:Boolean;Var SUN:longint);
Procedure STABLE(Var OVER:Boolean;Var SUN:longint);
Procedure GYPSY(Var OVER:Boolean;Var SUN:longint);
Procedure COLOSSEUM(Var OVER:Boolean;Var SUN:longint);
Procedure TORTURE;



implementation


(**************************************************************************)
  Procedure CIVILIANS(Var OVER:Boolean;Var SUN:longint);
    Var
      POPS,HOWLONG,COUNT,COUNT1,GUA,RANDOM,GOLD,OTHER,BACK,POUCH,SACK,RAN,POT:Integer;
      SURE,OUTFIT,WILL:str80;
      CONT,TEMPEM:Boolean;
    Begin
      POPS:=TOWNI[USERI[NUM,14],7];CONT:=True;
      MAKESURE(NUM,SUN,OVER);
      If OVER=False then Begin
        If VT=True then
          begin
            vtModem(Chr(27)+'E');
            clrscr;
          end;
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
          GUA:=DRANDOM mod (USERI[NUM,3] div 2) + 1;
          For COUNT:=1 to HOWLONG do Begin
            If (OVER=False) and (CONT=True) then Begin
              Mriteln('');Mrite('Press ANY key to steal for hour #');
              Send_Num(COUNT);Mrite(' ['); tcolor(yellow); mrite('S'); tcolor(white); mrite(']top...');
              SOMETHING(SURE);If SURE='S' then CONT:=False;If SURE='S' then Mriteln('Stop...');
              If SURE<>'S' then Mriteln('');
              If CONT=True then Begin
                GUA:=GUA-1;USERI[NUM,6]:=USERI[NUM,6]-1;Mriteln('');
                Case GUA of
                  0: begin Mrite('Some guards grab thy shoulder, "'); tcolor(red); mrite('Thou art under arrest!');
                  tcolor(white); mriteln('"'); end;
                  2: begin tcolor(magenta); Mriteln('A couple guards gain on thee!'); tcolor(white); end;
                  4: begin tcolor(blue); Mriteln('Some guards are following thee!'); tcolor(white); end;
                  6: begin tcolor(cyan); Mriteln('The guards look at thee suspiciously...'); tcolor(white); end;
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
                     tcolor(green); Send_Num(GOLD); tcolor(white);
                     Mriteln(' gold pieces!');
                     USERI[NUM,4]:=USERI[NUM,4]+GOLD;
                     GOLD:=DRANDOM mod 7+1;
                     If GOLD=4 then Begin
                       Mriteln('');
                       GOLD:=DRANDOM mod 35+1;
                       If GOLD<5 then GOLD:=9;
                       Mrite('Thou dost notice a ');
                       Mrite(MONSTER[GOLD]);Mriteln(' carrying a heavy load...');
                       Mriteln('');Mrite('Steal from his ['); tcolor(cyan); mrite('B'); tcolor(white);
                       mrite(']ackpack, ['); tcolor(red); mrite('P'); tcolor(white); mrite(']ouch, [');
                       tcolor(green); mrite('S'); tcolor(white); mrite(']ack, or ['); tcolor(yellow);
                       mrite('N'); tcolor(white); mrite(']one? ');
                       Repeat
                         SOMETHING(SURE);
                       Until (SURE='B') or (SURE='P') or (SURE='S') or (SURE='N');
                       Case SURE[1] of
                         'B':begin tcolor(cyan); Mriteln('Backpack...'); tcolor(white); end;
                         'P':begin tcolor(red); Mriteln('Pouch...'); tcolor(white); end;
                         'S':begin tcolor(green); Mriteln('Sack...'); tcolor(white); end;
                         'N':begin tcolor(yellow); Mriteln('None.'); tcolor(white); end;
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
                           Mrite('The sack contains ');tcolor(green); Send_Num(SACK); tcolor(white);
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
                             8:OUTFIT:='VERY expensive Gold Crown';
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

(***** ---====++++**** THE *FINAL* QUEST!!!!!!!!!!! ****++++====--- *******)
  Procedure FINAL(Var OVER:Boolean;Var SUN:longint);
    Var
      CD,B:Integer;
      DWORD,TEMP,JUNK:str80;
      FNAME,ZNAME:Text;
    Begin
      If (VT=True) and (OVER=False) then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
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
          Meadln(DWORD);UPCASEln(DWORD);
          Mriteln('');
          If DWORD='ALYASIA' then
            begin
              Mriteln('The Dragon says, "That is correct, thou may pass..."');
              WON:=True;
            end
          else begin
            Mriteln('The Dragon roars, "THOU SPEAKETH NONSENSE FOOL!!!! DIE!!!!!"');
            Mriteln('');Mriteln('The Dragon flies from the cliff towards thee!!!');
            Mriteln('');Mriteln('The Dragon yells, "Thou mightest flee, but NOT through the portal!"');
            If EMULATE then STOP;C_MONSTER:=42;
            EM_SEND((600+C_MONSTER)-1);
            EM_SEND(303);
            COMBAT(1,OVER,False)
           End;
          If WON then Begin
            Mriteln('');
            bcolor(red); tcolor(black); Mrite('Thou dost jump through the portal!!!!!!!!!!!!!!'); tcolor(white); bcolor(black);
            mriteln('  Your mind spins for hours...');
            STOP;EM_SEND(694);EM_SEND(303);STOP;EM_SEND(300);
            Mriteln('');Mriteln('You wake up in your computer room, wondering for  a second  if  it  was');
            Mriteln('all a dream.  Just then you look  into your monitor  to see  several of');
            Mriteln('your fellow guild members wandering  aimlessly, trapped  forever in the');
            Mriteln('world of the Thieves'' Guild.  You know  that  from this day forward you');
            Mriteln('may always come back and watch this world, to reflect upon the memories');
            Mriteln('it holds for you.');
            STOP;
            Mriteln('');
            tcolor(red); Mrite('CONGRATULATIONS '); tcolor(white);
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
            assign(fname,temp); Rewrite (FNAME);
            MReset(ZNAME,RIDDLES);
            While JUNK[2]<>'"' do Begin
              Readln(ZNAME,JUNK);
              If JUNK[2]<>'"' then Writeln(FNAME,JUNK)
             End;
            Write(FNAME,DAYSS,'   ',USERS[NUM,3]);
            For B:=1 to (30-(ord(USERS[NUM,3][0]))) do
              Write (FNAME,' ');
            Write(FNAME,USERI[NUM,5]);
            close(fname);
            close(zname);
            MReset (FNAME,TEMP);
            assign(zname,riddles); Rewrite(ZNAME);
            While not EOF(FNAME) do Begin
              Readln(FNAME,JUNK);
              Writeln(ZNAME,JUNK)
             End;
            Writeln(ZNAME,'===========================================================');
            Writeln(ZNAME,' "And there were some whose name would be known throughout');
            Writeln(ZNAME,'    all time, known as legends, and shining examples of');
            Writeln(ZNAME,'        great valor and bravery, against all odds."');
            close(fname); close(zname);
            STOP;
            For CD:=1 to 26 do GOODBYE(CD,CD,OVER);
            DUES:=0;GMMSG:='';BSTEAL:='';BDATE:='';
            OVER:=True;
       End;
      End;
     End;

(***** The Cave of the Ancient Ones - 4 Magic Items, 25x25 grid ***********)
  Procedure CAVE(Var OVER:Boolean;Var SUN:longint; whichCave : integer);
    Var
      MAP:Array[1..25,1..25] of Boolean;
      ANAME:Text;
      NOR,SOU,EAS,WES:Boolean;
      SPOT:Char;
      COUNTX,COUNTY,EFFECT:Integer;
      DTR,JUNKS:str80;
    Begin
      If EMULATE then VT:=False;
      If PYRA=False then Mriteln('');
      DTR:=TPATH;
      INSERT('TOWNS.DAT',DTR,((Ord(DTR[0]))+1));
      If PYRA=False then Mriteln('Thou art looking for the cave entrance...');
      If PYRA=True then Mriteln('Thou art looking for the Pyramid entrance...');
      MReset(ANAME,DTR);
(* bypass city descriptions *)
      For COUNTX:=1 to 939 do Readln(ANAME,JUNKS);COUNTX:=0;
(* if pyra=true then we need skip Shiron *)
      If PYRA=True then Begin
          For COUNTX:=1 to 625 do Readln(ANAME,JUNKS);COUNTX:=0;
        if whichCave > 1 then
          For COUNTX:=1 to 625 do Readln(ANAME,JUNKS);COUNTX:=0;
        if whichCave > 2 then
          For COUNTX:=1 to 25 do Readln(ANAME,JUNKS);COUNTX:=0;
      End;

      if whichCave < 2 then
        begin
          For COUNTX:=1 to 25 do Begin
            For COUNTY:=1 to 25 do Begin
              Readln(ANAME,SPOT);
              If SPOT='1' then MAP[COUNTX,COUNTY]:=True;
              If SPOT='0' then MAP[COUNTX,COUNTY]:=False;
            End;
          End;
        end
      else
        begin
          for countx := 1 to 25 do
            begin
              readln(aname,junks);
              for county := 1 to 25 do
                if junks[county] = '1' then map[countx,county] := TRUE else map[countx,county] := FALSE;
            end;
          end;

      close(aname);
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

         { to piss paul witte off royally, three different caves!!!
                                           three different exits!!! }
         if PYRA = TRUE then
           begin
             If ((whichCave = 1) and (COUNTX=4) and (COUNTY=13)) then FINAL(OVER,SUN);
             If ((whichCave = 2) and (COUNTX=12) and (COUNTY=20)) then FINAL(OVER,SUN);
             If ((whichCave = 3) and (COUNTX=2) and (COUNTY=7)) then FINAL(OVER,SUN);
             If ((whichCave = 2) and (countx=17) and (county=21)) then
               begin
                 countx := 7; county := 2;
                 mriteln('');
                 tcolor(yellow);
                 mriteln('Thou feelest woosey and a tad bit disoriented...');
                 tcolor(white);
               end;
             If ((whichCave = 2) and (countx=18) and (county=22)) then
               begin
                 countx := 11; county := 4;
                 mriteln('');
                 tcolor(yellow);
                 mriteln('Thou feelest woosey and a tad bit disoriented...');
                 tcolor(white);
               end;
             If ((whichCave = 3) and (countx=7) and (county=21)) then
               begin
                 countx := 6; county := 5;
                 mriteln('');
                 tcolor(yellow);
                 mriteln('Thou feelest woosey and a tad bit disoriented...');
                 tcolor(white);
               end;
             If ((whichCave = 3) and (countx=22) and (county=22)) then
               begin
                 countx := 24; county := 2;
                 mriteln('');
                 tcolor(yellow);
                 mriteln('Thou feelest woosey and a tad bit disoriented...');
                 tcolor(white);
               end;
           end;

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
  Procedure PYRAMIDS(Var OVER:Boolean;Var SUN:longint);
    Var
      PYR:str80;
      DOOBE:Boolean;
      IS:Integer;

   Begin
      EM_SEND(412);EM_SEND(699);EM_SEND(303);DOOBE:=False;
      If (VT=True) and (OVER=False) then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
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
        CAVE(OVER,SUN,DRANDOM mod 3 + 1);
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
  Procedure WORKSHOP(Var OVER:Boolean;Var SUN:longint);
    Var
      DEC,SAMT,SURE:str80;
      AMT,PUN:Integer;
      GOLD:longint;
      JUSSO:Boolean;
    Begin
     JUSSO:=EMULATE;
     Repeat
       If (VT=True) and (OVER=False) then
         begin
           vtModem(Chr(27)+'E');
           clrscr;
         end;
       If OVER=False then MAKESURE(NUM,SUN,OVER);
       If (OVER=False) and (USERI[NUM,29]<>1) then Begin
         Mriteln('');Mrite ('         Thou art at -=* ');
         If VT=True then
           begin
             vtModem(Chr(27)+'b1');
           end;
         Mrite('The Wizard''s Workshop');
         If VT=True then
           begin
             vtModem(chr(27)+'b3');
           end;
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
  Procedure GRAVEYARD(Var OVER:Boolean;Var SUN:longint);
    Var
      GRAVE,BODY:Integer;
      DEC,SURE:str80;
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
       If (VT=True) and (OVER=False) then
         begin
           vtModem(Chr(27)+'E');
           clrscr;
         end;
       If OVER=False then MAKESURE(NUM,SUN,OVER);
       If (OVER=False) and (USERI[NUM,29]<>1) then Begin
         Mriteln('');Mrite ('             Thou art at -=* ');
         If VT=True then
           begin
             vtModem(Chr(27)+'b1');
           end;
         Mrite('The Durnin Graveyard');
         If VT=True then
           begin
             vtModem(Chr(27)+'b3');
           end;
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
  Procedure ASSASINS(Var OVER:Boolean;Var SUN:longint);
    Var
      SURE:str80;
      HLONG,GOLD,WHICH:Integer;
    Begin
       EM_SEND(413);EM_SEND(301);
       If VT=True then
         begin
           vtModem(Chr(27)+'E');
           clrscr;
         end;
       MAKESURE(NUM,SUN,OVER);
       If OVER=False then Begin
          Mriteln('');Mrite ('                Thou art at -=* ');
          If VT=True then
            begin
              vtModem(Chr(27)+'b1');
            end;
          Mrite('The Assassins'' Guild');
          If VT=True then
            begin
              vtModem(Chr(27)+'b3');
            end;
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
  Procedure TEMPLE(Var OVER:Boolean;Var SUN:longint);
    Var
      GOLD:Integer;
      SURE:str80;
    Begin
        If CHEAT1<>47 then HALT;
        MAKESURE(NUM,SUN,OVER);
        If OVER=False then Begin
             If VT=True then
               begin
                 vtModem(Chr(27)+'E');
                 clrscr;
               end;
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
  Procedure MOONSHADE(Var OVER:Boolean;Var SUN:longint);
    Var
      SURE:str80;
      RANDOM:Integer;
    Begin
       EM_SEND(430);EM_SEND(699);EM_SEND(303);If EMULATE then VT:=False;
       If VT=True then
         begin
           vtModem(Chr(27)+'E');
           clrscr;
         end;
       MAKESURE(NUM,SUN,OVER);
       If OVER=False then Begin
        Mriteln('');If not EMULATE then Mrite('            ');Mrite('-=* ');
        If VT=True then
          begin
            vtModem(Chr(27)+'b1');
          end;
        Mrite('Thou art at Moonshade''s Quarters ');
        If VT=True then
          begin
            vtModem(Chr(27)+'b3');
          end;
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
  Procedure THE_GUILD(Var OVER:Boolean;Var SUN:longint);
    Var
      KIND,CURR,HIT,COUNT:Integer;
      CHOICE,DARTS:str80;
      TRAIN,SEP:longint;
    Begin
      Mriteln('');
      tcolor(green);
      Mriteln('Thou followest the winding  path into the Northern Mountains.');
      Mriteln('Finally thou arriveth at the Guild, Smoke billows out of the');
      Mriteln('chimney, dense aspen forests surround the area.');
      tcolor(white);

      If USERI[NUM,16]=0 then Begin
        Mriteln('');tcolor(yellow); Mriteln('It took thee 1 hour to walk.');
        tcolor(white);
        USERI[NUM,6]:=USERI[NUM,6]-1
       End;
      STOP;
      BOOGIE:=True;EM_SEND(401);EM_SEND(301);
      Repeat
       If VT=True then
         begin
           vtModem(Chr(27)+'E');
           clrscr;
         end;
       MAKESURE(NUM,SUN,OVER);
       If OVER=False then Begin
       Repeat
        KIND:=0;HIT:=0;
          Mriteln('');Mrite ('Thou art at -=* ');
          If VT=True then
            begin
              vtModem(Chr(27)+'b1');
            end;

          tcolor(red);
          Mrite('The Thieves'' Guild');
          tcolor(white);

          If VT=True then
            begin
              vtModem(Chr(27)+'b3');
            end;
          Mriteln(' *=-.');
          Mriteln('');
          Mrite('Greetings '); tcolor(blue); Mrite(USERS[NUM,3]); tcolor(white); Mriteln('!');
          Mriteln('');Mriteln('Why hast thou come?');
          Mriteln('');
          Mrite(' ['); tcolor(magenta); mrite('0'); tcolor(white); mriteln(']  Change thy steal message.');
          Mrite(' ['); tcolor(green); mrite('1'); tcolor(white); mriteln(']  Level Advancement!');
          Mrite(' ['); tcolor(cyan); mrite('2'); tcolor(white); mriteln(']  Training!');
          Mrite(' ['); tcolor(red); mrite('3'); tcolor(white); mriteln(']  Buy some Poison Darts!');
          Mriteln('');Mrite(' ['); tcolor(yellow); mrite('4'); tcolor(white); mriteln(']  Leave the guild.');
          Mriteln('');
          Mrite('Shadowy thieves glare at thee: ');
          Meadln(CHOICE);UPCASEln(CHOICE)
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
        tcolor(green); AWVIEW(1,NUM); tcolor(white); Mrite(', and '); tcolor(blue); AWVIEW(2,NUM);
        tcolor(white); Mriteln(' Armour!');
        Mriteln('');
        Mrite('Thou hast gained ');tcolor(yellow); Send_Num(HIT); tcolor(White);
        Mriteln(' Hit point(s)!!');
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
      If (VT=True) and (OVER=False) then
        begin
          vtModem(Chr(27)+'E');
        end;
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
  Procedure STABLE(Var OVER:Boolean;Var SUN:longint);
    Var
      GOLD,HP:Integer;
      OUT:Boolean;
      GOLDS,HORSETYPE,NAME,KIND:str80;
    Begin
      EM_SEND(409);EM_SEND(301);
      Repeat
        MAKESURE(NUM,SUN,OVER);
        OUT:=False;
        If OVER=False then Begin
         Repeat
            If VT=True then
              begin
                vtModem(Chr(27)+'E');
                clrscr;
              end;
            ABLE:=True;
            Mriteln('');Mrite ('Thou art at the ');
            If VT=True then
              begin
                vtModem(Chr(27)+'b1');
              end;
            Mrite(TOWNS[USERI[NUM,14],1]);
            If VT=True then
              begin
                vtModem(chr(27)+'b3');
              end;
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
  Procedure GYPSY(Var OVER:Boolean;Var SUN:longint);
    Var
      SURE:str80;
    Begin
      EM_SEND(424);EM_SEND(301);
      If VT=True then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
      MAKESURE(NUM,SUN,OVER);
      If OVER=False then Begin
        Mriteln('');Mrite('            -=* ');
        If VT=True then
          begin
            vtModem(Chr(27)+'b1');
          end;
        Mrite('Thou art at the Gypsy''s Quarters ');
        If VT=True then
          begin
            vtModem(Chr(27)+'b3');
          end;
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
  Procedure COLOSSEUM(Var OVER:Boolean;Var SUN:longint);
    Var
      PRICE,ISEL:Integer;
      SEL,ASEL,CSEL:str80;
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
           If VT=True then
             begin
               vtModem(#27+'E');
               clrscr;
             end;
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
      If VT=True then
        begin
          vtModem(#27+'E');
          clrscr;
        end;
      Mriteln('');Mrite('            -=* ');
      If VT=True then
        begin
          vtModem(Chr(27)+'b1');
        end;
      Mrite('Thou art at the Brynthia Torture Chamber ');
      If VT=True then
        begin
          vtModem(Chr(27)+'b3');
        end;
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



begin
end.