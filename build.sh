cd tools/build
haxe compile.hxml
cd ../..
cd project
neko build.n $@
cd ..