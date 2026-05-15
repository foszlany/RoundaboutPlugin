/*
* These effects will never be rolled for a multieffect round, not even when forced.
* This is to prevent unwanted effects.
*/
void InitializeExcludedMultieffects() {
     MULTIEFFECT_EXCLUDED = new ArrayList();
     MULTIEFFECT_EXCLUDED.PushArray({
          EFFECT_PURE,    // No reason to include this
          EFFECT_MVM      // Too fragile
     });
}