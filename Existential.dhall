-- Existential type machinery as defined in the "Existential Types as Rank2
-- Universal Types" section of https://bkase.dev/posts/data-abstraction

let Prelude = https://prelude.dhall-lang.org/v15.0.0/package.dhall

let Exists
    : (Type → Type) → Type
    = λ(tau : Type → Type) → ∀(u : Type) → (∀(t : Type) → tau t → u) → u

in    (   λ(tau : Type → Type)
        → let Client
              : Type → Type
              = λ(u : Type) → ∀(t : Type) → tau t → u

          in  { Impl = Exists tau, Client = Client }
      )
    : (Type → Type) → { Impl : Type, Client : Type → Type }
