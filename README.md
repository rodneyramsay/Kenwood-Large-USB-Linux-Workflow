# Kenwood USB flow

Kenwood Car Audio USB Drive work flow for Linux. This flow is centered on FLAC lossless data.

trim-audio : Perl script to split audio files to 20 minutes. Kenwood
USB player requires flac 20 minutes or less (probably exacly 21:20 =
1280 Sec). The same time limit applies from 16/44.1k - 24/48k.

Makefile : Make file to run flow steps.

kenwood_usb_flow.txt Description of library prep, USB drive prep, and copying steps.

This flow is working for Kenwood DPX502BT with 256GB Sandisk Cruzer
thumb drive. Also works with SanDisk SD Card Reader.

Maximum resolution working so far is 24bit 48kHz. Player can nearly
handle 24bit/96kHz but it's giving dropouts at that rate with my
setup. Maybe with a different USB drive I can get up to 24bit/96kHz.

<hl>
   
Required tools:<br>
   sox     - sound eXchange. Used here for splitting long files. http://sox.sourceforge.net/<br>
   rename  - Larry Wall's rename program.                        https://gist.github.com/zhasm/663538<br>
   FLAC    - Using flac encoding.                                https://xiph.org/flac/<br>
   pmount  - Mount to USB under /media from command line         https://anonscm.debian.org/git/pmount/pmount.git<br>
   
   
   




