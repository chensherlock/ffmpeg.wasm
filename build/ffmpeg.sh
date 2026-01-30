#!/bin/bash

set -euo pipefail

CONF_FLAGS=(
  --target-os=none              # disable target specific configs
  --arch=x86_32                 # use x86_32 arch
  --disable-everything
  --disable-network
  --enable-cross-compile        # use cross compile configs
  --disable-asm                 # disable asm
  --disable-stripping           # disable stripping as it won't work
#  --disable-programs            # disable ffmpeg, ffprobe and ffplay build
#  --disable-doc                 # disable doc build
#  --disable-debug               # disable debug mode
  --disable-runtime-cpudetect   # disable cpu detection
  --disable-autodetect          # disable env auto detect
  --enable-small
  --enable-decoder=pcm_s16le,pcm_s24le,pcm_f32le,pcm_u8,pcm_s16be,pcm_s32be,pcm_mulaw,mp3*,flac,opus,vorbis
  --enable-encoder=pcm_s16le,pcm_s24le,pcm_f32le,pcm_u8,pcm_s16be,pcm_s32be,pcm_mulaw,libmp3lame,flac,opus,vorbis
  --enable-demuxer=pcm_s16le,pcm_s24le,pcm_f32le,pcm_u8,pcm_s16be,pcm_s32be,pcm_mulaw,wav,mp3,flac,opus,ogg,caf
  --enable-muxer=pcm_s16le,pcm_s24le,pcm_f32le,pcm_u8,pcm_s16be,pcm_s32be,pcm_mulaw,wav,mp3,flac,opus,caf
  --enable-parser=mpegaudio,opus
  --enable-filter=aresample,afilter,anull,atrim,aformat,acopy
  --enable-protocol=file
  --enable-libmp3lame     # enable libmp3lame
  --enable-libvorbis      # enable libvorbis
  --enable-libopus        # enable opus
  # assign toolchains and extra flags
  --nm=emnm
  --ar=emar
  --ranlib=emranlib
  --cc=emcc
  --cxx=em++
  --objcc=emcc
  --dep-cc=emcc
  --extra-cflags="$CFLAGS"
  --extra-cxxflags="$CXXFLAGS"

  # disable thread when FFMPEG_ST is NOT defined
  ${FFMPEG_ST:+ --disable-pthreads --disable-w32threads --disable-os2threads}
)

emconfigure ./configure "${CONF_FLAGS[@]}" $@
emmake make -j
