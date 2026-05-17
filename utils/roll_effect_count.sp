int RollEffectCount() {
    float chance = g_CVAR_MultieffectBaseChance.FloatValue;

    for(int i = 2; i <= g_CVAR_MultieffectMaxCount.IntValue; i++) {
        if(GetRandomFloat(0.0, 1.0) <= chance) {
            return i;
        }

        chance /= g_CVAR_MultieffectRarityMultiplier.FloatValue;
    }

    return 1;
}
