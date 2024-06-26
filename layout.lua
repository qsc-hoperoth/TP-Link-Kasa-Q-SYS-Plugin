-- layout["code"] = {PrettyName = "Code",Style = "None"}

local x, y = 0, 10

local current_page = props["page_index"].Value
local NumberOfDevices = props["Number Of Single Endpoints"].Value
local NumberOfStrips = props["Number Of Multi Endpoints"].Value

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
      FontSize = 9
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
      FontSize = 9
    }
    x = x + 150
    layout["Device_" .. d .. "_Name"] = {
      PrettyName = "Device" .. d .. "~Name",
      Position = {x, y},
      Size = {150, 20},
      Style = "Text",
      FontSize = 9
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
  if NumberOfStrips > 0 then
    x = 0
    y = y + 20
    table.insert(
      graphics,
      {
        Type = "Label",
        Position = {x, y},
        Size = {40, 20},
        Text = "Strip",
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
        FontSize = 9
      }
    )
    x = x + 150
    table.insert(
      graphics,
      {
        Type = "Label",
        Position = {x, y},
        Size = {75, 20},
        Text = "Plug 1",
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
        Text = "Plug 2",
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
        Text = "Plug 3",
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
        Text = "Plug 4",
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
        Text = "Plug 5",
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
        Text = "Plug 6",
        FontSize = 12
      }
    )
    for d = 1, NumberOfStrips do
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
      layout["Strip_" .. d .. "_IP"] = {
        PrettyName = "Strip" .. d .. "~IP Address",
        Position = {x, y},
        Size = {125, 20},
        Style = "Text",
        FontSize = 12
      }
      x = x + 125
      layout["Strip_" .. d .. "_Status"] = {
        PrettyName = "Strip" .. d .. "~Status",
        Position = {x, y},
        Size = {150, 20},
        Style = "Text",
        FontSize = 9
      }
      x = x + 150
      layout["Strip_" .. d .. "_Name"] = {
        PrettyName = "Strip" .. d .. "~Name",
        Position = {x, y},
        Size = {150, 20},
        Style = "Text",
        FontSize = 9
      }
      x = x + 150
      for p = 1, 6 do
        layout["Strip_" .. d .. "_Plug_" .. p .. "_Toggle"] = {
          PrettyName = "Strip" .. d .. "~Plug " .. p .. "~Toggle",
          Position = {x, y},
          Size = {75, 20},
          Style = "Button",
          Legend = "Toggle",
          FontSize = 12,
          Margin = 0
        }
        x = x + 75
      end
    end
  end
else
  local index = current_page - 2
  prefix = (index <= NumberOfDevices) and "Device_" .. index or "Strip_" .. (index - NumberOfDevices)
  prettyNamePrefix = (index <= NumberOfDevices) and "Device" .. index or "Strip" .. (index - NumberOfDevices)
  isStrip = (index > NumberOfDevices)
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
  layout[prefix .. "_IP"] = {
    PrettyName = prettyNamePrefix .. "~IP Address",
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
  layout[prefix .. "_Status"] = {
    PrettyName = prettyNamePrefix .. "~Status",
    Position = {x, y + 20},
    Size = {150, 20},
    Style = "Text",
    FontSize = 12
  }
  x = 0
  y = 90
  if isStrip then
    table.insert(
      graphics,
      {
        Type = "GroupBox",
        Position = {x, y},
        Size = {190, 150},
        Text = "Device Info",
        FontSize = 12,
        StrokeColor = Colors.Black,
        StrokeWidth = 1,
        CornerRadius = 5
      }
    )

    --Device Info
    x = x + 5
    y = y + 20
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
    layout[prefix .. "_Name"] = {
      PrettyName = prettyNamePrefix .. "~Name",
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
    layout[prefix .. "_Model"] = {
      PrettyName = prettyNamePrefix .. "~Model",
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
    layout[prefix .. "_Mac"] = {
      PrettyName = prettyNamePrefix .. "~Mac Address",
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
    layout[prefix .. "_Firmware"] = {
      PrettyName = prettyNamePrefix .. "~Firmware",
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
    layout[prefix .. "_Rssi"] = {
      PrettyName = prettyNamePrefix .. "~RSSI",
      Position = {x + 80, y},
      Size = {100, 20},
      Style = "Text",
      FontSize = 12
    }

    -- Plugs
    x = x + 200
    for p = 1, 6 do
      y = 90
      table.insert(
        graphics,
        {
          Type = "GroupBox",
          Position = {x, y},
          Size = {90, 215},
          Text = "Plug " .. p,
          FontSize = 12,
          StrokeColor = Colors.Black,
          StrokeWidth = 1,
          CornerRadius = 5
        }
      )
      y = y + 20
      layout[prefix .. "_Plug_" .. p .. "_Name"] = {
        PrettyName = prettyNamePrefix .. "~Plug " .. p .. "~Name",
        Position = {x + 5, y},
        Size = {80, 20},
        Style = "Text",
        FontSize = 9
      }
      y = y + 25
      layout[prefix .. "_Plug_" .. p .. "_On"] = {
        PrettyName = prettyNamePrefix .. "~Plug " .. p .. "~On",
        Position = {x + 5, y},
        Size = {40, 40},
        Style = "Button",
        Legend = "On",
        FontSize = 12
      }
      -- y = y + 50
      layout[prefix .. "_Plug_" .. p .. "_Off"] = {
        PrettyName = prettyNamePrefix .. "~Plug " .. p .. "~Off",
        Position = {x + 45, y},
        Size = {40, 40},
        Style = "Button",
        Legend = "Off",
        FontSize = 12
      }
      y = y + 45
      layout[prefix .. "_Plug_" .. p .. "_Toggle"] = {
        PrettyName = prettyNamePrefix .. "~Plug " .. p .. "~Toggle",
        Position = {x + 5, y},
        Size = {80, 40},
        Style = "Button",
        Legend = "Toggle",
        FontSize = 12
      }
      y = y + 50
      layout[prefix .. "_Plug_" .. p .. "_Voltage"] = {
        PrettyName = prettyNamePrefix .. "~Plug " .. p .. "~Voltage",
        Position = {x + 5, y},
        Size = {80, 20},
        Style = "Text",
        FontSize = 12
      }
      y = y + 25
      layout[prefix .. "_Plug_" .. p .. "_Current"] = {
        PrettyName = prettyNamePrefix .. "~Plug " .. p .. "~Current",
        Position = {x + 5, y},
        Size = {80, 20},
        Style = "Text",
        FontSize = 12
      }
      y = y + 25
      layout[prefix .. "_Plug_" .. p .. "_Power"] = {
        PrettyName = prettyNamePrefix .. "~Plug " .. p .. "~Power",
        Position = {x + 5, y},
        Size = {80, 20},
        Style = "Text",
        FontSize = 12
      }
      x = x + 100
    end
  else
    table.insert(
      graphics,
      {
        Type = "GroupBox",
        Position = {x, y},
        Size = {100, 225},
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
        Size = {190, 225},
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
    layout[prefix .. "_On"] = {
      PrettyName = prettyNamePrefix .. "~On",
      Position = {x, y},
      Size = {40, 40},
      Style = "Button",
      Legend = "On",
      FontSize = 12
    }
    x = x + 50
    layout[prefix .. "_Off"] = {
      PrettyName = prettyNamePrefix .. "~Off",
      Position = {x, y},
      Size = {40, 40},
      Style = "Button",
      Legend = "Off",
      FontSize = 12
    }
    x = 5
    y = y + 50
    layout[prefix .. "_Toggle"] = {
      PrettyName = prettyNamePrefix .. "~Toggle",
      Position = {x, y},
      Size = {90, 40},
      Style = "Button",
      Legend = "Toggle",
      FontSize = 12
    }
    y = y + 50
    layout[prefix .. "_Brightness"] = {
      PrettyName = prettyNamePrefix .. "~Brightness",
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
    layout[prefix .. "_Name"] = {
      PrettyName = prettyNamePrefix .. "~Name",
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
    layout[prefix .. "_Model"] = {
      PrettyName = prettyNamePrefix .. "~Model",
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
    layout[prefix .. "_Mac"] = {
      PrettyName = prettyNamePrefix .. "~Mac Address",
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
    layout[prefix .. "_Firmware"] = {
      PrettyName = prettyNamePrefix .. "~Firmware",
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
    layout[prefix .. "_Rssi"] = {
      PrettyName = prettyNamePrefix .. "~RSSI",
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
        Text = "Voltage",
        FontSize = 12,
        HTextAlign = "Right"
      }
    )
    layout[prefix .. "_Voltage"] = {
      PrettyName = prettyNamePrefix .. "~Voltage",
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
        Text = "Current",
        FontSize = 12,
        HTextAlign = "Right"
      }
    )
    layout[prefix .. "_Current"] = {
      PrettyName = prettyNamePrefix .. "~Current",
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
        Text = "Power",
        FontSize = 12,
        HTextAlign = "Right"
      }
    )
    layout[prefix .. "_Power"] = {
      PrettyName = prettyNamePrefix .. "~Power",
      Position = {x + 80, y},
      Size = {100, 20},
      Style = "Text",
      FontSize = 12
    }
  end
end
