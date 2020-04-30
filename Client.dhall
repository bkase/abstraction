let Stack = ./Stack.dhall

-- A client can use the stack, but doesn't know what `t` is!
let stackClient : Stack.Client Natural = \(t : Type) -> \(stack : Stack.Type t) ->
  let s = stack.create 10
  let s = stack.push 1 s
  let s = stack.push 2 s
  let y = stack.pop s
  in
  y.x

in
-- The Stack.Impl is the engine for executing the client on our implementation
Stack.Impl Natural stackClient
