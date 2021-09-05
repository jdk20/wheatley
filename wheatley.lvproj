<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="15008000">
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
		<Item Name="audio-discrimination-task.vi" Type="VI" URL="../audio-discrimination-task.vi"/>
		<Item Name="main.vi" Type="VI" URL="../main.vi"/>
		<Item Name="states-enum.ctl" Type="VI" URL="../states-enum.ctl"/>
		<Item Name="write-log.vi" Type="VI" URL="../write-log.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Acquire Semaphore.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Acquire Semaphore.vi"/>
				<Item Name="AddNamedSemaphorePrefix.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/AddNamedSemaphorePrefix.vi"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Close File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Close File+.vi"/>
				<Item Name="compatReadText.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatReadText.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="ex_CorrectErrorChain.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/ex_CorrectErrorChain.vi"/>
				<Item Name="Find First Error.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find First Error.vi"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="General Error Handler Core CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler Core CORE.vi"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="GetNamedSemaphorePrefix.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/GetNamedSemaphorePrefix.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="High Resolution Relative Seconds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/High Resolution Relative Seconds.vi"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="LVRectTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVRectTypeDef.ctl"/>
				<Item Name="NI_AALBase.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALBase.lvlib"/>
				<Item Name="Not A Semaphore.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Not A Semaphore.vi"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Obtain Semaphore Reference.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Obtain Semaphore Reference.vi"/>
				<Item Name="Open File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Open File+.vi"/>
				<Item Name="Read Delimited Spreadsheet (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Delimited Spreadsheet (DBL).vi"/>
				<Item Name="Read Delimited Spreadsheet (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Delimited Spreadsheet (I64).vi"/>
				<Item Name="Read Delimited Spreadsheet (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Delimited Spreadsheet (string).vi"/>
				<Item Name="Read Delimited Spreadsheet.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Delimited Spreadsheet.vi"/>
				<Item Name="Read File+ (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read File+ (string).vi"/>
				<Item Name="Read Lines From File (with error IO).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Lines From File (with error IO).vi"/>
				<Item Name="Release Semaphore Reference.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Release Semaphore Reference.vi"/>
				<Item Name="Release Semaphore.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Release Semaphore.vi"/>
				<Item Name="RemoveNamedSemaphorePrefix.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/RemoveNamedSemaphorePrefix.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Semaphore RefNum" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Semaphore RefNum"/>
				<Item Name="Semaphore Refnum Core.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Semaphore Refnum Core.ctl"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="Simple Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Simple Error Handler.vi"/>
				<Item Name="subFile Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/express/express input/FileDialogBlock.llb/subFile Dialog.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="Validate Semaphore Size.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/semaphor.llb/Validate Semaphore Size.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
			</Item>
			<Item Name="Aipuff-Pulse.vi" Type="VI" URL="../Device/Methods/Aipuff-Pulse.vi"/>
			<Item Name="Airpuff- Square sequence.ctl" Type="VI" URL="../Device/Typedefs/Airpuff- Square sequence.ctl"/>
			<Item Name="Airpuff-Init.vi" Type="VI" URL="../Device/Methods/Airpuff-Init.vi"/>
			<Item Name="All Reservations.vi" Type="VI" URL="../Rack/Methods/Helper subVIs/All Reservations.vi"/>
			<Item Name="AnalogOutput Interface SineSequence.vi" Type="VI" URL="../Rack/Device interfaces/AnalogOutput Interface SineSequence.vi"/>
			<Item Name="AnalogOutput Interface SquareSequence.vi" Type="VI" URL="../Rack/Device interfaces/AnalogOutput Interface SquareSequence.vi"/>
			<Item Name="AnalogOutput Interface.vi" Type="VI" URL="../Rack/Device interfaces/AnalogOutput Interface.vi"/>
			<Item Name="AnalogOutput Reservations.vi" Type="VI" URL="../Rack/Device interfaces/AnalogOutput Reservations.vi"/>
			<Item Name="AnalogOutput-Configuration.ctl" Type="VI" URL="../Rack/Methods/Port drivers/AnalogOutput-Configuration.ctl"/>
			<Item Name="AnalogOutput-Start.vi" Type="VI" URL="../Rack/Methods/Port drivers/AnalogOutput-Start.vi"/>
			<Item Name="AnalogOutput_SineSequence.ctl" Type="VI" URL="../Rack/Typedefs/AnalogOutput_SineSequence.ctl"/>
			<Item Name="AnalogOutput_SquareSequence.ctl" Type="VI" URL="../Rack/Typedefs/AnalogOutput_SquareSequence.ctl"/>
			<Item Name="DataSocketOutput-Configuration.ctl" Type="VI" URL="../Rack/Methods/Port drivers/DataSocketOutput-Configuration.ctl"/>
			<Item Name="DataSocketOutput-Start.vi" Type="VI" URL="../Rack/Methods/Port drivers/DataSocketOutput-Start.vi"/>
			<Item Name="Device.vi" Type="VI" URL="../Device/Device.vi"/>
			<Item Name="DigitalInput Interface.vi" Type="VI" URL="../Rack/Device interfaces/DigitalInput Interface.vi"/>
			<Item Name="DigitalInput Reservations.vi" Type="VI" URL="../Rack/Device interfaces/DigitalInput Reservations.vi"/>
			<Item Name="DigitalInput-Configuration.ctl" Type="VI" URL="../Rack/Methods/Port drivers/DigitalInput-Configuration.ctl"/>
			<Item Name="DigitalInput-DataCluster.ctl" Type="VI" URL="../Rack/Methods/Port drivers/DigitalInput-DataCluster.ctl"/>
			<Item Name="DigitalInput-Driver.vi" Type="VI" URL="../Rack/Methods/Port drivers/DigitalInput-Driver.vi"/>
			<Item Name="DigitalOutput Interface.vi" Type="VI" URL="../Rack/Device interfaces/DigitalOutput Interface.vi"/>
			<Item Name="DigitalOutput Reservations.vi" Type="VI" URL="../Rack/Device interfaces/DigitalOutput Reservations.vi"/>
			<Item Name="DigitalOutput-Configuration.ctl" Type="VI" URL="../Rack/Methods/Port drivers/DigitalOutput-Configuration.ctl"/>
			<Item Name="DigitalOutput-Start.vi" Type="VI" URL="../Rack/Methods/Port drivers/DigitalOutput-Start.vi"/>
			<Item Name="Does line exist.vi" Type="VI" URL="../Rack/Methods/Helper subVIs/Does line exist.vi"/>
			<Item Name="Door-Close.vi" Type="VI" URL="../Device/Methods/Door-Close.vi"/>
			<Item Name="Door-Init.vi" Type="VI" URL="../Device/Methods/Door-Init.vi"/>
			<Item Name="Door-Open.vi" Type="VI" URL="../Device/Methods/Door-Open.vi"/>
			<Item Name="Door.ctl" Type="VI" URL="../Device/Typedefs/Door.ctl"/>
			<Item Name="EventLogger-Init.vi" Type="VI" URL="../Device/Methods/EventLogger-Init.vi"/>
			<Item Name="EventLogger-Write.vi" Type="VI" URL="../Device/Methods/EventLogger-Write.vi"/>
			<Item Name="EventLogger.ctl" Type="VI" URL="../Device/Typedefs/EventLogger.ctl"/>
			<Item Name="Eyeblinker-Go.vi" Type="VI" URL="../Device/Methods/Eyeblinker-Go.vi"/>
			<Item Name="Eyeblinker-Init.vi" Type="VI" URL="../Device/Methods/Eyeblinker-Init.vi"/>
			<Item Name="Eyeblinker.ctl" Type="VI" URL="../Device/Typedefs/Eyeblinker.ctl"/>
			<Item Name="FileOutput-Configuration.ctl" Type="VI" URL="../Rack/Methods/Port drivers/FileOutput-Configuration.ctl"/>
			<Item Name="FileOutput-Start.vi" Type="VI" URL="../Rack/Methods/Port drivers/FileOutput-Start.vi"/>
			<Item Name="HandlerCounter.vi" Type="VI" URL="../Rack/Methods/Helper subVIs/HandlerCounter.vi"/>
			<Item Name="InputData cluster.ctl" Type="VI" URL="../Rack/Typedefs/InputData cluster.ctl"/>
			<Item Name="Juicer-ChangeMode.vi" Type="VI" URL="../Device/Methods/Juicer-ChangeMode.vi"/>
			<Item Name="Juicer-Init.vi" Type="VI" URL="../Device/Methods/Juicer-Init.vi"/>
			<Item Name="Juicer.ctl" Type="VI" URL="../Device/Typedefs/Juicer.ctl"/>
			<Item Name="Lickometer-Init.vi" Type="VI" URL="../Device/Methods/Lickometer-Init.vi"/>
			<Item Name="Lickometer-Read.vi" Type="VI" URL="../Device/Methods/Lickometer-Read.vi"/>
			<Item Name="Lickometer-Stop.vi" Type="VI" URL="../Device/Methods/Lickometer-Stop.vi"/>
			<Item Name="Lickometer.ctl" Type="VI" URL="../Device/Typedefs/Lickometer.ctl"/>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
			<Item Name="nilvaiu.dll" Type="Document" URL="nilvaiu.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="OutputRequest refnum.ctl" Type="VI" URL="../Rack/Typedefs/OutputRequest refnum.ctl"/>
			<Item Name="OutputRequest.ctl" Type="VI" URL="../Rack/Typedefs/OutputRequest.ctl"/>
			<Item Name="Port table entry.ctl" Type="VI" URL="../Rack/Typedefs/Port table entry.ctl"/>
			<Item Name="Port table lookup.vi" Type="VI" URL="../Rack/Device interfaces/Port table lookup.vi"/>
			<Item Name="Port table.vi" Type="VI" URL="../Setup-specific/Port table.vi"/>
			<Item Name="Rack driver configuration cluster.ctl" Type="VI" URL="../Rack/Typedefs/Rack driver configuration cluster.ctl"/>
			<Item Name="Rack-Config.vi" Type="VI" URL="../Rack/Methods/Rack-Config.vi"/>
			<Item Name="Rack-Init.vi" Type="VI" URL="../Rack/Methods/Rack-Init.vi"/>
			<Item Name="Rack-Refresh.vi" Type="VI" URL="../Rack/Methods/Rack-Refresh.vi"/>
			<Item Name="Rack-Start.vi" Type="VI" URL="../Rack/Methods/Rack-Start.vi"/>
			<Item Name="Rack-Stop.vi" Type="VI" URL="../Rack/Methods/Rack-Stop.vi"/>
			<Item Name="Rack.vi" Type="VI" URL="../Rack/Rack.vi"/>
			<Item Name="Reservation exit codes.ctl" Type="VI" URL="../Rack/Typedefs/Reservation exit codes.ctl"/>
			<Item Name="Speaker - Sine sequence.ctl" Type="VI" URL="../Device/Typedefs/Speaker - Sine sequence.ctl"/>
			<Item Name="Speaker-Init.vi" Type="VI" URL="../Device/Methods/Speaker-Init.vi"/>
			<Item Name="Speaker-Play.vi" Type="VI" URL="../Device/Methods/Speaker-Play.vi"/>
			<Item Name="Speaker-PlaySequence.vi" Type="VI" URL="../Device/Methods/Speaker-PlaySequence.vi"/>
			<Item Name="Speaker.ctl" Type="VI" URL="../Device/Typedefs/Speaker.ctl"/>
			<Item Name="states.ctl" Type="VI" URL="../states.ctl"/>
			<Item Name="status.ctl" Type="VI" URL="../status.ctl"/>
			<Item Name="Timestamp Interface.vi" Type="VI" URL="../Rack/Device interfaces/Timestamp Interface.vi"/>
			<Item Name="Timestamp Reservations.vi" Type="VI" URL="../Rack/Device interfaces/Timestamp Reservations.vi"/>
			<Item Name="Valve-Close.vi" Type="VI" URL="../Device/Methods/Valve-Close.vi"/>
			<Item Name="Valve-Init.vi" Type="VI" URL="../Device/Methods/Valve-Init.vi"/>
			<Item Name="Valve-Open.vi" Type="VI" URL="../Device/Methods/Valve-Open.vi"/>
			<Item Name="Valve-Pulse.vi" Type="VI" URL="../Device/Methods/Valve-Pulse.vi"/>
			<Item Name="Valve.ctl" Type="VI" URL="../Device/Typedefs/Valve.ctl"/>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
