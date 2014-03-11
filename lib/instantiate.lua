---------------------------------------------------------------------------------------------------


function instantiate(self, ...)
    local object = {}
    setmetatable(object, self)
    self.__index = self
    object:reset(...)
    return object
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>