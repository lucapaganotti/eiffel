#include <stdio.h>
#include <stdint.h>
#include "eif_eiffel.h"

// typedef for useful function pointer
typedef void (*cbfunc_t)(int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick);

cbfunc_t fn = NULL;

// eiffel side object reference
EIF_OBJECT obj = NULL;
// eiffel side object routine to be called
EIF_POINTER routine  = NULL;
EIF_POINTER callback = NULL;

// set the routine pointer
void c_set_routine (EIF_POINTER routine_a) 
{
  routine = routine_a;
}

// set the object reference
void c_set_object (EIF_REFERENCE obj_a)
{
  if(obj != NULL) 
  {
    eif_wean (obj);
  }
  obj = eif_protect (obj_a);
}

// set the callback pointer
void c_set_callback (EIF_POINTER c)
{
  callback = c;
}

// do the call
void c_do_callback ()
{
  ((void (*) (EIF_REFERENCE)) routine) (eif_access (obj));
}

// do the call with parameters
void c_do_cbfunc (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick)
{
  ((void (*) (EIF_REFERENCE, int, unsigned int, unsigned int, uint32_t)) routine) (eif_access(obj), pi, user_gpio, edge, tick);
}

void c_set_cbfunc(EIF_POINTER f)
{
  cbfunc_t intf = (cbfunc_t)(f);
  fn = intf;
  printf("f:          %#X\n", f);
  printf("fn:         %#X\n", fn);
  printf("internal f: %#X\n", intf);
}

void c_wean_cbfunc(EIF_POINTER f)
{
  eif_wean(f);
}

void c_call_cbfunc(int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick)
{
  printf("fn: %#X\n", fn);
  printf("pi: %d\n", pi);
  printf("user_gpio: %d\n", user_gpio);
  printf("edge: %d\n", edge);
  printf("tick: %d\n", tick);
  if( fn != NULL )
  {
    printf("call fn\n");
    ((void (*) (EIF_REFERENCE, int, unsigned int, unsigned int, uint32_t))fn) (eif_access(obj), pi, user_gpio, edge, tick);
    printf("fn called\n");
  }
  else
  {
    printf("fn is null\n");
  }
}

