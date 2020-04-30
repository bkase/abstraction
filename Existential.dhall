let Prelude = https://prelude.dhall-lang.org/v15.0.0/package.dhall

-- An existential type as defined in the "Existential Types as Rank2 Universal
-- Types" section of https://bkase.dev/posts/data-abstraction
let Exists: (Type -> Type) -> Type =
    \(tau : Type -> Type) ->
      forall(u : Type) -> ( forall(t : Type) -> (tau t) -> u ) -> u

in

\(tau : Type -> Type) ->
    let Client : Type -> Type =
        \(u: Type) -> forall(t : Type) -> tau t -> u
    in
    { Impl = Exists tau
    , Client = Client
    }
