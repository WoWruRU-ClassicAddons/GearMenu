--[[
  GearMenu - A WoW 1.12.1 Addon to manage quick itemswitching
  Copyright (C) 2018 Michael Wiesendanger <michael.wiesendanger@gmail.com>

  This file is part of GearMenu.

  GearMenu is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  GearMenu is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with GearMenu.  If not, see <http://www.gnu.org/licenses/>.
]]--

local mod = gm
local me = {}
mod.logger = me
me.tag = "Logger"

--[[
  debug - 4
  info - 3
  warn - 2
  error - 1
  event - 0
]]--
me.logLevel = 1
me.debug = 4
me.info = 3
me.warn = 2
me.error = 1
me.event = 0

-- log events
me.logEvent = false
--[[
  force logs to be logged to default chatframe. This does not stop other functionality
  from logging to different windows
]]--
me.forceLogDefaultChatFrame = false

me.colors = {}
me.colors.error = "|cfff00000"  -- red
me.colors.warn = "|cffffce01"   -- yellow
me.colors.info = "|cff18f3ff"   -- blue
me.colors.debug = "|cff7413d9"  -- magenta
me.colors.event = "|cff1cdb4f"  -- green

-- log chatframes
local addonChatFramePosition = nil
local debugChatFramePosition = nil
local infoChatFramePosition = nil
local warnChatFramePosition = nil
local errorChatFramePosition = nil
local eventChatFramePosition = nil

--[[
  Searching for a chatFrame with name GM_CONSTANTS.ADDON_CHATFRAME.
  If it is able to find one messages will be logged to this specific window
  instead of cluttering the default window. This function is called during
  initialisation of the addon. If a debug ChatFrame is added at a later point
  make sure to reload the UI.
]]--
function me.InitializeLogging()
  -- testing for first 10 tabs whether the debug chatFrame can be found
  for i = 1, 10 do
    local tabName = GetChatWindowInfo(i)

    if tabName == GM_CONSTANTS.ADDON_CHATFRAME then
      addonChatFramePosition = i
      -- make sure this info is displayed in the default chatframe so it is seen
      me.LogToDefaultChatFrame(me.tag, "Found addon chatFrame in position " .. i .. ". Logging messages to this frame", me.colors.debug)
    elseif tabName == GM_CONSTANTS.ADDON_DEBUG_CHATFRAME then
      debugChatFramePosition = i
      me.LogToDefaultChatFrame(me.tag, "Found debug chatFrame in position " .. i .. ". Logging messages to this frame", me.colors.debug)
    elseif tabName == GM_CONSTANTS.ADDON_INFO_CHATFRAME then
      infoChatFramePosition = i
      me.LogToDefaultChatFrame(me.tag, "Found info chatFrame in position " .. i .. ". Logging messages to this frame", me.colors.debug)
    elseif tabName == GM_CONSTANTS.ADDON_WARN_CHATFRAME then
      warnChatFramePosition = i
      me.LogToDefaultChatFrame(me.tag, "Found warn chatFrame in position " .. i .. ". Logging messages to this frame", me.colors.debug)
    elseif tabName == GM_CONSTANTS.ADDON_ERROR_CHATFRAME then
      errorChatFramePosition = i
      me.LogToDefaultChatFrame(me.tag, "Found error chatFrame in position " .. i .. ". Logging messages to this frame", me.colors.debug)
    elseif tabName == GM_CONSTANTS.ADDON_EVENT_CHATFRAME then
      eventChatFramePosition = i
      me.LogToDefaultChatFrame(me.tag, "Found event chatFrame in position " .. i .. ". Logging messages to this frame", me.colors.debug)
    end
  end
end

--[[
  Figures out where to log a message

  @param {number} type
  @param {string} tag
  @param {string} message
  @param {string} color
]]--
function me.LogMessage(type, tag, message, color)
  if not message or not color then return end

  if not tag then
    tag = ""
  end

  --[[
    if one of the loglevel specific windows exists additionaly log messages
    to those windows
  ]]--
  if type == me.debug and debugChatFramePosition then
    me.LogToCustomChatFrame(debugChatFramePosition, tag, message, color)
  elseif type == me.info and infoChatFramePosition then
    me.LogToCustomChatFrame(infoChatFramePosition, tag, message, color)
  elseif type == me.warn and warnChatFramePosition then
    me.LogToCustomChatFrame(warnChatFramePosition, tag, message, color)
  elseif type == me.error and errorChatFramePosition then
    me.LogToCustomChatFrame(errorChatFramePosition, tag, message, color)
  elseif type == me.event and eventChatFramePosition then
    me.LogToCustomChatFrame(eventChatFramePosition, tag, message, color)
  end

  --[[
    independent whether messages are logged to a specific tab messages are always
    logged to the custom chatframe or the default chatframe if logging is activated
  ]]--
  if addonChatFramePosition then
    me.LogToCustomChatFrame(addonChatFramePosition, tag, message, color)
  else
    me.LogToDefaultChatFrame(tag, message, color)
    return -- prevent duplicate logging to DEFAULT_CHAT_FRAME
  end

  --[[
    force logging to default chat frame. This can be useful when wow has invisible
    chat windows and thinks it is logging to those. To workaround this you can also
    delete chat-cache.txt of your character in the wtf folder of your wow installation
  ]]--
  if me.forceLogDefaultChatFrame then
    me.LogToDefaultChatFrame(tag, message, color)
  end
end

--[[
  @param {number} position
  @param {string} tag
  @param {string} message
  @param {string} color
]]--
function me.LogToCustomChatFrame(position, tag, message, color)
  getglobal("ChatFrame" .. position):AddMessage(color ..
    GM_CONSTANTS.ADDON_NAME_SHORT .. ":" .. tag .. " - " .. message)
end

--[[
  @param {string} tag
  @param {string} message
  @param {string} color
]]--
function me.LogToDefaultChatFrame(tag, message, color)
  DEFAULT_CHAT_FRAME:AddMessage(color ..
    GM_CONSTANTS.ADDON_NAME_SHORT .. ":" .. tag .. " - " .. message)
end

--[[
  @param {string} tag
  @param {string} message
]]--
function me.LogDebug(tag, message)
  if me.logLevel == me.debug then
    me.LogMessage(me.debug, tag, message, me.colors.debug)
  end
end

--[[
  @param {string} tag
  @param {string} message
]]--
function me.LogInfo(tag, message)
  if me.logLevel >= me.info then
    me.LogMessage(me.info, tag, message, me.colors.info)
  end
end

--[[
  @param {string} tag
  @param {string} message
]]--
function me.LogWarn(tag, message)
  if me.logLevel >= me.warn then
    me.LogMessage(me.warn, tag, message, me.colors.warn)
  end
end

--[[
  @param {string} tag
  @param {string} message
]]--
function me.LogError(tag, message)
  if me.logLevel >= me.error then
    me.LogMessage(me.error, tag, message, me.colors.error)
  end
end

--[[
  @param {string} tag
  @param {string} message
]]--
function me.LogEvent(tag, message)
  if me.logEvent == true then
    me.LogMessage(me.event, tag, message, me.colors.event)
  end
end

--[[
  Print a colorized message to the default chatframe. The message will be printed even when
  logging is set to errors only

  @param {string} tag
  @param {string} msg
  @param {number} r
  @param {number} g
  @param {number} b
]]--
function me.Print(tag, msg, r, g, b)
  if tag == nil then
    tag = ""
  end

  DEFAULT_CHAT_FRAME:AddMessage("|cffff8040" .. tag .. ":|r " .. msg, r, g, b)
end

--[[
  Display a message in the standard error frame

  @param {string} msg
]]--
function me.PrintUserError(msg)
  local displayTime = 5 -- standard error display time in secs

  UIErrorsFrame:AddMessage(msg, GM_CONSTANTS.INTERFACE_COLORS_RED.r,
    GM_CONSTANTS.INTERFACE_COLORS_RED.g, GM_CONSTANTS.INTERFACE_COLORS_RED.b,
    ChatTypeInfo["SYSTEM"], displayTime)
end
