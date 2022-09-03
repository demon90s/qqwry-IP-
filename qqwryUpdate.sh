#!/bin/sh
cd `dirname $0`
yum -y install php
mkdir -p qqwryTemp
cd qqwryTemp
wget http://update.cz88.net/ip/copywrite.rar
wget http://update.cz88.net/ip/qqwry.rar
cat > unlock.php <<EOF
<?php
\$copywrite = file_get_contents("copywrite.rar");
\$qqwry = file_get_contents("qqwry.rar");
\$key = unpack("V6", \$copywrite)[6];
for (\$i = 0; \$i < 512; \$i++) {
    \$key = ((\$key * 2053) + 1) & 0xFF;
    \$qqwry[\$i] = chr(ord(\$qqwry[\$i]) ^ \$key);
}
\$qqwry = gzuncompress(\$qqwry);
\$fp = fopen("qqwry.dat", "wb");
fwrite(\$fp, \$qqwry);
fclose(\$fp);
?>
EOF
php unlock.php
cd ..
cp -f qqwryTemp/qqwry.dat qqwry.dat
rm -rf qqwryTemp/
