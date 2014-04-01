import sys.FileSystem;
import sys.io.File;

class Build extends hxcpp.Builder
{
   var buildArgs:Array<String>;

   override public function allowNdll() { return false; }

   override public function runBuild(target:String, isStatic:Bool, arch:String, inBuildFlags:Array<String>)
   {
      var android = target=="android";
      var ios = target=="ios";
      var blackberry = target=="blackberry";
      var tizen = target=="tizen";
      var emscripten = target=="emscripten";
      var webos = target=="webos";
      
      buildArgs = inBuildFlags;

      if (verbose)
         Sys.println('Build $target $isStatic $android ' + buildArgs);

      mkdir("bin");
      mkdir("unpack");
      mkdir("../include");
      
      if (emscripten)
      {
         buildFreetype("2.5.0.1");
         return;
      }
      
      buildZ("1.2.3");
      buildPng("1.2.24");
      buildJpeg("6b");
      buildFreetype("2.5.0.1");
      buildCurl("7.35.0","1.4.4");
      if (!android && !webos)
      {
         buildOgg("1.3.0");
         buildVorbis("1.3.3");
         if (!tizen)
         {
            buildTheora("1.1.1");
         }
      }

      buildModPlug("0.8.8.4");

      if (!android && !ios && !blackberry && !tizen && !webos)
      {
         buildSDL2("2.0.1");
         buildSDL2Mixer("2.0.0");
         buildOpenAL("1.15.1");
      }
   }

   override public function getCleanDir()
   {
      return "unpack";
   }

   public static function mkdir(inDir:String)
   {
      FileSystem.createDirectory(inDir);
   }

   public static function untar(inCheckDir:String,inTar:String,inBZ = false,baseDir="unpack")
   {
      if (inCheckDir!="")
      {
         if (FileSystem.exists(inCheckDir+"/.extracted"))
            return;
      }
      Sys.println("untar " + inTar);
      run("tar", [ inBZ ? "xf" : "xzf", "tars/" + inTar, "--no-same-owner", "-C", baseDir ]);
      if (inCheckDir!="")
         File.saveContent(inCheckDir+"/.extracted","extracted");
   }

   public static function run(inExe:String, inArgs:Array<String>)
   {
      var result = Sys.command(inExe,inArgs);
      if (result != 0)
      {
         Sys.exit(result);
      }
   }

   public static function copy(inFrom:String, inTo:String)
   {
      if (FileSystem.exists(inTo) && FileSystem.isDirectory(inTo))
         inTo += "/" + haxe.io.Path.withoutDirectory(inFrom);

      if (FileSystem.exists(inFrom) && FileSystem.exists(inTo))
      {
         if (File.getContent(inFrom)==File.getContent(inTo))
            return;
      }

      try {
         sys.io.File.copy(inFrom,inTo);
      }
      catch(e:Dynamic)
      {
         Sys.println("Could not copy " + inFrom + " to " + inTo + ":" + e);
         Sys.exit(1);
      }
   }

   public static function copyRecursive(inFrom:String, inTo:String)
   {
      if (!FileSystem.exists(inFrom))
      {
         Sys.println("Invalid copy : " + inFrom);
         Sys.exit(1);
      }
      if (FileSystem.isDirectory(inFrom))
      {
         mkdir(inTo);
         for(file in FileSystem.readDirectory(inFrom))
         {
            if (file.substr(0,1)!=".")
               copyRecursive(inFrom + "/" + file, inTo + "/" + file);
         }

      }
      else
         copy(inFrom,inTo);
   }


   public static function runIn(inDir:String, inExe:String, inArgs:Array<String>)
   {
      var oldPath:String = Sys.getCwd();
      Sys.setCwd(inDir);
      var result = Sys.command(inExe,inArgs);
      if (result != 0)
      {
         Sys.exit(result);
      }
      Sys.setCwd(oldPath);
   }

   public function buildZ(inVer:String)
   {
      var dir = 'unpack/zlib-$inVer';
      untar(dir,"zlib-" + inVer + ".tgz");
      copy("buildfiles/zlib.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "zlib.xml" ].concat(buildArgs));
      copy('$dir/zlib.h',"../include");
      copy('$dir/zconf.h',"../include");
   }

   public function buildPng(inVer:String)
   {
      var dir = 'unpack/libpng-$inVer';
      untar(dir,"libpng-" + inVer + ".tgz");
      copy("buildfiles/png.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "png.xml" ].concat(buildArgs));
      copy('$dir/png.h',"../include");
      copy('$dir/pngconf.h',"../include");
   }

   public function buildJpeg(inVer:String)
   {
      var dir = 'unpack/jpeg-$inVer';
      untar(dir,"jpeg-" + inVer + ".tgz");
      var configs = [ "h", "mac", "iphoneos", "vc", "linux" ];
      for(config in configs)
         copy('configs/jconfig.$config', dir);

      copy("buildfiles/jpeg.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "jpeg.xml" ].concat(buildArgs));
      for(config in configs)
         copy('configs/jconfig.$config', "../include");
      copy('$dir/jpeglib.h',"../include");
      copy('$dir/jmorecfg.h',"../include");
   }


   public function buildOgg(inVer:String)
   {
      var dir = 'unpack/libogg-$inVer';
      untar(dir,"libogg-" + inVer + ".tgz");
      copy('configs/ogg-config_types.h', dir+"/include/ogg/config_types.h");
      copy("buildfiles/ogg.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "ogg.xml" ].concat(buildArgs));
      mkdir("../include/ogg");
      copy('$dir/include/ogg/ogg.h',"../include/ogg");
      copy('configs/ogg-config_types.h', "../include/ogg/config_types.h");
      copy('$dir/include/ogg/os_types.h',"../include/ogg");
   }
   
   public function buildOpenAL(inVer:String)
   {
      var dir = 'unpack/openal-soft-$inVer';
      untar(dir,"openal-soft-" + inVer + ".tar.bz2", true);
      copy('configs/openal_config.h', dir+"/include/config.h");
      copy("buildfiles/openal.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "openal.xml" ].concat(buildArgs));
      mkdir("../include/AL");
      copyRecursive('$dir/include/AL', "../include/AL");
   }

   public function buildVorbis(inVer:String)
   {
      var dir = 'unpack/libvorbis-$inVer';
      untar(dir,"libvorbis-" + inVer + ".tgz");
      copy('patches/vorbis/os.h', dir+"/lib");
      copy("buildfiles/vorbis.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "vorbis.xml" ].concat(buildArgs));
      mkdir("../include/vorbis");
      copy('$dir/include/vorbis/vorbisfile.h',"../include/vorbis");
      copy('$dir/include/vorbis/codec.h',"../include/vorbis");
      copy('$dir/include/vorbis/vorbisenc.h',"../include/vorbis");
   }

   public function buildTheora(inVer:String)
   {
      var dir = 'unpack/libtheora-$inVer';
      untar(dir,"libtheora-" + inVer + ".tar.bz2", true);
      copy('patches/theora/theoraplay.c', dir+"/lib/theoraplay.cpp");
      copy('patches/theora/theoraplay.h', dir+"/include");
      copy('patches/theora/theoraplay_cvtrgb.h', dir+"/include");
      copy("buildfiles/theora.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "theora.xml" ].concat(buildArgs));
      mkdir("../include/theora");
      copy('$dir/include/theora/theora.h',"../include/theora");
      copy('$dir/include/theora/theoradec.h',"../include/theora");
      copy('$dir/include/theora/codec.h',"../include/theora");
      copy('$dir/include/theoraplay.h',"../include");
   }

   public function buildFreetype(inVer:String)
   {
      var dir = 'unpack/freetype-$inVer';
      untar(dir,"freetype-" + inVer + ".tgz");
      copy("buildfiles/freetype.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "freetype.xml" ].concat(buildArgs));
      copy('$dir/include/ft2build.h',"../include");
      copyRecursive('$dir/include/freetype',"../include/freetype");
   }


   public function buildCurl(inVer:String,inAxTlsVer:String)
   {

      var dir = 'unpack/curl-$inVer';
      untar(dir,"curl-" + inVer + ".tgz");

      var axtls = '$dir/axTLS';
      untar(axtls,"axTLS-" + inAxTlsVer + ".tgz", false, dir);
      copy(axtls+"/ssl/ssl.h", axtls+"/ssl.h");
      copy("configs/axTLS-config.h", axtls+"/config/config.h");
      copy("patches/curl/crypto_misc.c", axtls+"/crypto/crypto_misc.c");
      copy("patches/curl/axtls.c", dir+"/lib/vtls/axtls.c");


      copy("configs/curl_config.gcc", dir+"/lib/curl_config.h");
      copy("patches/curl/curlbuild.h", dir+"/include/curl");
      copy("buildfiles/curl.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "curl.xml", "-Dcurl_ssl" ].concat(buildArgs));
      copyRecursive('$dir/include/curl',"../include/curl");
   }


   public function buildSDL2(inVer:String)
   {
      var dir = 'unpack/SDL2-$inVer';
      untar(dir,"SDL2-" + inVer + ".tgz");
      copy("patches/SDL2/SDL_config_windows.h", dir+"/include");
      copy("patches/SDL2/SDL_config_linux.h", dir+"/include/SDL_config_minimal.h");
      copy("patches/SDL2/SDL_stdinc.h", dir+"/include");
      copy("buildfiles/sdl2.xml", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "sdl2.xml" ].concat(buildArgs));
      mkdir("../include/SDL2");
      copyRecursive('$dir/include',"../include/SDL2");
   }

   public function buildModPlug(inVer:String)
   {
      var dir = 'unpack/libmodplug-$inVer';
      untar(dir,"libmodplug-" + inVer + ".tgz");
      copy("buildfiles/modplug.xml", dir);
      copy("configs/modplug_config.h", dir+"/src/config.h");
      copy("patches/libmodplug/load_abc.cpp", dir+"/src");
      copy("patches/libmodplug/load_pat.cpp", dir+"/src");
      runIn(dir, "haxelib", ["run", "hxcpp", "modplug.xml" ].concat(buildArgs));
      copy('$dir/src/modplug.h',"../include/modplug.h");
   }



   public function buildSDL2Mixer(inVer:String)
   {
      var dir = 'unpack/SDL2_mixer-$inVer';
      untar(dir,"SDL2_mixer-" + inVer + ".tgz");
      copy("buildfiles/sdl2_mixer.xml", dir);
      copy("patches/SDL2_mixer/music.c", dir);
      runIn(dir, "haxelib", ["run", "hxcpp", "sdl2_mixer.xml" ].concat(buildArgs));
      mkdir("../include/SDL2");
      copy('$dir/SDL_mixer.h',"../include/SDL2/SDL_mixer.h");
   }


   public static function main()
   {
      new Build( Sys.args() );
   }
}

