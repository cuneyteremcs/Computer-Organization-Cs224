unsigned int leds;
void Wait() {
Delay_ms(1000);
}
void main() {
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
  leds = 0x0077;
  
  while(1)
  {
    //rotate left or right accourding to DIR input. Mask first 8 bits
    if(RE5_bit){//Blink if
       if(RE7_bit)PORTA = leds = (RE6_bit ?leds<<1 | leds>>7: leds>>1 | leds <<7 ) & 0xFF;
       else Wait();
       Wait();
    }
    else{
         Wait();
          leds = PORTA;
          PORTA = 0xffff;
          Wait();
          PORTA = leds;
          }
    }//while

}//main
