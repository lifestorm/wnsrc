--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local CHAR_STRING = {
	["\""] = true,
	["'"] = true
}

local CHAR_TABLE_OPEN = {
	["{"] = true,
	["["] = true
}

local CHAR_TABLE_CLOSE = {
	["}"] = true,
	["]"] = true
}

local CHAR_WHITESPACE = {
	[" "] = true,
	["\t"] = true,
	["\r"] = true,
	["\n"] = true
}

local CHAR_NEWLINE = {
	["\r"] = true,
	["\n"] = true
}

local CHAR_COMMENT = {
	["/"] = true,
	["-"] = true
}

local KEY_CASE = true
local ORDERED = false

local buffer = ""
local tbl = {}
local tbl_focus
local tbl_tmp
local value, lastvalue
local ignore_next_pop
local escape
local stringtype
local is_comment = false
local f

local strsub = string.sub
local strlow = string.lower

local fread = file.Read

local function strchar( strv, ind )
	return strsub( strv, ind, ind)
end

local function ResetValues()
	lastvalue = nil
	value = nil
end

local function FlushBuffer(write)
	if buffer ~= "" or stringtype then
		lastvalue = value
		if lastvalue and not KEY_CASE then
			lastvalue = strlow(lastvalue)
		end
		value = buffer
		buffer = ""

		if tbl_focus and (write == nil or write) and lastvalue and value then
			if ORDERED then
				tbl_focus[ #tbl_focus + 1 ] = { ["key"] = lastvalue, ["value"] = value }
			else
				tbl_focus[lastvalue] = value
			end
			ResetValues()
		end
	end
end

local function PushTable()
	FlushBuffer(true)
	if value and not KEY_CASE then
		value = strlow(value)
	end
	if value and value ~= "" then
		if ORDERED then
			tbl_focus[ #tbl_focus + 1 ] = { ["key"] = value, ["value"] = {} }
			tbl_focus[ #tbl_focus ].value.__par = tbl_focus
			tbl_focus = tbl_focus[ #tbl_focus ].value
		else
			tbl_focus[value] = istable(tbl_focus[value]) and tbl_focus[value] or {}
			tbl_focus[value].__par = tbl_focus
			tbl_focus = tbl_focus[value]
		end
		ignore_next_pop = false
	else
		ignore_next_pop = true
	end

	ResetValues()
end

local function PopTable()
	if not ignore_next_pop then
		FlushBuffer(true)

		if tbl_focus.__par then
			tbl_tmp = tbl_focus.__par
			tbl_focus.__par = nil
			tbl_focus = tbl_tmp
		end
	end

	ignore_next_pop = false
	ResetValues()
end

function TFA.ParseKeyValues(fn, path, use_escape, keep_key_case, invalid_escape_addslash, ordered )
	if use_escape == nil then
		use_escape = true
	end
	if keep_key_case == nil then
		keep_key_case = true
	end
	KEY_CASE = keep_key_case
	if invalid_escape_addslash == nil then
		invalid_escape_addslash = true
	end
	if ordered then
		ORDERED = true
	else
		ORDERED = false
	end
	tbl = {}
	tbl_focus = tbl
	tbl_tmp = nil
	value = nil
	lastvalue = nil
	escape = false
	is_comment = false
	stringtype = nil
	f = fread(fn, path)
	if not f then return tbl end
	for i = 1, #f do
		local char = strchar(f,i)

		if not char then
			FlushBuffer()
			break
		end

		if is_comment then
			if CHAR_NEWLINE[char] then
				is_comment = false
			end
		elseif escape then
			if char == "t" then
				buffer = buffer .. "\t"
			elseif char == "n" then
				buffer = buffer .. "\n"
			elseif char == "r" then
				buffer = buffer
			else
				if invalid_escape_addslash then
					buffer = buffer .. "\\"
				end
				buffer = buffer .. char
			end

			escape = false
		elseif char == "\\" and use_escape then
			escape = true
		elseif CHAR_STRING[char] then
			if not stringtype then
				FlushBuffer()
				stringtype = char
			elseif stringtype == char then
				FlushBuffer()
				stringtype = nil
			elseif stringtype then
				buffer = buffer .. char
			end
		elseif stringtype then
			buffer = buffer .. char
		elseif CHAR_COMMENT[char] then
			if CHAR_COMMENT[ strchar(f,i + 1,i + 1 ) ] then
				is_comment = true
			else
				buffer = buffer .. char
			end
		elseif CHAR_WHITESPACE[char] then
			if buffer ~= "" then
				FlushBuffer()
			end
		elseif CHAR_TABLE_OPEN[char] then
			PushTable()
		elseif CHAR_TABLE_CLOSE[char] then
			PopTable()
		else
			buffer = buffer .. char
		end
	end
	return tbl
end