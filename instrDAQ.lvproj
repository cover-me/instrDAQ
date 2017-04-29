<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="8608001">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Control" Type="Folder">
			<Item Name="InstrInfo.ctl" Type="VI" URL="../Controls/InstrInfo.ctl"/>
			<Item Name="swpPara.ctl" Type="VI" URL="../Controls/swpPara.ctl"/>
			<Item Name="acqPara.ctl" Type="VI" URL="../Controls/acqPara.ctl"/>
			<Item Name="filePara.ctl" Type="VI" URL="../Controls/filePara.ctl"/>
			<Item Name="readPara.ctl" Type="VI" URL="../Controls/readPara.ctl"/>
		</Item>
		<Item Name="LoadInstrInfo" Type="Folder">
			<Item Name="getAllInstr.vi" Type="VI" URL="../VIs/getAllInstr.vi"/>
			<Item Name="chkAvlInstr.vi" Type="VI" URL="../VIs/chkAvlInstr.vi"/>
			<Item Name="getSampPara.vi" Type="VI" URL="../VIs/getSampPara.vi"/>
			<Item Name="toCommand.vi" Type="VI" URL="../VIs/toCommand.vi"/>
			<Item Name="readList.vi" Type="VI" URL="../VIs/readList.vi"/>
			<Item Name="swpList.vi" Type="VI" URL="../VIs/swpList.vi"/>
			<Item Name="getCmdPackage.vi" Type="VI" URL="../VIs/getCmdPackage.vi"/>
			<Item Name="id 2 cnt ofst.vi" Type="VI" URL="../VIs/id 2 cnt ofst.vi"/>
			<Item Name="instrIni.vi" Type="VI" URL="../VIs/instrIni.vi"/>
			<Item Name="toRdSwp.vi" Type="VI" URL="../VIs/toRdSwp.vi"/>
		</Item>
		<Item Name="Aquire" Type="Folder">
			<Item Name="AcquisitionMain.vi" Type="VI" URL="../VIs/AcquisitionMain.vi"/>
			<Item Name="getSelected.vi" Type="VI" URL="../VIs/getSelected.vi"/>
			<Item Name="calcSomeSamPara.vi" Type="VI" URL="../VIs/calcSomeSamPara.vi"/>
			<Item Name="toData.vi" Type="VI" URL="../VIs/toData.vi"/>
			<Item Name="toGraph.vi" Type="VI" URL="../VIs/toGraph.vi"/>
			<Item Name="keepPause.vi" Type="VI" URL="../VIs/keepPause.vi"/>
			<Item Name="keepSweep.vi" Type="VI" URL="../VIs/keepSweep.vi"/>
			<Item Name="isOutRange.vi" Type="VI" URL="../VIs/isOutRange.vi"/>
			<Item Name="myWrite.vi" Type="VI" URL="../VIs/myWrite.vi"/>
			<Item Name="getIndexOfField.vi" Type="VI" URL="../VIs/getIndexOfField.vi"/>
			<Item Name="SeqStr2SwpArr.vi" Type="VI" URL="../VIs/SeqStr2SwpArr.vi"/>
			<Item Name="Seq2file.vi" Type="VI" URL="../VIs/Seq2file.vi"/>
			<Item Name="Seq_fromfile.vi" Type="VI" URL="../VIs/Seq_fromfile.vi"/>
		</Item>
		<Item Name="Others" Type="Folder">
			<Item Name="Log.vi" Type="VI" URL="../VIs/Log.vi"/>
			<Item Name="splitStr.vi" Type="VI" URL="../VIs/splitStr.vi"/>
			<Item Name="ExtractNumbers.vi" Type="VI" URL="../VIs/ExtractNumbers.vi"/>
			<Item Name="myBeep.vi" Type="VI" URL="../VIs/myBeep.vi"/>
			<Item Name="myTTS.vi" Type="VI" URL="../VIs/myTTS.vi"/>
			<Item Name="handleExePath.vi" Type="VI" URL="../VIs/handleExePath.vi"/>
			<Item Name="generateSeq.vi" Type="VI" URL="../VIs/generateSeq.vi"/>
			<Item Name="wantContinue.vi" Type="VI" URL="../VIs/wantContinue.vi"/>
			<Item Name="saveImg.vi" Type="VI" URL="../VIs/saveImg.vi"/>
			<Item Name="Seq_advance.vi" Type="VI" URL="../VIs/Seq_advance.vi"/>
			<Item Name="replace-r-n.vi" Type="VI" URL="../VIs/replace-r-n.vi"/>
			<Item Name="spt mtl.vi" Type="VI" URL="../VIs/spt mtl.vi"/>
			<Item Name="id2term.vi" Type="VI" URL="../VIs/id2term.vi"/>
			<Item Name="myset.vi" Type="VI" URL="../VIs/myset.vi"/>
			<Item Name="myWrite(set).vi" Type="VI" URL="../VIs/myWrite(set).vi"/>
			<Item Name="wait4set.vi" Type="VI" URL="../VIs/wait4set.vi"/>
			<Item Name="plus1.vi" Type="VI" URL="../VIs/plus1.vi"/>
			<Item Name="id2echo.vi" Type="VI" URL="../VIs/id2echo.vi"/>
			<Item Name="addterm.vi" Type="VI" URL="../VIs/addterm.vi"/>
			<Item Name="filePara2Str.vi" Type="VI" URL="../VIs/filePara2Str.vi"/>
			<Item Name="rd name split.vi" Type="VI" URL="../VIs/rd name split.vi"/>
			<Item Name="clear interface.vi" Type="VI" URL="../VIs/clear interface.vi"/>
			<Item Name="setVItitle.vi" Type="VI" URL="../VIs/setVItitle.vi"/>
		</Item>
		<Item Name="main.vi" Type="VI" URL="../main.vi"/>
		<Item Name="Paramecium.ico" Type="Document" URL="../Paramecium.ico"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Beep.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/Beep.vi"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Escape Characters for HTTP.vi" Type="VI" URL="/&lt;vilib&gt;/printing/PathToURL.llb/Escape Characters for HTTP.vi"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="Open URL in Default Browser (path).vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser (path).vi"/>
				<Item Name="Open URL in Default Browser (string).vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser (string).vi"/>
				<Item Name="Open URL in Default Browser core.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser core.vi"/>
				<Item Name="Open URL in Default Browser.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/browser.llb/Open URL in Default Browser.vi"/>
				<Item Name="Path to URL.vi" Type="VI" URL="/&lt;vilib&gt;/printing/PathToURL.llb/Path to URL.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="Write JPEG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Write JPEG File.vi"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="Check Data Size.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Data Size.vi"/>
				<Item Name="Check Color Table Size.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Color Table Size.vi"/>
				<Item Name="Check Path.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Path.vi"/>
				<Item Name="Directory of Top Level VI.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Directory of Top Level VI.vi"/>
				<Item Name="Check File Permissions.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check File Permissions.vi"/>
				<Item Name="Get Section Names.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Get Section Names.vi"/>
				<Item Name="Config Data Registry.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Registry.vi"/>
				<Item Name="Config Data RefNum" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data RefNum"/>
				<Item Name="Config Data.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data.ctl"/>
				<Item Name="Config Data Section.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Section.ctl"/>
				<Item Name="Config Data Registry Functions.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Registry Functions.ctl"/>
				<Item Name="Close Config Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Close Config Data.vi"/>
				<Item Name="Config Data Get File Path.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Get File Path.vi"/>
				<Item Name="Config Data Write To File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Write To File.vi"/>
				<Item Name="Config Data to String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data to String.vi"/>
				<Item Name="Add Quotes.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Add Quotes.vi"/>
				<Item Name="Config Data Close Reference.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Close Reference.vi"/>
				<Item Name="Read Key.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Read Key.vi"/>
				<Item Name="Read Key (Boolean).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Read Key (Boolean).vi"/>
				<Item Name="Config Data Get Key Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Get Key Value.vi"/>
				<Item Name="Read Key (Double).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Read Key (Double).vi"/>
				<Item Name="Read Key (I32).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Read Key (I32).vi"/>
				<Item Name="Read Key (Path).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Read Key (Path).vi"/>
				<Item Name="Remove Quotes.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Remove Quotes.vi"/>
				<Item Name="Common Path to Specific Path.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Common Path to Specific Path.vi"/>
				<Item Name="Read Key (String).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Read Key (String).vi"/>
				<Item Name="Parse Stored String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Parse Stored String.vi"/>
				<Item Name="Get Next Character.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Get Next Character.vi"/>
				<Item Name="Read Key (U32).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Read Key (U32).vi"/>
				<Item Name="Merge Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Merge Errors.vi"/>
				<Item Name="Open Config Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Open Config Data.vi"/>
				<Item Name="Config Data Open Reference.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Open Reference.vi"/>
				<Item Name="Config Data Set File Path.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Set File Path.vi"/>
				<Item Name="Config Data Modify.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Modify.vi"/>
				<Item Name="Info From Config Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Info From Config Data.vi"/>
				<Item Name="Config Data Modify Functions.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Modify Functions.ctl"/>
				<Item Name="Config Data Read From File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Config Data Read From File.vi"/>
				<Item Name="String to Config Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/String to Config Data.vi"/>
				<Item Name="Invalid Config Data Reference.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/Invalid Config Data Reference.vi"/>
			</Item>
		</Item>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="instrDAQ" Type="EXE">
				<Property Name="App_applicationGUID" Type="Str">{EE339B11-65C2-4882-BBB2-1E5ED2D33AF3}</Property>
				<Property Name="App_applicationName" Type="Str">instrDAQ.exe</Property>
				<Property Name="App_autoIncrement" Type="Bool">true</Property>
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_fileDescription" Type="Str">Acquiring data from a group of instruments while triggering a continuous or step scan from one of them.</Property>
				<Property Name="App_fileVersion.build" Type="Int">68</Property>
				<Property Name="App_fileVersion.major" Type="Int">4</Property>
				<Property Name="App_fileVersion.patch" Type="Int">8</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{801F3DA2-4E5F-428F-9557-69571BB4B120}</Property>
				<Property Name="App_INI_GUID" Type="Str">{4CA434A9-A95B-43C8-BFBB-99A791D5AC9E}</Property>
				<Property Name="App_internalName" Type="Str">instrDAQ</Property>
				<Property Name="App_legalCopyright" Type="Str">cover-me</Property>
				<Property Name="App_productName" Type="Str">instrDAQ</Property>
				<Property Name="App_serverConfig.httpPort" Type="Int">8002</Property>
				<Property Name="Bld_buildSpecName" Type="Str">instrDAQ</Property>
				<Property Name="Bld_defaultLanguage" Type="Str">ChineseS</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Destination[0].destName" Type="Str">instrDAQ.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/instrDAQ/NI_AB_PROJECTNAME/internal.llb</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/instrDAQ/NI_AB_PROJECTNAME/data</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Exe_iconItemID" Type="Ref">/My Computer/Paramecium.ico</Property>
				<Property Name="Source[0].itemID" Type="Str">{0515D036-B2D1-46FA-82F5-146BC3547753}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/main.vi</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="SourceCount" Type="Int">2</Property>
			</Item>
		</Item>
	</Item>
</Project>
