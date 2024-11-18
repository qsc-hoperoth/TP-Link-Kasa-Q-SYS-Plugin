-- table.insert(
--   props,
--   {
--     Name = "Number Of Single Endpoints",
--     Type = "integer",
--     Min = 0,
--     Max = MaxDevices,
--     Value = 1
--   }
-- )
-- table.insert(
--   props,
--   {
--     Name = "Number Of Multi Endpoints",
--     Type = "integer",
--     Min = 0,
--     Max = MaxDevices,
--     Value = 0
--   }
-- )
table.insert(props, {
    Name = "Device Type",
    Type = "enum",
    Choices = {"Switch", "Dimmer", "Strip", "LED Strip"},
    Value = "Switch"
})
table.insert(props,
             {Name = "Energy Monitoring", Type = "boolean", Value = false})
table.insert(props, {
    Name = "Number Of Outputs",
    Type = "integer",
    Min = 2,
    Max = 6,
    Value = 2
})
table.insert(props, {
    Name = "Poll Time",
    Comment = "Time in seconds between polling the devices",
    Type = "integer",
    Min = 1,
    Max = 60,
    Value = 5
})
table.insert(props, {
    Name = "Debug Print",
    Type = "enum",
    Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
    Value = "None"
})
