Willard Networks - WN:IX
A unique HL2RP schema built by the WN team

Copyright Atko 2023
All Rights Reserved

# Code Style
* General coding style
  * Use tab-indentation with tab-width set to 4 spaces!
  * Use 'and' and 'or', rather than '&&' or '||'. For negation the '!' is used over 'not'
  * We use 'if (condition) then' for spacing, as well as 'func(arg1, arg2, arg3, ...)'. Arrays use array[index], except for double indexing in which case spaces get added array1[ array2[index] ] (to prevent [[ and ]] from forming long strings or comments)
  * String concatenation is done without spacing like.."this".."."
  * " " has the preference for strings, although ' ' can be used if your string contains a ". [[ ]] can be used for multiline strings, or strings that contain both " and '
  * Unused loop variables or return variables are assigned to '\_' to indicate they are unused
* Variable and data fields
  * Local vars use lower camel case (lowerCamelCase)
  * Functions are upper camel case (UpperCamelCase). Local function vars use lower camel case (as per local var casing)
  * Enums are in all caps, with underscores for spacing. This also counts if you make enum fields on a table (e.g. PLUGIN.MAX_VAR)
  * Strings for internal use should be UpperCamelCase (data fields, net messages, ...). If some sort of identifiying prefix is used, lower camel casing is used (e.g. ixSendData, cmdCharSetHealth, ...)
  * Try to give loop variables sensible names over k, v. E.g. 'for character, data in pairs(list) do', which creates much more readable code than 'for k, v in pairs(list) do'
  * Avoid using variable names that overwrite library names.
    * 'player' is generally replaced with 'client'
    * 'table' should use something more descriptive, or 'tbl' if you really got nothing
    * 'string' can use 'text' or 'str'
* Optimization
  * Avoid creating and using global variables, the access time on them is extremely slow. The easiest workaround is to localize the variable at the top of the file (if it is a table, the variable will still update as tables are stored by reference rather than by value). Libraries (e.g. ix, math, string, ...) can also be localized like this, and is typically done if you absolutely need to squeeze out performance from some bit of code that will run a lot.
  * Avoid using Think, Tick, etc. server-side. Basically any hook that gets called every frame (or even worse: every frame for every player) unless there is absolutely no way around it. A lot of stuff doesn't need to check every frame, but is fine if it checks every 0.5/1/2/... seconds. Use timers for this!
  * If you must use Think-like hooks or have another performance critical bit of code:
    * Keep it short, shorter code usually is more optimized
    * Localize everything in it
    * Avoid loops, make loops as small as possible. If you need to loop over a table to search one entry, you may need to rethink your table structure. E.g. looping over a table of all players is slower than looking up a player by SteamID (table[client:SteamID64()]).
    * 'for i = 1, x do' is faster than 'for k, v in ipairs', which is faster than 'for k, v in pairs'
    * Making tables is expensive compared to clearing out a small table. Array indexing (table[1]) is faster than hashmap lookups (table.x)
    * Square roots (sqrt, Distance) and geometry functions (cos, acos, sin, asin, tan, ...) are SLOOOOW (compared to e.g. multiplication)! Avoid them in performance-critical code. Distance can often be replaced by DistToSqr (squared distance) when the goal is simple comparisons to avoid taking a square root (don't forget to square the other side of the comparison). E.g. 'x:Distance(y) > 100' becomes 'x:DistToSqr(y) > 100 * 100'
    * Creating functions during runtime is SLOOOOOOOOOOOOOOW, but sometimes needed. Just avoid this happening in code that runs often/regularly. Try to limit it to e.g. character load, or when a player does a certain action. If possible, use a function created during compile and pass the needed arguments via varargs.
* Helix-specific stuff
  * Use ix.log.AddType and ix.log.Add rather than ix.log.AddRaw. This creates a category that can be used with our log searching tool, and stores some extra searchable meta-data as well (client, arguments passed, location, ...)
  * Categorize your logtypes by proceeding the type with the plugin name or some other descriptive prefix. This facilitates selecting it from the giant dropdown menu in the logsearch tool. E.g. medicalBleedout, itemPickup, ...
  * Try to use localized text (via e.g. L(), NotifyLocalized, ...) and define a translation table in your plugin via ix.lang.AddTable. This makes life for our Russian friends a lot easier.
  * Server-side only code always should be in an sv_file! This counts double for net hooks, security checks, etc. Any half-decent hacker will read your cl_ and sh_ files to find exploits, do not make their life easier. It is also harder to steal our code if they do not have the server-side code.
  
## Using the Linter in your IDE
See instructions [here](https://github.com/mpeterv/luacheck#editor-support).

For visual studio, simply downloading the vscode-luacheck plugin should be enough with no additional configuration required.
