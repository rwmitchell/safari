# http://apple.stackexchange.com/questions/141702/open-an-new-safari-window-on-the-current-space-from-the-termial-shell-with-multi
#

function _load_safari_script () {

  local OFS=$IFS
  IFS='' _safari_script=$(cat <<EOF
  on run argv
      tell application "Safari"
          if (count argv) = 0 then
              -- If you dont want to open a new window for an empty list, replace the
              -- following line with just "return"
              set {first_url, rest_urls} to {"https://google.com", {}}
          else
              -- 'item 1 of ...' gets the first item of a list, 'rest of ...' gets
              -- everything after the first item of a list.  We treat the two
              -- differently because the first item must be placed in a new window, but
              -- everything else must be placed in a new tab.
              set {first_url, rest_urls} to {item 1 of argv, the rest of argv}
          end if

          make new document at end of documents with properties {URL:first_url}
          tell window 1
              repeat with the_url in rest_urls
                  make new tab at end of tabs with properties {URL:the_url}
              end repeat
          end tell
          activate
      end tell
  end run
EOF
  )
  IFS=$OFS
}

# This works, but args must be a full URL
function safari () {
  [[ -n $_safari_script ]] || _load_safari_script

  for url in $@; do

    # if url is a local file, redo url
    if [[ -e $url ]]; then
      url="file:///"$(command ls -1 -d $PWD/$url)
    fi
    printf "Opening: %s\n" "$url"
    osascript -e $_safari_script $url
  done
  #
# osascript -e $_safari_script $@

}

# Replace open_command from omz plugin

function open_command () {
  local open_cmd='safari'

  if [[ -n "$BROWSER" && "$1" = (http:https)://* ]]; then
    "$BROWSER" "$@"
    return
  fi
  ${=open_cmd} "$@" &> /dev/null
}
