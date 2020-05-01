-- A client of the infinite stack interface. The Stack.Impl is the engine for
-- executing the client on our implementation

let Stack = ./Stack.dhall

let stackClient
    : Stack.Client Natural
    =   λ(t : Type)
      → λ(stack : Stack.Interface t)
      → let s = stack.create 10

        let s = stack.push 1 s

        let s = stack.push 2 s

        let y = stack.pop s

        in  y.x

in  Stack.Impl Natural stackClient
