if (GetLocale() == "deDE") then
  gm.L["name"] = "GearMenu"

  -- console
  gm.L["help"] = "|cFFFFFF00(%s)|r: Benutze |cFFFFFF00/gm|r oder |cFFFFFF00/gearmenu|r für eine Liste der verfügbaren Optionen"
  gm.L["show"] = "|cFFFFFF00show|r - anzeigen "
  gm.L["hide"] = "|cFFFFFF00hide|r - ausblenden "
  gm.L["opt"] = "|cFFFFFF00opt|r - zeige Optionsmenu an"
  gm.L["reload"] = "|cFFFFFF00reload|r - UI neu laden"

  -- user errors
  gm.L["unequip_failed"] = "Kein freier Taschenplatz gefunden"
  gm.L["quick_change_item_select_missing"] = "Es muss ein Item von der Von und der Zu Liste ausgewählt werden"

  -- gui
  gm.L["navigationslots"] = "Slots"
  gm.L["navigationgeneral"] = "Allgemein"
  gm.L["navigationquickchange"] = "Schnellwechsel"
  gm.L["navigationabout"] = "Über"

  -- slots tab
  gm.L["titleslot1"] = "Slot 1:"
  gm.L["titleslot2"] = "Slot 2:"
  gm.L["titleslot3"] = "Slot 3:"
  gm.L["titleslot4"] = "Slot 4:"
  gm.L["titleslot5"] = "Slot 5:"
  gm.L["titleslot6"] = "Slot 6:"
  gm.L["titleslot7"] = "Slot 7:"
  gm.L["slot_menu_slot_already_in_use"] = "Slot wird bereits benutzt"

  -- general tab
  gm.L["lockwindow"] = "Sperre Fenster"
  gm.L["lockwindowtooltip"] = "Verhindert das bewegen des GearMenu Fensters."
  gm.L["showcooldowns"] = "Zeige Abklingzeiten an"
  gm.L["showcooldownstooltip"] = "Zeige Abklingzeiten für alle Slots an."
  gm.L["showkeybindings"] = "Zeige Tastaturkürzel an"
  gm.L["showkeybindingstooltip"] = "Zeige Tastaturkürzel auf den ausgerüsteten Items an."
  gm.L["showtooltips"] = "Deaktiviere Kurzinfo"
  gm.L["showtooltipstooltip"] = "Deaktiviere Kurzinfo für markierte Items."
  gm.L["smalltooltips"] = "Zeige kleine Kurzinfo"
  gm.L["smalltooltipstooltip"] = "Zeige nur den Titel des markierten Items anstatt die ganze Kurzinfo."
  gm.L["disabledraganddrop"] = "Deaktiviere Drag and Drop"
  gm.L["disabledraganddroptooltip"] = "Deaktiviere Drag and Drop für Items."
  gm.L["filteritemquality"] = "Filtere Gegenstandsqualität:"
  gm.L["item_quality_poor"] = "Arm (Grau)"
  gm.L["item_quality_common"] = "Gewöhnlich (Weiss)"
  gm.L["item_quality_uncommon"] = "Ungewöhnlich (Grün)"
  gm.L["item_quality_rare"] = "Selten (Blau)"
  gm.L["item_quality_epic"] = "Episch (Violet)"
  gm.L["item_quality_legendary"] = "Legendär (Orange)"

  -- quick change tab
  gm.L["rulelistlabel"] = "Regeln:"
  gm.L["changefromlabel"] = "Von:"
  gm.L["changetolabel"] = "Zu:"
  gm.L["delaylabel"] = "Verzögerung: "
  gm.L["delayunitlabel"] = "Sek"
  gm.L["addrule"] = "Erstelle Regel"
  gm.L["deleterule"] = "Lösche Regel"

  -- about tab
  gm.L["author"] = "Autor: Michael Wiesendanger"
  gm.L["email"] = "E-Mail: michael.wiesendanger@gmail.com"
  gm.L["version"] = "Version: " .. GM_CONSTANTS.ADDON_VERSION
  gm.L["issues"] = "Probleme: https://github.com/RagedUnicorn/wow-gearmenu/issues"
end
