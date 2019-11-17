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

; TODO INSERT ISR HERE

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************

MAIN_PROG CODE                      ; let linker place main program

START

RNG
    X0 EQU 0x000
    X1 EQU 0x001
    X2 EQU 0x002
    X3 EQU 0x003
 
    CODE0 EQU 0x004
    CODE1 EQU 0x005
 
    GUESS0 EQU 0x010
    GUESS1 EQU 0x011

FEEDBACK
    ; unpack the guess into individual registers  
    COLOR0 EQU 0x020
    COLOR1 EQU 0x021
    COLOR2 EQU 0x022
    COLOR3 EQU 0x023
    
    FB0 EQU 0x024
    FB1 EQU 0x025
    FB2 EQU 0x026
    FB3 EQU 0x027
    
    ; unpack first bype of code/guess
    MOVFF CODE0, COLOR0
    MOVFF GUESS0, FB0    
    MOVLW H'F0'
    ANDWF COLOR0, F
    RRCF COLOR0, F
    RRCF COLOR0, F
    RRCF COLOR0, F
    RRCF COLOR0, F
    ANDWF FB0, F
    RRCF FB0, F
    RRCF FB0, F
    RRCF FB0, F
    RRCF FB0, F
    
    ; unpack second bype of code/guess
    MOVFF CODE0, COLOR1
    MOVFF GUESS0, FB1  
    MOVLW H'0F'
    ANDWF COLOR1, F
    ANDWF FB1, F
    
    ; unpack third bype of code/guess
    MOVFF CODE1, COLOR2
    MOVFF GUESS1, FB2
    MOVLW H'F0'
    ANDWF COLOR2, F
    RRCF COLOR2, F
    RRCF COLOR2, F
    RRCF COLOR2, F
    RRCF COLOR2, F
    ANDWF FB2, F
    RRCF FB2, F
    RRCF FB2, F
    RRCF FB2, F
    RRCF FB2, F
    
    ; unpack forth bype of code/guess
    MOVFF CODE1, COLOR3
    MOVFF GUESS1, FB3  
    MOVLW H'0F'
    ANDWF COLOR3, F
    ANDWF FB3, F
    
    ; count the blacks and whites
    BLACKS EQU 0x030
    WHITES EQU 0x031
    CLRF BLACKS
    CLRF WHITES
    
BLACK_CHECK3
    MOVF FB3, W
    CPFSEQ COLOR3
    GOTO BLACK_CHECK2
    INCF BLACKS
    BSF FB3, 7
    BSF COLOR3, 7
    
BLACK_CHECK2
    MOVF FB2, W
    CPFSEQ COLOR2
    GOTO BLACK_CHECK1
    INCF BLACKS
    BSF FB2, 7
    BSF COLOR2, 7
    
BLACK_CHECK1
    MOVF FB1, W
    CPFSEQ COLOR1
    GOTO BLACK_CHECK0
    INCF BLACKS
    BSF FB1, 7
    BSF COLOR1, 7
    
BLACK_CHECK0
    MOVF FB0, W
    CPFSEQ COLOR0
    GOTO WHITE_CHECK0
    INCF BLACKS
    BSF FB0, 7
    BSF COLOR0, 7

WHITE_CHECK3
    ; check for color matches if this guess hasn't been counted as a white
    BTFSC FB3, 7
    GOTO WHITE_CHECK2
    MOVF FB3, W
    ; skip this color if it was counted as a black
    BTFSC COLOR2, 7
    GOTO WHITE_CHECK3_1
    CPFSEQ COLOR2
    GOTO WHITE_CHECK3_1
    INCF WHITES
    BSF COLOR2, 7
    GOTO WHITE_CHECK2
    
WHITE_CHECK3_1
    BTFSC COLOR1, 7
    GOTO WHITE_CHECK2
    B

WHITE_CHECK3_0   

WHITE_CHECK2
    BTFSS FB2, 7
    GOTO WHITE_CHECK1
    
WHITE_CHECK1
    BTFSS FB1, 7
    GOTO WHITE_CHECK0
    
WHITE_CHECK0
    BTFSS FB0, 7
    GOTO FEEDBACK_END
    
FEEDBACK_END
 
    GOTO $                          ; loop forever     
    END