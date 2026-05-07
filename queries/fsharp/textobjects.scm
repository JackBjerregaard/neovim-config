;; extends

(function_or_value_defn
  body: (_) @function.inner) @function.outer

(member_defn
  (method_or_prop_defn
    body: (_) @function.inner)) @function.outer
