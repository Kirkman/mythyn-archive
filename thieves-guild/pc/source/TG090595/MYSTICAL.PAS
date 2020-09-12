unit mystical;

interface

uses comunit, io, crt;

procedure doMysticPortal;
procedure doMineFound;

implementation

procedure doMysticPortal;

  var
    ourChoice : str80;
    ch : str80;
    fh : integer;

  begin
    mriteln('');
    mriteln('A bright light surrounds thee!  You hear a voice:');
    tcolor(yellow);
    mrite('"Where dost thou desire to go, m''leige?"');
    tcolor(white);
    mriteln('');
    mriteln('');

    Mrite(' [1] Arisilon ['); tcolor(green); mrite('Thieves'' Guild'); tcolor(white); mrite(']');
    mrite('     [2] Jarsoloth ['); tcolor(green); mrite('Stable'); tcolor(white); mriteln(']');
    Mrite(' [3] Senaria ['); tcolor(green); mrite('Gypsy''s Quarters'); tcolor(white); mrite(']');
    mrite('    [4] Brynthia ['); tcolor(red); mrite('Torture Chamber'); tcolor(white); mriteln(']');
    Mrite(' [5] Balor ['); tcolor(Red); mrite('Balorian Temple'); tcolor(white); mriteln(']       [6] Irata');
    Mrite(' [7] Mythyn                        [8] Shady Brook ['); tcolor(cyan); mrite('Wizard''s Workshop'); tcolor(white);
    mriteln(']');
    Mrite(' [9] Castelon                     [10] Shiron ['); tcolor(cyan); mrite('Cave of the Ancient Ones'); tcolor(white);
    mriteln(']');
    Mrite('[11] Airion ['); tcolor(green); mrite('Catharian Temple'); tcolor(white); mrite(']    [12] Evil Shore [');
    tcolor(red); mrite('Colleseum'); tcolor(white); mriteln(']');
    Mrite('[13] SilverMoon ['); tcolor(cyan); mrite('Pyramids'); tcolor(white); mriteln(']        [14] Arnach');
    Mriteln('[15] Tirion                       [16] Erelas');
    Mrite('[17] Morgai ['); tcolor(red); mrite('Stable'); tcolor(white); mrite(']              [18] Durnin ['); tcolor(red);
    mrite('Graveyard'); tcolor(white); mriteln(']');
    Mrite('[19] ShamnorWood                  [20] Zenon ['); tcolor(cyan); mrite('The Fortress'); tcolor(white); mriteln(']');
    Mrite('[21] PineVille ['); tcolor(cyan); mrite('Temple of Solnar'); tcolor(white); mriteln('] [22] Zilar');
    Mriteln('[23] BlackWood                    [24] Glantria');
    Mrite('[25] Fort Demise ['); tcolor(red); mrite('Assassin''s Guild'); tcolor(white); mriteln(']');

    Repeat
      Mriteln('');Mrite('Enter thy selection: ');
      Meadln(CH);
      BUGPROOF(CH,FH);
    Until (FH>0) and (FH<26);
    Mriteln('');
    if fh = 8 then
      begin
        If USERI[NUM,29]>1 then
          Begin
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
        If (USERI[NUM,29]=0) or (USERI[NUM,29]=1) then
          Begin
            tcolor(yellow);
            Mriteln('A surge of electricity sears through thy body!!!!!!');
            tcolor(red);
            if useri[num,20] > 3 then
              begin
                mriteln('Hit points - 3');
                useri[num,20] := useri[num,20] - 3;
              end
            else
              begin
                mriteln('Some of thy dexterity hast been drained!');
                useri[num,3] := useri[num,3] - 3;
                if useri[num,3] < 5 then useri[num,3] := 5;
              end;
            tcolor(white);

            Repeat
              fh:=DRANDOM mod 25+1
            Until (fh<>8) and (fh<>USERI[NUM,14]);
          end;
      end
    else
      begin
        tcolor(cyan); Mrite('So mote it be!'); tcolor(white); mriteln('');
      end;

    EM_SEND(FH);

    USERI[NUM,14]:=FH;
    tcolor(green);
    Mriteln('The extreme force of the teleport hast drained thy energy.');
    tcolor(white);

    STOP;

    if useri[num,12] < 18 then
      useri[num,12] := useri[num,12] - 5
    else
      useri[num,12] := 13;

{    if useri[num,4] < 10000 then useri[num,4] := useri[num,4] + drandom mod 5000 + 5000;}
    mriteln('');
  end;

procedure doMineFound;

  var
    x : integer;

  begin
    if useri[num,6] < 1 then
      begin
        Mriteln('Thou hast not the time to dig!');
        mriteln('');
      end
    else
      begin
        x := DRANDOM mod 5;
        if ((x = 0) and (useri[num,6] < 3)) then x := 2;
        if ((x = 1) and (useri[num,6] < 2)) then x := 2;
        case (x) of
          0 : begin
                Mriteln('');
                Mriteln('Thou wasted three hours before discovering that the mine was all');
                Mriteln('hoopla and was nothing but fool''s gold!');
                useri[num,6] := useri[num,6] - 3;
                Mriteln('');
              end;
          1 : begin
                Mriteln('');
                tcolor(yellow);
                Mriteln('Thou spent 2 hours digging for gold.  Riches found!!!');
                tcolor(white);
                Mriteln('');
                useri[num,4] := useri[num,4] + 1000 + (drandom mod 3777) + (drandom mod 2500);
                useri[num,6] := useri[num,6] - 2;
              end;
          else
            begin
                Mriteln('');
                tcolor(cyan);
                Mriteln('Thou spent 1 hours digging for gold.  Riches found!!!');
                tcolor(white);
                Mriteln('');
                useri[num,4] := useri[num,4] + 500 + (drandom mod 3777);
                useri[num,6] := useri[num,6] - 1;
            end;
        end;
      end;
    stop;
  end;


begin
end.