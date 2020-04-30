let Prelude = https://prelude.dhall-lang.org/v15.0.0/package.dhall sha256:6b90326dc39ab738d7ed87b970ba675c496bed0194071b332840a87261649dcd

let Existential = ./Existential.dhall

-- We choose our StackType to be an (infinite) stack
let StackType : Type -> Type =
  \(t : Type) -> {
    create : Natural -> t,
    push : Natural -> t -> t,
    pop : t -> { x: Natural, rest: t }
  }

let e = Existential StackType
let Impl = e.Impl
let Client = e.Client

-- The concrete stack is a default value if it's empty and a list of the rest
let Stack = { default: Natural, xs : List Natural }

-- The implementation relies on the concrete stack
let StackImpl : Impl = \(u : Type) ->
  \(x: Client u) ->
    x
      Stack
      { create = \(i : Natural) -> { default = i, xs = [] : List Natural }
      , push = \(i : Natural) -> \(t : Stack) -> t // { xs = [ i ] # t.xs }
      , pop = \(t : Stack) -> {
          x =
            Prelude.Optional.fold Natural
              (Prelude.List.head Natural t.xs)
              Natural
              (\(x: Natural) -> x)
              t.default,
          rest = { default = t.default, xs = Prelude.List.drop 1 Natural t.xs }
        }
      }
in
{ Type = StackType, Impl = StackImpl, Client = Client }

