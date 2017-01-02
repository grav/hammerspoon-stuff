-- require('hs')

function t_eq(a,b)
  for k,v in pairs(a) do
    if b[k]~=v then return false end
    return true
  end
end

function screen(screenname)
  local s = nil
  for _,sc in pairs(hs.screen.allScreens()) do
    if sc:name()==screenname then s = sc end
  end
  return s
end

function place(appname,screenname,x,w)
  print("Placing " .. appname .. " on " .. screenname)
  local app = hs.application.get(appname)
  if app==nil then return end
  for _,win in pairs(app:visibleWindows()) do
    s = screen(screenname)
    win:moveToScreen(s)
    s_rect = s:absoluteToLocal(s:frame())
    if x and w then
      w_rect = hs.geometry.rect(s_rect.w*x,s_rect.y,s_rect.w * w, s_rect.h)
      win:setFrame(w_rect)
    else
      win:maximize(0)
    end
  end
end

function placeWin(window,screenname)
  w:moveToScreen(screen(screenname))
  w:maximize(0)
end

function placeAll()
  --
  for _,a in pairs({"Safari","Slack","Messages","SourceTree"}) do
    place(a,"HP E232")
  end

  for a,t in pairs({
    ["IntelliJ IDEA"]={screen="DELL U3014",x=0,w=0.7},
    ["Terminal"]={screen="DELL U3014",x=0.7,w=0.3},
    ["Atom"]={screen="DELL U3014",
    ["Google Chrome"]={screen="Color LCD"}}
  }) do
      place(a,t.screen,t.x,t.w)
  end

  -- for _,w in pairs(hs.application.get("Google Chrome"):visibleWindows()) do
  --   if string.match(w:title(),"^Developer Tools") then
  --     placeWin(w,"HP E232")
  -- end
end

function placeIfScreensConnected()
    local t = hs.screen.allScreens()
    local names = {}
    for k,v in pairs(t) do
      names[v:name()] = true
    end
    if t_eq({["DELL U3014"]=true,["Color LCD"]=true,["HP E232"]=true},names) then placeAll() end
end
