FW = {}

function sharedFunctions()
    return FW
end

function FW.generatePlate()
    local letter = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
    local number = {"1","2","3","4","5","6","7","8","9"}
    local text1 = letter[math.random(#letter)]
    local text2 = letter[math.random(#letter)]
    local text3 = letter[math.random(#letter)]
    local number1 = number[math.random(#number)]
    local number2 = number[math.random(#number)]
    local number3 = number[math.random(#number)]
    return text1 .. text2 .. text3 .. ' ' .. number1 .. number2 .. number3
end

exports("sharedFunctions", sharedFunctions)
