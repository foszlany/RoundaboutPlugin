enum struct BidirectionalMap {
    StringMap KeyToValueMap;
    StringMap ValueToKeyMap;

    void Init() {
        this.KeyToValueMap = new StringMap();
        this.ValueToKeyMap = new StringMap();
    }

    void SetPair(const char[] key, any value) {
        char buf[64];
        Format(buf, sizeof(buf), "%d", value);

        this.KeyToValueMap.SetString(key, buf);
        this.ValueToKeyMap.SetString(buf, key);
    }

    bool GetValue(const char[] key, char[] out, int maxlen) {
        return this.KeyToValueMap.GetString(key, out, maxlen);
    }

    bool GetIntValue(const char[] key, int &out) {
        char buffer[32];

        if(!this.KeyToValueMap.GetString(key, buffer, sizeof(buffer))) {
            return false;
        }

        out = StringToInt(buffer);
        return true;
    }

    bool GetKey(const char[] value, char[] out, int maxlen) {
        return this.ValueToKeyMap.GetString(value, out, maxlen);
    }

    bool GetKeyFromInt(int value, char[] out, int maxlen) {
        char buffer[32];
        IntToString(value, buffer, sizeof(buffer));

        return this.ValueToKeyMap.GetString(buffer, out, maxlen);
    }

    bool ContainsKey(const char[] key) {
        return this.KeyToValueMap.ContainsKey(key);
    }

    bool ContainsValue(const char[] value) {
        return this.ValueToKeyMap.ContainsKey(value);
    }

    StringMapSnapshot GetKeySnapshot() {
        return this.KeyToValueMap.Snapshot();
    }

    StringMapSnapshot GetValueSnapshot() {
        return this.ValueToKeyMap.Snapshot();
    }
}