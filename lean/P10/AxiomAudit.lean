import P10.Fixtures.FourWorld

-- These commands are part of the build log. Every declaration must report
-- that it does not depend on axioms. The acceptance script also rejects proof
-- placeholders and treats compiler warnings as errors.

#print axioms P10.underdetermined_of_witnesses
#print axioms P10.worlds_distinct_of_values_differ
#print axioms P10.encodings_distinct_of_values_differ
#print axioms P10.not_underdetermined_of_constant_eval
#print axioms P10.WitnessCertificate.sound
#print axioms P10.Fixtures.FourWorld.underdetermined
#print axioms P10.Fixtures.FourWorld.rejects_incompatible_world
#print axioms P10.Fixtures.FourWorld.rejects_duplicate_world
#print axioms P10.Fixtures.FourWorld.determining_compatible_eval_false
#print axioms P10.Fixtures.FourWorld.determining_evidence_not_underdetermined
#print axioms P10.Fixtures.FourWorld.no_certificate_for_determining_evidence
#print axioms P10.Fixtures.FourWorld.canonical_witnesses_distinct
