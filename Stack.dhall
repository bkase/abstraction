-- An infinite stack interface and implementation

let Prelude =
      https://prelude.dhall-lang.org/v15.0.0/package.dhall sha256:6b90326dc39ab738d7ed87b970ba675c496bed0194071b332840a87261649dcd

let Existential = ./Existential.dhall

let Interface
    : Type → Type
    =   λ(t : Type)
      → { create : Natural → t
        , push : Natural → t → t
        , pop : t → { x : Natural, rest : t }
        }

let e = Existential Interface

let Impl = e.Impl

let Client = e.Client

let Stack = { default : Natural, xs : List Natural }

let StackImpl
    : Impl
    =   λ(u : Type)
      → λ(x : Client u)
      → x
          Stack
          { create = λ(i : Natural) → { default = i, xs = [] : List Natural }
          , push = λ(i : Natural) → λ(t : Stack) → t ⫽ { xs = [ i ] # t.xs }
          , pop =
                λ(t : Stack)
              → { x =
                    Prelude.Optional.fold
                      Natural
                      (Prelude.List.head Natural t.xs)
                      Natural
                      (λ(x : Natural) → x)
                      t.default
                , rest =
                    { default = t.default
                    , xs = Prelude.List.drop 1 Natural t.xs
                    }
                }
          }

in    { Interface = Interface, Impl = StackImpl, Client = Client }
    : { Interface : Type → Type, Impl : Impl, Client : Type → Type }
