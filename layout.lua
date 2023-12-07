-- layout["code"] = {PrettyName = "Code",Style = "None"}

local x, y = 0, 10

local current_page = props["page_index"].Value
local NumberOfDevices = props["Number Of Devices"].Value

if current_page == 2 then --Setup
  layout["Discover"] = {
    Position = {x, y},
    Size = {60, 40},
    Style = "Button",
    Legend = "Discover",
    FontSize = 14
  }
  y = y + 60
  layout["Discovered Devices"] = {
    Position = {x, y},
    Size = {300, 300},
    Style = "Text",
    Legend = "Discovered Devices",
    HTextAlign = "Left",
    VTextAlign = "Top",
    FontSize = 12
  }
elseif current_page == 1 then -- Central Control
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {40, 20},
      Text = "Index",
      FontSize = 12
    }
  )
  x = x + 40
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {125, 20},
      Text = "IP Address",
      FontSize = 12
    }
  )
  x = x + 125
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {150, 20},
      Text = "Status",
      FontSize = 12
    }
  )
  x = x + 150
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {150, 20},
      Text = "Name",
      FontSize = 12
    }
  )
  x = x + 150
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {75, 20},
      Text = "Toggle",
      FontSize = 12
    }
  )
  x = x + 75
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {75, 20},
      Text = "Brightness",
      FontSize = 12
    }
  )
  for d = 1, NumberOfDevices do
    x = 0
    y = y + 20
    table.insert(
      graphics,
      {
        Type = "Label",
        Position = {x, y},
        Size = {40, 20},
        Text = tostring(d),
        FontSize = 12
      }
    )
    x = x + 40
    layout["Device_" .. d .. "_IP"] = {
      PrettyName = "Device" .. d .. "~IP Address",
      Position = {x, y},
      Size = {125, 20},
      Style = "Text",
      FontSize = 12
    }
    x = x + 125
    layout["Device_" .. d .. "_Status"] = {
      PrettyName = "Device" .. d .. "~Status",
      Position = {x, y},
      Size = {150, 20},
      Style = "Text",
      FontSize = 12
    }
    x = x + 150
    layout["Device_" .. d .. "_Name"] = {
      PrettyName = "Device" .. d .. "~Name",
      Position = {x, y},
      Size = {150, 20},
      Style = "Text",
      FontSize = 12
    }
    x = x + 150
    layout["Device_" .. d .. "_Toggle"] = {
      PrettyName = "Device" .. d .. "~Toggle",
      Position = {x, y},
      Size = {75, 20},
      Style = "Button",
      Legend = "Toggle",
      FontSize = 12,
      Margin = 0
    }
    x = x + 75
    layout["Device_" .. d .. "_Brightness"] = {
      PrettyName = "Device" .. d .. "~Brightness",
      Position = {x, y},
      Size = {75, 20},
      Style = "Text",
      FontSize = 12
    }

  end
else
  local index = current_page - 2
  table.insert(
    graphics,
    {
      Type = "GroupBox",
      Position = {x, y},
      Size = {300, 70},
      Text = "Connection",
      FontSize = 12,
      StrokeColor = Colors.Black,
      StrokeWidth = 1,
      CornerRadius = 5
    }
  )
  x = 10
  y = 30
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {125, 20},
      Text = "IP Address",
      FontSize = 12
    }
  )
  layout["Device_" .. index .. "_IP"] = {
    PrettyName = "Device" .. index .. "~IP Address",
    Position = {x, y + 20},
    Size = {125, 20},
    Style = "Text",
    FontSize = 12
  }
  x = x + 135
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {150, 20},
      Text = "Status",
      FontSize = 12
    }
  )
  layout["Device_" .. index .. "_Status"] = {
    PrettyName = "Device" .. index .. "~Status",
    Position = {x, y + 20},
    Size = {150, 20},
    Style = "Text",
    FontSize = 12
  }
  x = 0
  y = 90
  table.insert(
    graphics,
    {
      Type = "GroupBox",
      Position = {x, y},
      Size = {100, 200},
      Text = "Control",
      FontSize = 12,
      StrokeColor = Colors.Black,
      StrokeWidth = 1,
      CornerRadius = 5
    }
  )
  table.insert(
    graphics,
    {
      Type = "GroupBox",
      Position = {x + 110, y},
      Size = {190, 200},
      Text = "Device Info",
      FontSize = 12,
      StrokeColor = Colors.Black,
      StrokeWidth = 1,
      CornerRadius = 5
    }
  )
  --Control
  x = 5
  y = y + 20
  TopY = y

  layout["Device_" .. index .. "_On"] = {
    PrettyName = "Device" .. index .. "~On",
    Position = {x, y},
    Size = {40, 40},
    Style = "Button",
    Legend = "On",
    FontSize = 12
  }
  x = x + 50
  layout["Device_" .. index .. "_Off"] = {
    PrettyName = "Device" .. index .. "~Off",
    Position = {x, y},
    Size = {40, 40},
    Style = "Button",
    Legend = "Off",
    FontSize = 12
  }
  x = 5
  y = y + 50
  layout["Device_" .. index .. "_Toggle"] = {
    PrettyName = "Device" .. index .. "~Toggle",
    Position = {x, y},
    Size = {90, 40},
    Style = "Button",
    Legend = "Toggle",
    FontSize = 12
  }
  y = y + 50
  layout["Device_" .. index .. "_Brightness"] = {
    PrettyName = "Device" .. index .. "~Brightness",
    Position = {x, y},
    Size = {90, 80},
    Style = "Knob",
    FontSize = 12
  }

  --Device Info
  x = x + 110
  y = TopY
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {75, 20},
      Text = "Name",
      FontSize = 12,
      HTextAlign = "Right"
    }
  )
  layout["Device_" .. index .. "_Name"] = {
    PrettyName = "Device" .. index .. "~Name",
    Position = {x + 80, y},
    Size = {100, 20},
    Style = "Text",
    FontSize = 12
  }
  y = y + 25
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {75, 20},
      Text = "Model",
      FontSize = 12,
      HTextAlign = "Right"
    }
  )
  layout["Device_" .. index .. "_Model"] = {
    PrettyName = "Device" .. index .. "~Model",
    Position = {x + 80, y},
    Size = {100, 20},
    Style = "Text",
    FontSize = 12
  }
  y = y + 25
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {75, 20},
      Text = "Mac Address",
      FontSize = 12,
      HTextAlign = "Right"
    }
  )
  layout["Device_" .. index .. "_Mac"] = {
    PrettyName = "Device" .. index .. "~Mac Address",
    Position = {x + 80, y},
    Size = {100, 20},
    Style = "Text",
    FontSize = 9
  }
  y = y + 25
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {75, 20},
      Text = "Firmware",
      FontSize = 12,
      HTextAlign = "Right"
    }
  )
  layout["Device_" .. index .. "_Firmware"] = {
    PrettyName = "Device" .. index .. "~Firmware",
    Position = {x + 80, y},
    Size = {100, 20},
    Style = "Text",
    FontSize = 12
  }
  y = y + 25
  table.insert(
    graphics,
    {
      Type = "Label",
      Position = {x, y},
      Size = {75, 20},
      Text = "RSSI",
      FontSize = 12,
      HTextAlign = "Right"
    }
  )
  layout["Device_" .. index .. "_Rssi"] = {
    PrettyName = "Device" .. index .. "~RSSI",
    Position = {x + 80, y},
    Size = {100, 20},
    Style = "Text",
    FontSize = 12
  }
end
