# P10 Lean Axiom Policy

The reference checker accepts only declarations that `#print axioms` reports
as depending on no axioms. Proof placeholders and evaluator shortcuts
`sorry`, `admit`, `sorryAx`, `native_decide`, and `Lean.ofReduceBool` are
forbidden in the audited Lean sources and negative tests.
