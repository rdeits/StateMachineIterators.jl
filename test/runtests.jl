using StateMachineIterators
using Base.Test
import Iterators: chain
import IJulia

# Test non-iterator interface:

let
    machine = StateMachine(:going_up, :final,
       [(:going_up, x -> x >= 10, :going_down),
        (:going_down, x -> x <= 1, :final)])

    behaviors = Dict(:going_up => x -> x + 1,
                     :going_down => x -> x - 1,
                     :final => x -> x)

    values = []
    x = 1
    state = initial(machine)
    while state != final(machine)
        push!(values, x)
        state = nextstate(machine, state, x)
        x = behaviors[state](x)
    end

    @test all(values .== [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])

end

# Test iterator interface:

let
    machine = StateMachine(:going_up, :final,
       [(:going_up, x -> x >= 5, :going_down),
        (:going_down, x -> x <= 1, :final)])

    behaviors = Dict(:going_up => x -> x + 1,
                     :going_down => x -> x - 1,
                     :final => x -> x)

    values = []
    x = 1
    for state in StateMachineIterator(machine, () -> x)
        push!(values, x)
        x = behaviors[state](x)
    end

    @test all(values .== [1, 2, 3, 4, 5, 4, 3, 2, 1])
end

let
    x_machine = StateMachine(:going_up, :final,
       [(:going_up, x -> x >= 10, :going_down),
        (:going_down, x -> x <= 1, :final)])

    y_machine = StateMachine(:going_up, :final,
       [(:going_up, y -> y >= 3, :going_down),
        (:going_down, y -> y <= 1, :going_up)])

    behaviors = Dict(:going_up => a -> a + 1,
                     :going_down => a -> a - 1,
                     :final => a -> a)

    values = []
    x = 1
    y = 1
    for (x_state, y_state) in zip(StateMachineIterator(x_machine, () -> x),
                                  StateMachineIterator(y_machine, () -> y))
        push!(values, (x, y))
        x = behaviors[x_state](x)
        y = behaviors[y_state](y)
    end

    @test all(values .== [
        (1, 1),
        (2, 2),
        (3, 3),
        (4, 2),
        (5, 1),
        (6, 2),
        (7, 3),
        (8, 2),
        (9, 1),
        (10, 2),
        (9, 3),
        (8, 2),
        (7, 1),
        (6, 2),
        (5, 3),
        (4, 2),
        (3, 1),
        (2, 2),
        (1, 3)])
end

let
    machine = StateMachine(:going_up, :final,
       [(:going_up, x -> x >= 5, :going_down),
        (:going_down, x -> x <= 1, :final)])

    behaviors = Dict(:going_up => x -> x + 1,
                     :going_down => x -> x - 1,
                     :final => x -> x)

    values = []

    x = 1
    for state in chain(repeated(StateMachineIterator(machine, () -> x), 2)...)
        push!(values, x)
        x = behaviors[state](x)
    end
    @test all(values .== [1, 2, 3, 4, 5, 4, 3, 2, 1, 1, 2, 3, 4, 5, 4, 3, 2, 1])
end

jupyter = IJulia.jupyter
notebook = "../examples/state_machines.ipynb"
run(`$jupyter nbconvert --to notebook --execute $notebook --output $notebook`)
