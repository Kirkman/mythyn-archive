Thieves' Guild
==============

This directory contains the source code for several versions of Thieves' Guild, a door game for Atari ST BBSes, created by Paul Witte of Mythyn Software. The game was written in Pascal using OSS's Personal Pascal compiler. 

In 1995, Myron Crandall ported the game to Turbo Pascal so it could run on the PC. Although a ZIP file was prepared for shareware distribution, the PC version doesn't appear to have actually been distributed.

Atari
-----

The `/atari/` directory contains source code for two versions of the game for that platform. It also contains the source code for an early or experimental version of the "Thieves Guild Emulator," a graphical front-end client for playing the game; as well as some early artwork for the emulator.

### `/artwork/`

`TGTOR.NEO` is a NeoChrome image file created by Herb Flower, bearing a modification date of 1990-04-04. It contains four scenes, some of which are clearly incomplete. At least one of these scenes (the torture chamber) made it into the final emulator.

### `/emulator/`

This directory contains the GFA BASIC source code for what appears to be an early or experimental version of the Thieves' Guild Emulator. Most of the files bear the default Atari ST creation date of 1985-11-20, but `TGCFG.MYT` has a date of 1990-02-18. The .DAT files here appear to be sound files.

### `/v1.5/`

This directory contains only two files: the Pascal source code for the Thieves' Guild game and its data editor program. The files themselves bear the default Atari ST creation date of 1985-11-20, so it's impossible to date them precisely. The code itself has a copyright year of 1990, and the game is described as version 1.5.

### `/v2.5b/`

This directory contains the the Pascal source code for the Thieves' Guild game and its data editor program, as well as several supporting files. Most of the files in this directory have file modification dates in 1992-93. 

* `EDITOR.PAS`: Source code to the editor
* `ENCRYPTG.PRG`: An encryption program used by the author to encrypt the text in data files
* `LZH201L.TTP`: A compression program for handling LZH archives
* `SYSOP_UN.DOC`: Sysop documentation template for the unregistered version. 
* `THIEVES.DOC`: Player documentation template for the registered version.
* `THIEVES.PAS`: Source code to the game
* `THIEVES2.DOC`: Player documentation template for the unregistered version. This appears to be an earlier draft of `THIEVES.DOC`; it lacks the three-part narrative introduction, and has several spelling mistakes which corrected in the later version.
* `THIEVES.LZH` and `/THIEVES/`: This archive and folder contain support files for the registered version of Thieves Guild. They would have been sent on a disk to sysops who paid the registration fee.
	- `EDITOR.TOS`: The compiled editor program
	- `RUMOURS`: A data file
	- `RUMOURS.DAT`: A data file
	- `SYSOP.DOC` Sysop documentation for the registered version
	- `TG_MSGS.DAT`: A data file
	- `THIEVES.DAT`: A data file
	- `THIEVES.DOC`: Player documentation. This version contains are several minor fixes, and two additional sections.
	- `THIEVES.SCR`: VT-52 title screen
	- `THIEVES.SET`: A configuration file
	- `TOWNS.DAT`: A data file

A note about v2.5b: This version compiles into a playable executable. The presence of some variables (such as `MITCH`) in `THIEVES.PAS` may indicate that Myron Crandall contributed to this version.





PC
--

The `/pc/` directory contains Myron Crandall's work on porting Thieves' Guild to the PC. There are two main directories, one containing the Turbo Pascal source code, the other containing compiled files apparently intended for distribution.

The Pascal source files all bear a modification date of 1995-08-01, except `THIEVES.PAS` which is dated 1995-09-05.

It is worth noting that the THIEVES.EXE in `/distribution/` will not run under DOSBOX. The same errors that display in DOSBOX apparently were occurring at the time it was compiled, since they match what is recorded in `ERROR.LOG` in the `/source/` directory.

Also of note: Crandall apparently added several cheats to the PC version. See `MAGIC.PAS`, for example.

