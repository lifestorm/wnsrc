--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.compnettable = ix.compnettable or {}
-- size of chunks
ix.compnettable.chunkSize = 60000

do
    if (CLIENT) then
        ix.compnettable.doExpoBackOff = true
        -- expo backoff and jitter vars
        ix.compnettable.maxBackOffTime   = 20  -- tenth of a second
        ix.compnettable.baseBackOffTime  = 1   -- tenth of a second
        ix.compnettable.attemptsInWindow = 0
        ix.compnettable.windowSize       = 1         -- seconds
        ix.compnettable.lastRequest      = CurTime()
    else
        -- don't do backoffs on the server (that'd break a lot of shit)
        ix.compnettable.doExpobackOff = false
    end
end

-- writes a compressed and chunked table with the following mechanism:
--[[
    1) sends an int of the number of chunks to expect
    2) writes the chunks as compressed strings
    3) returns number of chunks to caller

    IMPORTANT
    THIS MUST BE USED IN THE CORRECT CONTEXT. EX:

    net.Send("YourNetHook", function()
        ix.compnettable:Write(myTable)
    end)
    net.Receive("YourNetHook", function()
        local yourTable = ix.compnettable:Read()
    end)

    OTHERWISE IT WILL BREAK YOUR SHIT
]]
function ix.compnettable:Write(tbl)
    if (!istable(tbl)) then
        return nil
    end

    local str = util.TableToJSON(tbl)
    local basestrlen = string.len(str)

    if (!str or basestrlen < 1) then
        error("Provided table could not be converted to JSON!")
    end

    local nchunks = math.ceil(basestrlen / self.chunkSize)
    net.WriteInt(nchunks, 17)

    for i=0, nchunks + 1, 1 do
        local stringslice = string.sub(
            str,
            i * self.chunkSize,
            (i + 1) *self.chunkSize
        )
        local chunk = util.Compress(stringslice)

        if (!chunk) then
            error(
                "Chunk "
                ..tostring(i)
                .." cannot be compressed! Attempted to compress: "
                ..stringslice
            )
        end

        net.WriteInt(#chunk, 17)
        net.WriteData(chunk, #chunk)
    end

    return nchunks
end


-- attempts to read a table compressed by ix.compnettable.Write()
--[[ IMPORTANT
    THIS MUST BE USED IN THE CORRECT CONTEXT. EX:

    net.Send("YourNetHook", function()
        ix.compnettable:Write(myTable)
    end)
    net.Receive("YourNetHook", function()
        local yourTable = ix.compnettable:Read()
    end)

    OTHERWISE IT WILL BREAK YOUR SHIT
]]
function ix.compnettable:Read()
    local nchunks = net.ReadInt(17)
    if (nchunks < 1) then
        error("No chunks to read!")
    end

    local fullstr = ""
    for i=0, nchunks + 1, 1 do
        local chunksize = net.ReadInt(17)
        local strcomp = net.ReadData(chunksize)
        if (#strcomp == 1 and strcomp[0] == 0) then
            error("Expected substring at idx ("..tostring(i)..") out of ("..tostring(nchunks)..") is empty or nil!")
        end

        local strchunk = util.Decompress(strcomp)
        if (!strchunk) then
            error("Substring ("..tostring(i)..") out of ("..tostring(nchunks)..") failed to decompress!")
        end
        fullstr = fullstr..strchunk
    end

    return util.JSONToTable(fullstr)
end

-- reads with a brief backoff to help with overflow issues
-- https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/
-- ^^ a cheap (and wildly simplified) version of this:
function ix.compnettable:ReadWithBackoff()
	if (CLIENT) then
	    local backOffTime = 0
	    local reqStart = SysTime()
	
	    if (self.doExpoBackOff) then
	        if ((reqStart - self.lastRequest) < self.windowSize) then
	            self.attemptsInWindow = self.attemptsInWindow + 1
	            local minBackOffTime = math.min(
	                math.pow(
	                    self.baseBackOffTime,
	                    self.attemptsInWindow
	                ),
	                self.maxBackOffTime
	            )
	            local maxBackOffTime = minBackOffTime + (self.baseBackOffTime * 10)
	            backOffTime = math.Rand(minBackOffTime, maxBackOffTime) / 10
	        else
	            self.attemptsInWindow = 0
	        end
	    end
	
	    if (backOffTime > 0) then
	        print("Backing off for "..tostring(backOffTime).." seconds...")
	        -- ^^ leave this in for now just in case ;)
	    end
	
	    local sec = tonumber(SysTime() + backOffTime);
	    while (SysTime() < sec) do
	        -- wait for backOffTime in seconds...
	        -- NOTE: This might cause some freezing and things 
	        -- BUT A FREEZE IS BETTER THAN AN OVERFLOW!!!!!!!!
	    end
	
	    self.lastRequest = reqStart
	end

    return self:Read()
end
