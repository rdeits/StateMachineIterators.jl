# StateMachineIterators

[![Build Status](https://travis-ci.org/rdeits/StateMachineIterators.jl.svg?branch=master)](https://travis-ci.org/rdeits/StateMachineIterators.jl)
[![codecov](https://codecov.io/gh/rdeits/StateMachineIterators.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/rdeits/StateMachineIterators.jl)

This package is inspired by the observation that a state machine, combined with a function that produces the inputs to that state machine, can be treated as an iterator. The StateMachineIterator type allows state machines to behave as general Julia iterators which can be combined using standard iterator tools like `zip()` and `Iterators.chain()`.

For more, check out the [example notebook](https://github.com/rdeits/StateMachineIterators.jl/blob/master/examples/state_machines.ipynb).

# Installation

```julia
Pkg.clone("git://github.com/rdeits/StateMachineIterators.jl.git")
```
