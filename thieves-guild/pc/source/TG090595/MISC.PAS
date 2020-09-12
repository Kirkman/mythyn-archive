unit misc;

interface

uses comunit,io,dos,crt,ddplus;

Procedure DECRYPT(Var TIKIHEAD:ENCTYPE;TIKITOES:ENCTYPE;MONGO:Byte);
Function CONVERT(AMON:Integer):Integer;
Procedure BLA(Var PASSW:str80);
Procedure LOC;
Procedure QSTOP;
Procedure MAKESURE(Var NUM:Integer;Var SUN:longint;Var OVER:Boolean);
Procedure DDISPLAY;
Procedure CHSTMSG;
Procedure VIEWATEXT(Var VIFILE:Text;LenLim:Boolean);
Procedure START;
Procedure PNEW(Var NUM:Integer;Var OVER:Boolean);
Procedure LOADSTUFF(Var TOWNI:TI;Var TOWNS:TS);
Procedure LOGON(Var OVER:Boolean;Var NUM:Integer; Var SUN:longint);
Procedure DISTIME(NUMBER:Integer;Var NNUMBER:Integer);
Procedure AWVIEW(AORW:Integer;SO:Integer);
Procedure MEMBERS(NUM:Integer;Var OVER:Boolean;Var SUN:longint);
Procedure MIDNIGHT(Var DAYSS:str80;Var OVER:Boolean);
Procedure POTION;
Procedure TREASURE(HITS:Integer;MODE:Integer);
Procedure COMBAT(MODE:Integer;Var OVER:Boolean;SEX:Boolean);
Procedure ENCOUNTER(MODE:Integer;Var NUM:Integer;Var OVER:Boolean);


implementation



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
(**************************************************************************)
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
(*****GET KEY**************************************************************)
  Procedure BLA(Var PASSW:str80);
   Var
    dummy,event,what_key,A,B,C,W,DONE:integer;
    ts : string[10];
    Key_Wait,PART,DUMB:str80;
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
      UPCASELN(Key_wait);
      If (ord(Key_wait[1])<>13) and (ord(Key_wait[1])<>8) then PASSW[A]:=Key_wait[1];
      If (VT=True) then
        Begin
          str(w,ts);
          vtModem(Chr(27)+'b'+ts);
        End;
      DONE:=1;
      If (ord(Key_wait[1])<>13) and (ord(Key_wait[1])<>8) then Mrite ('*');
   Until ord(Key_wait[1])=13;
   If (VT=True) then Begin
     vtModem(Chr(27)+'b3')
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
(****** GETS A RETURN FROM THE PLAYER - PAUSE *****************************)
(*****GET FILE LOCATIONS REAL QUICK****************************************)
  Procedure LOC;
    Var
      a : integer;
      ION:Integer;
      garbage : text;
      TITLE:Text;
      first : str80;

    Begin
      assign(title,'thieves.set');
      {$I-}
      Reset(TITLE);
      {$I+}
      If ioresult <> 0 then begin
        Mriteln('I could not find the THIEVES.SET file, it should');
        Mriteln('in the same directory the BBS is run from.  Please inform Sysop.');
        STOP;
        HALT;
       End;
      Readln(TITLE,DPATH);
      Readln(TITLE,TPATH);
      Readln(TITLE,todayEventsFileName);
      Readln(TITLE,yesterdayEventsFileName);
      Readln(TITLE,LOP);
      Readln(TITLE,MASTERS);
      Readln(TITLE,RIDDLES);
      Close(TITLE);
      (*PASTE HERE*)
XXX:=4;
NUMTOT:='7<<73';NUMTOTO:='     ';
ln1:='Thkgppguib|&QQPW |vr>|P]tfeqqee|Ivfovhrab|||Tfljg=|)12/79/*53340  Thkgpptdx';
insert('glj|&5..3|||QvoQs>|Oeenepa|Vuscaourr',ln1,76);

ln1o:='                *                                               ~`         ';
insert('                                    ',ln1o,76);

ln2:='Ki|@?O|qekb|qu|Nekph|!|eu|rmq|vki|?>U|}mr|cui|lj|qsu)|prxgcu|xw|^p|^F@PY  ,';
insert('6--+563*-:7=,||Roi_pa|wl_kg| sso|U wMm|hrv|oailwrbnkqk|qdkv|or]nlxw  ukepbs',ln2,76);
CHEAT7:=53;
insert('cui|mnqgyaq |01|Juvk}l|Oqixu^ng1',ln2,151);

ln2o:='                                                                        ~` ';
insert('                            y     y                                ~`      ',ln2o,76);
insert('           !                    ',ln2o,151);

ln3:='||||||||||||||||||||||||||||*91-|Kvpj r|Pkhw{_oa|- ;*  ||||||||||||||||||||';
insert('|||||||||||||M*Q1|@lt|457/  |||||||||||||||||||||||||||||||||Lngp0|RP||<2-1',ln3,76);
insert(';',ln3,151);

ln3o:='                                     y            \  ~`                    ';
insert('                          ~`                                               ',ln3o,76);
insert(' ',ln3o,151);


    if length(user_first_name) > 0 then
      bbsname := user_first_name
    else
      bbsname := '';
    if ((user_last_name <> ' ') and (length(bbsname) > 0)) then
      bbsname := concat(bbsname,' ',user_last_name)
    else if (user_last_name <> ' ') then
      bbsname := user_last_name;


    upcaseln(BBSNAME);

  end;
(**** No Display STOP *****************************************************)
  Procedure QSTOP;
    Var
      QUICK:str80;
    Begin
      TWIN;COMP1:=Clock;QUICK:='A';
      Repeat
        SOMETHING(QUICK)
      Until ord(QUICK[1])=13;
      Mriteln('')
    End;
(**** CHECK FOR TIME-OUT AND UPDATE TIME ON-LINE **************************)
  Procedure MAKESURE(Var NUM:Integer;Var SUN:longint;Var OVER:Boolean);
    Var
      SINGLE:longint;
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
      D:longint;
      FNAME,ZNAME:Text;
      TEMP,JUNK:str80;
      TQO:String[10];
    Begin
     If NUM>0 then
     If USERI[GM,5]<USERI[NUM,5] then GM:=NUM;
     assign (FNAME,LOP);
     rewrite(fname);
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
     close(fname);
     If (MONTH<>CMONTH) and (MONTH<>'0') then Begin
       TEMP:=DPATH;
       INSERT('JUNK.DAT',TEMP,((Ord(TEMP[0]))+1));
       assign(FNAME,TEMP); rewrite(fname);
       MReset(ZNAME,MASTERS);
       While not EOF(ZNAME) do Begin
         Readln(ZNAME,JUNK);
         Writeln(FNAME,JUNK)
        End;
       Write(FNAME,DAYSS,'   ',USERS[GM,3]);
       For B:=1 to (30-(ord(USERS[GM,3][0]))) do
         Write (FNAME,' ');
       Write(FNAME,USERI[GM,5]);
       close(fname); close(zname);
       MReset (FNAME,TEMP);
       assign(zname,masters); rewrite(zname);
       While not EOF(FNAME) do Begin
         Readln(FNAME,JUNK);
         Writeln(ZNAME,JUNK)
        End;
       close(fname); close(zname);
      End
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
      assign(newname,temp);
      rewrite(newname);
      For PLACE:=1 to 26 do Begin
         Readln(OLDNAME,JUNK);
         If NUM<>PLACE then
           Writeln(NEWNAME,JUNK)
         else
           Writeln(NEWNAME,TOLD);
        End;
      {Rename(NEWNAME,OLDNAME)}
      close(oldname);
      erase(oldname);

      close(newname);
      assign(newname,temp);
      temp := tpath;
      INSERT('STEALMSG.DAT',TEMP,((Ord(TEMP[0]))+1));
      rename(newname,temp)
     End;

(**************************************************************************)
(**** Procedure to view a text file ***************************************)
  Procedure VIEWATEXT(Var VIFILE:Text;LenLim:Boolean);
    Var
      HUH:str80;
      THINGS:FIXEDONE;
      WHERE,LOCCOUNT,LIMCOUNT:Integer;
      CONTIN:Boolean;
    Begin
      CONTIN:=False;ABLE:=True;LIMCOUNT:=0;
      Mriteln('');
      If VT then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
      WHERE:=0;
      While (not eof(VIFILE)) and (WHERE<100) and (SOFF=False) do
        Begin
          WHERE:=WHERE+1;LIMCOUNT:=LIMCOUNT+1;
          If CONTIN then WHERE:=1;
          Readln (VIFILE,THINGS);
          Mriteln (THINGS);If (LIMCOUNT=136) and (LENLIM) then WHERE:=101;
          If WHERE=23 then Begin
            Mrite('[');
            If VT=True then
              Begin
                vtModem(Chr(27)+'c1');
              End;
            Mrite('<RETURN>');
            If VT=True then
              Begin
                vtModem(Chr(27)+'c4');
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

(*      begin  { color ansi }
        TEMP:=TPATH;
        temper := drandom mod 10;
        if (temper > 4) then
          INSERT('title1.ans',TEMP,((Ord(TEMP[0]))+1))
        else
          INSERT('title2.ans',TEMP,((Ord(TEMP[0]))+1));
        MReset (PICTURE,TEMP);
        while not eof(picture) do
          begin
            readln(picture,things);
            mriteln(things);  {MKCISME was mriteln2}
          end;
        close(picture);
      end;  {of displaying ansi screen}

  *)

  Procedure START;

function unencrypt(encrypted:str80; var unencrypted:str80; var checksum:integer):boolean;


  var
    y, len, x, i, z : integer;
    result : boolean;
    encKey : string[180];

  begin
    encKey := 'Gytwdy6666357t672^%$^&T#HujB2^%$^&DY%7uG@YGX&D^&*STYGHUH@IHDLS(*@++FIOS|7uG@YGX&';

    for x := 1 to length(encrypted) do
      begin
       y := ord(encrypted[x]) xor ord(encKey[x]);
       encrypted[x] := chr(y);
      end;

    checksum := ord(encrypted[1]) * 256 + ord(encrypted[2]);
    z := 0;
    unencrypted := '';
    len := ord(encrypted[80]);
    for x := 1 to len do
      begin
        if x mod 2 = 0 then
          i := ord(encrypted[x+2]) - ord(encKey[x])
        else
          i := ord(encrypted[x+2]) + ord(encKey[x]);
        if i < 0 then i := i + 255;
        if i > 255 then i := i -255;
        z := z + ord(encrypted[x+2]);
        unencrypted := concat(unencrypted,chr(i));
      end;
    for x := len+2+1 to 79 do
      z := z + ord(encrypted[x]);
    if z = checksum then result := true else result := false;
    unencrypt := result;
  end;


  Var
    HUH,HUH2,TEMP,MOPTION:str80;
    THINGS:FIXEDONE;
    PICTURE:Text;
    WHERE,ION,LOCCOUNT,SSTRING,IMOPTION:Integer;
    TATEST,TST:longint;
    ff : text;
    encrypted : array[1..4] of str80;
    checksum : integer;
    unencrypted : array[1..4] of str80;
    x,y : integer;
    ch : char;
    failUnencrypt : boolean;

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
      Mriteln(''); Mrite('Do you prefer [V]T-52, [A]nsi (default), or [N]one? ');
      what2(huh);
      if huh='V' then
        begin
          vt := TRUE; ansi := FALSE;
          mapBcolor(4);
          mapTcolor(3);
        end;
      if huh='A' then
        begin
          ansi := TRUE; VT := FALSE;
          tcolor(white); bcolor(black);
        end;
      if huh='N' then
        begin
          vt := false; ansi := false;
        end;
    End;
      TEMP:=TPATH;
      if not ansi then
        INSERT('THIEVES.SCR',TEMP,((Ord(TEMP[0]))+1))
      else
        INSERT('THIEVES.ANS',TEMP,((Ord(TEMP[0]))+1));

      EM_SEND(1051);
      MReset (PICTURE,TEMP);

      If EMULATE then
        Begin
          vtModem(Chr(27)+'b4'+chr(27)+'c3');
        End;
      ABLE:=True;
      inTitle := TRUE;
      While not eof(PICTURE) do
        Begin
          Readln(PICTURE,THINGS);
          Mriteln(THINGS)
        End;
      inTitle := FALSE;
      close(picture);
     ABLE:=False;SOFF:=False;
     If VT then
       begin
         vtModem(#27+'b3'+#27+'c4');
         maptColor(3);
         mapBColor(4);
       end;
    tcolor(white);
    Mriteln('');
    Mriteln('A world of untold treasures and arcane secrets of old awaits!');
    Mriteln('');Mrite ('Would you like to read Instructions [Y/'); tcolor(yellow);
    mrite('N'); tcolor(white); mrite(']? ');
    WHAT3(HUH,'N');
    If HUH='Y' then Begin
      If VT then Begin
        vtModem(Chr(27)+'E');
        clrscr;
       End;
      TEMP:=TPATH;
      INSERT('THIEVES.DOC',TEMP,((Ord(TEMP[0]))+1));
      assign(picture,temp);
      {$I-}
      Reset (PICTURE);
      {$I+}
      If ioresult <> 0 then Mriteln('I could not find THIEVES.DOC, please inform SysOp.')
    else
    begin
     LOCCOUNT:=0;
     If VT then
       begin
         vtModem(Chr(27)+'E');
         clrscr;
       end;
     For LOCCOUNT:=1 to 22 do Begin
        Readln(PICTURE,THINGS);Mriteln(THINGS)
       End;STOP;
     Repeat {MENU}
      If VT then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
      LOCCOUNT:=0;SSTRING:=0;
      For LOCCOUNT:=1 to 25 do Begin
        Readln(PICTURE,THINGS);Mriteln(THINGS);
       End;
      Repeat
          Mrite('Start where?  Chapter #, or Appendix letter [RETURN=Beginning]: ');
          Meadln(MOPTION);
          UPCASELN(MOPTION);BUGPROOF(MOPTION,IMOPTION);
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
        close(picture);
        Mriteln('');Mrite('Would''st thou like to read more? [y/N] ');
        WHAT3(HUH2,'N');
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
        Mriteln('');
        Mrite('Read ['); tcolor(yellow); mrite('T'); tcolor(white); mrite(']oday''s Events, [');
        tcolor(cyan); mrite('Y'); tcolor(white); mrite(']esterday''s Events, [');
        tcolor(red); mrite('S'); tcolor(white); mrite(']core List,'); mriteln('');
        Mrite('['); tcolor(blue); mrite('G'); tcolor(white); mrite(']uild Masters, [');
        tcolor(green); mrite('R'); tcolor(white); mrite(']iddle Masters, or [');
        tcolor(black); bcolor(red); mrite('<RETURN>'); tcolor(white); bcolor(black); mrite('=None]: ');
      Repeat
        SOMETHING(HUH2);
        Case HUH2[1] of
          'T':begin tcolor(yellow); Mriteln('Today...'); tcolor(white); end;
          'Y':begin tcolor(cyan); Mriteln('Yesterday...'); tcolor(white); end;
          'S':begin tcolor(Red); Mriteln('Scores...'); tcolor(white); end;
          'G':begin tcolor(blue); Mriteln('Guild Masters!'); tcolor(white); end;
          'R':begin tcolor(green); Mriteln('Riddle Masters!'); tcolor(white); end;
         End; {Case}
          If ord(HUH2[1])=13 then Mriteln('Exit')
       Until (HUH2='T') or (HUH2='Y') or (HUH2='S') or (HUH2='G') or
             (HUH2='R') or (ord(HUH2[1])=13);
       ion := 0;
       If HUH2='Y' then begin assign(picture,yesterdayEventsFileName); Reset(PICTURE); {$I+} ion := ioresult; end;
       If HUH2='T' then begin assign(picture,todayEventsFileName); Reset(PICTURE); {$I+} ion := ioresult; end;
       If HUH2='S' then begin assign(picture,lop); Reset(PICTURE); {$I+} ion := ioresult; end;
       If HUH2='G' then begin assign(picture,masters); Reset(PICTURE); {$I+} ion := ioresult; end;
       If HUH2='R' then begin assign(picture,riddles); {$I-} Reset(PICTURE); {$I+} ion := ioresult; end;
       If ord(HUH2[1])<>13 then Begin
           If (ion <> 0) then begin
             Mriteln('');
             Mriteln('Sorry, that Scroll could not be found in the library...');
            End
         End;
       If (ord(HUH2[1])<>13) and (ION<>-33) and (ION<>-34) then begin VIEWATEXT(PICTURE,False); close(picture); end;
     Until ord(HUH2[1])=13;
       If VT then
         vtModem(Chr(27)+'v');

    failUnEncrypt := FALSE;
    assign(ff,'tgbbsreg.cfg');
    {$I-}
    reset(ff);
    {$I+}
    if ioresult = 0 then
      begin
        for x := 1 to 4 do
          begin
            encrypted[x] := '';
            for y := 1 to 80 do
              begin
                read(ff,ch);
                encrypted[x] := concat(encrypted[x],ch);
              end;
          end;
          close(ff);
          failUnEncrypt := FALSE;
          for x := 1 to 4 do
            if not (unencrypt(encrypted[x],unencrypted[x],checksum)) then
              failUnEncrypt := TRUE; (*writeln('not able to unencrypt... FAILED!!!'); *)
          if failUnEncrypt = FALSE then registered := TRUE;
        end
      else
        begin
          registered := FALSE;
        end;

       mriteln('');

       if registered = TRUE then
         begin
           Mrite('Registered to '); tcolor(red); mrite(unencrypted[2]); tcolor(white);
           mrite(', BBS '); tcolor(green); mriteln(unencrypted[3]); tcolor(white);
           mrite('Sysop: '); tcolor(magenta); mrite(unencrypted[1]); tcolor(white);
           Mrite('    Serial # '); tcolor(cyan); mriteln(unencrypted[4]); tcolor(white);
           Mriteln('');CHEAT6:=0;
           For LOCCOUNT:=1 to ord(LN2[0]) do
             Mrite(LN2[LOCCOUNT]);Mriteln('');
         end
       else if failUnEncrypt = FALSE then  { registered = FALSE }
         begin
           tcolor(cyan);
           mriteln('This is an Unregistered version of Thieves'' Guild');
           tcolor(white);
           mriteln('and is to be used for 30 days only.  To register, call');
           mriteln('(801) 371-9132 for more information.  Please encourage your');
           mriteln('SysOp to register this door.  Many options have been disabled');
           mriteln('in the shareware version including a maximum of 8 different');
           mriteln('players and the menu ''0'' items disabled (except the');
           mriteln('Thieve''s Guild in Arisolon and the Stables in Jarsoloth and');
           mriteln('Morgai.');
           mriteln('');
         end
       else { registered = FALSE, failUnEncrypt = TRUE }
         begin
           mriteln('The definition file for Thieves'' Guild is missing or corrupt.');
           mriteln('The TGBBSREG file must be deleted or fixed before execution.');
           mriteln('To register this please call [BBS] (801) 371-9132 and notify');
           mriteln('SYSOP (Mythyn Software)');
           mriteln('  -->  Software Piracy is a crime! <--');
           halt(1);
         end;

{
       ln1 := 'Registered to ' + bbsname + ', BBS ' + bbsnumb
       LOCCOUNT:=0;

       For LOCCOUNT:=1 to ord(LN1[0]) do Begin
         DOUBCHECK:=True;
         mrite(LN1[LOCCOUNT])
        End;}

       DOUBCHECK := True;

       cheat6 := 0;


{      mriteln('This is a Beta Copy of the registered version and is not');
       mriteln('to be used after March 30, 1994.  If it is in play, call');
       mriteln('[BBS] (801) 371-9132 and notify the SysOp (Mythyn Software)');
       mriteln('  -->  Software Piracy is a crime! <--');
 }

       STOP;
  End;
(*****NEW USER ROUTINE*****************************************************)
Procedure PNEW(Var NUM:Integer;Var OVER:Boolean);
  Var
    NAME,PASSWORD,WELL,STUFF,EVENT,TEMP:str80;
    AFILE:Text;
    MAGIC:Boolean;
    A,C,LASTIME,LADYHAWK,ION:Integer;
    tooMany : boolean;
    verName : str80;
    triedNames : integer;

  begin
    triedNames := 0;
    num := 0; c := 0; a := 0;
    magic := FALSE;

    repeat
      A:=A+1;
      if USERS[A,3] = 'EMPTY' then magic := TRUE;
    until (a=26) or (MAGIC=TRUE);


    tooMany := FALSE;
    if registered = FALSE then
      begin
        if (magic = true) and (a > 8) then
          begin
            magic := FALSE;
            tooMany := TRUE;
          end;
      end;



    ladyhawk := 0;

    repeat
      LADYHAWK := LADYHAWK+1;
      if (USERS[LADYHAWK,3]='EMPTY') and (USERS[LADYHAWK,2]<>'EMPTY') then
        begin
          if USERS[LADYHAWK,2]=BBSNAME then
            begin
              Mriteln('');Mriteln('Thou must wait until tommorrow to create a new character...');
              Mriteln('');EM_SEND(0);HALT
            end;
        end;
    until ladyhawk = 26;

    if MAGIC=FALSE then
      begin
        if tooMany = TRUE then
          begin
            Mriteln('');
            Mriteln ('Sorry, no apprentices are needed at this time...');
            mriteln('Encourage your SysOp to register and more apprentices will');
            mriteln('become needed.  There is a maximum of 8 players in the');
            mriteln('shareware version of Thieve''s Guild.');
            em_send(0);
            over := TRUE;
            halt;
          end
        else
          begin
            Mriteln('');Mriteln ('Sorry, no apprentices are needed at this time...');
            Mriteln ('Please try again later...');
            Mriteln('');
            EM_SEND(0);
            OVER:=TRUE;
            HALT;
          end;
      end;

    If MAGIC=True then
      Begin
       Repeat
        Repeat
          inc(triedNames);
          if triedNames > 6 then
            begin
              mriteln('');
              mriteln('Too many attempts at a valid name...');
              mriteln('Come visit again when you can be more decisive on a TRUE name.');
              mriteln('');
              em_send(0);
              over := TRUE;
              halt(0);
            end;
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
          UPCASELN(NAME);
         Until (NAME[1]<>' ') and (NAME[ord(NAME[0])]<>' ') and (ord(NAME[0])<26) and (ord(NAME[0])>3) and
               (NAME<>'EMPTY');
          Mrite (NAME);
          Mrite(' Correct [Y/n] ');
          WHAT3(WELL,'Y');
          if well = 'N' then
            begin
              mriteln('');
              mrite('Do you really want to join [Y/n] ');
              what3(verName,'Y');
              if verName = 'N' then
                begin
                  mriteln('');
                  mriteln('Ok, but if you decide to change your mind, come visit again.');
                  mriteln('');
                  em_send(0);
                  over := TRUE;
                  halt(0);
                end;
            end;
        Until (WELL='Y');

{      If (BBSN<>'FOREM') and (BBSN<>'EXPRESS') and (BBSN<>'PCB150') then Begin
        Repeat
         Repeat
          Mriteln('');Mrite ('Enter a Password to use: ');
          Meadln (PASSWORD);
          If ord(PASSWORD[0])>25 then Mriteln ('25 Char. Maximum Please...');
          If ord(PASSWORD[0])<4 then Mriteln ('4 Char. Minimum Please...');
         Until (ord(PASSWORD[0])<26) and (ord(PASSWORD[0])>3);
          upcaseln(password);
          mrite (password);
          mrite(' Correct [Y/N] ');
          what(well);
        Until (WELL='Y')
       End;}


       NUM:=A;NUNUM:=A;
{        If (BBSN<>'FOREM') and (BBSN<>'EXPRESS') and (BBSN<>'PCB150') then
          USERS[NUM,2]:=PASSWORD
        Else }
        USERS[NUM,2]:=BBSNAME;
        USERS[NUM,3]:=NAME;
        EVENT:=DPATH;
        INSERT(' ',EVENT,((Ord(EVENT[0]))+1));
        EVENT[ord(EVENT[0])]:=USERS[NUM,1][1];
        assign(afile,event);
        rewrite (AFILE);
        close(afile);
        CHSTMSG;
        Mriteln('');
        Mrite('Would''st thou like to read the story-line? [y/N] ');
        WHAT3(WELL,'N');
        If WELL='Y' then Begin
          TEMP:=TPATH;
          INSERT('THIEVES.DOC',TEMP,((Ord(TEMP[0]))+1));
          assign(afile,temp);
          {$I-}
          Reset(AFILE);
          {$I+}
          If ioresult <> 0 then Mriteln('I could not find THIEVES.DOC, please inform SysOp.')
          else
           Begin
            For C:=1 to 47 do Readln(AFILE);
            VIEWATEXT(AFILE,True);
            close(afile);
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
      D,TST:longint;
      NAME,FNAME,GARBAGE,NEWNAME:Text;
      CHOICE,TEMP,FIRST:str80;
      INFO:String[160];
      DONE,FIN:Boolean;
    Begin
      N:=0;SN:=0;D:=0;SD:=0;A:=0;B:=0;
      Mriteln('');Mriteln ('Reading the Scrolls...');
      TEMP:=TPATH;
      INSERT('STEALMSG.DAT',TEMP,((Ord(TEMP[0]))+1));
      assign(newname,temp);
      {$I-}
      Reset (NEWNAME);
      {$I+}
      If ioresult <> 0 then Begin
        {$I-}
        Rewrite(NEWNAME);
        {$I+}
        if ioresult <> 0 then
          begin
            writeln('SysOp:  unable to create ',temp);
            writeln('It may contain an invalid directory...');
            writeln('To fix, please create the directory ',tpath);
            writeln('and try again... thankyou...');
            halt(3);
          end;
        For N:=1 to 26 do Writeln(NEWNAME,'');
        N:=0
       End;
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
          for a:=38 to 45 do
            readln(name,useri[n,a]);
        Until N=26;
      Readln(NAME,DUES);
      Readln(NAME,DREAM);
      Readln(NAME,PROG);Readln(NAME,BSTEAL);Readln(NAME,BDATE);
      If not eof(NAME) then Readln(NAME,GMMSG);
      close(name);
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
      close(name);
      assign(eventsFile,todayEventsFileName);

      {$I-}
      append(eventsFile);
      {$I+}
      If ioresult <> 0 then
        begin
            rewrite(eventsFile);
            Writeln (eventsFile);
            Writeln (eventsFile,'      #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#');
            Writeln (eventsFile,'#*#*#* The Thieves'' Guild Current Events as of *#*#*#');
            Writeln (eventsFile,'      #*#*#*#*#*# ',DAYSS,' #*#*#*#*#');
            close(eventsFile);
            append(eventsFile);
        end;
{ eventsFile is now pointing to end of current events! }
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
     GETEMGONE(False)
    End;
(**************************************************************************)
  Procedure LOGON(Var OVER:Boolean;Var NUM:Integer; Var SUN:longint);
    Var
     CHECK,A,B,S,J,TOTAL,COND,COUNT,LINE,NOP,RANK,S_RANK,PLAYS:Integer;
     G_WEALTH,A_SKILL:longint;
     PASSWORD,FIRST,EVENT,JUNK:str80;
     WORDS:String[160];
     EVENTS:Text;
     foundHim : boolean;

    Begin
     CHECK:=1;COUNT:=0;
     NUM:=100;
     S:=0;
     foundHim := FALSE;
     count := 0;
     repeat
       inc(count);
       if (USERS[COUNT,2]=BBSNAME) and (USERS[COUNT,3]<>'EMPTY') then
         begin
           NUM:=COUNT;
           foundHim := TRUE;
         end;
     until ((foundHim = TRUE) or (count = 26));
{     For COUNT:=1 to 26 do
       If (USERS[COUNT,2]=BBSNAME) and (USERS[COUNT,3]<>'EMPTY') then NUM:=COUNT;}
     If NUM=100 then PNEW(NUM,OVER);
     If OVER=False then Begin
     Mriteln('');
     If GMMSG<>'' then Begin
       Mrite('The Guild Master says, "');
       tcolor(magenta);
       Mrite(GMMSG);
       tcolor(white);
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
      tcolor(green);
      Send_Num(G_WEALTH); tcolor(white); Mriteln(' Gold Pieces.');
      Mriteln('');COUNT:=0;
      Mrite('There are currently '); tcolor(cyan);
      Send_Num(NOP); tcolor(white); Mrite(' Guild Member(s) with an Average skill of ');
      tcolor(magenta); Send_Num(A_SKILL div NOP); tcolor(white); Mriteln(' points.');
      Mrite('You are now ranked #');tcolor(yellow); Send_Num(RANK);tcolor(white); Mrite(' in Skill, and #');
      tcolor(red); Send_Num(S_RANK);tcolor(white); Mriteln(' in Score...');
      tcolor(blue); Send_Num(PLAYS);tcolor(white);
      If PLAYS=1 then
        Mrite(' thief has')
      Else
        Mrite(' theives have');
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
     tcolor(cyan);
     Mrite ('Greetings');
     If GM=-1 then GM:=NUM;
     If GM<>NUM then Mrite (' ');
     If GM<>NUM then Mrite(USERS[NUM,3]);
     If GM<>NUM then Mriteln('!');
     If GM=NUM then Mriteln (', Guild Master!!');
     tcolor(white);
     EM_SEND(115);
     If USERI[NUM,7] > 0 then Begin
       Mriteln('');
       Mrite ('Thou art still in Jail for ');
       tcolor(red);
       Send_Num(USERI[NUM,7]);
       tcolor(white);
       Mriteln(' more Day(s)!');
       Mrite ('Bail would Cost thee ');
       tcolor(Green); Send_Num(USERI[NUM,7]*500); tcolor(white);
       Mriteln(' Gold Pieces.');
       Mrite ('Pay it? [Y/n] ');
       WHAT3(JUNK,'Y');
       If JUNK='N' then OVER:=TRUE;
       If JUNK='Y' then Begin
         If USERI[NUM,4]<USERI[NUM,7]*500 then Begin
           Mriteln('');
           Mrite('The Guards say angrily, "'); tcolor(red); mrite('Thou dost not have enough Gold!');
           tcolor(white); mriteln('"');
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
       Mrite ('Thou must wait until the '); tcolor(red); mrite('moon'); tcolor(white); mriteln(' once again reaches');
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
       tcolor(green); Send_Num(DUES); tcolor(white);
       Mriteln(' gold piece(s) in dues!!!!!');
       USERI[NUM,4]:=USERI[NUM,4]+DUES;
       DUES:=0;Mriteln('')
      End;
       Mriteln('The Guild Scribe approaches thee, "Dost thou have a new message, master?"');
       Mrite('Leave a new guild message? [y/N] ');
       WHAT3(JUNK,'N');
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
           Mrite ('Correct [Y/n] ');
           WHAT3(JUNK,'Y');
           Mriteln('');
          Until JUNK='Y';
        End
       End;
       EM_SEND(USERI[NUM,14]);EM_SEND(200+USERI[NUM,6]);
       bcolor(green); tcolor(black); Mrite('Events While Gone!'); tcolor(white); bcolor(black); mriteln('');
       mriteln('');
       LINE:=0;
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
       close(events);
       ABLE:=False;SOFF:=False;
       STOP;If JOINED then ESTUFF(1,NUM,'',44);
       Mriteln('');If JOINED=False then ESTUFF(1,NUM,'',45);
       assign(events,event); Rewrite (EVENTS); close(events); EM_SEND(1052)
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
  Procedure MEMBERS(NUM:Integer;Var OVER:Boolean;Var SUN:longint);
    Var
      WHICH,COND,IS:Integer;
      JUNK:str80;
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
        Mriteln('');Mrite ('Anyone else? [Y/n] ');
        WHAT3(JUNK,'Y');
        If JUNK='Y' then Mriteln('')
      End;
     MAKESURE(NUM,SUN,OVER);
     Until (JUNK='N') or (WHICH=-1) or (OVER=TRUE);
     If OVER=FALSE then STOP;
    End;
(**** AFTER MIDNIGHT MAINTANANCE ******************************************)
  Procedure MIDNIGHT(Var DAYSS:str80;Var OVER:Boolean);
    Var
      A,B,THIS,D,O,G,X,Y,Z,Tm:longint;
      DR:Real;
      TEMP:str80;
      Neg: Boolean;
      ONE:Text;
      year,mnth,dy,dayofweek : word;
    Begin
      TEMP:=DPATH;
      INSERT('JUNK.DAT',TEMP,((Ord(TEMP[0]))+1));
      assign(one,temp);
      {$I-}
      Rewrite(ONE);
      {$I+}
      if ioresult <> 0 then
        begin
          writeln('SysOp:  unable to create ',temp);
          writeln('It may be an invalid directory...');
          writeln('To fix, please create the directory ',dpath);
          writeln('and try again... thankyou...');
          halt(2);
        end;

      GetDate(Year, Mnth, Dy, DayOfWeek);
      O:=dy;
      D:=mnth;
      G:=year;
      Tm:=clock;
      Neg:=Tm<0;
      Tm:=Tm+(32768*ord(neg));
      Z:=Tm mod 32;
      Y:=(Tm mod 2048) div 32;
      X:=(Tm div 2048)+(16*ord(neg));
      Z:=Z*2;
      LDATE:=DA_TE(G-1900,D,O);
      Write (One,D div 10,D mod 10,'/',O div 10,O mod 10,'/',G,' ',X div 10);
      Writeln (One,X mod 10,':',Y div 10,Y mod 10,':',Z div 10,Z mod 10);
      close(one);
      MReset (ONE,TEMP);
      Readln (ONE,DAYSS);
      close(one);
      TEMP:=TPATH;
      DECRYPT(ln1,ln1o,CHEAT1);
      INSERT('THIEVES.CLK',TEMP,((Ord(TEMP[0]))+1));
      MReset (ONE,TEMP);
      Readln (ONE,THIS);
      Readln (ONE,MONTH);
      close(one);
      CMONTH:='  ';CMONTH[1]:=DAYSS[1];CMONTH[2]:=DAYSS[2];
      If LDATE<THIS then Begin
        Mriteln('');Mriteln('The date has been altered, game will not run until changed.');
        Mriteln('');Mriteln('Please notify the SysOp...');EM_SEND(0);
        HALT
       End;
      If (THIS < LDATE) or (MONTH <> CMONTH) then Begin
        Mriteln('');Mrite ('''The Moon has Risen!'' - Please Wait...');
        assign(one,masters);
        {$I-}
        Reset (ONE);
        {$I+}
        If ioresult <> 0 then Begin
          assign(one,masters);
          Rewrite(ONE);
          Writeln (ONE);
          Writeln (ONE,'       *__--__* The Masters of the Guild!! *__--__*');
          Writeln(ONE);
          Writeln (ONE,'Date                 Name                            Score');
          Writeln (ONE,'*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*')
         End;
        close(one);
        assign(one,riddles);
        {$I-}
        Reset (ONE);
        {$I+}
        If ioresult <> 0 then Begin
          assign(one,riddles);
          Rewrite(ONE);
          Writeln(ONE);
          Writeln(ONE,'     *-)----<<<<*>>>>/\/\<<<<*>>>>/\/\<<<<*>>>>----(-*');
          Writeln(ONE,'  *(/\/\__  --* The Masters of the Riddles! *--  __/\/\)*');
          Writeln(ONE,'     *-)----<<<<*>>>>\/\/<<<<*>>>>\/\/<<<<*>>>>----(-*');
          Writeln(ONE);
          Writeln(ONE,'   Date      Time     Name                          Score');
          Writeln(ONE,'-----------------------------------------------------------');
          Writeln(ONE,'12/07/1990 11:37:46   LUVAN LIGHTFINGERS            2767627');
          Writeln(ONE,'12/23/1993 11:37:46   MITCH CALAHAN                13974321');
          Writeln(ONE,'===========================================================');
          Writeln(ONE,' "And there were some whose name would be known throughout');
          Writeln(ONE,'    all time, known as legends, and shining examples of');
          Writeln(ONE,'        great valor and bravery, against all odds."')
         End;
        close(one);
        assign(one,temp);
        Rewrite (ONE);
        Writeln (ONE,LDATE);
        Writeln (ONE,CMONTH);
        A:=0;
        CLOSE(ONE);

        { deleting yesterday's events }
        assign(one,yesterdayEventsFileName);
        {$I-}
        erase(ONE);
        {$I+}
        if ioresult <> 0 then
          begin
            writeln('YesterdayEventsFileName does not exist: ',yesterdayEventsFileName);
            writeln('Was trying to erase the file... no matter...');
          end;

        { rename current events to yesterdays events }
        close(eventsFile);
        rename(eventsFile,yesterdayEventsFileName);

        { create a new todays events file }
        assign(eventsFile,todayEventsFileName);
        rewrite(eventsFile);
        writeln (eventsFile);
        writeln (eventsFile,'      #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#');
        writeln (eventsFile,'#*#*#* The Thieves'' Guild Current Events as of *#*#*#');
        writeln (eventsFile,'      #*#*#*#*#*# ',DAYSS,' #*#*#*#*#');
        close(eventsFile);
        append(eventsFile);

        A:=0;
        For A:=1 to 26 do
          Begin
            If (USERI[A,17]>0) and (USERI[A,18]<=250000) then
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
      COLOR,WHICH,SSURE:str80;
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
        WHICH,TARGET:str80;
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
        If (VT=True) and (EMULATE=False) then
          begin
            vtModem(Chr(27)+'E');
            clrscr;
          end;
        PHASE:=PHASE+1;
        If (VT=False) or (EMULATE=True) then Mriteln('');
        Mrite('         !!! '); tcolor(green); mrite('BATTLE PHASE'); tcolor(cyan); mrite(' #');
        Send_Num(PHASE); tcolor(white);
        Mriteln(' !!!');
        Mriteln('');
        If STUN>0 then STUN:=STUN-1;
        If C_STAT>0 then C_STAT:=C_STAT-1;
        If STUN>0 then
          begin
            tcolor(yellow);
            Mriteln('Thou art still stunned, and unable to attack...');
            tcolor(white);
          end;
        If C_STAT>0 then
          begin
            tcolor(yellow);
            Mriteln('Thou art unable to get back on thy feet...');
            tcolor(white);
          end;
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
          Mrite  ('       [7] '); tcolor(magenta); mriteln('Recover thy Weapon!'); tcolor(white);
          Mriteln('        >> [T]ry to Escape <<')
          End;
         End;
        If (MODE=3) and (CANON) then
          begin
            Mrite('       ]=> ['); tcolor(magenta); mrite('F'); tcolor(white); mrite(']');
            tcolor(magenta); mrite('ire thy Catapult'); tcolor(white); mriteln(' <=[');
          end;
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
        If C_WEAPON<>-1 then
          begin
            tcolor(cyan);
            AWVIEW(1,NUM);
            tcolor(white);
          end;
        If C_WEAPON=-1 then
          begin
            tcolor(yellow);
            Mrite('Bare Hands');
            tcolor(white);
          end;
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
          If DRANDOM mod 2+1=1 then
            Begin
             Mrite('Thy ');
             AWVIEW(1,NUM);
             Mrite(' screams, "'); tcolor(red); mrite('Meet my wrath!!!!!!'); tcolor(white); mriteln('"');
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
           tcolor(red); Send_Num(DAMAGE); tcolor(white);
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
             tcolor(red); Send_Num(DAMAGE); tcolor(white);
             Mriteln(' point(s) of damage!!');
             MHP:=MHP-DAMAGE;If (RANDOM>USERI[NUM,3]) and (MODE=3) then Mriteln('');
             EM_SEND(505);If M_STUN>0 then EM_SEND(502)
           End;
        If WHICH='F' then Begin
          DAMAGE:=DRANDOM mod 20+1;
          Mrite('Thou dost fire thy catapult and hit doing ');
          tcolor(red); Send_Num(DAMAGE); tcolor(white);
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
            tcolor(cyan); AWVIEW(1,NUM); tcolor(cyan);
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
             Mriteln('');tcolor(red); Mriteln('That was a real Balorian like thing to do!'); tcolor(white);
             STOP
            End;
           If (TARGET='N') and (USERI[NUM,19]=21) then Begin
             Mriteln('');tcolor(cyan); Mriteln('That was a real Solnarian like thing to do!'); tcolor(white);
             STOP
            End;
           TARGET:='NO'
          End;
         If (DRANDOM mod 7+1=3) and (TARGET<>'NO') then FIGHT:=False;
         If FIGHT=False then Mriteln('');
         If (FIGHT=False) and (MODE<>2) and (MODE<>3) and (MODE<>5) then EM_SEND(300);
         If FIGHT=False then
           begin
             tcolor(green);
             Mriteln('Thy foe flees the battle!!!!!');
             tcolor(white);
           end;
       End;
      End;
      If (FIGHT=True) and (DRANDOM mod 17+1=5) and (MODE=0) then Begin
        Mriteln('');EM_SEND(300);
        tcolor(green);
        Mriteln('The bartender breaks up the fight!  The patrons grumble with dissapointment.');
        tcolor(white);
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
           tcolor(red); Mriteln('Thy horse hast been slain!'); tcolor(white);
           ESTUFF(1,NUM,USERS[NUM,9],43);
           USERS[NUM,8]:='NONE';USERS[NUM,9]:='NONE';USERI[NUM,16]:=0
          End
          Else Begin
           Mriteln('');
           Mrite('Thy horse has ');
           tcolor(red); Send_Num(HHP); tcolor(white); Mriteln(' hit point(s) left...')
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
         tcolor(red);
         Send_Num(DAMAGE);
         tcolor(white);
         Mriteln(' point(s) of damage!!!!!');
         If (C_MONSTER=3) and (WEAP=2) then Begin
            If DRANDOM mod 2+1=2 then Begin
              Mriteln('');tcolor(Red);Mriteln('Thou art poisoned by the sting!'); tcolor(white);
              USERI[NUM,26]:=3
            End
           End;
         If ((USERI[NUM,23]=2) or (USERI[NUM,23]=3)) and (MODE<>3) then Begin
           Mrite('Thy ');
           AWVIEW(2,NUM);
           If USERI[NUM,22]<>0 then Mrite(' armour');
           Mrite(' complains, "'); tcolor(magenta); mrite('That one hurt!!!'); tcolor(white); mriteln('"');
          End;
         If MODE<>3 then USERI[NUM,20]:=USERI[NUM,20]-DAMAGE;
         If MODE=3 then HULL:=HULL-DAMAGE;
         If USERI[NUM,20]<0 then USERI[NUM,20]:=0;
         If HULL<0 then HULL:=0;
         If (WHERE=1) and (DRANDOM mod 6+1=3) then begin
           Mriteln('');
           tcolor(green); Mriteln('Thou art stunned by the blow!!!'); tcolor(white);
           STUN:=DRANDOM mod 3+1
          End;
         If (WHERE=4) and (DRANDOM mod 6+1=3) then begin
           Mriteln('');
           tcolor(blue); Mriteln('Thou art knocked down by the attack!!!!'); tcolor(white);
           C_STAT:=DRANDOM mod 3+1
          End;
         If (WHERE=2) and (DRANDOM mod 3+1=2) and (C_WEAPON<>-1) then begin
           Mriteln('');
           Mrite('Thy ');
           tcolor(Cyan); AWVIEW(1,NUM); tcolor(white);
           Mriteln(' is hurled from thy grasp!!!!!!');
           C_WEAPON:=-1
          End;
          Mriteln('');
         If MODE=3 then Begin
          Mrite('Thy Ship''s Hull: ');
          tcolor(Red);
          Send_Num(HULL);
          tcolor(white);
          Mrite('/');
          Send_NUM(SHPM);
          Mriteln('');
         End;
         If MODE<>3 then
           Begin
             mrite('Thy Health: ');
             if ((useri[num,20]) < (useri[num,21] div 80)) then
               tcolor(red)
             else
               tcolor(cyan);
             Send_Num(USERI[NUM,20]);
             tcolor(white);
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
        REACT,SURE:str80;
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
      close(aname);
      ENCRYPT(AHINT,False);
      If (VT=True) and (MODE<>1) and (EMULATE=False) then
        begin
          vtModem(Chr(27)+'E');
          clrscr;
        end;
      SEX:=False;
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




end.