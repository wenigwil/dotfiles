;;extends

[
(argument_list
        [
                ","
                ";"
        ]? @parameter.outer
        .
        (_) @parameter.inner @parameter.outer
)
(argument_list
        (_) @parameter.inner @parameter.outer
        .
        [
                ","
                ";"
        ]? @parameter.outer
)
]


