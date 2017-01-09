#!/bin/bash
# Some Debian configuration for myself.
# By Arvin.X.

# ida, jeb, jadx icons
echo -n "Add icons in dock..."
cat > /usr/share/applications/ida.desktop <<EOF
[Desktop Entry]                                                             
Type=Application
Name=IDA
Comment= "IDA 32bit"
Icon=/root/tools/ida/appico.png
Exec=wine /root/tools/ida/idaq.exe
Terminal=false
EOF

cat > /usr/share/applications/ida64.desktop <<EOF
[Desktop Entry]                                                             
Type=Application
Name=IDA64
Comment= "IDA 64bit"
Icon=/root/tools/ida/appico64.png
Exec=wine /root/tools/ida/idaq64.exe
Terminal=false
EOF

cat > /usr/share/applications/jeb.desktop <<EOF
[Desktop Entry]                                                             
Type=Application
Name=jeb
Comment= "jeb"
Icon=/root/tools/jeb/bin/icon.xpm
Exec=/root/tools/jeb/bin/jeb
Terminal=false
EOF

cat > /usr/share/applications/jadx.desktop <<EOF
[Desktop Entry]                                                             
Type=Application
Name=jadx
Comment= "jadx"
Icon=/root/tools/jadx/java_icon.png
Exec=/root/tools/jadx/bin/jadx-gui
Terminal=false
EOF

echo "Done."

