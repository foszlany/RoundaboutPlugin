#pragma semicolon 1

#define E6_BASE_HEAL 0.5
#define E6_RARE_CHANCE 5
#define E6_RARE_HEAL 1.0

public void Event_RoundStart_6_Vampire(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_VAMPIRE) || GetRandomInt(0, 100) <= E6_RARE_CHANCE) {
          g_Effect6_IsSpecialRound = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Damage-to-heal ratio is significantly stronger.");
     }
     else {
          g_Effect6_IsSpecialRound = false;
     }
}


public void Event_PlayerHit_6_Vampire(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     int victim = GetClientOfUserId(event.GetInt("userid"));

     if(attacker != 0 && attacker != victim) {
          int attackerHealth = GetClientHealth(attacker);
          int attackerMaxHealth = GetEntData(attacker, FindDataMapInfo(attacker, "m_iMaxHealth"), 4);

          if(attackerHealth > attackerMaxHealth) {
               return;
          }

          int damage = event.GetInt("damageamount");

          int healAmountRaw = RoundToFloor(damage * (g_Effect6_IsSpecialRound ? E6_RARE_HEAL : E6_BASE_HEAL));
          int healAmount = healAmountRaw + attackerHealth <= attackerMaxHealth ? attackerHealth + healAmountRaw : attackerMaxHealth;

          if(IsClientInGame(attacker) && IsPlayerAlive(attacker)) {
               SetEntityHealth(attacker, healAmount);
          }
     }
}