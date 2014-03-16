Prototype = {}


---------------------------------------------------------------------------------------------------


function Prototype:clone(...)
    local object = {}
    setmetatable(object, self)
    self.__index = self
    if object.make then object:make(...) end
    return object
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
