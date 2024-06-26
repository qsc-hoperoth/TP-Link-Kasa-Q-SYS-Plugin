table.insert(
  props,
  {
    Name = "Number Of Single Endpoints",
    Type = "integer",
    Min = 0,
    Max = MaxDevices,
    Value = 1
  }
)
table.insert(
  props,
  {
    Name = "Number Of Multi Endpoints",
    Type = "integer",
    Min = 0,
    Max = MaxDevices,
    Value = 0
  }
)
table.insert(
  props,
  {
    Name = "Poll Time",
    Type = "integer",
    Min = 1,
    Max = 60,
    Value = 5
  }
)
table.insert(
  props,
  {
    Name = "Debug Print",
    Type = "enum",
    Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
    Value = "None"
  }
)
