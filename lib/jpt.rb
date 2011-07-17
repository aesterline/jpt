LIB_DIR = File.dirname(__FILE__)

$LOAD_PATH.unshift(File.join(LIB_DIR, '..', 'vendor'))
$LOAD_PATH.unshift(LIB_DIR)

require 'java'
require 'bcel-5.2'
require 'dependencies/string_class_name_extractor'
require 'dependencies/dependency_extractor'