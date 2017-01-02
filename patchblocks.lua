function checkIfMounted()
  if not hs.fs.volume.allVolumes(false)["/Volumes/CRP DISABLD"] then
    hs.alert.show("Patchblock not mounted, reconnect USB!")
  end
end

local usbWatcher = hs.usb.watcher.new(function (data)
  if string.find(data["productName"],"NXP LPC13XX IFLASH") and data["eventType"] == "added" then
    hs.timer.doAfter(2, checkIfMounted)
  end
end):start()

function alertIfMounted(eventType, relTable)
  if eventType == hs.fs.volume.didMount and hs.fs.volume.allVolumes()["/Volumes/CRP DISABLD"] then
    hs.alert.show("Patchblock mounted!")
  end
end
