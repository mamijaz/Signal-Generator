#line 1 "D:/Study/PIC Mikro c/test5/LCD.c"



int DataBits[5]={0};



char keypadPort at PORTD;




sbit LCD_D4 at RC0_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D7 at RC3_bit;
sbit LCD_EN at RC4_bit;
sbit LCD_RS at RC5_bit;

sbit LCD_D4_Direction at TRISC0_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D7_Direction at TRISC3_bit;
sbit LCD_EN_Direction at TRISC4_bit;
sbit LCD_RS_Direction at TRISC5_bit;
#line 38 "D:/Study/PIC Mikro c/test5/LCD.c"
int keyidentifier(int kp);
int power(int i,int j);
void set_keyword(int frequancy);
void send_data_ad9850();
int frequancy_keyword(int number);


void main() {


 unsigned short kp;
 int nscale=0;
 char txt[3];


 char scale[3][3];
 scale[0][0]='H';scale[0][1]='z';scale[0][2]=' ';
 scale[1][0]='K';scale[1][1]='H';scale[1][2]='z';
 scale[2][0]='M';scale[2][1]='H';scale[2][2]='z';
 TRISA= 0;
 TRISB=0;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Freq:");
 Lcd_Out(1, 14, "Hz");
 Lcd_Out(2,1,"Signal Generator");
 Keypad_Init();
 while(1)
 {
 int freq_array[3]={0,0,0};
 unsigned long freq;

 kp=0;
 kp=Keypad_Key_Click();

 if(kp!=0 && kp!=1 && kp!=2)
 {
 freq_array[0]=freq_array[1];
 freq_array[1]=freq_array[2];
 freq_array[2]=keyidentifier(kp);
 freq=100*freq_array[2]+10*freq_array[1]+freq_array[0];
 LongToStr(freq,txt);
 Lcd_Out(1,6,txt);
 }

 if(kp==2)
 {
 if(nscale==2){
 nscale=0;
 }
 else
 {
 nscale=nscale+1;
 }
 Lcd_Out(1,14,scale[nscale]);
 }

 if(kp==1)
 {
 if(nscale==2)
 {
 freq=freq*1000000;
 }
 else if(nscale==1)
 {
 freq=freq*1000;
 }
 else
 {
 freq=freq;
 }

 set_keyword(freq);
 send_data_ad9850();
 }

 }

}

int keyidentifier(int kp)
{
 switch (kp) {
 case 13: kp = 49; break;
 case 16: kp = 50; break;
 case 14: kp = 51; break;
 case 9: kp = 52; break;
 case 12: kp = 53; break;
 case 10: kp = 54; break;
 case 5: kp = 55; break;
 case 8: kp = 56; break;
 case 6: kp = 57; break;
 case 1: kp = 42; break;
 case 4: kp = 48; break;
 case 2: kp = 35; break;
 }
 return kp;
}

int power(int i,int j)
{
 int m=0,value=1;
 for(m=0;m<j;m++)
 {
 value*=i;
 }
 return value;
}

void set_keyword(int frequancy)
{
 int DataBits[5]={0};
 int sum=0,i=0,m=0;
 frequancy=frequancy_keyword(frequancy);

 while(frequancy!=0)
 {
 sum+=(frequancy%2)*power(2,i);
 i++;
 if(i==8)
 {
 i=0;
 DataBits[m]=sum;
 m++;
 sum=0;
 }
 frequancy/=2;
 if(i<8 && frequancy==0)
 {
 DataBits[m]=sum;
 }
 }
}

void send_data_ad9850()
{
 int i=0;
 PORTA.F3=0;
 delay_ms(500);
 PORTA.F3=0;



 for(i=4;i>=0;i--)
 {
 PORTB=DataBits[i];
 Delay_us(1);
 PORTA.F0=1;
 Delay_us(1);
 PORTA.F0=0;
 Delay_us(1);
 }

 PORTA.F1=1;
 Delay_us(1);
 PORTA.F1=0;
}

int frequancy_keyword(int number)
{
 return (int)(number*power(2,32)/125000000.00+0.5);
}
