#pragma semicolon 1

public void GetClassString(int index, char[] buffer, int maxlen) {
     switch(index) {
          case 1: strcopy(buffer, maxlen, "SCOUT");
          case 2: strcopy(buffer, maxlen, "SNIPER");
          case 3: strcopy(buffer, maxlen, "SOLDIER");
          case 4: strcopy(buffer, maxlen, "DEMOMAN");
          case 5: strcopy(buffer, maxlen, "MEDIC");
          case 6: strcopy(buffer, maxlen, "HEAVY");
          case 7: strcopy(buffer, maxlen, "PYRO");
          case 8: strcopy(buffer, maxlen, "SPY");
          case 9: strcopy(buffer, maxlen, "ENGINEER");
          default: strcopy(buffer, maxlen, "UNKNOWN");
     }
}