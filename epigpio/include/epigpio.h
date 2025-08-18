#include <stdio.h>
#include <stdint.h>
#include "eif_eiffel.h"

#ifndef __EPIGPIO_H__
#define __EPIGPIO_H__

// typedef for useful function pointer
typedef void (*cbfunc_t)      (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick);
typedef void (*cbfuncex_t)    (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick, void* userdata);
typedef void (*evtcbfunc_t)   (int pi, unsigned int event,     uint32_t tick);
typedef void (*evtcbfuncex_t) (int pi, unsigned int event,     uint32_t tick, void* useerdata);

cbfunc_t      either_fn    = NULL;
cbfunc_t      rising_fn    = NULL;
cbfunc_t      falling_fn   = NULL;

cbfuncex_t    either_exfn  = NULL;
cbfuncex_t    rising_exfn  = NULL;
cbfuncex_t    falling_exfn = NULL;

evtcbfunc_t   efn          = NULL;
evtcbfuncex_t eexfn        = NULL;

// eiffel side object reference
EIF_OBJECT obj = NULL;
// eiffel side object routine to be called
EIF_POINTER routine  = NULL;

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

/*
  callbacks examples
*/

void c_either_edge_callback (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick)
{
  printf("callback called on gpio %d changing state for pi %d at tick %#X\n", user_gpio, pi, tick);
}

void c_rising_edge_callback (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick)
{
  printf("callback called on gpio %d rising state for pi %d at tick %#X\n", user_gpio, pi, tick);
}

void c_falling_edge_callback (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick)
{
  printf("callback called on gpio %d falling state for pi %d at tick %#X\n", user_gpio, pi, tick);
}

cbfunc_t c_get_either_edge_callback()
{
  either_fn = &c_either_edge_callback;
  return either_fn;
}

cbfunc_t c_get_rising_edge_callback()
{
  rising_fn = &c_rising_edge_callback;
  return rising_fn;
}

cbfunc_t c_get_falling_edge_callback()
{
  falling_fn = &c_falling_edge_callback;
  return falling_fn;
}

void c_either_edge_callback_ex (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick, void* userdata)
{
  printf("callback ex called on gpio %d changing state for pi %d at tick %#X with userdata %#X\n", user_gpio, pi, tick, userdata);
}

void c_rising_edge_callback_ex (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick, void* userdata)
{
  printf("callback ex called on gpio %d rising state for pi %d at tick %#X with userdata %#X\n", user_gpio, pi, tick, userdata);
}

void c_falling_edge_callback_ex (int pi, unsigned int user_gpio, unsigned int edge, uint32_t tick, void* userdata)
{
  printf("callback ex called on gpio %d falling state for pi %d at tick %#X with userdata %#X\n", user_gpio, pi, tick, userdata);
}

cbfuncex_t c_get_either_edge_callback_ex()
{
  either_exfn = &c_either_edge_callback_ex;
  return either_exfn;
}

cbfuncex_t c_get_rising_edge_callback_ex()
{
  rising_exfn = &c_rising_edge_callback_ex;
  return rising_exfn;
}

cbfuncex_t c_get_falling_edge_callback_ex()
{
  falling_exfn = &c_falling_edge_callback_ex;
  return falling_exfn;
}

/*
  events callback examples
*/
void c_event_callback_example (int pi, unsigned int event, uint32_t tick)
{
	printf("event callback called for pi %d for event %d at tick %#X\n", pi, event, tick);
}

void c_event_callback_ex_example(int pi, unsigned int event, uint32_t tick, void* userdata)
{
	printf("event callback ex called for pi %d for event %d at tick %#X with userdata %#X\n", pi, event, tick, userdata);
}

evtcbfunc_t c_get_event_callback_example()
{
	efn = &c_event_callback_example;
	return efn;
}

evtcbfuncex_t c_get_event_callback_ex_example()
{
	eexfn = &c_event_callback_ex_example;
	return eexfn;
}


#endif

