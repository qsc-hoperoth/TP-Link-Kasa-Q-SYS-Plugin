table.insert (
  props,
  {
    Name = "Number Of Devices",
    Type = "integer",
    Min = 1,
    Max = MaxDevices,
    Value = 1
  }
)
table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
  Value = "None"
})