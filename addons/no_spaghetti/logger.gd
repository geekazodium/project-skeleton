class_name SpaghettiLogger

const LOG_PREFIX: String = "[NS] ";
const LOG_PREFIX_FULL: String = "[NoSpaghetti] ";

static var use_full_prefix: bool = false; ## make changeable

static func rich(msg: String, varargs: Array = []) -> void:
	print_rich(_get_prefix() + msg.format(varargs));
	
static func debug(msg: String, varargs: Array = []) -> void:
	print_debug(_get_prefix() + msg.format(varargs));

static func warning(msg: String, varargs: Array = []) -> void:
	push_warning(_get_prefix() + msg.format(varargs));
	print_stack();
	
static func error(msg: String, varargs: Array = []) -> void:
	push_error(_get_prefix() + msg.format(varargs));
	print_stack();

static func _get_prefix() -> String:
	return LOG_PREFIX if !use_full_prefix else LOG_PREFIX_FULL;
