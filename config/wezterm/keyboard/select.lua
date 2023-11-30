return {
	quick_select_patterns = {
		-- 1. IP Address
		"%b()\b(?:%d{1,3}%.){3}%d{1,3}\b",

		-- 2. URL
		"https?://(?:[a-zA-Z]|%d|[%-$-_@.&+!*\\(\\),]|(?:%%[0-9a-fA-F][0-9a-fA-F]))+",

		-- 4. File Path (Unix-like)
		"/(?:[^/\\0]+/)*[^/\\0]+",

		-- 5. Numeric Values (Integers or Floats)
		"%b()\b%d+(%.%d+)?%b()\b",

		-- 6. Date (YYYY-MM-DD)
		"%b()\b%d%d%d%d-%d%d-%d%d%b()\b",

		-- 7. Hexadecimal Color Code
		"#%x+",

		-- 8. MAC Address
		"([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})",
	},
}
