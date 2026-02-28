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
    t("export class "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  s("interface", {
    t("export interface "),
    f(get_filename, {}),
    t(" {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
  -- Component snippet for Angular
  s("comp", {
    t({
      "@Component({",
      "  selector: 'app-",
    }),
    f(get_filename, {}),
    t({
      "',",
      "  templateUrl: './",
    }),
    f(get_filename, {}),
    t(".component.html',"),
    t({"", "  styleUrls: ['./"}),
    f(get_filename, {}),
    t(".component.css']"),
    t({"", "})"}),
    t({"", "export class "}),
    f(get_filename, {}),
    t("Component {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
}
