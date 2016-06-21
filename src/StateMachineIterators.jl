__precompile__()

module StateMachineIterators

import Base: start, done, next, show
import DataStructures: OrderedDict

export StateMachine,
    StateMachineIterator,
    initial,
    final,
    finished,
    addtransition!,
    nextstate

type State
    name::Symbol
    transitions::OrderedDict{Function, State}
end

State(name::Symbol) = State(name, OrderedDict{Function, State}())

type StateMachine
    states::Dict{Symbol, State}
    initial::State
    final::State
end

initial(machine::StateMachine) = machine.initial.name
final(machine::StateMachine) = machine.final.name

function addtransition!(machine::StateMachine, from::Symbol, check::Function, to::Symbol)
    from_state = get!(machine.states, from, State(from))
    to_state = get!(machine.states, to, State(to))
    from_state.transitions[check] = to_state
end

function StateMachine(initial::Symbol, final::Symbol, transitions::Vector{Tuple{Symbol, Function, Symbol}})
    initial_state = State(initial)
    final_state = State(final)
    states = Dict{Symbol, State}(initial => initial_state, final => final_state)
    machine = StateMachine(states, initial_state, final_state)
    for (from, check, to) in transitions
        addtransition!(machine, from, check, to)
    end
    machine
end

show(io::IO, machine::StateMachine) = println("StateMachine with states: $(collect(keys(machine.states)))
    initial state: $(machine.initial.name)
    final state: $(machine.final.name)")

function nextstate(state::State, input)
    for (check, destination) in state.transitions
        check(input) && return destination
    end
    state # if no transitions match, then return current state
end

nextstate(machine::StateMachine, current_state::Symbol, input) = nextstate(machine.states[current_state], input).name
finished(machine::StateMachine, state::Symbol) = machine.states[state] == machine.final

type StateMachineIterator
    machine::StateMachine
    input::Function
end

name_and_state(x::State) = (x.name, x)

start(iter::StateMachineIterator) = iter.machine.initial
done(iter::StateMachineIterator, state::State) = state == iter.machine.final
next(iter::StateMachineIterator, state::State) = name_and_state(nextstate(state, iter.input()))

end
