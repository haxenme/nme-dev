/* Define to the library version */
#define ALSOFT_VERSION "1.15.1"

#define AL_ALEXT_PROTOTYPES



#ifdef HX_MACOS



// Why does cmake need this?
#define SIZEOF_LONG sizeof(long)
#define SIZEOF_LONG_LONG sizeof(long long)

/* API declaration export attribute */
#define AL_API  __attribute__((visibility("default")))
#define ALC_API __attribute__((visibility("default")))

/* Define any available alignment declaration */
#define ALIGN(x) __attribute__((aligned(x)))

/* Define to the appropriate 'restrict' keyword */
#define RESTRICT restrict
#define HAVE_POSIX_MEMALIGN
#define HAVE_SSE
#define HAVE_COREAUDIO
#define HAVE_WAVE
#define HAVE_STAT
#define HAVE_LRINTF
#define HAVE_STRTOF
#define HAVE_GCC_DESTRUCTOR
#define HAVE_GCC_FORMAT
#define HAVE_STDINT_H
#define HAVE_DLFCN_H
#define HAVE_XMMINTRIN_H
#define HAVE_CPUID_H
#define HAVE_FLOAT_H
#define HAVE_FENV_H
#define HAVE_FESETROUND
#define HAVE_PTHREAD_SETSCHEDPARAM



#elif defined(HX_WINDOWS)


#define AL_API
#define ALC_API

// Why does cmake need this?
#define SIZEOF_LONG sizeof(long)
#define SIZEOF_LONG_LONG sizeof(long long)

#define ALIGN(x) __declspec(align(x))
#define RESTRICT __restrict
#define HAVE__ALIGNED_MALLOC
#define HAVE_SSE
#define HAVE_MMDEVAPI
#define HAVE_DSOUND
#define HAVE_WINMM
#define HAVE_WAVE
#define HAVE_STAT
#define HAVE_STDINT_H
#define HAVE_WINDOWS_H
#define HAVE_XMMINTRIN_H
#define HAVE_MALLOC_H
#define HAVE_GUIDDEF_H
#define HAVE_FLOAT_H
#define HAVE__CONTROLFP
#define HAVE___CONTROL87_2

#define strcasecmp _stricmp
#define strncasecmp _strnicmp
#if defined(_MSC_VER) && _MSC_VER <1900
#define snprintf _snprintf
#endif
//#define isfinite _finite
//#define isnan _isnan



#elif defined(HX_LINUX)



/* API declaration export attribute */
#define AL_API  __attribute__((visibility("protected")))
#define ALC_API __attribute__((visibility("protected")))

/* Define to the library version */
#define ALSOFT_VERSION "1.15.1"

/* Define any available alignment declaration */
#define ALIGN(x) __attribute__((aligned(x)))
#ifdef __MINGW32__
#define align(x) aligned(x)
#endif

/* Define to the appropriate 'restrict' keyword */
#define RESTRICT __restrict

/* Define if we have the C11 aligned_alloc function */
/* #undef HAVE_ALIGNED_ALLOC */

/* Define if we have the posix_memalign function */
#define HAVE_POSIX_MEMALIGN

/* Define if we have the _aligned_malloc function */
/* #undef HAVE__ALIGNED_MALLOC */

/* Define if we have SSE CPU extensions */
//#define HAVE_SSE

// Disable for now, may work with different HXCPP compile flags?

/* Define if we have ARM Neon CPU extensions */
/* #undef HAVE_NEON */

/* Define if we have the ALSA backend */
#define HAVE_ALSA

/* Define if we have the OSS backend */
#define HAVE_OSS

/* Define if we have the Solaris backend */
/* #undef HAVE_SOLARIS */

/* Define if we have the SndIO backend */
/* #undef HAVE_SNDIO */

/* Define if we have the MMDevApi backend */
/* #undef HAVE_MMDEVAPI */

/* Define if we have the DSound backend */
/* #undef HAVE_DSOUND */

/* Define if we have the Windows Multimedia backend */
/* #undef HAVE_WINMM */

/* Define if we have the PortAudio backend */
/* #undef HAVE_PORTAUDIO */

/* Define if we have the PulseAudio backend */
#define HAVE_PULSEAUDIO

/* Define if we have the CoreAudio backend */
/* #undef HAVE_COREAUDIO */

/* Define if we have the OpenSL backend */
/* #undef HAVE_OPENSL */

/* Define if we have the Wave Writer backend */
#define HAVE_WAVE

/* Define if we have the stat function */
#define HAVE_STAT

/* Define if we have the lrintf function */
#define HAVE_LRINTF

/* Define if we have the strtof function */
#define HAVE_STRTOF

/* Define if we have the __int64 type */
/* #undef HAVE___INT64 */

/* Define to the size of a long int type */
#define SIZEOF_LONG 8

/* Define to the size of a long long int type */
#define SIZEOF_LONG_LONG 8

/* Define if we have GCC's destructor attribute */
#define HAVE_GCC_DESTRUCTOR

/* Define if we have GCC's format attribute */
#define HAVE_GCC_FORMAT

/* Define if we have stdint.h */
#define HAVE_STDINT_H

/* Define if we have windows.h */
/* #undef HAVE_WINDOWS_H */

/* Define if we have dlfcn.h */
#define HAVE_DLFCN_H

/* Define if we have pthread_np.h */
/* #undef HAVE_PTHREAD_NP_H */

/* Define if we have xmmintrin.h */
#define HAVE_XMMINTRIN_H

/* Define if we have arm_neon.h */
/* #undef HAVE_ARM_NEON_H */

/* Define if we have malloc.h */
#define HAVE_MALLOC_H

/* Define if we have cpuid.h */
#define HAVE_CPUID_H

/* Define if we have guiddef.h */
/* #undef HAVE_GUIDDEF_H */

/* Define if we have initguid.h */
/* #undef HAVE_INITGUID_H */

/* Define if we have ieeefp.h */
/* #undef HAVE_IEEEFP_H */

/* Define if we have float.h */
#define HAVE_FLOAT_H

/* Define if we have fenv.h */
#define HAVE_FENV_H

/* Define if we have fesetround() */
#define HAVE_FESETROUND

/* Define if we have _controlfp() */
/* #undef HAVE__CONTROLFP */

/* Define if we have __control87_2() */
/* #undef HAVE___CONTROL87_2 */

/* Define if we have pthread_setschedparam() */
#define HAVE_PTHREAD_SETSCHEDPARAM



#endif
