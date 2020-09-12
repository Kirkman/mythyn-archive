program makeBBSDefinition;

uses crt;

  const
    maxRegistrations = 100;


  type
     str80 = string[80];

     turmoil = record
                 num         : integer;
                 sysopName   : str80;
                 bbsName     : str80;
                 bbsNumber   : str80;
                 serialNum   : str80;
                 dateReg     : str80;
               end;
     total = array[0..maxRegistrations] of turmoil;

  var
    dataBase : total;


procedure initDataBase(start:integer; finish:integer);

  var
    x : integer;

  begin

    for x := start to finish do
      begin
        dataBase[x].num := 0;
        dataBase[x].sysopName := '';
        dataBase[x].bbsName := '';
        dataBase[x].bbsNumber := '';
        dataBase[x].serialNum := '';
        dataBase[x].dateReg := '';
      end;
  end;

procedure saveDataBase;

  var
    ff : file of turmoil;
    x : integer;

  begin
    assign(ff,'database.dat');
    rewrite(ff);
    write(ff,dataBase[0]);
    for x := 1 to dataBase[0].num do
      write(ff,dataBase[x]);
    close(ff);
  end;

procedure loadDataBase;

  var
    ff : file of turmoil;
    x : integer;

  begin
    assign(ff,'database.dat');
    reset(ff);
    read(ff,dataBase[0]);
    for x := 1 to dataBase[0].num do
      read(ff,dataBase[x]);
    close(ff);
    initDataBase(dataBase[0].num+1,maxRegistrations);
  end;

procedure encrypt(st:str80; var st2:str80);

  var
    y,q,x,i,z,t : integer;
    encKey : string[180];
    caca : str80;
  begin
    encKey := 'Gytwdy6666357t672^%$^&T#HujB2^%$^&DY%7uG@YGX&D^&*STYGHUH@IHDLS(*@++FIOS|7uG@YGX&';
    z := 0;
    for x := 1 to length(st) do
      begin
        if x mod 2 = 0 then
          i := ord(st[x]) + ord(encKey[x])
        else
          i := ord(st[x]) - ord(encKey[x]);
        if i < 0 then i := i + 255;
        if i > 255 then i := i - 225;
        st[x] := chr(i);
        z := z + ord(st[x]);
      end;
    q := length(st);
(*    caca := copy(encKey,q+1,77-q);
{    for x := length(st)+1 to 77 do
      begin
        z := z + ord(encKey[x]);
      end;}*)
    caca := '';
    for x := 1 to 77-q do
      begin
        caca := concat(caca,chr(random(256)));
      end;

    for x := 1 to length(caca) do
      z := z + ord(caca[x]);
    x := z div 256;
    t := z mod 256;
    st2 := concat(chr(x),chr(t),st,caca,chr(q));
    for x := 1 to length(st2) do
      begin
       y := ord(st2[x]) xor ord(encKey[x]);
       st2[x] := chr(y);
      end;
  end;

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


procedure showReg(num:integer);

  begin
    writeln('SysOp name: ',dataBase[num].sysopName);
    writeln('BBS Name  : ',dataBase[num].bbsName);
    writeln('BBS Number: ',dataBase[num].bbsNumber);
    writeln('Serial #  : ',dataBase[num].serialNum);
    writeln('Date Registered: ',dataBase[num].dateReg);
  end;


procedure editRegistration;

  var
    nums : str80;
    num  : integer;
    code : integer;
    ch : char;

  begin
    write('Enter number to edit: ');
    readln(nums);
    val(nums,num,code);
    if num > dataBase[0].num then
      begin
        writeln('No registration that high...');
        delay(1000);
      end
    else
      begin
        clrscr;
        showReg(num);
        writeln;
        write('Edit this one? ');
        repeat ch := upcase(readkey) until ch in ['Y','N'];
        if ch = 'Y' then
          begin
            write('Enter SysOp name: ');
            readln(dataBase[num].sysopName);
            write('Enter BBS Name  : ');
            readln(dataBase[num].bbsName);
            write('Enter BBS Number: ');
            readln(dataBase[num].bbsNumber);
            write('Enter Serial #  : ');
            readln(dataBase[num].serialNum);
            write('Enter todays date: ');
            readln(dataBase[num].dateReg);
          end;
      end;
  end;



procedure addRegistration;

  var
    ff          : text;
    ch          : char;
    encrypted   : array[1..4] of str80;
    unencrypted : array[1..4] of str80;
    checksum    : integer;
    x, y        : integer;
    numToAdd    : integer;

  begin
    dataBase[0].num := dataBase[0].num + 1;
    numToAdd := dataBase[0].num;
    repeat
      dataBase[numToAdd].num := numToAdd;
      write('Enter SysOp name: ');
      readln(dataBase[numToAdd].sysopName);
      write('Enter BBS Name  : ');
      readln(dataBase[numToAdd].bbsName);
      write('Enter BBS Number: ');
      readln(dataBase[numToAdd].bbsNumber);
      write('Enter Serial #  : ');
      readln(dataBase[numToAdd].serialNum);
      write('Enter todays date: ');
      readln(dataBase[numToAdd].dateReg);
      writeln('Now encrypting...');
      encrypt(dataBase[numToAdd].sysopName,encrypted[1]);
      encrypt(dataBase[numToAdd].bbsName,encrypted[2]);
      encrypt(dataBase[numToAdd].bbsNumber,encrypted[3]);
      encrypt(dataBase[numToAdd].serialNum,encrypted[4]);
      for x := 1 to 4 do
        if not (unencrypt(encrypted[x],unencrypted[x],checksum)) then
          writeln('not able to unencrypt... FAILED!!!');
      for x := 1 to 4 do
        writeln(unencrypted[x]);
      writeln('Is that ok?');
      ch := upcase(readkey);
    until ch in ['Y','Q'];
    if ch = 'Y' then
      begin
        assign(ff,'tgbbsreg.cfg');
        rewrite(ff);
        for x := 1 to 4 do
          for y := 1 to 80 do
            write(ff,encrypted[x,y]);
        close(ff);
        writeln('File now created!!!');
      end;
  end;

procedure readFile;

  var
    ff : text;
    encrypted   : array[1..4] of str80;
    unencrypted : array[1..4] of str80;
    x, y : integer;
    ch : char;
    checksum : integer;


  begin
    assign(ff,'tgbbsreg.cfg');
    reset(ff);
    for x := 1 to 4 do
      begin
        encrypted[x] := '';
        for y := 1 to 80 do
          begin
            read(ff,ch);
            encrypted[x] := concat(encrypted[x],ch);
          end;
      end;
      for x := 1 to 4 do
        if not (unencrypt(encrypted[x],unencrypted[x],checksum)) then
          writeln('not able to unencrypt... FAILED!!!');
      for x := 1 to 4 do
        writeln(unencrypted[x]);
      writeln;
      writeln('<press any key>');
      readkey;
    end;


procedure createKeyDef(num : integer);

  var
    ff          : text;
    ch          : char;
    encrypted   : array[1..4] of str80;
    unencrypted : array[1..4] of str80;
    checksum    : integer;
    x, y        : integer;

  begin
    clrscr;
    showReg(num);
    writeln('Now encrypting...');
    encrypt(dataBase[num].sysopName,encrypted[1]);
    encrypt(dataBase[num].bbsName,encrypted[2]);
    encrypt(dataBase[num].bbsNumber,encrypted[3]);
    encrypt(dataBase[num].serialNum,encrypted[4]);
    for x := 1 to 4 do
      if not (unencrypt(encrypted[x],unencrypted[x],checksum)) then
        writeln('not able to unencrypt... FAILED!!!');
    for x := 1 to 4 do
      writeln(unencrypted[x]);
    writeln('Is that ok?');
    ch := upcase(readkey);
    if ch = 'Y' then
      begin
        assign(ff,'tgbbsreg.cfg');
        rewrite(ff);
        for x := 1 to 4 do
          for y := 1 to 80 do
            write(ff,encrypted[x,y]);
        close(ff);
        writeln('File now created!!!');
      end;
  end;


procedure showRegistration;

  var
    nums : str80;
    num  : integer;
    code : integer;

  begin
    write('Enter number to show: ');
    readln(nums);
    val(nums,num,code);
    if num > dataBase[0].num then
      begin
        writeln('No registration that high...');
        delay(1000);
      end
    else
      begin
        clrscr;
        showReg(num);
        writeln;
        writeln('<press any key to continue>');
        readkey;
      end;
  end;


procedure createRegistrationFile;

  var
    nums : str80;
    num  : integer;
    code : integer;

  begin
    write('Enter number of Registration to create: ');
    readln(nums);
    val(nums,num,code);
    if num > dataBase[0].num then
      begin
        writeln('No registration that high...');
        delay(1000);
      end
    else
      begin
        createKeyDef(num);
        writeln;
        writeln('<press any key to continue>');
        readkey;
      end;
  end;



procedure findRegistration;

  begin
  end;

procedure displayRegistrations;

  var
    x : integer;
    y : integer;

  begin
    clrscr;
    for x := 1 to dataBase[0].num do
      begin
        if (x mod 20 = 0) then
          begin
            writeln('<press any key>');
            readkey;
            clrscr;
          end;
        write(dataBase[x].sysopName);
          for y := 1 to 25 - length(dataBase[x].sysopName) do write(' ');
        write(dataBase[x].serialNum);
          for y := 1 to 6 - length(dataBase[x].serialNum) do write(' ');
        write(dataBase[x].bbsName);
          for y := 1 to 20 - length(dataBase[x].bbsName) do write(' ');
        write(dataBase[x].bbsNumber);
          for y := 1 to 18 - length(dataBase[x].bbsNumber) do write(' ');
        write(dataBase[x].dateReg);
        writeln;
      end;
    writeln('<press any key>');
    readkey;
  end;


procedure main;

  var
    hc, ch : char;

  begin
    repeat
      repeat
         clrscr;
         writeln('A)dd new registration');
         writeln('S)how specific registration');
         writeln('F)ind registration');
         writeln('D)isplay registrations');
         writeln('C)reate registration file');
         writeln('R)ead current Key Def file');
         writeln('I)nitialize data base');
         writeln('E)dit a registeration');
         writeln('Q)uit registration program');
         writeln;
         write('--> ');
         ch := upcase(readkey);
         writeln(ch);
      until ch in ['A','S','F','Q','D','C','R','E'];
      case(ch) of
        'A' : addRegistration;
        'S' : showRegistration;
        'F' : findRegistration;
        'D' : displayRegistrations;
        'C' : createRegistrationFile;
        'E' : editRegistration;
        'I' : begin
                writeln;
                writeln('Initializing data base is disasterous... are you sure?');
                repeat hc := upcase(readkey) until hc in ['Y','N'];
                if hc = 'Y' then
                  initDataBase(0,maxRegistrations);
              end;
        'R' : readFile;
      end;
    until ch = 'Q';
  end;


begin
  loadDataBase;
  writeln('Read in ',dataBase[0].num,' records...');
  delay(1000);
  main;
  writeln('Saving ',dataBase[0].num,' records...');
  saveDataBase;
end.
