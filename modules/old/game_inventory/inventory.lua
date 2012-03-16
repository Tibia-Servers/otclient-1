Inventory = {}

-- private variables
local inventoryWindow
local inventoryButton

-- public functions
function Inventory.create()
  inventoryWindow = displayUI('inventory.otui', g_game.gameRightPanel)
  inventoryButton = TopMenu.addGameButton('inventoryButton', 'Inventory (Ctrl+I)', 'inventory.png', Inventory.toggle)
  inventoryButton:setOn(true)
  Keyboard.bindKeyDown('Ctrl+I', Inventory.toggle)
end

function Inventory.destroy()
  Keyboard.unbindKeyDown('Ctrl+I')
  inventoryWindow:destroy()
  inventoryWindow = nil
  inventoryButton:destroy()
  inventoryButton = nil
end

function Inventory.toggle()
  local visible = not inventoryWindow:isExplicitlyVisible()
  inventoryWindow:setVisible(visible)
  inventoryButton:setOn(visible)
end

-- hooked events
function Inventory.onInventoryChange(slot, item)
  local itemWidget = inventoryWindow:getChildById('slot' .. slot)
  itemWidget:setItem(item)
end

function Inventory.onFreeCapacityChange(freeCapacity)
  local widget = inventoryWindow:getChildById('capacity')
  widget:setText("Cap:\n" .. freeCapacity)
end

function Inventory.onSoulChange(soul)
  local widget = inventoryWindow:getChildById('soul')
  widget:setText("Soul:\n" .. soul)
end

connect(g_game, { onGameStart = Inventory.create,
                onGameEnd = Inventory.destroy,
                onInventoryChange = Inventory.onInventoryChange,
                onFreeCapacityChange = Inventory.onFreeCapacityChange,
                onSoulChange = Inventory.onSoulChange })
