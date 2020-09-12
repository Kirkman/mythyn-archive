{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V-,X+,Y+}
{$M 16384,0,655360}
program thieves_guild;

uses dos, crt, comunit, io, misc, shoppes2, ddplus, main, elog, netfilep;

  const
    version = '0.99';

(**************************************************************************)

procedure mainProgram;

begin

  randomize;

  inTitle := FALSE; ansi := FALSE;  bold := FALSE; flash := FALSE;

  SPCB:=False;TOFF:=False;SOFF:=False;ABLE:=False;TKILL:=False;ISITOK:=False;WATERS:=False;
  BBSNAME:='';PIRCHECK:=0;MAINP:=False;CHEAT1:=21;CHEAT2:=254;CHEAT3:=55;CHEAT4:=76;
  EMULATE:=False;DEATH:=''; ansix := 1; ansiy := 1;


  loc;

  C_ADJECTIVE:=0;A_CRYPT:=False;
  BOOGIE:=False;DTREAS:=False;COMPTEST:=0;WIZPOT:=False;CHEAT5:=237;
  STEALER:=0;VIEWOK:=False;MULT:=False;GMMSG:='';GT:=False;GTT:=False;LOCK:=False;ELEMENT:=0;
  TWISTY:=False;KEY:=False;OCE:=False;MITCH:=False;CHEAT6:=100;
  HORN:=False;FAIRY:=False;LUCK:=False;JOINED:=False;TAVSTEAL:=0;DOUBCHECK:=False;
  PYRA:=False;SYSOPM:=0;MYSTIC:=False;HALF:=False;WIND:=2;WON:=False;

  if local then
    car := 2  { local is from DDPLUS... }
  else
    car:=1;


  over := FALSE;
  ujaill := FALSE;

  sclrscr;

  sysopMessage;  { load and display sysopmsg.txt if exist in cur dir }

  loadstuff(towni, towns);

  decrypt(ln1,ln1o,87);

  ISITOK:=True;
  MIDNIGHT(DAYSS,OVER);
  DECRYPT(ln1,ln1o,CHEAT2);
  START;
  LOGON(OVER,NUM,SUN);

  If (OVER=FALSE) then MAINMENU(NUM,OVER,SUN);
  VIEWOK:=True;
  If USERS[NUM,3]<>'EMPTY' then
    begin
      Mriteln('');
      Mrite('Review thy Stats? [Y/N] ');
      WHAT(DEATH);
      If DEATH='Y' then STATS(NUM,OVER,SUN)
    end;
  DDISPLAY;
  Mriteln('');
  Mriteln ('One Moment...');

  If CHEAT5<>237 then
    If (DRANDOM mod 107)>77 then
      DOUBCHECK:=False;

  If DOUBCHECK then SAVEINFO(OVER);
    ISITOK:=False;

  if (over = TRUE) then
    begin
      em_send(0);
      mriteln('');
      mriteln ('       ---===**  Thank you for playing The Thieves'' Guild! v' + version + ' **===---');
      mriteln('');
      mriteln ('                   Converted to the IBM by Myron K. Crandall');
      mriteln('');
      mriteln ('                          The infamous Mongo of Kalahad.');
      mriteln('');
      mriteln ('      "The Thieves'' Guild", All Rights Reserved (C) 1988-95 by Paul Witte');
      mriteln('');
      mriteln ('               -=/*     A Mythyn Software Production     *\=-');
      mriteln('');
      mriteln('                    Support BBS: Deathmatch BBS (801) 371-9132');
      mriteln('')
    end;
  close(eventsFile);
end;


var
  ff : text;
  name : str80;

begin

  SaveExitProc := ExitProc;
  ExitProc := @MyExit1;

  { for DDPLUS }
  initdoordriver('thieves.ctl');
  progname := 'Thieves'' Guild ' + version;


  window(1,1,80,23);


  shareinst;
  if shareInst then
    FileMode := 64;

  assign(ff,'thieves.lok');
  {$I-}
  rewrite(ff);
  {$I+}
  if ioresult <> 0 then
    begin
      if shareInst then fileMode := 66;
      mriteln('');
      mriteln('Someone else is currently in the game.  Please return');
      mriteln('in a few minutes and try again.  Sorry for the inconvinience.');
      mriteln('');
      stop;
    end
  else
    begin
      mainProgram;
      close(ff);
      if shareInst then fileMode := 66;
      erase(ff);
    end;
end.

