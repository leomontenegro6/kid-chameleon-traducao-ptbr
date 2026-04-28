@echo off
call build.bat
.\flips.exe -c "Kid Chameleon (USA, Europe).md" "kid_built.bin" "Kid Chameleon [BR] v10.ips"

del "[SMD] Kid Chameleon (U) (1.0).zip"
.\7z.exe a -tzip "[SMD] Kid Chameleon (U) (1.0).zip"^
    "Kid Chameleon [BR] v10.ips"^
    "LEIAME.txt"

del "Kid Chameleon [BR] v10.ips"