if props["Energy Monitoring"].Value then
  -- table.insert(PageNames, "Energy Graph",3)
end
for ix,name in ipairs(PageNames) do
  table.insert(pages, {name = PageNames[ix]})
end