#pragma semicolon 1

public void Event_RoundStart_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     PrintCenterTextAll("Weaklings");
     ShowHintToAllClients("Weaklings\n\nAll damage is reduced to 33 percent.");
}

public void Event_PlayerHit_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     float floatDamage = float(event.GetInt("damageamount"));
     floatDamage *= 0.33333333333;
     
     int intDamage = floatDamage <= 1 ? 1 : RoundToNearest(floatDamage);
     event.SetInt("damageamount", intDamage);
}