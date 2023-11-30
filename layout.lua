-- layout["code"] = {PrettyName = "Code",Style = "None"}

local x, y = 0, 10

local current_page = props["page_index"].Value

if current_page == 1 then --Setup
  layout["Discover"] = 
  {
    Position = {x, y},
    Size = {60,40},
    Style = "Button",
    Legend = "Discover",
    FontSize = 14,
  }
  y = y + 60
  layout["Discovered Devices"] = 
  {
    Position = {x, y},
    Size = {300,300},
    Style = "Text",
    Legend = "Discovered Devices",
    HTextAlign = "Left",
    VTextAlign = "Top",
    FontSize = 12,
  }
else 
  local index = current_page - 1
  table.insert(
    graphics,
    {
      Type = "GroupBox",
      Position = {x, y},
      Size = {200,100},
      Text = "Connection",
      FontSize = 12,
    }
  )
  x = 10
  y = 20
  table.insert(
    graphics,
    {
      Type = "GroupBox",
      Position = {x, y},
      Size = {75,20},
      Text = "IP Address",
      FontSize = 12,
    }
  )
  layout["Device_" .. index .. "_IP"] = 
  {
    Position = {x, y + 20},
    Size = {75,20},
    Style = "Text",
    FontSize = 12,
  }
  x = x + 85
  table.insert(
    graphics,
    {
      Type = "GroupBox",
      Position = {x, y},
      Size = {100,20},
      Text = "Status",
      FontSize = 12,
    }
  )
  layout["Device_" .. index .. "_Status"] = 
  {
    Position = {x, y + 20},
    Size = {100,20},
    Style = "Text",
    FontSize = 12,
  }
  table.insert(
    graphics,
    {
      Type = "GroupBox",
      Position = {x, y},
      Size = {100,20},
      Text = "Control",
      FontSize = 12,
    }
  )
end