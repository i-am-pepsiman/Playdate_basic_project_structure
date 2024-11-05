
function parseJsonToTable(path)
    jsonContent = json.decodeFile(path)
    -- print(json.encodePretty(jsonContent))
    return jsonContent
end

function findElementInTableByID(table, elementID)
    for _, element in ipairs(table) do
        if element.elementID == elementID then
            return element
        end
    end
    return nil
end