local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function get_filename()
  return vim.fn.expand("%:t:r")
end

return {
  s("class", {
    t("public class "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  s("Class", {
    t("public class "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  s("interface", {
    t("public interface "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  s("enum", {
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
