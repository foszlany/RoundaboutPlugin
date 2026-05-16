/*
* These effects will never be rolled for a multieffect round.
* This cannot be bypassed with !roundabout_force either.
* This is to prevent unwanted effects.
*/
void InitializeExcludedMultieffects() {
     MULTIEFFECT_EXCLUDED = new ArrayList();
     
     MULTIEFFECT_EXCLUDED.Push(EFFECT_PURE);    // No reason to include this
     MULTIEFFECT_EXCLUDED.Push(EFFECT_MVM);     // Too fragile
}