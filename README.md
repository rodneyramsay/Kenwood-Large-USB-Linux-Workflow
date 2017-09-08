# Kenwood USB flow

Kenwood Car Audio USB Drive work flow for linux. This flow is centered on flac lossless data.


trim-audio : Perl script to trim audio files to 20 minutes. Kenwood USB player requires flac 20 minutes or less.

Makefile : Make file to run flow steps.

kenwood_usb_flow.txt Description of library prep, USB drive prep, and copying steps.

This flow is working for kenwood DPX502BT with 128GB Sandisk Cruzer thumb drive. Also works with SanDisk SD Card Reader.


Required tools:
   sox     - sound eXchange for splitting long files. http://sox.sourceforge.net/
   rename  - Larry Wall's rename program modified.    https://gist.github.com/zhasm/663538
   FLAC    - Using flac encoding here.                https://xiph.org/flac/
   




