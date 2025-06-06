# Retrieve the theme settings
export def main [] {
    return {
        separator: "#a9b1d6"
        leading_trailing_space_bg: { attr: "n" }
        header: { fg: "#9ece6a" attr: "b" }
        empty: "#7aa2f7"
        bool: {|| if $in { "#7dcfff" } else { "light_gray" } }
        int: "#a9b1d6"
        filesize:"#e0af68"
        duration: "#a9b1d6"
        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: "#f7768e" attr: "b" }
            } else if $in < 6hr {
                "#f7768e"
            } else if $in < 1day {
                "#e0af68"
            } else if $in < 3day {
                "#9ece6a"
            } else if $in < 1wk {
                { fg: "#9ece6a" attr: "b" }
            } else if $in < 6wk {
                "#7dcfff"
            } else if $in < 52wk {
                "#7aa2f7"
            } else { "dark_gray" }
        }
        range: "#cdd6f4"
        float: "#cdd6f4"
        string: "#cdd6f4"
        nothing: "#cdd6f4"
        binary: "#cdd6f4"
        cell-path: "#cdd6f4"
        row_index: { fg: "#9ece6a" attr: "b" }
        record: "#cdd6f4"
        list: "#cdd6f4"
        block: "#cdd6f4"
        hints: "dark_gray"
        search_result: { fg: "#f7768e" bg: "#a9b1d6" }

        shape_and: { fg: "#bb9af7" attr: "b" }
        shape_binary: { fg: "#bb9af7" attr: "b" }
        shape_block: { fg: "#7aa2f7" attr: "b" }
        shape_bool: "#7dcfff"
        shape_custom: "#9ece6a"
        shape_datetime: { fg: "#7dcfff" attr: "b" }
        shape_directory: "#9ece6a"
        shape_external: "#cdd6f4"
        shape_externalarg: { fg: "#9ece6a" attr: "b" }
        shape_filepath: "#7dcfff"
        shape_flag: { fg: "#7aa2f7" attr: "b" }
        shape_float: { fg: "#bb9af7" attr: "b" }
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: "b" }
        shape_globpattern: { fg: "#7dcfff" attr: "b" }
        shape_int: { fg: "#bb9af7" attr: "b" }
        shape_internalcall: { fg: "#7dcfff" attr: "b" }
        shape_list: { fg: "#7dcfff" attr: "b" }
        shape_literal: "#7aa2f7"
        shape_match_pattern: "#9ece6a"
        shape_matching_brackets: { attr: "u" }
        shape_nothing: "#7dcfff"
        shape_operator: "#e0af68"
        shape_or: { fg: "#bb9af7" attr: "b" }
        shape_pipe: { fg: "#bb9af7" attr: "b" }
        shape_range: { fg: "#e0af68" attr: "b" }
        shape_record: { fg: "#7dcfff" attr: "b" }
        shape_redirection: { fg: "#bb9af7" attr: "b" }
        shape_signature: { fg: "#9ece6a" attr: "b" }
        shape_string: "#9ece6a"
        shape_string_interpolation: { fg: "#7dcfff" attr: "b" }
        shape_table: { fg: "#7aa2f7" attr: "b" }
        shape_variable: "#bb9af7"

        background: "#1a1b26"
        foreground: "#c0caf5"
        cursor: "#c0caf5"
    }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '#cdd6f4'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
        
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate
