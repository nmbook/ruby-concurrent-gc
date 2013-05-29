# Ruby with Concurrent GC

Ruby Language
=============
See [README] [1] for information on Ruby itself.

This is built on [version 1.9.3-p429] [2].

Concurrent GC Plan
==================

[x] update init_heap()
 * initialize shared memory page
[x] update gc_newobj()
 * check freelist: do we need to GC (low)?
 * can we go concurrent? if so: call concurrent_garbage_collect()
 * always return new object
[ ] add concurrent_garbage_collect()
 * same as garbage_collect except only collects a freelist into shared memory
  1. disallow to go concurrent
  2. prepare shared memory
  3. call fork(). if child: call child_garbage_collect(), else: return
[ ] add child_garbage_collect()
 * actions as child process
  1. call mark
  2. update memory page
  3. signal changes
  4. exit
[ ] add signal handler for changes
 * actions as parent process
  1. merge changes
  2. allow to go concurrent again

   [1]: https://github.com/nmbook/ruby-concurrent-gc/blob/master/README "Ruby README"
   [2]: https://github.com/ruby/ruby/tree/ruby_1_9_3                    "Ruby 1.9.3"
