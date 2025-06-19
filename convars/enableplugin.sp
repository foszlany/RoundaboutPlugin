public void ConvarChange_EnablePlugin(ConVar convar, const char[] oldValue, const char[] newValue) {
     bool isEnabled = convar.BoolValue;

     if(isEnabled) {
          EnablePluginFeatures();
     }
     else {
          DisablePluginFeatures();
     }
}