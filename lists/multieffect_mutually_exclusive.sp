/*
* These effects may only be rolled at most once for a multieffect round.
* This cannot be bypassed with !roundabout_force either.
* This is to prevent unwanted effects, most notably not being able to pick a class.
*/
void InitializeMutuallyExclusiveMultieffects() {
    MULTIEFFECT_MUTUALLY_EXCLUSIVE = new ArrayList();

    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_ROLEMODEL);
    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_CLASSWARS);
    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_ASSASSINS);
    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_INCONTROL);
    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_MOSQUITO);
    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_HELL);
    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_NOSCRUBS);
    MULTIEFFECT_MUTUALLY_EXCLUSIVE.Push(EFFECT_RESTRICTION);
}
