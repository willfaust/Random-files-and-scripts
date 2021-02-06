rm -r -f hactool # removes any previous hactool instance

pkg update -y
pkg install git make clang binutils vim -y

git clone https://github.com/SciresM/hactool
mv hactool hactoolsrc
cd hactoolsrc
cp config.mk.template config.mk
make
mv hactool ..
cd ..
rm -r -f hactoolsrc
./hactool
