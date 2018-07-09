public float[] statsBase = {0, 0, 0, 0,   0, 0, 0, 0, 0, 0,   10, 10, 1.25, 0.05,   100, 0, 0, 0.1,   0.5, 0, 0, 1.0};
public String[] statsName = {"STR", "INT", "END", "DEX",   "LCK", "SEN", "LIB", "COR", "LUS", "FAT",   "ATK", "MAG", "CRD", "CRC",   "HLP", "DEF", "RES", "DDG",   "RUN", "DEC", "PGN", "EGN" };
public float[] stats;
public int statsMax = 100;
public int statsMin = 0;

/*
[STR] : +ATK +DEF +CRD
[INT] : +MAG +RES +CRD
[END] : +HLP +DEF +RES +External LUS gain resist
[DEX] : +DDG +RUN
[LCK] : +CRC
[SEN] : -External LUS gain resist
[LIB] : +Passive LUS gain
[COR] : +Passive LUS gain

[ATK] : BASE + STR (Max: 100 Physical Damage from STR)
[MAG] : BASE + INT*2 (Max: 200 Magical Damage from INT)
[CRD] : 25% + STR(%) + INT(%) (Max: 225% Additional Damage)
[CRC] : 5% + LCK/2(%) (Max: 55%)
[HLP] : BASE + END*5 (Max: 500 HLP from END)
[DEF] : END/2(%) + STR/4(%) (Max: 75% Physical Damage Reduction)
[RES] : END/2(%) + INT/4(%) (Max: 75% Magical Damage Reduction)
[DDG] : 10% + DEX*0.4(%) (Max: 50% DDG)
[RUN] : 50% + DEX/2(%) (Max: 100% RUN)
[FAT] : (Max: 100 FAT)
[Decay/Time] : INT/4 (Max: 25 Decay/Time)
[LUS] : (Max: 100 LUS)
[Passive Gain/Time] : LIB/4 + COR/4 (Max: 50 LUS/Time)
[External Gain Modifier] : 100% + SEN/2(%) - END(%) (Min: 0%; Max: 150%)
*/

void setup() {
  frameRate(1);
  initializeStats();
  recalculateStats();
  bindStats();
  printStats();
}

void draw() {
  recalculateStats();
  lusTick();
  bindStats();
  printStats();
}

public void initializeStats() {
  stats = new float[22];
  for (int i = 0; i < stats.length; i++) {
    if (statsBase[i] != 0) {
      stats[i] = statsBase[i];
    } else {
      stats[i] = 0;
    }
  }
}

public void recalculateStats() {
  for (int i = 0; i < stats.length; i++) {
    switch (i) {
      //STR
      case 0 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //INT
      case 1 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //END
      case 2 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //DEX
      case 3 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //LCK
      case 4 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //SEN
      case 5 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //LIB
      case 6 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //COR
      case 7 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //LUS
      case 8 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //FAT
      case 9 :
        //stats[i] = statsBase[i] + stats[i];
        break;
      //ATK
      case 10 :
        stats[i] = statsBase[i] + stats[0];
        break;
      //MAG
      case 11 :
        stats[i] = statsBase[i] + (stats[1] * 2);
        break;
      //CRD
      case 12 :
        stats[i] = statsBase[i] + (stats[0] * 0.01) + (stats[1] * 0.01);
        break;
      //CRC
      case 13 :
        stats[i] = statsBase[i] + (stats[4] * 0.5 * 0.01);
        break;
      //HLP
      case 14 :
        stats[i] = statsBase[i] + (stats[2] * 5);
        break;
      //DEF
      case 15 :
        stats[i] = statsBase[i] + (stats[2] * 0.5 * 0.01) + (stats[0] * 0.25 * 0.01);
        break;
      //RES
      case 16 :
        stats[i] = statsBase[i] + (stats[2] * 0.5 * 0.01) + (stats[1] * 0.25 * 0.01);
        break;
      //DDG
      case 17 :
        stats[i] = statsBase[i] + (stats[3] * 0.4 * 0.01);
        break;
      //RUN
      case 18 :
        stats[i] = statsBase[i] + (stats[3] * 0.5 * 0.01);
        break;
      //DEC
      case 19 :
        stats[i] = statsBase[i] + (stats[1] * 0.5);
        break;
      //PGN
      case 20 :
        stats[i] = statsBase[i] + ((stats[6] + stats[7]) * 0.25);
        break;
      //EGN
      case 21 :
        stats[i] = statsBase[i] + ((stats[5] * 0.5) - stats[2]) * 0.01;
        break;
      default :
        //stats[i] = statsBase[i] + stats[i];
        break;
    }
  }
}

public void bindStats() {
  for (int i = 0; i < stats.length; i++) {
    if (i < 10) {
      if (stats[i] < statsMin) {
        stats[i] = statsMin;
      } else if (stats[i] > statsMax) {
        stats[i] = statsMax;
      } else {}
    } else {}
  }
}

public void printStats() {
  for (int i = 0; i < stats.length; i++) {
    print("[" + statsName[i] + "] : ");
    if (i < 10) {
      print(floor(stats[i]));
    } else {
      print(stats[i]);
    }
    if (i < 3 || (i > 3 && i < 7)) {
      print(" || ");
    } else {
    println();
    }
  }
  println();
  println();
}

public void increaseStat(int statNum) {
  stats[statNum] += 25;
}

public void decreaseStat(int statNum) {
  stats[statNum] -= 25;
}

void keyReleased() {
  switch (key) {
    case '1':
      increaseStat(0);
      break;
    case '2':
      increaseStat(1);
      break;
    case '3':
      increaseStat(2);
      break;
    case '4':
      increaseStat(3);
      break;
    case '5':
      increaseStat(4);
      break;
    case '6':
      increaseStat(5);
      break;
    case '7':
      increaseStat(6);
      break;
    case '8':
      increaseStat(7);
      break;
    case '9':
      decreaseStat(8);
        break;
    default:
    break;
  }
}

public void lusTick() {
  stats[8] += stats[20];
}
