
# Copyright (c) 2018-2021 TFA Base Devs

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os, zlib

targetPath = "lua/autorun/!tfa_base_crc_check.lua"

hashCheckCode = '''if CLIENT then return end

local hashes = {{
{hashes}
}}

local function check_and_compare_files()
	for file_name, crc_stored in pairs(hashes) do
		if string.sub(file_name, 1, 4) == "lua/" then
			file_name = string.sub(file_name, 5)
		end

		local file_contents = file.Read(file_name, "LUA")

		if not file_contents or file_contents == "" then
			print("[TFA Base] (CRC) An error occured while reading file '" .. file_name .. "'")

			goto CONTINUE
		end

		local crc_local = util.CRC(file_contents)

		if not crc_local then
			print("[TFA Base] (CRC) Unable to calculate checksum for file '" .. file_name .. "'")
		elseif crc_local ~= crc_stored then
			print("[TFA Base] (CRC) Checksum diff for '" .. file_name .. "': expected " .. tostring(crc_stored) .. ", got " .. tostring(crc_local))
		end

		::CONTINUE::
	end
end

hook.Add("InitPostEntity", "TFABase_CRCIntegrityCheck", check_and_compare_files)'''

if __name__ == '__main__':
	if os.path.exists(targetPath):
		os.remove(targetPath)

	hashes = {}

	for root, dirs, files in os.walk("lua"):
		for file in files:
			if file.endswith("___basecrc.lua"):
				continue

			if file.endswith(".lua"):
				fileName = os.path.join(root, file)
				with open(fileName, "rb") as f:
					hashes[fileName.replace("\\", "/")] = zlib.crc32(f.read())

	hashesStr = ''
	for filename in hashes:
		hashesStr = hashesStr + '\t["' + filename + '"] = "' + str(hashes[filename]) + '",\n'

	hashesFile = open(targetPath, 'w')
	hashesFile.write(hashCheckCode.format(hashes=hashesStr))
	hashesFile.close()
