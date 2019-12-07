;*******************************************************************************
;                                                                              *
;    Microchip licenses this software to you solely for use with Microchip     *
;    products. The software is owned by Microchip and/or its licensors, and is *
;    protected under applicable copyright laws.  All rights reserved.          *
;                                                                              *
;    This software and any accompanying information is for suggestion only.    *
;    It shall not be deemed to modify Microchip?s standard warranty for its    *
;    products.  It is your responsibility to ensure that this software meets   *
;    your requirements.                                                        *
;                                                                              *
;    SOFTWARE IS PROVIDED "AS IS".  MICROCHIP AND ITS LICENSORS EXPRESSLY      *
;    DISCLAIM ANY WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING  *
;    BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS    *
;    FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL          *
;    MICROCHIP OR ITS LICENSORS BE LIABLE FOR ANY INCIDENTAL, SPECIAL,         *
;    INDIRECT OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, HARM TO     *
;    YOUR EQUIPMENT, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR    *
;    SERVICES, ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY   *
;    DEFENSE THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER      *
;    SIMILAR COSTS.                                                            *
;                                                                              *
;    To the fullest extend allowed by law, Microchip and its licensors         *
;    liability shall not exceed the amount of fee, if any, that you have paid  *
;    directly to Microchip to use this software.                               *
;                                                                              *
;    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF    *
;    THESE TERMS.                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Filename:                                                                 *
;    Date:                                                                     *
;    File Version:                                                             *
;    Author:                                                                   *
;    Company:                                                                  *
;    Description:                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Notes: In the MPLAB X Help, refer to the MPASM Assembler documentation    *
;    for information on assembly instructions.                                 *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Known Issues: This template is designed for relocatable code.  As such,   *
;    build errors such as "Directive only allowed when generating an object    *
;    file" will result when the 'Build in Absolute Mode' checkbox is selected  *
;    in the project properties.  Designing code in absolute mode is            *
;    antiquated - use relocatable mode.                                        *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Revision History:                                                         *
;                                                                              *
;*******************************************************************************



;*******************************************************************************
; Processor Inclusion
;
; TODO Step #1 Open the task list under Window > Tasks.  Include your
; device .inc file - e.g. #include <device_name>.inc.  Available
; include files are in C:\Program Files\Microchip\MPLABX\mpasmx
; assuming the default installation path for MPLAB X.  You may manually find
; the appropriate include file for your device here and include it, or
; simply copy the include generated by the configuration bits
; generator (see Step #2).
;
;*******************************************************************************

; TODO INSERT INCLUDE CODE HERE
#include <p18f46k22.inc>

;*******************************************************************************
;
; TODO Step #2 - Configuration Word Setup
;
; The 'CONFIG' directive is used to embed the configuration word within the
; .asm file. MPLAB X requires users to embed their configuration words
; into source code.  See the device datasheet for additional information
; on configuration word settings.  Device configuration bits descriptions
; are in C:\Program Files\Microchip\MPLABX\mpasmx\P<device_name>.inc
; (may change depending on your MPLAB X installation directory).
;
; MPLAB X has a feature which generates configuration bits source code.  Go to
; Window > PIC Memory Views > Configuration Bits.  Configure each field as
; needed and select 'Generate Source Code to Output'.  The resulting code which
; appears in the 'Output Window' > 'Config Bits Source' tab may be copied
; below.
;
;*******************************************************************************

; TODO INSERT CONFIG HERE

;*******************************************************************************
;
; TODO Step #3 - Variable Definitions
;
; Refer to datasheet for available data memory (RAM) organization assuming
; relocatible code organization (which is an option in project
; properties > mpasm (Global Options)).  Absolute mode generally should
; be used sparingly.
;
; Example of using GPR Uninitialized Data
;
;   GPR_VAR        UDATA
;   MYVAR1         RES        1      ; User variable linker places
;   MYVAR2         RES        1      ; User variable linker places
;   MYVAR3         RES        1      ; User variable linker places
;
;   ; Example of using Access Uninitialized Data Section (when available)
;   ; The variables for the context saving in the device datasheet may need
;   ; memory reserved here.
;   INT_VAR        UDATA_ACS
;   W_TEMP         RES        1      ; w register for context saving (ACCESS)
;   STATUS_TEMP    RES        1      ; status used for context saving
;   BSR_TEMP       RES        1      ; bank select used for ISR context saving
;
;*******************************************************************************

; TODO PLACE VARIABLE DEFINITIONS GO HERE

;*******************************************************************************
; Reset Vector
;*******************************************************************************

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

;*******************************************************************************
; TODO Step #4 - Interrupt Service Routines
;
; There are a few different ways to structure interrupt routines in the 8
; bit device families.  On PIC18's the high priority and low priority
; interrupts are located at 0x0008 and 0x0018, respectively.  On PIC16's and
; lower the interrupt is at 0x0004.  Between device families there is subtle
; variation in the both the hardware supporting the ISR (for restoring
; interrupt context) as well as the software used to restore the context
; (without corrupting the STATUS bits).
;
; General formats are shown below in relocatible format.
;
;------------------------------PIC16's and below--------------------------------
;
; ISR       CODE    0x0004           ; interrupt vector location
;
;     <Search the device datasheet for 'context' and copy interrupt
;     context saving code here.  Older devices need context saving code,
;     but newer devices like the 16F#### don't need context saving code.>
;
;     RETFIE
;
;----------------------------------PIC18's--------------------------------------
;
; ISRHV     CODE    0x0008
;     GOTO    HIGH_ISR
; ISRLV     CODE    0x0018
;     GOTO    LOW_ISR
;
; ISRH      CODE                     ; let linker place high ISR routine
; HIGH_ISR
;     <Insert High Priority ISR Here - no SW context saving>
;     RETFIE  FAST
;
; ISRL      CODE                     ; let linker place low ISR routine
; LOW_ISR
;       <Search the device datasheet for 'context' and copy interrupt
;       context saving code here>
;     RETFIE
;
;*******************************************************************************

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************

MAIN_PROG CODE                      ; let linker place main program

START
 
; set up LCD screen
Count0 EQU 0xE0
Count1 EQU 0xE1
Count2 EQU 0xE2 ;counter for delays
COUNTER	EQU 0xE3	;counter for delay loops
delay EQU 0xE4		;amount  of  delay for delay subroutines
temp_wr EQU 0xE5	;temporary register for LCD written data
temp_rd	EQU 0xE6	;temporary register for data read from the LCD controller
ptr_pos EQU 0xE7
ptr_count EQU 0xE8
cmd_byte EQU 0xE9	;used by LCD routines 

    GoTo	Main

Main:
    BSF TRISA, 4    ; sets PORTA bit 4 as an input -- SW2
    
    ;enable portb for digital
    MOVLB 0xF
    MOVLW 0xF0
    MOVWF ANSELB
    BSF TRISB, 0    ; sets PORTB bit 0 as an input -- SW3
    
    call	LCDInit		; Initialize PORTA, PORTD, and LCD Module
    call	LCDLine_1	;move cursor to line 1
    
; ---------------- Wait a while = 1 x256 x256 x3 uSec = 0.1 sec
    movLW	1
    movWF	Count2
    clrF	Count1
    clrF	Count0
WLoo	
    decFsZ	Count0
    bra		WLoo
    decFsZ	Count1
    bra		WLoo
    decFsZ	Count2
    bra		WLoo	
    
Display:
    ; print welcome message
    call	LCDLine_1
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'L'
    movWF	temp_wr
    call	d_write
    movLW	A'C'
    movWF	temp_wr
    call	d_write
    movLW	A'O'
    movWF	temp_wr
    call	d_write
    movLW	A'M'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    
    call	LCDLine_2
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'2'
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    movLW	A'A'
    movWF	temp_wr
    call	d_write
    movLW	A'R'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    
    ; wait for user start
    call RNG  
 
CODE_PACK1 EQU 0x500
CODE_PACK2 EQU 0x501
    
    ; store the rng value as the code
    CALL PACK
    MOVFF 0xA10, CODE_PACK1
    
    MOVFF 0xA02, 0xA00
    MOVFF 0xA03, 0xA01
    CALL PACK
    MOVFF 0xA10, CODE_PACK2
    
CODE1 EQU 0x510
CODE2 EQU 0x511
CODE3 EQU 0x512
CODE4 EQU 0X513
 
    ; unpack the code
 
UNPACK_CODE
    MOVFF CODE_PACK1, 0xA10
    CALL UNPACK
    MOVFF 0xA00, CODE1
    MOVFF 0xA01, CODE2
    
    MOVFF CODE_PACK2, 0xA10
    CALL UNPACK
    MOVFF 0xA00, CODE3
    MOVFF 0xA01, CODE4
    
    MOVFF CODE1, 0xA00
    MOVFF CODE2, 0xA01
    MOVFF CODE3, 0xA02
    MOVFF CODE4, 0xA03

GUESS_PACK1 EQU 0x600
GUESS_PACK2 EQU 0x601
 
GUESS1 EQU 0x610
GUESS2 EQU 0x611
GUESS3 EQU 0x612
GUESS4 EQU 0x613
 
GUESS_PACK_ARRAY EQU 0x620
BLK_CNT_ARRAY EQU 0x640
WT_CNT_ARRAY EQU 0x650
    
    LFSR 0, GUESS_PACK_ARRAY
    LFSR 1, BLK_CNT_ARRAY
    LFSR 2, WT_CNT_ARRAY
 
GUESS_NUM EQU 0x660
    MOVLB 0x6
    CLRF GUESS_NUM, 1
    
GUESS_LOOP
    CALL ENTER_GUESS
    
    ; unpack the guess
    MOVFF GUESS_PACK1, 0xA10
    CALL UNPACK
    MOVFF 0xA00, GUESS1
    MOVFF 0xA01, GUESS2
    
    MOVFF GUESS_PACK2, 0xA10
    CALL UNPACK
    MOVFF 0xA00, GUESS3
    MOVFF 0xA01, GUESS4
    
    ; determine blacks and whites
    MOVFF CODE1, 0xA00
    MOVFF CODE2, 0xA01
    MOVFF CODE3, 0xA02
    MOVFF CODE4, 0xA03
    MOVFF GUESS1, 0xA04
    MOVFF GUESS2, 0xA05
    MOVFF GUESS3, 0xA06
    MOVFF GUESS4, 0xA07
    CALL BLK_CNT
    
    ; store blacks
    MOVFF 0xA10, INDF1
    INCF FSR1
    
    CALL WT_CNT
    
    ; store whites
    MOVFF 0xA10, INDF2
    INCF FSR2
        
    ; TODO: display feedback
    
    ; TOOD: check for win condition
    
    ; pack and store the guess
    MOVFF GUESS1, 0xA00
    MOVFF GUESS2, 0xA01
    CALL PACK
    
    MOVFF 0xA10, INDF0
    INCF INDF0
   
    MOVFF GUESS3, 0xA00
    MOVFF GUESS4, 0xA01
    CALL PACK
    
    MOVFF 0xA10, INDF0
    INCF INDF0
    
    MOVLB 0x6
    INCF GUESS_NUM, 1
    
    GOTO GUESS_LOOP

;*******************************************************************************
; SUBROUTINES
;*******************************************************************************

PACK
    ; Reads 2 single digits stored in two 8-bit registers, and packs them
    ; into one 8-bit register.
    ;
    ; Input at 0x0A00 (r1) and 0x0A01 (r2)
    ; Output at 0x0A10 as (r2|r1)
    
    MOVLB 0xA
    
    ; move the contents of r2 to the high nibble and zero out the low nibble
    SWAPF 0xA01, F, 1
    MOVLW H'F0'
    ANDWF 0xA01, F, 1
    
    ; zero out the low nibble of r1
    MOVLW H'0F'
    ANDWF 0xA00, W, 1
    
    ; combine r2 and r1 and move it to the output
    IORWF 0xA01, W, 1
    MOVWF 0xA10, 1
    RETURN

    
UNPACK
    ; Reads one double digit number stored in an 8-bit register, and
    ; unpacks it into 2 single digit numbers stored in two 8-bit registers.
    ;
    ; Input at 0x0A10 as (r2|r1)
    ; Output at 0x0A00 (r1) and 0x0A01 (r2)
    
    MOVLB 0xA
    
    MOVLW H'F0'
    ANDWF 0xA10, W, 1
    MOVWF 0xA01, 1
    SWAPF 0xA01, F, 1
    
    MOVLW H'0F'
    ANDWF 0xA10, W, 1
    MOVWF 0xA00, 1
    
    RETURN
    
    
BLK_CNT
    ; Compares two 4-digit codes, each stored in an unpacked form in
    ; 4 8-bit registers, and find the number of exact matches between the two. 
    ; The upper nibbles of all registers hold the value 0H.
    ;
    ; Since WT_CNT will be called afterwards, any matches will have a flag set
    ; in bit 7 to prevent a false positives for whites
    ;
    ; Input at 0xA00 - 0xA03 (r1 to r4 for CODE)
    ;          0xA04 - 0xA07 (r5 to r8 for GUESS)
    ; Output at 0xA10
    
    MOVLB 0xA
    
    CLRF 0xA10, 1
    
BLK_CNT_1
    MOVF 0xA00, W, 1
    CPFSEQ 0xA04, 1 ; check if CODE == GUESS
    BRA BLK_CNT_2 ; if not, check the next row
    
    INCF 0xA10, F, 1 ; if so, increment the count and flag the values
    BSF 0xA00, 7, 1
    BSF 0xA04, 7, 1
    
BLK_CNT_2
    MOVF 0xA01, W, 1
    CPFSEQ 0xA05, 1
    BRA BLK_CNT_3
    
    INCF 0xA10, F, 1
    BSF 0xA01, 7, 1
    BSF 0xA05, 7, 1
    
BLK_CNT_3
    MOVF 0xA02, W, 1
    CPFSEQ 0xA06, 1
    BRA BLK_CNT_4
    
    INCF 0xA10, F, 1
    BSF 0xA02, 7, 1
    BSF 0xA06, 7, 1
    
BLK_CNT_4
    MOVF 0xA03, W, 1
    CPFSEQ 0xA07, 1
    RETURN
    
    INCF 0xA10, F, 1
    BSF 0xA03, 7, 1
    BSF 0xA07, 7, 1

BLK_CNT_END
    RETURN
    
    
WT_CNT
    ; Compares two 4-digit codes, each stored in an unpacked form in 
    ; 4 8-bit registers, and find the number of color matches between the two 
    ; that are not considered in exact matches. The upper nibbles of all 
    ; registers hold the value 0H. You need to be careful of double counting.
    ;
    ; Input at 0x0A00 - 0xA003 (r1 to r4 for CODE)
    ;          0x0A04 - 0xA007 (r5 to r8 for GUESS)
    ; Output at 0x0A10
    
    MOVLB 0xA
    
    CLRF 0xA10, 1 ; white count

    MOVLW 4H ; outer loop counter
    MOVWF 0xA20, 1
    
    MOVLW 4H ; inner loop counter
    MOVWF 0xA21, 1
    
    LFSR 0, 0xA00
    LFSR 1, 0xA04
    
WT_CNT_LOOP_1
    ; skip this iteration if this code has been counted as a black
    BTFSS INDF0, 7
    
    CALL WT_CNT_LOOP_2
    
    DCFSNZ 0xA20, F, 1
    RETURN
    
    LFSR 1, 0xA04; reset guess pointer
    
    MOVLW 4H ; reset inner loop counter
    MOVWF 0xA21, 1
    
    INCF FSR0L
    BRA WT_CNT_LOOP_1
    
WT_CNT_LOOP_2
    ; skip this iteration if this guess has been counted as a black
    BTFSS INDF1, 7
    CALL WT_CNT_CMP
   
    DCFSNZ 0xA21, F, 1
    RETURN
    
    INCF FSR1L
    BRA WT_CNT_LOOP_2
    
WT_CNT_CMP
    ; skip this iteration if we are matching the same row
    MOVF 0xA20, W, 1
    SUBWF 0xA21, W, 1
    BZ WT_CNT_CMP_END
    
    ; compare
    MOVF INDF0, W
    CPFSEQ INDF1
    BRA WT_CNT_CMP_END
    INCF 0xA10, F, 1
    BSF INDF0, 7
    BSF INDF1, 7
    
WT_CNT_CMP_END
    RETURN
    
    
RNG
; randomizes a code until user presses SW2
; Outputs to 0xA00-0xA03
CPURAND0 EQU 0xA00
CPURAND1 EQU 0xA01
CPURAND2 EQU 0xA02
CPURAND3 EQU 0xA03
 
    MOVLB 0xA
    
    ;initialize counters to 5
    MOVLW 5H
    MOVWF CPURAND0, 1
    MOVLW 5H
    MOVWF CPURAND1, 1
    MOVLW 5H
    MOVWF CPURAND2, 1
    MOVLW 5H
    MOVWF CPURAND3, 1
    BRA RCOUNT3 ; RCOUNT3 starts counting down the LSB
    
RCOUNT0 ; RESET bit 1
    MOVLW 5H
    MOVWF CPURAND1, 1
RCOUNT1 ; RESET bit 2
    MOVLW 5H
    MOVWF CPURAND2, 1
RCOUNT2 ; RESET bit 3
    MOVLW 5H
    MOVWF CPURAND3, 1
RCOUNT3
    ; check if SW2 is pressed
    BTFSS PORTA, 4
    BRA RNG_WAIT
    
    DECFSZ CPURAND3, 1
    BRA RCOUNT3
    ; R3 is 0
    DECFSZ CPURAND2, 1
    BRA RCOUNT2
    ; R3 is 0 and R2 = 0
    DECFSZ CPURAND1, 1
    BRA RCOUNT1
    ; R3 is 0 and R2 = 0 and R1 = 0
    DECFSZ CPURAND0, 1
    BRA RCOUNT0
    ; R3 is 0 and R2 = 0 and R1 = 0 and R0 = 0
    MOVLW 5H ; reset MSB
    MOVWF CPURAND0, 1
    BRA RCOUNT0
 
RNG_WAIT
    BTFSS PORTA, 4
    BRA $-2
    RETURN
 

;*******************************************************************************
; I/O SUBROUTINES
;*******************************************************************************
WAIT_BP
    ; waits for a button press and release and returns which button got pushed
    ; output at 0xA00, 0 if SW2, 1 if SW3
    ; SW2 = RA4 = PORTA, 4
    ; SW3 = RB0 = PORTB, 0
    MOVLB 0xA
    
    BTFSS	PORTA, 4
    BRA		WT_RELEASEA
    BTFSS	PORTB, 0
    BRA		WT_RELEASEB

    BRA    	WAIT_BP
    
WT_RELEASEA   
    BTFSS	PORTA,4
    BRA		$-2
    CLRF	0xA00, 1
    RETURN
    
WT_RELEASEB    
    BTFSS	PORTB,0
    BRA		$-2
    BSF		0xA00, 0, 1
    RETURN
    
    
CLEAR_LCD
    ; clears the LCD screen
    movLW	1H
    movWF	temp_wr
    call	i_write
    RETURN
    
    
ENTER_GUESS
    ; prompts user for a guess and stores it at 0xA10 - 0xA13
    ; initalize guess to 0000
    
    MOVLB 0xA
    
    CLRF 0xA10, 1
    CLRF 0xA11, 1
    CLRF 0xA12, 1
    CLRF 0xA13, 1
    
    ; update display to prompt user
    CALL CLEAR_LCD
    
    ; print "SW2:++ SW3:NEXT" to line 1
    call	LCDLine_1
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'2'
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A'+'
    movWF	temp_wr
    call	d_write
    movLW	A'+'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'W'
    movWF	temp_wr
    call	d_write
    movLW	A'3'
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A'N'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'X'
    movWF	temp_wr
    call	d_write
    movLW	A'T'
    movWF	temp_wr
    call	d_write
    
    ; print "GUESS: 0" to line 2
    call	LCDLine_1
    movLW	A'G'
    movWF	temp_wr
    call	d_write
    movLW	A'U'
    movWF	temp_wr
    call	d_write
    movLW	A'E'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A'S'
    movWF	temp_wr
    call	d_write
    movLW	A':'
    movWF	temp_wr
    call	d_write
    movLW	A' '
    movWF	temp_wr
    call	d_write
    movLW	A'0'
    movWF	temp_wr
    call	d_write
    
    CALL WAIT_BP
    
    BTFSS 0xA00, 1
    BRA INC_GUESS
    BRA NEXT_VALUE
    
    
    
; *****************  Low-Level LCD Routines  *******************
#Include LCD_p18LCD_Subs_New.asm
  ; Contains:
; --- LCDInit:		>> initialize
; --- LCDLine_1:	>> Cursor to Line_1
; --- LCDLine_2:	>> Cursor to to Line_2
; --- i_write:  	>> instruction write
; --- d_write:		>> data        write
    END
