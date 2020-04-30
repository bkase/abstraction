let Stack = ./Stack.dhall

let stackClient : Stack.Client Natural = \(t : Type) -> \(stack : Stack.Type t) ->
  let s = stack.create 10
  let s = stack.push 1 s
  let s = stack.push 2 s
  let y = stack.pop s
  in
  y.x

in
Stack.Impl Natural stackClient
