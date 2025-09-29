@tool
extends Pasta

# MIT License (c) 2025 geekazodium

## No tree hopping rule:
## nodes should not be accessing nodes that are far out in the tree, 2 degrees of
## node separation is already extremely hard to keep track of when editing anything
## at all in my opinion, If I have to check the script in order to know that
## the fishing rod or something is accessing the audio node, refactor it to
## an event, signal, or exported node reference, please.
##
## this rule checks if any $"<your node path here>" reference takes three steps out
## or more, and adds it to the list
## alternatively, if you backreference, that immediately is also counted

var compiled: RegEx;
var compiled_no_quote: RegEx;
var max_allowed_depth: int = 2;

func compile_rules() -> void:
	self.compiled = RegEx.create_from_string("\\$\"([^\"]+)\"");
	self.compiled_no_quote = RegEx.create_from_string("\\$([^\\.\\:\"\\%]+)[\\.\n\\\\]");
	
func search_all(text: String, file_name: String, array: Array[RegExMatch]) -> void:
	for m: RegExMatch in self.compiled.search_all(text):
		if check_hopping(m): array.append(m);
	for m: RegExMatch in self.compiled_no_quote.search_all(text):
		if check_hopping(m): array.append(m);

func check_hopping(m: RegExMatch) -> bool:
	var c = 0;
	for g in m.get_string(1).split("/"):
		c += (self.max_allowed_depth + 1) if g.strip_escapes() == ".." else 1;
		if c > self.max_allowed_depth:
			return true;
	return false;
