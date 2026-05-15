/*
* These effects may only be rolled at most once for a multieffect round, not even when forced.
* This is to prevent unwanted effects, most notably not being able to pick a class.
*/
void InitializeMutuallyExclusiveMultieffects() {
     MULTIEFFECT_MUTUALLY_EXCLUSIVE = new ArrayList();
     MULTIEFFECT_MUTUALLY_EXCLUSIVE.PushArray({
          EFFECT_ROLEMODEL,
          EFFECT_CLASSWARS,
          EFFECT_ASSASSINS,
          EFFECT_INCONTROL,
          EFFECT_MOSQUITO,
          EFFECT_HELL,
          EFFECT_NOSCRUBS,
          EFFECT_RESTRICTION
     });
}