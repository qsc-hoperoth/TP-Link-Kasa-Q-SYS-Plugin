function decode(buf, udp)
  local ascii = ""
  local hex = ""
  -- Decryption key is -85 (256-85=171)
  local key = 171
  -- Decrypt Autokey XOR
  -- Skip first 4 bytes (header)
  for index = (udp and 1 or 5), #buf do
    local c = buf:byte(index)
    -- XOR first byte with key
    d = c ~ key
    -- Use byte as next key
    key = c
    hex = hex .. string.format("%x ", d)
    -- Convert to printable characters
    if d >= 0x20 and d <= 0x7E then
      ascii = ascii .. string.format("%c", d)
    else
      -- Use dot for non-printable bytes
      ascii = ascii .. "."
    end
  end
  -- print(hex)
  -- print(ascii)
  return rapidjson.decode(ascii)
end 
function decodeToString(buf, udp)
  local ascii = ""
  local hex = ""
  -- Decryption key is -85 (256-85=171)
  local key = 171
  -- Decrypt Autokey XOR
  -- Skip first 4 bytes (header)
  for index = (udp and 1 or 5), #buf do
    local c = buf:byte(index)
    -- XOR first byte with key
    d = c ~ key
    -- Use byte as next key
    key = c
    hex = hex .. string.format("%x ", d)
    -- Convert to printable characters
    if d >= 0x20 and d <= 0x7E then
      ascii = ascii .. string.format("%c", d)
    else
      -- Use dot for non-printable bytes
      ascii = ascii .. "."
    end
  end
  -- print(hex)
  -- print(ascii)
  -- return rapidjson.decode(ascii)
  return ascii
end 

function encode(message)
  local key = 171
  result = string.pack(">I",#message)
  for i = 1, #message do 
    a = key ~ message:byte(i)
    key = a
    result = result .. string.char(a)
  end 
  return result
end 