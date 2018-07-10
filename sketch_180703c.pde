float[] statBase = {10, 0, 0, 0,   0, 0, 0, 0, 0, 0,   10, 10, 1.25, 0.05,   100, 0, 0, 0.1,   0.5, 0, 0, 1.0};
String[] statName = {"STR", "INT", "END", "DEX",   "LCK", "SEN", "LIB", "COR", "LUS", "FAT",   "ATK", "MAG", "CRD", "CRC",   "HLP", "DEF", "RES", "DDG",   "RUN", "DEC", "PGN", "EGN" };
float[] stat;
int statMax = 100;
int statMin = 0;

boolean waitingForPlayer = true;

Monster wildebeast = new Monster("Wildebeast", 5, 25);
Monster[] enemyList = {wildebeast};
Monster currentEnemy;



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
  //recalculateStats();
  //lusTick();
  //bindStats();
  //printStats();
  if (!waitingForPlayer) {
    enemyTurn();
    printStats();
  }
}

void initializeStats() {
  stat = new float[22];
  for (int i = 0; i < stat.length; i++) {
    if (statBase[i] != 0) {
      stat[i] = statBase[i];
    } else {
      stat[i] = 0;
    }
  }
}

void recalculateStats() {
  for (int i = 0; i < stat.length; i++) {
    switch (i) {
      //STR
      case 0 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //INT
      case 1 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //END
      case 2 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //DEX
      case 3 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //LCK
      case 4 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //SEN
      case 5 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //LIB
      case 6 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //COR
      case 7 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //LUS
      case 8 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //FAT
      case 9 :
        //stat[i] = statBase[i] + stat[i];
        break;
      //ATK
      case 10 :
        stat[i] = statBase[i] + stat[0];
        break;
      //MAG
      case 11 :
        stat[i] = statBase[i] + (stat[1] * 2);
        break;
      //CRD
      case 12 :
        stat[i] = statBase[i] + (stat[0] * 0.01) + (stat[1] * 0.01);
        break;
      //CRC
      case 13 :
        stat[i] = statBase[i] + (stat[4] * 0.5 * 0.01);
        break;
      //HLP
      case 14 :
        stat[i] = statBase[i] + (stat[2] * 5);
        break;
      //DEF
      case 15 :
        stat[i] = statBase[i] + (stat[2] * 0.5 * 0.01) + (stat[0] * 0.25 * 0.01);
        break;
      //RES
      case 16 :
        stat[i] = statBase[i] + (stat[2] * 0.5 * 0.01) + (stat[1] * 0.25 * 0.01);
        break;
      //DDG
      case 17 :
        stat[i] = statBase[i] + (stat[3] * 0.4 * 0.01);
        break;
      //RUN
      case 18 :
        stat[i] = statBase[i] + (stat[3] * 0.5 * 0.01);
        break;
      //DEC
      case 19 :
        stat[i] = statBase[i] + (stat[1] * 0.5);
        break;
      //PGN
      case 20 :
        stat[i] = statBase[i] + ((stat[6] + stat[7]) * 0.25);
        break;
      //EGN
      case 21 :
        stat[i] = statBase[i] + ((stat[5] * 0.5) - stat[2]) * 0.01;
        break;
      default :
        //stat[i] = statBase[i] + stat[i];
        break;
    }
  }
}

void bindStats() {
  for (int i = 0; i < stat.length; i++) {
    if (i < 10) {
      if (stat[i] < statMin) {
        stat[i] = statMin;
      } else if (stat[i] > statMax) {
        stat[i] = statMax;
      } else {}
    } else {}
  }
}

void printStats() {
  for (int i = 0; i < stat.length; i++) {
    print("[" + statName[i] + "] : ");
    if (i < 10) {
      print(floor(stat[i]));
    } else {
      print(stat[i]);
    }
    if (i < 3 || (i > 3 && i < 7)) {
      print(" || ");
    } else {
    println();
    }
  }
  println(currentEnemy);
  println();
  println();
}

void increaseStat(int statNum) {
  stat[statNum] += 25;
}

void decreaseStat(int statNum) {
  stat[statNum] -= 25;
}

void keyReleased() {
  if (waitingForPlayer) {
    switch (key) {
      case 'a':
      playerAttack();
      break;
      default:
      break;
    }
  }
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

void lusTick() {
  stat[8] += stat[20];
}

void setEnemy(int enemyID) {
  currentEnemy = enemyList[enemyID];
}

void playerAttack() {
  currentEnemy.takeDamage(stat[10]);
  waitingForPlayer = false;
}

void enemyTurn() {
  stat[14] -= currentEnemy.getDamage();
  waitingForPlayer = true;
}

class Monster() {
  public String name;
  public int damage;
  public int health;
  Monster(String enemyName, int enemyDamage, int enemyHealth) {
    name = enemyName;
    damage = enemyDamage;
    health = enemyHealth;
  }
  public int getDamage() {
    return this.damage;
  }
  public void takeDamage(int damageTaken) {
    this.health -= damageTaken;
  }
}
