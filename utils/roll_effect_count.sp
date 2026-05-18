int RollEffectCount() {
    float baseChance = g_CVAR_MultieffectBaseChance.FloatValue;
    float multiplier = g_CVAR_MultieffectRarityMultiplier.FloatValue;
    
    for(int i = g_CVAR_MultieffectMaxCount.IntValue; i >= 2; i--) {
        float chance = baseChance;
        for(int j = 2; j < i; j++) {
            chance /= multiplier;
        }
        
        if(GetRandomFloat(0.0, 1.0) <= chance) {
            return i;
        }
    }
    
    return 1;
}