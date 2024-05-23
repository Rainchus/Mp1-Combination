#ifndef _TYPES_H
#define _TYPES_H

typedef signed char             s8;
typedef unsigned char           u8;
typedef signed short int        s16;
typedef unsigned short int      u16;
typedef signed int              s32;
typedef unsigned int            u32;
typedef signed long long int    s64;
typedef unsigned long long int  u64;
typedef float                   f32;
typedef double                  f64;

#ifndef TRUE
#define TRUE    1
#endif

#ifndef FALSE
#define FALSE   0
#endif

#ifndef NULL
#define NULL    (void *)0
#endif

typedef void (*functionPtr)();

#endif