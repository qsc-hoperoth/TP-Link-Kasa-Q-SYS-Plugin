local DiscoveredDevices = {}

function RenderDiscoveredDevices()
  Controls["Discovered Devices"].String = ""
  local toPrint = ""
  for _, device in pairs(DiscoveredDevices) do
    toPrint = toPrint..device.alias.."["..device.model.."] - "..device.ip.."\n"
  end
  Controls["Discovered Devices"].String = toPrint
end

DiscoverySocket = UdpSocket.New()
DiscoverySocket.EventHandler = function(socket, packet)  
  data = decode(packet.Data,true)
  if data.system.get_sysinfo.alias then 
    print(decodeToString(packet.Data,true))
    print(data.system.get_sysinfo.alias.."["..data.system.get_sysinfo.model.."] - "..packet.Address)
    if DiscoveredDevices[data.system.get_sysinfo.mac] == nil then
      DiscoveredDevices[data.system.get_sysinfo.mac] = {}
    end
    DiscoveredDevices[data.system.get_sysinfo.mac].alias = data.system.get_sysinfo.alias
    DiscoveredDevices[data.system.get_sysinfo.mac].model = data.system.get_sysinfo.model
    DiscoveredDevices[data.system.get_sysinfo.mac].ip = packet.Address
  end 
  RenderDiscoveredDevices()
end 

DiscoverySocket:Open("",9999)
Controls.Discover.EventHandler = function()
  print("Sending Discovery packet")
  DiscoveredDevices = {}
  RenderDiscoveredDevices()
  DiscoverySocket:Send("255.255.255.255",9999,"\xd0\xf2\x81\xf8\x8b\xff\x9a\xf7\xd5\xef\x94\xb6\xd1\xb4\xc0\x9f\xec\x95\xe6\x8f\xe1\x87\xe8\xca\xf0\x8b\xf6\x8b\xf6")
end 