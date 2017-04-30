

void ToneC() {
  Sound_Play(261 , 200);
}

void ToneG() {
  Sound_Play(392 , 200);
}

void ToneA() {
  Sound_Play(440 , 200);
}

void ToneF() {
  Sound_Play(349, 200);
}

void ToneE() {
  Sound_Play(329 , 200);
}

void ToneD() {
  Sound_Play(294 , 200);
}

void ToneX1() {
  Sound_Play(660 , 100);
}
void ToneX2() {
  Sound_Play(510 , 100);
}
void ToneX3() {
  Sound_Play(770 , 100);
}
void ToneX4() {
  Sound_Play(380 , 100);
}
void ToneX5() {
  Sound_Play(320 , 100);
}
void ToneX6() {
  Sound_Play(440 , 100);
}
void ToneX7() {
  Sound_Play(480 , 80);
}
void ToneX8() {
  Sound_Play(450 , 100);
}
void ToneX9() {
  Sound_Play(430 , 100);
}
void ToneX10() {
  Sound_Play(380 , 100);
}
void ToneX11() {
  Sound_Play(660 , 80);
}
void ToneX12() {
  Sound_Play(760 , 50);
}
void ToneX13() {
  Sound_Play(860 , 100);
}
void ToneX14() {
  Sound_Play(700 , 80);
}
void ToneX15() {
  Sound_Play(520 , 80);
}
void ToneX16() {
  Sound_Play(580 , 80);
}




void Melody() {           // Plays the melody "Yellow house"


        ToneX1();Delay_ms(150);
     ToneX1(); Delay_ms(300);
      ToneX1(); Delay_ms(300);
       ToneX2(); Delay_ms(100);
       ToneX1(); Delay_ms(300);
       ToneX3();Delay_ms(350);
       ToneX4(); Delay_ms(500);

    ToneX2(); Delay_ms(450);
    ToneX4(); Delay_ms(400);
    ToneX5(); Delay_ms(500);
    ToneX6(); Delay_ms(300);
    ToneX7(); Delay_ms(300);
    ToneX8(); Delay_ms(150);
    ToneX9(); Delay_ms(300);
    ToneX10(); Delay_ms(300);
    ToneX11(); Delay_ms(200);
    ToneX12(); Delay_ms(150);
    ToneX13(); Delay_ms(300);
    ToneX14(); Delay_ms(150);
    ToneX12(); Delay_ms(350);
    ToneX11(); Delay_ms(300);
    ToneX15(); Delay_ms(150);
    ToneX16(); Delay_ms(100);



/*
  ToneE(); ToneE(); ToneE(); ToneE();
  ToneF(); ToneF(); ToneG(); ToneG();
  ToneF(); ToneF(); ToneE();
  ToneE(); ToneD(); ToneD();
  ToneC(); ToneC(); ToneC(); ToneC();
  ToneD(); ToneD(); ToneE(); ToneE();
  ToneE(); ToneE(); ToneE();
  ToneD(); ToneD(); ToneD();
  ToneD(); ToneD();
  */
}

void Melody2() {
  unsigned short i;
  for (i = 9; i > 0; i--) {
    ToneA(); ToneC(); ToneE();
  }
}

void main() {
  AD1PCFG = 0xFFFF;                 // Configure AN pins as digital
  TRISE = 0xFFFF;                    // Configure RB7..RB3 as input
  LATE = 0;

  Sound_Init(&PORTD, 0);
  Sound_Play(0, 1000);            // Play sound at 880Hz for 1 second

  while(1){
    while(PORTEbits.RE4 == 0){
       if(PORTEbits.RE5 == 0){
          Melody();
       }
       if(PORTEbits.RE5 == 1 && PORTEbits.RE6 == 1 && PORTEbits.RE7 == 1){
          ToneA();
       }
       if(PORTEbits.RE5 == 1 && PORTEbits.RE6 == 1 && PORTEbits.RE7 == 0){
          ToneF();
       }
       if(PORTEbits.RE5 == 1 && PORTEbits.RE6 == 0 && PORTEbits.RE7 == 1){
          ToneG();
       }
       if(PORTEbits.RE5 == 1 && PORTEbits.RE6 == 0 && PORTEbits.RE7 == 0){
          ToneC();
       }
    }
  }
}