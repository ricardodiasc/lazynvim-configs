local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function get_filename()
  return vim.fn.expand("%:t:r")
end

local function get_package_name()
  local path = vim.fn.expand("%:p:h")
  local package = path:match("src/main/java/(.+)")
      or path:match("src/test/java/(.+)")
      or path:match("java/(.+)")
      or path:match("src/(.+)")
  
  if package then
    return "package " .. package:gsub("/", ".") .. ";"
  end
  return ""
end

local function get_package_and_header()
  local pkg = get_package_name()
  if pkg ~= "" then
    return { pkg, "", "" }
  end
  return ""
end

return {
  s("class", {
    f(get_package_and_header, {}),
    t("public class "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  s("Class", {
    f(get_package_and_header, {}),
    t("public class "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  s("interface", {
    f(get_package_and_header, {}),
    t("public interface "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  s("enum", {
    f(get_package_and_header, {}),
    t("public enum "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  -- Test snippet
  s("test", {
    t("This is a test snippet for "),
    f(get_filename, {}),
  }),
}
