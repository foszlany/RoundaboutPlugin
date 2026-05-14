int RollEffectCount(){
    int r = GetRandomInt(1, 10000);

    if (r <= 1)      return 1;
    else if (r <= 9900) return 2;
    else if (r <= 9950) return 3;
    else if (r <= 9990) return 4;
    else                return 5;
}
