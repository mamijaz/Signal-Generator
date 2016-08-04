
_main:

;LCD.c,45 :: 		void main() {
;LCD.c,49 :: 		int nscale=0;
	CLRF       main_nscale_L0+0
	CLRF       main_nscale_L0+1
;LCD.c,54 :: 		scale[0][0]='H';scale[0][1]='z';scale[0][2]=' ';
	MOVLW      72
	MOVWF      main_scale_L0+0
	MOVLW      122
	MOVWF      main_scale_L0+1
	MOVLW      32
	MOVWF      main_scale_L0+2
;LCD.c,55 :: 		scale[1][0]='K';scale[1][1]='H';scale[1][2]='z';
	MOVLW      75
	MOVWF      main_scale_L0+3
	MOVLW      72
	MOVWF      main_scale_L0+4
	MOVLW      122
	MOVWF      main_scale_L0+5
;LCD.c,56 :: 		scale[2][0]='M';scale[2][1]='H';scale[2][2]='z';
	MOVLW      77
	MOVWF      main_scale_L0+6
	MOVLW      72
	MOVWF      main_scale_L0+7
	MOVLW      122
	MOVWF      main_scale_L0+8
;LCD.c,57 :: 		TRISA= 0;
	CLRF       TRISA+0
;LCD.c,58 :: 		TRISB=0;
	CLRF       TRISB+0
;LCD.c,61 :: 		Lcd_Init();                              // Initialize LCD
	CALL       _Lcd_Init+0
;LCD.c,62 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,63 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCD.c,64 :: 		Lcd_Out(1, 1, "Freq:");                  // Write message text on LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_LCD+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,65 :: 		Lcd_Out(1, 14, "Hz");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_LCD+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,66 :: 		Lcd_Out(2,1,"Signal Generator");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_LCD+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,67 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;LCD.c,68 :: 		while(1)
L_main0:
;LCD.c,70 :: 		int freq_array[3]={0,0,0};
	CLRF       main_freq_array_L1+0
	CLRF       main_freq_array_L1+1
	CLRF       main_freq_array_L1+2
	CLRF       main_freq_array_L1+3
	CLRF       main_freq_array_L1+4
	CLRF       main_freq_array_L1+5
;LCD.c,73 :: 		kp=0;
	CLRF       main_kp_L0+0
;LCD.c,74 :: 		kp=Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      main_kp_L0+0
;LCD.c,76 :: 		if(kp!=0 && kp!=1 && kp!=2)         //when any number is pressed
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
	MOVF       main_kp_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main4
	MOVF       main_kp_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main4
L__main40:
;LCD.c,78 :: 		freq_array[0]=freq_array[1];
	MOVF       main_freq_array_L1+2, 0
	MOVWF      main_freq_array_L1+0
	MOVF       main_freq_array_L1+3, 0
	MOVWF      main_freq_array_L1+1
;LCD.c,79 :: 		freq_array[1]=freq_array[2];
	MOVF       main_freq_array_L1+4, 0
	MOVWF      main_freq_array_L1+2
	MOVF       main_freq_array_L1+5, 0
	MOVWF      main_freq_array_L1+3
;LCD.c,80 :: 		freq_array[2]=keyidentifier(kp);
	MOVF       main_kp_L0+0, 0
	MOVWF      FARG_keyidentifier_kp+0
	CLRF       FARG_keyidentifier_kp+1
	CALL       _keyidentifier+0
	MOVF       R0+0, 0
	MOVWF      main_freq_array_L1+4
	MOVF       R0+1, 0
	MOVWF      main_freq_array_L1+5
;LCD.c,81 :: 		freq=100*freq_array[2]+10*freq_array[1]+freq_array[0];
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       main_freq_array_L1+2, 0
	MOVWF      R4+0
	MOVF       main_freq_array_L1+3, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDWF      FLOC__main+0, 0
	MOVWF      main_freq_L1+0
	MOVF       FLOC__main+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      main_freq_L1+1
	MOVF       main_freq_array_L1+0, 0
	ADDWF      main_freq_L1+0, 1
	MOVF       main_freq_array_L1+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_freq_L1+1, 1
	MOVLW      0
	BTFSC      main_freq_L1+1, 7
	MOVLW      255
	MOVWF      main_freq_L1+2
	MOVWF      main_freq_L1+3
;LCD.c,82 :: 		LongToStr(freq,txt);
	MOVF       main_freq_L1+0, 0
	MOVWF      FARG_LongToStr_input+0
	MOVF       main_freq_L1+1, 0
	MOVWF      FARG_LongToStr_input+1
	MOVF       main_freq_L1+2, 0
	MOVWF      FARG_LongToStr_input+2
	MOVF       main_freq_L1+3, 0
	MOVWF      FARG_LongToStr_input+3
	MOVLW      main_txt_L0+0
	MOVWF      FARG_LongToStr_output+0
	CALL       _LongToStr+0
;LCD.c,83 :: 		Lcd_Out(1,6,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,84 :: 		}
L_main4:
;LCD.c,86 :: 		if(kp==2)         //when scale key pressed
	MOVF       main_kp_L0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;LCD.c,88 :: 		if(nscale==2){
	MOVLW      0
	XORWF      main_nscale_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main43
	MOVLW      2
	XORWF      main_nscale_L0+0, 0
L__main43:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;LCD.c,89 :: 		nscale=0;
	CLRF       main_nscale_L0+0
	CLRF       main_nscale_L0+1
;LCD.c,90 :: 		}
	GOTO       L_main7
L_main6:
;LCD.c,93 :: 		nscale=nscale+1;
	INCF       main_nscale_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_nscale_L0+1, 1
;LCD.c,94 :: 		}
L_main7:
;LCD.c,95 :: 		Lcd_Out(1,14,scale[nscale]);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      3
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       main_nscale_L0+0, 0
	MOVWF      R4+0
	MOVF       main_nscale_L0+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDLW      main_scale_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCD.c,96 :: 		}
L_main5:
;LCD.c,98 :: 		if(kp==1)         //when start is pressed
	MOVF       main_kp_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;LCD.c,100 :: 		if(nscale==2)
	MOVLW      0
	XORWF      main_nscale_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVLW      2
	XORWF      main_nscale_L0+0, 0
L__main44:
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;LCD.c,102 :: 		freq=freq*1000000;
	MOVF       main_freq_L1+0, 0
	MOVWF      R0+0
	MOVF       main_freq_L1+1, 0
	MOVWF      R0+1
	MOVF       main_freq_L1+2, 0
	MOVWF      R0+2
	MOVF       main_freq_L1+3, 0
	MOVWF      R0+3
	MOVLW      64
	MOVWF      R4+0
	MOVLW      66
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      main_freq_L1+0
	MOVF       R0+1, 0
	MOVWF      main_freq_L1+1
	MOVF       R0+2, 0
	MOVWF      main_freq_L1+2
	MOVF       R0+3, 0
	MOVWF      main_freq_L1+3
;LCD.c,103 :: 		}
	GOTO       L_main10
L_main9:
;LCD.c,104 :: 		else if(nscale==1)
	MOVLW      0
	XORWF      main_nscale_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVLW      1
	XORWF      main_nscale_L0+0, 0
L__main45:
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;LCD.c,106 :: 		freq=freq*1000;
	MOVF       main_freq_L1+0, 0
	MOVWF      R0+0
	MOVF       main_freq_L1+1, 0
	MOVWF      R0+1
	MOVF       main_freq_L1+2, 0
	MOVWF      R0+2
	MOVF       main_freq_L1+3, 0
	MOVWF      R0+3
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      main_freq_L1+0
	MOVF       R0+1, 0
	MOVWF      main_freq_L1+1
	MOVF       R0+2, 0
	MOVWF      main_freq_L1+2
	MOVF       R0+3, 0
	MOVWF      main_freq_L1+3
;LCD.c,107 :: 		}
	GOTO       L_main12
L_main11:
;LCD.c,110 :: 		freq=freq;
;LCD.c,111 :: 		}
L_main12:
L_main10:
;LCD.c,113 :: 		set_keyword(freq);
	MOVF       main_freq_L1+0, 0
	MOVWF      FARG_set_keyword_frequancy+0
	MOVF       main_freq_L1+1, 0
	MOVWF      FARG_set_keyword_frequancy+1
	CALL       _set_keyword+0
;LCD.c,114 :: 		send_data_ad9850();
	CALL       _send_data_ad9850+0
;LCD.c,115 :: 		}
L_main8:
;LCD.c,117 :: 		}
	GOTO       L_main0
;LCD.c,119 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_keyidentifier:

;LCD.c,121 :: 		int keyidentifier(int kp)
;LCD.c,123 :: 		switch (kp) {
	GOTO       L_keyidentifier13
;LCD.c,124 :: 		case  13: kp = 49; break; // 1
L_keyidentifier15:
	MOVLW      49
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,125 :: 		case  16: kp = 50; break; // 2
L_keyidentifier16:
	MOVLW      50
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,126 :: 		case  14: kp = 51; break; // 3
L_keyidentifier17:
	MOVLW      51
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,127 :: 		case  9:         kp = 52; break; // 4
L_keyidentifier18:
	MOVLW      52
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,128 :: 		case  12: kp = 53; break; // 5
L_keyidentifier19:
	MOVLW      53
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,129 :: 		case  10: kp = 54; break; // 6
L_keyidentifier20:
	MOVLW      54
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,130 :: 		case  5:         kp = 55; break; // 7
L_keyidentifier21:
	MOVLW      55
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,131 :: 		case  8:         kp = 56; break; // 8
L_keyidentifier22:
	MOVLW      56
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,132 :: 		case  6:         kp = 57; break; // 9
L_keyidentifier23:
	MOVLW      57
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,133 :: 		case         1:        kp = 42; break; // '*'
L_keyidentifier24:
	MOVLW      42
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,134 :: 		case         4:         kp = 48; break; // '0'
L_keyidentifier25:
	MOVLW      48
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,135 :: 		case         2:         kp = 35; break; // '#'
L_keyidentifier26:
	MOVLW      35
	MOVWF      FARG_keyidentifier_kp+0
	MOVLW      0
	MOVWF      FARG_keyidentifier_kp+1
	GOTO       L_keyidentifier14
;LCD.c,136 :: 		}
L_keyidentifier13:
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier47
	MOVLW      13
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier47:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier15
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier48
	MOVLW      16
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier48:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier16
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier49
	MOVLW      14
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier49:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier17
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier50
	MOVLW      9
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier50:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier18
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier51
	MOVLW      12
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier51:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier19
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier52
	MOVLW      10
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier52:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier20
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier53
	MOVLW      5
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier53:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier21
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier54
	MOVLW      8
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier54:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier22
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier55
	MOVLW      6
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier55:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier23
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier56
	MOVLW      1
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier56:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier24
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier57
	MOVLW      4
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier57:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier25
	MOVLW      0
	XORWF      FARG_keyidentifier_kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__keyidentifier58
	MOVLW      2
	XORWF      FARG_keyidentifier_kp+0, 0
L__keyidentifier58:
	BTFSC      STATUS+0, 2
	GOTO       L_keyidentifier26
L_keyidentifier14:
;LCD.c,137 :: 		return kp;
	MOVF       FARG_keyidentifier_kp+0, 0
	MOVWF      R0+0
	MOVF       FARG_keyidentifier_kp+1, 0
	MOVWF      R0+1
;LCD.c,138 :: 		}
L_end_keyidentifier:
	RETURN
; end of _keyidentifier

_power:

;LCD.c,140 :: 		int power(int i,int j)
;LCD.c,142 :: 		int m=0,value=1;
	CLRF       power_m_L0+0
	CLRF       power_m_L0+1
	MOVLW      1
	MOVWF      power_value_L0+0
	MOVLW      0
	MOVWF      power_value_L0+1
;LCD.c,143 :: 		for(m=0;m<j;m++)
	CLRF       power_m_L0+0
	CLRF       power_m_L0+1
L_power27:
	MOVLW      128
	XORWF      power_m_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_power_j+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__power60
	MOVF       FARG_power_j+0, 0
	SUBWF      power_m_L0+0, 0
L__power60:
	BTFSC      STATUS+0, 0
	GOTO       L_power28
;LCD.c,145 :: 		value*=i;
	MOVF       power_value_L0+0, 0
	MOVWF      R0+0
	MOVF       power_value_L0+1, 0
	MOVWF      R0+1
	MOVF       FARG_power_i+0, 0
	MOVWF      R4+0
	MOVF       FARG_power_i+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      power_value_L0+0
	MOVF       R0+1, 0
	MOVWF      power_value_L0+1
;LCD.c,143 :: 		for(m=0;m<j;m++)
	INCF       power_m_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       power_m_L0+1, 1
;LCD.c,146 :: 		}
	GOTO       L_power27
L_power28:
;LCD.c,147 :: 		return value;
	MOVF       power_value_L0+0, 0
	MOVWF      R0+0
	MOVF       power_value_L0+1, 0
	MOVWF      R0+1
;LCD.c,148 :: 		}
L_end_power:
	RETURN
; end of _power

_set_keyword:

;LCD.c,150 :: 		void set_keyword(int frequancy)
;LCD.c,152 :: 		int DataBits[5]={0};
	CLRF       set_keyword_DataBits_L0+0
	CLRF       set_keyword_DataBits_L0+1
	CLRF       set_keyword_DataBits_L0+2
	CLRF       set_keyword_DataBits_L0+3
	CLRF       set_keyword_DataBits_L0+4
	CLRF       set_keyword_DataBits_L0+5
	CLRF       set_keyword_DataBits_L0+6
	CLRF       set_keyword_DataBits_L0+7
	CLRF       set_keyword_DataBits_L0+8
	CLRF       set_keyword_DataBits_L0+9
	CLRF       set_keyword_sum_L0+0
	CLRF       set_keyword_sum_L0+1
	CLRF       set_keyword_i_L0+0
	CLRF       set_keyword_i_L0+1
	CLRF       set_keyword_m_L0+0
	CLRF       set_keyword_m_L0+1
;LCD.c,154 :: 		frequancy=frequancy_keyword(frequancy);
	MOVF       FARG_set_keyword_frequancy+0, 0
	MOVWF      FARG_frequancy_keyword_number+0
	MOVF       FARG_set_keyword_frequancy+1, 0
	MOVWF      FARG_frequancy_keyword_number+1
	CALL       _frequancy_keyword+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_keyword_frequancy+0
	MOVF       R0+1, 0
	MOVWF      FARG_set_keyword_frequancy+1
;LCD.c,156 :: 		while(frequancy!=0)
L_set_keyword30:
	MOVLW      0
	XORWF      FARG_set_keyword_frequancy+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_keyword62
	MOVLW      0
	XORWF      FARG_set_keyword_frequancy+0, 0
L__set_keyword62:
	BTFSC      STATUS+0, 2
	GOTO       L_set_keyword31
;LCD.c,158 :: 		sum+=(frequancy%2)*power(2,i);
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_set_keyword_frequancy+0, 0
	MOVWF      R0+0
	MOVF       FARG_set_keyword_frequancy+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__set_keyword+0
	MOVF       R0+1, 0
	MOVWF      FLOC__set_keyword+1
	MOVLW      2
	MOVWF      FARG_power_i+0
	MOVLW      0
	MOVWF      FARG_power_i+1
	MOVF       set_keyword_i_L0+0, 0
	MOVWF      FARG_power_j+0
	MOVF       set_keyword_i_L0+1, 0
	MOVWF      FARG_power_j+1
	CALL       _power+0
	MOVF       FLOC__set_keyword+0, 0
	MOVWF      R4+0
	MOVF       FLOC__set_keyword+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDWF      set_keyword_sum_L0+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      set_keyword_sum_L0+1, 1
;LCD.c,159 :: 		i++;
	INCF       set_keyword_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       set_keyword_i_L0+1, 1
;LCD.c,160 :: 		if(i==8)
	MOVLW      0
	XORWF      set_keyword_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_keyword63
	MOVLW      8
	XORWF      set_keyword_i_L0+0, 0
L__set_keyword63:
	BTFSS      STATUS+0, 2
	GOTO       L_set_keyword32
;LCD.c,162 :: 		i=0;
	CLRF       set_keyword_i_L0+0
	CLRF       set_keyword_i_L0+1
;LCD.c,163 :: 		DataBits[m]=sum;
	MOVF       set_keyword_m_L0+0, 0
	MOVWF      R0+0
	MOVF       set_keyword_m_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      set_keyword_DataBits_L0+0
	MOVWF      FSR
	MOVF       set_keyword_sum_L0+0, 0
	MOVWF      INDF+0
	MOVF       set_keyword_sum_L0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;LCD.c,164 :: 		m++;
	INCF       set_keyword_m_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       set_keyword_m_L0+1, 1
;LCD.c,165 :: 		sum=0;
	CLRF       set_keyword_sum_L0+0
	CLRF       set_keyword_sum_L0+1
;LCD.c,166 :: 		}
L_set_keyword32:
;LCD.c,167 :: 		frequancy/=2;
	RRF        FARG_set_keyword_frequancy+1, 1
	RRF        FARG_set_keyword_frequancy+0, 1
	BCF        FARG_set_keyword_frequancy+1, 7
	BTFSC      FARG_set_keyword_frequancy+1, 6
	BSF        FARG_set_keyword_frequancy+1, 7
;LCD.c,168 :: 		if(i<8 && frequancy==0)
	MOVLW      128
	XORWF      set_keyword_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_keyword64
	MOVLW      8
	SUBWF      set_keyword_i_L0+0, 0
L__set_keyword64:
	BTFSC      STATUS+0, 0
	GOTO       L_set_keyword35
	MOVLW      0
	XORWF      FARG_set_keyword_frequancy+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_keyword65
	MOVLW      0
	XORWF      FARG_set_keyword_frequancy+0, 0
L__set_keyword65:
	BTFSS      STATUS+0, 2
	GOTO       L_set_keyword35
L__set_keyword41:
;LCD.c,170 :: 		DataBits[m]=sum;
	MOVF       set_keyword_m_L0+0, 0
	MOVWF      R0+0
	MOVF       set_keyword_m_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      set_keyword_DataBits_L0+0
	MOVWF      FSR
	MOVF       set_keyword_sum_L0+0, 0
	MOVWF      INDF+0
	MOVF       set_keyword_sum_L0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;LCD.c,171 :: 		}
L_set_keyword35:
;LCD.c,172 :: 		}
	GOTO       L_set_keyword30
L_set_keyword31:
;LCD.c,173 :: 		}
L_end_set_keyword:
	RETURN
; end of _set_keyword

_send_data_ad9850:

;LCD.c,175 :: 		void send_data_ad9850()
;LCD.c,177 :: 		int i=0;
	CLRF       send_data_ad9850_i_L0+0
	CLRF       send_data_ad9850_i_L0+1
;LCD.c,178 :: 		PORTA.F3=0;
	BCF        PORTA+0, 3
;LCD.c,179 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_send_data_ad985036:
	DECFSZ     R13+0, 1
	GOTO       L_send_data_ad985036
	DECFSZ     R12+0, 1
	GOTO       L_send_data_ad985036
	DECFSZ     R11+0, 1
	GOTO       L_send_data_ad985036
	NOP
;LCD.c,180 :: 		PORTA.F3=0;
	BCF        PORTA+0, 3
;LCD.c,184 :: 		for(i=4;i>=0;i--)
	MOVLW      4
	MOVWF      send_data_ad9850_i_L0+0
	MOVLW      0
	MOVWF      send_data_ad9850_i_L0+1
L_send_data_ad985037:
	MOVLW      128
	XORWF      send_data_ad9850_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__send_data_ad985067
	MOVLW      0
	SUBWF      send_data_ad9850_i_L0+0, 0
L__send_data_ad985067:
	BTFSS      STATUS+0, 0
	GOTO       L_send_data_ad985038
;LCD.c,186 :: 		PORTB=DataBits[i];
	MOVF       send_data_ad9850_i_L0+0, 0
	MOVWF      R0+0
	MOVF       send_data_ad9850_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _DataBits+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;LCD.c,187 :: 		Delay_us(1);
	NOP
	NOP
	NOP
	NOP
	NOP
;LCD.c,188 :: 		PORTA.F0=1;
	BSF        PORTA+0, 0
;LCD.c,189 :: 		Delay_us(1);
	NOP
	NOP
	NOP
	NOP
	NOP
;LCD.c,190 :: 		PORTA.F0=0;
	BCF        PORTA+0, 0
;LCD.c,191 :: 		Delay_us(1);
	NOP
	NOP
	NOP
	NOP
	NOP
;LCD.c,184 :: 		for(i=4;i>=0;i--)
	MOVLW      1
	SUBWF      send_data_ad9850_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       send_data_ad9850_i_L0+1, 1
;LCD.c,192 :: 		}
	GOTO       L_send_data_ad985037
L_send_data_ad985038:
;LCD.c,194 :: 		PORTA.F1=1;
	BSF        PORTA+0, 1
;LCD.c,195 :: 		Delay_us(1);
	NOP
	NOP
	NOP
	NOP
	NOP
;LCD.c,196 :: 		PORTA.F1=0;
	BCF        PORTA+0, 1
;LCD.c,197 :: 		}
L_end_send_data_ad9850:
	RETURN
; end of _send_data_ad9850

_frequancy_keyword:

;LCD.c,199 :: 		int frequancy_keyword(int number)
;LCD.c,201 :: 		return (int)(number*power(2,32)/125000000.00+0.5);
	MOVLW      2
	MOVWF      FARG_power_i+0
	MOVLW      0
	MOVWF      FARG_power_i+1
	MOVLW      32
	MOVWF      FARG_power_j+0
	MOVLW      0
	MOVWF      FARG_power_j+1
	CALL       _power+0
	MOVF       FARG_frequancy_keyword_number+0, 0
	MOVWF      R4+0
	MOVF       FARG_frequancy_keyword_number+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	CALL       _Int2Double+0
	MOVLW      40
	MOVWF      R4+0
	MOVLW      107
	MOVWF      R4+1
	MOVLW      110
	MOVWF      R4+2
	MOVLW      153
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      126
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
;LCD.c,202 :: 		}
L_end_frequancy_keyword:
	RETURN
; end of _frequancy_keyword
