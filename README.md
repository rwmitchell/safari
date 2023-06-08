# safari: zsh addon

## About
Uses Applescript to open a new Safari window on the current Desktop

'open_command' is simplified version of same from 'web-search' plugin,
but it replaces the use of Apple's 'open' with 'safari'.  Code for
other OSes removed has Safari only runs on MacOS.

## Usage
```safari URL```

A local file is opened just by specifying the filename.

If the URL does not contain ":/", "https://" will be prepended.

A full URL is required for anything else.

Used in combination with 'web-search' plugin, 'google' will
use 'safari' instead of 'open' to display the search.

## Installation
Copy or ln 'safari' to your location for zsh plugins
