# instrDAQ
## Description
* This program acquires data from a group of instruments after triggering a continuous or discrete sweep from one of them.

  * A continuous sweep sweeps a continuous output such as a magnetic field or the time. The sweep is done by _instruments_, the program only triggers it. A command is required if one needs to pause the sweep.
  
  * A discrete sweep sweeps a discrete, or step-by-step output such as gate voltages and source-drain voltages. _The program_, instead of the instrument, is responsible for a discrete sweep. The former sends commands to the latter one by one, setting the output step-by-step.
  
  * 2D or 3D scan can be made with a sweep sequence.
  
  * More complicated sweeps are possible. You may need to write your wrapper program to wrap complicated sweeps or trying other programs such as qtlab (an open-source python-based data acquisition program). The combination of qtlab and qtplot (visualize 1d, 2d and slices of 3d data, perform mathematical filters...) is awesome. I have two videos [here](https://cover-me.github.io/2019/03/31/qtplot-demo.html) showing how they work.

* The program communicates with instruments by VISA

  * VISA behaviors like a translator who speaks all languages. With VISA, commands can be sent to or read from instruments with any interfaces, by the same VISA functions. One can simply use VISA write and VISA read functions to communicate with instruments through serial, GPIB, Ethernet or USB ports. Low-level drivers, which should be provided by instrument providers, may still be required.

  * Instrument parameters such as addresses, commands, and interface-parameters are collected in text files. New-instrument support can be done without changing the program itself!

## Table of Contents
* [Overview](#ovw)
* [How to](#how2)
* [Known problems](#np)
* [Further reading](#fr)

## <a name="ovw">Overview</a>

![set up](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/setup.jpg)
![schematic](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/schematic.png)
![snapshot-Main.vi](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/snapshot-main.png)
![snapshot-AcquisitionMain.vi](https://github.com/cover-me/instrDAQ/blob/master/documentation/images/snapshot-acquisition.png)

## <a name="how2">How to</a>
### Install
* Download the whole project and open it with LabVIEW 8.6 or newer versions.
* Run main.vi or compile it into a .exe. The former enables one to run the program on a Mac even if it was developed on a PC. The latter enables one to run the program on a computer without LabVIEW (but LabVIEW runtime is required).
* Make sure NI-VISA and other device drivers (such as NI-4882) have been installed.
### Read data from instruments, such as an SR830 lock-in amplifier or a 2400 sourcemeter
* Connect instruments to your computer. Check the connection by sending simple commands. Many instruments would respond to the command `*IDN?`, which queries the instrument identifications. Be familiar with your instruments by reading manuals.
* Find the command for taking data. Commands you need should be listed somewhere in manuals. For SR830, the command returning x and y readings is `SNAP?1,2`.
* Add the following code to the file "Model". This is the file stores parameters for different instrument models. You can run main.vi or .exe without a Model file, they will generate an empty one, usually in the same folder but sometimes in the parent folder (depends on LabVIEW versions and operating systems).
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
Make sure there are two other files, named "config.ini" and "instrGroup1", in the same folder as "Model". If they don't exist, create them. Copy the following code to "config.ini":
```
[config]
instrGroup=instrGroup1
user=user1,user2
```
The code above specifies the file name "instrGroup1" for the program to get more information and user names ("user1" and "user2") in the lab. 

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
Replace the addresses ([GPIB0::1::INSTR]) with correct ones. Run the program. The program will try sending `*IDN?` to each address listed here to check whether that instrument is powered on and whether the _Model_ specified in "instrGroup1" is correct. A check is passed if there is a response and the response contains the _CheckStr_ in file "Model". The instrument will then be listed in the front panel of the program. If you don't want a check or if the instrument wouldn't resopnd to `*IDN?`, just delete that line (CheckStr=\*\*\*) in file "Model".  

_RdCmd_ is the command querying readings.

_RdName_ is the name of the readings. If there are multiple readings returned by one command, separate names with "&".

_Alias_ is used to replace the "#" in _RdName_.

### Add more than one commands in a single Model
*   Just separate them with "/", the 6221 current source, for example,
```
[6221]
CheckStr=6221
RdName=#_I/#_V&#_time
RdCmd=:SOUR:CURR?/:SENSE:DATA?
```
### Sweep the output, for example, of a voltage source or a magnet power supply.
*    If the scan requires you keep sending commands at every loop (a discrete sweep), add `SwpAvl=FALSE` in the corresponding model. For example, if you want to sweep the output of a sourcemeter from 0V to 1V with step=0.1V, you need to send commands for 11 times. The san is controlled by the computer rather than the instrument.  The _OutName_ should begin with a name existing in _RdName_, followed by a ":" and then whatever else. The program determines the value of the output by readings who has the name before ":", instead of the setting value sent by the computer. The scan stops when the destination is reached or a stop bottom is pressed (for continuous sweeps, the pause command should be provided in file Model). The "#" in _OutCmd_ will be replaced with real numbers to set the output. The following is an example for 2400 and 2600 series SourceMeters with outputs.
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
* For instruments taking care of ramping themselves (continuous sweeps), you only need to send the command once before the scan starts. Set `SwpAvl=TRUE` in the model. It's a good idea to add a command for pausing in case you want to pause the ramping in the middle. Just leave the pause command behind the ramping command and separate them with "&". If no pausing command is provided, the ramping will may continue after the program stopped, maybe not a big issue in some cases. The following is an example for 4G and 625 magnet power supplies
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
### Add a model that echos/require a terminator/baud rate not 9600...
Add a line like the following to the corresponding model
```
AdvPara = [init cmd],[echo/baud rate/data bits/parity/stop bits],[terminator/multiline?],[count/offset]
```
Each parameter, seperated by `,` or `/` on the right side of the `=`, can be left empty if default value is desired. For example, `AdvPara = ,////,/,/` will set all advanced parameters to their default values.
A rightmost `/` in square brackets or a rightmost `,` can be omitted. For example, `,////,/,/` equals to `,///,,` equals to `,,,` equals to `,,` equals to an empty string. `,////,/,/0` does not equal to `,////,/,0` since the sixth `/` is not rightmost.
* `init cmd`: The command which will send to the instrument during the initialization step. Since `,` has its special meaning in `AdvPara`, an `init cmd` containing `,` would lead to errors in the current version.
* `echo`: 0 if no command echoes. 1 if commands for reading data echo. 2 if the commands for setting echo. 3 if both kinds of command echo. If a command echoes, you need to read for one extra time before getting the desired response.
* `baud rate/data bits/parity/stop bits`: Parameters for a serial port. Valid only if the interface type is the serial port and these 4 parameters and `echo` are all not empty.
* `terminator`: Terminator of commands. 
* `multiline?`: By default, commands sent to the same instrument will be packed into one string, seperated by `;`. Add something like `AdvPara=,,/FALSE` to avoid packing.
* `count`: Number of bytes read by the `VISA Read` function. Valid only if >128.
* `offset`: The program converts every number in a string returned by the `VISA Read` function. Use `offset` to intercepts a portion of the string.
### Sweep with commands requiring two parameters
The `Step` on the program interface can be used as a second parameter for `OutCmd` when the value of `SwpAvl` is `TRUE` and there is a `##` in `OutCmd`. The `#` in `OutCmd` will be replaced with `To` and the `##` with `Step`. It is useful for a vector magnet.
### a reading command returns many readings
Use `RdName=name{n}`, which equals to `RdName=name1&name2&name3...$namen`
### Delay after executing a command
`cmd@seconds@message`

For example, we can set the `OutCmd` of the Oxford's VRM as `SET:SYS:VRM:RVST:MODE:RATE:RATE:0.1:VSET:[# 0 ##]@5@seting parameters...`
### Add a model that doesn't talk to VISA read and write
Write a wrapper program like this https://github.com/cover-me/tcp-visa-server. Communicate with the wrapper function using `VISA read` and `VISA write`. It's useful for PPMS systems.

...
## <a name="np">Known problems</a>
A typical GPIB instrument may take tens of milliseconds to prepare its data. To minimize the time of waiting, the program sends commands to all instruments before reading any replies, instead of fetching data from instruments one by one. Sometimes one needs to send multiple commands to one instrument for multiple readings. If the instrument works well with multiple commands in one line like `cmd1;cmd2;cmd3`, which is usually the case, everything is fine. Else, if the instrument only receives commands one by one, but you can read all results by a single reading, it is still fine, just set `multiline?'` to False. Else (very rare), you can download the branch "stable_write1_read1", which fetches data from instruments one by one and command by command.

Another solution is to modify the code. Add a switch disabling the termination characters when `count` is nonzero and calculate the exact bytes returned...

## <a name="fr">Further reading</a>

* [A prototype for data taking programs](https://cover-me.github.io/2020/01/11/A-prototype-for-data-taking-programs.html)
