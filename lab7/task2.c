

unsigned int n = 1;
int acc = 0;
int value =0;
int temp = 0;

void Wait() {
  Delay_ms(1000);
}

void convert(int n){
     if(n==0){
        LATD = 0x3F;
     }
      if(n==1){
        LATD = 0x06;
     }
     if(n==2){
        LATD = 0x5B;
     }
     if(n==3){
        LATD = 0x4F;
     }
     if(n==4){
        LATD = 0x66;
     }
     if(n==5){
        LATD = 0x6D;
     }
     if(n==6){
        LATD = 0x7D;
     }
     if(n==7){
        LATD = 0x07;
     }
     if(n==8){
        LATD = 0x7F;
     }
     if(n==9){
        LATD = 0x6F;
     }
     if(n==10){
        LATD = 0x77;
     }
     if(n==11){
        LATD = 0x7C;
     }
     if(n==12){
        LATD = 0x58;
     }
     if(n==13){
        LATD = 0x5E;
     }
     if(n==14){
        LATD = 0x79;
     }
     if(n==15){
        LATD = 0x71;
     }
}

void main() {
     int j = 0;
     int num = 0;
     int count = 0;
     int num1 = 0;
     AD1PCFG = 0xFFFF;       // configure AN pins as digital

     DDPCON.JTAGEN = 0;      //jtag disable

     TRISA = 0x0000;
     TRISB = 0xFFFF;
     TRISE = 0xFFFF;
     TRISD = 0x0000;

     LATB  = 0Xffff;         // switches
     LATE  = 0Xffff;         // buttons
     LATD =  0Xffff;         // 7-seg
     LATA =  0Xffff;         // anots
      /*
     MODE = PORTEbits.RE0;
     SHOW  = PORTEbits.RE1;
     CLR  = PORTEbits.RE2;
     ADD = PORTEbits.RE3; */
     while(1){
     if(PORTEbits.RE0 == 1){
       while(PORTEbits.RE0 == 1)
       {
       //n  = 0;
        while(n<=4 && PORTEbits.RE0 == 1){
           while(j<200 && PORTEbits.RE0 == 1){
             LATD = 0x76;
             LATA = 0X1;
             Delay_ms(1);

             LATD = 0x79;
             LATA = 0x2;
             Delay_ms(1);

             LATD = 0x38;
             LATA = 0x4;
             Delay_ms(1);

             LATD = 0x3F;
             LATA = 0x8;
             Delay_ms(1);
             j++;
          }
          j = 0;
          LATA = 0x00;
          Wait();
          n++;
          }
          while(PORTEbits.RE0 == 1){
            while(num<=12 && PORTEbits.RE0 == 1){
              while(count<200 && PORTEbits.RE0 == 1){
                convert(num);
                LATA = 0x1;
                Delay_ms(1);

                convert(num+1);
                LATA = 0x2;
                Delay_ms(1);

                convert(num+2);
                LATA = 0x4;
                Delay_ms(1);

                convert(num+3);
                LATA = 0x8;
                Delay_ms(1);
                count++;
              }
              num++;
              count = 0;
            }
            num = 0;
            }
          }
       }
       while(PORTEbits.RE0 == 0){
          while(PORTEbits.RE3 ==1 && PORTEbits.RE2 == 1 && PORTEbits.RE1 ==1 && PORTEbits.RE0 == 0){
            num1 = 1 * !portBbits.RB4 + 2 * !portBbits.RB5 + 4 * !portBbits.RB6 + 8 * !portBbits.RB7 + 16 * !portBbits.RB12 + 32 * !portBbits.RB13 + 64 * !portBbits.RB14 + 128 * !portBbits.RB15;
              j = 0;
              while(j<200 && PORTEbits.RE0 == 0 && PORTEbits.RE1 ==1){
                convert(num1%16);
                LATA = 0x8;
                Delay_ms(1);

                convert((num1/16)%16);
                LATA = 0x4;
                Delay_ms(1);

                convert((num1/256)%16);
                LATA = 0x2;
                Delay_ms(1);

                convert((num1/4096)%16);
                LATA = 0x1;
                Delay_ms(1);
                j++;
              }
          }
          while(PORTEbits.RE3 ==1 && PORTEbits.RE2 == 1 && PORTEbits.RE1 ==0 && PORTEbits.RE0 == 0){
             j = 0;
              while(j<200 && PORTEbits.RE0 == 0 && PORTEbits.RE1==0){
                convert(acc%16);
                LATA = 0x8;
                Delay_ms(1);

                convert((acc/16)%16);
                LATA = 0x4;
                Delay_ms(1);

                convert((acc/256)%16);
                LATA = 0x2;
                Delay_ms(1);

                convert((acc/4096)%16);
                LATA = 0x1;
                Delay_ms(1);
                j++;
              }
          }
          while(PORTEbits.RE3 ==1 && PORTEbits.RE2 == 0 && PORTEbits.RE1 ==1 && PORTEbits.RE0 == 0){
             acc = 0;
          }
          if(PORTEbits.RE3 ==0 && PORTEbits.RE2 == 1 && PORTEbits.RE1 ==1 && PORTEbits.RE0 == 0){
             temp = ( 1 * !portBbits.RB0 + 2 * !portBbits.RB1 + 4 * !portBbits.RB2 + 8 * !portBbits.RB3 + 16 * !portBbits.RB4 + 32 * !portBbits.RB5 + 64 * !portBbits.RB6 + 128 * !portBbits.RB7);
             acc = acc + temp;
             Wait();
          }
       }
   }
}