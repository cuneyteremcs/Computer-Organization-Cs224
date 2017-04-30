

/*
Attention!
Configuration  for push-button project :

Connect portA to LEDs
Jumpers of portA are : 5V, pull up ( both of the to the left side )

Connect portE to push-buttons
Jumpers of portE are : 3V3, pull up ( top one to right, other to left )

*/



void Wait() {
 Delay_ms(1000);
}

void main() {

 int numbers = 0Xfe;
 
 AD1PCFG = 0xFFFF;

 DDPCON.JTAGEN = 0; // disable JTAG

 TRISA = 0x0000;  //portA is output to turn on LEDs.
 TRISE = 0XFFFF;  //portE is inputs to read push-buttons.

 LATA = 0Xffff;
 LATE = 0X0000;

 // single LED blink
 LATA=0xffff;
 Wait();
 LATA=0x0000;
 Wait();

 while(1)
 {
 
  if(  portE.RD4 == 1 ){
       numbers = numbers * 2;
       numbers = numbers % 255;
  }
  else{
       if(numbers % 2 == 1){
                  numbers += 256;
       }
       numbers = numbers / 2;
  }
   portA = numbers;
   Wait();
  
 }//while

}//main