-- table.insert(ctrls,{Name = "code",ControlType = "Text",PinStyle = "Input",Count = 1})

local NumberOfDevices = props["Number Of Single Endpoints"].Value
local NumberOfStrips = props["Number Of Multi Endpoints"].Value

table.insert(
  ctrls,
  {
    Name = "Discover",
    ControlType = "Button",
    ButtonType = "Trigger",
    PinStyle = "Input",
    UserPin = true
  }
)

table.insert(
  ctrls,
  {
    Name = "Discovered Devices",
    ControlType = "Indicator",
    IndicatorType = "Text",
    PinStyle = "Output",
    UserPin = true
  }
)

for d = 1, NumberOfDevices do
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_IP",
      ControlType = "Text",
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Status",
      ControlType = "Indicator",
      IndicatorType = "Status",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_On",
      ControlType = "Button",
      ButtonType = "Toggle",
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Off",
      ControlType = "Button",
      ButtonType = "Toggle",
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Toggle",
      ControlType = "Button",
      ButtonType = "Toggle",
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Brightness",
      ControlType = "Knob",
      ControlUnit = "Percent",
      Min = 1,
      Max = 100,
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Name",
      ControlType = "Text",
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Model",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Mac",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Firmware",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Rssi",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Voltage",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Current",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Device_" .. d .. "_Power",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
end
for d = 1, NumberOfStrips do
  table.insert(
    ctrls,
    {
      Name = "Strip_" .. d .. "_IP",
      ControlType = "Text",
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Strip_" .. d .. "_Status",
      ControlType = "Indicator",
      IndicatorType = "Status",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Strip_" .. d .. "_Name",
      ControlType = "Text",
      PinStyle = "Both",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Strip_" .. d .. "_Model",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Strip_" .. d .. "_Mac",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Strip_" .. d .. "_Firmware",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )
  table.insert(
    ctrls,
    {
      Name = "Strip_" .. d .. "_Rssi",
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
      UserPin = true
    }
  )

  for p = 1, 6 do -- Per Plug
    table.insert(
      ctrls,
      {
        Name = "Strip_" .. d .. "_Plug_" .. p .. "_On",
        ControlType = "Button",
        ButtonType = "Toggle",
        PinStyle = "Both",
        UserPin = true
      }
    )
    table.insert(
      ctrls,
      {
        Name = "Strip_" .. d .. "_Plug_" .. p .. "_Off",
        ControlType = "Button",
        ButtonType = "Toggle",
        PinStyle = "Both",
        UserPin = true
      }
    )
    table.insert(
      ctrls,
      {
        Name = "Strip_" .. d .. "_Plug_" .. p .. "_Toggle",
        ControlType = "Button",
        ButtonType = "Toggle",
        PinStyle = "Both",
        UserPin = true
      }
    )
    table.insert(
      ctrls,
      {
        Name = "Strip_" .. d .. "_Plug_" .. p .. "_Name",
        ControlType = "Text",
        PinStyle = "Both",
        UserPin = true
      }
    )
    table.insert(
      ctrls,
      {
        Name = "Strip_" .. d .. "_Plug_" .. p .. "_Voltage",
        ControlType = "Indicator",
        IndicatorType = "Text",
        PinStyle = "Output",
        UserPin = true
      }
    )
    table.insert(
      ctrls,
      {
        Name = "Strip_" .. d .. "_Plug_" .. p .. "_Current",
        ControlType = "Indicator",
        IndicatorType = "Text",
        PinStyle = "Output",
        UserPin = true
      }
    )
    table.insert(
      ctrls,
      {
        Name = "Strip_" .. d .. "_Plug_" .. p .. "_Power",
        ControlType = "Indicator",
        IndicatorType = "Text",
        PinStyle = "Output",
        UserPin = true
      }
    )
  end
end
