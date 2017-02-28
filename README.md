# instrDAQ
## Description
Acquiring data from a group of instruments while triggering a continuous or step scan from one of them.
## Table of Contents
* [Overview](#ovw)
* [How to](#how2)

## <a name="ovw">Overview</a>

![set up](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/setup.jpg)
![schematic](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/schematic.png)
![snapshot-Main.vi](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/snapshot-main.png)
![snapshot-AcquisitionMain.vi](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/snapshot-acquisition.png)

## <a name="how2">How to</a>

### Read data from instruments, like an SR830 lock-in amplifiers or a 2400 SourceMeter
* After installing required drivers for GPIB (or other interfaces) and NI-VISA, connet the instruments to your computer. Check the connection by sending a simple command to the instruments. Most instruments support the command `*IDN?` which will query the identify of the instruments.
* Find out the command for readings in the manual of the instruments. Usuanlly there is a chapter listing all the commands and their usages. For SR830, the command returning x and y is `SNAP?1,2`.
* Add the following code to the file "Model"
	```
	[SR830]
	CheckStr=830
	RdName=#d1&#d2
	RdCmd=SNAP?1,2
	[24xx_noout]
	CheckStr=24
	RdName=#_V&#_I&#_R&#_t&#_s
	RdCmd=:READ?
	```  
	and the following code to the file "instrGroup1"
	```
	[GPIB0::1::INSTR]
	Model=SR830
	Alias=L1
	[GPIB0::2::INSTR]
	Model=SR830
	Alias=L2
	[GPIB0::11::INSTR]
	Model=24xx
	Alias=smu1
	```
	Replace the addresses ([GPIB0::1::INSTR]) with correct ones. The program will try sending the command `*IDN?` to each address in file "instrGroup1" to check if the instrument has been turned on or the _Model_ in "instrGroup1" is correct, if _CheckStr_ of corresponding _Model_ is contained in the returning string, the instrument will be listed in the front panel of the program. If you don't want to check at or if the instrument doesn't support the command `*IDN?`, just delete that line (CheckStr=***) in file "Model".  
	_RdCmd_ is the command querying readings.  
	_RdName_ is the name for readings queried by _RdCmd_. If there are many readings returned by one command, seperate them with "&".
	The _Alias_ is used to replace the "#" in _RdName_.
### Add more than one commands in a single Model
*   Just seperate them with "/", 6221 current source for example,
	```
	[6221]
	CheckStr=6221
	RdName=#_I/#_V&#_time
	RdCmd=:SOUR:CURR?/:SENSE:DATA?
	```
### Ramp the output, for example, from an voltage source or magnet power supply.
*	If the ramping requires you to send commands at each loop, add `SwpAvl=FALSE` in corresponding model. For example, if you want ramp the output of a sourcemeter from 0V to 1V, step=0.1V, you should send 11 commands. The program of ramping runs in the computer rather than in the instruments.  The _OutName_ should begin with a name existing in _RdName_, followed by a ":" and then whatever else. The program determines the value of the output by the reading with the name before ":". The ramping stops when the that value reaches your setting or a stop bottom is pressed. The "#" in `OutCmd` will be replaced with real numbers in each loop. Following are examples for 2400 and 2600 series SourceMeter.
```
[24xx]
CheckStr=24
RdName=#_V&#_I&#_3&#_4&#_5
RdCmd=:READ?
SwpAvl=FALSE
OutName="#_V: (V)"
OutCmd=":SOUR:VOLT #"
[26xx]
CheckStr=26
RdName=#_I&#_V
RdCmd=printnumber(smua.measure.iv())
SwpAvl=FALSE
OutName="#_I: (A)/#_V: (V)"
OutCmd=smua.source.leveli=#/smua.source.levelv=#
```
* For instruments taking care of ramping themselves, you only need to send the command once before the loop. Set `SwpAvl=TRUE` in the model. Maybe you want add a command to pause the ramping, just leave it behind the ramping command and seperate them with "&". If no pausing command is provided, the ramping will continue after the program stopped, not a big problem for some instrumens. The following is an example of 4G and 625 magnet power supply
```
[4G]
CheckStr=4G
RdName="B (9T)/B (4T)"
RdCmd="CHAN 2;IMAG?/CHAN 1;IMAG?"
SwpAvl=TRUE
OutName="B (9T): Sweep Up/B (9T): Sweep Down/B (9T): Sweep Zero/B (4T): Sweep Up/B (4T): Sweep Down/B (4T): Sweep Zero"
OutCmd="CHAN 2;Sweep up slow&CHAN 2;Sweep pause slow/CHAN 2;Sweep down slow&CHAN 2;Sweep pause slow/CHAN 2;Sweep zero slow&CHAN 2;Sweep pause slow/CHAN 1;Sweep up slow&CHAN 1;Sweep pause slow/CHAN 1;Sweep down slow&CHAN 1;Sweep pause slow/CHAN 1;Sweep zero slow&CHAN 1;Sweep pause slow"
[625]
CheckStr=625
RdName="B (A)"
RdCmd=RDGI?
SwpAvl=TRUE
OutName="B (A): Ramping"
OutCmd="SETI #&STOP"
```
### Add a model that echos/require terminator/baud rate not 9600...
### Add a model that don't support VISA read and write
...