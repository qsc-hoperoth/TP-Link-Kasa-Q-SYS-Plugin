rapidjson = require("rapidjson")

NumberOfDevices = Properties["Number Of Devices"].Value

DebugTx, DebugRx, DebugFunction = false, false, false
DebugPrint = Properties["Debug Print"].Value
if DebugPrint == "Tx/Rx" then
  DebugTx, DebugRx = true, true
elseif DebugPrint == "Tx" then
  DebugTx = true
elseif DebugPrint == "Rx" then
  DebugRx = true
elseif DebugPrint == "Function Calls" then
  DebugFunction = true
elseif DebugPrint == "All" then
  DebugTx, DebugRx, DebugFunction = true, true, true
end

StatusState = {OK = 0, COMPROMISED = 1, FAULT = 2, NOTPRESENT = 3, MISSING = 4, INITIALIZING = 5}

--[[ #include "KasaEncryption.lua" ]]
--[[ #include "Discovery.lua" ]]
Sockets = {}
Timers = {}
FaderDebounce = {}
local PollTime = 5

for x = 1, NumberOfDevices do
  table.insert(Sockets, TcpSocket.New())
  table.insert(Timers, Timer.New())
  table.insert(FaderDebounce, Timer.New())

  Timers[x].EventHandler = function()
    DevicePoll(x)
  end
  Sockets[x].EventHandler = function(socket, event, err)
    -- print(event)
    if event == TcpSocket.Events.Data then
      data = socket:Read(socket.BufferLength)
      jsonData, err = decode(data)
      if err == nil then
        if jsonData.system then
          if jsonData.system.get_sysinfo then
            if jsonData.system.get_sysinfo.err_code == 0 then
              Controls["Device_" .. x .. "_Status"].Value = 0 --ok
              Controls["Device_" .. x .. "_Status"].String = ""
            end
            parseGetInfo(x, jsonData.system.get_sysinfo)
          elseif jsonData.system.set_relay_state then
            DevicePoll(x)
          end
        elseif jsonData["smartlife.iot.dimmer"] then
        -- Poll()
        end
      else
        print("JSON Err:", err)
        print(decodeToString(data))
        Controls["Device_" .. x .. "_Status"].Value = 2 --fault
        Controls["Device_" .. x .. "_Status"].String = "JSON Error: ", err
      end
    elseif event == TcpSocket.Events.Connected then
      DevicePoll(x)
      Timers[x]:Start(PollTime)
    else
      Timers[x]:Stop()
      Controls["Device_" .. x .. "_Status"].Value = 4 --missing
      Controls["Device_" .. x .. "_Status"].String = event
    end
  end

  Controls["Device_" .. x .. "_IP"].EventHandler = function(ctrl)
    DeviceDisconnect(x)
    if ctrl.String ~= "" then
      DeviceConnect(x)    
    end
  end

  Controls["Device_" .. x .. "_On"].EventHandler = function(ctrl)
    if Sockets[x].IsConnected then
      if DebugTx then
        print("Device" .. x .. " TX: " .. '{ "system":{ "set_relay_state":{ "state":1 } } }')
      end
      Sockets[x]:Write(encode('{ "system":{ "set_relay_state":{ "state":1 } } }'))
    end
  end
  Controls["Device_" .. x .. "_Off"].EventHandler = function(ctrl)
    if Sockets[x].IsConnected then
      if DebugTx then
        print("Device" .. x .. " TX: " .. '{ "system":{ "set_relay_state":{ "state":0 } } }')
      end
      Sockets[x]:Write(encode('{ "system":{ "set_relay_state":{ "state":0 } } }'))
    end
  end
  Controls["Device_" .. x .. "_Toggle"].EventHandler = function(ctrl)
    if Sockets[x].IsConnected then
      if DebugTx then
        print("Device" .. x .. " TX: " .. '{ "system":{ "set_relay_state":{ "state":'..(ctrl.Boolean and 1 or 0)..' } } }')
      end
      Sockets[x]:Write(encode('{ "system":{ "set_relay_state":{ "state":'..(ctrl.Boolean and 1 or 0)..' } } }'))
    end
  end
  Controls["Device_" .. x .. "_Brightness"].EventHandler = function(ctrl)
    FaderDebounce[x]:Stop()
    FaderDebounce[x]:Start(0.1)
  end
  FaderDebounce[x].EventHandler = function()
    FaderDebounce[x]:Stop()
    if Sockets[x].IsConnected then
      val = math.floor(Controls["Device_" .. x .. "_Brightness"].Value)
      if DebugTx then
        print("Device" .. x .. " TX: " .. '{ "smartlife.iot.dimmer":{ "set_brightness":{ "brightness":'..val..' } } }')
      end
      Sockets[x]:Write(encode('{ "smartlife.iot.dimmer":{ "set_brightness":{ "brightness":'..val..' } } }'))
    end
  end
end

function ClearDeviceVariables(index)
  if index ~= nil and type(index) == "number" and index <= NumberOfDevices then
    Controls["Device_" .. index .. "_Status"].Value = 3
    Controls["Device_" .. index .. "_Status"].String = ""
    Controls["Device_" .. index .. "_On"].Boolean = false
    Controls["Device_" .. index .. "_Off"].Boolean = false
  end
end
function ClearVariables()
  for d = 1, NumberOfDevices do
    ClearDeviceVariables(d)
  end
end

function DeviceConnect(index)
  if index ~= nil and type(index) == "number" and index <= NumberOfDevices then
    local ip = Controls["Device_" .. index .. "_IP"].String
    Timers[index]:Stop()
    if ip ~= nil and ip ~= "" then
      Sockets[index]:Connect(ip, 9999)
    else
      Controls["Device_" .. index .. "_Status"].Value = 3 --not present
      Controls["Device_" .. index .. "_Status"].String = "No IP Address"
    end
  end
end
function DeviceDisconnect(index)
  if index ~= nil and type(index) == "number" and index <= NumberOfDevices then
    Timers[index]:Stop()
    Sockets[index]:Disconnect()
    -- Controls["Device_" .. index .. "_Status"].Value = 3 --not present
    -- Controls["Device_" .. index .. "_Status"].String = "Disconnected"
  end
end
function DevicePoll(index)
  if index ~= nil and type(index) == "number" and index <= NumberOfDevices then
    if Sockets[index].IsConnected then
      if DebugTx then
        print("Device" .. index .. " TX: " .. '{ "system":{ "get_sysinfo":null } }')
      end
      Sockets[index]:Write(encode('{ "system":{ "get_sysinfo":null } }'))
    end
  end
end

function parseGetInfo(index, data)
  local Meter = Controls["Device_" .. index .. "_Brightness"]
  if data.brightness then
    Meter.IsInvisible = false
    Meter.Value = data.brightness
  else
    Meter.IsInvisible = true
  end
  local On = Controls["Device_" .. index .. "_On"]
  local Off = Controls["Device_" .. index .. "_Off"]
  local Toggle = Controls["Device_" .. index .. "_Toggle"]
  if data.relay_state then
    On.Boolean = data.relay_state == 1
    Off.Boolean = data.relay_state == 0
    Toggle.Boolean = data.relay_state == 1
  end

  -- Device Info
  if data.alias then
    Controls["Device_" .. index .. "_Name"].String = data.alias
  end
  if data.model then
    Controls["Device_" .. index .. "_Model"].String = data.model
  end
  if data.mac then
    Controls["Device_" .. index .. "_Mac"].String = data.mac
  end
  if data.sw_ver then
    Controls["Device_" .. index .. "_Firmware"].String = data.hw_ver
  end
  if data.rssi then
    Controls["Device_" .. index .. "_Rssi"].String = data.rssi
  end
end


function Init()
  ClearVariables()
  for d = 1, NumberOfDevices do
    DeviceConnect(d)
  end
end

Init()
