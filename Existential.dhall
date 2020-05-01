-- Existential type machinery as defined in the "Existential Types as Rank2
-- Universal Types" section of https://bkase.dev/posts/data-abstraction


  (   λ(tau : Type → Type)
    → let Client
          : Type → Type
          = λ(u : Type) → ∀(t : Type) → tau t → u

      let ExistsTau
          : Type
          = ∀(u : Type) → Client u → u

      in  { Impl = ExistsTau, Client = Client }
  )
: (Type → Type) → { Impl : Type, Client : Type → Type }
