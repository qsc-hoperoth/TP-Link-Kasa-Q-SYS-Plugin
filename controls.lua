-- table.insert(ctrls,{Name = "code",ControlType = "Text",PinStyle = "Input",Count = 1})

NumberOfDevices = props["Number Of Devices"].Value

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
      ControlType = "Indicator",
      IndicatorType = "Text",
      PinStyle = "Output",
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
end
