# StateMachineIterators

[![Build Status](https://travis-ci.org/rdeits/StateMachineIterators.jl.svg?branch=master)](https://travis-ci.org/rdeits/StateMachineIterators.jl)
[![codecov](https://codecov.io/gh/rdeits/StateMachineIterators.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/rdeits/StateMachineIterators.jl)

This package implements a general-purpose state machine, consisting of a set of states and transitions between those states. Each transition occurs when a specified check function returns `true`. The StateMachineIterator type allows state machines to behave as general Julia iterators, which can be combined with functions like Base.zip() and Iterators.chain().

For more, check out the [example notebook](https://github.com/rdeits/StateMachineIterators.jl/blob/master/examples/state_machines.ipynb).
