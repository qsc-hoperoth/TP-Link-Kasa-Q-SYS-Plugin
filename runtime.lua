rapidjson = require("rapidjson")

NumberOfDevices = Properties["Number Of Single Endpoints"].Value
NumberOfStrips = Properties["Number Of Multi Endpoints"].Value

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
local PollTime = Properties["Poll Time"].Value

local Devices = {}

for x = 1, NumberOfDevices + NumberOfStrips do
  local prefix = (x <= NumberOfDevices) and "Device_" .. x or "Strip_" .. (x - NumberOfDevices)
  local isStrip = (x > NumberOfDevices)
  table.insert(Sockets, TcpSocket.New())
  table.insert(Timers, Timer.New())
  table.insert(FaderDebounce, Timer.New())
  Devices[x] = {}
  Devices[x].Buffer = ""
  Devices[x].Info = {}
  Devices[x].Energy = {}

  Timers[x].EventHandler = function()
    DevicePoll(x)
  end
  Sockets[x].EventHandler = function(socket, event, err)
    -- print(event)
    print(prefix .. " got " .. socket.BufferLength .. " bytes")
    if event == TcpSocket.Events.Data then
      Devices[x].Buffer = Devices[x].Buffer .. socket:Read(socket.BufferLength)
      jsonData, err = decode(Devices[x].Buffer)
      if err == nil then
        print(prefix .. " JSON OK, " .. #Devices[x].Buffer .. " bytes")
        Devices[x].Buffer = ""
        if DebugRx then
          print(prefix .. " RX:\n" .. rapidjson.encode(jsonData))
        end
        if jsonData.system then
          if jsonData.system.get_sysinfo then
            if jsonData.system.get_sysinfo.err_code == 0 then
              Controls[prefix .. "_Status"].Value = 0 --ok
              Controls[prefix .. "_Status"].String = ""
            end
            parseGetInfo(x, jsonData.system.get_sysinfo)
          elseif jsonData.system.set_relay_state then
            DevicePoll(x)
          end
        elseif jsonData["smartlife.iot.dimmer"] then -- Dimmer response
          -- Poll()
        elseif jsonData.emeter then -- Energy info
          if jsonData.emeter.get_realtime then -- Realtime energy info
            parseEnergyInfo(x, jsonData.emeter.get_realtime)
          end
        else
          print(prefix .. " Unknown JSON")
          print(rapidjson.encode(jsonData))
        end
      else
        -- Controls["Device_" .. x .. "_Status"].Value = 2 --fault
        -- Controls["Device_" .. x .. "_Status"].String = "JSON Error: ", err
        print("JSON Err:", err)
        print(decodeToString(Devices[x].Buffer))
        if err:find("The document root must not be followed by other values") then
          Devices[x].Buffer = ""
        end
      end
    elseif event == TcpSocket.Events.Connected then
      DevicePoll(x)
      Timers[x]:Start(PollTime)
    else
      Timers[x]:Stop()
      Controls[prefix .. "_Status"].Value = 4 --missing
      Controls[prefix .. "_Status"].String = event
    end
  end

  Controls[prefix .. "_IP"].EventHandler = function(ctrl)
    DeviceDisconnect(x)
    DeviceConnect(x)
  end
  if isStrip then
    for p = 1, 6 do
      Controls[prefix .. "_Plug_" .. p .. "_On"].EventHandler = function(ctrl)
        if
          Sockets[x].IsConnected and Devices[x].Info.deviceId ~= nil and Devices[x].Info.children ~= nil and
            Devices[x].Info.children[p] ~= nil and
            Devices[x].Info.children[p].id ~= nil
         then
          local childID =
            #Devices[x].Info.children[p].id > 2 and Devices[x].Info.children[p].id or
            Devices[x].Info.deviceId .. Devices[x].Info.children[p].id
          if DebugTx then
            print(
              "Strip" ..
                x ..
                  " Plug " ..
                    p ..
                      " TX: " ..
                        '{"context":{"child_ids":["' .. childID .. '"]},"system":{"set_relay_state":{"state":1}}}'
            )
          end
          Sockets[x]:Write(
            encode('{"context":{"child_ids":["' .. childID .. '"]},"system":{"set_relay_state":{"state":1}}}')
          )
        end
      end
      Controls[prefix .. "_Plug_" .. p .. "_Off"].EventHandler = function(ctrl)
        if
          Sockets[x].IsConnected and Devices[x].Info.deviceId ~= nil and Devices[x].Info.children ~= nil and
            Devices[x].Info.children[p] ~= nil and
            Devices[x].Info.children[p].id ~= nil
         then
          local childID =
            #Devices[x].Info.children[p].id > 2 and Devices[x].Info.children[p].id or
            Devices[x].Info.deviceId .. Devices[x].Info.children[p].id
          if DebugTx then
            print(
              "Strip" ..
                x ..
                  " Plug " ..
                    p ..
                      " TX: " ..
                        '{"context":{"child_ids":["' .. childID .. '"]},"system":{"set_relay_state":{"state":0}}}'
            )
          end
          Sockets[x]:Write(
            encode('{"context":{"child_ids":["' .. childID .. '"]},"system":{"set_relay_state":{"state":0}}}')
          )
        end
      end
      Controls[prefix .. "_Plug_" .. p .. "_Toggle"].EventHandler = function(ctrl)
        if
          Sockets[x].IsConnected and Devices[x].Info.deviceId ~= nil and Devices[x].Info.children ~= nil and
            Devices[x].Info.children[p] ~= nil and
            Devices[x].Info.children[p].id ~= nil
         then
          local childID =
            #Devices[x].Info.children[p].id > 2 and Devices[x].Info.children[p].id or
            Devices[x].Info.deviceId .. Devices[x].Info.children[p].id
          if DebugTx then
            print(
              "Strip" ..
                x ..
                  " Plug " ..
                    p ..
                      " TX: " ..
                        '{"context":{"child_ids":["' ..
                          childID .. '"]},"system":{"set_relay_state":{"state":' .. (ctrl.Boolean and 1 or 0) .. "}}}"
            )
          end
          Sockets[x]:Write(
            encode(
              '{"context":{"child_ids":["' ..
                childID .. '"]},"system":{"set_relay_state":{"state":' .. (ctrl.Boolean and 1 or 0) .. "}}}"
            )
          )
        end
      end
      Controls[prefix .. "_Plug_" .. p .. "_Name"].EventHandler = function(ctrl)
        if
          Sockets[x].IsConnected and Devices[x].Info.deviceId ~= nil and Devices[x].Info.children ~= nil and
            Devices[x].Info.children[p] ~= nil and
            Devices[x].Info.children[p].id ~= nil
         then
          local childID =
            #Devices[x].Info.children[p].id > 2 and Devices[x].Info.children[p].id or
            Devices[x].Info.deviceId .. Devices[x].Info.children[p].id
          if DebugTx then
            print(
              "Strip" ..
                x ..
                  " Plug " ..
                    p ..
                      " TX: " ..
                        '{"context":{"child_ids":["' ..
                          childID .. '"]},"system":{"set_dev_alias":{"alias":"' .. ctrl.String .. '"}}}'
            )
          end
          Sockets[x]:Write(
            encode(
              '{"context":{"child_ids":["' ..
                childID .. '"]},"system":{"set_dev_alias":{"alias":"' .. ctrl.String .. '"}}}'
            )
          )
        end
      end
    end
  else
    Controls[prefix .. "_On"].EventHandler = function(ctrl)
      if Sockets[x].IsConnected then
        if DebugTx then
          print(prefix .. " TX: " .. '{ "system":{ "set_relay_state":{ "state":1 } } }')
        end
        Sockets[x]:Write(encode('{ "system":{ "set_relay_state":{ "state":1 } } }'))
      end
    end
    Controls[prefix .. "_Off"].EventHandler = function(ctrl)
      if Sockets[x].IsConnected then
        if DebugTx then
          print(prefix .. " TX: " .. '{ "system":{ "set_relay_state":{ "state":0 } } }')
        end
        Sockets[x]:Write(encode('{ "system":{ "set_relay_state":{ "state":0 } } }'))
      end
    end
    Controls[prefix .. "_Toggle"].EventHandler = function(ctrl)
      if Sockets[x].IsConnected then
        if DebugTx then
          print(
            "Device" ..
              x .. " TX: " .. '{ "system":{ "set_relay_state":{ "state":' .. (ctrl.Boolean and 1 or 0) .. " } } }"
          )
        end
        Sockets[x]:Write(encode('{ "system":{ "set_relay_state":{ "state":' .. (ctrl.Boolean and 1 or 0) .. " } } }"))
      end
    end
    Controls[prefix .. "_Brightness"].EventHandler = function(ctrl)
      FaderDebounce[x]:Stop()
      FaderDebounce[x]:Start(0.1)
    end
    FaderDebounce[x].EventHandler = function()
      FaderDebounce[x]:Stop()
      if Sockets[x].IsConnected then
        val = math.floor(Controls[prefix .. "_Brightness"].Value)
        if DebugTx then
          print(prefix .. " TX: " .. '{ "smartlife.iot.dimmer":{ "set_brightness":{ "brightness":' .. val .. " } } }")
        end
        Sockets[x]:Write(encode('{ "smartlife.iot.dimmer":{ "set_brightness":{ "brightness":' .. val .. " } } }"))
      end
    end
  end
  Controls[prefix .. "_Name"].EventHandler = function(ctrl)
    if Sockets[x].IsConnected then
      if DebugTx then
        print(prefix .. " TX: " .. '{ "system":{ "set_dev_alias":{ "alias":"' .. ctrl.String .. '" } } }')
      end
      Sockets[x]:Write(encode('{ "system":{ "set_dev_alias":{ "alias":"' .. ctrl.String .. '" } } }'))
    end
  end
end

function ClearDeviceVariables(index)
  if index ~= nil and type(index) == "number" then
    local prefix = (index <= NumberOfDevices) and "Device_" .. index or "Strip_" .. (index - NumberOfDevices)
    local isStrip = (index > NumberOfDevices)
    if isStrip then
      for p = 1, 6 do
        Controls[prefix .. "_Plug_" .. p .. "_On"].Boolean = false
        Controls[prefix .. "_Plug_" .. p .. "_Off"].Boolean = false
        Controls[prefix .. "_Plug_" .. p .. "_Toggle"].Boolean = false
        Controls[prefix .. "_Plug_" .. p .. "_Name"].String = ""
        Controls[prefix .. "_Plug_" .. p .. "_Voltage"].String = ""
        Controls[prefix .. "_Plug_" .. p .. "_Current"].String = ""
        Controls[prefix .. "_Plug_" .. p .. "_Power"].String = ""
      end
    else
      Controls[prefix .. "_On"].Boolean = false
      Controls[prefix .. "_Off"].Boolean = false
      Controls[prefix .. "_Toggle"].Boolean = false
      Controls[prefix .. "_Brightness"].Value = 0
      Controls[prefix .. "_Voltage"].String = ""
      Controls[prefix .. "_Current"].String = ""
      Controls[prefix .. "_Power"].String = ""
    end
    Controls[prefix .. "_Status"].Value = 3
    Controls[prefix .. "_Status"].String = ""
    Controls[prefix .. "_Name"].String = ""
    Controls[prefix .. "_Model"].String = ""
    Controls[prefix .. "_Mac"].String = ""
    Controls[prefix .. "_Firmware"].String = ""
    Controls[prefix .. "_Rssi"].String = ""
  end
end
function ClearVariables()
  for d = 1, NumberOfDevices + NumberOfStrips do
    ClearDeviceVariables(d)
  end
end
function HideControls(index)
  if index ~= nil and type(index) == "number" then
    local prefix = (index <= NumberOfDevices) and "Device_" .. index or "Strip_" .. (index - NumberOfDevices)
    local isStrip = (index > NumberOfDevices)
    if isStrip then
      for p = 1, 6 do
        Controls[prefix .. "_Plug_" .. p .. "_On"].IsInvisible = true
        Controls[prefix .. "_Plug_" .. p .. "_Off"].IsInvisible = true
        Controls[prefix .. "_Plug_" .. p .. "_Toggle"].IsInvisible = true
        Controls[prefix .. "_Plug_" .. p .. "_Name"].IsInvisible = true
        Controls[prefix .. "_Plug_" .. p .. "_Voltage"].IsInvisible = true
        Controls[prefix .. "_Plug_" .. p .. "_Current"].IsInvisible = true
        Controls[prefix .. "_Plug_" .. p .. "_Power"].IsInvisible = true
      end
    else
      Controls[prefix .. "_Brightness"].IsInvisible = true
      Controls[prefix .. "_On"].IsInvisible = true
      Controls[prefix .. "_Off"].IsInvisible = true
      Controls[prefix .. "_Toggle"].IsInvisible = true
    end
  end
end

function DeviceConnect(index)
  if index ~= nil and type(index) == "number" then
    local prefix = (index <= NumberOfDevices) and "Device_" .. index or "Strip_" .. (index - NumberOfDevices)
    local ip = Controls[prefix .. "_IP"].String
    Timers[index]:Stop()
    if ip ~= nil and ip ~= "" then
      Sockets[index]:Connect(ip, 9999)
    else
      ClearDeviceVariables(index)
      Controls[prefix .. "_Status"].Value = 3 --not present
      Controls[prefix .. "_Status"].String = "No IP Address"
      HideControls(index)
    end
  end
end
function DeviceDisconnect(index)
  if index ~= nil and type(index) == "number" then
    Timers[index]:Stop()
    Sockets[index]:Disconnect()
    HideControls(index)
  -- Controls["Device_" .. index .. "_Status"].Value = 3 --not present
  -- Controls["Device_" .. index .. "_Status"].String = "Disconnected"
  end
end
function DevicePoll(index)
  if index ~= nil and type(index) == "number" then
    local isStrip = (index > NumberOfDevices)
    if Sockets[index].IsConnected then
      if DebugTx then
        print("Device" .. index .. " TX: " .. '{ "system":{ "get_sysinfo":null } }')
      end
      Sockets[index]:Write(encode('{ "system":{ "get_sysinfo":null } }'))

      if Devices[index].Info.feature ~= nil and Devices[index].Info.feature:find("ENE") then
        if isStrip then
          for p = 1, 6 do
            if Devices[index].Info.children ~= nil and Devices[index].Info.children[p] ~= nil then
              local childID =
                #Devices[index].Info.children[p].id > 2 and Devices[index].Info.children[p].id or
                Devices[index].Info.deviceId .. Devices[index].Info.children[p].id
              if DebugTx then
                print(
                  "Strip" ..
                    index ..
                      " Plug " ..
                        p .. " TX: " .. '{"context":{"child_ids":["' .. childID .. '"]},"emeter":{"get_realtime":{}}}'
                )
              end
              Sockets[index]:Write(
                encode('{"context":{"child_ids":["' .. childID .. '"]},"emeter":{"get_realtime":{}}}')
              )
            end
          end
        else
          Timer.CallAfter(
            function()
              if DebugTx then
                print("Device" .. index .. " TX: " .. '{"emeter":{"get_realtime":{}}}')
              end
              Sockets[index]:Write(encode('{"emeter":{"get_realtime":{}}}'))
            end,
            0.1
          )
        end
      end
    end
  end
end

function parseGetInfo(index, data)
  prefix = (index <= NumberOfDevices) and "Device_" .. index or "Strip_" .. (index - NumberOfDevices)
  isStrip = (index > NumberOfDevices)
  -- print(prefix, rapidjson.encode(data))

  -- Device Info
  if data.alias then
    Controls[prefix .. "_Name"].String = data.alias
    Devices[index].Info.alias = data.alias
  end
  if data.model then
    Controls[prefix .. "_Model"].String = data.model
    Devices[index].Info.model = data.model
  end
  if data.mac then
    Controls[prefix .. "_Mac"].String = data.mac
    Devices[index].Info.mac = data.mac
  end
  if data.sw_ver then
    Controls[prefix .. "_Firmware"].String = data.hw_ver
    Devices[index].Info.sw_ver = data.sw_ver
  end
  if data.rssi then
    Controls[prefix .. "_Rssi"].String = data.rssi
    Devices[index].Info.rssi = data.rssi
  end
  if data.feature then
    Devices[index].Info.feature = data.feature
  end
  if data.deviceId then
    Devices[index].Info.deviceId = data.deviceId
  end
  if data.children then
    Devices[index].Info.children = data.children
    if not isStrip then
      print("ERROR: Device " .. index .. " has children")
    end
  end
  if isStrip then
    if data.child_num > 0 and data.children then
      for _, child in ipairs(data.children) do
        childID = tonumber(child.id:sub(-2)) + 1
        if child.alias then
          Controls[prefix .. "_Plug_" .. childID .. "_Name"].String = child.alias
        end
        if child.state then
          Controls[prefix .. "_Plug_" .. childID .. "_On"].Boolean = child.state == 1
          Controls[prefix .. "_Plug_" .. childID .. "_Off"].Boolean = child.state == 0
          Controls[prefix .. "_Plug_" .. childID .. "_Toggle"].Boolean = child.state == 1
        end
      end
    end
    local child_num = data.child_num or 0
    for p = 1, 6 do
      Controls[prefix .. "_Plug_" .. p .. "_On"].IsInvisible = (p > child_num)
      Controls[prefix .. "_Plug_" .. p .. "_Off"].IsInvisible = (p > child_num)
      Controls[prefix .. "_Plug_" .. p .. "_Toggle"].IsInvisible = (p > child_num)
      Controls[prefix .. "_Plug_" .. p .. "_Name"].IsInvisible = (p > child_num)
      Controls[prefix .. "_Plug_" .. p .. "_Voltage"].IsInvisible = (p > child_num) and data.feature:find("ENE")
      Controls[prefix .. "_Plug_" .. p .. "_Current"].IsInvisible = (p > child_num) and data.feature:find("ENE")
      Controls[prefix .. "_Plug_" .. p .. "_Power"].IsInvisible = (p > child_num) and data.feature:find("ENE")
    end
  else
    local Meter = Controls[prefix .. "_Brightness"]
    if data.brightness then
      Meter.IsInvisible = false
      Meter.Value = data.brightness
    else
      Meter.IsInvisible = true
    end
    local On = Controls[prefix .. "_On"]
    local Off = Controls[prefix .. "_Off"]
    local Toggle = Controls[prefix .. "_Toggle"]
    if data.relay_state then
      On.Boolean = data.relay_state == 1
      Off.Boolean = data.relay_state == 0
      Toggle.Boolean = data.relay_state == 1
      On.IsInvisible = false
      Off.IsInvisible = false
      Toggle.IsInvisible = false
    else
      On.IsInvisible = true
      Off.IsInvisible = true
      Toggle.IsInvisible = true
    end
  end
end
function parseEnergyInfo(index, data)
  -- print("parseEnergyInfo", index)
  -- print(rapidjson.encode(data))
  local prefix = (index <= NumberOfDevices) and "Device_" .. index or "Strip_" .. (index - NumberOfDevices)
  local isStrip = (index > NumberOfDevices)
  if isStrip then
    local p = data.slot_id + 1
    if data.voltage_mv then
      Controls[prefix .. "_Plug_" .. p .. "_Voltage"].String = data.voltage_mv / 1000 .. " V"
    end
    if data.current_ma then
      Controls[prefix .. "_Plug_" .. p .. "_Current"].String = data.current_ma / 1000 .. " A"
    end
    if data.power_mw then
      Controls[prefix .. "_Plug_" .. p .. "_Power"].String = data.power_mw / 1000 .. " W"
    end
  else
    if data.voltage_mv then
      Controls[prefix .. "_Voltage"].String = data.voltage_mv / 1000 .. " V"
    end
    if data.current_ma then
      Controls[prefix .. "_Current"].String = data.current_ma / 1000 .. " A"
    end
    if data.power_mw then
      Controls[prefix .. "_Power"].String = data.power_mw / 1000 .. " W"
    end
  end
end

function Init()
  ClearVariables()
  for d = 1, NumberOfDevices + NumberOfStrips do
    HideControls(index)
    DeviceConnect(d)
  end
end

Init()
