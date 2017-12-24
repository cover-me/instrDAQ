# instrDAQ
## Description
* Acquire data from a group of instruments after triggering a continuous or discrete sweep from one of them.

  * A continuous sweep sweeps a continous output such as a magnetic field. The sweep is done by instruments themselves and a command is needed to pause it.
  
  * A discrete sweep sweeps a discrete output such as a gate vlotage. The sweep is done by the program and a the value of output jumps discretely.
    
* Sweep multiple outputs simultaneously by this program is possible, if you put some magic strings in the file "Model" or work with a wrapper program (write it yourself). Another choice is use to other programs, such as qtlab, a python-based data acquisition program.
## Table of Contents
* [Overview](#ovw)
* [How to](#how2)

## <a name="ovw">Overview</a>

![set up](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/setup.jpg)
![schematic](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/schematic.png)
![snapshot-Main.vi](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/snapshot-main.png)
![snapshot-AcquisitionMain.vi](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/snapshot-acquisition.png)

## <a name="how2">How to</a>
### Install
* Download the whole project and open it with LabVIEW 8.6 or later versions.
* Use the program by running main.vi or compiling it into an exe. The former method enables one to run the program on a Mac even if it was developed on a PC. The latter method enables one to run the program in a computer without LabVIEW installed.
* Make sure NI-VISA and other device drivers (such as NI-4882) have been installed.
### Read data from instruments, such as an SR830 lock-in amplifier or a 2400 sourcemeter
* Connect instruments to your computer. Check the connection by sending simple commands. Many instruments would response to the command `*IDN?`, which queries the instrument identifications. You can know instruments by reading their manuals.
* Find out the command for taking data. Commands you need are usually listed somewhere in the manuals. For SR830, the command returning x and y is `SNAP?1,2`.
* Add the following code to the file "Model". You can run main.vi or exe without a Model file, they will generate an empty one, usually in the same folder but sometimes in the parent folder (depends on LabVIEW versions and operating systems).
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
Make sure there are two other files, named "config.ini" and "instrGroup1", in the sample file as "Model". If they don't exist, create them. Write the following code into "config.ini":
```
[config]
instrGroup=instrGroup1
user=user1,user2
```
The code specifies a file name (which is "instrGroup1" here) for the program to get address information of instruments and specifies user names ("user1" and "user2"). 

Add the following code to the file "instrGroup1".
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
Replace the addresses ([GPIB0::1::INSTR]) with correct ones. Run the program. The program will try sending `*IDN?` to each address listed here to check whether an instrument is powered on and whether the _Model_ specified in "instrGroup1" is correct. A check is passed if there is a response and the response contains the _CheckStr_. The instrument will then be listed in the front panel of the program. If you don't want a check or if the instrument wouldn't response to `*IDN?`, just delete that line (CheckStr=\*\*\*) in "Model".  

_RdCmd_ is the command querying readings.

_RdName_ is the name of readings. If there are multiple readings returned by one command, seperate them with "&".

_Alias_ is used to replace the "#" in _RdName_.

### Add more than one commands in a single Model
*   Just seperate them with "/", 6221 current source for example,
```
[6221]
CheckStr=6221
RdName=#_I/#_V&#_time
RdCmd=:SOUR:CURR?/:SENSE:DATA?
```
### Ramp the output, for example, from an voltage source or magnet power supply.
*	If the ramping requires you sending commands at each loop, add `SwpAvl=FALSE` in corresponding model. For example, if you want ramp the output of a sourcemeter from 0V to 1V, step=0.1V, you should send 11 commands. The program of ramping runs in the computer rather than in the instruments.  The _OutName_ should begin with a name existing in _RdName_, followed by a ":" and then whatever else. The program determines the value of the output by readings with the name before ":". The ramping stops when your setting is reached or a stop bottom is pressed. The "#" in _OutCmd_ will be replaced with real numbers in each loop. Following are examples for 2400 and 2600 series SourceMeter.
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
Add a line like the following to the corresponding model
```
AdvPara = [init cmd],[echo/baud rate/data bits/parity/stop bits],[terminator/multiline?],[count/offset]
```
Each parameter, seperated by `,` or `/` on the right side of the `=`, can be left empty if default value is desired. For example, `AdvPara = ,////,/,/` will set all advanced parameters to their default values.
A rightmost `/` in square brackets or a rightmost `,` can be omitted. For example, `,////,/,/` equals to `,///,,` equals to `,,,` equals to `,,` equals to an empty string. `,////,/,/0` does not equal to `,////,/,0` since the sixth `/` is not rightmost.
* `init cmd`: A command which will send to the instrument during the initialization. Since `,` has its special meaning in `AdvPara`, an `init cmd` containing `,` would lead to errors in current version. 
* `echo`: 0 if no command echoes. 1 if the command for reading data echoes. 2 if the command for setting echoes. 3 if both commands echo. If a command echoes, you should read for an extra time before getting the desired response.
* `baud rate/data bits/parity/stop bits`: Parameters for a serial port. Valid only if the interface type is the serial port and these 4 parameters and `echo` are all not empty.
* `terminator`: Terminator of commands. 
* `multiline?`: By default, commands sent to the same instrument will be packed into one string, seperated by `;`. Add something like `AdvPara=,,/FALSE` to avoid packing.
* `count`: Number of bytes read by the `VISA Read` function. Valid only if >128.
* `offset`: The program converts every number in a string returned by the `VISA Read` function. Use `offset` to intercepts a portion of the string.
### Sweeping command with two parameters
The `Step` on the program interface can be used as a second parameter for `OutCmd` when the value of `SwpAvl` is `TRUE` and there is a `##` in `OutCmd`. The `#` in `OutCmd` will be replaced with `To` and the `##` with `Step`.
### a read command returns too many readings
`RdName=name{n}` equals to `RdName=name1&name2&name3...$namen`
### Delay after executing a command
`cmd@seconds@message`

For example, we can set the `OutCmd` of the Oxford's VRM as `SET:SYS:VRM:RVST:MODE:RATE:RATE:0.1:VSET:[# 0 ##]@5@seting parameters...`
### Add a model that don't support VISA read and write
Write a wrapper program like this https://github.com/cover-me/tcp-visa-server. Communicate with the wrapper function using `VISA read` and `VISA write`.

...
