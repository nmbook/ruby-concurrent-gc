# Ruby with Concurrent GC

Ruby Language
=============
See README for information on Ruby itself.

This is built on version 1.9.3-p429.

Concurrent GC Plan
==================

- update init_heap()
 1. initialize shared memory page
- update gc_newobj()
 1. check freelist: do we need to GC (low)?
  * can we go concurrent?
   1. disallow to go concurrent
   2. prepare shared memory
   3. call fork
    1. call bg_garbage_collect
    2. update memory page
    3. signal changes
    4. exit
  * no?
    1. call garbage_collect (BLOCKING) // can we do lazy sweep here?
 2. return new object
- add bg_garbage_collect()
 * same as garbage_collect except only collects a freelist on sweep
- add signal handler for changes
 * merge changes
 * allow to go concurrent again

