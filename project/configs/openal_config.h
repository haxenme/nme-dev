/* Define to the library version */
#define ALSOFT_VERSION "1.15.1"

// Why does cmake need this?
#define SIZEOF_LONG sizeof(long)
#define SIZEOF_LONG_LONG sizeof(long long)
#define AL_ALEXT_PROTOTYPES

#ifdef HX_MACOS

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



// Static...
#define AL_API
#define ALC_API

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


#endif // HX OS
